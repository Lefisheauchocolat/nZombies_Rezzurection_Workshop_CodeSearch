AddCSLuaFile()

ENT.Base = "nz_zombie_walker_moon_classic"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

function ENT:SpecialInit()

	self:SetBodygroup(2,2)
	
	-- MP Zombies don't have the cap.
	if self:GetBodygroup(2) == 2 then self:SetBodygroup(0,0) end
end