AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Trading Table"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Int", 1, "UserIndex")
	self:NetworkVar("Entity", 0, "Weapon")
	self:NetworkVar("Bool", 0, "AllowWonder")
end
