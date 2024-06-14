AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "indivisible zobie"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "Wavy"
ENT.Spawnable = true

if CLIENT then 

	function ENT:PostDraw()
		self:EffectsAndSounds()
	end

	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if !self.Draw_FX or !IsValid(self.Draw_FX) then
				self.Draw_FX = "wavy_zombie/hev/crimhead_run.wav"

				self:EmitSound(self.Draw_FX, 75, math.random(95, 105), 1, 3)
			end
		end
	end

	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = false

ENT.Models = {
	{Model = "models/wavy_rigs/lethal_necrotics/wavy_zombie_cloaker_new.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnrun = {"nz_ent_ground_01", "nz_ent_ground_02"}

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
	{seq = "nz_iw7_cp_zom_stand_attack_l_01"},
	{seq = "nz_iw7_cp_zom_stand_attack_l_02"},
	{seq = "nz_iw7_cp_zom_stand_attack_r_01"},
	{seq = "nz_iw7_cp_zom_stand_attack_r_02"},
	{seq = "nz_zom_core_stand_attack_2h_01"},
	{seq = "nz_zom_core_stand_attack_2h_02"},
}

local RunAttackSequences = {
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

local SprintJumpSequences = {
	{seq = "nz_barricade_sprint_1"},
	{seq = "nz_barricade_sprint_2"},
	--{seq = "nz_mantle_over_128"}, -- Here for later...
}

local runsounds = {
	Sound("npc/zombie/zombie_pain1.wav"),
	Sound("npc/zombie/zombie_pain2.wav"),
	Sound("npc/zombie/zombie_pain3.wav"),
	Sound("npc/zombie/zombie_pain4.wav"),
	Sound("npc/zombie/zombie_pain5.wav"),
	Sound("npc/zombie/zombie_pain6.wav"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnrun},
			MovementSequence = {
				"nz_supersprint_ad3",
				"nz_supersprint_au3",
				"nz_legacy_sprint_v4",
				"nz_supersprint_ad11",
				"nz_supersprint_ad12",
				"nz_supersprint_au6",
				"nz_gm_zrun_fast",
				"nz_gm_sprint",
				"nz_s2_siz_slow_sprint_v1",
				"nz_s2_siz_slow_sprint_v2",
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
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {SprintJumpSequences},
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
	"npc/zombie_poison/pz_die1.wav",
	"npc/zombie_poison/pz_die2.wav",
	"npc/zombie_poison/pz_pain1.wav",
	"npc/zombie/zombie_die2.wav"
}

ENT.AttackSounds = {
	"npc/zombie/zo_attack1.wav",
	"npc/zombie/zo_attack2.wav"
}

ENT.CustomWalkFootstepsSounds = {
	"npc/zombie/foot1.wav",
	"npc/zombie/foot2.wav",
	"npc/zombie/foot3.wav"
}

ENT.CustomRunFootstepsSounds = {
	"npc/zombie/foot1.wav",
	"npc/zombie/foot2.wav",
	"npc/zombie/foot3.wav"
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
			self:SetHealth( math.ceil(nzRound:GetZombieHealth() * 0.5) or 75 )
		end
	end
		self.Cloaked = false
		self.CanCloak = true
		self.Cooldown = CurTime() + math.random(2,6)
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

function ENT:PerformDeath(dmginfo)
	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:StopSound("wavy_zombie/hev/crimhead_run.wav")
	self:BecomeRagdoll(dmginfo)
end

function ENT:OnRemove()
	self:StopSound("wavy_zombie/hev/crimhead_run.wav")
end

function ENT:PostAdditionalZombieStuff()
	--if self:GetSpecialAnimation() then return end
	if CurTime() > self.Cooldown and self.Cloaked then
		if math.random(15) == 15 then
			self:EmitSound("npc/stalker/go_alert2a.wav", 500, 100, 1, 2)
		else
			self:EmitSound("npc/stalker/stalker_alert"..math.random(1,3).."b.wav", 500, 100, 1, 2)
		end
		self.Cloaked = false
		self.CanCloak = true
		self.Cooldown = CurTime() + math.random(2,6)
		ParticleEffectAttach("bo3_qed_explode_2", 4, self, 10)
		self:EmitSound("weapons/tfa_bo3/qed/beam_fx.wav")
		--print("surprise!")
	end
	if CurTime() > self.Cooldown and self.CanCloak and !self.Cloaked then
	self.CanCloak = false
	self.Cloaked = true
	ParticleEffectAttach("bo3_qed_explode_floor", 4, self, 10)
	self:EmitSound("weapons/tfa_bo3/qed/evt_qed_poof.wav")
	self.Cooldown = CurTime() + math.random(2,6)
	--print("im indicvisesble")
	end
	if self:Health() > 0 and self.Cloaked then
		self:SetMaterial( "invisible" )
	end
	if self:Health() > 0 and !self.Cloaked then
		self:SetMaterial( "" )
	end
end

--[[function ENT:OnTargetInAttackRange()
    if !self:GetBlockAttack() and !self.Cloaked and !nzPowerUps:IsPowerupActive("timewarp") then
    self:Attack()
    else
    self:TimeOut(1)
    end
end]]