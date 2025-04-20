AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Amm-O-Matic"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "TotalCooldown")
	self:NetworkVar("Int", 1, "Price")
	self:NetworkVar("Float", 0, "NextCooldown")
	self:NetworkVar("Bool", 0, "Active")
end

function ENT:IsCoolingDown()
	return self:GetNextCooldown() > CurTime()
end
