
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
ENT.PrintName = "Magmagat Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO4Magma = function(self, duration, attacker, inflictor, damage)
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
		if damage == nil then
			damage = 54000
		end

		if IsValid(self.bo4_magmagat_logic) then
			self.bo4_magmagat_logic:UpdateDuration(duration)
			return self.bo4_magmagat_logic
		end

		self.bo4_magmagat_logic = ents.Create("bo4_status_effect_magma")
		self.bo4_magmagat_logic:SetPos(self:WorldSpaceCenter())
		self.bo4_magmagat_logic:SetParent(self)
		self.bo4_magmagat_logic:SetOwner(self)

		self.bo4_magmagat_logic:SetAttacker(attacker)
		self.bo4_magmagat_logic:SetInflictor(inflictor)
		self.bo4_magmagat_logic:SetDamage(damage)

		self.bo4_magmagat_logic:Spawn()
		self.bo4_magmagat_logic:Activate()

		self.bo4_magmagat_logic:SetOwner(self)
		self.bo4_magmagat_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.MagmagatLogic", self.bo4_magmagat_logic)
		return self.bo4_magmagat_logic
	end
	hook.Add("PlayerDeath", "BO4.MagmagatLogic", function(self)
		if IsValid(self.bo4_magmagat_logic) then
			return self.bo4_magmagat_logic:Remove()
		end
	end)
	hook.Add("OnNPCKilled", "BO4.MagmagatLogic", function(self)
		if IsValid(self.bo4_magmagat_logic) then
			return self.bo4_magmagat_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO4.MagmagatLogic", function(self)
			if IsValid(self.bo4_magmagat_logic) then
				self.bo4_magmagat_logic:Remove()
			end
		end)
	end
end

entMeta.BO4IsMagmaIgnited = function(self)
	return IsValid(self:GetNW2Entity("BO4.MagmagatLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
	self:NetworkVar("Float", 0, "Damage")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	if CLIENT then return end
	local p = self:GetParent()
	if not IsValid(p) then self:Remove() return end

	if p:IsNPC() then
		self.npc_spd = p:GetMoveVelocity() * 0.5
	end

	if p:IsNextBot() then
		if not p.OldAccel then
			p.OldAccel = p.loco:GetAcceleration()
			p.OldSpeed = p.loco:GetDesiredSpeed()
		end

		p.loco:SetDesiredSpeed(50)
		p.loco:SetAcceleration(50)
		if nzombies and p:IsValidZombie() then
			p:SetBlockAttack(true)
		end
	end

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
	if IsValid(p) and p.Ignite then
		p:Ignite(newtime)
	end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and p:IsNPC() then
		p:SetMoveVelocity(self.npc_spd)
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
	ParticleEffect("bo4_magmagat_explode", ent:WorldSpaceCenter(), Angle(0,0,0))
	ent:EmitSound("TFA_BO4_BLUNDER.Magma.Explode")
	ent:EmitSound("TFA_BO4_BLUNDER.Magma.Explode.Swt")

	local damage = DamageInfo()
	damage:SetDamage(self:GetDamage())
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamageType(DMG_SLOWBURN)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(self:GetDamage(), ent:GetMaxHealth() / 12))
		//damage:ScaleDamage(math.min(math.Round(nzRound:GetNumber()/6), 1))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		if p:IsNextBot() then
			if nzombies then
				if p:IsValidZombie() and !p.IgnoreBlockAttackReset then
					p:SetBlockAttack(false)
				end
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
