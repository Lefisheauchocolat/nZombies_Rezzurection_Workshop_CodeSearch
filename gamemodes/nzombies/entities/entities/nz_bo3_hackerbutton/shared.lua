AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Hacker Button"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Flag")
	self:NetworkVar("String", 1, "DoorFlag")
	self:NetworkVar("Bool", 0, "Electric")
	self:NetworkVar("Bool", 1, "Activated")
	self:NetworkVar("Bool", 2, "DoHide")
	self:NetworkVar("Bool", 3, "DoSprite")
	self:NetworkVar("Int", 0, "HaxLock") //for hiddens stuffs
	self:NetworkVar("Int", 1, "Price")
	self:NetworkVar("Float", 0, "Time")
	self:NetworkVar("Vector", 0, "GlowColor")
end

function ENT:Hackable()
	return !self:GetActivated() and self:GetHaxLock() == 0 and (!self:GetElectric() or self:GetElectric() and nzElec:IsOn())
end
