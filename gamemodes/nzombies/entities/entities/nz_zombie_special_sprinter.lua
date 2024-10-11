AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
--ENT.PrintName = "ZomBEESSS"
ENT.PrintName = "Pest"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

function ENT:Draw()
	self:DrawModel()
end

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = false

ENT.AttackDamage = 25

ENT.Models = {
	{Model = "models/moo/_codz_ports/s2/zombie/moo_codz_s2_zom_sprinter_3arc.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_ent_ground_01", "nz_ent_ground_02"}

ENT.DeathSequences = {
	"nz_death_1",
	"nz_death_2",
	"nz_death_3",
	"nz_death_f_1",
	"nz_death_f_2",
	"nz_death_f_3",
	"nz_death_f_4",
	"nz_death_f_5",
	"nz_death_f_6",
	"nz_death_f_7",
	"nz_death_f_8",
	"nz_death_f_9",
	"nz_death_f_10",
	"nz_death_f_11",
	"nz_death_f_12",
	"nz_death_f_13",
	"nz_death_fallback",
	"nz_l4d_death_running_11a",
	"nz_l4d_death_running_11g",
	"nz_l4d_death_02a",
	"nz_l4d_death_11_02d",
}

ENT.CrawlDeathSequences = {
	"nz_crawl_death_v1",
	"nz_crawl_death_v2",
}

ENT.SparkySequences = {
	"nz_s2_core_stunned_electrobolt_v1",
	"nz_s2_core_stunned_electrobolt_v2",
	"nz_s2_core_stunned_electrobolt_v3",
	"nz_s2_core_stunned_electrobolt_v4",
	"nz_s2_core_stunned_electrobolt_v5",
}

local CrawlAttackSequences = {
	{seq = "nz_iw7_cp_zom_prone_attack_2h_01"},
	{seq = "nz_iw7_cp_zom_prone_attack_l_01"},
	{seq = "nz_iw7_cp_zom_prone_attack_l_02"},
	{seq = "nz_iw7_cp_zom_prone_attack_r_01"},
}

local CrawlJumpSequences = {
	{seq = "nz_iw7_cp_zom_prone_run_window_over_40_01"},
	{seq = "nz_iw7_cp_zom_prone_run_window_over_40_02"},
	{seq = "nz_iw7_cp_zom_prone_run_window_over_40_03"},
	{seq = "nz_iw7_cp_zom_prone_walk_window_over_40_01"},
	{seq = "nz_iw7_cp_zom_prone_walk_window_over_40_02"},
	{seq = "nz_iw7_cp_zom_prone_walk_window_over_40_03"},
}

ENT.ElectrocutionSequences = {
	"nz_death_elec_1",
	"nz_death_elec_2",
	"nz_death_elec_3",
	"nz_death_elec_4",
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
}

local SlowClimbUp36 = {
	"nz_traverse_climbup36"
}
local SlowClimbUp48 = {
	"nz_traverse_climbup48"
}
local SlowClimbUp72 = {
	"nz_traverse_climbup72"
}
local SlowClimbUp96 = {
	"nz_traverse_climbup96"
}
local SlowClimbUp128 = {
	"nz_traverse_climbup128",
	"nz_l4d_traverse_climbup132_01",
	"nz_l4d_traverse_climbup132_02",
	"nz_l4d_traverse_climbup132_03",
}
local SlowClimbUp160 = {
	"nz_traverse_climbup160",
	"nz_l4d_traverse_climbup156_01",
	"nz_l4d_traverse_climbup156_02",
	"nz_l4d_traverse_climbup156_03",
}
local FastClimbUp36 = {
	"nz_traverse_fast_climbup36",
	"nz_l4d_traverse_climbup36_01",
	"nz_l4d_traverse_climbup36_02",
	"nz_l4d_traverse_climbup36_03",
}
local FastClimbUp48 = {
	"nz_traverse_fast_climbup48",
	"nz_l4d_traverse_climbup48_01",
	"nz_l4d_traverse_climbup48_02",
	"nz_l4d_traverse_climbup48_03",
	"nz_l4d_traverse_climbup48_04",
}
local FastClimbUp72 = {
	"nz_traverse_fast_climbup72",
	"nz_l4d_traverse_climbup72_01",
	"nz_l4d_traverse_climbup72_02",
	"nz_l4d_traverse_climbup72_03",
}
local FastClimbUp96 = {
	"nz_traverse_fast_climbup96",
	"nz_l4d_traverse_climbup96_01",
	"nz_l4d_traverse_climbup96_02",
	"nz_l4d_traverse_climbup96_03",
}
local ClimbUp200 = {
	"nz_traverse_climbup200"
}

local AttackSequences = {
	{seq = "nz_s2_pest_stand_attack_v1"},
	{seq = "nz_s2_pest_stand_attack_v2"},
	{seq = "nz_s2_pest_stand_attack_v3"},
	{seq = "nz_legacy_attack_v3"},

	{seq = "nz_legacy_attack_v11"},
}

local RunAttackSequences = {
	{seq = "nz_s2_pest_sprint_attack_v1"},
	{seq = "nz_s2_pest_sprint_attack_v2"},
	{seq = "nz_s2_pest_sprint_attack_v3"},
}

local JumpSequences = {
	{seq = "nz_iw7_cp_zom_walk_window_over_40_01"},
	{seq = "nz_iw7_cp_zom_walk_window_over_40_02"},
	{seq = "nz_iw7_cp_zom_walk_window_over_40_03"},
	{seq = "nz_iw7_cp_zom_walk_window_over_40_04"},
}
local RunJumpSequences = {
	{seq = "nz_iw7_cp_zom_run_window_over_40_01"},
	{seq = "nz_iw7_cp_zom_run_window_over_40_02"},
	{seq = "nz_iw7_cp_zom_run_window_over_40_03"},
	{seq = "nz_iw7_cp_zom_run_window_over_40_04"},
	{seq = "nz_iw7_cp_zom_run_window_over_40_05"},
	{seq = "nz_l4d_mantle_over_36"},
}
local SprintJumpSequences = {
	{seq = "nz_zom_core_mantle_over_40"},
	{seq = "nz_zom_core_traverse_stepover_40"},
	{seq = "nz_zom_core_traverse_window_36_quick"},
}
local walksounds = {
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_charge_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_charge_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_charge_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_charge_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_charge_05.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_charge_06.mp3"),

	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_1_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_1_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_1_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_1_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_1_05.mp3"),

	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_2_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_2_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_2_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_2_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_2_05.mp3"),

	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_3_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_3_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_3_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_3_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_3_05.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_s2_pest_sprint_v1",
				"nz_s2_pest_sprint_v2",
				"nz_s2_pest_sprint_v3",
				"nz_sonic_run_01",
				"nz_sprint_ad3",
				"nz_sprint_ad5",
			},
			LowgMovementSequence = {
				"nz_sprint_lowg_v1",
				"nz_sprint_lowg_v2",
				"nz_sprint_lowg_v3",
				"nz_sprint_lowg_v4",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_iw7_cp_zom_prone_shamble_forward_01",
				"nz_iw7_cp_zom_prone_shamble_forward_02",
				--[["nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",]]
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			TurnedMovementSequence = {
				--"nz_pb_zombie_sprint_v6",
				--"nz_pb_zombie_sprint_v7",
				"nz_pb_zombie_sprint_v8", -- The Tranzit Sprinter one.
				--"nz_pb_zombie_sprint_v9",
				"nz_l4d_run_03",
				"nz_l4d_run_04",
				
				"nz_t9_base_player_sprint_v01",
				"nz_t9_base_player_sprint_v02",
				"nz_t9_base_player_sprint_v03",
				"nz_t9_base_player_sprint_v04",
				"nz_t9_base_player_sprint_v05",
				"nz_t9_base_player_sprint_v06",
				"nz_t9_base_player_sprint_v07",
				"nz_t9_base_player_sprint_v08",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			JumpSequences = {JumpSequences},
			CrawlJumpSequences = {CrawlJumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

ENT.IdleSequence = "nz_iw7_cp_zom_stand_idle_01"

ENT.IdleSequenceAU = "nz_iw7_cp_zom_stand_idle_02"

ENT.TauntSequences = {
	"nz_taunt_v1",
	"nz_taunt_v2",
	"nz_taunt_v3",
	"nz_taunt_v4",
	"nz_taunt_v5",
	"nz_taunt_v6",
	"nz_taunt_v7",
	"nz_taunt_v8",
	"nz_taunt_v9"
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_10.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_death_10.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_1_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_1_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_1_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_1_04.mp3"),

	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_2_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_2_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_2_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_2_04.mp3"),

	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_3_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_3_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_3_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_anm_sprint_attack_3_04.mp3"),
}

ENT.SpawnSounds = {
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_05.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_06.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_07.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_08.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_09.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_spawn_10.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_spr/flies_pan_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_05.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_06.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_07.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_08.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_09.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_10.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_11.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_12.mp3"),
	Sound("nz_moo/zombies/vox/_spr/flies_pan_13.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_09.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_10.mp3"),
	Sound("nz_moo/zombies/vox/_spr/zmb_vox_spr_sneak_attack_11.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		self:SetRunSpeed( 1 )
		self:SetHealth( 200 )
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

	if IsValid(self.SpawnIndex) then
		local stype = self.SpawnIndex:GetSpawnType()
		if stype == 11 then
			self:EmitSound("ambient/energy/weld"..math.random(2)..".wav",100,math.random(95,105))
			self:EmitSound("nz_moo/zombies/gibs/head/_og/zombie_head_0"..math.random(0,2)..".mp3", 65, math.random(95,105))
			self:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(0,3)..".mp3", 100, math.random(95,105))
			if IsValid(self) then ParticleEffect("wwii_spawn_main", self:GetPos() + Vector(0,0,0), Angle(0,0,0), self) end
			if IsValid(self) then ParticleEffect("wwii_spawn_embers", self:GetPos() + Vector(0,0,0), Angle(0,0,0), self) end
			if IsValid(self) then ParticleEffect("wwii_spawn_blood", self:GetPos() + Vector(0,0,0), Angle(0,0,0), self) end
			if IsValid(self) then ParticleEffect("wwii_spawn_elec", self:GetPos() + Vector(0,0,20), Angle(0,0,0), self) end
		end
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