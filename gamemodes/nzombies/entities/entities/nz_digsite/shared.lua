AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Dig Mound Spawn"
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
	self:NetworkVar("Bool", 1, "Override")
	self:NetworkVar("Bool", 2, "Red")
	self:NetworkVar("Bool", 3, "SemtexHack")
end
