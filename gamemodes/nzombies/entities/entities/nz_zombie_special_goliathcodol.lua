AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Goliath"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")

	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()

		if self.RedEyes == true and self:IsAlive() and !self:GetDecapitated() then
			self:DrawEyeGlow() 
		end

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


	function ENT:DrawEyeGlow()
		local eyeColor = Color(215,255,0)

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


	hook.Add("CreateClientsideRagdoll", "nZ_Goliath_Ragdoll", function(ent, ragdoll)
        if not IsValid(ent) or not IsValid(ragdoll) then return end
        if not ent:IsValidZombie() then return end
        if ent:GetClass() ~= "nz_zombie_special_goliathcodol" then return end
        
        ragdoll:SetModelScale(1.15, 0.000001)

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
ENT.IsMiniBoss = true

ENT.AttackRange 			= 95
ENT.DamageRange 			= 95
ENT.AttackDamage 			= 75
ENT.HeavyAttackDamage 		= 100 

ENT.SoundVolume 			= 90
ENT.SoundDelayMin 			= 8
ENT.SoundDelayMax 			= 17

ENT.Models = {
	{Model = "models/moo/_codz_ports/codol/goliath/moo_codz_codol_goliath_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/goliath/moo_codz_codol_goliath_zombie_v2.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_base_goliath_spawn_a", "nz_base_goliath_spawn_b"}

ENT.DeathSequences = {
	"nz_base_goliath_death",
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
	{seq = "nz_base_goliath_attack_single_01"},
	{seq = "nz_base_goliath_attack_single_02"},
	{seq = "nz_base_goliath_attack_multi_01"},
	{seq = "nz_base_goliath_attack_multi_02"},
	{seq = "nz_base_goliath_headbutt"},
	{seq = "nz_base_goliath_push"},
}

local WalkAttackSequences = {
	{seq = "nz_base_goliath_attack_single_01"},
	{seq = "nz_base_goliath_attack_single_02"},
	{seq = "nz_base_goliath_attack_multi_01"},
	{seq = "nz_base_goliath_attack_multi_02"},
	{seq = "nz_base_goliath_headbutt"},
	{seq = "nz_base_goliath_push"},
}

local RunAttackSequences = {
	{seq = "nz_base_goliath_attack_run_01"},
}

local SprintAttackSequences = {
	{seq = "nz_base_goliath_attack_sprint_01"},
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
local walksounds = {
	Sound("nz_moo/zombies/vox/_codolgoliath/zmb_vox_goliath_idle_PCM.mp3"),
}

ENT.IdleSequence 	= "nz_base_goliath_idle_01"
ENT.IdleSequenceAU 	= "nz_base_goliath_idle_01"
ENT.NoTargetIdle 	= "nz_base_goliath_idle_01"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_goliath_walk_01",
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

			JumpSequences = {WalkJumpSequencesMiddle},
			JumpSequencesLeft = {WalkJumpSequencesLeft},
			JumpSequencesRight = {WalkJumpSequencesRight},
			CrawlJumpSequences = {CrawlJumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_goliath_run_01",
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

			JumpSequences = {RunJumpSequencesMiddle},
			JumpSequencesLeft = {RunJumpSequencesLeft},
			JumpSequencesRight = {RunJumpSequencesRight},
			CrawlJumpSequences = {CrawlJumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_goliath_sprint_01",
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

			JumpSequences = {SprintJumpSequencesMiddle},
			JumpSequencesLeft = {SprintJumpSequencesLeft},
			JumpSequencesRight = {SprintJumpSequencesRight},
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
	"nz_taunt_v7",
	"nz_taunt_v8",
	"nz_taunt_v9"
}

ENT.EnrageSounds = {
	Sound("nz_moo/zombies/vox/_codolgoliath/zmb_vox_boss_intro_PCM.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_codolgoliath/zmb_vox_goliath_death_PCM.mp3"),
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

ENT.SlamSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/dst_rock_quake/dst_rock_quake_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/dst_rock_quake/dst_rock_quake_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/dst_rock_quake/dst_rock_quake_03.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/dst_rock_quake/dst_rock_quake_04.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/dst_rock_quake/dst_rock_quake_05.mp3"),
}

ENT.SlamSWTSounds = {
	Sound("nz_moo/zombies/vox/_monkey/groundpound/ground_pound_sweet_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/groundpound/ground_pound_sweet_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/groundpound/ground_pound_sweet_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/groundpound/ground_pound_sweet_03.mp3"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_cellbreaker/attack/swing/swing_00.mp3"),
	Sound("nz_moo/zombies/vox/_cellbreaker/attack/swing/swing_01.mp3"),
	Sound("nz_moo/zombies/vox/_cellbreaker/attack/swing/swing_02.mp3"),
	Sound("nz_moo/zombies/vox/_cellbreaker/attack/swing/swing_03.mp3"),
	Sound("nz_moo/zombies/vox/_cellbreaker/attack/swing/swing_04.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_06.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_07.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_08.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_09.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_10.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_11.mp3"),
	Sound("nz_moo/zombies/footsteps/_s2_large/zmb_fs_default_sprint_large_default_12.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(5000)
			self:SetMaxHealth(5000)	
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 425 + 115, 1000, 25000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 425 + 115, 1000, 25000 * count))
			else
				self:SetHealth(5000)
				self:SetMaxHealth(5000)	
			end
		end

		self:SetRunSpeed( 1 )
		self:SetModelScale(1.15, 0.001)
		self.NextSound = CurTime() + self.SoundDelayMax

		self.SlamCooldown = CurTime() + math.Rand(7.15,10.25)

		self.Enraged = false
		self.ShouldEnrage = false
		self.RandomEnrage = CurTime() + math.Rand(15.15,20.25)

		self.Speedup = false
		self.ShouldSpeedup = false
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

	self:EmitSound("nz_moo/zombies/vox/_codolgoliath/zmb_vox_boss_intro_PCM.mp3",577)
	--ParticleEffect("summon_beam",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/pre_spawn.mp3",511,100)
	ParticleEffect("hound_summon",self:GetPos(),self:GetAngles(),nil)
	--ParticleEffect("fx_hellhound_summon",self:GetPos(),self:GetAngles(),nil)

	self:TimeOut(0.55)
	
	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/strikes_00.mp3",511,100)
	ParticleEffectAttach("ins_skybox_lightning",PATTACH_ABSORIGIN_FOLLOW,self,0)

	self:SetSpecialAnimation(false)
	self:CollideWhenPossible()
	self:SetNoDraw(false)
	self:SetBodygroup(1,1)

	if animation then
		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
		self:SetSpecialAnimation(true)
		self:SetIsBusy(true)
		
		self:PlaySequenceAndMove(animation, {gravity = grav})

		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:SetIsBusy(false)
		self:CollideWhenPossible()
	end
end

function ENT:AI()

	-- Speed Up
	if self.ShouldSpeedup and !self.Speedup then
		self.Speedup = true
		self:SetRunSpeed(36)
		self:SpeedChanged()
	end

	-- Slam Attack(Normal)
	if CurTime() > self.SlamCooldown and !self.Enraged and self:TargetInRange(200) and !self:IsAttackBlocked() and math.random(100) < 25 then
		self:TempBehaveThread(function(self)
			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove("nz_base_goliath_ground_smash", 1, self.FaceEnemy)
			self:SetSpecialAnimation(false)

			self.SlamCooldown = CurTime() + math.Rand(7.15,10.25)
		end)
	end

	-- Slam Attack(Rage)
	if self.Enraged and self:TargetInRange(200) and !self:IsAttackBlocked() and math.random(100) < 25 then
		self:TempBehaveThread(function(self)
			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove("nz_base_goliath_attack_leap_01", 1, self.FaceEnemy)
			self:SetSpecialAnimation(false)

			self.Enraged = false
			self.ShouldSpeedup = false
			self.Speedup = false
			self.RandomEnrage = CurTime() + math.Rand(15.15,20.25)
			self.SlamCooldown = CurTime() + math.Rand(7.15,10.25)

			self:SetRunSpeed( 1 )
			self:SpeedChanged()
		end)
	end

	-- ENRAGE
	if !self.Enraged and !self:IsAttackBlocked() and CurTime() > self.RandomEnrage then
		self.Enraged = true

		self:DoSpecialAnimation("nz_base_goliath_roar")
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end
end

function ENT:OnNuke() 
	self:DoSpecialAnimation("nz_base_goliath_stumble_stationary")
end

function ENT:OnInjured(dmginfo)
	if !self:IsAlive() then return end

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce = dmginfo:GetDamageForce()
	local damage = dmginfo:GetDamage()

	local attacker = dmginfo:GetAttacker()

	if !self.ShouldSpeedup and !self.Enraged and math.random(100) < 25 then
		self.ShouldSpeedup = true
	end

	dmginfo:ScaleDamage(0.45)
end

function ENT:CustomAnimEvent(a,b,c,d,e) 

	-- Say you wanted to override some the existing events, use one of these bool below when doing so.
	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large

	if e == "goliath_push" then
		local target = self:GetTarget()

		if IsValid(target) and target:IsPlayer() and !self:IsAttackBlocked() then
			if self:TargetInRange(self.DamageRange) then
				
				self:EmitSound(self.SlamSWTSounds[math.random(#self.SlamSWTSounds)], 90)

				target:NZSonicBlind(1.75)
				target:ViewPunch( VectorRand():Angle() * 0.05 )
				if target:IsOnGround() then
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 10 + Vector( 0, 35, 0 ) )
				else
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 2 + Vector( 0, 35, 14 ) )
				end
			end
		end
	end

	if e == "goliath_slam" then

		for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
	        if not v:IsWorld() and v:IsSolid() then
	            v:SetVelocity(((v:GetPos() - self:GetPos()):GetNormalized()*150) + v:GetUp()*200)
	            
	            if v:IsValidZombie() and !v.IsMooSpecial then
	                if v == self then continue end
	                if v:EntIndex() == self:EntIndex() then continue end
	                if v:Health() <= 0 then continue end
	                if !v:IsAlive() then continue end

	                local seq = v.ThunderGunSequences[math.random(#v.ThunderGunSequences)]
	                if v:HasSequence(seq) then
						v:DoSpecialAnimation(seq)
					end
	            end

	            if v:IsPlayer() and v:IsOnGround() then
	            	v:SetGroundEntity(nil)
	                v:ViewPunch(Angle(-25,math.random(-10, 10),0))
					v:NZSonicBlind(1)
	            end
	        end
	    end

		self:EmitSound(self.SlamSounds[math.random(#self.SlamSounds)], 90)
		self:EmitSound(self.SlamSWTSounds[math.random(#self.SlamSWTSounds)], 90)
		self:EmitSound("nz_moo/zombies/vox/_engineer/evt/hammer/flux.mp3", 90)
		util.ScreenShake(self:GetPos(),5,5,0.5,750)
		for i=1,2 do
			ParticleEffect("bo3_panzer_landing",self:LocalToWorld(Vector(20+(i*2),20,0)),Angle(0,0,0),nil)
		end
	end

	if e == "goliath_fall" then
		self:EmitSound("nz_moo/zombies/vox/_margwa/fall/fall_body.mp3", 100)
	end

	if e == "goliath_roar" then
		self:EmitSound("nz_moo/zombies/vox/_thrasher/enrage_imp_00.mp3",577)
		ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,60)),Angle(0,0,0),nil)	
		util.ScreenShake(self:GetPos(),10000,5000,1,1000)
	end

	if e == "step_right_large" or e == "step_left_large" then
		self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 75)
		util.ScreenShake(self:GetPos(),5,5,0.2,475)
	end
end
