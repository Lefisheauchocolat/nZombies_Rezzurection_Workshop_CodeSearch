AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Wallace"
ENT.PrintName = "Water Catalyst"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		self:PostDraw()
	end
	function ENT:PostDraw()
		self:EffectsAndSounds()

		if self:IsAlive() then
			if self:BomberBuff() then
				local elight = DynamicLight( self:EntIndex(), true )
				if ( elight ) then
					local bone = self:LookupBone("j_spineupper")
					local pos = self:GetBonePosition(bone)
					pos = pos 
					elight.pos = pos
					elight.r = 0
					elight.g = 255
					elight.b = 75
					elight.brightness = 10
					elight.Decay = 1000
					elight.Size = 40
					elight.DieTime = CurTime() + 1
					elight.style = 0
					elight.noworld = true
				end
			else
				local elight = DynamicLight( self:EntIndex(), true )
				if ( elight ) then
					local bone = self:LookupBone("j_spineupper")
					local pos = self:GetBonePosition(bone)
					pos = pos 
					elight.pos = pos
					elight.r = 0
					elight.g = 100
					elight.b = 255
					elight.brightness = 6
					elight.Decay = 1000
					elight.Size = 40
					elight.DieTime = CurTime() + 1
					elight.style = 0
					elight.noworld = true
				end
			end

			local eyeglow =  Material("nz_moo/sprites/moo_glow1")
			local eyeColor = Color(255,200,255)
			local latt = self:LookupAttachment("lefteye")
			local ratt = self:LookupAttachment("righteye")

			if latt == nil then return end
			if ratt == nil then return end

			local leye = self:GetAttachment(latt)
			local reye = self:GetAttachment(ratt)

			local righteyepos = leye.Pos + leye.Ang:Forward()*0.5
			local lefteyepos = reye.Pos + reye.Ang:Forward()*0.5

			if lefteyepos and righteyepos then
				render.SetMaterial(eyeglow)
				render.DrawSprite(lefteyepos, 4, 4, eyeColor)
				render.DrawSprite(righteyepos, 4, 4, eyeColor)
			end
		end
	end
	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) and (!self.Draw_FX2 or !self.Draw_FX2:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_mutated_water_aura", PATTACH_POINT_FOLLOW, 9)
				self.Draw_FX2 = CreateParticleSystem(self, "spit_trail_glow_blue", PATTACH_POINT_FOLLOW, 2)
			end

			if !self.Draw_SFX or !IsValid(self.Draw_SFX) then
				self.Draw_SFX = "nz_moo/zombies/vox/_mutated/new/water/water_zm_loop.wav"

				self:EmitSound(self.Draw_SFX, 65, math.random(95, 105), 1, 3)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.RedEyes = false
ENT.IsMooZombie = true
ENT.IsCatalyst = true

--ENT.IsMooSpecial = true
--ENT.MooSpecialZombie = true -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.

ENT.Models = {
	{Model = "models/moo/_codz_ports/t8/catalysts/moo_codz_t8_water_catalyst.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb"}
local spawnrun = {"nz_spawn_ground_v1_run"}
local spawnfast = {"nz_spawn_ground_climbout_fast", "nz_s4_3arc_traverse_riser"}
local spawnsuperfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

local crawlspawnwalk = {"nz_base_zombie_crawl_out_walk_01",}
local crawlspawnrun = {"nz_base_zombie_crawl_out_run_01","nz_base_zombie_crawl_out_run_02",}
local crawlspawnsprint = {"nz_base_zombie_crawl_out_sprint_01","nz_base_zombie_crawl_out_sprint_01",}
ENT.DeathSequences = {
	"nz_death_v1",
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
	"nz_traverse_climbup128"
}
local SlowClimbUp160 = {
	"nz_traverse_climbup160"
}
local FastClimbUp36 = {
	"nz_traverse_fast_climbup36"
}
local FastClimbUp48 = {
	"nz_traverse_fast_climbup48"
}
local FastClimbUp72 = {
	"nz_traverse_fast_climbup72"
}
local FastClimbUp96 = {
	"nz_traverse_fast_climbup96"
}
local ClimbUp200 = {
	"nz_traverse_climbup200"
}

local AttackSequences = {
	{seq = "nz_attack_stand_ad_1"},
	{seq = "nz_attack_stand_au_1"},
	{seq = "nz_legacy_attack_v3"},
	{seq = "nz_legacy_attack_v4"},
	{seq = "nz_legacy_attack_v11"},
	{seq = "nz_fwd_ad_attack_v1"},
	{seq = "nz_fwd_ad_attack_v2"},
	{seq = "nz_legacy_attack_superwindmill"},
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
}
local SprintJumpSequences = {
	{seq = "nz_barricade_sprint_1"},
	{seq = "nz_barricade_sprint_2"},
}
local walksounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_16.mp3"),
}

ENT.IdleSequence = "nz_idle_v1"
ENT.IdleSequenceAU = "nz_idle_v1"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			CrawlOutSequences = {crawlspawnwalk},
			MovementSequence = {
				"nz_walk_v1",
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
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			CrawlOutSequences = {crawlspawnrun},
			MovementSequence = {
				"nz_run_v1",
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

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			CrawlOutSequences = {crawlspawnsprint},
			MovementSequence = {
				"nz_sprint_v1",
				"nz_sprint_v2",
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

			PassiveSounds = {walksounds},
		},
	}},
	--[[{Threshold = 155, Sequences = {
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
	}}]]
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
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_05.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/death/death_05.mp3"),
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
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_09.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_10.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_11.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_12.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_13.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_14.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_15.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_16.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_17.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_18.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/attack/attack_19.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/amb/amb_16.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_10.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_11.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_12.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_13.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/vox/pain/pain_14.mp3"),
}

ENT.FootstepsSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_05.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_06.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_07.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_08.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/step/step_water_09.mp3"),
}

ENT.SWTFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_05.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_06.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_07.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_08.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_09.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_10.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_11.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_12.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_13.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_14.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_15.mp3"),
}

ENT.ExplodeSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/water/zmb_catalyst_death_explode_water.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/gibs/bodyfall/fall_00.mp3"),
	Sound("nz_moo/zombies/gibs/bodyfall/fall_01.mp3"),
	Sound("nz_moo/zombies/gibs/bodyfall/fall_02.mp3"),
}

ENT.BuffImpactSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/impact/impact_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/impact/impact_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/impact/impact_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/impact/impact_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/impact/impact_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/impact/impact_05.mp3"),
}

ENT.BuffImpactSWTSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/swt/impact_swt_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/swt/impact_swt_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/water/buff/swt/impact_swt_02.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav")
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav")
}

function ENT:StatsInitialize()
	if SERVER then
		if nzRound:GetNumber() == -1 then
			self:SetRunSpeed( math.random(25, 220) )
			self:SetHealth( math.random(100, 1500) )
		else
			local speeds = nzRound:GetZombieCoDSpeeds()
			if speeds then
				self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
			else
				self:SetRunSpeed( 100 )
			end
			self:SetHealth( nzRound:GetZombieHealth() * 2 or 75 )
		end

		self.WaterCoolDown = CurTime() + 1
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn(animation, grav, dirt)

	animation = animation or self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	if self.SpawnedFromZombie then -- Do the emerge from zombie anim.
		self:DoSpecialAnimation("nz_zombie_catalyst_emerge")
		return
	end

	self:EmitSound("nz_moo/zombies/vox/_mutated/new/_shared/spawn_stinger/zmb_catalyst_stinger_water.mp3", 100, math.random(95,105))

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

if SERVER then
	function ENT:AI() 
		if CurTime() > self.WaterCoolDown then
			self.WaterCoolDown = CurTime() + 1
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 500)) do
				if IsValid(v) and v:IsValidZombie() and v.IsMooZombie then
				if v.IsMooSpecial or v.IsMooBossZombie or v.NZBossType or v.IsCatalyst or v:WaterBuff() then continue end -- will ignore itself and Bosses
					self:ResetMovementSequence()
					self:MoveToPos(v:GetPos(), {lookahead = 10, tolerance = 50, maxage = 3, repath = 1})
					self:FleeTarget(3)
					if v.SpeedBasedSequences then
						if self:BomberBuff() then
			            	v:SetRunSpeed(250)
							v.loco:SetDesiredSpeed( v:GetRunSpeed() )
							v:SetHealth( nzRound:GetZombieHealth() * 5 )
							v:SpeedChanged()
							v:SetBomberBuff(true)
							v:SetWaterBuff(true)
						else
							v:SetHealth( nzRound:GetZombieHealth() * 3 )
							v:SetWaterBuff(true)
						end
						v:EmitSound(self.BuffImpactSounds[math.random(#self.BuffImpactSounds)],100,math.random(95,105))
						v:EmitSound(self.BuffImpactSWTSounds[math.random(#self.BuffImpactSWTSounds)],100,math.random(95,105))
						ParticleEffectAttach("water_playerdive",PATTACH_ABSORIGIN_FOLLOW,v,0)
						ParticleEffectAttach("water_playeremerge",PATTACH_ABSORIGIN_FOLLOW,v,0)
					end
				end
			end
		end
	end
end

function ENT:PostDeath(dmginfo)
	if IsValid(self) then
		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("spit_impact_blue", self:GetPos() + Vector(0,0,40), Angle(0,0,0), nil) 

		self:StopSound("nz_moo/zombies/vox/_mutated/new/water/water_zm_loop.wav")

		if IsValid(dmginfo) then
			self:Remove(dmginfo)
		else
			self:Remove()
		end
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e)

	self.OverrideLsmall = true
	self.OverrideRsmall = true
	self.OverrideLLarge = true
	self.OverrideRLarge = true
	self.OverrideDDoll = true

	if e == "step_left_small" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
		ParticleEffectAttach("zmb_mutated_water_step",PATTACH_POINT,self,11)
	end
	if e == "step_right_small" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
		ParticleEffectAttach("zmb_mutated_water_step",PATTACH_POINT,self,12)
	end
	if e == "step_left_large" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
		ParticleEffectAttach("zmb_mutated_water_step",PATTACH_POINT,self,11)
	end
	if e == "step_right_large" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
		ParticleEffectAttach("zmb_mutated_water_step",PATTACH_POINT,self,12)
	end
	if e == "death_ragdoll" then
		if IsValid(DamageInfo()) then
			self:Remove(DamageInfo())
		else
			self:Remove()
		end
		--self:BecomeRagdoll(DamageInfo())
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_mutated/new/water/water_zm_loop.wav")
end