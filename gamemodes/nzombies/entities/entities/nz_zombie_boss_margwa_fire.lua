AddCSLuaFile()

ENT.Base = "nz_zombie_boss_margwa"
--ENT.PrintName = "I've adopted a funny little squid creature from Laby"
ENT.PrintName = "Fire Margwa"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:SpecialInit()
	self:SetElementalType("Fire")
	self:SetSkin(2)
end