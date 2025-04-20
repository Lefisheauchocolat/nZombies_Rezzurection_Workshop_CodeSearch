AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Blank Chalk"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "NoChalk")
	self:NetworkVar("Bool", 1, "Used")
end