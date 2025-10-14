AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Locker Spawn"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "PickupHint")
	self:NetworkVar("String", 1, "DoorFlag")
	self:NetworkVar("String", 2, "LockerClass")
	self:NetworkVar("String", 3, "Flag")
	self:NetworkVar("Float", 0, "Time")
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Bool", 0, "Electric")
	self:NetworkVar("Bool", 1, "Used")
end