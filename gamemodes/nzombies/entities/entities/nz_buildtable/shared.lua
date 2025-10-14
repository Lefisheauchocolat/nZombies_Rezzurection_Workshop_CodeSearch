AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Buildable Table"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.BrutusDestructable = true
ENT.Damage = 0
ENT.WeaponWeight = 10
ENT.BuildName = ""

ENT.BuildLoopSound = "NZ.Buildable.Craft.Loop"
ENT.BuildEndSound = "NZ.Buildable.Craft.Finish"
ENT.BuildDenySound = "NZ.Buildable.Deny"
ENT.BuildPickupSound = "NZ.Buildable.PickUp"

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Buildable")

	self:NetworkVar("Int", 1, "Price")

	self:NetworkVar("Bool", 0, "Completed")
	self:NetworkVar("Bool", 1, "Used")
	self:NetworkVar("Bool", 2, "BrutusLocked")
end

function ENT:GetRemainingParts()
	local amount = 0
	for k, v in pairs(ents.FindByClass("nz_buildable")) do
		if v:GetBuildable() == self:GetBuildable() and not v:GetActivated() then
			amount = amount + 1
		end
	end

	for k, v in pairs(ents.FindByClass("nz_digsite")) do
		if v:GetOverride() and v:GetBuildable() == self:GetBuildable() and not v:GetActivated() then
			amount = amount + 1
		end
	end

	if self.RequiredTable then
		for k, v in pairs(ents.FindByClass("nz_buildtable")) do
			if v:GetBuildable() == self.RequiredTable and not v:GetUsed() then
				amount = amount + 1
			end
		end
	end

	return tonumber(amount)
end

function ENT:OnRemove()
	self:StopSound("NZ.Buildable.Craft.Loop")
	self:StopSound("NZ.Buildable.Craft.LoopSweet")
	self:StopParticles()
	if SERVER then
		if IsValid(self.CraftedModel) then
			SafeRemoveEntity(self.CraftedModel)
		end
		if IsValid(self.CraftedModel2) then
			SafeRemoveEntity(self.CraftedModel2)
		end
	end
end
