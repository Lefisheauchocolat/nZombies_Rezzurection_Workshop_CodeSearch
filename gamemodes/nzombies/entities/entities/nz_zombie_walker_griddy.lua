AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo. Glongo"
ENT.Spawnable = true

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zom_ger_eyeglow.vmt"),
		[1] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zom_ger_head_01.vmt"),
		[2] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zom_ger_head_02.vmt"),
		[4] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zom_ger_head_03.vmt"),
		[5] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zom_ger_head_04.vmt"),
		[6] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zom_ger_head_05.vmt"),
		[7] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zmb_rus_f_head1.vmt"),
		[8] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zmb_rus_f_head2.vmt"),
		[9] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zmb_rus_f_head3.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_ger_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_ger_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_ger_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_ger_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_ger_5.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_rus_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_rus_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_rus_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_rus_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_rus_5.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_shirtless_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_shirtless_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_shirtless_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_shirtless_5.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_rus_fem_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_rus_fem_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zod_rus_fem_3.mdl", Skin = 0, Bodygroups = {0,0}},
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
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_16.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_17.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_18.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_19.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_20.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_21.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_22.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_1/amb_23.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_16.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_17.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_18.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_19.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_20.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_21.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_2/amb_22.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/amb/series_3/amb_09.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_1/sprint_11.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_2/sprint_13.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/sprint/series_3/sprint_11.mp3"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			CrawlOutSequences = {crawlspawnwalk},
			MovementSequence = {
				"nz_walk_ad1",
				"nz_s4_3arc_walk_ad_v2",
				"nz_walk_ad3",
				"nz_s4_3arc_walk_ad_v4",
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
				"nz_base_zombie_walk_dazed_v1",
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
				"nz_base_zombie_walk_dazed_v1",
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
				"nz_base_zombie_hunted_dazed_walk_c_limp",
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
				"nz_s4_3arc_run_au_v1",
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
				"nz_base_zombie_hunted_dazed_walk_c_limp",
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
				"nz_s4_3arc_sprint_ad_v21",
				"nz_s4_3arc_sprint_ad_v22",
				"nz_t9_base_sprint_ad_v23",
				"nz_t9_base_sprint_ad_v24",
				"nz_sprint_ad3",
				"nz_sprint_ad4",
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
				"nz_sprint_au3",
				"nz_sprint_au4",
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

			Climb36 = {FastClimbUp36},
			Climb48 = {FastClimbUp48},
			Climb72 = {FastClimbUp72},
			Climb96 = {FastClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {walksounds},
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

			Climb36 = {FastClimbUp36},
			Climb48 = {FastClimbUp48},
			Climb72 = {FastClimbUp72},
			Climb96 = {FastClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {walksounds},
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
ENT.IdleSequence = "nz_idle_ad"

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_15.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_16.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_17.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_18.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_19.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_20.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_21.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_22.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_23.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_24.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_25.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_26.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_27.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_28.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_29.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_30.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_31.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_32.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_33.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_34.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_35.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_36.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_37.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_38.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_39.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_40.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_41.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_42.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_43.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/death/zmb_vox_death_44.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_2k20/elec/series_1/elec_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_1/elec_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_1/elec_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_1/elec_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_1/elec_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_1/elec_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_1/elec_06.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/elec/series_2/elec_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_2/elec_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_2/elec_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_2/elec_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_2/elec_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_2/elec_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_2/elec_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_2/elec_07.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/elec/series_3/elec_09.mp3"),
}

ENT.LaunchSounds = {
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/anti_grav/anti_grav_10.mp3"),
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
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_00.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_01.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_02.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_03.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_04.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_05.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_06.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_07.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_08.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_09.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_10.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_11.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_12.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_1/attack_13.mp3",

	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_00.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_01.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_02.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_03.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_04.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_05.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_06.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_07.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_08.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_09.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_10.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_11.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_12.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_13.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_14.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_15.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_16.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_17.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_2/attack_18.mp3",

	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_00.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_01.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_02.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_03.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_04.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_05.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_06.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_07.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_08.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_09.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_10.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_11.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_12.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_13.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_14.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_15.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_16.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_17.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_18.mp3",
	"nz_moo/zombies/vox/_2k20/attack/series_3/attack_19.mp3"
}

ENT.FireDeathSounds = {
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_15.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_16.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_17.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_18.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_19.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_20.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_21.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_22.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_23.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_24.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_25.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/burned/zmb_vox_burned_26.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_1/crawl_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_1/crawl_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_1/crawl_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_1/crawl_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_1/crawl_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_1/crawl_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_1/crawl_06.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_2/crawl_08.mp3"),
	
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_3/crawl_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_3/crawl_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_3/crawl_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_3/crawl_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_3/crawl_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/crawl/series_3/crawl_05.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_01.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_02.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_03.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_04.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_05.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_06.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_2k20/behind/series_1/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_1/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_1/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_1/behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_1/behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_1/behind_05.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/behind/series_2/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_2/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_2/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_2/behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_2/behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_2/behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_2/behind_06.mp3"),
	
	Sound("nz_moo/zombies/vox/_2k20/behind/series_3/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_3/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_3/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_3/behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/behind/series_3/behind_04.mp3"),
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
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_00.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_01.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_02.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_03.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_04.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_05.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_06.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_07.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_08.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_09.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_10.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_11.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_12.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_13.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_14.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_15.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_16.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_17.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_1/pain_18.mp3",

	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_00.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_01.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_02.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_03.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_04.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_05.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_06.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_07.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_08.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_2/pain_09.mp3",

	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_00.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_01.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_02.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_03.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_04.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_05.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_06.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_07.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_08.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_09.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_10.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_11.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_12.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_13.mp3",
	"nz_moo/zombies/vox/_2k20/pain/series_3/pain_14.mp3",
}

ENT.CustomTauntAnimV1Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomTauntAnimV2Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomTauntAnimV3Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomTauntAnimV4Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomTauntAnimV5Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomTauntAnimV6Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomTauntAnimV7Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomTauntAnimV8Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}

ENT.CustomTauntAnimV9Sounds = {
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_1/taunt_02.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_08.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_09.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_10.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_11.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_12.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_13.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_14.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_2/taunt_15.mp3"),

	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_00.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_01.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_02.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_03.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_04.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_05.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_06.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_07.mp3"),
	Sound("nz_moo/zombies/vox/_2k20/taunt/series_3/taunt_08.mp3"),
}
