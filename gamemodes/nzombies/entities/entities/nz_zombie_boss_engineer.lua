AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Engineer"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()

		if self:WaterBuff() and !self:BomberBuff() and self:IsAlive() then
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
		elseif self:BomberBuff() and !self:WaterBuff() and self:IsAlive() then
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
		elseif self:WaterBuff() and self:BomberBuff() and self:IsAlive() then
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
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end
	hook.Add("CreateClientsideRagdoll", "nZ_Engineer_Ragdoll", function(ent, ragdoll)
        if not IsValid(ent) or not IsValid(ragdoll) then return end
        if not ent:IsValidZombie() then return end
        if ent:GetClass() ~= "nz_zombie_boss_engineer" then return end

        --
        if IsValid(ent) and ent.GetZCTFlameColor and ent:GetZCTFlameColor() then 
        	if ent:GetZCTFlameColor() == "" then
        		return 
        	end
        end

        if ent.Draw_FX and IsValid(ent.Draw_FX) then
            ent.Draw_FX:StopEmissionAndDestroyImmediately()
        end

    end)
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.RedEyes = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooBossZombie = true

ENT.DamageRange 			= 75
ENT.AttackDamage 			= 75
ENT.HeavyAttackDamage 		= 100 

ENT.SoundVolume 			= 90

ENT.Models = {
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_engineer.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_base_zombie_cellbreaker_summondogs",}

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
	{seq = "nz_base_zombie_cellbreaker_attack_01"},
	{seq = "nz_base_zombie_cellbreaker_attack_02"},
	{seq = "nz_base_zombie_cellbreaker_attack_03"},
}

local WalkAttackSequences = {
	{seq = "nz_base_zombie_cellbreaker_attack_01"},
	{seq = "nz_base_zombie_cellbreaker_attack_02"},
	{seq = "nz_base_zombie_cellbreaker_attack_03"},
}

local RunAttackSequences = {
	{seq = "nz_base_zombie_boss_attack_running"},
}

local SprintAttackSequences = {
	{seq = "nz_base_zombie_boss_attack_sprinting"},
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
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/amb/amb_09.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_engineer/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/attack/attack_03.mp3"),
}

ENT.IdleSequence = "nz_base_zombie_cellbreaker_idle_a"
ENT.IdleSequenceAU = "nz_base_zombie_cellbreaker_idle_b"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_zombie_boss_walk_01",
				"nz_base_zombie_cellbreaker_walk_01",
			},
			LowgMovementSequence = {
				"nz_astro_walk_v1",
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
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_zombie_boss_run_01",
				"nz_base_zombie_boss_run_02",
				"nz_base_zombie_boss_run_03",
				"nz_base_zombie_boss_run_04",
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
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_zombie_boss_sprint_01",
				"nz_base_zombie_boss_sprint_02",
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

			PassiveSounds = {runsounds},
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
	"nz_taunt_v7",
	"nz_taunt_v8",
	"nz_taunt_v9"
}

ENT.EnrageSounds = {
	Sound("nz_moo/zombies/vox/_engineer/roar/roar_00.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/roar/roar_01.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/roar/roar_02.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/roar/roar_03.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_engineer/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/death/death_04.mp3"),
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

ENT.HitHeadSounds = {
	Sound("nz_moo/zombies/vox/_engineer/fly/headbang/headbang_00.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/fly/headbang/headbang_01.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/fly/headbang/headbang_02.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/fly/headbang/headbang_03.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/fly/headbang/headbang_04.mp3"),
	Sound("nz_moo/zombies/vox/_engineer/fly/headbang/headbang_05.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_director/_sfx/steps/zmb_director_step_00.mp3"),
	Sound("nz_moo/zombies/vox/_director/_sfx/steps/zmb_director_step_01.mp3"),
	Sound("nz_moo/zombies/vox/_director/_sfx/steps/zmb_director_step_02.mp3"),
	Sound("nz_moo/zombies/vox/_director/_sfx/steps/zmb_director_step_03.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		local hp = nzRound:GetZombieHealth()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(1000)
			self:SetMaxHealth(1000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(hp * 3 * count, 1000, 60000 * count))
				self:SetMaxHealth(math.Clamp(hp * 3 * count, 1000, 60000 * count))
			else
				self:SetHealth(1000)
				self:SetMaxHealth(1000)	
			end
		end

		self:SetRunSpeed( 1 )
		self:SetModelScale(1.15, 0.001)
		self.NextSound = CurTime() + self.SoundDelayMax

		self.Enraged = false
		self.ShouldEnrage = false
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	self:SetNoDraw(true)
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)

	self:EmitSound("nz_moo/zombies/vox/_engineer/evt/spawn/engineer_00.mp3",577)
	self:EmitSound("nz_moo/zombies/vox/_director/_sfx/zmb_director_yellow_beam_PCM.mp3",577)
	ParticleEffect("summon_beam",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)

	self:TimeOut(1.5)

	self:SetSpecialAnimation(false)
	self:SetInvulnerable(false)
	self:CollideWhenPossible()
	self:SetNoDraw(false)

	self:EmitSound("nz_moo/zombies/vox/_engineer/evt/spawn/bells_00.mp3", 577)
	self:EmitSound("nz_moo/zombies/vox/_director/_sfx/zmb_director_beam_PCM.mp3", 577)

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
	-- ENRAGE
	if !self.Enraged and self.ShouldEnrage then
		self.Enraged = true

		self:EmitSound("nz_moo/zombies/vox/_thrasher/enrage_imp_00.mp3",577)
		ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,60)),Angle(0,0,0),nil)	
		
		for k,v in pairs(player.GetAll()) do
			if v:Alive() and self:GetRangeTo( v:GetPos() ) < 575 then
				v:NZSonicBlind(1)
			end
		end

		self:DoSpecialAnimation("nz_base_zombie_cellbreaker_summondogs")
		self:SetRunSpeed(150)
		self:SpeedChanged()
	end
end

function ENT:OnInjured(dmginfo)
	if !self:IsAlive() then return end

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce = dmginfo:GetDamageForce()
	local damage = dmginfo:GetDamage()

	local attacker = dmginfo:GetAttacker()

	if !self.Enraged and !self.ShouldEnrage and math.random(100) < 25 then -- Have a chance of becoming enraged from just being shot.
		self.ShouldEnrage = true
	end

	dmginfo:ScaleDamage(0.5)
end

function ENT:CustomAnimEvent(a,b,c,d,e) 

	-- Say you wanted to override some the existing events, use one of these bool below when doing so.
	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large

	if e == "boss_headbang" then
		self:EmitSound(self.HitHeadSounds[math.random(#self.HitHeadSounds)], 85)
	end

	if e == "boss_enrage" then
		self.NextSound = CurTime() + self.SoundDelayMax
		self:EmitSound(self.EnrageSounds[math.random(#self.EnrageSounds)],577, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		util.ScreenShake(self:GetPos(),10000,5000,1,1000)
	end

	if e == "step_right_large" or e == "step_left_large" then
		self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 80)
		util.ScreenShake(self:GetPos(),5,5,0.2,475)
	end
end
