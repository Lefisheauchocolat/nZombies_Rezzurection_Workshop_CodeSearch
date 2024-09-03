AddCSLuaFile()

ENT.Base = "nz_zombie_walker_jup"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.EyeColorTable = {
	[0] = Material("models/moo/codz/t10_zombies/jup/xmaterial_e739cc7eabf07b.vmt"),
}

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_armored_heavy.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
}

ENT.MetalImpactSounds = {
	Sound("physics/metal/metal_solid_impact_bullet1.wav"),
	Sound("physics/metal/metal_solid_impact_bullet2.wav"),
	Sound("physics/metal/metal_solid_impact_bullet3.wav"),
	Sound("physics/metal/metal_solid_impact_bullet4.wav"),
}

ENT.ArmorBreakSounds = {
	Sound("nz_moo/zombies/fly/armor_break/break_00.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_01.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_02.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_03.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_04.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_05.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_06.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_07.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_08.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_09.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_10.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_11.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_12.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_13.mp3"),
}

if SERVER then
	function ENT:SpecialInit()
		self:SetBodygroup(2,0) -- Helmet
		self:SetBodygroup(3,0) -- Torso
		self:SetBodygroup(4,0) -- Left Arm
		self:SetBodygroup(5,0) -- Right Arm
		self:SetBodygroup(6,0) -- Left Leg
		self:SetBodygroup(7,0) -- Right Leg

		self.HelmetHP 	= self:Health() * 2
		self.TorsoHP 	= self:Health() * 2
		self.LArmHP 	= self:Health() * 2
		self.RArmHP 	= self:Health() * 2
		self.LLegHP 	= self:Health() * 2
		self.RLegHP 	= self:Health() * 2

		self.HasHelmet 	= true
		self.HasTorso 	= true
		self.HasLArm 	= true
		self.HasRArm 	= true
		self.HasLLeg 	= true
		self.HasRLeg 	= true
	end

	function ENT:OnInjured(dmginfo)
		local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
		local hitforce 		= dmginfo:GetDamageForce()
		local hitpos 		= dmginfo:GetDamagePosition()
		local attacker 		= dmginfo:GetAttacker()
		local inflictor 	= dmginfo:GetInflictor()
		local dmgtype 		= dmginfo:GetDamageType()
		local damage 		= dmginfo:GetDamage()

		if !self.SpawnProtection and !self.IsMooSpecial and self.CanGib then

			--[[ CRAWLER CREATION FROM DAMAGE ]]--
			if (self:CrawlerDamageTest(dmginfo)) and self:Alive() then
				local lleg = self:LookupBone("j_ball_le")
				local rleg = self:LookupBone("j_ball_ri")

				local llegpos = self:GetBonePosition(lleg)
				local rlegpos = self:GetBonePosition(rleg)

				if (lleg and !self.LlegOff) and (hitpos:DistToSqr(llegpos) < 35^2) and !self.HasLLeg then
					self:GibLegL()
				end
				if (rleg and !self.RlegOff) and (hitpos:DistToSqr(rlegpos) < 35^2) and !self.HasRLeg then
					self:GibLegR()
				end
			end

			--[[ GIBBING SYSTEM ]]--
			if self:GibForceTest(hitforce) then
				local head = self:LookupBone("j_head")
				local larm = self:LookupBone("j_elbow_le")
				local rarm = self:LookupBone("j_elbow_ri")
				
				if (larm and hitgroup == HITGROUP_LEFTARM) and !self.IsMooSpecial and !self.HasGibbed and !self.HasLArm then
					self:GibArmL()
				end

				if (rarm and hitgroup == HITGROUP_RIGHTARM) and !self.IsMooSpecial and !self.HasGibbed and !self.HasRArm then
					self:GibArmR()
				end
			end

			--[[ STUMBLING/STUN ]]--
			if CurTime() > self.LastStun then -- The code here is kinda bad tbh, and in turn it does weird shit because of it.
				-- Moo Mark 7/17/23: Alright... We're gonna try again.
				if self.Dying then return end
				if !self:Alive() then return end
				if dmginfo:IsDamageType(DMG_MISSILEDEFENSE) 
					or self:GetSpecialAnimation() 
					or self:GetCrawler() 
					or self:GetIsBusy() 
					or self.ShouldCrawl 
					then return end

				-- 11/1/23: Have to double check the CurTime() > self.LastStun in order to stop the Zombie from being able to stumble two times in a row.
				if !self.IsBeingStunned and !self:GetSpecialAnimation() then
					if hitgroup == HITGROUP_HEAD and CurTime() > self.LastStun and !self.HasHelmet then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.HeadPainSequences[math.random(#self.HeadPainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end

					if hitgroup == HITGROUP_LEFTARM and CurTime() > self.LastStun and !self.HasLArm then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.LeftPainSequences[math.random(#self.LeftPainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end

					if hitgroup == HITGROUP_RIGHTARM and CurTime() > self.LastStun and !self.HasRArm then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.RightPainSequences[math.random(#self.RightPainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
					if (self.LlegOff or self.RlegOff) and !self.HasBeenCrippled and (!self.HasLLeg or !self.HasRLeg) then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.HasBeenCrippled = true
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.CrawlerPainSequences[math.random(#self.CrawlerPainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
					if self:CrawlerForceTest(hitforce) and CurTime() > self.LastStun and !self.HasTorso then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.PainSequences[math.random(#self.PainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
				end
			end
		end
	end

	local resist = {
		[DMG_CLUB] = true,
		[DMG_SLASH] = true,
		[DMG_CRUSH] = true,
		[DMG_GENERIC] = true,

		[DMG_BULLET] = true,

		[DMG_BLAST] = true,
		[DMG_BLAST_SURFACE] = true,
	}

	function ENT:PostTookDamage(dmginfo)
		local attacker = dmginfo:GetAttacker()
		local inflictor = dmginfo:GetInflictor()

		local dmgtype = dmginfo:GetDamageType()
		local damage = dmginfo:GetDamage()

		local hitpos = dmginfo:GetDamagePosition()
		local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
		local hitforce = dmginfo:GetDamageForce()

		local insta = nzPowerUps:IsPowerupActive("insta") -- Don't apply the damage reduction if insta kill is active.

		--[[ Armor ]]--
		if !insta and resist[dmgtype] then
			-- Head
			if hitgroup == HITGROUP_HEAD and self.HasHelmet then
				if self.HelmetHP > 0 then

					self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
					ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 10)

					self.HelmetHP = self.HelmetHP - damage

					dmginfo:ScaleDamage(0.015)
				else
					self.HasHelmet = false
					self:SetBodygroup(2,1)

					self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)
					attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)
					ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 10)

					if !self.IsBeingStunned and !self:GetSpecialAnimation() then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.HeadPainSequences[math.random(#self.HeadPainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
				end
			end

			-- Torso
			if (hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH or hitgroup == HITGROUP_GENERIC) and self.HasTorso then
				if self.TorsoHP > 0 then

					self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
					ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 9)

					self.TorsoHP = self.TorsoHP - damage
					dmginfo:ScaleDamage(0.015)
				else
					self.HasTorso = false
					self:SetBodygroup(3,1)

					self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)
					attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)
					ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 9)

					if !self.IsBeingStunned and !self:GetSpecialAnimation() then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.PainSequences[math.random(#self.PainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
				end
			end

			-- Left Arm
			if hitgroup == HITGROUP_LEFTARM and self.HasLArm then
				if self.LArmHP > 0 then

					self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
					ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 5)

					self.LArmHP = self.LArmHP - damage

					dmginfo:ScaleDamage(0.015)
				else
					self.HasLArm = false
					self:SetBodygroup(4,1)

					self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)
					attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)
					ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 5)

					if !self.IsBeingStunned and !self:GetSpecialAnimation() then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.LeftPainSequences[math.random(#self.LeftPainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
				end
			end

			-- Right Arm
			if hitgroup == HITGROUP_RIGHTARM and self.HasRArm then
				if self.RArmHP > 0 then

					self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
					ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 6)

					self.RArmHP = self.RArmHP - damage

					dmginfo:ScaleDamage(0.015)
				else
					self.HasRArm = false
					self:SetBodygroup(5,1)

					self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)
					attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)
					ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 6)

					if !self.IsBeingStunned and !self:GetSpecialAnimation() then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.RightPainSequences[math.random(#self.RightPainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
				end
			end

			-- Left Leg
			if hitgroup == HITGROUP_LEFTLEG and self.HasLLeg then
				if self.LLegHP > 0 then

					self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
					ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 7)

					self.LLegHP = self.LLegHP - damage

					dmginfo:ScaleDamage(0.015)
				else
					self.HasLLeg = false
					self:SetBodygroup(6,1)

					self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)
					attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)
					ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 7)

					if !self.IsBeingStunned and !self:GetSpecialAnimation() then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.PainSequences[math.random(#self.PainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
				end
			end

			-- Right Leg
			if hitgroup == HITGROUP_RIGHTLEG and self.HasRLeg then
				if self.RLegHP > 0 then

					self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
					ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 8)

					self.RLegHP = self.RLegHP - damage

					dmginfo:ScaleDamage(0.015)
				else
					self.HasRLeg = false
					self:SetBodygroup(7,1)

					self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)
					attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)
					ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 8)

					if !self.IsBeingStunned and !self:GetSpecialAnimation() then
						if self.PainSounds and !self:GetDecapitated() then
							self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
							self.NextSound = CurTime() + self.SoundDelayMax
						end
						self.IsBeingStunned = true
						self:DoSpecialAnimation(self.PainSequences[math.random(#self.PainSequences)], true, true)
						self.IsBeingStunned = false
						self.LastStun = CurTime() + 8
						self:ResetMovementSequence()
					end
				end
			end
		end
	end
end