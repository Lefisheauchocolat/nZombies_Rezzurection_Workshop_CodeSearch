AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.PrintName = "Doppleghast"
ENT.Spawnable = true

if CLIENT then
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")
	local defaultColor = Color(255, 75, 0, 255)

	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t10_zombies/zm/c_t10_zmb_zombie_base_body_01_eyes.vmt"),
		[1] = Material("models/moo/codz/t10_zombies/zm/xmaterial_7bc047c19822a5.vmt"),
	}

	function ENT:DrawEyeGlow()
		local eyeColor = nzMapping.Settings.zombieeyecolor
		local nocolor = Color(0,0,0)

		if self.EyeColorTable then
			-- Go through every material given and set the color.
			local eyecolor = nzMapping.Settings.zombieeyecolor
			local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()

			for k,v in pairs(self.EyeColorTable) do
				v:SetVector("$emissiveblendtint", col)
			end
		end
		
		if eyeColor == nocolor then return end


		local latt = self:LookupAttachment("l_lefteye")
		local ratt = self:LookupAttachment("l_righteye")
		local latt2 = self:LookupAttachment("r_lefteye")
		local ratt2 = self:LookupAttachment("r_righteye")

		if latt == nil then return end
		if ratt == nil then return end
		if latt2 == nil then return end
		if ratt2 == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)
		local leye2 = self:GetAttachment(latt2)
		local reye2 = self:GetAttachment(ratt2)

		if leye == nil then return end
		if reye == nil then return end
		if leye2 == nil then return end
		if reye2 == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.49
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.49
		local righteyepos2 = leye2.Pos + leye2.Ang:Forward()*0.49
		local lefteyepos2 = reye2.Pos + reye2.Ang:Forward()*0.49

		if lefteyepos and righteyepos and righteyepos2 and lefteyepos2 then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 5, 5, eyeColor)
			render.DrawSprite(righteyepos, 5, 5, eyeColor)
			render.DrawSprite(lefteyepos2, 5, 5, eyeColor)
			render.DrawSprite(righteyepos2, 5, 5, eyeColor)
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true
ENT.IsMiniBoss = true

ENT.SoundDelayMin = 2
ENT.SoundDelayMax = 6

ENT.AttackRange 			= 115
ENT.DamageRange 			= 115
ENT.AttackDamage 			= 25
ENT.HeavyAttackDamage 		= 75

ENT.ResistWW 				= true
ENT.WWResistDamage 			= 0.25 		

ENT.BehindSoundDistance = 0

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/zm/moo_codz_t10_ghoul.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_base_ghoul_arrive_01"}

ENT.DeathSequences = {
	"nz_base_ghoul_death_01",
	"nz_base_ghoul_death_02",
	"nz_base_ghoul_death_03",
}

ENT.BarricadeTearSequences = {
	"nz_base_ghoul_stand_attack_01",
	"nz_base_ghoul_stand_attack_02",
	"nz_base_ghoul_stand_attack_03",
	"nz_base_ghoul_stand_attack_04",
}

local AttackSequences = {
	{seq = "nz_base_ghoul_stand_attack_01"},
	{seq = "nz_base_ghoul_stand_attack_02"},
	{seq = "nz_base_ghoul_stand_attack_03"},
	{seq = "nz_base_ghoul_stand_attack_04"},
}

local WalkAttackSequences = {
	{seq = "nz_base_ghoul_walk_attack_01"},
	{seq = "nz_base_ghoul_walk_attack_02"},
}

local RunAttackSequences = {
	{seq = "nz_base_ghoul_run_attack_01"},
	{seq = "nz_base_ghoul_run_attack_02"},
}

local SprintAttackSequences = {
	{seq = "nz_base_ghoul_sprint_attack_01"},
}

local JumpSequences = {
	{seq = "nz_base_ghoul_walk_mantle_over_48"},
}
local ambsounds = {
	Sound("nz_moo/zombies/vox/_ghoul/lurk/vox_ghoul_lurk_00.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/lurk/vox_ghoul_lurk_01.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/lurk/vox_ghoul_lurk_02.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/lurk/vox_ghoul_lurk_03.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/lurk/vox_ghoul_lurk_04.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_ghoul/run/vox_ghoul_run_00.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/run/vox_ghoul_run_01.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/run/vox_ghoul_run_02.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/run/vox_ghoul_run_03.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/run/vox_ghoul_run_04.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/run/vox_ghoul_run_05.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/run/vox_ghoul_run_06.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/run/vox_ghoul_run_07.mp3"),
}


ENT.ZombieStunInSequence = "nz_base_ghoul_stun_in"
ENT.ZombieStunOutSequence = "nz_base_ghoul_stun_out"

ENT.SparkySequences = {
	"nz_base_ghoul_stun_loop",
	"nz_base_ghoul_stun_loop",
	"nz_base_ghoul_stun_loop",
	"nz_base_ghoul_stun_loop",
	"nz_base_ghoul_stun_loop",
}

ENT.IdleSequence = "nz_base_ghoul_idle"
ENT.IdleSequenceAU = "nz_base_ghoul_idle"
ENT.NoTargetIdle = "nz_base_ghoul_idle"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_ghoul_walk_01",
				"nz_base_ghoul_walk_02",
				"nz_base_ghoul_walk_03",
				"nz_base_ghoul_walk_04",
			},
			
			StandAttackSequences = {AttackSequences},
			AttackSequences = {WalkAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {ambsounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_ghoul_run_01",
				"nz_base_ghoul_run_02",
				"nz_base_ghoul_run_03",
				"nz_base_ghoul_run_04",
			},
			
			StandAttackSequences = {AttackSequences},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {ambsounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_ghoul_sprint_01",
				"nz_base_ghoul_sprint_02",
				"nz_base_ghoul_sprint_03",
				"nz_base_ghoul_sprint_04",
				"nz_base_ghoul_sprint_05",
				"nz_base_ghoul_sprint_06",
			},
			
			StandAttackSequences = {AttackSequences},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}},
}

ENT.CustomMantleOver48 = {
	"nz_base_ghoul_walk_mantle_over_48",
}

ENT.CustomMantleOver72 = {
	"nz_base_ghoul_walk_mantle_over_72",
}

ENT.CustomMantleOver96 = {
	"nz_base_ghoul_walk_mantle_over_96",
}

ENT.CustomMantleOver128 = {
	"nz_base_ghoul_walk_mantle_over_128",
}

ENT.ZombieLandSequences = {
	"nz_base_ghoul_land",
}

ENT.ZombieLedgeClimbLoopSequences = {
	"nz_base_ghoul_climb_loop",
}
ENT.ZombieLedgeClimbSequences = {
	"nz_base_ghoul_climb_finish", -- Will only ever be one, for easy overridding.
}
ENT.RangedAttackSequences = {
	"nz_base_ghoul_ranged_attack_01",
	"nz_base_ghoul_ranged_attack_02",
}

ENT.GhoulDodgeSequences = {
	"nz_base_ghoul_dodge_left_01",
	"nz_base_ghoul_dodge_right_01",
}

ENT.PainSequences = {
	"nz_base_ghoul_run_stagger_01",
	"nz_base_ghoul_run_stagger_02",
}

ENT.FatalSequences = {
	"nz_base_ghoul_knockdown_b_01",
	"nz_base_ghoul_knockdown_f_01",
	"nz_base_ghoul_knockdown_l_01",
	"nz_base_ghoul_knockdown_r_01",
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_ghoul/death/vox_ghoul_death.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_ghoul/attack/vox_ghoul_attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/attack/vox_ghoul_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/attack/vox_ghoul_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/attack/vox_ghoul_attack_04.mp3"),
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
	Sound("nz_moo/zombies/vox/_ghoul/pain/vox_ghoul_pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/pain/vox_ghoul_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/pain/vox_ghoul_pain_02.mp3"),
}

ENT.DodgeSounds = {
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_00.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_01.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_02.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_03.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_04.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_05.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_06.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_07.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/dodge/vox_ghoul_dodge_08.mp3"),
}

ENT.DodgeSWTSounds = {
	Sound("nz_moo/zombies/vox/_ghoul/fly/fly_ghoul_dodge_00.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/fly/fly_ghoul_dodge_01.mp3"),
}

ENT.FootStepSounds = {
	Sound("nz_moo/zombies/vox/_ghoul/fly/fly_ghoul_footstep_00.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/fly/fly_ghoul_footstep_01.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/fly/fly_ghoul_footstep_02.mp3"),
}

ENT.LandSounds = {
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_dirt_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_dirt_02.mp3"),
}

ENT.ExplodeSounds = {
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_02.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

ENT.RangedAttackSounds = {
	Sound("nz_moo/zombies/vox/_ghoul/fly/fly_ghoul_ranged_attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_ghoul/fly/fly_ghoul_ranged_attack_01.mp3"),
}

ENT.RangedAttackFireSounds = {
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_00.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_01.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_02.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_03.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		local speeds = nzRound:GetZombieCoDSpeeds()
		
		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(2250)
			self:SetMaxHealth(2250)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetZombieHealth() * 6, 100, 360000))
				self:SetMaxHealth(math.Clamp(nzRound:GetZombieHealth() * 6, 100, 360000))
			else
				self:SetHealth(2250)
				self:SetMaxHealth(2250)	
			end
		end

		if nzRound:InState( ROUND_PROG ) then
			if nzMisc.WeightedRandom(speeds) + math.random(0,35) < 155 then
				self.GhoulSpeedState = 1
				self:SetRunSpeed( 1 )
			else
				self.GhoulSpeedState = 2
				self:SetRunSpeed( 36 )
			end
		else
			self.GhoulSpeedState = 1
			self:SetRunSpeed( 1 )
		end

		self:SetSurroundingBounds(Vector(-84, -84, 0), Vector(84, 84, 155))
		self:SetCollisionBounds(Vector(-12,-12, 0), Vector(12, 12, 72))

		self.CanCutoff = true

		self.GhoulDodgeCooldown = CurTime() + math.Rand(3.85, 6.29)
		self.GhoulRangedCooldown = CurTime() + math.Rand(5.64, 8.99)

		self.GhoulSpeedIncreaseInterval = CurTime() + 12.5
		self.LastStun = CurTime() + 1

		util.SpriteTrail(self, 9, Color(100, 0, 5, 125), true, 75, 35, 0.75, 1 / 40 * 0.3, "materials/trails/plasma")
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
	effectData:SetMagnitude( 1 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)

	self:EmitSound("nz_moo/zombies/vox/_ghoul/spawn/evt_ghoul_spawn_que.mp3", 511, math.random(95,105))

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

function ENT:AI()
	local target = self:GetTarget()

	-- Dodge Move
	if IsValid(target) and self:TargetInRange(500) and self:IsAimedAt() and CurTime() > self.GhoulDodgeCooldown and self.GhoulSpeedState > 1 and !self:GetJumping() then
		local seq = self.GhoulDodgeSequences[math.random(#self.GhoulDodgeSequences)]

		if self:SequenceHasSpace(seq) then
			if self.GhoulSpeedState == 3 then
				self.GhoulDodgeCooldown = CurTime() + math.Rand(3.35, 4.12)
			else
				self.GhoulDodgeCooldown = CurTime() + math.Rand(3.85, 6.29)
			end
			self:DoSpecialAnimation(seq)
		end
	end

	-- Ranged Attack
	if IsValid(target) and self:TargetInRange(500) and !self:IsAttackBlocked() and CurTime() > self.GhoulRangedCooldown and !self:GetJumping() then
		self:TempBehaveThread(function(self)
			self.GhoulRangedCooldown = CurTime() + math.Rand(8.64, 13.99)

			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove(self.RangedAttackSequences[math.random(#self.RangedAttackSequences)], 1, self.FaceEnemy)
			self:SetSpecialAnimation(false)
		end)
	end

	-- Speed Increase
	if CurTime() > self.GhoulSpeedIncreaseInterval and self.GhoulSpeedState < 3 then
		self.GhoulSpeedState = self.GhoulSpeedState + 1
		self.GhoulSpeedIncreaseInterval = CurTime() + 12.5 * self.GhoulSpeedState

		if self.GhoulSpeedState == 2 then
			self:SetRunSpeed(36)
			self:SpeedChanged()
			self.AttackDamage = 50
			self.HeavyAttackDamage = 95
		elseif self.GhoulSpeedState == 3 then
			self:SetRunSpeed(71)
			self:SpeedChanged()
			self.AttackDamage = 85
			self.HeavyAttackDamage = 200
		end
	end
end

function ENT:OnNuke() 
	self:PerformStun(5)
end

function ENT:PerformDeath(dmgInfo)
	
	self.Dying = true

	ParticleEffectAttach("zmb_amal_death_drops", 4, self, 1)
	if self:GetSpecialAnimation() then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		if IsValid(self) then
			self:Remove()
		end
	else
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then
			self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 
			
			self:Remove()
		end
	end)
end

function ENT:OnInjured(dmginfo)
	local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce 		= dmginfo:GetDamageForce()
	local hitpos 		= dmginfo:GetDamagePosition()
	local inflictor 	= dmginfo:GetInflictor()

	if !self.SpawnProtection then

		if dmginfo:GetDamage() == 18.75 and dmginfo:IsDamageType(DMG_MISSILEDEFENSE) and !self:GetSpecialAnimation() then
			--print("Uh oh Luigi, I'm about to commit insurance fraud lol.")
			self:DoSpecialAnimation("nz_base_ghoul_knockdown_b_01")
			if inflictor and inflictor:GetClass() == "nz_zombie_boss_hulk" then dmginfo:ScaleDamage(0) return end
		end

		--[[ STUMBLING/STUN ]]--
		if CurTime() > self.LastStun then

			if self.Dying then return end
			if !self:IsAlive() then return end
			if dmginfo:IsDamageType(DMG_MISSILEDEFENSE) or self:GetSpecialAnimation() or self:GetIsBusy() then return end

			if !self.IsBeingStunned and !self:GetSpecialAnimation() then
				if nzMapping.Settings.stumbling == true then
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
end

function ENT:OnRemove()
	if self.Dying then
		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 
		ParticleEffect("zmb_explosive_zombie_explo", self:GetPos() + Vector(0,0,40), Angle(0,0,0), nil)
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
	end
	if e == "step_right_large" then
		self:EmitSound(self.FootStepSounds[math.random(#self.FootStepSounds)], 75)
	end

	if e == "ghoul_death_explode" then
		if IsValid(self) then
			--[[self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 
			ParticleEffect("zmb_explosive_zombie_explo", self:GetPos() + Vector(0,0,40), Angle(0,0,0), nil)]]

			self:Remove()
		end
	end

	if e == "ghoul_dodge" then
		self:EmitSound(self.DodgeSWTSounds[math.random(#self.DodgeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:PlaySound(self.DodgeSounds[math.random(#self.DodgeSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	end

	if e == "ghoul_ranged_tell" then
		self:PlaySound("nz_moo/zombies/vox/_ghoul/pain/vox_ghoul_pain_02.mp3", 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	end

	if e == "ghoul_ranged_attack" then
		self:PlaySound("nz_moo/zombies/vox/_ghoul/pain/vox_ghoul_pain_01.mp3", 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		self:EmitSound(self.RangedAttackSounds[math.random(#self.RangedAttackSounds)], SNDLVL_GUNFIRE, math.random(95,105))

		local attach = self:GetBonePosition(self:LookupBone("j_spineupper")) + self:GetForward() * 20
		local target = self:GetTarget()


		ParticleEffect("zmb_ghoul_ranged_attack", attach, self:GetAngles(), self)

		if IsValid(target) then
			for i=1, 6 do
				timer.Simple(i * 0.1, function()
					if IsValid(self) then
						self:EmitSound(self.RangedAttackFireSounds[math.random(#self.RangedAttackFireSounds)], SNDLVL_GUNFIRE, math.random(95,105))

						self.Needles = ents.Create("nz_proj_dopple_needle")
						self.Needles:SetPos(attach)
						self.Needles:Spawn()
						self.Needles:Launch(((target:GetPos() + Vector(math.random(-100,100),math.random(-100,100),math.random(-50,50)) + target:GetVelocity() * math.Clamp(target:GetVelocity():Length2D(),0,0.5)) - self.Needles:GetPos()):GetNormalized())
					end
				end)
			end
		end

		-- First time doing a Cone type hitbox for an enemy so this might suck a little.
		--[[
		local dmgInfo = DamageInfo()
		dmgInfo:SetAttacker( self )
		dmgInfo:SetDamage( 50 )
		dmgInfo:SetDamageType( DMG_SLASH )

		local conepos = self:EyePos()
		local conedir = self:GetAimVector()
		local conesize = 200
		local coneang = 0.6

		local entities = ents.FindInCone( conepos, conedir, conesize, coneang)
		for _, target in pairs(entities) do
			if IsValid(target) and target:IsPlayer() and !self:IsAttackEntBlocked(target) then
				target:TakeDamageInfo(dmgInfo)
                target:NZSonicBlind(1)
			end
		end
		]]
	end
end
