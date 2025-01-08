AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/zed/male/eyeball_l.vmt"),
		[1] = Material("models/zed/male/eyeball_r.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.MinSoundPitch 			= 30 				-- Limits the minimum pitch for passive sounds the zombie can make.
ENT.MaxSoundPitch 			= 50 				-- Limits the maximum pitch for passive sounds the zombie can make.
ENT.SoundVolume 			= 125 				-- Limits the volume for passive sounds the zombie can make.

ENT.Models = {
	{Model = "models/wavy_rigs/nzombies3_zeds/zed4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed4.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed4.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed4.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed4.mdl", Skin = 6, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed4.mdl", Skin = 7, Bodygroups = {0,0}},
	
	{Model = "models/wavy_rigs/nzombies3_zeds/zed6.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed6.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed6.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed6.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed6.mdl", Skin = 6, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed6.mdl", Skin = 7, Bodygroups = {0,0}},
	
	{Model = "models/wavy_rigs/nzombies3_zeds/zed8.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed8.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed8.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed8.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed8.mdl", Skin = 6, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/nzombies3_zeds/zed8.mdl", Skin = 7, Bodygroups = {0,0}},
}

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb"}
local spawnrun = {"nz_spawn_ground_v1_run"}
local spawnfast = {"nz_spawn_ground_climbout_fast", "nz_s4_3arc_traverse_riser"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

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

local CrawlAttackSequences = {
	{seq = "nz_crawl_attack_v1", dmgtimes = {0.75, 1.65}},
	{seq = "nz_crawl_attack_v2", dmgtimes = {0.65}},
}

local CrawlJumpSequences = {
	{seq = "nz_barricade_crawl_1"},
	{seq = "nz_barricade_crawl_2"},
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
	Sound("npc/zombie_poison/pz_pain1.wav"),
	Sound("npc/zombie_poison/pz_pain2.wav"),
	Sound("npc/zombie_poison/pz_pain3.wav"),
}

local runsounds = {
	Sound("npc/zombie_poison/pz_pain1.wav"),
	Sound("npc/zombie_poison/pz_pain2.wav"),
	Sound("npc/zombie_poison/pz_pain3.wav"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_walk_ad1",
				"nz_s4_3arc_walk_ad_v2",
				"nz_walk_ad3",
				"nz_s4_3arc_walk_ad_v4",
				"nz_walk_ad7",
				"nz_walk_ad5",
				"nz_walk_ad6",
				"nz_walk_ad19",
				"nz_walk_ad20",
				"nz_walk_ad21",
				"nz_walk_ad22",
				"nz_walk_ad23",
				"nz_walk_ad24",
				"nz_walk_ad25",
				"nz_walk_au_goose",
				"nz_legacy_walk_dazed",
				--"nz_legacy_jap_walk_v1",
				--"nz_legacy_jap_walk_v2",
				--"nz_legacy_jap_walk_v3",
				--"nz_legacy_jap_walk_v4",
				"nz_legacy_walk_v9",
				
				"nz_walk_ad1",
				"nz_s4_3arc_walk_ad_v2",
				"nz_walk_ad3",
				"nz_s4_3arc_walk_ad_v4",
				"nz_walk_ad7",
				"nz_walk_ad5",
				"nz_walk_ad6",
				"nz_walk_ad19",
				"nz_walk_ad20",
				"nz_walk_ad21",
				"nz_walk_ad22",
				"nz_walk_ad23",
				"nz_walk_ad24",
				"nz_walk_ad25",
				"nz_walk_au_goose",
				"nz_legacy_walk_dazed",
				--"nz_legacy_jap_walk_v1",
				--"nz_legacy_jap_walk_v2",
				--"nz_legacy_jap_walk_v3",
				--"nz_legacy_jap_walk_v4",
				"nz_legacy_walk_v9",
				"nz_gm_walk",
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
				"nz_walk_au23",
				"nz_walk_au_goose", -- This is the goosestep walk aka marching anim that german soldier zombies use.
				"nz_legacy_walk_dazed",
				--"nz_legacy_jap_walk_v1",
				--"nz_legacy_jap_walk_v2",
				--"nz_legacy_jap_walk_v3",
				--"nz_legacy_jap_walk_v4",
				"nz_legacy_walk_v9",
				
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
				"nz_walk_au23",
				"nz_walk_au_goose", -- This is the goosestep walk aka marching anim that german soldier zombies use.
				"nz_legacy_walk_dazed",
				--"nz_legacy_jap_walk_v1",
				--"nz_legacy_jap_walk_v2",
				--"nz_legacy_jap_walk_v3",
				--"nz_legacy_jap_walk_v4",
				"nz_legacy_walk_v9",
				"nz_gm_walk",
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
				"nz_walk_fast_ad1",
				"nz_walk_fast_ad2",
				"nz_walk_fast_ad3",
				"nz_legacy_run_v1",
				"nz_legacy_run_v3",
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
				"nz_walk_fast_au1",
				"nz_walk_fast_au2",
				"nz_walk_fast_au3",
				"nz_legacy_run_v1",
				"nz_legacy_run_v3",
				--"nz_legacy_jap_run_v1",
				--"nz_legacy_jap_run_v2",
				--"nz_legacy_jap_run_v4",
				--"nz_legacy_jap_run_v5",
				--"nz_legacy_jap_run_v6",
				"nz_run_au1",
				"nz_s4_3arc_run_au_v2",
				"nz_run_au3",
				"nz_s4_3arc_run_au_v4",
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
				"nz_legacy_sprint_v5",
				--"nz_legacy_jap_run_v3",
				"nz_t9_base_sprint_ad_v01",
				"nz_t9_base_sprint_ad_v02",
				"nz_t9_base_sprint_ad_v05",
				"nz_s4_3arc_sprint_ad_v21",
				"nz_s4_3arc_sprint_ad_v22",
				"nz_t9_base_sprint_ad_v23",
				"nz_sprint_ad3",
				"nz_sprint_ad4",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
				
				"nz_bo3_zombie_sprint_v4",
				"nz_legacy_sprint_v5",
				--"nz_legacy_jap_run_v3",
				"nz_t9_base_sprint_ad_v01",
				"nz_t9_base_sprint_ad_v02",
				"nz_t9_base_sprint_ad_v05",
				"nz_s4_3arc_sprint_ad_v21",
				"nz_s4_3arc_sprint_ad_v22",
				"nz_t9_base_sprint_ad_v23",
				"nz_sprint_ad3",
				"nz_sprint_ad4",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
				"nz_gm_run",
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
				"nz_bo3_zombie_sprint_v2",
				"nz_bo3_zombie_sprint_v4",
				"nz_legacy_sprint_v5",
				--"nz_legacy_jap_run_v3",
				"nz_t9_base_sprint_au_v01",
				--"nz_t9_base_sprint_au_v02",
				"nz_t9_base_sprint_au_v20",
				"nz_t9_base_sprint_au_v21",
				"nz_t9_base_sprint_au_v22",
				"nz_t9_base_sprint_au_v25",
				"nz_sprint_au3",
				"nz_sprint_au4",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
				
				"nz_bo3_zombie_sprint_v2",
				"nz_bo3_zombie_sprint_v4",
				"nz_legacy_sprint_v5",
				--"nz_legacy_jap_run_v3",
				"nz_t9_base_sprint_au_v01",
				--"nz_t9_base_sprint_au_v02",
				"nz_t9_base_sprint_au_v20",
				"nz_t9_base_sprint_au_v21",
				"nz_t9_base_sprint_au_v22",
				"nz_t9_base_sprint_au_v25",
				"nz_sprint_au3",
				"nz_sprint_au4",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
				"nz_gm_run",
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
				--"nz_l4d_run_05",
				--"nz_pb_zombie_sprint_v7",
				--"nz_pb_zombie_sprint_v9",
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
				
				--"nz_l4d_run_05",
				--"nz_pb_zombie_sprint_v7",
				--"nz_pb_zombie_sprint_v9",
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
		},
		{
			SpawnSequence = {spawnsuperfast},
			MovementSequence = {
				--"nz_l4d_run_05",
				--"nz_pb_zombie_sprint_v7",
				--"nz_pb_zombie_sprint_v9",
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
				
				--"nz_l4d_run_05",
				--"nz_pb_zombie_sprint_v7",
				--"nz_pb_zombie_sprint_v9",
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
	Sound("npc/zombie_poison/pz_throw2.wav"),
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

ENT.CustomWalkFootstepsSounds = {
	Sound("npc/zombie/foot1.wav"),
	Sound("npc/zombie/foot2.wav"),
	Sound("npc/zombie/foot3.wav"),
	Sound("npc/zombie/foot_slide1.wav"),
	Sound("npc/zombie/foot_slide2.wav"),
	Sound("npc/zombie/foot_slide3.wav"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("npc/fast_zombie/foot1.wav"),
	Sound("npc/fast_zombie/foot2.wav"),
	Sound("npc/fast_zombie/foot3.wav"),
	Sound("npc/fast_zombie/foot4.wav"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("npc/zombie/claw_miss1.wav"),
	Sound("npc/zombie/claw_miss2.wav"),
}

ENT.CustomAttackImpactSounds = {
	Sound("npc/zombie/claw_strike1.wav"),
	Sound("npc/zombie/claw_strike2.wav"),
	Sound("npc/zombie/claw_strike3.wav"),
	Sound("npc/zombie/zombie_hit.wav"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("npc/zombie_poison/pz_pain1.wav"),
	Sound("npc/zombie_poison/pz_pain2.wav"),
	Sound("npc/zombie_poison/pz_pain3.wav"),
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