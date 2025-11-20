
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
ENT.PrintName = "KT4 Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO3Spore = function(self, duration, attacker, inflictor, upgrade)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if upgrade == nil then
			upgrade = false
		end
		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end

		if IsValid(self.bo3_sporegun_logic) then
			self.bo3_sporegun_logic:UpdateDuration(duration)
			return self.bo3_sporegun_logic
		end

		self.bo3_sporegun_logic = ents.Create("bo3_status_effect_spores")
		self.bo3_sporegun_logic:SetPos(self:WorldSpaceCenter())
		self.bo3_sporegun_logic:SetParent(self)
		self.bo3_sporegun_logic:SetOwner(self)
		self.bo3_sporegun_logic:SetUpgraded(upgrade)

		self.bo3_sporegun_logic:Spawn()
		self.bo3_sporegun_logic:Activate()
		
		self.bo3_sporegun_logic:SetAttacker(attacker)
		self.bo3_sporegun_logic:SetInflictor(inflictor)

		self.bo3_sporegun_logic:SetOwner(self)
		self.bo3_sporegun_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.SporegunLogic", self.bo3_sporegun_logic)
		return self.bo3_sporegun_logic
	end
	
	hook.Add("PlayerDeath", "BO3.SporegunLogic", function(self)
		if IsValid(self.bo3_sporegun_logic) then
			return self.bo3_sporegun_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO3.SporegunLogic", function(self)
		if IsValid(self.bo3_sporegun_logic) then
			return self.bo3_sporegun_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO3.SporegunLogic", function(self)
			if IsValid(self.bo3_sporegun_logic) then
				return self.bo3_sporegun_logic:Remove()
			end
		end)
	end
end

entMeta.BO3IsSpored = function(self)
	return IsValid(self:GetNW2Entity("BO3.SporegunLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
	self:NetworkVar("Bool", 0, "Upgraded")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("TFA_BO3_MIRG.Spore.Infect")
		p:EmitSound("TFA_BO3_MIRG.Spore.Grow")
		if self:GetUpgraded() then
			ParticleEffectAttach("bo3_mirg2k_zomb_goo_2", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		else
			ParticleEffectAttach("bo3_mirg2k_zomb_goo", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		end
	end

	if CLIENT then return end
	self.statusStart = CurTime()
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) then
		local rate = math.Clamp((self.statusEnd - CurTime()) / self.duration, 0, 1)

		if SERVER then
			if p:IsNPC() then
				if not p.OldSpeed then
					p.OldSpeed = p:GetMoveVelocity()
				end
				p:SetMoveVelocity(p.OldSpeed * rate)
			end

			if p:IsNextBot() then
				if not p.OldAccel then
					p.OldAccel = p.loco:GetAcceleration()
					p.OldSpeed = p.loco:GetDesiredSpeed()
				end
				p.loco:SetAcceleration(p.OldAccel * rate)
				p.loco:SetDesiredSpeed(p.OldSpeed * rate)
			end
		end
	end

	if self.statusEnd < CurTime() then
		if IsValid(p) then
			self:InflictDamage(p)
		end
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	ent:EmitSound("TFA_BO3_MIRG.Spore.Explode")
	if self:GetUpgraded() then
		ParticleEffect("bo3_mirg2k_explode_2", ent:WorldSpaceCenter(), Angle(0,0,0))
	else
		ParticleEffect("bo3_mirg2k_explode", ent:WorldSpaceCenter(), Angle(0,0,0))
	end

	local damage = DamageInfo()
	damage:SetDamageType(DMG_RADIATION)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 12))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/6))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

function ENT:Explode()
	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamageType(DMG_RADIATION)
	damage:SetDamage(400)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self:GetUpgraded() and 90 or 60)) do
		if (v:IsNPC() or v:IsNextBot() or v:IsPlayer()) then
			if v == self:GetParent() then continue end
			if v:IsPlayer() then continue end
			if v:BO3IsSpored() then continue end
			if v:Health() <= 0 then continue end

			v:EmitSound("TFA_BO3_MIRG.ImpactSwt")

			ParticleEffect(self:GetUpgraded() and "bo3_mirg2k_explode_2" or "bo3_mirg2k_explode", v:WorldSpaceCenter(), angle_zero)

			if nzombies and (v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "zombie_boss")) then
				damage:SetDamage(math.max(1200, v:GetMaxHealth()/12))
			end

			damage:SetDamageForce(v:GetUp()*8000 + (v:GetPos()-self:GetPos()):GetNormalized()*6000)
			damage:SetDamagePosition(v:WorldSpaceCenter())

			if v:IsNPC() then
				v:SetHealth(1)
				v:SetSchedule(SCHED_ALERT_STAND)
			end

			v:TakeDamageInfo(damage)
		end
	end
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		self:Explode()
		p:StopParticles()

		if p:IsNextBot() then
			if nzombies then
				p.loco:SetAcceleration(p.Acceleration)
				p.loco:SetDesiredSpeed(p:GetRunSpeed())
			else
				p.loco:SetAcceleration(p.OldAccel)
				p.loco:SetDesiredSpeed(p.OldSpeed)
			end
		end
		if p:IsNPC() then
			p:SetSchedule(SCHED_ALERT_STAND)
		end
	end
end

ENT.Draw = function(self)
end