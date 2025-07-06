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

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb"}
local spawnrun = {"nz_spawn_ground_v1_run"}
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

ENT.CrawlDeathSequences = {
	"nz_crawl_death_v1",
	"nz_crawl_death_v2",
}

local CrawlAttackSequences = {
	{seq = "nz_crawl_attack_v1", dmgtimes = {0.75, 1.65}},
	{seq = "nz_crawl_attack_v2", dmgtimes = {0.65}},
}

local CrawlJumpSequences = {
	{seq = "nz_barricade_crawl_1"},
	{seq = "nz_barricade_crawl_2"},
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
	Sound("nz_moo/zombies/vox/_za/normal/undead_breath_in_long_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_breath_in_long_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_breath_in_long_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_breath_out_long_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_breath_out_long_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_breath_out_long_03.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_09.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_10.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_11.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_12.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_13.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_14.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_15.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_16.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_17.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_18.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_19.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_20.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_21.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_22.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_23.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_24.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_25.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_26.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_27.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_28.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_29.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_30.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_31.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_32.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_33.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_spotplayer_34.mp3"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			CrawlOutSequences = {crawlspawnwalk},
			MovementSequence = {
				"nz_walk_ad1",
				"nz_walk_ad2",
				"nz_walk_ad3",
				"nz_walk_ad4",
				"nz_walk_ad7",
				"nz_walk_ad5",
				"nz_walk_ad6",
				"nz_s4_3arc_walk_ad_v10",
				"nz_s4_3arc_walk_ad_v12",
				"nz_s4_3arc_walk_ad_v14",
				"nz_walk_ad19",
				"nz_walk_ad20",
				"nz_walk_ad21",
				"nz_walk_ad22",
				"nz_walk_ad23",
				"nz_walk_ad24",
				"nz_walk_ad25",
				--"nz_walk_au_goose",
				--"nz_legacy_walk_dazed",
				--"nz_legacy_jap_walk_v1",
				--"nz_legacy_jap_walk_v2",
				--"nz_legacy_jap_walk_v3",
				--"nz_legacy_jap_walk_v4",
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
		{
			SpawnSequence = {spawnslow},
			CrawlOutSequences = {crawlspawnwalk},
			MovementSequence = {
				"nz_walk_au1",
				"nz_walk_au2",
				"nz_walk_au3",
				"nz_walk_au4",
				"nz_walk_au5",
				"nz_walk_au6",
				"nz_walk_au7",
				"nz_walk_au8",
				"nz_walk_au10",
				"nz_walk_au11",
				"nz_walk_au12",
				"nz_walk_au13",
				"nz_walk_au15",
				"nz_walk_au20",
				"nz_walk_au21",
				"nz_s4_3arc_walk_au_v22",
				"nz_walk_au23",
				"nz_s4_3arc_walk_au_v24",
				"nz_s4_3arc_walk_au_v25",
				--"nz_walk_au_goose", -- This is the goosestep walk aka marching anim that german soldier zombies use.
				--"nz_legacy_walk_dazed",
				--"nz_legacy_jap_walk_v1",
				--"nz_legacy_jap_walk_v2",
				--"nz_legacy_jap_walk_v3",
				--"nz_legacy_jap_walk_v4",
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
		}
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			CrawlOutSequences = {crawlspawnrun},
			MovementSequence = {
				"nz_walk_fast_ad1",
				"nz_walk_fast_ad2",
				"nz_walk_fast_ad3",
				--"nz_legacy_run_v1",
				--"nz_legacy_run_v3",
				--"nz_legacy_jap_run_v1",
				--"nz_legacy_jap_run_v2",
				--"nz_legacy_jap_run_v4",
				--"nz_legacy_jap_run_v5",
				--"nz_legacy_jap_run_v6",
				"nz_run_ad1",
				"nz_run_ad2",
				"nz_run_ad3",
				"nz_run_ad4",
				"nz_run_ad7",
				"nz_run_ad8",
				"nz_run_ad11",
				"nz_run_ad12",
				"nz_s4_3arc_run_ad_v13",
				"nz_run_ad14",
				"nz_run_ad20",
				"nz_run_ad21",
				"nz_run_ad22",
				"nz_run_ad23",
				"nz_run_ad24",
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
		{
			SpawnSequence = {spawnrun},
			CrawlOutSequences = {crawlspawnrun},
			MovementSequence = {
				"nz_walk_fast_au1",
				"nz_walk_fast_au2",
				"nz_walk_fast_au3",
				--"nz_legacy_run_v1",
				--"nz_legacy_run_v3",
				--"nz_legacy_jap_run_v1",
				--"nz_legacy_jap_run_v2",
				--"nz_legacy_jap_run_v4",
				--"nz_legacy_jap_run_v5",
				--"nz_legacy_jap_run_v6",
				"nz_run_au1",
				"nz_run_au2",
				"nz_run_au3",
				"nz_run_au4",
				"nz_run_au5",
				"nz_run_au9",
				"nz_run_au11",
				"nz_s4_3arc_run_au_v12",
				"nz_run_au13",
				"nz_run_au20",
				"nz_run_au21",
				"nz_run_au22",
				"nz_run_au23",
				"nz_run_au24",
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
		}
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_t9_base_sprint_ad_v01",
				"nz_t9_base_sprint_ad_v02",
				"nz_t9_base_sprint_ad_v05",
				"nz_t9_base_sprint_ad_v21",
				"nz_t9_base_sprint_ad_v22",
				"nz_t9_base_sprint_ad_v23",
				"nz_t9_base_sprint_ad_v24",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
				"nz_cyborg_sprint_02",
				"nz_legacy_sprint_v5",
				"nz_bo3_zombie_sprint_v4",
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
		{
			SpawnSequence = {spawnfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_t9_base_sprint_au_v01",
				"nz_t9_base_sprint_au_v02",
				"nz_t9_base_sprint_au_v20",
				"nz_t9_base_sprint_au_v21",
				"nz_t9_base_sprint_au_v22",
				"nz_t9_base_sprint_au_v25",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
				"nz_cyborg_sprint_02",
				"nz_legacy_sprint_v5",
				"nz_bo3_zombie_sprint_v4",
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

			PassiveSounds = {runsounds},
		}
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_supersprint_ad1",
				"nz_supersprint_ad2",
				"nz_supersprint_ad3",
				"nz_supersprint_ad4",
				"nz_supersprint_ad5",
				"nz_supersprint_ad6",
				"nz_supersprint_ad7",
				"nz_supersprint_ad8",
				"nz_supersprint_ad9",
				"nz_supersprint_ad10",
				"nz_supersprint_ad11",
				"nz_supersprint_ad12",
				"nz_supersprint_ad13",
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
				"nz_l4d_run_03",
				"nz_l4d_run_04",
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

			PassiveSounds = {runsounds},
		},
		{
			SpawnSequence = {spawnsuperfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_supersprint_au1",
				"nz_supersprint_au2",
				"nz_supersprint_au3",
				"nz_supersprint_au4",
				"nz_supersprint_au6",
				"nz_supersprint_au8",
				"nz_supersprint_au9",
				"nz_supersprint_au12",
				"nz_supersprint_au20",
				"nz_supersprint_au21",
				"nz_supersprint_au25",
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
				"nz_l4d_run_03",
				"nz_l4d_run_04",
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
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_10.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_11.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_12.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_13.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_death_14.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_emerge_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_emerge_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_emerge_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_emerge_04.mp3"),
}

ENT.LaunchSounds = {
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_00.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_01.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_02.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_03.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_04.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_05.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_06.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_07.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_08.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_09.mp3"),
	Sound("nz_moo/zombies/vox/_classic/launch/zmb_launch_10.mp3"),
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
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_09.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_10.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_11.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_12.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_13.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_14.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_15.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_16.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_17.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_18.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_19.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_20.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_21.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_22.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_23.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_24.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_25.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_26.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_27.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_28.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_29.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_30.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_31.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_32.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_33.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_34.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_35.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_36.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_37.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_38.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_39.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_40.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_41.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_42.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_43.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_44.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_45.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_46.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_47.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_48.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_melee_49.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_08.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_resurrect_08.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
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

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

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

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_10.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_11.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_12.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_13.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_14.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_15.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_16.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_17.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_18.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_19.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_20.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_21.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_22.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_23.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_24.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_25.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_pain_26.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV1Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV2Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV3Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV4Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV5Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV6Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV7Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV8Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.TauntAnimV9Sounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

ENT.CustomSpecialTauntSounds = {
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_01.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_02.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_03.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_04.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_05.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_06.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_07.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_08.mp3"),
	Sound("nz_moo/zombies/vox/_za/normal/undead_vox_low_random_09.mp3"),
}

