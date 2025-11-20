
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
ENT.PrintName = "Molotov Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO1BurnSlow = function(self, duration, blockattack)
		if duration == nil then
			duration = 0
		end
		if blockattack == nil then
			blockattack = false
		end

		if IsValid(self.bo1_molotov_logic) then
			self.bo1_molotov_logic:UpdateDuration(duration)
			return self.bo1_molotov_logic
		end

		self.bo1_molotov_logic = ents.Create("bo1_status_effect_molotov")
		self.bo1_molotov_logic:SetPos(self:WorldSpaceCenter())
		self.bo1_molotov_logic:SetParent(self)
		self.bo1_molotov_logic:SetOwner(self)
		self.bo1_molotov_logic:SetUpgraded(blockattack)

		self.bo1_molotov_logic:Spawn()
		self.bo1_molotov_logic:Activate()

		self.bo1_molotov_logic:SetOwner(self)
		self.bo1_molotov_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO1.MolotovLogic", self.bo1_molotov_logic)
		return self.bo1_molotov_logic
	end

	hook.Add("OnZombieKilled", "BO1.MolotovLogic", function(self)
		if IsValid(self.bo1_molotov_logic) then
			return self.bo1_molotov_logic:Remove()
		end
	end)
end

entMeta.BO1IsBurning = function(self)
	return IsValid(self:GetNW2Entity("BO1.MolotovLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Bool", 0, "Upgraded")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	self:EmitSound("TFA_BO1_MOLOTOV.Zomb.Burn")
	if IsValid(p) then
		ParticleEffectAttach(self:GetUpgraded() and "bo1_molotov_zomb_2" or "bo1_molotov_zomb", PATTACH_ABSORIGIN_FOLLOW, p, 0)

		if SERVER and p:IsValidZombie() then
			self.DesiredSpeed = p.DesiredSpeed
			p:SetRunSpeed(1)
			p:SpeedChanged()
			if self:GetUpgraded() then
				p:SetBlockAttack(true)
			end
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

	//if self.statusEnd - CurTime() > newtime then return end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.OnRemove = function(self)
	self:StopSound("TFA_BO1_MOLOTOV.Zomb.Burn")
	self:EmitSound("TFA_BO1_MOLOTOV.Burn")

	local p = self:GetParent()
	if not IsValid(p) then return end

	if p:IsValidZombie() then
		if (p.Alive and p:Alive()) or (p.IsAlive and p:IsAlive()) then
			p:StopParticles()
		end
	else
		p:StopParticles()
	end

	if SERVER and p:IsValidZombie() then
		p:SetRunSpeed(self.DesiredSpeed)
		p:SpeedChanged()
		if self:GetUpgraded() and !p.IgnoreBlockAttackReset then
			p:SetBlockAttack(false)
		end
	end
end

ENT.Draw = function(self)
end