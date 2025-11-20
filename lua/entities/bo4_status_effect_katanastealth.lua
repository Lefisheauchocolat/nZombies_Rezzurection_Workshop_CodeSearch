
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
ENT.PrintName = "Katana Stealth Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local nzombies = engine.ActiveGamemode() == "nzombies"
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.BO4KatanaStealth = function(self, duration)
		if duration == nil then
			duration = 0
		end

		if IsValid(self.bo4_katanastealth_logic) then
			self.bo4_katanastealth_logic:UpdateDuration(duration)
			return self.bo4_katanastealth_logic
		end

		self.bo4_katanastealth_logic = ents.Create("bo4_status_effect_katanastealth")
		self.bo4_katanastealth_logic:SetPos(self:WorldSpaceCenter())
		self.bo4_katanastealth_logic:SetParent(self)
		self.bo4_katanastealth_logic:SetOwner(self)

		self.bo4_katanastealth_logic:Spawn()
		self.bo4_katanastealth_logic:Activate()

		self.bo4_katanastealth_logic:SetOwner(self)
		self.bo4_katanastealth_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.KatanaStealthLogic", self.bo4_katanastealth_logic)
		return self.bo4_katanastealth_logic
	end
	hook.Add("PlayerDeath", "BO4.KatanaStealthLogic", function(self)
		if IsValid(self.bo4_katanastealth_logic) then
			return self.bo4_katanastealth_logic:Remove()
		end
	end)
end

entMeta.BO4IsStealth = function(self)
	return IsValid(self:GetNW2Entity("BO4.KatanaStealthLogic"))
end

ENT.SetupDataTables = function(self)
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		ParticleEffectAttach("bo4_katana_player", PATTACH_POINT_FOLLOW, p, 1)
		if SERVER then
			p:SetNoTarget(true)
			if p.SetTargetPriority then
				p:SetTargetPriority(TARGET_PRIORITY_NONE)
			end
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
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		if SERVER then
			p:SetNoTarget(false)
			if nzombies and !nzPowerUps:IsPlayerPowerupActive(p, "zombieblood") then
				p:SetTargetPriority(TARGET_PRIORITY_PLAYER)
			end
		end
		p:SetNW2Bool("KatanaStealth", false)
	end
end
