AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.MinSoundPitch 			= 87
ENT.MaxSoundPitch 			= 100

ENT.SoundDelayMin = 2
ENT.SoundDelayMax = 4

ENT.Models = {
	-- Theres like 300+ skins for these fuckers. So I just added code that forces it to pick a random one.

	-- Males
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male02.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_rual01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_military_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_police_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_worker_male01.mdl", Skin = 0, Bodygroups = {0,0}},

	-- Females
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_rural01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_rural01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_rural01.mdl", Skin = 0, Bodygroups = {0,0}},


	-- Area Specific(Hospital and Airport)
	--{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_surgeon_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	--{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_tsaagent_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	--{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_pilot.mdl", Skin = 0, Bodygroups = {0,0}},
	--{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_patient_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	--{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_baggagehandler_01.mdl", Skin = 0, Bodygroups = {0,0}},
	--{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_nurse01.mdl", Skin = 0, Bodygroups = {0,0}},
	--{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_nurse01.mdl", Skin = 0, Bodygroups = {0,0}},
	--{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_nurse01.mdl", Skin = 0, Bodygroups = {0,0}},
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

	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim402.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim426.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim434.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim435.mp3"),
}

ENT.IdleSequence = "nz_l4d_idlealert_01a"
ENT.IdleSequenceAU = "nz_l4d_idlealert_03"
ENT.NoTargetIdle = "nz_l4d_idleneutral_12"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_walk_ad1",
				"nz_walk_ad2",
				"nz_walk_ad3",
				"nz_walk_au4",
				"nz_walk_au5",
				"nz_walk_au6",
				"nz_iw7_cp_zom_shamble_forward_01",
				"nz_iw7_cp_zom_shamble_forward_02",
				"nz_iw7_cp_zom_shamble_forward_03",
				"nz_iw7_cp_zom_shamble_forward_04",
				"nz_iw7_cp_zom_walk_forward_01",
				"nz_iw7_cp_zom_walk_forward_02",
				"nz_iw7_cp_zom_walk_forward_03",
				"nz_iw7_cp_zom_walk_forward_04",
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
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			MovementSequence = {
				"nz_s4_3arc_run_au_v1",
				"nz_s4_3arc_run_au_v2",
				"nz_s4_3arc_run_au_v4",
				"nz_run_ad12",
				"nz_legacy_jap_run_v1",
				"nz_legacy_jap_run_v4",
				"nz_legacy_jap_run_v6",
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
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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

			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_sprint_ad1",
				"nz_sprint_au2",
				"nz_sprint_ad5",
				"nz_sprint_au22",
				"nz_bo3_zombie_sprint_v4",
				"nz_base_zombie_sprint_w_object_4",
				"nz_base_zombie_sprint_w_object_5",
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
				"nz_iw7_cp_zom_prone_run_forward_01",
				"nz_iw7_cp_zom_prone_run_forward_02",
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

			PassiveSounds = {runsounds},
		},
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
				--[["nz_s1_zom_core_sprint_1",
				"nz_s1_zom_core_sprint_2",
				"nz_s1_zom_core_sprint_3",
				"nz_s1_zom_core_sprint_4",
				"nz_s1_zom_core_sprint_5",
				"nz_s1_zom_core_sprint_6",
				"nz_pb_zombie_sprint_v7",
				"nz_pb_zombie_sprint_v9",]]

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

			JumpSequences = {SprintJumpSequences},
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

ENT.CustomMonkeySounds = {
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

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_l4d/death/death_14.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_17.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_19.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_22.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_23.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_24.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_27.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_28.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_29.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_30.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_33.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_34.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_35.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_36.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_37.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_38.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_40.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_41.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_42.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_44.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_46.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_47.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/death/death_49.mp3")
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_l4d/elec/ignite09.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/elec/ignite10.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/elec/ignite11.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/elec/ignite12.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/elec/ignite13.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/elec/ignite14.mp3"),
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
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_01.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_02.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_04.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_06.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_08.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_09.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_13.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_31.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_32.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_33.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_34.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_52.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_54.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_55.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_57.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_58.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_59.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_67.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_72.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_78.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_80.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/rage_82.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/shoved_1.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/shoved_05.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/shoved_08.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/shoved_16.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim421.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim422.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim425.mp3"),
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

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_l4d/attack/shoved_05.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/shoved_08.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/shoved_1.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/shoved_16.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_34.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_13.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/attack/been_shot_06.mp3"),
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

ENT.CustomSpecialTauntSounds = {
	Sound("nz_moo/zombies/vox/_l4d/taunt/mega_mob_incoming.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/taunt/mega_mob_incoming2.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_l4d/walk/concrete1.mp3"),
	Sound("nz_moo/zombies/footsteps/_l4d/walk/concrete2.mp3"),
	Sound("nz_moo/zombies/footsteps/_l4d/walk/concrete3.mp3"),
	Sound("nz_moo/zombies/footsteps/_l4d/walk/concrete4.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_l4d/walk/concrete1.mp3"),
	Sound("nz_moo/zombies/footsteps/_l4d/walk/concrete2.mp3"),
	Sound("nz_moo/zombies/footsteps/_l4d/walk/concrete3.mp3"),
	Sound("nz_moo/zombies/footsteps/_l4d/walk/concrete4.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_l4d/punch_boxing_bodyhit03.wav"),
	Sound("nz_moo/zombies/plr_impact/_l4d/punch_boxing_bodyhit04.wav"),
	Sound("nz_moo/zombies/plr_impact/_l4d/punch_boxing_facehit4.wav"),
	Sound("nz_moo/zombies/plr_impact/_l4d/punch_boxing_facehit5.wav"),
	Sound("nz_moo/zombies/plr_impact/_l4d/punch_boxing_facehit6.wav"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_l4d/behind/squeal_1.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/behind/squeal_2.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/behind/squeal_3.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/behind/squeal_4.mp3"),
	Sound("nz_moo/zombies/vox/_l4d/sprint/rage_at_victim401.mp3"),
}

-- So we can identify if we can use the female zombie sounds or not.
ENT.Females = {
	"models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01.mdl",
	"models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01_suit.mdl",
	"models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_rural01.mdl",
	"models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_nurse01.mdl",
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

		-- Theres actually so many fucking skins, this single line will handle that.
		self:SetSkin(math.random(0, self:SkinCount()))

		-- Theres models with messed up skin groups, so cap it at the last good one.
		if self:GetModel() == "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_rual01.mdl" then
			if self:GetBodygroup(1) >= 6 then
				self:SetSkin(math.random(0, 63))
			end
		end

		for _,model in pairs(self.Females) do
			if model == self:GetModel() then
				self.MinSoundPitch 	= 115
				self.MaxSoundPitch 	= 120
				self.SoundDelayMin  = 2
				self.SoundDelayMax  = 3
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

ENT.CustomTauntAnimV1Sounds = {
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

ENT.CustomTauntAnimV2Sounds = {
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

ENT.CustomTauntAnimV3Sounds = {
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

ENT.CustomTauntAnimV4Sounds = {
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

ENT.CustomTauntAnimV5Sounds = {
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

ENT.CustomTauntAnimV6Sounds = {
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

ENT.CustomTauntAnimV7Sounds = {
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

ENT.CustomTauntAnimV8Sounds = {
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

ENT.CustomTauntAnimV9Sounds = {
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
