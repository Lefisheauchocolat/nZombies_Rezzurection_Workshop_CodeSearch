
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
ENT.PrintName = "Alistairs Shrink Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO4Shrink = function(self, duration, attacker, inflictor)
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

		if IsValid(self.bo4_alishrink_logic) then
			self.bo4_alishrink_logic:UpdateDuration(duration)
			return self.bo4_alishrink_logic
		end

		self.bo4_alishrink_logic = ents.Create("bo4_status_effect_shrink")
		self.bo4_alishrink_logic:SetPos(self:GetPos())
		self.bo4_alishrink_logic:SetParent(self)
		self.bo4_alishrink_logic:SetOwner(self)

		self.bo4_alishrink_logic:Spawn()
		self.bo4_alishrink_logic:Activate()

		self.bo4_alishrink_logic:SetAttacker(attacker)
		self.bo4_alishrink_logic:SetInflictor(inflictor)

		self.bo4_alishrink_logic:SetOwner(self)
		self.bo4_alishrink_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.ShrinkLogic", self.bo4_alishrink_logic)
		return self.bo4_alishrink_logic
	end
	hook.Add("PlayerDeath", "BO4.ShrinkLogic", function(self)
		if IsValid(self.bo4_alishrink_logic) then
			return self.bo4_alishrink_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO4.ShrinkLogic", function(self)
		if IsValid(self.bo4_alishrink_logic) then
			return self.bo4_alishrink_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO4.ShrinkLogic", function(self)
			if IsValid(self.bo4_alishrink_logic) then
				self.bo4_alishrink_logic:Remove()
			end
		end)
	end
end

entMeta.BO4IsShrunk = function(self)
	return IsValid(self:GetNW2Entity("BO4.ShrinkLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("TFA_BO4_ALISTAIR.Charged.Shrink")

		ParticleEffectAttach("bo4_alistairs_shrink_ent", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		if p:OnGround() then
			ParticleEffectAttach( "bo4_alistairs_shrink_ent_floor", PATTACH_ABSORIGIN_FOLLOW, p, 0)
		end

		if nzombies and p:IsValidZombie() then
			p:SetBlockAttack(true)
		end
	end

	if CLIENT then return end
	self.statusStart = CurTime()
	self.duration = 1
	self.statusEnd = self.statusStart + 1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end
	if self.statusEnd - CurTime() > newtime then return end

	local p = self:GetParent()
	if SERVER and IsValid(p) then
		p:SetModelScale(0.1, newtime)
	end

    self.duration = newtime
    self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	if self.statusEnd < CurTime() then
		if IsValid(self:GetParent()) then
			self:InflictDamage(self:GetParent())
		end
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_REMOVENORAGDOLL)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ParticleEffect("bo4_alistairs_shrink_kill", ent:GetPos(), Angle(0,0,0))

	if nzombies and ent:IsValidZombie() then
		ent:SetNW2Bool("NZNoRagdoll", true)
	end

	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)
	ent:Remove()
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
	end
end
