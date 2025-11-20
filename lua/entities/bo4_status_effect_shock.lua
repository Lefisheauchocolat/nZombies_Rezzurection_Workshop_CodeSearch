
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
ENT.PrintName = "Shock Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO4Shock = function(self, duration, attacker, inflictor)
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

		if IsValid(self.bo4_shocking_logic) then
			self.bo4_shocking_logic:UpdateDuration(duration)
			return self.bo4_shocking_logic
		end

		self.bo4_shocking_logic = ents.Create("bo4_status_effect_shock")
		self.bo4_shocking_logic:SetPos(self:WorldSpaceCenter())
		self.bo4_shocking_logic:SetParent(self)
		self.bo4_shocking_logic:SetOwner(self)

		self.bo4_shocking_logic:SetAttacker(attacker)
		self.bo4_shocking_logic:SetInflictor(inflictor)

		self.bo4_shocking_logic:Spawn()
		self.bo4_shocking_logic:Activate()

		self.bo4_shocking_logic:SetOwner(self)
		self.bo4_shocking_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.ShockLogic", self.bo4_shocking_logic)
		return self.bo4_shocking_logic
	end

	hook.Add("PlayerDeath", "BO4.ShockLogic", function(self)
		if IsValid(self.bo4_shocking_logic) then
			return self.bo4_shocking_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO4.ShockLogic", function(self)
		if IsValid(self.bo4_shocking_logic) then
			return self.bo4_shocking_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO4.ShockLogic", function(self)
			if IsValid(self.bo4_shocking_logic) then
				self.bo4_shocking_logic:Remove()
			end
		end)
	end
end

entMeta.BO4IsShocked = function(self)
	return IsValid(self:GetNW2Entity("BO4.ShockLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")

	self:NetworkVar("Float", 0, "StatusStart")
	self:NetworkVar("Float", 1, "StatusEnd")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		self:SetStatusStart(CurTime())
		p:EmitSound("TFA_BO4_DG5.ShockLoop")
		ParticleEffectAttach("bo4_dg5_shock", PATTACH_POINT_FOLLOW, p, 2)
	end

	self.Traptime = 2
	if nzombies and nzPowerUps:IsPowerupActive("insta") then
		self.Traptime = 0.5
	end

	if CLIENT then return end
	if not IsValid(p) then return self:Remove() end

	self:TrapNextBot(p)
	self:TrapNPC(p)

	self.statusStart = CurTime()
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

	local p = self:GetParent()
	if IsValid(p) and !p:IsPlayer() and not (p.NZBossType or p.IsMooBossZombie) and p.Freeze then
		p:Freeze(newtime)
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime

	self:SetStatusEnd(self.statusEnd)
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		if IsValid(p) and (self.statusEnd - self.statusStart) > self.Traptime then
			self:InflictDamage(p)
			self:StopSound("TFA_BO4_DG5.ShockLoop")
			self:Remove()
			return false
		end
	end

	if self.statusEnd < CurTime() then
		if IsValid(p) and self.statusEnd > (self.statusStart + 1.5) then
			self:InflictDamage(p)
		end
		self:StopSound("TFA_BO4_DG5.ShockLoop")
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	self:StopSound("TFA_BO4_DG5.ShockLoop")

	ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
	ent:EmitSound("TFA_BO3_WAFFE.Pop")
	ent:EmitSound("TFA_BO3_GENERIC.Gore")

	local damage = DamageInfo()
	damage:SetDamageType(DMG_ENERGYBEAM)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:EyePos())

	ParticleEffect("blood_impact_red_01", ent:EyePos(), ent:GetForward():Angle())

	local head = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !head then head = ent:LookupBone("j_head") end
	if head then
		damage:SetDamagePosition(ent:GetBonePosition(head))
	end

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(1000, ent:GetMaxHealth() / 10))
		//damage:ScaleDamage(math.min(math.Round(nzRound:GetNumber()/12), 1))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

ENT.TrapNextBot = function(self, bot)
	if bot:IsNextBot() then
		if not bot.OldCollision then
			bot.OldCollision = bot:GetCollisionGroup()
		end

		if (bot.NZBossType or bot.IsMooBossZombie) then return end

		bot:SetCollisionGroup(COLLISION_GROUP_WORLD)
		bot.loco:SetVelocity(vector_origin)
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)

		if nzombies and bot:IsValidZombie() then
			bot:SetBlockAttack(true)
		end
	end
end

ENT.TrapNPC = function(self, npc)
	if npc:IsNPC() then
		if not npc.OldCollision then
			npc.OldCollision = npc:GetCollisionGroup()
		end

		npc:Ignite(0)
		npc:SetCollisionGroup(COLLISION_GROUP_WORLD)
		npc:StopMoving()
		npc:SetSchedule(SCHED_NPC_FREEZE)
	end
end

ENT.OnRemove = function(self)
	self:StopSound("TFA_BO4_DG5.ShockLoop")

	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("TFA_BO4_DG5.ShockEnd")
		p:StopParticles()

		if p:IsNextBot() then
			if nzombies then
				if p:IsValidZombie() and !p.IgnoreBlockAttackReset then
					p:SetBlockAttack(false)
				end
				p.loco:SetAcceleration(p.Acceleration)
				p.loco:SetDesiredSpeed(p:GetRunSpeed())
			else
				p.loco:SetAcceleration(200)
				p.loco:SetDesiredSpeed(200)
			end
			if p.OldCollision then
				p:SetCollisionGroup(p.OldCollision)
			end
		end

		if p:IsNPC() then
			if p.OldCollision then
				p:SetCollisionGroup(p.OldCollision)
			end
			p:SetSchedule(SCHED_ALERT_STAND)
		end
	end
end
