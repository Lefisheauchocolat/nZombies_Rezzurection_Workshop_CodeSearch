AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/iw7_zombies/park/zmb_male_eyes_02.vmt"),
		[1] = Material("models/moo/codz/iw7_zombies/park/zmb_shared_eyes_a.vmt"),
		[2] = Material("models/moo/codz/iw7_zombies/park/zmb_male_head_01.vmt"),
		[3] = Material("models/moo/codz/iw7_zombies/park/zmb_male_head_01_b.vmt"),
		[4] = Material("models/moo/codz/iw7_zombies/park/zmb_male_head_01_c.vmt"),
		[5] = Material("models/moo/codz/iw7_zombies/park/zmb_male_head_02.vmt"),
		[6] = Material("models/moo/codz/iw7_zombies/park/zmb_male_head_02_b.vmt"),
		[7] = Material("models/moo/codz/iw7_zombies/park/zmb_male_head_02_c.vmt"),
		[8] = Material("models/moo/codz/iw7_zombies/park/zmb_head_female_01_head.vmt"),
		[9] = Material("models/moo/codz/iw7_zombies/park/zmb_head_female_01_head_b.vmt"),
		[10] = Material("models/moo/codz/iw7_zombies/park/zmb_head_female_01_head_c.vmt"),
		[11] = Material("models/moo/codz/iw7_zombies/park/zmb_female_head_02_damaged.vmt"),
		[12] = Material("models/moo/codz/iw7_zombies/park/zmb_female_head_02_damaged_b.vmt"),
		[13] = Material("models/moo/codz/iw7_zombies/park/zmb_female_head_02_damaged_c.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_1_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_1_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_2_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_2_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_3_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_3_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_4_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_4_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_5_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_5_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_1_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_1_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_2_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_2_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_3_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_3_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_4_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_4_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_5_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_5_2.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_iw7_cp_zom_spawn_ground_02", "nz_iw7_cp_zom_spawn_ground_06", "nz_iw7_cp_zom_spawn_ground_walk_01", "nz_iw7_cp_zom_spawn_ground_walk_03", "nz_iw7_cp_zom_spawn_ground_walk_04"}
local spawnrun = {"nz_iw7_cp_zom_spawn_ground_run_01", "nz_iw7_cp_zom_spawn_ground_run_02", "nz_iw7_cp_zom_spawn_ground_run_03", "nz_iw7_cp_zom_spawn_ground_run_04"}
local spawnfast = {"nz_iw7_cp_zom_spawn_ground_run_01", "nz_iw7_cp_zom_spawn_ground_run_02", "nz_iw7_cp_zom_spawn_ground_run_03", "nz_iw7_cp_zom_spawn_ground_run_04"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

ENT.SoundDelayMin = 2
ENT.SoundDelayMax = 5

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
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_08.mp3"),
	
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_08.mp3"),
	
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_front_08.mp3"),
	
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_10.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_08.mp3"),
	
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_08.mp3"),
	
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_runner_run_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_runner_run_front_08.mp3"),
	
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_10.mp3"),
}

local sprintsounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_07.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_07.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_07.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_front_10.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_sprinter_sprint_front_07.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_talk_10.mp3"),
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
				"nz_s1_zom_core_run_1",
				"nz_s1_zom_core_run_2",
				"nz_s1_zom_core_run_3",
				"nz_s1_zom_core_run_4",
				"nz_s1_zom_core_run_5",
				--[["nz_legacy_sprint_v4",
				"nz_fast_sprint_v2",]]
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

			PassiveSounds = {sprintsounds},
		}
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
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

			PassiveSounds = {sprintsounds},
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

ENT.IdleSequence = "nz_iw7_cp_zom_stand_idle_01"

ENT.IdleSequenceAU = "nz_iw7_cp_zom_stand_idle_02"

ENT.CrawlIdleSequence = "nz_iw7_cp_zom_prone_idle_01"

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_07.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_07.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_blackhole_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_death_blackhole_02.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_blackhole_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_blackhole_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_blackhole_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_death_blackhole_04.mp3"),
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
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_front_07.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_10.mp3"),
}

ENT.CustomMonkeySounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_09.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_shambler_walk_behind_10.mp3"),
}

-- So we can identify if we can use the female zombie sounds or not.
ENT.Females = {
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_1_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_1_2.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_2_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_2_2.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_3_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_3_2.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_4_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_4_2.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_5_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_5_2.mdl",
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_attack_behind_07.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local speeds = nzRound:GetZombieCoDSpeeds()
		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 100 )
		end

		self:SetSkin(math.random(0, self:SkinCount()))

		self:SetHealth( nzRound:GetZombieHealth() or 75 )
		self.AttackDamage = nzRound:GetZombieDamage() or 50

		for _,model in pairs(self.Females) do
			if model == self:GetModel() then
				self.MinSoundPitch 	= 135
				self.MaxSoundPitch 	= 175
				self.SoundDelayMin  = 1
				self.SoundDelayMax  = 2
			end
		end
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
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_pain_08.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomSpecialTauntSounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_talk_09.mp3"),
}

ENT.CustomTauntAnimV1Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomTauntAnimV2Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomTauntAnimV3Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomTauntAnimV4Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomTauntAnimV5Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomTauntAnimV6Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomTauntAnimV7Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomTauntAnimV8Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
}

ENT.CustomTauntAnimV9Sounds = {
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male_sprinter_sprint_behind_08.mp3"),

	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_iw7/zombie_vox_male2_shambler_walk_behind_08.mp3"),
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

ENT.CustomCrawlImpactSounds = {
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_06.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_07.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_08.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_09.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_10.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_11.mp3"),
	Sound("nz_moo/zombies/footsteps/_iw7/zmb_handstep_walk_concrete_12.mp3"),
}