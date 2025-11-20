
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Winters Howl Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_BOTH
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO4WintersFreeze = function(self, duration, attacker, inflictor)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end

		if IsValid(self.bo4_wintershowl_logic) then
			self.bo4_wintershowl_logic:UpdateDuration(duration)
			return self.bo4_wintershowl_logic
		end

		self.bo4_wintershowl_logic = ents.Create("bo4_status_effect_winters")
		self.bo4_wintershowl_logic:SetPos(self:WorldSpaceCenter())
		self.bo4_wintershowl_logic:SetParent(self)
		self.bo4_wintershowl_logic:SetOwner(self)
		self.bo4_wintershowl_logic:SetModel("models/weapons/tfa_bo4/winters/ice_chunk.mdl")

		self.bo4_wintershowl_logic:Spawn()
		self.bo4_wintershowl_logic:Activate()

		self.bo4_wintershowl_logic:SetAttacker(attacker)
		self.bo4_wintershowl_logic:SetInflictor(inflictor)

		self.bo4_wintershowl_logic:SetOwner(self)
		self.bo4_wintershowl_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.WintersLogic", self.bo4_wintershowl_logic)
		return self.bo4_wintershowl_logic
	end

	hook.Add("PlayerDeath", "BO4.WintersLogic", function(self)
		if IsValid(self.bo4_wintershowl_logic) then
			return self.bo4_wintershowl_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO4.WintersLogic", function(self)
		if IsValid(self.bo4_wintershowl_logic) then
			return self.bo4_wintershowl_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO4.WintersLogic", function(self)
			if IsValid(self.bo4_wintershowl_logic) then
				self.bo4_wintershowl_logic:Remove()
			end
		end)
	end
end

entMeta.BO4IsFrozen = function(self)
	return IsValid(self:GetNW2Entity("BO4.WintersLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Draw = function(self)
	self:DrawModel()
end

ENT.IsTranslucent = function(self)
	return true
end

ENT.Initialize = function(self)
	self:SetBodygroup(0, math.random(0,1))

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:UseTriggerBounds(true, 10)

	local p = self:GetParent()

	if IsValid(p) then
		self:SetModelScale(p:BoundingRadius()/60,0)
		
		self.DesiredScale = p:BoundingRadius()/25
		self.DesiredRate = p:BoundingRadius()/math.random(8000, 9500)

		p:StopParticles()
		p:SetMaterial("models/weapons/tfa_bo4/winters/rus_ter_ice_slush")
		self:EmitSound("weapons/tfa_bo4/winters/zm_office.all.sabl.47"..math.random(2,4)..".wav", math.random(70,80), math.random(95,105), 1, CHAN_ITEM)

		ParticleEffectAttach("bo4_freezegun_zomb_smoke", PATTACH_POINT_FOLLOW, p, 0)
	end

	if CLIENT then return end
	if not IsValid(p) then SafeRemoveEntity(self) return end

	self:TrapPlayer(p)
	self:TrapNextBot(p)
	self:TrapNPC(p)

	self:SetTrigger(true)
	self.freezeStart = CurTime()
	self.duration = 0.1
	self.freezeEnd = self.freezeStart + 0.1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end
	if self.freezeEnd - CurTime() > newtime then return end
	self.duration = newtime
	self.freezeEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and p:IsNPC() then
		if p:GetCurrentSchedule() ~= SCHED_NPC_FREEZE then
			p:SetSchedule(SCHED_NPC_FREEZE)
			p:SetMoveVelocity(Vector(0,0,0))
		end
	end

	if self.freezeEnd < CurTime() then
		if IsValid(p) then
			self:InflictDamage(p)
		end
		self:Remove()
		return false
	end

	if self:GetModelScale() < self.DesiredScale then
		self:SetModelScale(math.Approach(self:GetModelScale(), self.DesiredScale, self.DesiredRate))
	end

	self:NextThink(CurTime())
	return true
end

ENT.TrapPlayer = function(self, ply)
	if ply:IsPlayer() then
		ply:Freeze(true)
	end
end

ENT.TrapNextBot = function(self, bot)
	if bot:IsNextBot() then
		bot:SetCollisionGroup(COLLISION_GROUP_WORLD)
		bot.loco:SetVelocity(vector_origin)
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)

		/*if bot.Freeze then
			bot:Freeze(5)
		end*/

		if nzombies and bot:IsValidZombie() then
			bot:SetBlockAttack(true)
		end
	end
end

ENT.TrapNPC = function(self, npc)
	if npc:IsNPC() then
		npc:SetCollisionGroup(COLLISION_GROUP_WORLD)
		npc:StopMoving()
		npc:SetMoveVelocity(vector_origin)

		if npc.Freeze then
			npc:Freeze(5)
		end

		npc:SetSchedule(SCHED_NPC_FREEZE)
	end
end

ENT.InflictDamage = function(self, ent, hitpos, norm)
	local damage = DamageInfo()
	damage:SetDamageType(nZSTORM and DMG_VEHICLE or DMG_REMOVENORAGDOLL)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamagePosition(hitpos or ent:WorldSpaceCenter())
	damage:SetDamageForce(norm or vector_origin)
	damage:SetDamage(ent:Health() + 666)

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)

	local ply = self:GetAttacker()
	if (ent:IsNPC() or ent:IsNextBot()) and IsValid(ply) and ply:IsPlayer() then
		if not ply.level_winters_shatters then ply.level_winters_shatters = 0 end

		ply.level_winters_shatters = ply.level_winters_shatters + 1
		if ply.level_winters_shatters == 115 then
			if not ply.bo4wintersachievement then
				TFA.BO3GiveAchievement("Breaking the Ice", "vgui/overlay/achievment/Breaking_the_Ice.png", ply, 3)
				ply.bo4wintersachievement = true
			end
		end
	end
end

function ENT:Explode()
	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamage(500)
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 120)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == self:GetParent() then continue end
			if v:IsPlayer() then continue end

			damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos()-self:GetPos()):GetNormalized()*15000)
			damage:SetDamagePosition(v:WorldSpaceCenter())

			if v:BO4IsFrozen() then damage:SetDamageType(nZSTORM and DMG_VEHICLE or DMG_REMOVENORAGDOLL) end
			if v:IsNPC() then v:SetSchedule(SCHED_ALERT_STAND) end

			v:TakeDamageInfo(damage)
		end
	end
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()

		if SERVER then
			if nzombies and p:IsValidZombie() then
				if !p.IgnoreBlockAttackReset then
					p:SetBlockAttack(false)
				end
				p.loco:SetAcceleration(p.Acceleration)
				p.loco:SetDesiredSpeed(p:GetRunSpeed())
			end

			if p:IsPlayer() then
				p:SetMaterial("")
				p:Freeze(false)
			end
		end
	end

	ParticleEffect("bo4_freezegun_explode", self:GetPos(), angle_zero)
	self:EmitSound("TFA_BO4_WINTERS.Shatter")
end

ENT.StartTouch = function(self, ent)
	local p = self:GetParent()
	if IsValid(p) and ent:IsPlayer() then
		local data = self:GetTouchTrace()
		self:SetAttacker(ent)
		self:InflictDamage(p, data.HitPos, -data.Normal)
		self:Remove()
	end
end

ENT.OnTakeDamage = function(self, dmginfo)
	local p = self:GetParent()
	if IsValid(p) then
		self:SetAttacker(dmginfo:GetAttacker())
		self:InflictDamage(p)
		self:Remove()
	end
end
