AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Crog"
--ENT.PrintName = "Crustacean"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
	
-- Simple minded creature that attacks and explodes into a stinky puddle.

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.IsMooSpecial = true

ENT.DamageRange 			= 85
ENT.AttackDamage 			= 60
ENT.HeavyAttackDamage 		= 100

ENT.Models = {
	{Model = "models/moo/_codz_ports/iw7/town/moo_codz_iw7_town_minicrab.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_minicrab_spawn_ground"}

local AttackSequences = {
	{seq = "nz_minicrab_attack_stand_01"},
	{seq = "nz_minicrab_attack_stand_02"},
	{seq = "nz_minicrab_attack_stand_03"},
}

local RunAttackSequences = {
	{seq = "nz_minicrab_attack_run_01"},
	{seq = "nz_minicrab_attack_run_02"},
	{seq = "nz_minicrab_attack_run_03"},
}

local JumpSequences = {
	{seq = "nz_minicrab_barricade_jump"},
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

ENT.IdleSequence 	= "nz_minicrab_idle_01"
ENT.IdleSequenceAU 	= "nz_minicrab_idle_02"
ENT.NoTargetIdle 	= "nz_minicrab_idle_03"

ENT.DeathSequences = {
	"nz_minicrab_death_01",
	"nz_minicrab_death_02",
	"nz_minicrab_death_03",
	"nz_minicrab_death_04",
	"nz_minicrab_death_05",
}

ENT.ElectrocutionSequences = {
	"nz_minicrab_sparky_01",
	"nz_minicrab_sparky_02",
}

ENT.SparkySequences = {
	"nz_minicrab_sparky_01",
	"nz_minicrab_sparky_02",
	"nz_minicrab_sparky_01",
	"nz_minicrab_sparky_02",
	"nz_minicrab_sparky_01",
	"nz_minicrab_sparky_02",
}

ENT.ZombieLandSequences = { "nz_minicrab_jump_land", }

local walksounds = {
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_jump_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_jump_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_jump_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_jump_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_jump_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_jump_06.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_jump_07.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch7_jump_08.mp3"),
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

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch6_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch6_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch6_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch6_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch6_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch6_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_batch6_death_08.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_01.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_02.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_03.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_04.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_05.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_06.mp3"),
}

ENT.AppearSounds = {
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_01a.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_01b.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_02a.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_02b.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_03a.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/vox/brute_demo4_posture_03b.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_06.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_02.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_03.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_04.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_05.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/step/alien_footstep_bg_06.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_minicrab_run_01",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_minicrab_sprint_01",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
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

function ENT:StatsInitialize()
	if SERVER then
		self:SetHealth( nzRound:GetZombieHealth() * 0.5 or 75 )
		self:SetMaxHealth( self:Health() )
		
		-- Chance to be a fast Crustacean
		if math.random(100) < 10 then
			self:SetRunSpeed( 71 )
			self.loco:SetDesiredSpeed( 71 )
		else
			self:SetRunSpeed( 36 )
			self.loco:SetDesiredSpeed( 36 )
		end
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

function ENT:PerformDeath(dmgInfo)
	self.Dying = true

	ParticleEffectAttach("doom_de_cybermancubus_fireball_glow", PATTACH_POINT_FOLLOW, self, 2)

	if self:GetSpecialAnimation() then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			self:ToxicExplode()
		end
	else
		if dmgInfo:GetDamageType() == DMG_SHOCK then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			self:DoDeathAnimation(self.ElectrocutionSequences[math.random(#self.ElectrocutionSequences)])
		else
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
		end
	end
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then			
			self:ToxicExplode()
		end
	end)
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end