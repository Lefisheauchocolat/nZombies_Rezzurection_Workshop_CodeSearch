AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Cheaple"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/wavy/wavy_rigs/lethal_necrotics/cheaple/wavy_lnr_zombie_cheaple.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/lethal_necrotics/cheaple/wavy_lnr_zombie_cheaple.mdl", Skin = 1, Bodygroups = {0,0}},
}

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb"}
local spawnrun = {"nz_spawn_ground_v1_run"}
local spawnfast = {"nz_spawn_ground_climbout_fast", "nz_s4_3arc_traverse_riser"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

ENT.SoundDelayMin = 1
ENT.SoundDelayMax = 3

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
	"nz_l4d_death_running_11a",
	"nz_l4d_death_running_11g",
	"nz_l4d_death_02a",
	"nz_l4d_death_11_02d",
	"nz_t9_dth_f_chest_lt_00",
	"nz_t9_dth_f_chest_lt_01",
	"nz_t9_dth_f_chest_lt_02",
	"nz_t9_dth_f_chest_lt_03",
	"nz_t9_dth_f_chest_lt_04",
	"nz_t9_dth_f_chest_lt_05",
	"nz_t9_dth_f_chest_lt_06",
	"nz_t9_dth_f_chest_lt_07",
	"nz_t9_dth_f_chest_lt_08",
	"nz_t9_dth_f_chest_lt_09",
	"nz_t9_dth_f_head_lt_00",
	"nz_t9_dth_f_head_lt_01",
	"nz_t9_dth_f_head_lt_02",
}

ENT.CrawlDeathSequences = {
	"nz_crawl_death_v1",
	"nz_crawl_death_v2",
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
	{seq = "nz_crawl_attack_v1", dmgtimes = {0.75, 1.65}},
	{seq = "nz_crawl_attack_v2", dmgtimes = {0.65}},
}

local CrawlJumpSequences = {
	{seq = "nz_barricade_crawl_1"},
	{seq = "nz_barricade_crawl_2"},
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
	{seq = "nz_attack_stand_ad_1"},
	{seq = "nz_attack_stand_au_1"},
	{seq = "nz_legacy_attack_v3"},
	{seq = "nz_legacy_attack_v6"},
	{seq = "nz_legacy_attack_v4"},
	{seq = "nz_legacy_attack_v11"},
	{seq = "nz_legacy_attack_v12"},
	{seq = "nz_legacy_attack_superwindmill"},
	{seq = "nz_attack_stand_long"},
	{seq = "nz_fwd_ad_attack_v1"},
	{seq = "nz_fwd_ad_attack_v2"},
	{seq = "nz_t8_attack_stand_larm_1"},
	{seq = "nz_t8_attack_stand_larm_2"},
	{seq = "nz_t8_attack_stand_larm_3"},
	{seq = "nz_t8_attack_stand_rarm_1"},
	{seq = "nz_t8_attack_stand_rarm_2"},
	{seq = "nz_t8_attack_stand_rarm_3"},
}

local WalkAttackSequences = {
	{seq = "nz_walk_ad_attack_v1"}, -- Quick single swipe
	{seq = "nz_walk_ad_attack_v2"}, -- Slowish double swipe
	{seq = "nz_walk_ad_attack_v3"}, -- Slowish single swipe
	{seq = "nz_walk_ad_attack_v4"}, -- Quickish double swipe
	{seq = "nz_walk_ad_attack_v5"},
	{seq = "nz_walk_ad_attack_v6"},
	{seq = "nz_walk_ad_attack_v7"},
	{seq = "nz_walk_ad_attack_v8"},
	{seq = "nz_walk_ad_attack_v9"},
	{seq = "nz_t8_attack_walk_larm_1"},
	{seq = "nz_t8_attack_walk_rarm_3"},
	{seq = "nz_t8_attack_walk_larm_2"},
	{seq = "nz_t8_attack_walk_rarm_6"},
}

local RunAttackSequences = {
	{seq = "nz_t8_attack_run_larm_1"},
	{seq = "nz_t8_attack_run_larm_2"},
	{seq = "nz_t8_attack_run_larm_3"},
	{seq = "nz_t8_attack_run_larm_4"},
	{seq = "nz_t8_attack_run_rarm_1"},
	{seq = "nz_t8_attack_run_rarm_2"},
	{seq = "nz_t8_attack_run_rarm_3"},
	{seq = "nz_t8_attack_run_rarm_4"},
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
	{seq = "nz_t8_attack_sprint_larm_1"},
	{seq = "nz_t8_attack_sprint_larm_2"},
	{seq = "nz_t8_attack_sprint_larm_3"},
	{seq = "nz_t8_attack_sprint_larm_4"},
	{seq = "nz_t8_attack_sprint_rarm_1"},
	{seq = "nz_t8_attack_sprint_rarm_2"},
	{seq = "nz_t8_attack_sprint_rarm_3"},
	{seq = "nz_t8_attack_sprint_rarm_4"},
}

local SuperSprintAttackSequences = {
	{seq = "nz_t8_attack_supersprint_larm_1"},
	{seq = "nz_t8_attack_supersprint_larm_2"},
	{seq = "nz_t8_attack_supersprint_rarm_1"},
	{seq = "nz_t8_attack_supersprint_rarm_2"},
}

local JumpSequences = {
	{seq = "nz_barricade_trav_walk_1"},
	{seq = "nz_barricade_trav_walk_2"},
	{seq = "nz_barricade_trav_walk_3"},
}
local RunJumpSequences = {
	{seq = "nz_barricade_run_1"},
	{seq = "nz_l4d_mantle_over_36"},
}
local SprintJumpSequences = {
	{seq = "nz_barricade_sprint_1"},
	{seq = "nz_barricade_sprint_2"},
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
				"nz_gm_walk",
				"nz_gm_crouchwalk",
				"nz_gm_zwalk_01",
				"nz_gm_zwalk_02",
				"nz_gm_zwalk_03",
				"nz_gm_zwalk_04",
				"nz_gm_zwalk_05",
				"nz_gm_zwalk_06",
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
		},
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_gm_walk",
				"nz_gm_crouchwalk",
				"nz_gm_zwalk_01",
				"nz_gm_zwalk_02",
				"nz_gm_zwalk_03",
				"nz_gm_zwalk_04",
				"nz_gm_zwalk_05",
				"nz_gm_zwalk_06",
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
				"nz_gm_run",
				"nz_gm_zrun",
				"nz_l4d_crouchrun",
				"nz_l4d_quadrun",
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
		},
		{
			SpawnSequence = {spawnrun},
			MovementSequence = {
				"nz_gm_run",
				"nz_gm_zrun",
				"nz_l4d_crouchrun",
				"nz_l4d_quadrun",
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
				"nz_bo3_zombie_sprint_v4",
				"nz_fast_sprint_v2",
				"nz_gm_run_charge",
				"nz_gm_zrun_fast",
				"nz_gm_crouchrun",
				"nz_gm_crouchsprint",
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
		},
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_bo3_zombie_sprint_v4",
				"nz_fast_sprint_v2",
				"nz_gm_run_charge",
				"nz_gm_zrun_fast",
				"nz_gm_crouchrun",
				"nz_gm_crouchsprint",
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
				"nz_gm_sprint",
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
		},
		{
			SpawnSequence = {spawnsuperfast},
			MovementSequence = {
				"nz_l4d_run_01",
				"nz_l4d_run_02",
				"nz_l4d_run_03",
				"nz_l4d_run_04",
				"nz_l4d_run_05",
				"nz_gm_sprint",
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

ENT.IdleSequence = "nz_l4d_idlealert_01a"

ENT.IdleSequenceAU = "nz_l4d_idlealert_03"

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
	"nz_moo/zombies/vox/_l4d/elec/ignite14.mp3"
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

-- Cheaple zombies are real. You are not safe.
