AddCSLuaFile()

ENT.Base = "nz_zombie_walker_exo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end
	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_exo_fire_aura", 4, 10)
			end

			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 255
				elight.g = 210
				elight.b = 10
				elight.brightness = 5
				elight.Decay = 1000
				elight.Size = 75
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.Models = {
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_fire.mdl", Skin = 0, Bodygroups = {0,0}},
}

function ENT:SpecialInit()

	local health = nzRound:GetZombieHealth()
	self:SetHealth( math.ceil(nzRound:GetZombieHealth() * 2.5) or 200)

	self.BlockZCTAbility = true
	self.ZombieIgnited = true
end