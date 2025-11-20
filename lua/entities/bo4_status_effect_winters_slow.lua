
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
ENT.PrintName = "Winters Slow Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local nzombies = engine.ActiveGamemode() == "nzombies"
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.BO4WintersSlow = function(self, duration, ratio)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end

		if duration == nil then
			duration = 0
		end
		if ratio == nil then
			ratio = 1
		end

		if IsValid(self.bo4_winterslow_logic) then
			self.bo4_winterslow_logic:UpdateDuration(duration)
			return self.bo4_winterslow_logic
		end

		self.bo4_winterslow_logic = ents.Create("bo4_status_effect_winters_slow")
		self.bo4_winterslow_logic:SetPos(self:WorldSpaceCenter())
		self.bo4_winterslow_logic:SetParent(self)
		self.bo4_winterslow_logic:SetOwner(self)
		self.bo4_winterslow_logic:SetRatio(ratio)

		self.bo4_winterslow_logic:Spawn()
		self.bo4_winterslow_logic:Activate()

		self.bo4_winterslow_logic:SetOwner(self)
		self.bo4_winterslow_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.WinterSlowLogic", self.bo4_winterslow_logic)
		return self.bo4_winterslow_logic
	end

	hook.Add("OnNPCKilled", "BO4.WinterSlowLogic", function(self)
		if IsValid(self.bo4_winterslow_logic) then
			return self.bo4_winterslow_logic:Remove()
		end
	end)
	hook.Add("PlayerDeath", "BO4.WinterSlowLogic", function(self)
		if IsValid(self.bo4_winterslow_logic) then
			return self.bo4_winterslow_logic:Remove()
		end
	end)
	if nzombies then
		hook.Add("OnZombieKilled", "BO4.WinterSlowLogic", function(self)
			if IsValid(self.bo4_winterslow_logic) then
				return self.bo4_winterslow_logic:Remove()
			end
		end)
	end
end

entMeta.BO4IsSlowed = function(self)
	return IsValid(self:GetNW2Entity("BO4.WinterSlowLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Float", 0, "Ratio")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		ParticleEffectAttach("bo4_freezegun_zomb_smoke", PATTACH_POINT_FOLLOW, p, 0)
	end

	if CLIENT then return end
	self.statusStart = CurTime()
	self.duration = 0.5
	self.statusEnd = self.statusStart + 0.5
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end
    self.duration = newtime
    self.statusEnd = CurTime() + newtime

    local p = self:GetParent()
	if SERVER and IsValid(p) then
		if p:IsNextBot() then
			if not p.OldAccel then
				p.OldAccel = p.loco:GetAcceleration()
				p.OldSpeed = p.loco:GetDesiredSpeed()
			end
			p.loco:SetVelocity(p.loco:GetVelocity() * self:GetRatio())
			p.loco:SetDesiredSpeed(p.loco:GetDesiredSpeed() * self:GetRatio())
			p.loco:SetAcceleration(p.loco:GetAcceleration() * self:GetRatio())
			self.nxb_spd = p.loco:GetDesiredSpeed()
		end

		if p:IsNPC() then
			if not p.OldSpeed then
				p.OldSpeed = p:GetMoveVelocity()
			end

			p:SetMoveVelocity(p:GetMoveVelocity() * self:GetRatio())
			self.npc_spd = p:GetMoveVelocity()
		end

		if p:IsPlayer() then
			if not p.OldPlySpeed then
				p.OldPlySpeed = p:GetMaxSpeed()
			end

			p:SetMaxSpeed(p:GetMaxSpeed() * self:GetRatio())
			self.ply_spd = p:GetMaxSpeed()
		end
	end
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and not p:BO4IsFrozen() then
		if p:IsNPC() then
			p:SetMoveVelocity(self.npc_spd)
		end

		if p:IsNextBot() then
			p.loco:SetVelocity(p:GetForward() * self.nxb_spd)
			p.loco:SetDesiredSpeed(self.nxb_spd)
		end

		if p:IsPlayer() then
			p:SetMaxSpeed(self.ply_spd)
		end
	end

	if self.statusEnd < CurTime() then
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
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
			p:SetMoveVelocity(p.OldSpeed)
		end

		if p:IsPlayer() then
			p:SetMaxSpeed(p.OldPlySpeed)
		end
	end
end
