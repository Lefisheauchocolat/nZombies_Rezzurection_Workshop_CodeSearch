AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Key Spawn"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.NZHudIcon = Material("vgui/icon/zom_hud_icon_key.png", "unlitgeneric smooth")

local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "PickupHint")
	self:NetworkVar("String", 1, "HudIcon")
	self:NetworkVar("String", 2, "Flag")
	self:NetworkVar("Bool", 0, "SingleUse")
	self:NetworkVar("Bool", 1, "Used")
	self:NetworkVar("Vector", 0, "CustomGlow")
end