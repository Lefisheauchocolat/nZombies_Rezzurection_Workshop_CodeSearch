AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Cryptid Scorpion"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then

	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/iw6_aliens/spitter/mtl_alien_spitter_body_a.vmt"),
		[1] = Material("models/moo/codz/iw6_aliens/spitter/mtl_alien_spitter_sacks_a.vmt"),
		[2] = Material("models/moo/codz/iw6_aliens/minion/mtl_alien_brute_eye.vmt")
	}

	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()

		if self.EyeColorTable then
			-- Go through every material given and set the color.
			local eyecolor = nzMapping.Settings.zombieeyecolor
			local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()

			for k,v in pairs(self.EyeColorTable) do
				v:SetVector("$emissiveblendtint", col)
			end
		end
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true
ENT.IsMooCryptid = true

ENT.SoundDelayMin = 2
ENT.SoundDelayMax = 4

ENT.AttackDamage 			= 20
ENT.HeavyAttackDamage 		= 50
ENT.MaxYawRate 				= 720

ENT.Models = {
	{Model = "models/moo/_codz_ports/iw6/aliens/moo_codz_iw6_alien_scorpion.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_ai_alien_out_floor_grate_01"}
local spawnfast = {"nz_ai_alien_spawn_underground"}

ENT.DeathSequences = {
	"nz_ai_alien_drone_death_01",
	"nz_ai_alien_drone_death_lupbody_l",
	"nz_ai_alien_drone_death_rupbody_r",
}

ENT.ElectrocutionSequences = {
	"nz_ai_alien_drone_death_01",
	"nz_ai_alien_drone_death_lupbody_l",
	"nz_ai_alien_drone_death_rupbody_r",
}

ENT.BarricadeTearSequences = {
	"nz_ai_alien_attack_swipe_01",
	"nz_ai_alien_attack_swipe_02",
	"nz_ai_alien_attack_swipe_03",
}

local AttackSequences = {
	--{seq = "nz_ai_alien_attack_swipe_01"},
	--{seq = "nz_ai_alien_attack_swipe_02"},
	{seq = "nz_ai_alien_attack_swipe_03"},
}

local JumpSequences = {
	{seq = "nz_ai_alien_traverse_mantle_36"},
}
local ambsounds = {
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_jump_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_jump_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_jump_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_jump_04.mp3"),
}

ENT.IdleSequence = "nz_ai_alien_spitter_idle_01"
ENT.IdleSequenceAU = "nz_ai_alien_spitter_idle_02"
ENT.NoTargetIdle = "nz_ai_alien_spitter_idle_02"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_ai_alien_spitter_walk",
			},
			
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {ambsounds},
		},
	}},
}

ENT.ZombieLandSequences = {
	"nz_ai_alien_drone_land",
}

ENT.BiteSequences = {
	"nz_ai_alien_attack_bite_01", -- Nom
	"nz_ai_alien_attack_bite_02",
	"nz_ai_alien_attack_bite_03",
}

ENT.DodgeSequences = {
	"nz_ai_alien_move_side_l",
	"nz_ai_alien_move_side_l_v2",
	"nz_ai_alien_move_side_r",
	"nz_ai_alien_move_side_r_v2",
}

ENT.DodgeBackSequences = {
	"nz_ai_alien_move_back_crawl",
	"nz_ai_alien_move_back_hop",
	"nz_ai_alien_move_back_jump",
}

ENT.StumbleSequences = {
	"nz_ai_alien_run_pain_llowbody_l_heavy",
	"nz_ai_alien_run_pain_llowbody_l_light",
	"nz_ai_alien_run_pain_rupbody_r_heavy",
	"nz_ai_alien_run_pain_rupbody_r_light",
}

ENT.CustomSlowTurnAroundSequences = {
	"nz_ai_alien_run_to_stop_180_l",
	"nz_ai_alien_run_to_stop_180_r",
}

ENT.CustomFastTurnAroundSequences = {
	"nz_ai_alien_run_to_stop_180_l",
	"nz_ai_alien_run_to_stop_180_r",
}

ENT.IncapAttackSequences = {
	"nz_ai_alien_flare_reaction_01",
	"nz_ai_alien_flare_reaction_01_v2",
	"nz_ai_alien_flare_reaction_02",
	"nz_ai_alien_flare_reaction_02_v2",
}

ENT.TauntSequences = {
	"nz_ai_alien_drone_posture_01",
	"nz_ai_alien_drone_posture_02",
	"nz_ai_alien_drone_posture_03",
}

ENT.UndercroftSequences = {
	"nz_ai_alien_traverse_crawl_under",
	"nz_ai_alien_traverse_crawl_under",
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_death_04.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch5_swipe_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch5_swipe_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch5_swipe_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch5_swipe_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch5_swipe_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch5_swipe_06.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch5_swipe_07.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch5_swipe_08.mp3"),

	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_bite_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_bite_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_bite_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_bite_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_bite_06.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_bite_07.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_bite_08.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_01.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_02.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_03.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_04.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_05.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_06.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_pain_04.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_01a.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_01b.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_02a.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_02b.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_03a.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_03b.mp3"),
}

ENT.FootStepSounds = {
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_06.mp3"),
}

ENT.HandStepSounds = {
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_sm_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_sm_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_sm_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_sm_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_sm_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_sm_06.mp3"),
}

ENT.FlyStepSounds = {
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_mvmt_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_mvmt_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_mvmt_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_mvmt_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_mvmt_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_mvmt_06.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_mvmt_07.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_mvmt_08.mp3"),
}

ENT.JumpWhooshSounds = {
	Sound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_00.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_01.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_02.mp3"),
}

ENT.LandSounds = {
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_concrete_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_concrete_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_dirt_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_dirt_02.mp3"),
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

ENT.ShootVoxSounds = {
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_batch1_distant_attack_1.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_batch1_distant_attack_2.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_batch1_distant_attack_3.mp3"),
}

ENT.ShootSounds = {
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_fire_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_fire_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/spitter/spitter_fire_03.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		if nzRound:GetNumber() == -1 then
			self:SetRunSpeed( math.random(25, 220) )
			self:SetHealth( math.random(100, 1500) )
		else
			local speeds = nzRound:GetZombieCoDSpeeds()
			if speeds then
				self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
			else
				self:SetRunSpeed( 100 )
			end
			self:SetHealth( nzRound:GetZombieHealth() * 2 or 75 )


			local rndprog = nzRound:InProgress()
			local specialrnd = nzRound:IsSpecial()

			if rndprog and specialrnd then
				self:SetRunSpeed( math.random(36,236) )
			end

			self.Lunging = false
			self.LastLunge = CurTime() + 5

			self.ShootCoolDown = CurTime() + 3

			self.AttackSimian = math.random(3)

			self:SetModelScale(1.4, 0.001)

			self:SetCollisionBounds(Vector(-9,-9, 0), Vector(9, 9, 45))
			self:SetSurroundingBounds(Vector(-35, -35, 0), Vector(35, 35, 72))
		end
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = animation or self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	if dirt then
		local SpawnMatSound = {
			[MAT_DIRT] = "nz_moo/zombies/spawn/dirt/pfx_zm_spawn_dirt_0"..math.random(0,1)..".mp3",
			[MAT_SNOW] = "nz_moo/zombies/spawn/snow/pfx_zm_spawn_snow_0"..math.random(0,1)..".mp3",
			[MAT_SLOSH] = "nz_moo/zombies/spawn/mud/pfx_zm_spawn_mud_00.mp3",
			[0] = "nz_moo/zombies/spawn/default/pfx_zm_spawn_default_00.mp3",
		}
		SpawnMatSound[MAT_GRASS] = SpawnMatSound[MAT_DIRT]
		SpawnMatSound[MAT_SAND] = SpawnMatSound[MAT_DIRT]

		local norm = (self:GetPos()):GetNormalized()
		local tr = util.QuickTrace(self:GetPos(), norm*10, self)

		if tr.Hit then
			local finalsound = SpawnMatSound[tr.MatType] or SpawnMatSound[0]
			self:EmitSound(finalsound)
		end

		ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
	end

	if animation then
		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
		self:SetSpecialAnimation(true)
		self:SetIsBusy(true)
		
		self:PlaySequenceAndMove(animation, {gravity = grav})

		self:SetSpecialAnimation(false)
		self:SetIsBusy(false)
		self:CollideWhenPossible()
	end
end

-- Instead of making a copy of the function above, use this.
function ENT:CustomAnimEvent(a,b,c,d,e) 
	
	self.OverrideLsmall = true
	self.OverrideLLarge = true
	self.OverrideRsmall = true
	self.OverrideRLarge = true

	if e == "step_left_small" then
		self:EmitSound(self.HandStepSounds[math.random(#self.HandStepSounds)], 75)
	end
	if e == "step_right_small" then
		self:EmitSound(self.HandStepSounds[math.random(#self.HandStepSounds)], 75)
	end
	if e == "step_left_large" then
		self:EmitSound(self.FootStepSounds[math.random(#self.FootStepSounds)], 75)
		self:EmitSound(self.FlyStepSounds[math.random(#self.FlyStepSounds)], 70)
	end
	if e == "step_right_large" then
		self:EmitSound(self.FootStepSounds[math.random(#self.FootStepSounds)], 75)
		self:EmitSound(self.FlyStepSounds[math.random(#self.FlyStepSounds)], 70)
	end

	if e == "alien_body_land" then
		self:EmitSound(self.LandSounds[math.random(#self.LandSounds)], 85)
	end

	if e == "alien_jump_whoosh" then
		self:EmitSound(self.JumpWhooshSounds[math.random(#self.JumpWhooshSounds)], 85)
	end

	if e == "alien_spit" then
		local bonetag = self:LookupBone("j_jaw")

		self.Guts = ents.Create("nz_gib")
		self.Guts:SetPos(self:GetBonePosition(bonetag))
		self.Guts:Spawn()

		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)

		local phys = self.Guts:GetPhysicsObject()
		local target = self:GetTarget()
		local movementdir
		if IsValid(phys) and IsValid(target) then

			phys:SetVelocity(self.Guts:getvel(target:EyePos() - Vector(0,0,7), self:EyePos(), 0.95))
		end
	end

	if e == "alien_spitter_dst_atk" then
		self:EmitSound(self.ShootVoxSounds[math.random(#self.ShootVoxSounds)], 100, math.random(85, 105), 1, 2)
	end

	if e == "alien_spitter_atk" then
		local bonetag = self:GetBonePosition(self:LookupBone("j_tail_7_dn"))

		self:EmitSound(self.ShootSounds[math.random(#self.ShootSounds)],80,100)

		self:Retarget()

		local target = self:GetTarget()

		if IsValid(target) then

			ParticleEffect("spit_impact_yellow", bonetag, Angle(0,0,0), nil) 
			self.Goop = ents.Create("nz_proj_alien_scorpion_shot")
			self.Goop:SetPos(bonetag)
			self.Goop:Spawn()
			self.Goop:Launch(((target:EyePos() - Vector(0,0,7)) - self.Goop:GetPos()):GetNormalized())
		end

	end
end

function ENT:AI()
	local target = self:GetTarget()

	if IsValid(target) and target:IsPlayer() and !self:IsAttackBlocked() then

		-- SPITTING BARS
		if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() and CurTime() > self.ShootCoolDown then
			if !self:TargetInRange(100) and !self:IsAttackBlocked() and self:TargetInRange(750) then
				self:FaceTowards(target:GetPos())
				self:DoSpecialAnimation("nz_ai_alien_spitter_attack_tail")

				self.ShootCoolDown = CurTime() + math.Rand(4, 9)
			end
		end

		-- DODGE
		if self:TargetInRange(500) then
			if !self:IsAimedAt() then return end
			if self.IsMooBossZombie or self.NZBossType then return end
			if nzPowerUps:IsPowerupActive("timewarp") then return end -- OR! If Time Distortion:tm: is active

			if !self.AttackIsBlocked and math.random(15) <= 10 and CurTime() > self.LastSideStep then
				if !self:IsAimedAt() then return end
				if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
					local seq = self.DodgeSequences[math.random(#self.DodgeSequences)]
					-- By default, try to sidestep.


					if !self:SequenceHasSpace(seq) then
						seq = self.DodgeBackSequences[math.random(#self.DodgeBackSequences)]
						-- Only roll if there isn't space for a sidestep.
					end
						
					if self:SequenceHasSpace(seq) and self:LookupSequence(seq) > 0 then
						self:DoSpecialAnimation(seq, true, true)
						-- If there isn't space at all, don't dodge.
					end
					self.LastSideStep = CurTime() + 3
				end
			end
		end

	end
end

function ENT:OnInjured(dmginfo)
		local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
		local hitforce 		= dmginfo:GetDamageForce()
		local hitpos 		= dmginfo:GetDamagePosition()
		local inflictor 	= dmginfo:GetInflictor()

		if !self.SpawnProtection then

		--[[ STUMBLING/STUN ]]--
		if CurTime() > self.LastStun then
			if self.Dying then return end
			if !self:Alive() then return end
			if dmginfo:IsDamageType(DMG_MISSILEDEFENSE) 
				or self:GetSpecialAnimation() 
				or self:GetIsBusy() 
				then return end

			if !self.IsBeingStunned and !self:GetSpecialAnimation() then
				if hitgroup == HITGROUP_HEAD and CurTime() > self.LastStun then
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
				if self:CrawlerForceTest(hitforce) and CurTime() > self.LastStun then
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

function ENT:PerformDeath(dmgInfo)	
	self.Dying = true

	if self:GetSpecialAnimation() then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("spit_impact_orange", self:GetPos() + Vector(0,0,25), Angle(0,0,0), nil) 

			self:Remove()
		end
	else
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then
			self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("spit_impact_orange", self:GetPos() + Vector(0,0,25), Angle(0,0,0), nil) 
			
			self:Remove()
		end
	end)
end
