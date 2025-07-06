AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false

ENT.SoundDelayMin = 1
ENT.SoundDelayMax = 2

ENT.MinSoundPitch = 80
ENT.MaxSoundPitch = 120
ENT.SoundVolume = 95

ENT.Models = {
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_exo2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_shotgun.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/marines/moo_codz_s1_zom_marine_shotgun2.mdl", Skin = 0, Bodygroups = {0,0}},

	{Model = "models/moo/_codz_ports/s1/civ/moo_codz_s1_zom_civ_ruban_male.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/civ/moo_codz_s1_zom_civ_ruban_male.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/civ/moo_codz_s1_zom_civ_ruban_male.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/civ/moo_codz_s1_zom_civ_ruban_male2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/civ/moo_codz_s1_zom_civ_ruban_male2.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s1/civ/moo_codz_s1_zom_civ_ruban_male2.mdl", Skin = 2, Bodygroups = {0,0}},
}

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb", "nz_iw7_cp_zom_spawn_ground_02", "nz_iw7_cp_zom_spawn_ground_06", "nz_iw7_cp_zom_spawn_ground_walk_01", "nz_iw7_cp_zom_spawn_ground_walk_03", "nz_iw7_cp_zom_spawn_ground_walk_04"}
local spawnrun = {"nz_spawn_ground_v1_run", "nz_iw7_cp_zom_spawn_ground_run_01", "nz_iw7_cp_zom_spawn_ground_run_02", "nz_iw7_cp_zom_spawn_ground_run_03", "nz_iw7_cp_zom_spawn_ground_run_04"}
local spawnfast = {"nz_spawn_ground_climbout_fast", "nz_s4_3arc_traverse_riser"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

local crawlspawnwalk = {"nz_base_zombie_crawl_out_walk_01",}
local crawlspawnrun = {"nz_base_zombie_crawl_out_run_01","nz_base_zombie_crawl_out_run_02",}
local crawlspawnsprint = {"nz_base_zombie_crawl_out_sprint_01","nz_base_zombie_crawl_out_sprint_01",}
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
	"nz_zombie_tesla_death_e",
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
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
	{seq = "nz_walk_ad_attack_v5"},
	{seq = "nz_walk_ad_attack_v6"},
	{seq = "nz_walk_ad_attack_v7"},
	{seq = "nz_walk_ad_attack_v8"},
	{seq = "nz_walk_ad_attack_v9"},
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

local WalkJumpSequencesMiddle = {
	{seq = "nz_base_zombie_walk_win_trav_m_01"},
	{seq = "nz_base_zombie_walk_win_trav_m_02"},
	{seq = "nz_base_zombie_walk_win_trav_m_03"},
}

local WalkJumpSequencesLeft = {
	{seq = "nz_base_zombie_walk_win_trav_l_01"},
}

local WalkJumpSequencesRight = {
	{seq = "nz_base_zombie_walk_win_trav_r_01"},
}

local RunJumpSequencesMiddle = {
	{seq = "nz_base_zombie_run_win_trav_m_01"},
}

local RunJumpSequencesLeft = {
	{seq = "nz_base_zombie_run_win_trav_l_01"},
}

local RunJumpSequencesRight = {
	{seq = "nz_base_zombie_run_win_trav_r_01"},
}

local SprintJumpSequencesMiddle = {
	{seq = "nz_base_zombie_sprint_win_trav_m_01"},
	{seq = "nz_base_zombie_sprint_win_trav_m_02"},
}

local SprintJumpSequencesLeft = {
	{seq = "nz_base_zombie_sprint_win_trav_l_01"},
}

local SprintJumpSequencesRight = {
	{seq = "nz_base_zombie_sprint_win_trav_r_01"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_33.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_34.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_35.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_36.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_37.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_38.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_39.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_40.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_41.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_42.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_43.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_48.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_49.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_50.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_51.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_52.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_53.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_54.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_55.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_low_56.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_33.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_idle_high_35.mp3"),
}

ENT.IdleSequence = "nz_iw7_cp_zom_stand_idle_01"

ENT.IdleSequenceAU = "nz_iw7_cp_zom_stand_idle_02"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			CrawlOutSequences = {crawlspawnwalk},
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
			Bo3AttackSequences = {StinkyRunAttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {WalkJumpSequencesMiddle},
			JumpSequencesLeft = {WalkJumpSequencesLeft},
			JumpSequencesRight = {WalkJumpSequencesRight},
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
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			CrawlOutSequences = {crawlspawnrun},
			MovementSequence = {
				"nz_iw7_cp_zom_run_forward_01",
				"nz_iw7_cp_zom_run_forward_02",
				"nz_iw7_cp_zom_run_forward_03",
				"nz_iw7_cp_zom_run_forward_04",
				"nz_iw7_cp_zom_run_forward_05",
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

			JumpSequences = {RunJumpSequencesMiddle},
			JumpSequencesLeft = {RunJumpSequencesLeft},
			JumpSequencesRight = {RunJumpSequencesRight},
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
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_s1_zom_core_run_1",
				"nz_s1_zom_core_run_2",
				"nz_s1_zom_core_run_3",
				"nz_s1_zom_core_run_4",
				"nz_s1_zom_core_run_5",
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

			JumpSequences = {SprintJumpSequencesMiddle},
			JumpSequencesLeft = {SprintJumpSequencesLeft},
			JumpSequencesRight = {SprintJumpSequencesRight},
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
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
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
				"nz_iw7_cp_zom_prone_shamble_forward_01",
				"nz_iw7_cp_zom_prone_shamble_forward_02",
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

			JumpSequences = {SprintJumpSequencesMiddle},
			JumpSequencesLeft = {SprintJumpSequencesLeft},
			JumpSequencesRight = {SprintJumpSequencesRight},
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
	}}
}

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
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_10.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_death_10.mp3"),
}

ENT.NukeDeathSounds = {
	Sound("nz_moo/zombies/vox/nuke_death/soul_00.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_01.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_02.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_03.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_04.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_05.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_06.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_07.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_08.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_09.mp3"),
	Sound("nz_moo/zombies/vox/nuke_death/soul_10.mp3")
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_pain_15.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_06.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_07.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_08.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_09.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_10.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_11.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_12.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_13.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_14.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_walk_concrete_15.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_06.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_07.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_08.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_09.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_step_run_concrete_10.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_behind_hiss_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_behind_hiss_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_behind_hiss_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_behind_hiss_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_behind_hiss_05.mp3"),
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

ENT.CustomTauntAnimV1Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomTauntAnimV2Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomTauntAnimV3Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomTauntAnimV4Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomTauntAnimV5Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomTauntAnimV6Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomTauntAnimV7Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomTauntAnimV8Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomTauntAnimV9Sounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}

ENT.CustomSpecialTauntSounds = {
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_06.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_07.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_08.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_09.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_10.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_11.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_12.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_13.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_14.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_15.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_16.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_17.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_18.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_19.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_20.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_21.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_22.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_23.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_24.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_25.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_26.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_27.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_28.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_29.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_30.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_31.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_32.mp3"),
	Sound("nz_moo/zombies/vox/_exo/zmb_gen_scream_33.mp3"),
}