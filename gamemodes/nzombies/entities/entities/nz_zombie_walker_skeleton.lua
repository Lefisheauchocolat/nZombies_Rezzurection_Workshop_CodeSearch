AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Skeleton"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t7_giant/mtl_c_zom_der_zombie_head1u.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t7/castle/moo_codz_t7_castle_skeleton.mdl", Skin = 0, Bodygroups = {0,0}},
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
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			CrawlOutSequences = {crawlspawnwalk},
			MovementSequence = {
				"nz_bo3_zombie_walk_v1",
				"nz_bo3_zombie_walk_v2",
				"nz_bo3_zombie_walk_v3",
				"nz_bo3_zombie_walk_v4",
				"nz_walk_au5",
				"nz_walk_au6",
				"nz_legacy_walk_v9",
				"nz_legacy_jap_walk_v1",
				"nz_legacy_jap_walk_v2",
				"nz_legacy_jap_walk_v3",
				"nz_legacy_jap_walk_v4",
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

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			CrawlOutSequences = {crawlspawnrun},
			MovementSequence = {
				"nz_bo3_zombie_walk_fast_v1",
				"nz_bo3_zombie_walk_fast_v2",
				"nz_bo3_zombie_walk_fast_v3",
				"nz_legacy_run_v1",
				"nz_legacy_run_v2",
				"nz_legacy_run_v3",
				"nz_legacy_run_v4",
				"nz_legacy_jap_run_v1",
				"nz_legacy_jap_run_v2",
				"nz_legacy_jap_run_v4",
				"nz_legacy_jap_run_v5",
				"nz_legacy_jap_run_v6",
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

			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_bo3_zombie_sprint_v1",
				"nz_bo3_zombie_sprint_v2",
				"nz_bo3_zombie_sprint_v3",
				"nz_bo3_zombie_sprint_v4",
				"nz_legacy_sprint_v5",
				"nz_cyborg_sprint_02",
				"nz_legacy_jap_run_v3",
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
		},
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				--"nz_l4d_run_05",
				--"nz_pb_zombie_sprint_v7",
				--"nz_pb_zombie_sprint_v9",
				"nz_hazmat_sprint_01",
				"nz_suicide_sprint_01",
				"nz_base_zombie_sprint_w_object_4",
				"nz_base_zombie_sprint_w_object_5",
				"nz_supersprint_ad1",
				"nz_supersprint_au2",
				"nz_supersprint_ad3",
				"nz_supersprint_ad4",
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

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_06.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_07.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_08.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_09.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_10.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_11.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_12.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_13.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_14.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_06.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_07.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_08.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_09.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_10.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_11.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_12.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_13.mp3"),
	Sound("nz_moo/zombies/footsteps/_original/_extended/step_14.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_t4/melee_hit_00.mp3"),
	Sound("nz_moo/zombies/plr_impact/_t4/melee_hit_01.mp3"),
	Sound("nz_moo/zombies/plr_impact/_t4/melee_hit_02.mp3"),
	Sound("nz_moo/zombies/plr_impact/_t4/melee_hit_03.mp3"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_00.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_01.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/_og/swing_02.mp3"),
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


		-- Force the enhanced bodygroups to be blank(Theres an extra lua that allows them.)
		self:SetBodygroup(2,0)
		self:SetBodygroup(3,0)
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

