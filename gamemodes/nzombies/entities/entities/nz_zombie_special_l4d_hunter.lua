AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.PrintName = "Hunter"
ENT.Spawnable = true

if CLIENT then 
	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()

		if self:WaterBuff() and !self:BomberBuff() and self:Alive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 0
				elight.g = 50
				elight.b = 255
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:BomberBuff() and !self:WaterBuff() and self:Alive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 150
				elight.g = 255
				elight.b = 75
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		elseif self:WaterBuff() and self:BomberBuff() and self:Alive() then
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 255
				elight.g = 0
				elight.b = 0
				elight.brightness = 10
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end

		self:ZCTFire()
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			local min, max = self:GetCollisionBounds()
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), min, max, Color(255,0,0), true)
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true
ENT.RedEyes = true

ENT.SoundDelayMin = 1
ENT.SoundDelayMax = 3

ENT.MinSoundPitch 			= 95
ENT.MaxSoundPitch 			= 105
ENT.SoundVolume 			= 82 

ENT.DamageRange 			= 95

ENT.AttackDamage 			= 50
ENT.HeavyAttackDamage 		= 150

ENT.Models = {
	{Model = "models/moo/_moo_ports/l4d/infected/hunter/moo_l4d_special_hunter.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_ports/l4d/infected/hunter/moo_l4d2_special_hunter.mdl", Skin = 0, Bodygroups = {0,0}},

	-- Workshop Skins/Models
	{Model = "models/moo/_moo_ports/l4d/infected/hunter/moo_l4d_special_hunter.mdl", Skin = 1, Bodygroups = {0,0}}, 				-- Beta Hunter Texture by Maytree
	{Model = "models/moo/_moo_ports/l4d/infected/hunter/moo_l4d_special_hunter_concept.mdl", Skin = 0, Bodygroups = {0,0}}, 		-- Concept Hunter Model by Sades160
	{Model = "models/moo/_moo_ports/l4d/infected/hunter/moo_l4d2_special_hunter_remastered.mdl", Skin = 0, Bodygroups = {0,0}}, 	-- Hunter Remastered Model by SpicyJam
}

local spawn = {"nz_s4_3arc_traverse_ground_dugup"}


ENT.DeathSequences = {
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
	{seq = "nz_base_hunter_attack_stand_01"},
	{seq = "nz_fwd_ad_attack_v1"},
	{seq = "nz_fwd_ad_attack_v2"},
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
	{seq = "nz_base_hunter_attack_stand_01"},
	{seq = "nz_legacy_attack_v4"},
	{seq = "nz_legacy_attack_v6"},
}

local WalkAttackSequences = {
	{seq = "nz_walk_ad_attack_v1"}, -- Quick single swipe
	{seq = "nz_walk_ad_attack_v4"}, -- Quickish double swipe
}

local SprintAttackSequences = {
	{seq = "nz_t8_attack_sprint_larm_4"},
	{seq = "nz_t8_attack_sprint_rarm_1"},
	{seq = "nz_t8_attack_sprint_rarm_3"},
	{seq = "nz_t8_attack_sprint_rarm_4"},
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
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_09.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_09.mp3"),
}

ENT.IdleSequence = "nz_base_hunter_idle_01"
ENT.IdleSequenceAU = "nz_base_hunter_idle_02"
ENT.NoTargetIdle = "nz_base_hunter_idle_03"
ENT.CrawlIdleSequence = "nz_base_crouch_hunter_idle"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_hunter_walk",
			},
			LowgMovementSequence = {
				"nz_base_hunter_walk",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_base_hunter_crouch_walk_01",
				"nz_base_hunter_crouch_walk_02",
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
				"nz_base_hunter_walk",
			},
			AttackSequences = {WalkAttackSequences},
			StandAttackSequences = {AttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {JumpSequences},
			CrawlJumpSequences = {CrawlJumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_hunter_run",
			},
			LowgMovementSequence = {
				"nz_base_hunter_run",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			CrawlMovementSequence = {
				"nz_base_hunter_crouch_walk_01",
				"nz_base_hunter_crouch_walk_02",
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
				"nz_base_hunter_walk",
			},
			AttackSequences = {SprintAttackSequences},
			StandAttackSequences = {AttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {SprintJumpSequences},
			CrawlJumpSequences = {CrawlJumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
}

ENT.LeapAttackSequences = {
	"nz_zom_exo_lunge_atk_2h_01",
	"nz_zom_exo_lunge_atk_l_01",
	"nz_zom_exo_lunge_atk_r_01",
}

ENT.PainSequences = {
	"nz_base_hunter_stumble_back_01",
	"nz_base_hunter_stumble_back_02",
	"nz_base_hunter_stumble_forward_01",
	"nz_base_hunter_stumble_left_01",
	"nz_base_hunter_stumble_right_01",
	"nz_base_hunter_stumble_right_roll",
}

ENT.ThunderGunSequences = {
	"nz_base_hunter_stumble_back_01",
	"nz_base_hunter_stumble_back_02",
	"nz_base_hunter_stumble_back_01",
	"nz_base_hunter_stumble_back_02",
	"nz_base_hunter_stumble_back_01",
	"nz_base_hunter_stumble_back_02",
	"nz_base_hunter_stumble_back_01",
	"nz_base_hunter_stumble_back_02",
	"nz_base_hunter_stumble_back_01",
	"nz_base_hunter_stumble_back_02",
}

ENT.NormalForwardReactSequences = {
	"nz_l4d_violentalert_f",
	"nz_l4d_violentalert_f",
	"nz_l4d_violentalert_f",
	"nz_l4d_violentalert_f",
	"nz_l4d_violentalert_f",
	"nz_l4d_violentalert_f",
	"nz_l4d_violentalert_f",
}

ENT.NormalLeftReactSequences = {
	"nz_l4d_violentalert_l",
	"nz_l4d_violentalert_l",
	"nz_l4d_violentalert_l",
}

ENT.NormalRightReactSequences = {
	"nz_l4d_violentalert_r",
	"nz_l4d_violentalert_r",
	"nz_l4d_violentalert_r",
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

ENT.WarnSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/warn/hunter_warn_10.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/warn/hunter_warn_14.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/warn/hunter_warn_16.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/warn/hunter_warn_17.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/warn/hunter_warn_18.mp3"),
}

ENT.MeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_hunter/fly/miss/claw_miss_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/miss/claw_miss_2.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/claw_hit_flesh_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/claw_hit_flesh_2.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/claw_hit_flesh_3.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/claw_hit_flesh_4.mp3"),
}

ENT.HeavyAttackImpactSounds = {
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_2.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_3.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_4.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_5.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_6.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_10.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_12.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_13.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_14.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_pain_15.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_09.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_10.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_11.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_12.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_13.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_painshort_14.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_09.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_10.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/hunter_stunned_11.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/death/hunter_death_08.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_09.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_10.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_11.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_12.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_13.mp3"),
}

ENT.LaunchSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_09.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_10.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_11.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_12.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_pounce_13.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_09.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_10.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_11.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_shred_12.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_09.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_06.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_07.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_08.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/idle/hunter_stalk_09.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.WhooshSounds = {
	Sound("nz_moo/zombies/vox/_hunter/attack/lunge_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/attack/lunge_2.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/attack/lunge_3.mp3"),
}

ENT.LungeSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/shriek_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/attack/hunter_attackmix_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/pain/lunge_attack_3.mp3"),
}

ENT.SpawnSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.SpawnStingSounds = {
	Sound("nz_moo/zombies/vox/_hunter/music/hunterbacteria.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/music/hunterbacterias.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then

		self:SetRunSpeed( 100 )
		self:SetHealth( nzRound:GetZombieHealth() * 2 or 75 )
		self:SetMaxHealth( nzRound:GetZombieHealth() * 2 or 75 )

		self.IsStalking = false
		self.CrawlCoolDown = CurTime() + 3
		self.CrawlLength = CurTime() + 16

		self.DodgeTime = CurTime() + math.Rand(2.34, 5.12)

		self.NextSting = CurTime() + math.Rand(25.7, 60.3)
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

	--self:EmitSound(self.SpawnStingSounds[math.random(#self.SpawnStingSounds)], 577)
	self:PlaySound(self.SpawnSounds[math.random(#self.SpawnSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)

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
	local target = self.Target

	-- Spooky Music
	if CurTime() > self.NextSting then
		self.NextSting = CurTime() + math.Rand(25.7, 60.3)
		self:EmitSound(self.SpawnStingSounds[math.random(#self.SpawnStingSounds)], 577)
	end

	-- Attempt to jump out of target's aim.
	if !self:GetCrawler() and self:IsAimedAt() and !nzPowerUps:IsPowerupActive("timewarp") then
		if self:TargetInRange(750) and !self.AttackIsBlocked and CurTime() > self.DodgeTime then
			if !self:IsFacingEnt(target) then return end
			if self:TargetInRange(70) then return end
			if IsValid(target) and target:IsPlayer() then
				local seq = self.ZCTDodgeSequences[math.random(#self.ZCTDodgeSequences)]

				if self:SequenceHasSpace(seq) and self:HasSequence(seq) then
					self:DoSpecialAnimation(seq, true, true)
					-- If there isn't space at all, don't dodge.
					self.DodgeTime = CurTime() + math.Rand(1.34, 3.12)
				end
			end
		end
	end

	-- Jump Attack
	if self:TargetInRange(150) and !self:IsAttackBlocked() and !self:GetCrawler() and !self:GetSpecialAnimation() and !nzPowerUps:IsPowerupActive("timewarp") and math.random(100) <= 25 then
		if self:TargetInRange(50) then return end
		self:TempBehaveThread(function(self)
			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove(self.LeapAttackSequences[math.random(#self.LeapAttackSequences)], 1, self.FaceEnemy)
			self:SetSpecialAnimation(false)
		end)
	end

	-- Pounce Attack
	if self:GetCrawler() and self.IsStalking and IsValid(target) and !target.MonkeyBomb and !target.BHBomb and !self:IsAttackBlocked() and math.random(100) <= 75 then
		if self:TargetInRange(350) and !self:TargetInRange(125) then
			self:TempBehaveThread(function(self)
				--if !self:SequenceHasSpace("nz_base_hunter_attack_lunge_high") then return end

				self:SetSpecialAnimation(true)
				self:PlaySequenceAndMove("nz_base_hunter_attack_lunge_high", 1, self.FaceEnemy)
				self:SetSpecialAnimation(false)

				self.IsStalking = false
				self:SetCrawler(false)
				self:BecomeNormal()
				
				self.CrawlCoolDown = CurTime() + math.random(6,12)
			end)
		elseif self:TargetInRange(600) and !self:TargetInRange(350) then
			self:TempBehaveThread(function(self)
				--if !self:SequenceHasSpace("nz_base_hunter_attack_lunge_low") then return end

				self:SetSpecialAnimation(true)
				self:PlaySequenceAndMove("nz_base_hunter_attack_lunge_low", 1, self.FaceEnemy)
				self:SetSpecialAnimation(false)

				self.IsStalking = false
				self:SetCrawler(false)
				self:BecomeNormal()

				self.CrawlCoolDown = CurTime() + math.random(6,12)
			end)
		end
	end

	-- Start Crawling
	if (!self:GetCrawler() and !self.IsStalking) and CurTime() > self.CrawlCoolDown and IsValid(target) and !target.MonkeyBomb and !target.BHBomb and !self:TargetInRange(150) then
		self.IsStalking = true
		self:SetCrawler(true)
		self.CrawlLength = CurTime() + math.random(12,24)

		self:BecomeCrawler()
	end

	-- Stop Crawling
	if self:GetCrawler() and self.IsStalking and CurTime() > self.CrawlLength then
		self.CrawlCoolDown = CurTime() + math.random(3,9)
		self.IsStalking = false
		self:SetCrawler(false)
		self:BecomeNormal()
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) 
	self.OverrideLsmall = true
	self.OverrideLLarge = true
	self.OverrideRsmall = true
	self.OverrideRLarge = true
	self.OverrideAttack = true 		-- Overrides melee and melee_heavy

	if (e == "melee" or e == "melee_heavy") then

		if self.AttackSounds and !self.IsStalking then
			self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		end
		if e == "melee_heavy" then
			self.HeavyAttack = true
		end

		if self.HeavyAttack and IsValid(self.Target) and self:TargetInRange( self.DamageRange ) and self.IsStalking then
			self:EmitSound("nz_moo/zombies/vox/_hunter/hit/tackled_1.mp3", 85)
			self:EmitSound("nz_moo/zombies/vox/_hunter/music/exenterationhit.mp3", 577)
			self.Target:EmitSound("nz_moo/zombies/vox/_hunter/music/exenterationhit.mp3", SNDLVL_GUNFIRE)
		end

		self:DoAttackDamage()
	end

	if e == "hunter_pain" then
		self:PlaySound(self.PainSounds[math.random(#self.PainSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch),1, 2)
	end
	if e == "hunter_warn" then
		self:PlaySound(self.WarnSounds[math.random(#self.WarnSounds)],577, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		self.NextSound = CurTime() + 10
	end
	if e == "hunter_attack" then
		self:EmitSound(self.WhooshSounds[math.random(#self.WhooshSounds)], 85, math.random(95,105))
		self:PlaySound(self.LungeSounds[math.random(#self.LungeSounds)],577, math.random(self.MinSoundPitch, self.MaxSoundPitch))
		self.NextSound = CurTime() + 10
	end
	if e == "hunter_land" then
		self:EmitSound("nz_moo/zombies/vox/_hunter/fly/bodyfall_largecreature.mp3", 80, math.random(95,105))
	end
end

if SERVER then
	-- This function is really only used for normal zombies a lot, so this can be overridden without problems.
	function ENT:OnInjured(dmginfo)
		local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
		local hitforce 		= dmginfo:GetDamageForce()
		local hitpos 		= dmginfo:GetDamagePosition()
		local inflictor 	= dmginfo:GetInflictor()

		if !self.SpawnProtection then

			--[[ FLINCHING ]]--
			if !self:GetSpecialAnimation() and !self.Dying and !self:IsAttacking() and !self.IsBeingStunned and CurTime() > self.LastFlinch then
				-- Just plays an additive that makes the zombie look like they flinch whenever they take damage.
				-- Fuck you multiplayer... IT DECIDES WHEN THIS SHOULD WORK.
				self.CanFlinch = true
				self.LastFlinch = CurTime() + 0.1
				--self:RestartGesture(ACT_GESTURE_FLINCH_HEAD, true, true)
			end

			--[[ STUMBLING/STUN ]]--
			if CurTime() > self.LastStun then -- The code here is kinda bad tbh, and in turn it does weird shit because of it.
				-- Moo Mark 7/17/23: Alright... We're gonna try again.
				if self.Dying then return end
				if !self:Alive() then return end
				if dmginfo:IsDamageType(DMG_MISSILEDEFENSE) 
					or self:GetSpecialAnimation() 
					or self:GetCrawler() 
					or self:GetIsBusy() 
					or self.ShouldCrawl 
					then return end

				-- 11/1/23: Have to double check the CurTime() > self.LastStun in order to stop the Zombie from being able to stumble two times in a row.
				if !self.IsBeingStunned and !self:GetSpecialAnimation() then
					if allowstumble == 1 then
						if self:CrawlerForceTest(hitforce) and CurTime() > self.LastStun then
							self.IsBeingStunned = true
							self:DoSpecialAnimation(self.PainSequences[math.random(#self.PainSequences)], true, true)
							self.IsBeingStunned = false
							self.LastStun = CurTime() + 8
							self:ResetMovementSequence()
						end
					end
				end
			end
		end
	end
end

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV1Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV2Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV3Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV4Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV5Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV6Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV7Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV8Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}

ENT.TauntAnimV9Sounds = {
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/voice/alert/hunter_alert_05.mp3"),
}
