AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
--ENT.PrintName = "Rock Candy - Vincent A.K.A. Vinny"
ENT.PrintName = "Tormentor"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo & Loonicity"
ENT.Spawnable = true

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t9_zombies/explosive_zombie/mtl_c_t9_zmb_outbreak_explosive_zombie_eyes.vmt"),
		[1] = Material("models/moo/codz/t9_zombies/explosive_zombie/mtl_c_t9_zmb_outbreak_explosive_zombie_eyes_lod.vmt"),
	}
	function ENT:PostDraw()
		self:EffectsAndSounds()

		if self:Alive() then
		local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 255
				elight.g = 20
				elight.b = 0
				elight.brightness = 7
				elight.Decay = 1000
				elight.Size = 60
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end
	end
	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_explosive_zombie_aura", PATTACH_POINT_FOLLOW, 0)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = false

ENT.MinSoundPitch 			= 60
ENT.MaxSoundPitch 			= 130
ENT.SoundDelayMin = 2
ENT.SoundDelayMax = 3
ENT.SoundVolume 			= 90

ENT.Models = {
	{Model = "models/moo/_codz_ports/t9/outbreak/moo_codz_t9_outbreak_explosive_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
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
	{seq = "nz_zombie_catalyst_plasma_death_01"},
	--{seq = "nz_zombie_catalyst_plasma_death_02"},
	{seq = "nz_zombie_catalyst_plasma_death_03"},
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
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_16.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_17.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_16.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/amb/amb_17.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
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
				"nz_t9_base_player_sprint_v01",
				"nz_t9_base_player_sprint_v02",
				"nz_t9_base_player_sprint_v03",
				"nz_t9_base_player_sprint_v04",
				"nz_t9_base_player_sprint_v05",
				"nz_t9_base_player_sprint_v06",
				"nz_t9_base_player_sprint_v07",
				"nz_t9_base_player_sprint_v08",
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
			AttackSequences = {AttackSequences},
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

ENT.ExplodeSounds = {
	Sound("nz_moo/zombies/vox/_explosive/explode/explode_00.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/explode/explode_01.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/explode/explode_02.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/explode/explode_03.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/explode/explode_04.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/explode/explode_05.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/vox/_explosive/shatter/shatter_00.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/shatter/shatter_01.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/shatter/shatter_02.mp3"),
}

ENT.ExplodeChargeLongSounds = {
	Sound("nz_moo/zombies/vox/_explosive/vox/chargeup_pulse/charge_pulse_00.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/chargeup_pulse/charge_pulse_01.mp3"),
}
ENT.ExplodeChargeShortSounds = {
	Sound("nz_moo/zombies/vox/_explosive/vox/chargeup_pulse/charge_pulse_02.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_explosive/vox/chargeup/charge_00.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/chargeup/charge_01.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/vox/chargeup/charge_02.mp3"),
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
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_6227fcdc35eb5b4.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_64cc93d59b717bc.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_7727b0c2577bf57.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_7ed52318fc4c639.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_8dc093b06943b8b.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_bd205d1a5c704bf.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_beb77a773e6f3d.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_c4d2d86ecca5612.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_de06aa6de44f795.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_e606b53211360f8.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_f028d5f4fe68dba.mp3"),
	Sound("nz_moo/zombies/vox/_explosive/step/xsound_f0ff90840e5a916.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_screamer/death/zmb_screamer_vox_death_03.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		self:SetRunSpeed( 71 )

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

function ENT:PostDeath(dmginfo)
	if IsValid(self) then
		self:Explode( 75 )

		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("zmb_explosive_zombie_explo", self:GetPos() + Vector(0,0,40), Angle(0,0,0), nil)
		ParticleEffect("spit_impact_orange", self:GetPos() + Vector(0,0,40), Angle(0,0,0), nil) 

		self:StopSound("nz_moo/zombies/vox/_devildog/loop_00.wav")

		if IsValid(dmginfo) then
			self:Remove(dmginfo)
		else
			self:Remove()
		end
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large
	self.OverrideDDoll = true

	if e == "step_right_small" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
		ParticleEffectAttach("zmb_explosive_zombie_step",PATTACH_POINT,self,12)
	end
	if e == "step_left_small" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
		ParticleEffectAttach("zmb_explosive_zombie_step",PATTACH_POINT,self,11)
	end
	if e == "step_right_large" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
		ParticleEffectAttach("zmb_explosive_zombie_step",PATTACH_POINT,self,12)
	end
	if e == "step_left_large" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 65)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 65)
		ParticleEffectAttach("zmb_explosive_zombie_step",PATTACH_POINT,self,11)
	end
	if e == "anim_catalyst_plasma_death_explode" then
		self:Explode(100, true)
	end
	if e == "anim_explosive_zombie_death_tell_quick" then
		self:EmitSound(self.ExplodeChargeShortSounds[math.random(#self.ExplodeChargeShortSounds)], 511)
		self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
	end
	if e == "anim_explosive_zombie_death_tell_long" then
		self:EmitSound(self.ExplodeChargeLongSounds[math.random(#self.ExplodeChargeLongSounds)], 511)
		self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
	end
	if e == "death_ragdoll" then
		if IsValid(DamageInfo()) then
			self:Remove(DamageInfo())
		else
			self:Remove()
		end
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_screamer/zmb_vox_screamer_lp.wav")
end