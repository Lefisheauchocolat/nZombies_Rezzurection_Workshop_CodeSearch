AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Wustling"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then

	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/s2_zombies/follower/mtl_zom_follower_eye_org1.vmt"),
	}

	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()

		if self.RedEyes == true and self:IsAlive() and !self:GetDecapitated() and !self:GetMooSpecial() and !self.IsMooSpecial then
			self:DrawEyeGlow() 
		end

		if self:WaterBuff() and !self:BomberBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 0
				elight.g = 50
				elight.b = 255
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:BomberBuff() and !self:WaterBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 150
				elight.g = 255
				elight.b = 75
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:WaterBuff() and self:BomberBuff() and self:IsAlive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 255
				elight.g = 0
				elight.b = 0
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end

		self:ZCTFire()
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end

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
	end

	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMiniBoss = true
ENT.RedEyes = true

ENT.AttackRange 			= 95
ENT.DamageRange 			= 95
ENT.AttackDamage 			= 65
ENT.HeavyAttackDamage 		= 95

ENT.SoundDelayMin = 5
ENT.SoundDelayMax = 10

ENT.Models = {
	{Model = "models/moo/_codz_ports/s2/zombie/moo_codz_s2_follower.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_base_follower_trav_riser"}

ENT.DeathSequences = {
	"nz_base_follower_stand_dth",
	"nz_base_follower_walk_dth",
}

ENT.ElectrocutionSequences = {
	"nz_base_follower_stunned_electrobolt_v1",
	"nz_base_follower_stunned_electrobolt_v2",
}

local AttackSequences = {
	{seq = "nz_base_follower_stand_attack_v1"},
	{seq = "nz_base_follower_stand_attack_v2"},
	{seq = "nz_base_follower_stand_attack_v3"},
}

local WalkAttackSequences = {
	{seq = "nz_base_follower_walk_attack_v1"},
	{seq = "nz_base_follower_walk_attack_v2"},
	{seq = "nz_base_follower_walk_attack_v3"},
	{seq = "nz_base_follower_walk_attack_v4"},
}

local RunAttackSequences = {
	{seq = "nz_base_follower_run_attack_v1"},
	{seq = "nz_base_follower_run_attack_v2"},
	{seq = "nz_base_follower_run_attack_v3"},
}

local SprintAttackSequences = {
	{seq = "nz_base_follower_charge_attack"},
}

local JumpSequences = {
	{seq = "nz_base_follower_trav_win_v1"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev1_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev1_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev1_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev1_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev1_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev1_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev1_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev1_08.mp3"),

	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev2_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev2_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev2_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev2_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev2_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev2_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev2_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev2_08.mp3"),

	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev4_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev4_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev4_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev4_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev4_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev4_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_growl_lev4_07.mp3"),

	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_sml_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_sml_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_sml_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_sml_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_sml_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_sml_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_sml_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_sml_08.mp3"),

	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_med_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_med_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_med_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_med_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_med_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_med_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_med_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_med_08.mp3"),

	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_lrg_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_lrg_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_lrg_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_lrg_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_lrg_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_lrg_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_lrg_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_taunt_lrg_08.mp3"),
}

ENT.IdleSequence = "nz_base_follower_pass_idle_v1"
ENT.IdleSequenceAU = "nz_base_follower_pass_idle_v2"
ENT.NoTargetIdle = "nz_base_follower_pass_idle_v3"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_follower_walk_v1",
				"nz_base_follower_walk_v2",
			},
			AttackSequences = {WalkAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_follower_run_v1",
				"nz_base_follower_run_v2",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_follower_charge_run",
			},
			AttackSequences = {SprintAttackSequences},
			StandAttackSequences = {SprintAttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
}

ENT.ZombieLedgeClimbLoopSequences = {
	"nz_base_follower_climb_loop",
}
ENT.ZombieLedgeClimbSequences = {
	"nz_base_follower_climb_finish", -- Will only ever be one, for easy overridding.
}

ENT.ZombieLandSequences = {
	"nz_base_follower_land", -- Will only ever be one, for easy overridding.
}

ENT.SparkySequences = {
	"nz_base_follower_stunned_electrobolt_v1",
	"nz_base_follower_stunned_electrobolt_v2",
}

ENT.JumpSpawnSequences = {
	"nz_base_follower_trav_riser_burstup",
}

ENT.DugUpSpawnSequences = {
	"nz_base_follower_trav_riser_burstup",
}

ENT.CustomJumpThroughClosetDoor = {
	"nz_base_follower_closet_jumpthrough",
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_sml_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_sml_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_sml_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_sml_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_sml_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_sml_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_sml_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_sml_08.mp3"),

	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_med_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_med_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_med_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_med_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_med_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_med_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_med_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_med_08.mp3"),

	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_08.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_pain_lrg_09.mp3"),
}
ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_05.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_death_05.mp3"),
}

ENT.ChargeSounds = {
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_charge_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_charge_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_charge_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_charge_attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_charge_attack_05.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_med_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_med_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_med_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_med_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_med_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_med_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_med_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_med_08.mp3"),

	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_01.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_02.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_03.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_04.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_05.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_06.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_07.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_08.mp3"),
	Sound("nz_moo/zombies/vox/_fol/zmb_vox_fol_melee_lrg_09.mp3"),
}

ENT.HeavyAttackImpactSounds = {
	Sound("wavy_zombie/hulk/pound_victim_1.wav"),
	Sound("wavy_zombie/hulk/pound_victim_2.wav"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_06.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_07.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_08.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_09.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_10.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_11.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_run_large_default_12.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_06.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_07.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_08.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_09.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_10.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_11.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_12.mp3"),
}

ENT.WeakImpactSounds = {
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_00.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_01.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_02.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_03.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_04.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		if nzRound:GetNumber() == -1 then
			self:SetHealth(math.random(2500, 7500))
		else
			self:SetHealth( nzRound:GetZombieHealth() * 4 or 75 )
		end

		self:SetRunSpeed(1)

		self.ManIsMad = false -- The REAL Man is mad.
		self.ManNoLongerMad = false
		self.ManIsMadTime = CurTime() + 3
		self.ManIsMadCooldown = CurTime() + 3
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

function ENT:PostTookDamage(dmginfo) 
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local dmgtype = dmginfo:GetDamageType()

	local hitpos = dmginfo:GetDamagePosition()

	local weakspot = self:GetAttachment(self:LookupAttachment("tag_back_weakspot")).Pos

	if (hitpos:DistToSqr(weakspot) < 10^2) then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(3)
	else
		dmginfo:ScaleDamage(0.25)
	end

	if CurTime() > self.ManIsMadCooldown and !self.ManIsMad and !self.IsTurned and math.random(100) <= 50 and !self:GetSpecialAnimation() then
		self.ManIsMad = true
		self.ManIsMadTime = CurTime() + math.Rand(4.25, 4.95)

		self:SetRunSpeed(155)
		self:SpeedChanged()

		self:DoSpecialAnimation("nz_base_follower_charge_react")
	end
end

function ENT:OnAttack()
	if self.ManIsMad then
		self.ManIsMad = false
		self.ManNoLongerMad = true
		self.BlockBigJumpThink = false
		self.ManIsMadCooldown = CurTime() + 6
	end
end

function ENT:PostAttack()
	if self.ManNoLongerMad then
		self.ManNoLongerMad = false
		self.BlockBigJumpThink = false

		self:SetRunSpeed(1)
		self:SpeedChanged()
	end
end

function ENT:AI()
	if CurTime() > self.ManIsMadTime and self.ManIsMad then
		--print(self.ManIsMad)
		self:DoSpecialAnimation("nz_base_follower_charge_attack")

		self.ManIsMad = false
		self.BlockBigJumpThink = true
		self.ManIsMadCooldown = CurTime() + 3

		self:SetRunSpeed(1)
		self:SpeedChanged()
	end
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	
	-- Turned Zombie Targetting
	if self.IsTurned then
		return IsValid(ent) and ent:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooBossZombie and ent:IsAlive() 
	end
	
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:CustomAnimEvent(a,b,c,d,e) 
	if e == "vox_follower_charge" then
		self:EmitSound(self.ChargeSounds[math.random(#self.ChargeSounds)], 85, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		self.NextSound = CurTime() + self.SoundDelayMax
	end
	if e == "evt_follower_land" then
		self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)],80,math.random(95,100))
		util.ScreenShake(self:GetPos(),100000,500000,0.1,500)
		ParticleEffect("panzer_land_dust",self:LocalToWorld(Vector(0,20,0)),Angle(0,0,0),nil)
	end
	if e == "evt_follower_slam" then
		self:EmitSound("wavy_zombie/hulk/hulk_punch_1.wav", 85, math.random(85,105))
		util.ScreenShake(self:GetPos(),100000,500000,0.1,500)
		ParticleEffect("panzer_land_dust",self:LocalToWorld(Vector(0,20,0)),Angle(0,0,0),nil)
	end
end