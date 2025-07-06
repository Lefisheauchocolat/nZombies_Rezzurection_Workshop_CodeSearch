AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Toxic Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end
	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Play_SFX or !IsValid(self.Play_SFX)) then
				self.Play_SFX = "nz_moo/zombies/vox/_mutated/new/decay/corrosive_zm_new_loop_00.wav"
				self:EmitSound(self.Play_SFX, 70, 77, 1, 3)
			end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_smoker_aura", 4, 3)
			end

			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 0
				elight.g = 255
				elight.b = 25
				elight.brightness = 5
				elight.Decay = 1000
				elight.Size = 50
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end
	end
	function ENT:DrawEyeGlow()
		local eyeglow =  Material("nz_moo/sprites/moo_glow1")
		local eyeColor = Color(0,255,50)

		if eyeColor == nocolor then return end

		local latt = self:LookupAttachment("lefteye")
		local ratt = self:LookupAttachment("righteye")

		if latt == nil then return end
		if ratt == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)

		if leye == nil then return end
		if reye == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.49
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.49

		if lefteyepos and righteyepos then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 5, 5, eyeColor)
			render.DrawSprite(righteyepos, 5, 5, eyeColor)
		end
	end
end

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.MinSoundPitch = 95
ENT.MaxSoundPitch = 105

ENT.SoundDelayMin = 4
ENT.SoundDelayMax = 8

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/zm/shatteredveil/moo_codz_t10_zmb_zombie_puke_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/zm/shatteredveil/moo_codz_t10_zmb_zombie_puke_2.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.ExplodeSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/gibs/bodyfall/fall_00.mp3"),
	Sound("nz_moo/zombies/gibs/bodyfall/fall_01.mp3"),
	Sound("nz_moo/zombies/gibs/bodyfall/fall_02.mp3"),
}

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb"}
local spawnrun = {"nz_spawn_ground_v1_run"}
local spawnfast = {"nz_spawn_ground_climbout_fast", "nz_s4_3arc_traverse_riser"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

local crawlspawnwalk = {"nz_base_zombie_crawl_out_walk_01",}
local crawlspawnrun = {"nz_base_zombie_crawl_out_run_01","nz_base_zombie_crawl_out_run_02",}
local crawlspawnsprint = {"nz_base_zombie_crawl_out_sprint_01","nz_base_zombie_crawl_out_sprint_01",}
ENT.DeathSequences = {
	"nz_dth_microwave_1",
	"nz_dth_microwave_2",
	"nz_dth_microwave_3",
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


local runsounds = {
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/amb/amb_12.mp3"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				--"nz_legacy_sprint_v5",
				--"nz_legacy_jap_run_v3",
				"nz_t9_base_sprint_ad_v01",
				"nz_t9_base_sprint_ad_v02",
				"nz_t9_base_sprint_ad_v05",
				"nz_t9_base_sprint_ad_v21",
				"nz_t9_base_sprint_ad_v22",
				"nz_t9_base_sprint_ad_v23",
				"nz_t9_base_sprint_ad_v24",
				"nz_sprint_ad3",
				"nz_sprint_ad4",

				"nz_t9_base_sprint_au_v01",
				"nz_t9_base_sprint_au_v02",
				"nz_t9_base_sprint_au_v20",
				"nz_t9_base_sprint_au_v21",
				"nz_t9_base_sprint_au_v22",
				"nz_t9_base_sprint_au_v25",
				"nz_sprint_au3",
				"nz_sprint_au4",

				"nz_pb_zombie_sprint_v6",
				"nz_pb_zombie_sprint_v7",
				"nz_pb_zombie_sprint_v9",
				"nz_pb_zombie_sprint_v10",
				"nz_pb_zombie_sprint_v6",
				"nz_pb_zombie_sprint_v7",
				"nz_pb_zombie_sprint_v9",
				"nz_pb_zombie_sprint_v10",
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
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_04.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_05.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_06.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_07.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_08.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_09.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_04.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_05.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_06.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_07.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_08.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/vox/death/death_09.mp3"),
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

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_00.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_01.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_02.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_03.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_04.mp3"),
	Sound("nz_moo/zombies/vox/_classic/crawl/crawl_05.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_01.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_02.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_03.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_04.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_05.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_06.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_07.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_08.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_09.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_10.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_11.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_12.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_13.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_14.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_15.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_16.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_17.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_18.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_19.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_20.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_01.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_02.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_03.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_04.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_05.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_06.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_07.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_08.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_09.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_10.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_11.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_12.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_13.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_14.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_15.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_16.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_17.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_18.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_19.mp3"),
	Sound("nz_moo/zombies/vox/_spartanskeleton/step/rattle_20.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_zhd/behind/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/behind/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/behind/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/behind/behind_03.mp3"),
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

	util.SpriteTrail(self, 9, Color(45, 255, 45, 25), true, 45, 20, 0.75, 1 / 40 * 0.3, "materials/trails/plasma")

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

function ENT:SpecialInit()
	local fuckercloud = ents.Create("nova_gas_cloud_decay")
	local bone = self:LookupBone("j_spineupper")
	local pos = self:GetBonePosition(bone)
	fuckercloud:SetPos(pos)
	fuckercloud:SetAngles(Angle(0,0,0))
	fuckercloud:SetParent(self)
	fuckercloud:Spawn()

	self.CanGib = false

	local speed = math.random(71,185)
	self:SetRunSpeed(speed)
	self:SpeedChanged()
end

function ENT:ToxicExplode()
	if !self.Exploded then
		self.Exploded = true

		local bone = self:GetBonePosition(self:LookupBone("j_spineupper"))

		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("acidbug_spit_impact", bone, Angle(0,0,0), nil) 

		local fuckercloud = ents.Create("nz_ent_toxic_cloud")
		fuckercloud:SetPos(self:GetPos())
		fuckercloud:SetAngles(Angle(0,0,0))
		fuckercloud:Spawn()

		self:Remove()
	end
end

function ENT:PostDeath(dmginfo) 
	local damagetype = dmginfo:GetDamageType()
	if damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		if self.LaunchSounds then
			self:PlaySound(self.LaunchSounds[math.random(#self.LaunchSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
			self.Launched = true
		end
		self:ToxicExplode()
	end
	if damagetype == DMG_REMOVENORAGDOLL then
		self:ToxicExplode()
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or !self.DeathSequences then
		if self.DeathSounds and !self.Launched then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		end
		self:ToxicExplode()
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) 
	self.OverrideDDoll = true 		-- Overrides death_ragdoll

	if e == "death_ragdoll" then
		self:ToxicExplode()
	end
	if e == "cooked" then
		self:ToxicExplode()
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_mutated/new/decay/corrosive_zm_new_loop_00.wav")
end
