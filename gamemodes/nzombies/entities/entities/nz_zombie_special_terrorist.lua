AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Terrorist Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

local resist = {
	[DMG_BULLET] = true,
}

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/totu/detonator/bulldozer_eyeball_l.vmt"),
		[1] = Material("models/totu/detonator/bulldozer_eyeball_r.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true

ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMiniBoss = true

ENT.RedEyes = true

ENT.Models = {
	{Model = "models/moo/_moo_rerigs/lethal_necrotics/moo_rerig_ln_detonator.mdl", Skin = 0, Bodygroups = {0,0}},
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
			MovementSequence = {
				"nz_base_zombie_cellbreaker_walk_01",
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
			Bo3AttackSequences = {StinkyRunAttackSequences},
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
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			MovementSequence = {
				"nz_base_zombie_hunted_dazed_walk_c_limp",
				"nz_base_zombie_boss_run_04",
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
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_base_zombie_boss_sprint_01",
				"nz_base_zombie_cellbreaker_sprint_01",
				"nz_base_zombie_cellbreaker_sprint_02",
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
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
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
	}},
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
		if nzRound:GetNumber() == -1 then
			self:SetHealth( math.random(100, 1500) )
		else
			self:SetHealth( nzRound:GetZombieHealth() or 75 )
		end

		self:SetRunSpeed(1)

		self.C4Cooldown = CurTime() + math.random(3,6)
		self.SpeedUpTime = CurTime() + 18
		self.TimesAttacks = 0
		self.UseCustomAttackDamage = true
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

function ENT:AI()
	if CurTime() > self.C4Cooldown and math.random(100) <= 50 then
		self:DoSpecialAnimation("nz_base_zombie_cellbreaker_gasattack")
		self.C4Cooldown = CurTime() + math.random(7,15)
	end
	if CurTime() > self.SpeedUpTime and self:GetRunSpeed() < 178 then
		self.SpeedUpTime = CurTime() + 18
		self:SetRunSpeed(self:GetRunSpeed() + 36)
		self:SpeedChanged()
	end
end

function ENT:PostTookDamage(dmginfo)
	local insta = nzPowerUps:IsPowerupActive("insta") -- Don't apply the damage reduction if insta kill is active.
	if resist[dmginfo:GetDamageType()] and !insta then
		dmginfo:ScaleDamage(0.5)
	end
end

function ENT:CustomAttackDamage(target, dmg) 
	local dmgInfo = DamageInfo()
	dmgInfo:SetAttacker( self )
	dmgInfo:SetDamage( dmg )
	dmgInfo:SetDamageType( DMG_SLASH )

	target:TakeDamageInfo(dmgInfo)

	if self.TimesAttacks >= 1 then
		self:TakeDamage(self:Health() + 666, self, self)
	else
		self.TimesAttacks = self.TimesAttacks + 1
	end

end

function ENT:PostDeath(dmginfo)
	self:Explode(45, true)
end

function ENT:CustomAnimEvent(a,b,c,d,e) 
	if e == "cellbreaker_gasattack" then
		self:EmitSound("weapons/c4/c4_initiate.wav", 95, math.random(95,105))
		local c4 = ents.Create("nz_proj_terrorist_c4")
		c4:SetPos(self:WorldSpaceCenter() + self:GetForward() * 30)
		c4:SetAngles(self:GetAngles())
		c4:Spawn()
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
