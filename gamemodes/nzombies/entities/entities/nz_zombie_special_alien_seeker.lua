AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Cryptid Seeker"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then

	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/iw6_aliens/minion/mtl_alien_minion_body_a.vmt"),
		[1] = Material("models/moo/codz/iw6_aliens/minion/mtl_alien_minion_sacks_a.vmt"),
		[2] = Material("models/moo/codz/iw6_aliens/minion/mtl_alien_brute_eye.vmt"),
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
	{Model = "models/moo/_codz_ports/iw6/aliens/moo_codz_iw6_alien_seeker.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_ai_alien_out_floor_grate_01"}
local spawnfast = {"nz_ai_alien_spawn_underground"}

ENT.DeathSequences = {
	"nz_ai_alien_minion_explode",
}

ENT.ElectrocutionSequences = {
	"nz_ai_alien_minion_explode",
}

ENT.BarricadeTearSequences = {
	"nz_ai_alien_attack_swipe_01",
	"nz_ai_alien_attack_swipe_02",
	"nz_ai_alien_attack_swipe_03",
}

local AttackSequences = {
	{seq = "nz_ai_alien_minion_explode"},
}

local JumpSequences = {
	{seq = "nz_ai_alien_traverse_mantle_36"},
}
local ambsounds = {
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_run_chatter_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_run_chatter_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_run_chatter_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_run_chatter_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_run_chatter_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_run_chatter_06.mp3"),
}

ENT.IdleSequence = "nz_ai_alien_drone_idle_01"
ENT.IdleSequenceAU = "nz_ai_alien_drone_idle_02"
ENT.NoTargetIdle = "nz_ai_alien_drone_idle_03"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				--"nz_ai_alien_minion_walk",
				"nz_ai_alien_minion_walk_fast",
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
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_explo_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_explo_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_explo_death_03.mp3"),
}

ENT.PreExplodeSounds = {
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_pre_explo_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_pre_explo_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_pre_explo_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_pre_explo_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_pre_explo_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/minion_pre_explo_06.mp3"),
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
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_pain_08.mp3"),
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
	Sound("nz_moo/zombies/vox/_aliens/minion/minion_batch2_explo_body_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/minion/minion_batch2_explo_body_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/minion/minion_batch2_explo_body_05.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/gibs/bodyfall/fall_00.mp3"),
	Sound("nz_moo/zombies/gibs/bodyfall/fall_01.mp3"),
	Sound("nz_moo/zombies/gibs/bodyfall/fall_02.mp3"),
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

			local eyecolor = nzMapping.Settings.zombieeyecolor

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

			self.AttackSimian = math.random(3)

			self:SetModelScale(0.99, 0.001)

			--util.SpriteTrail(self, 2, Color(eyecolor.r,eyecolor.g,eyecolor.b), true, 45, 20, 0.5, 1 / 40 * 0.3, "materials/particle/beam_smoke_01")

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

	if e == "alien_minion_explode" then
		if !self.DIE then
			self.DIE = true
			self:TakeDamage(self:Health() + 666, self, self)
		end
	end
end

function ENT:AI()
	local target = self:GetTarget()

	if IsValid(target) and target:IsPlayer() and !self:IsAttackBlocked() then

		-- SPITTING BARS
		if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
			
			local nav = navmesh.GetNearestNavArea(self:GetTarget():GetPos(), false, 65, false, true, -2) -- Check for a nav square, if theres one near by.
			local ply = self:GetTarget():IsOnGround() -- Also make sure the target is on the ground. People who are in the air are probably falling, diving with phd, or are trying to be an action hero. So we don't wanna accidentally think they're unreachable because of that.

			if IsValid(nav) then
				self.ThrowGuts = false -- If there a nav found then we stop or do nothing.
			else
				if ply then -- Otherwise, if the target is no where near a nav square and is on the ground...
					self.ThrowGuts = true -- THROW SHIT AT THEM
				end
			end

			if self.ThrowGuts then
				self:TempBehaveThread(function(self)
					
					self:SetSpecialAnimation(true)
					self:PlaySequenceAndMove("nz_ai_alien_attack_spit", 1, self.FaceEnemy)
					self:SetSpecialAnimation(false)
				end)
			end
		end

		-- LUNGE
		--[[if CurTime() > self.LastLunge and self:TargetInRange(145) then
			-- Lunge does more damage than a normal attack.
			self:TempBehaveThread(function(self)
				self:FaceTowards(target:GetPos())

				self:SetSpecialAnimation(true)
				self:PlaySequenceAndMove(self.BiteSequences[math.random(#self.BiteSequences)], 1)
				self:SetSpecialAnimation(false)	
			end)
			self.LastLunge = CurTime() + 2
		end]]

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
			if !self:IsAlive() then return end
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

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	if IsValid(self) then
		self:Explode(85)
		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("spit_impact_orange", self:GetPos() + Vector(0,0,25), Angle(0,0,0), nil) 

		self:Remove()
	end
end
