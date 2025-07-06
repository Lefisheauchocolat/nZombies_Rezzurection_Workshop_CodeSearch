AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
--ENT.PrintName = "Bomb has been planted"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then
	ENT.EyeColorTable = {
		[0] = Material("models/lncss/ct_gign_infected/ct_gign.vmt"),
		[1] = Material("models/lncss/ct_gsg9_infected/ct_gsg9.vmt"),
		[2] = Material("models/lncss/ct_sas_infected/ct_sas.vmt"),
		[3] = Material("models/lncss/ct_urban_infected/ct_urban.vmt"),
		[4] = Material("models/lncss/t_arctic_infected/t_arctic.vmt"),
		[5] = Material("models/lncss/t_guerilla_infected/t_guerilla.vmt"),
		[6] = Material("models/lncss/t_leet_infected/t_leet.vmt"),
		[7] = Material("models/lncss/t_phoenix_infected/t_phoenix.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/terror/moo_rerig_ln_counter_gign.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/terror/moo_rerig_ln_counter_gsg9.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/terror/moo_rerig_ln_counter_sas.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/terror/moo_rerig_ln_counter_urban.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/terror/moo_rerig_ln_terror_arctic.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/terror/moo_rerig_ln_terror_guerilla.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/terror/moo_rerig_ln_terror_leet.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/terror/moo_rerig_ln_terror_phoenix.mdl", Skin = 0, Bodygroups = {0,0}},
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
	Sound("voices/default/infected/zomb_runner_male1-idle-01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-idle-10.mp3"),
}

local runsounds = {
	Sound("voices/default/infected/zomb_runner_male1-pursuit-01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pursuit-13.mp3"),
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
				"nz_legacy_walk_dazed",
				"nz_base_zombie_walk_dazed_v1",
				"nz_base_zombie_walk_dazed_v2",

				"nz_walk_ad7",
				"nz_s4_3arc_walk_ad_v10",
				"nz_s4_3arc_walk_ad_v12",
				"nz_s4_3arc_walk_ad_v14",
				"nz_walk_ad19",
				"nz_s4_3arc_walk_au_v22",
				"nz_walk_au23",

				"nz_legacy_jap_walk_v1",
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
				--"nz_legacy_jap_run_v4",
				--"nz_legacy_jap_run_v5",
				--"nz_legacy_jap_run_v6",

				"nz_run_ad7",
				"nz_s4_3arc_run_ad_v13",
				"nz_run_au9",
				"nz_s4_3arc_run_au_v12",
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
				"nz_t9_base_sprint_ad_v05",
				"nz_t9_base_sprint_ad_v21",
				"nz_t9_base_sprint_ad_v24",
				"nz_t9_base_sprint_au_v20",
				"nz_t9_base_sprint_au_v22",

				"nz_t9_base_sprint_ad_v01",
				"nz_t9_base_sprint_au_v02",
				"nz_bo3_zombie_sprint_v3",
				"nz_bo3_zombie_sprint_v4",
				"nz_legacy_sprint_v5",
				"nz_legacy_jap_run_v3",
				"nz_pb_zombie_sprint_v7",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
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
	Sound("voices/default/infected/zomb_runner_male1-death-01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-15.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-16.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-17.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-18.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-19.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-20.mp3"),
}

ENT.ElecSounds = {
	Sound("voices/default/infected/zomb_runner_male1-death-01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-15.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-16.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-17.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-18.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-19.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-death-20.mp3"),
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
	Sound("voices/default/infected/zomb_runner_male1-attack01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack15.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack16.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack17.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack18.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack19.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack20.mp3"),
}

ENT.CrawlerSounds = {
	Sound("voices/default/infected/zomb_runner_male1-pain01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain15.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain16.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain17.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain18.mp3"),
}

ENT.MonkeySounds = {
	Sound("voices/default/infected/zomb_runner_male1-attack01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack15.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack16.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack17.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack18.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack19.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-attack20.mp3"),
}

ENT.PainSounds = {
	Sound("voices/default/infected/zomb_runner_male1-pain01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain15.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain16.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain17.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-pain18.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-15.mp3"),
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


ENT.TauntSounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-03.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-06.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-09.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-12.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-15.mp3"),
}

ENT.TauntAnimV1Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-03.mp3"),
}

ENT.TauntAnimV2Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-06.mp3"),
}

ENT.TauntAnimV3Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-09.mp3"),
}

ENT.TauntAnimV4Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-12.mp3"),
}

ENT.TauntAnimV5Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-13.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-14.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-15.mp3"),
}

ENT.TauntAnimV6Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-01.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-02.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-03.mp3"),
}

ENT.TauntAnimV7Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-04.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-05.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-06.mp3"),
}

ENT.TauntAnimV8Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-07.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-08.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-09.mp3"),
}

ENT.TauntAnimV9Sounds = {
	Sound("voices/default/infected/zomb_runner_male1-alert-10.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-11.mp3"),
	Sound("voices/default/infected/zomb_runner_male1-alert-12.mp3"),
}
