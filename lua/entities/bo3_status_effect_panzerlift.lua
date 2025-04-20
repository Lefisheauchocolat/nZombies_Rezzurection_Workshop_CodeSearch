
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
ENT.PrintName = "Portal Pull Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.PanzerDGLift = function(self, duration)
		if duration == nil then
			duration = 0
		end

		if IsValid(self.bo3_panzerlift_logic) then
			self.bo3_panzerlift_logic:UpdateDuration(duration)
			return self.bo3_panzerlift_logic
		end

		self.bo3_panzerlift_logic = ents.Create("bo3_status_effect_panzerlift")
		self.bo3_panzerlift_logic:SetPos(self:GetPos())
		self.bo3_panzerlift_logic:SetParent(self)
		self.bo3_panzerlift_logic:SetOwner(self)

		self.bo3_panzerlift_logic:Spawn()
		self.bo3_panzerlift_logic:Activate()

		self.bo3_panzerlift_logic:SetOwner(self)

		self.bo3_panzerlift_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO3.PanzerLiftLogic", self.bo3_panzerlift_logic)
		return self.bo3_panzerlift_logic
	end
end

local nzombies = engine.ActiveGamemode() == "nzombies"

entMeta.PanzerDGLifted = function(self)
	return IsValid(self:GetNW2Entity("BO3.PanzerLiftLogic"))
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	if CLIENT then return end
	local p = self:GetParent()
	if not IsValid(p) then self:Remove() return end

	self:TrapNextBot(p)
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
	if p.Freeze then
		p:Freeze(newtime)
	end

	self.duration = newtime
	self.statusEnd = self.statusEnd + newtime
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

ENT.TrapNextBot = function(self, bot)
	if bot:IsNextBot() then
		bot.loco:SetAcceleration(0)
		bot.loco:SetDesiredSpeed(0)
		if nzombies and bot:IsValidZombie() then
			bot:SetBlockAttack(true)
		end
	end
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		if p:IsNextBot() then
			if p:IsValidZombie() and !p.IgnoreBlockAttackReset then
				p:SetBlockAttack(false)
			end
			p.loco:SetAcceleration(p.Acceleration)
			p.loco:SetDesiredSpeed(p:GetRunSpeed())
		end
	end
end

ENT.Draw = function(self)
end