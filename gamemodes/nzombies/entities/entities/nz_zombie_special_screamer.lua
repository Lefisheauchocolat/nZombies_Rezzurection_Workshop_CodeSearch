AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Boom Schreier"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zmb_ger_screamer_arms_01.vmt"),
		[1] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zmb_ger_screamer_body_01.vmt"),
		[2] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zmb_ger_screamer_head_01.vmt"),
		[3] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zmb_ger_screamer_hips_01.vmt"),
		[4] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zmb_ger_screamer_legs_01.vmt"),
		[5] = Material("models/moo/codz/s4_zombies/zod/mtl_c_s4_zom_ger_eyeglow.vmt"),
	}
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end
	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			local color = nzMapping.Settings.zombieeyecolor
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) and (!self.Draw_FX2 or !self.Draw_FX2:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_screamer_shoulder", PATTACH_POINT_FOLLOW, 11)
				self.Draw_FX2 = CreateParticleSystem(self, "zmb_screamer_shoulder", PATTACH_POINT_FOLLOW, 12)
				self.Draw_FX:SetControlPoint(2, Vector(color.r/255, color.g/255, color.b/255)) -- Color
				self.Draw_FX2:SetControlPoint(2, Vector(color.r/255, color.g/255, color.b/255)) -- Color
			end

			if !self.Draw_SFX or !IsValid(self.Draw_SFX) then
				self.Draw_SFX = "nz_moo/zombies/vox/_screamer/zmb_vox_screamer_lp.wav"

				self:EmitSound(self.Draw_SFX, 75, math.random(95, 105), 1, 3)
			end
		end
	end
	hook.Add("CreateClientsideRagdoll", "Screamerragdollfire", function(ent, ragdoll)
        if not IsValid(ent) or not IsValid(ragdoll) then return end
        if not ent:IsValidZombie() then return end

        if (ent.Draw_FX and IsValid(ent.Draw_FX)) and (ent.Draw_FX2 and IsValid(ent.Draw_FX2)) then
            ent.Draw_FX:StopEmissionAndDestroyImmediately()
            ent.Draw_FX2:StopEmissionAndDestroyImmediately()
        end

    end)
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = false

ENT.MinSoundPitch 			= 80
ENT.MaxSoundPitch 			= 110
ENT.SoundVolume 			= 90

ENT.Models = {
	{Model = "models/moo/_codz_ports/s4/zod/moo_codz_s4_zom_sceamer_fb.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_ent_ground_01", "nz_ent_ground_02"}

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

ENT.SparkySequences = {
	"nz_s2_core_stunned_electrobolt_v1",
	"nz_s2_core_stunned_electrobolt_v2",
	"nz_s2_core_stunned_electrobolt_v3",
	"nz_s2_core_stunned_electrobolt_v4",
	"nz_s2_core_stunned_electrobolt_v5",
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

local RunAttackSequences = {
	{seq = "nz_t8_attack_supersprint_larm_1"},
	{seq = "nz_t8_attack_supersprint_larm_2"},
	{seq = "nz_t8_attack_supersprint_rarm_1"},
	{seq = "nz_t8_attack_supersprint_rarm_2"},
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
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_06.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/amb/zmb_screamer_vox_amb_06.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_s4_3arc_screamer_sprint_slow_v04",
				"nz_s4_3arc_screamer_sprint_slow_v05",
				"nz_s4_3arc_screamer_sprint_v02",
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
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			JumpSequences = {SprintJumpSequences},
			CrawlJumpSequences = {CrawlJumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

ENT.IdleSequence = "nz_s4_3arc_screamer_idle_unaware_v01"
ENT.IdleSequenceAU = "nz_s4_3arc_screamer_idle_unaware_v02"
ENT.NoTargetIdle = "nz_s4_3arc_screamer_idle_unaware_v03"

ENT.TauntSequences = {
	"nz_taunt_v1",
	"nz_taunt_v2",
	"nz_taunt_v3",
	"nz_taunt_v4",
	"nz_taunt_v5",
	"nz_taunt_v6",
	"nz_taunt_v8",
	"nz_taunt_v9"
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_03.mp3"),
}

ENT.ElecSounds = {
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_03.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_screamer/attack/zmb_screamer_vox_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/attack/zmb_screamer_vox_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/attack/zmb_screamer_vox_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/attack/zmb_screamer_vox_attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/attack/zmb_screamer_vox_attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/attack/zmb_screamer_vox_attack_06.mp3"),
}

ENT.FootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_0.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_1.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_2.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_3.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_4.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_5.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_6.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_7.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_8.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_9.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_10.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_11.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_12.mp3"),
	Sound("nz_moo/zombies/footsteps/_2k20/gore_step_13.mp3"),
}

ENT.SWTFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_02.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_03.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_04.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_05.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_06.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_07.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_08.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_09.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_10.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_11.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_12.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_13.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_left_14.mp3"),

	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_01.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_02.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_03.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_04.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_05.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_06.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_07.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_08.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_09.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_10.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_11.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_12.mp3"),
	Sound("nz_moo/zombies/footsteps/s2/zmb_fs_default_walk_right_13.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_03.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		self:SetRunSpeed( 71 )

		self.UseCustomAttackDamage = true
		self.HasSTaunted = true
		self.SizIgnite = false

		self.TimesAttacks = 0

		local health = nzRound:GetZombieHealth()
		self:SetHealth( math.ceil(nzRound:GetZombieHealth() * 0.75) or 200)
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

		ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
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

function ENT:CustomAttackDamage(target, dmg) 
	local dmgInfo = DamageInfo()
	dmgInfo:SetAttacker( self )
	dmgInfo:SetDamage( dmg )
	dmgInfo:SetDamageType( DMG_BURN )

	target:TakeDamageInfo(dmgInfo)
	--target:Ignite(1, 0)

	if math.random(100) > 50 and self.TimesAttacks > 0 then
		self:TakeDamage(self:Health() + 666, self, self)
	else
		self.TimesAttacks = self.TimesAttacks + 1
	end

end

function ENT:PostDeath(dmginfo)
	self:Explode(45, true)
	self:StopSound("nz_moo/zombies/vox/_screamer/zmb_vox_screamer_lp.wav")
end

function ENT:CustomAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large

	if e == "step_right_small" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
	end
	if e == "step_left_small" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
	end
	if e == "step_right_large" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
	end
	if e == "step_left_large" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_screamer/zmb_vox_screamer_lp.wav")
end