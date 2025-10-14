AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Bank Teller"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Points")
	self:NetworkVar("Int", 1, "PointLimit")
	self:NetworkVar("Int", 2, "PointFee")
	self:NetworkVar("Bool", 0, "Electric")
end