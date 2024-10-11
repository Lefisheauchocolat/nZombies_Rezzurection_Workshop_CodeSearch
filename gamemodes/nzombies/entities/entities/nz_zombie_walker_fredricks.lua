AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Animatronic"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.HeavyAttackDamage = 65

ENT.Models = {
	{Model = "models/moo/_codz_ports/t7/_custommaps/flipside/moo_codz_t7_endoskeleton.mdl", Skin = 0, Bodygroups = {0,0}}, -- the nazi in question is now an Endo
	
	{Model = "models/wavy/wavy_rigs/fnaf/freddy/wavy_fnaf_zombie_freddy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/fnaf/bonnie/wavy_fnaf_zombie_bonnie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/fnaf/chica/wavy_fnaf_zombie_chica.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/fnaf/foxy/wavy_fnaf_zombie_foxy.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb"}
local spawnrun = {"nz_spawn_ground_v1_run"}
local spawnfast = {"nz_spawn_ground_climbout_fast", "nz_s4_3arc_traverse_riser"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

ENT.DeathSequences = {
	"nz_iw7_cp_zom_death_backward_1",
	"nz_iw7_cp_zom_death_backward_2",
	"nz_iw7_cp_zom_death_backward_3",
	"nz_iw7_cp_zom_death_backward_4",
	"nz_iw7_cp_zom_death_backward_5",
	"nz_iw7_cp_zom_death_backward_6",
	"nz_iw7_cp_zom_death_backward_7",
	"nz_iw7_cp_zom_death_backward_8",
	"nz_iw7_cp_zom_death_forward_1",
	"nz_iw7_cp_zom_death_forward_2",
	"nz_iw7_cp_zom_death_forward_3",
	"nz_iw7_cp_zom_death_forward_4",
	"nz_iw7_cp_zom_death_forward_5",
	"nz_zom_core_death_run_1",
	"nz_zom_core_death_run_2",
	"nz_zom_core_death_run_3",
	"nz_zom_core_death_run_4",
	"nz_zom_core_death_run_5",
	"nz_zom_core_death_run_6",
	"nz_zom_core_death_run_7",
	"nz_zom_core_death_stand_1",
	"nz_zom_core_death_stand_2",
	"nz_zom_core_death_stand_3",
	"nz_zom_core_death_stand_4",
	"nz_zom_core_death_stand_5",
	"nz_death_fallback",
	"nz_l4d_death_running_11a",
	"nz_l4d_death_running_11g",
	"nz_l4d_death_02a",
	"nz_l4d_death_11_02d",
}

ENT.CrawlDeathSequences = {
	"nz_iw7_cp_zom_prone_death_backward_1",
	"nz_iw7_cp_zom_prone_death_backward_2",
	"nz_iw7_cp_zom_prone_death_forward_1",
	"nz_iw7_cp_zom_prone_death_forward_2",
}

ENT.ElectrocutionSequences = {
	"nz_death_elec_1",
	"nz_death_elec_2",
	"nz_death_elec_3",
	"nz_death_elec_4",
	"nz_zombie_tesla_death_e",
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
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
	{seq = "nz_iw7_cp_zom_stand_attack_l_01"},
	{seq = "nz_iw7_cp_zom_stand_attack_l_02"},
	{seq = "nz_iw7_cp_zom_stand_attack_r_01"},
	{seq = "nz_iw7_cp_zom_stand_attack_r_02"},
	{seq = "nz_zom_core_stand_attack_2h_01"},
	{seq = "nz_zom_core_stand_attack_2h_02"},
}

local WalkAttackSequences = {
	{seq = "nz_iw7_cp_zom_walk_attack_r_01"}, -- Quick single swipe
	{seq = "nz_iw7_cp_zom_walk_attack_r_02"}, -- Slowish double swipe
	{seq = "nz_iw7_cp_zom_walk_attack_l_01"}, -- Slowish single swipe
	{seq = "nz_iw7_cp_zom_walk_attack_l_02"}, -- Quickish double swipe
	{seq = "nz_zom_core_walk_atk_l_03"},
}

local RunAttackSequences = {
	{seq = "nz_zom_core_run_attack_l_01"},
	{seq = "nz_zom_core_run_attack_l_02"},
	{seq = "nz_zom_core_run_attack_r_01"},
	{seq = "nz_zom_core_run_attack_r_02"},
}

local StinkyRunAttackSequences = {
	{seq = "nz_run_ad_attack_v1"},
	{seq = "nz_run_ad_attack_v2"},
	{seq = "nz_run_ad_attack_v3"},
	{seq = "nz_run_ad_attack_v4"},

	-- The REAL Bad Attack Anims
	{seq = "nz_legacy_run_attack_v1"},
	{seq = "nz_legacy_run_attack_v2"},
	{seq = "nz_legacy_run_attack_v3"},
	{seq = "nz_legacy_run_attack_v4"},
}

local SprintAttackSequences = {
	{seq = "nz_zom_core_run_attack_l_01"},
	{seq = "nz_zom_core_run_attack_l_02"},
	{seq = "nz_zom_core_run_attack_r_01"},
	{seq = "nz_zom_core_run_attack_r_02"},
}

local SuperSprintAttackSequences = {
	{seq = "nz_zom_core_sprint_attack_2h_01"},
	{seq = "nz_zom_core_sprint_attack_2h_02"},
	{seq = "nz_zom_core_sprint_attack_l_01"},
	{seq = "nz_zom_core_sprint_attack_r_01"},
	{seq = "nz_zom_core_sprint_attack_r_02"},
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
	Sound("nz_moo/zombies/vox/_robot/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_16.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_17.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_18.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_19.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_20.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_21.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_22.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_23.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_24.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_25.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_26.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_27.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_28.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_29.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_30.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_31.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_32.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_33.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_34.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_35.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_36.mp3"),
	Sound("nz_moo/zombies/vox/_robot/amb/amb_37.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_00.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_01.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_02.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_03.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_04.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_05.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_06.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_07.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_08.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_09.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_10.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_11.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_12.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_13.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_14.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_15.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_16.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_17.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_18.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_19.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_20.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_21.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_22.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_23.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_24.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_25.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_26.mp3"),
	Sound("nz_moo/zombies/vox/_robot/sprint/sprint_27.mp3"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_s1_zom_core_walk_2",
				"nz_s1_zom_core_walk_3",
				"nz_s1_zom_core_walk_4",
				"nz_s1_zom_core_walk_5",
				"nz_iw7_cp_zom_shamble_forward_01",
				"nz_iw7_cp_zom_shamble_forward_02",
				"nz_iw7_cp_zom_shamble_forward_03",
				"nz_iw7_cp_zom_shamble_forward_04",
				"nz_iw7_cp_zom_walk_forward_01",
				"nz_iw7_cp_zom_walk_forward_02",
				"nz_iw7_cp_zom_walk_forward_03",
				"nz_iw7_cp_zom_walk_forward_04",
				"nz_s1_zom_core_walk_2",
				"nz_s1_zom_core_walk_3",
				"nz_s1_zom_core_walk_4",
				"nz_s1_zom_core_walk_5",
				"nz_iw7_cp_zom_shamble_forward_01",
				"nz_iw7_cp_zom_shamble_forward_02",
				"nz_iw7_cp_zom_shamble_forward_03",
				"nz_iw7_cp_zom_shamble_forward_04",
				"nz_iw7_cp_zom_walk_forward_01",
				"nz_iw7_cp_zom_walk_forward_02",
				"nz_iw7_cp_zom_walk_forward_03",
				"nz_iw7_cp_zom_walk_forward_04",
				"nz_s2_core_walk_v1",
				"nz_s2_core_walk_v2",
				"nz_s2_core_walk_v3",
				"nz_s2_core_walk_v4",
				"nz_s2_core_walk_v5",
				"nz_s2_core_walk_v6",
				"nz_s2_core_walk_v7",
				"nz_s2_core_walk_v8",
				"nz_s2_core_walk_v9",
				"nz_s2_core_walk_v10",
				"nz_s2_core_walk_v11",
				"nz_s2_core_walk_v12",
				"nz_s2_core_walk_v1",
				"nz_s2_core_walk_v2",
				"nz_s2_core_walk_v3",
				"nz_s2_core_walk_v4",
				"nz_s2_core_walk_v5",
				"nz_s2_core_walk_v6",
				"nz_s2_core_walk_v7",
				"nz_s2_core_walk_v8",
				"nz_s2_core_walk_v9",
				"nz_s2_core_walk_v10",
				"nz_s2_core_walk_v11",
				"nz_s2_core_walk_v12",
				"nz_gm_walk",
				"nz_gm_crouchwalk",
			},
			LowgMovementSequence = {
				"nz_walk_lowg_v1",
				"nz_walk_lowg_v2",
				"nz_walk_lowg_v3",
				"nz_walk_lowg_v4",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",
				"nz_s4_3arc_crawl_sprint",
				"nz_iw7_cp_zom_prone_shamble_forward_01",
				"nz_iw7_cp_zom_prone_shamble_forward_02",
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
			PatrolMovementSequence = {
				"nz_base_zombie_idle_patrol_01",
				"nz_base_zombie_idle_patrol_02",
				"nz_base_zombie_idle_patrol_03",
				"nz_base_zombie_idle_patrol_04",
				"nz_base_zombie_idle_patrol_05",
				"nz_base_zombie_idle_patrol_06",
				"nz_base_zombie_idle_patrol_07",
			},
			AttackSequences = {WalkAttackSequences},
			StandAttackSequences = {AttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {JumpSequences},
			CrawlJumpSequences = {CrawlJumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {walksounds},
		}
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			MovementSequence = {
				"nz_iw7_cp_zom_run_forward_01",
				"nz_iw7_cp_zom_run_forward_02",
				"nz_iw7_cp_zom_run_forward_03",
				"nz_iw7_cp_zom_run_forward_04",
				"nz_iw7_cp_zom_run_forward_05",
				"nz_iw7_cp_zom_run_forward_01",
				"nz_iw7_cp_zom_run_forward_02",
				"nz_iw7_cp_zom_run_forward_03",
				"nz_iw7_cp_zom_run_forward_04",
				"nz_iw7_cp_zom_run_forward_05",
				"nz_s2_core_run_v1",
				"nz_s2_core_run_v2",
				"nz_s2_core_run_v3",
				"nz_s2_core_run_v4",
				"nz_s2_core_run_v5",
				"nz_s2_core_run_v6",
				"nz_s2_core_run_v7",
				"nz_s2_core_run_v8",
				"nz_s2_core_run_v9",
				"nz_s2_core_run_v10",
				"nz_s2_core_run_v11",
				"nz_s2_core_run_v12",
				"nz_s2_core_run_v13",
				"nz_s2_core_run_v1",
				"nz_s2_core_run_v2",
				"nz_s2_core_run_v3",
				"nz_s2_core_run_v4",
				"nz_s2_core_run_v5",
				"nz_s2_core_run_v6",
				"nz_s2_core_run_v7",
				"nz_s2_core_run_v8",
				"nz_s2_core_run_v9",
				"nz_s2_core_run_v10",
				"nz_s2_core_run_v11",
				"nz_s2_core_run_v12",
				"nz_s2_core_run_v13",
				"nz_l4d_crouchrun",
				"nz_gm_crouchrun",
			},
			LowgMovementSequence = {
				"nz_run_lowg_v1",
				"nz_run_lowg_v2",
				"nz_run_lowg_v3",
				"nz_run_lowg_v4",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",
				"nz_s4_3arc_crawl_sprint",
				"nz_iw7_cp_zom_prone_shamble_forward_01",
				"nz_iw7_cp_zom_prone_shamble_forward_02",
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
			PatrolMovementSequence = {
				"nz_base_zombie_idle_patrol_01",
				"nz_base_zombie_idle_patrol_02",
				"nz_base_zombie_idle_patrol_03",
				"nz_base_zombie_idle_patrol_04",
				"nz_base_zombie_idle_patrol_05",
				"nz_base_zombie_idle_patrol_06",
				"nz_base_zombie_idle_patrol_07",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},
			Bo3AttackSequences = {StinkyRunAttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {RunJumpSequences},
			CrawlJumpSequences = {CrawlJumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {runsounds},
		}
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_legacy_jap_run_v3",
				"nz_legacy_jap_run_v3",
				"nz_t9_base_sprint_ad_v02",
				"nz_t9_base_sprint_au_v01",
				"nz_t9_base_sprint_au_v02",
				"nz_t9_base_sprint_ad_v01",
				"nz_t9_base_sprint_ad_v02",
				"nz_t9_base_sprint_au_v01",
				"nz_t9_base_sprint_au_v02",
				"nz_bo3_zombie_sprint_v4",
				"nz_legacy_sprint_v5",
				"nz_bo3_zombie_sprint_v4",
				"nz_legacy_sprint_v5",
				"nz_s1_zom_core_run_1",
				"nz_s1_zom_core_run_2",
				"nz_s1_zom_core_run_3",
				"nz_s1_zom_core_run_4",
				"nz_s1_zom_core_run_5",
				"nz_s1_zom_core_run_1",
				"nz_s1_zom_core_run_2",
				"nz_s1_zom_core_run_3",
				"nz_s1_zom_core_run_4",
				"nz_s1_zom_core_run_5",
				"nz_gm_run",
				"nz_gm_crouchsprint",
				"nz_s2_core_sprint_v1",
				"nz_s2_core_sprint_v2",
				"nz_s2_core_sprint_v3",
				"nz_s2_core_sprint_v4",
				"nz_s2_core_sprint_v5",
				"nz_s2_core_sprint_v6",
				"nz_s2_core_sprint_v7",
				"nz_s2_core_sprint_v8",
				"nz_s2_core_sprint_v9",
				"nz_s2_core_sprint_v10",
				"nz_s2_core_sprint_v11",
				"nz_s2_core_sprint_v12",
				"nz_s2_core_sprint_v13",
				"nz_s2_core_sprint_v14",
				"nz_s2_core_sprint_v15",
				"nz_s2_core_sprint_v16",
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
				"nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",
				"nz_s4_3arc_crawl_sprint",
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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
			PatrolMovementSequence = {
				"nz_base_zombie_idle_patrol_01",
				"nz_base_zombie_idle_patrol_02",
				"nz_base_zombie_idle_patrol_03",
				"nz_base_zombie_idle_patrol_04",
				"nz_base_zombie_idle_patrol_05",
				"nz_base_zombie_idle_patrol_06",
				"nz_base_zombie_idle_patrol_07",
			},
			AttackSequences = {SprintAttackSequences},
			StandAttackSequences = {AttackSequences},
			Bo3AttackSequences = {StinkyRunAttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {SprintJumpSequences},
			CrawlJumpSequences = {CrawlJumpSequences},

			Climb36 = {FastClimbUp36},
			Climb48 = {FastClimbUp48},
			Climb72 = {FastClimbUp72},
			Climb96 = {FastClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {runsounds},
		}
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			MovementSequence = {
				"nz_l4d_run_01",
				"nz_l4d_run_02",
				"nz_l4d_run_03",
				"nz_l4d_run_04",
				"nz_l4d_run_05",
				"nz_s1_zom_core_sprint_1",
				"nz_s1_zom_core_sprint_2",
				"nz_s1_zom_core_sprint_3",
				"nz_s1_zom_core_sprint_4",
				"nz_s1_zom_core_sprint_5",
				"nz_s1_zom_core_sprint_6",
			},
			LowgMovementSequence = {
				"nz_supersprint_lowg",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_v1",
				"nz_crawl_v2",
				"nz_crawl_v5",
				"nz_crawl_sprint_v1",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",
				"nz_s4_3arc_crawl_sprint",
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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
			PatrolMovementSequence = {
				"nz_base_zombie_idle_patrol_01",
				"nz_base_zombie_idle_patrol_02",
				"nz_base_zombie_idle_patrol_03",
				"nz_base_zombie_idle_patrol_04",
				"nz_base_zombie_idle_patrol_05",
				"nz_base_zombie_idle_patrol_06",
				"nz_base_zombie_idle_patrol_07",
			},
			AttackSequences = {SuperSprintAttackSequences},
			StandAttackSequences = {AttackSequences},
			Bo3AttackSequences = {StinkyRunAttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {SprintJumpSequences},
			CrawlJumpSequences = {CrawlJumpSequences},

			Climb36 = {FastClimbUp36},
			Climb48 = {FastClimbUp48},
			Climb72 = {FastClimbUp72},
			Climb96 = {FastClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {runsounds},
		}
	}}
}

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

ENT.IdleSequence = "nz_iw7_cp_zom_stand_idle_01"

ENT.IdleSequenceAU = "nz_iw7_cp_zom_stand_idle_02"

ENT.ExoLeapAttackSequences = {
	"nz_zom_exo_lunge_atk_2h_01",
	"nz_zom_exo_lunge_atk_l_01",
	"nz_zom_exo_lunge_atk_r_01",
}

ENT.ProneLeapAttackSequences = {
	"nz_zom_exo_crawl_lunge",
	"nz_zom_exo_crawl_lunge_2",
	"nz_zom_exo_crawl_lunge_3",
}

ENT.DeathSounds = {
	"nz_moo/zombies/vox/_robot/death/death_00.mp3",
	"nz_moo/zombies/vox/_robot/death/death_01.mp3",
	"nz_moo/zombies/vox/_robot/death/death_02.mp3",
	"nz_moo/zombies/vox/_robot/death/death_03.mp3",
	"nz_moo/zombies/vox/_robot/death/death_04.mp3",
	"nz_moo/zombies/vox/_robot/death/death_05.mp3",
	"nz_moo/zombies/vox/_robot/death/death_06.mp3",
	"nz_moo/zombies/vox/_robot/death/death_07.mp3",
	"nz_moo/zombies/vox/_robot/death/death_08.mp3",
	"nz_moo/zombies/vox/_robot/death/death_09.mp3",
	"nz_moo/zombies/vox/_robot/death/death_10.mp3",
	"nz_moo/zombies/vox/_robot/death/death_11.mp3",
	"nz_moo/zombies/vox/_robot/death/death_12.mp3",
	"nz_moo/zombies/vox/_robot/death/death_13.mp3",
	"nz_moo/zombies/vox/_robot/death/death_14.mp3",
	"nz_moo/zombies/vox/_robot/death/death_15.mp3",
}

ENT.ElecSounds = {
	"nz_moo/zombies/vox/_robot/elec/elec_00.mp3",
	"nz_moo/zombies/vox/_robot/elec/elec_01.mp3",
	"nz_moo/zombies/vox/_robot/elec/elec_02.mp3",
	"nz_moo/zombies/vox/_robot/elec/elec_03.mp3",
	"nz_moo/zombies/vox/_robot/elec/elec_04.mp3",
	"nz_moo/zombies/vox/_robot/elec/elec_05.mp3",
}

ENT.NukeDeathSounds = {
	"nz_moo/zombies/vox/nuke_death/soul_00.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_01.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_02.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_03.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_04.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_05.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_06.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_07.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_08.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_09.mp3",
	"nz_moo/zombies/vox/nuke_death/soul_10.mp3"
}

ENT.AttackSounds = {
	"nz_moo/zombies/vox/_robot/attack/attack_00.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_01.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_02.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_03.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_04.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_05.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_06.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_07.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_08.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_09.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_10.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_11.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_12.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_13.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_14.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_15.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_16.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_17.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_18.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_19.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_20.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_21.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_22.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_23.mp3",
	"nz_moo/zombies/vox/_robot/attack/attack_24.mp3",
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps-2.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps-3.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps-4.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps-5.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run-2.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run-3.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run-4.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run-5.mp3"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_00.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_01.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_02.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_robot/crawl/crawl_00.mp3"),
	Sound("nz_moo/zombies/vox/_robot/crawl/crawl_01.mp3"),
	Sound("nz_moo/zombies/vox/_robot/crawl/crawl_02.mp3"),
	Sound("nz_moo/zombies/vox/_robot/crawl/crawl_03.mp3"),
	Sound("nz_moo/zombies/vox/_robot/crawl/crawl_04.mp3"),
	Sound("nz_moo/zombies/vox/_robot/crawl/crawl_05.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_robot/taunt/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_robot/taunt/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_robot/taunt/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_robot/taunt/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_robot/taunt/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_robot/taunt/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_robot/taunt/taunt_06.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_robot/behind/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_robot/behind/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_robot/behind/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_robot/behind/behind_03.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local speeds = nzRound:GetZombieCoDSpeeds()
		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 100 )
		end

		self:SetHealth( nzRound:GetZombieHealth() or 75 )
		self.AttackDamage = nzRound:GetZombieDamage() or 50
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


function ENT:PostAdditionalZombieStuff()
	if SERVER then
		if self:TargetInRange(150) and !self:IsAttackBlocked() and self:GetRunSpeed() >= 175 and !self:GetCrawler() and !self:GetSpecialAnimation() and math.random(10) == 1 then
			if self:TargetInRange(50) then return end
			self:ExoLeapAttack()
		end
		if self:TargetInRange(200) and !self:IsAttackBlocked() and self:GetCrawler() and !self:GetSpecialAnimation() and math.random(15) == 1 then
			if self:TargetInRange(75) then return end
			self:ProneLeapAttack()
		end
	end
end

function ENT:ExoLeapAttack()
	local exoleapseq = self.ExoLeapAttackSequences[math.random(#self.ExoLeapAttackSequences)]
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.IsExoLeaping = true
		self:PlaySequenceAndMove(exoleapseq, 1, self.FaceEnemy)
		self.IsExoLeaping = false
		self:SetSpecialAnimation(false)
	end)
end

function ENT:ProneLeapAttack()
	local proneleapseq = self.ProneLeapAttackSequences[math.random(#self.ProneLeapAttackSequences)]
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.IsProneLeaping = true
		self:PlaySequenceAndMove(proneleapseq, 1, self.FaceEnemy)
		self.IsProneLeaping = false
		self:SetSpecialAnimation(false)
	end)
end


-- har har harhar har har harhar harhar
