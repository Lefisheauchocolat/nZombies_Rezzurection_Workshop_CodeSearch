
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
ENT.PrintName = "Nova Gas Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.NZNovaGas = function(self, duration)
		if duration == nil then
			duration = 0
		end

		if self:IsPlayer() and nzGum:GetActiveGum(self) and nzGum:GetActiveGum(self) == "danger_closest" then
			duration = duration / 2
		end

		if IsValid(self.nz_novagas_logic) then
			self.nz_novagas_logic:UpdateDuration(duration)
			return self.nz_novagas_logic
		end

		self.nz_novagas_logic = ents.Create("nz_status_effect_slow")
		self.nz_novagas_logic:SetPos(self:WorldSpaceCenter())
		self.nz_novagas_logic:SetParent(self)
		self.nz_novagas_logic:SetOwner(self)

		self.nz_novagas_logic:Spawn()
		self.nz_novagas_logic:Activate()

		self.nz_novagas_logic:SetOwner(self)
		self.nz_novagas_logic:UpdateDuration(duration)
		self:SetNW2Entity("NZ.NovaGas", self.nz_novagas_logic)
		return self.nz_novagas_logic
	end

	hook.Add("PlayerDeath", "NZ.NovaGas", function(self)
		if IsValid(self.nz_novagas_logic) then
			return self.nz_novagas_logic:Remove()
		end
	end)
end

entMeta.NZIsNovaGassed = function(self)
	return IsValid(self:GetNW2Entity("NZ.NovaGas"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Float", 0, "StatudEnd")
	self:NetworkVar("Float", 1, "StatusLength")
	self:NetworkVar("Float", 2, "StatusProgress")
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	self.statusStart = CurTime()
	self.duration = 0.1
	self.statusEnd = self.statusStart + 0.1

	self:SetStatudEnd(CurTime() + 0.1)
	self:SetStatusLength(0.1)
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

	self.duration = newtime
	self.statusEnd = CurTime() + newtime

	self:SetStatudEnd(CurTime() + newtime)
	self:SetStatusLength(newtime)
end

ENT.Think = function(self)
	self:SetStatusProgress(math.Clamp((self:GetStatudEnd() - CurTime()) / self:GetStatusLength(), 0, 1))

	if SERVER then
		if self.statusEnd < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

ENT.OnRemove = function(self)
end

ENT.Draw = function(self)
end