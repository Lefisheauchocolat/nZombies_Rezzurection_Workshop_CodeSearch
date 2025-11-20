
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
ENT.PrintName = "Scorpion Speen Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO4Speeen = function(self, duration, attacker, inflictor)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and string.find(self:GetClass(), "nz_zombie_boss") then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end

		if IsValid(self.bo4_scorpiongun_logic) then
			self.bo4_scorpiongun_logic:UpdateDuration(duration)
			return self.bo4_scorpiongun_logic
		end

		self.bo4_scorpiongun_logic = ents.Create("bo4_status_effect_speeen")
		self.bo4_scorpiongun_logic:SetPos(self:GetPos())
		self.bo4_scorpiongun_logic:SetParent(self)
		self.bo4_scorpiongun_logic:SetOwner(self)

		self.bo4_scorpiongun_logic:SetAttacker(attacker)
		self.bo4_scorpiongun_logic:SetInflictor(inflictor)

		self.bo4_scorpiongun_logic:Spawn()
		self.bo4_scorpiongun_logic:Activate()

		self.bo4_scorpiongun_logic:SetOwner(self)
		self.bo4_scorpiongun_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.SpeenLogic", self.bo4_scorpiongun_logic)
		return self.bo4_scorpiongun_logic
	end
	hook.Add("PlayerDeath", "BO4.SpeenLogic", function(self)
		if IsValid(self.bo4_scorpiongun_logic) then
			return self.bo4_scorpiongun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO4.SpeenLogic", function(self)
		if IsValid(self.bo4_scorpiongun_logic) then
			return self.bo4_scorpiongun_logic:Remove()
		end
	end)
	if engine.ActiveGamemode() == "nzombies" then
		hook.Add("OnZombieKilled", "BO4.SpeenLogic", function(self)
			if IsValid(self.bo4_scorpiongun_logic) then
				self.bo4_scorpiongun_logic:Remove()
			end
		end)
	end
end

local l_CT = CurTime

entMeta.BO4IsSpinning = function(self)
	return IsValid(self:GetNW2Entity("BO4.SpeenLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")

	self:NetworkVar("Float", 0, "NextPrimaryFire")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	local ct = l_CT()

	if IsValid(p) then
		p:EmitSound("TFA_BO4_SCORPION.Shock")
		self:EmitSound("TFA_BO4_SCORPION.Spin")
		self:SetNextPrimaryFire(ct)

		ParticleEffectAttach("bo4_scorpion_spinner", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		if p:OnGround() then
			ParticleEffectAttach("bo4_scorpion_spinner_ground", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		end
	end

	if CLIENT then return end
	if not IsValid(p) then return self:Remove() end

	self:TrapNextBot(p)
	self:TrapNPC(p)

	self.statusStart = ct
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - l_CT() > newtime then return end
	local p = self:GetParent()
	if nzombies and p:IsValidZombie() then
		p:Freeze(newtime)
	end

	self.duration = newtime
	self.statusEnd = l_CT() + newtime
end

ENT.Think = function(self)
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)

		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 250
			dlight.g = 255
			dlight.b = 120
			dlight.decay = 500
			dlight.brightness = 4
			dlight.size = 128
			dlight.dietime = CurTime() + 1
		end
	end

	if CLIENT then return false end

	local p = self:GetParent()
	local ct = l_CT()

	if IsValid(p) then
		if p:IsNPC() and p:GetCurrentSchedule() ~= SCHED_NPC_FREEZE then
			p:SetSchedule(SCHED_NPC_FREEZE)
			p:SetMoveVelocity(vector_origin)
		end

		local attacker = self:GetAttacker()

		if self:GetNextPrimaryFire() < ct then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 120)) do
				if v:IsNPC() or v:IsNextBot() then
					if v == p then continue end
					if v:Health() <= 0 then continue end
					if nzombies and (v.NZBossType or string.find(v:GetClass(), "zombie_boss")) then continue end
					if v:BO4IsSpinning() then continue end
					if v:BO4IsScorped() then continue end
					if IsValid(attacker) and attacker:IsNPC() and attacker:Disposition(v) == D_LI then continue end

					local time = math.random(9,12)*0.5
					if nzombies and nzPowerUps:IsPowerupActive("insta") then
						time = 1
					end

					local patt = p:GetAttachment(2) and p:GetAttachment(2).Pos or p:EyePos()
					local att = v:GetAttachment(2) and v:GetAttachment(2).Pos or v:EyePos()
					util.ParticleTracerEx("bo4_dg1_jump", patt, att, false, self:EntIndex(), v:EntIndex())

					v:BO4Scorp(time, attacker, self:GetInflictor())
					break
				end
			end

			local nexttime = math.Rand(0.2,0.5)
			self:SetNextPrimaryFire(ct + nexttime)
		end
	end

	if self.statusEnd < l_CT() then
		if IsValid(p) then
			self:InflictDamage(p)
		end
		self:StopSound("TFA_BO4_SCORPION.Spin")
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	ent:EmitSound("TFA_BO4_SCORPION.Kill")

	local damage = DamageInfo()
	damage:SetDamageType(nzombies and DMG_DISSOLVE or bit.bor(DMG_DISSOLVE, DMG_SHOCK))
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:EyePos())

	local head = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !head then head = ent:LookupBone("j_head") end
	if head then
		damage:SetDamagePosition(ent:GetBonePosition(head))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

ENT.TrapNextBot = function(self, bot)
	if bot:IsNextBot() then
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
		npc:SetCollisionGroup(COLLISION_GROUP_WORLD)
		npc:StopMoving()
		npc:SetMoveVelocity(vector_origin)
		npc:SetSchedule(SCHED_NPC_FREEZE)
	end
end

ENT.OnRemove = function(self)
	self:StopSound("TFA_BO4_SCORPION.Spin")
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		if SERVER and nzombies and p:IsValidZombie() then
			if !p.IgnoreBlockAttackReset then
				p:SetBlockAttack(false)
			end
			p.loco:SetAcceleration(p.Acceleration)
			p.loco:SetDesiredSpeed(p:GetRunSpeed())
		end
	end

	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 160)) do
			if IsValid(v.bo4_scorping_logic) then
				v.bo4_scorping_logic:Remove()
			end
		end
	end
end
