AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Weapon Chalk"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "WepClass")
	self:NetworkVar("String", 1, "HudIcon")
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Int", 1, "Points")
	self:NetworkVar("Bool", 0, "Flipped")
	self:NetworkVar("Bool", 1, "Used")
end