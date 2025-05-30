
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
ENT.Type = "anim"
ENT.PrintName = "Back Shield"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.bIsShield = true
ENT.NZHudIcon = Material("vgui/icon/zm_riotshield_icon.png", "smooth unlitgeneric")

local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Weapon")
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
