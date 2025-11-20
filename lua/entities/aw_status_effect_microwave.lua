
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
ENT.PrintName = "Magnetron Cooking Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.AWMicrowave = function(self, duration, attacker, inflictor, upgraded, hitpos)
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
		if upgraded == nil then
			upgraded = false
		end

		if IsValid(self.aw_magnetron_logic) then
			self.aw_magnetron_logic:UpdateDuration(duration)
			return self.aw_magnetron_logic
		end

		self.aw_magnetron_logic = ents.Create("aw_status_effect_microwave")
		self.aw_magnetron_logic:SetPos(self:WorldSpaceCenter())
		self.aw_magnetron_logic:SetParent(self)
		self.aw_magnetron_logic:SetOwner(self)

		self.aw_magnetron_logic:SetUpgraded(upgraded)
		self.aw_magnetron_logic:SetAttacker(attacker)
		self.aw_magnetron_logic:SetInflictor(inflictor)
		if hitpos then
			self.aw_magnetron_logic.HitPos = hitpos
		end

		self.aw_magnetron_logic:Spawn()
		self.aw_magnetron_logic:Activate()

		self.aw_magnetron_logic:SetOwner(self)
		self.aw_magnetron_logic:UpdateDuration(duration)
		self:SetNW2Entity("AW.MagnetronLogic", self.aw_magnetron_logic)
		return self.aw_magnetron_logic
	end

	hook.Add("PlayerDeath", "AW.MagnetronLogic", function(self)
		if IsValid(self.aw_magnetron_logic) then
			return self.aw_magnetron_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "AW.MagnetronLogic", function(self)
		if IsValid(self.aw_magnetron_logic) then
			return self.aw_magnetron_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "AW.MagnetronLogic", function(self)
			if IsValid(self.aw_magnetron_logic) then
				return self.aw_magnetron_logic:Remove()
			end
		end)
	end
end

entMeta.AWIsCooking = function(self)
	return IsValid(self:GetNW2Entity("AW.MagnetronLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
	self:NetworkVar("Bool", 0, "Upgraded")

	self:NetworkVar("Float", 0, "StatusStart")
	self:NetworkVar("Float", 1, "StatusEnd")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		self:SetStatusStart(CurTime())
		p:EmitSound("TFA_AW_MWAVE.Cook")
	end

	if CLIENT then return end
	if not IsValid(p) then self:Remove() return end
	self.statusStart = CurTime()
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime + math.Rand(-0.1, 0.1)

	self:SetStatusEnd(self.statusEnd)
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		local time = 1.5
		if nzombies and nzPowerUps:IsPowerupActive("insta") then
			time = 0.5
		end

		if self:GetStatusEnd() > (self:GetStatusStart() + time) then
			self:InflictDamage(p)
			self:Remove()
			return false
		end
	end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
	ParticleEffect(cyborg and "bo2_jetgun_grind_blue" or "bo2_jetgun_grind", ent:GetPos() + VectorRand(-5,5), vector_up:Angle())
	ParticleEffect(self:GetUpgraded() and "aw_magnetron_pop_2" or "aw_magnetron_pop", self:GetPos(), vector_up:Angle())

	ent:EmitSound("TFA_AW_MWAVE.Pop")
	ent:EmitSound("TFA_AW_MWAVE.Pop.Lyr")
	ent:EmitSound("TFA_BO3_WAFFE.Pop")

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamageType(DMG_ENERGYBEAM)
	damage:SetDamagePosition(self.HitPos or ent:EyePos())
	damage:SetDamageForce(vector_up)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss")) then
		damage:SetDamage(math.max(800, ent:GetMaxHealth() / 8))
	else
		ent:SetHealth(1)
		ent:SetNW2Bool("RemoveRagdoll", true)
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end

	ent:TakeDamageInfo(damage)
	self:Remove()
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopSound("TFA_AW_MWAVE.Cook")
	end
end

ENT.Draw = function(self)
end
