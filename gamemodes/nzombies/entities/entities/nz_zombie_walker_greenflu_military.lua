AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_ranger.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_iw7_cp_zom_spawn_ground_02", "nz_iw7_cp_zom_spawn_ground_06", "nz_iw7_cp_zom_spawn_ground_walk_01", "nz_iw7_cp_zom_spawn_ground_walk_03", "nz_iw7_cp_zom_spawn_ground_walk_04"}
local spawnrun = {"nz_iw7_cp_zom_spawn_ground_run_01", "nz_iw7_cp_zom_spawn_ground_run_02", "nz_iw7_cp_zom_spawn_ground_run_03", "nz_iw7_cp_zom_spawn_ground_run_04"}
local spawnfast = {"nz_iw7_cp_zom_spawn_ground_run_01", "nz_iw7_cp_zom_spawn_ground_run_02", "nz_iw7_cp_zom_spawn_ground_run_03", "nz_iw7_cp_zom_spawn_ground_run_04"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

ENT.SoundDelayMin = 1
ENT.SoundDelayMax = 3
ENT.HeavyAttackDamage = 50

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
	Sound("nz_moo/zombies/vox/_l4d/amb/alert13.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert16.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert25.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert26.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert42.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert44.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert50.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert51.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert54.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/alert55.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/become_alert11.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/become_alert12.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/become_alert26.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/become_alert29.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/become_alert41.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/become_alert54.mp3"),
	
	Sound("nz_moo/zombies/vox/_l4d/amb/become_alert56.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/hiss01.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/howl01.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/idle_breath_04.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/moan02.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/moan04.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/moan07.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/mumbling01.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/mumbling02.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/mumbling03.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/mumbling04.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/mumbling05.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/mumbling06.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/mumbling07.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/mumbling08.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/amb/recognize08.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim20.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim21.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim22.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim23.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim24.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim25.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim26.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim27.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim28.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim29.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim30.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim31.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim32.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim33.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim34.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim35.mp3"),
	
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim36.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim37.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim201.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim211.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim221.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim231.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim241.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim251.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim261.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim271.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim311.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim331.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim341.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim351.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim361.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim371.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/become_enraged07.mp3"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
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
				"nz_l4d_walk",
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
		},
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
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
				"nz_l4d_walk",
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
				"nz_l4d_crouchrun",
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
		},
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
				"nz_l4d_crouchrun",
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
				"nz_s1_zom_core_run_1",
				"nz_s1_zom_core_run_2",
				"nz_s1_zom_core_run_3",
				"nz_s1_zom_core_run_4",
				"nz_s1_zom_core_run_5",
				"nz_legacy_sprint_v4",
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
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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
		},
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_s1_zom_core_run_1",
				"nz_s1_zom_core_run_2",
				"nz_s1_zom_core_run_3",
				"nz_s1_zom_core_run_4",
				"nz_s1_zom_core_run_5",
				"nz_legacy_sprint_v4",
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
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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
		},
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
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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

ENT.IdleSequence = "nz_l4d_idlealert_01a"

ENT.IdleSequenceAU = "nz_l4d_idlealert_03"

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
	"nz_moo/zombies/vox/_l4d/death/death_14.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_17.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_19.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_22.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_23.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_24.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_27.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_28.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_29.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_30.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_33.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_34.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_35.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_36.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_37.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_38.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_40.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_41.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_42.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_44.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_46.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_47.mp3",
	"nz_moo/zombies/vox/_l4d/death/death_49.mp3"
}

ENT.ElecSounds = {
	"nz_moo/zombies/vox/_l4d/elec/ignite09.mp3",
	"nz_moo/zombies/vox/_l4d/elec/ignite10.mp3",
	"nz_moo/zombies/vox/_l4d/elec/ignite11.mp3",
	"nz_moo/zombies/vox/_l4d/elec/ignite12.mp3",
	"nz_moo/zombies/vox/_l4d/elec/ignite13.mp3",
	"nz_moo/zombies/vox/_l4d/elec/ignite14.mp3",
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
	"nz_moo/zombies/vox/_l4d/attack/been_shot_01.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_02.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_04.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_06.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_08.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_09.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_13.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_31.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_32.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_33.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_34.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_52.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_54.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_55.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_57.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_58.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_59.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_67.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_72.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_78.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_80.mp3",
	"nz_moo/zombies/vox/_l4d/attack/rage_82.mp3",
	"nz_moo/zombies/vox/_l4d/attack/shoved_1.mp3",
	"nz_moo/zombies/vox/_l4d/attack/shoved_05.mp3",
	"nz_moo/zombies/vox/_l4d/attack/shoved_08.mp3",
	"nz_moo/zombies/vox/_l4d/attack/shoved_16.mp3"
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_l4d/crawl/become_alert21.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shoved_10.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shoved_11.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shoved_12.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shoved_13.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shoved_17.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shoved_long_1.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shoved_long_2.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shoved_long_3.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shout02.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/crawl/shout04.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/mute_00.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	"nz_moo/zombies/footsteps/_l4d/walk/concrete1.mp3",
	"nz_moo/zombies/footsteps/_l4d/walk/concrete2.mp3",
	"nz_moo/zombies/footsteps/_l4d/walk/concrete3.mp3",
	"nz_moo/zombies/footsteps/_l4d/walk/concrete4.mp3",
}

ENT.CustomRunFootstepsSounds = {
	"nz_moo/zombies/footsteps/_l4d/run/concrete1.mp3",
	"nz_moo/zombies/footsteps/_l4d/run/concrete2.mp3",
	"nz_moo/zombies/footsteps/_l4d/run/concrete3.mp3",
	"nz_moo/zombies/footsteps/_l4d/run/concrete4.mp3",
}

ENT.CustomAttackImpactSounds = {
	"nz_moo/zombies/plr_impact/_l4d/punch_boxing_bodyhit03.mp3",
	"nz_moo/zombies/plr_impact/_l4d/punch_boxing_bodyhit04.mp3",
	"nz_moo/zombies/plr_impact/_l4d/punch_boxing_facehit4.mp3",
	"nz_moo/zombies/plr_impact/_l4d/punch_boxing_facehit5.mp3",
	"nz_moo/zombies/plr_impact/_l4d/punch_boxing_facehit6.mp3",
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_l4d/behind/squeal_1.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/behind/squeal_2.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/behind/squeal_3.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/behind/squeal_4.mp3"),
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
			self:SetHealth( nzRound:GetZombieHealth() or 75 )
			
			self.IsExoLeaping = false
			self.IsProneLeaping = false
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

ENT.PainSounds = {
	"nz_moo/zombies/vox/_l4d/attack/shoved_05.mp3",
	"nz_moo/zombies/vox/_l4d/attack/shoved_08.mp3",
	"nz_moo/zombies/vox/_l4d/attack/shoved_1.mp3",
	"nz_moo/zombies/vox/_l4d/attack/shoved_16.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_34.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_13.mp3",
	"nz_moo/zombies/vox/_l4d/attack/been_shot_06.mp3",
}

ENT.GasVox = {
	"nz_moo/zombies/vox/mute_00.mp3",
}

ENT.GasAttack = {
	"nz_moo/zombies/vox/mute_00.mp3",
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_l4d/taunt/ignite10.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/ignite11.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/ignite12.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/ignite13.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/ignite14.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/rage_50.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/rage_51.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/rage_56.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/rage_76.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/rage_79.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/rage_80.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/shoved_06.mp3"),
}

function ENT:Sound()
	if self:GetAttacking() or !self:Alive() or self:GetDecapitated() then return end

	local vol = 80

	for k,v in nzLevel.GetZombieArray() do -- FUCK YOU, ARRAYS ARE AWESOME!!!
		if k < 2 then vol = 511 else vol = 80 end
	end

	if self.BehindSoundDistance > 0 -- We have enabled behind sounds
		and IsValid(self.Target)
		and self.Target:IsPlayer() -- We have a target and it's a player within distance
		and self:GetRangeTo(self.Target) <= self.BehindSoundDistance
		and (self.Target:GetPos() - self:GetPos()):GetNormalized():Dot(self.Target:GetAimVector()) >= 0 then -- If the direction towards the player is same 180 degree as the player's aim (away from the zombie)
			self:PlaySound(self.BehindSounds[math.random(#self.BehindSounds)], 100, math.random(98, 102), 1, 2) -- Play the behind sound, and a bit louder!
	
	--[[ A big "if then" thingy for playing other sounds. ]]--
	elseif self.ElecSounds and (self.BO4IsShocked and self:BO4IsShocked() or self.BO4IsScorped and self:BO4IsScorped() or self.BO4IsSpinning and self:BO4IsSpinning()) then
		self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)],vol, math.random(98, 102), 1, 2)
	elseif self:GetCrawler() and self.CrawlerSounds then
		self:PlaySound(self.CrawlerSounds[math.random(#self.CrawlerSounds)],vol, math.random(98, 102), 1, 2)
	elseif self.PassiveSounds then
		self:PlaySound(self.PassiveSounds[math.random(#self.PassiveSounds)],vol, math.random(98, 102), 1, 2)
	else
		-- We still delay by max sound delay even if there was no sound to play
		self.NextSound = CurTime() + self.SoundDelayMax
	end
end

function ENT:PostAdditionalZombieStuff()
	if SERVER then
		if self:TargetInRange(150) and !self:IsAttackBlocked() and self:GetRunSpeed() >= 175 and !self:GetCrawler() and !self:GetSpecialAnimation() and !nzPowerUps:IsPowerupActive("timewarp") and math.random(10) == 1 then
			if self:TargetInRange(50) then return end
			self:ExoLeapAttack()
		end
		if self:TargetInRange(200) and !self:IsAttackBlocked() and self:GetCrawler() and !self:GetSpecialAnimation() and !nzPowerUps:IsPowerupActive("timewarp") and math.random(15) == 1 then
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

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 70)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 70)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
	end
	if e == "crawl_hand" then
		if self.CustomCrawlImpactSounds then
			self:EmitSound(self.CrawlImpactSounds[math.random(#self.CrawlImpactSounds)], 70)
		else
			self:EmitSound("CoDZ_Zombie.StepCrawl")
		end
	end
	if e == "melee" or e == "melee_heavy" then
		if self:BomberBuff() and self.GasAttack then
			self:EmitSound(self.GasAttack[math.random(#self.GasAttack)], 100, math.random(95, 105), 1, 2)
		else
			if self.AttackSounds then
				self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
			end
		end
		if e == "melee_heavy" then
			self.HeavyAttack = true
		end
		self:DoAttackDamage()
	end
	if e == "pull_plank" then
		if IsValid(self) and self:Alive() then
			if IsValid(self.BarricadePlankPull) and IsValid(self.Barricade) then
				self.Barricade:RemovePlank(self.BarricadePlankPull)
			end
		end
	end
	if e == "generic_taunt" then
		if self.TauntSounds then
			self:EmitSound(self.TauntSounds[math.random(#self.TauntSounds)], 100, math.random(98, 102), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "special_taunt" then
		if self.TauntSounds then
			self:EmitSound("nz_moo/zombies/vox/_l4d/taunt/mega_mob_incoming.mp3", 100, math.random(98, 102), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "base_ranged_rip" then
		ParticleEffectAttach("ins_blood_dismember_limb", 4, self, 5)
		self:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(0,3)..".mp3", 100, math.random(95,105))
		self:EmitSound("nz_moo/zombies/gibs/head/head_explosion_0"..math.random(4)..".mp3", 65, math.random(95,105))
	end
	if e == "base_ranged_throw" then
		self:EmitSound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_0"..math.random(0,2)..".mp3", 95)

		local larmfx_tag = self:LookupBone("j_wrist_le")

		self.Guts = ents.Create("nz_gib")
		self.Guts:SetPos(self:GetBonePosition(larmfx_tag))
		self.Guts:Spawn()

		local phys = self.Guts:GetPhysicsObject()
		local target = self:GetTarget()
		local movementdir
		if IsValid(phys) and IsValid(target) then
			phys:SetVelocity(self.Guts:getvel(target:EyePos() - Vector(0,0,7), self:EyePos(), 0.95))
		end
	end
	if e == "death_ragdoll" then
		self:BecomeRagdoll(DamageInfo())
	end
	if e == "start_traverse" then
		--print("starttraverse")
		self.TraversalAnim = true
	end
	if e == "finish_traverse" then
		--print("finishtraverse")
		self.TraversalAnim = false
	end
end

-- Franshish :)

-- https://twitter.com/ghostlymoo1/status/1631776813050482688


