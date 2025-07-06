AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Vermin"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t10_zombies/zm/c_t10_zmb_zombie_base_body_01_eyes.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true

ENT.AttackDamage 			= 25 
ENT.HeavyAttackDamage 		= 50 
ENT.AttackRange 			= 50
ENT.DamageRange 			= 50

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/zm/moo_codz_t10_zmb_vermin.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_base_vermin_riser_01", "nz_base_vermin_riser_02"}

ENT.DeathSequences = {
	"nz_base_vermin_dth_01",
	"nz_base_vermin_dth_02",
	"nz_base_vermin_dth_03",
}

ENT.ElectrocutionSequences = {
	"nz_base_vermin_dth_01",
	"nz_base_vermin_dth_02",
	"nz_base_vermin_dth_03",
}

ENT.BlackHoleDeathSequences = {
	"nz_base_vermin_deckcannon_dth_01",
	"nz_base_vermin_deckcannon_dth_01",
}

ENT.ThunderGunSequences = {
	"nz_base_vermin_knockback",
	"nz_base_vermin_knockback",
	"nz_base_vermin_knockback",
	"nz_base_vermin_knockback",
	"nz_base_vermin_knockback",
	"nz_base_vermin_knockback",
	"nz_base_vermin_knockback",
	"nz_base_vermin_knockback",
}

ENT.IdGunSequences = {	"nz_base_vermin_deckcannon_intro_01", }

ENT.CustomMantleOver48 		= {	"nz_base_vermin_mantle_over_48", }
ENT.CustomMantleOver72 		= {	"nz_base_vermin_mantle_over_72", }
ENT.CustomMantleOver96 		= {	"nz_base_vermin_mantle_over_96", }
ENT.ProneCrawlSequences 	= { "nz_base_vermin_crawlout", }

ENT.ZombieLandSequences 				= {	"nz_base_vermin_land", }
ENT.ZombieLedgeClimbSequences 			= { "nz_base_vermin_climbup", }
ENT.ZombieLedgeClimbMantleOverSequences = {	"nz_base_vermin_climb2mantle", }

local AttackSequences = {
	{seq = "nz_base_vermin_attack_01"},
	{seq = "nz_base_vermin_attack_02"},
}

local JumpSequences = {
	{seq = "nz_base_vermin_mantle_over_36"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/amb/vox_vermin_amb_16.mp3"),
}

ENT.IdleSequence 	= "nz_base_vermin_idle_01"
ENT.IdleSequenceAU 	= "nz_base_vermin_idle_02"
ENT.NoTargetIdle 	= "nz_base_vermin_idle_02"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_vermin_walk_01",
				"nz_base_vermin_walk_02",
			},
			BlackholeMovementSequence = {
				"nz_base_vermin_walk_blackhole_01",
				"nz_base_vermin_walk_blackhole_02",
				"nz_base_vermin_walk_blackhole_03",
				"nz_base_vermin_walk_blackhole_04",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_vermin_run_01",
				"nz_base_vermin_run_02",
			},
			BlackholeMovementSequence = {
				"nz_base_vermin_walk_blackhole_01",
				"nz_base_vermin_walk_blackhole_02",
				"nz_base_vermin_walk_blackhole_03",
				"nz_base_vermin_walk_blackhole_04",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_vermin_sprint_01",
				"nz_base_vermin_sprint_02",
				"nz_base_vermin_sprint_03",
			},
			BlackholeMovementSequence = {
				"nz_base_vermin_walk_blackhole_01",
				"nz_base_vermin_walk_blackhole_02",
				"nz_base_vermin_walk_blackhole_03",
				"nz_base_vermin_walk_blackhole_04",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_vermin/death/vox_vermin_death_00.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/death/vox_vermin_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/death/vox_vermin_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/death/vox_vermin_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/death/vox_vermin_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/death/vox_vermin_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/death/vox_vermin_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/death/vox_vermin_death_07.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_09.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_10.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_11.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/attack/vox_vermin_attack_12.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/behind/vox_vermin_behind_08.mp3"),
}

ENT.FootstepSounds = {
	Sound("nz_moo/zombies/vox/_vermin/step/fly_vermin_step_00.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/step/fly_vermin_step_01.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/step/fly_vermin_step_02.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/step/fly_vermin_step_03.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/step/fly_vermin_step_04.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/step/fly_vermin_step_05.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/step/fly_vermin_step_06.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/step/fly_vermin_step_07.mp3"),
}

ENT.SpawnSounds = {
	Sound("nz_moo/zombies/vox/_vermin/spawn/2d_vermin_spawn_que_00.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/spawn/2d_vermin_spawn_que_01.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/spawn/2d_vermin_spawn_que_02.mp3"),
	Sound("nz_moo/zombies/vox/_vermin/spawn/2d_vermin_spawn_que_03.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local speeds = nzRound:GetZombieCoDSpeeds()
		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 100 )
		end
		self:SetHealth( nzRound:GetZombieHealth() * 0.35 or 75 )

		self.InLeapAttack = false
		self.ContactWithTarget = false
		self.LeapAttackCooldown = CurTime() + 5
		self.LeapAttackThink = CurTime() + 0.05

		self.HasCollisionDuringJump = true

		self:SetCollisionBounds(Vector(-10,-10, 0), Vector(10, 10, 36))	
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

		ParticleEffect("zmb_zombie_spawn_dirt",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))

	end

	self:EmitSound(self.SpawnSounds[math.random(#self.SpawnSounds)], 511, math.random(self.MinSoundPitch, self.MaxSoundPitch))

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
	local target = self.Target

	-- Leap Attack
	if IsValid(target) and target:IsPlayer() and !self:IsJumping() then
		if CurTime() > self.LeapAttackCooldown and !self.InLeapAttack and !self:IsAttackBlocked() and self:TargetInRange(400) and math.random(50) < 25 then
			self.InLeapAttack = true

			self:TempBehaveThread(function(self)
				self:SetSpecialAnimation(true)
				self:PlaySequenceAndMove("nz_base_vermin_lunge_start", 1, self.FaceEnemy)

				self:CollideWhenPossible()
				self:FaceTowards(target)
				self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)

				self:FaceTowards(target)	
				self.loco:Jump()
   				self:TimedEvent( 0.1, function() self.loco:SetVelocity(((target:GetPos() + target:OBBCenter()) - (self:GetPos() + self:OBBCenter())):GetNormal()*400 + self:GetForward()*1250 + self:GetUp()*50 + self:GetRight()*0) end)
			end)
		end
	end 
end

function ENT:OnThink()
	if self.InLeapAttack and CurTime() > self.LeapAttackThink then
		self.LeapAttackThink = CurTime() + 0.05

		if self:TargetInRange(self.AttackRange + 20) and !self.ContactWithTarget then
			self.ContactWithTarget = true
			self:DoAttackDamage()
		end
	end
end

function ENT:OnLandOnGroundCustom(ent) 
	if self.InLeapAttack then 
		self.InLeapAttack = false 
		self.ContactWithTarget = false
		self.LeapAttackCooldown = CurTime() + 7

		self.CancelCurrentPath = true
		self:SetSpecialAnimation(false)

		self.loco:SetVelocity(self:GetForward() * -50) 
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) 
	if e == "vermin_step" then
		self:EmitSound(self.FootstepSounds[math.random(#self.FootstepSounds)], 80, math.random(95, 105))
	end
end
