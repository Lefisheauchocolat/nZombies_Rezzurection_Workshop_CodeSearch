AddCSLuaFile()

ENT.Base = "nz_zombie_special_nova"
ENT.Type = "nextbot"
ENT.PrintName = "Nova Crawler"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end
	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_gas_trail", PATTACH_POINT_FOLLOW, 2)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

function ENT:SpecialInit()
	self.MoonBehaviour = true
end