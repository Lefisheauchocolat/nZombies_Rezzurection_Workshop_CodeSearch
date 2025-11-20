
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

--[Info]--
local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

ENT.Type = "anim"
ENT.PrintName = "Zapper"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

ENT.Range = 180
ENT.Delay = 2/3
ENT.Life = 300 //lasts 5 minutes

ENT.NZHudIcon = Material("vgui/icon/hud_icon_electrip.png", "smooth unlitgeneric")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Float", 0, "ActivateTime")
	self:NetworkVar("String", 0, "TrapClass")
end

function ENT:EmitSoundNet(sound)
	if CLIENT or sp then
		if sp and not IsFirstTimePredicted() then return end

		self:EmitSound(sound)
		return
	end

	local filter = RecipientFilter()
	filter:AddPAS(self:GetPos())
	if IsValid(self:GetOwner()) then
		filter:RemovePlayer(self:GetOwner())
	end

	net.Start("tfaSoundEvent", true)
	net.WriteEntity(self)
	net.WriteString(sound)
	net.Send(filter)
end

local max = (nzombies and (sp and 4 or 2) or 12)
function ENT:OverflowCheck()
	local ply = self:GetOwner()
	if not ply.activeetrips then ply.activeetrips = {} end
	table.insert(ply.activeetrips, self)

	if SERVER then
		if #ply.activeetrips > max then
			for k, v in pairs(ply.activeetrips) do
				if not IsValid(v) then continue end
				if v == self then continue end
				v:Remove()
				break
			end
		end
	end
end

function ENT:OnRemove()
	local ply = self:GetOwner()
	if IsValid(ply) and ply.activeetrips and table.HasValue(ply.activeetrips, self) then
		table.RemoveByValue(ply.activeetrips, self)
	end
	self:StopSound("TFA_WAW_ELECTRIP.Loop")

	if SERVER then
		local ent = self.ElectripWire
		if IsValid(ent) then
			self.ElectripWire = nil
			ent:Remove()
		end
	end
end