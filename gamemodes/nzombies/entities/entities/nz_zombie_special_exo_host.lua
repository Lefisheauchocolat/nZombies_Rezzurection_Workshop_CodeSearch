AddCSLuaFile()

ENT.Base = "nz_zombie_walker_exo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Host Zombie"
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
				elight.brightness = 3
				elight.Decay = 1000
				elight.Size = 50
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end
	end
end

ENT.Models = {
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/special/moo_codz_s1_zom_special_host.mdl", Skin = 0, Bodygroups = {0,0}},
}

function ENT:SpecialInit()

	local health = nzRound:GetZombieHealth()
	self:SetHealth( math.ceil(nzRound:GetZombieHealth() * 0.85) or 200)

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
	
	self.MinSoundPitch = 50
	self.MaxSoundPitch = 55

	self.CanGib = false
end

