AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Buildable Part"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.Damage = 0
ENT.nextloop = 0

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Buildable")
	self:NetworkVar("Int", 0, "PartID")
	self:NetworkVar("Bool", 0, "Activated")
end