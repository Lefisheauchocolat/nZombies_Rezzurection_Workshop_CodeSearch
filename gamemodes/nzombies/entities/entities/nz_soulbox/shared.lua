AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Soul Box"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "RewardType")
	self:NetworkVar("Int", 1, "SoulAmount")
	self:NetworkVar("Int", 2, "SoulCost")
	self:NetworkVar("Int", 3, "SoulRange")
	self:NetworkVar("Int", 4, "AOE")
	self:NetworkVar("Int", 5, "Flag")

	self:NetworkVar("Bool", 0, "Open")
	self:NetworkVar("Bool", 1, "Electric")
	self:NetworkVar("Bool", 2, "Limited")
	self:NetworkVar("Bool", 3, "GivePowerup")
	self:NetworkVar("Bool", 4, "Specials")

	self:NetworkVar("String", 0, "DoorFlag")
	self:NetworkVar("String", 1, "WepClass")
	self:NetworkVar("String", 2, "ZombieClass")
end

function ENT:Open()
	self:SetOpen(true)
	self:ResetSequence("open")
	timer.Simple(self:SequenceDuration("open"), function()
		if not IsValid(self) then return end
		if not self:GetOpen() then return end
		if self:LookupSequence("loop") > 0 then
			self:ResetSequence("loop")
		end
	end)
end

function ENT:Close()
	self:SetOpen(false)
	self:StopParticles()
	self:ResetSequence("close")
end

function ENT:GetCompleted()
	return self:GetSoulAmount() >= self:GetSoulCost()
end

function ENT:GetRemaining()
	local count = 0
	for k, v in pairs(ents.FindByClass("nz_soulbox")) do
		if not v:GetCompleted() and v:GetFlag() == self:GetFlag() and v:GetRewardType() == self:GetRewardType() then
			count = count + 1
		end
	end

	return tonumber(count)
end

function ENT:GetMaxRemaining()
	local count = 0
	for k, v in pairs(ents.FindByClass("nz_soulbox")) do
		if v:GetFlag() == self:GetFlag() and v:GetRewardType() == self:GetRewardType() then
			count = count + 1
		end
	end

	return tonumber(count)
end

function ENT:OnRemove()
	hook.Call("nzmapscript_SoulCatcherRemoved", nil, self)
end
