AddCSLuaFile()

ENT.Base = "nz_zombie_boss_panzer"
ENT.PrintName = "Panzer Soldat(Origins Claw)"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:SpecialInit()
	if SERVER then
		self.VariantChance = 1
	end
end
