AddCSLuaFile()

ENT.Base = "nz_zombie_boss_panzer"
ENT.PrintName = "Panzer Soldat(Origins Taser)"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:SpecialInit()
	if SERVER then
		self.VariantChance = 2
	end
end