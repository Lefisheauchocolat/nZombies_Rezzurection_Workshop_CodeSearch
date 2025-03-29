AddCSLuaFile()

ENT.Base = "nz_zombie_walker_quartz_hazmat"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Toxic Zombie"
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
			if (!self.Play_SFX or !IsValid(self.Play_SFX)) then
				self.Play_SFX = "nz_moo/zombies/vox/_toxic/breathe.wav"
				self:EmitSound(self.Play_SFX, 70, 77, 1, 3)
			end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_smoker_aura", 4, 3)
			end

			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 0
				elight.g = 255
				elight.b = 25
				elight.brightness = 5
				elight.Decay = 1000
				elight.Size = 50
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end
	end
	function ENT:DrawEyeGlow()
		local eyeglow =  Material("nz_moo/sprites/moo_glow1")
		local eyeColor = Color(0,255,50)

		if eyeColor == nocolor then return end

		local latt = self:LookupAttachment("lefteye")
		local ratt = self:LookupAttachment("righteye")

		if latt == nil then return end
		if ratt == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)

		if leye == nil then return end
		if reye == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.49
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.49

		if lefteyepos and righteyepos then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 5, 5, eyeColor)
			render.DrawSprite(righteyepos, 5, 5, eyeColor)
		end
	end
end

ENT.MinSoundPitch = 65
ENT.MaxSoundPitch = 70

ENT.SoundDelayMin = 8
ENT.SoundDelayMax = 10

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/terminus/moo_codz_t10_zmb_zombie_hazmat_1.mdl", Skin = 2, Bodygroups = {0,0}},
}

ENT.ExplodeSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/gibs/bodyfall/fall_00.mp3"),
	Sound("nz_moo/zombies/gibs/bodyfall/fall_01.mp3"),
	Sound("nz_moo/zombies/gibs/bodyfall/fall_02.mp3"),
}

function ENT:SpecialInit()

	local fuckercloud = ents.Create("nova_gas_cloud_decay")
	local bone = self:LookupBone("j_spineupper")
	local pos = self:GetBonePosition(bone)
	fuckercloud:SetPos(pos)
	fuckercloud:SetAngles(Angle(0,0,0))
	fuckercloud:SetParent(self)
	fuckercloud:Spawn()

	local speed = math.random(71,185)
	self:SetRunSpeed(speed)
	self:SpeedChanged()
end

function ENT:ToxicExplode()
	if !self.Exploded then
		self.Exploded = true

		local bone = self:GetBonePosition(self:LookupBone("j_spineupper"))

		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("acidbug_spit_impact", bone, Angle(0,0,0), nil) 

		local fuckercloud = ents.Create("nz_ent_toxic_cloud")
		fuckercloud:SetPos(self:GetPos())
		fuckercloud:SetAngles(Angle(0,0,0))
		fuckercloud:Spawn()

		self:Remove()
	end
end

function ENT:PostDeath(dmginfo) 
	local damagetype = dmginfo:GetDamageType()
	if damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		if self.LaunchSounds then
			self:PlaySound(self.LaunchSounds[math.random(#self.LaunchSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.Launched = true
		end
		self:ToxicExplode()
	end
	if damagetype == DMG_REMOVENORAGDOLL then
		self:ToxicExplode()
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or !self.DeathSequences then
		if self.DeathSounds and !self.Launched then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		end
		self:ToxicExplode()
	end
end

-- Instead of making a copy of the function above, use this.
function ENT:CustomAnimEvent(a,b,c,d,e) 
	self.OverrideDDoll = true 		-- Overrides death_ragdoll

	if e == "death_ragdoll" then
		self:ToxicExplode()
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_toxic/breathe.wav")
end
