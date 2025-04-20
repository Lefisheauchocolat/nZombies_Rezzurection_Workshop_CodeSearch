AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Pressurized External Suit"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

ENT.NZHudIcon = Material("vgui/icon/uie_t5hud_icon_helmet.png", "smooth unlitgeneric")

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Active")
end
