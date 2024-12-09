AddCSLuaFile()

ENT.Base = "nz_zombie_boss_margwa"
--ENT.PrintName = "I've adopted a funny little squid creature from Laby"
ENT.PrintName = "Shadow Margwa"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:SpecialInit()
	self:SetElementalType("Shadow")
	self:SetSkin(3)
end