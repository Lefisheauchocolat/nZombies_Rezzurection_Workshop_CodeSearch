AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Weapon Locker"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Bool", 0, "Electric")
	self:NetworkVar("Bool", 1, "UseBoxList")
end