AddCSLuaFile()

ENT.Base = "nz_zombie_walker_exo_3arc"
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
				self.Draw_FX = CreateParticleSystem(self, "zmb_exo_blinker_aura", 4, 9)
			end

			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 50
				elight.g = 100
				elight.b = 255
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
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo_blinker.mdl", Skin = 0, Bodygroups = {0,0}},
}

function ENT:SpecialInit()

	local health = nzRound:GetZombieHealth()
	self:SetHealth( math.ceil(nzRound:GetZombieHealth() * 1.15) or 200)

	-- Since this enemy just acts like the blue flame zombies, we're just gonna block the zct code from ever running.
	self.BlockZCTAbility = true

	self.ExoCloakCoolDown = CurTime() + math.Rand(1, 4)
	self.ZCTCloaked = false
	self.ExoCloakActive = false

	util.SpriteTrail(self, 9, Color(255, 255, 255, 5), true, 50, 1, 0.85, 1 / 40 * 0.3, "materials/trails/smoke")
end

function ENT:AI()
	if CurTime() > self.ExoCloakCoolDown then
		self:ExoBlink()
	end
end

function ENT:OnThink()

	if not IsValid(self) then return end

	if (self:IsAttacking() or self:GetSpecialAnimation()) and self.ExoCloakActive and self.ZCTCloaked then
		self:ExoBlink()
	end

	if SERVER and self:IsAlive() and self:IsDecapitated() then // Decapitation bleedout
		if not self.nextbleedtick then
			self.nextbleedtick = CurTime() + 0.25
			self.bleedtickcount = 0
		end

		if self.nextbleedtick and self.nextbleedtick < CurTime() then
			ParticleEffectAttach(self.Blood[self.BloodType].HeadGibFX, 4, self, 10)

			self.nextbleedtick = CurTime() + math.Rand(0.15, 0.4)
			self.bleedtickcount = self.bleedtickcount + 1
		end

		if self.bleedtickcount and self.bleedtickcount > 10 then
			print("Goodbye Luigi.")
			self:TakeDamage(self:Health() + 666, Entity(0), Entity(0))
		end
	end
end

function ENT:ExoBlink()
	if !self.ExoCloakActive and !self.ZCTCloaked then

		self.ZCTCloaked = true
		self.ExoCloakActive = true
		if !self:GetCrawler() then
			self.UseMovementSequenceOverride = true
		end
		self:SetMaterial( "models/props_c17/fisheyelens" )

		self:EmitSound("nz_moo/zombies/vox/_exo/abilities/blink/disappear.mp3", 90)
		ParticleEffect("bo3_dg4_slam_glow",self:GetPos()+Vector(0,0,5),self:GetAngles(),self)
		ParticleEffect("bo3_dg4_slam_distort",self:GetPos()+Vector(0,0,5),self:GetAngles(),self)
	elseif self.ExoCloakActive and self.ZCTCloaked then
		self.ZCTCloaked = false
		self.ExoCloakActive = false
		self.UseMovementSequenceOverride = false
		self:SetMaterial( "" )

		self:EmitSound("nz_moo/zombies/vox/_exo/abilities/blink/appear.mp3", 90)
		ParticleEffect("bo3_dg4_slam_glow",self:GetPos()+Vector(0,0,5),self:GetAngles(),self)
		ParticleEffect("bo3_dg4_slam_distort",self:GetPos()+Vector(0,0,5),self:GetAngles(),self)
	end
	self.ExoCloakCoolDown = CurTime() + math.Rand(2, 6)
end

function ENT:MovementSequenceOverride()
	if self.ExoCloakActive and self.TurnedMovementSequence then
		self:ResetSequence(self.TurnedMovementSequence)
		self.CurrentSeq = self.TurnedMovementSequence
	end
end
