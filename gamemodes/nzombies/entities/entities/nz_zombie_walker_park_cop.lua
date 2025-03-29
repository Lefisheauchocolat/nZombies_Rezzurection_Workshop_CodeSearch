AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Police Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true




if CLIENT then
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")
	local LEyeColor = Color(255, 0, 0, 255)
	local REyeColor = Color(50, 50, 255, 255)

	function ENT:DrawEyeGlow()
		local latt = self:LookupAttachment("lefteye")
		local ratt = self:LookupAttachment("righteye")

		if latt == nil then return end
		if ratt == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)

		if leye == nil then return end
		if reye == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.5
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.5

		if lefteyepos and righteyepos then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 4, 4, LEyeColor)
			render.DrawSprite(righteyepos, 4, 4, REyeColor)
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.SoundDelayMin = 5
ENT.SoundDelayMax = 7

ENT.Models = {
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_iw7_cp_zom_spawn_ground_02", "nz_iw7_cp_zom_spawn_ground_06", "nz_iw7_cp_zom_spawn_ground_walk_01", "nz_iw7_cp_zom_spawn_ground_walk_03", "nz_iw7_cp_zom_spawn_ground_walk_04"}
local spawnrun = {"nz_iw7_cp_zom_spawn_ground_run_01", "nz_iw7_cp_zom_spawn_ground_run_02", "nz_iw7_cp_zom_spawn_ground_run_03", "nz_iw7_cp_zom_spawn_ground_run_04"}
local spawnfast = {"nz_iw7_cp_zom_spawn_ground_run_01", "nz_iw7_cp_zom_spawn_ground_run_02", "nz_iw7_cp_zom_spawn_ground_run_03", "nz_iw7_cp_zom_spawn_ground_run_04"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

ENT.SoundDelayMin = 1
ENT.SoundDelayMax = 3

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
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_front_10.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_run_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_run_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_run_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_run_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_run_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_run_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_run_front_07.mp3"),
}

local sprintsounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_sprinter_sprint_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_sprinter_sprint_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_sprinter_sprint_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_sprinter_sprint_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_sprinter_sprint_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_sprinter_sprint_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_sprinter_sprint_front_07.mp3"),
}

local talksounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
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
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_09.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_10.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_blackhole_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_blackhole_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_blackhole_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_death_blackhole_04.mp3"),
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
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_09.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_front_10.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_09.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_walk_behind_10.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_09.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_attack_behind_10.mp3"),
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


function ENT:Sound()
	if self:GetAttacking() or !self:IsAlive() or self:GetDecapitated() then return end

	local vol = 80

	for k,v in nzLevel.GetZombieArray() do -- FUCK YOU, ARRAYS ARE AWESOME!!!
		if k < 2 then vol = 511 else vol = 80 end
	end

	if self.BehindSoundDistance > 0 -- We have enabled behind sounds
		and IsValid(self.Target)
		and self.Target:IsPlayer() -- We have a target and it's a player within distance
		and self:GetRangeTo(self.Target) <= self.BehindSoundDistance
		and (self.Target:GetPos() - self:GetPos()):GetNormalized():Dot(self.Target:GetAimVector()) >= 0 then -- If the direction towards the player is same 180 degree as the player's aim (away from the zombie)
			self:PlaySound(self.BehindSounds[math.random(#self.BehindSounds)], 100, math.random(80, 110), 1, 2) -- Play the behind sound, and a bit louder!
	
	--[[ A big "if then" thingy for playing other sounds. ]]--
	elseif self.ElecSounds and (self.BO4IsShocked and self:BO4IsShocked() or self.BO4IsScorped and self:BO4IsScorped() or self.BO4IsSpinning and self:BO4IsSpinning()) then
		self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)],vol, math.random(80, 110), 1, 2)
	elseif IsValid(self.Target) and self.Target:GetClass() == "nz_bo3_tac_monkeybomb" and self.MonkeySounds and !self.IsMooSpecial then
		self:PlaySound(self.MonkeySounds[math.random(#self.MonkeySounds)], 100, math.random(80, 110), 1, 2)
	elseif self:GetCrawler() and self.CrawlerSounds then
		self:PlaySound(self.CrawlerSounds[math.random(#self.CrawlerSounds)],vol, math.random(80, 110), 1, 2)
	elseif (self:BomberBuff() or self.IsTurned ) and self.GasVox and !self.IsMooSpecial then
		self:PlaySound(self.GasVox[math.random(#self.GasVox)],vol, math.random(95, 105), 1, 2)
	elseif self.PassiveSounds then
		if math.random(100) > 15 then
			self:PlaySound(self.PassiveSounds[math.random(#self.PassiveSounds)],vol, math.random(80, 110), 1, 2)
		else
			self:PlaySound(self.TauntSounds[math.random(#self.TauntSounds)],vol, math.random(80, 110), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	else


		-- We still delay by max sound delay even if there was no sound to play
		self.NextSound = CurTime() + self.SoundDelayMax
	end
end


ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_pain_10.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomSpecialTauntSounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_shambler_talk_06.mp3"),
}

ENT.CustomTauntAnimV1Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomTauntAnimV2Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomTauntAnimV3Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomTauntAnimV4Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomTauntAnimV5Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomTauntAnimV6Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomTauntAnimV7Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomTauntAnimV8Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
}

ENT.CustomTauntAnimV9Sounds = {
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_01.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_02.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_03.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_04.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_05.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_06.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_07.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_08.mp3"),
	Sound("nz_moo/zombies/vox/_cop/zombie_vox_cop_runner_talk_09.mp3"),
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
