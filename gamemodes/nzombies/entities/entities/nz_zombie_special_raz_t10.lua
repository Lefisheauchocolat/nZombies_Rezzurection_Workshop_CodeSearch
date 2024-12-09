AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Mangler"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t10_zombies/zm/xmaterial_7bc047c19822a5.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

local util_traceline = util.TraceLine
local util_tracehull = util.TraceHull

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMiniBoss = true

ENT.AttackRange = 95
ENT.DamageRange = 95

ENT.AttackDamage = 75
ENT.HeavyAttackDamage = 115

ENT.MinSoundPitch = 95
ENT.MaxSoundPitch = 105

ENT.SoundDelayMin = 6
ENT.SoundDelayMax = 12

ENT.Eye = Material("models/moo/codz/t10_zombies/zm/xmaterial_7bc047c19822a5.vmt")

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_base_zmb_raz_portal_spawn"}

ENT.DeathSequences = {
	"nz_base_zmb_raz_death_collapse_fallback_1",
	"nz_base_zmb_raz_death_collapse_fallback_2",
	"nz_base_zmb_raz_death_collapse_fallback_2",
}

ENT.BarricadeTearSequences = {}

local JumpSequences = {
	{seq = "nz_base_zmb_raz_mantle_over_36"},
}

local AttackSequences = {
	{seq = "nz_base_zmb_raz_attack_sickle_double_swing_1"},
	{seq = "nz_base_zmb_raz_attack_sickle_double_swing_2"},
	{seq = "nz_base_zmb_raz_attack_sickle_double_swing_3"},
	{seq = "nz_base_zmb_raz_attack_sickle_swing_down"},
	{seq = "nz_base_zmb_raz_attack_sickle_swing_l_to_r"},
	{seq = "nz_base_zmb_raz_attack_sickle_swing_r_to_l"},
	{seq = "nz_base_zmb_raz_attack_sickle_swing_uppercut"},
}

local WalkAttackSequences = {
	{seq = "nz_base_zmb_raz_run_attack_v1"},
}

local RunAttackSequences = {
	{seq = "nz_base_zmb_raz_sprint_attack_v1"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/all_is_ours.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/burn_demolish.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/come_face_destruction.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/consume_conquer.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/crush_them.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/death_awaits.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/destroy_it_all.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/eliminate_weakness.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/enemy_is_close.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/enemy_near_break_them.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/exterminate_enemies.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/getting_close_lets_play.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/hold_this_ground.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/i_am_your_doom.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/i_break_i_make_crawl.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/i_show_mercy_i_make_quick.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/i_smell_weakness.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/i_tear_you_apart.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/i_will_snap_your_bones.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/leave_nothing_alive.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/must_slaughter_enemies.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/see_them_run.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/so_small_you_will_shatter.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/this_is_my_domain.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/this_world_will_burn.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/there_you_are_now_die.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/your_world_is_ours_now.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/your_time_is_done.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/you_stink_of_fear.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/you_will_turn_to_ash.mp3"),
}

ENT.NormalMantleOver48 = {
	"nz_base_zmb_raz_mantle_over_48",
}

ENT.NormalMantleOver72 = {
	"nz_base_zmb_raz_mantle_over_72",
}

ENT.NormalMantleOver96 = {
	"nz_base_zmb_raz_mantle_over_96",
}

ENT.NormalMantleOver128 = {
	"nz_base_zmb_raz_mantle_over_128",
}

ENT.ShootSequences = {
	"nz_base_zmb_raz_attack_shoot_01",
	"nz_base_zmb_raz_attack_shoot_02",
}

--[[
ENT.ZombieLedgeClimbLoopSequences = {
	"nz_base_zmb_raz_jump_up_loop",
}
ENT.ZombieLedgeClimbSequences = {
	"nz_base_zmb_raz_jump_finish", -- Will only ever be one, for easy overridding.
}
ENT.ZombieLedgeClimbSmallLoopSequences = {
	"nz_base_zmb_raz_jump_up_loop_quick",
}
ENT.ZombieLedgeClimbSmallSequences = {
	"nz_base_zmb_raz_jump_finish_quick", -- Will only ever be one, for easy overridding.
}
]]
ENT.ZombieLandSequences = {
	"nz_base_zmb_raz_land", -- Will only ever be one, for easy overridding.
}

ENT.ZombieStunInSequence = "nz_base_zmb_raz_stun_in"
ENT.ZombieStunOutSequence = "nz_base_zmb_raz_stun_out"

ENT.SparkySequences = {
	"nz_base_zmb_raz_stun_loop",
	"nz_base_zmb_raz_stun_loop",
	"nz_base_zmb_raz_stun_loop",
	"nz_base_zmb_raz_stun_loop",
	"nz_base_zmb_raz_stun_loop",
}

ENT.IdleSequence 	= "nz_base_zmb_raz_idle"
ENT.IdleSequenceAU 	= "nz_base_zmb_raz_idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_zmb_raz_walk",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {WalkAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_zmb_raz_sprint",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.EnrageSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t10/rage/rage_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/rage/rage_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/rage/rage_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/rage/rage_03.mp3"),
}

ENT.MeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_raz/melee/swing/melee_swing_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/melee/swing/melee_swing_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/melee/swing/melee_swing_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/melee/swing/melee_swing_03.mp3"),
}

ENT.MeleeWhooshSWTSounds = {
	Sound("nz_moo/zombies/vox/_raz/swing_blade/swing_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/swing_blade/swing_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/swing_blade/swing_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/swing_blade/swing_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/swing_blade/swing_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/swing_blade/swing_05.mp3"),
}

ENT.WalkFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_00.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_01.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_02.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_03.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_04.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_05.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_06.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_07.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_08.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_09.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_10.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/step/footstep_11.mp3"),
}

ENT.WalkFootstepsGearSounds = {
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_00.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_01.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_02.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_03.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_04.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_05.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_06.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_07.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_08.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_09.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_10.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_11.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_12.mp3"),
	Sound("nz_moo/zombies/vox/_gladiator/foley/movement/movement_13.mp3"),
}

ENT.ArmCannonShootSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t10/cannon/fire.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_10.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/pain/pain_11.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/attack/attack_08.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t10/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/death/death_04.mp3"),
}

ENT.DeathExploSounds = {
	Sound("nz_moo/zombies/vox/_raz/death/warlord_death_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/death/warlord_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/death/warlord_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/death/warlord_death_03.mp3"),
}

ENT.DeathSWTSounds = {
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_00.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_01.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_02.mp3"),
}

ENT.MangleTauntSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t10/laugh/laugh_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/laugh/laugh_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/laugh/laugh_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/laugh/laugh_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t10/lines/our_power_grows.mp3"),
}

ENT.RadioSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_05.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_06.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_07.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_08.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_09.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_10.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_11.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_12.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/ambient_radio/raz_ambient_13.mp3"),
}

ENT.MumbleSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.CannonInterruptSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/mangler/raz_charge_interrupt_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/mangler/raz_charge_interrupt_01.mp3"),
}

ENT.BloodSounds = {
	Sound("physics/flesh/flesh_squishy_impact_hard1.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard2.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard3.wav"),
	Sound("physics/flesh/flesh_squishy_impact_hard4.wav"),
}

ENT.MetalImpactSounds = {
	Sound("physics/metal/metal_solid_impact_bullet1.wav"),
	Sound("physics/metal/metal_solid_impact_bullet2.wav"),
	Sound("physics/metal/metal_solid_impact_bullet3.wav"),
	Sound("physics/metal/metal_solid_impact_bullet4.wav"),
}

ENT.ArmorBreakSounds = {
	Sound("nz_moo/zombies/fly/armor_break/break_00.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_01.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_02.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_03.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_04.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_05.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_06.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_07.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_08.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_09.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_10.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_11.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_12.mp3"),
	Sound("nz_moo/zombies/fly/armor_break/break_13.mp3"),
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
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 425 + 225, 1000, 25000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 425 + 225, 1000, 25000 * count))
			else
				self:SetHealth(5000)
				self:SetMaxHealth(5000)	
			end
		end

		self.NextShoot = CurTime() + 3
		self.ArmCannon = true
		self.UsingArmCannon = false
		self.ArmCannonHP = self:GetMaxHealth() * 0.01

		self.Helmet = true
		self.HelmetHP = self:GetMaxHealth() * 0.35

		self.Chest = true
		self.ChestHP = self:GetMaxHealth() * 0.125

		self.RandomEnrage = CurTime() + math.random(15,27)
		self.ShouldEnrage = false
		self.Enraged = false

		self.RadioSoundTime = CurTime() + 5

		self.CannonInspect = CurTime() + 5

		self:SetRunSpeed(1)
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	animation = self:SelectSpawnSequence()
	local stype

	if IsValid(self.SpawnIndex) then
		stype = self.SpawnIndex:GetSpawnType()
	end

	self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))
	self:SetSurroundingBounds(Vector(-45, -45, 0), Vector(45, 45, 80))

	self:SetBodygroup(1,0) -- Arm
	self:SetBodygroup(2,0) -- Helmet
	self:SetBodygroup(3,0) -- Torso

	if stype ~= 1 then
		ParticleEffect("zmb_trickster_portal",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/portal/zmb_spawn_portal_0"..math.random(6)..".mp3",100,math.random(95,105))
	else
		animation = "idle"
	end

	self:EmitSound("nz_moo/zombies/vox/_raz/_t9/spawn.mp3", 577)

	if animation then
		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
		self:SetSpecialAnimation(true)
		self:SetIsBusy(true)
			
		self:PlaySequenceAndMove(animation, {gravity = true})

		self:SetSpecialAnimation(false)
		self:SetIsBusy(false)
		self:CollideWhenPossible()
	end
end

function ENT:OnStunOut() 
	self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 90, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
end

function ENT:AI()
	-- Cannon
	if CurTime() > self.NextShoot and self.ArmCannon and self:IsOnGround() and IsValid(self.Target) then
		if !self:IsAttackBlocked() and self:TargetInRange(750) and !self:TargetInRange(150) and self:IsFacingEnt(self.Target) then
			self:TempBehaveThread(function(self)
				self.NextShoot = CurTime() + math.random(5,9)

				self:SetSpecialAnimation(true)

				self.UsingArmCannon = true
				
				self:EmitSound("nz_moo/zombies/vox/_raz/_t10/cannon/prefire.mp3", 90)
				self:PlaySequenceAndMove(self.ShootSequences[math.random(#self.ShootSequences)], 1, self.FaceEnemy)
				
				self.UsingArmCannon = false
				self:StopParticles()
				self:SetSpecialAnimation(false)
			end)
		end
	end

	-- Random Enrage
	if CurTime() > self.RandomEnrage and !self.Enraged and math.random(100) <= 25 then
		self.NextShoot = CurTime() + math.random(5,9)
		self:DoSpecialAnimation("nz_base_zmb_raz_enrage")
	end

	-- Radio Sounds
	if CurTime() > self.RadioSoundTime then
		local snd = self.RadioSounds[math.random(#self.RadioSounds)]
		local dur = SoundDuration(snd)

		self:EmitSound(snd, 55, math.random(95, 105))

		self.RadioSoundTime = CurTime() + dur + math.random(5)
	end

	-- Stim Inspect
	if CurTime() > self.CannonInspect and self.ArmCannon and !self:HasTarget() then
		self:EmitSound("nz_moo/zombies/vox/_raz/_t9/flourish_cannon.mp3",75)
		self:DoSpecialAnimation("nz_base_zmb_raz_idle_twitch_check")
		self.CannonInspect = CurTime() + math.random(8,15)
	end

	-- Random Blood Gush
	if math.random(10) <= 3 and !self.ArmCannon then
		self:EmitSound(self.BloodSounds[math.random(#self.BloodSounds)],75,math.random(95, 105))
		ParticleEffectAttach("ins_blood_impact_generic", 4, self, 6)
	end
end

function ENT:PerformDeath(dmginfo)
		
	self.Dying = true

	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:Explode(25)

	ParticleEffectAttach("bo3_explosion_micro", PATTACH_POINT_FOLLOW, self, 9)

	if damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo) -- Only Thundergun and Wavegun Ragdolls constantly.
	end
	if damagetype == DMG_REMOVENORAGDOLL then
		self:Remove(dmginfo)
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:Explode(dmg)
    dmg = dmg or 50

    if SERVER then
        local pos = self:WorldSpaceCenter()
        local targ = self:GetTarget()

        local attacker = self
        local inflictor = self

       	if IsValid(targ) and targ.GetActiveWeapon then
            attacker = targ
            if IsValid(targ:GetActiveWeapon()) then
                inflictor = targ:GetActiveWeapon()
            end
        end

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }

        for k, v in pairs(ents.FindInSphere(pos, 200)) do
            if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
                if v:GetClass() == self:GetClass() then continue end
                if v == self then continue end
                if v:EntIndex() == self:EntIndex() then continue end
                if v:Health() <= 0 then continue end
                --if !v:Alive() then continue end
                tr.endpos = v:WorldSpaceCenter()
                local tr1 = util_traceline(tr)
                if tr1.HitWorld then continue end

                local expdamage = DamageInfo()
                expdamage:SetAttacker(attacker)
                expdamage:SetInflictor(inflictor)
                expdamage:SetDamageType(DMG_BLAST)

                local distfac = pos:Distance(v:WorldSpaceCenter())
                distfac = 1 - math.Clamp((distfac/200), 0, 1)
                expdamage:SetDamage(dmg * distfac)

                expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

                v:TakeDamageInfo(expdamage)
            end
        end

        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())

        util.Effect("HelicopterMegaBomb", effectdata)
        util.Effect("Explosion", effectdata)

        self:EmitSound(self.DeathExploSounds[math.random(#self.DeathExploSounds)],70)
        self:EmitSound(self.DeathSWTSounds[math.random(#self.DeathSWTSounds)],SNDLVL_180dB,math.random(95, 105))

        util.ScreenShake(self:GetPos(), 20, 255, 1.5, 400)
    end
end

function ENT:PostTookDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
	local hitforce = dmginfo:GetDamageForce()

	local damage = dmginfo:GetDamage()

	local armpos = self:GetBonePosition(self:LookupBone("j_elbow_ri"))
	local headpos = self:GetBonePosition(self:LookupBone("j_head"))
	local chestpos = self:GetBonePosition(self:LookupBone("j_spine4"))

	-- Using the same type of armor code as the Heavy Zombie.
	if (hitpos:DistToSqr(headpos) < 13^2) then
		if self.Helmet then
			if self.HelmetHP > 0 then
				self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
				ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 10)

				self.HelmetHP = self.HelmetHP - damage

				dmginfo:ScaleDamage(0.015)
			else
				self.Helmet = false
				self:SetBodygroup(2,1)

				self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
				self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)	
				attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)

				attacker:GivePoints(50)

				ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 10)

				if !self:GetSpecialAnimation() then
					self:DoSpecialAnimation("nz_base_zmb_raz_pain_facemask")
				end
			end
		end
	elseif (hitpos:DistToSqr(chestpos) < 13^2) then
		if self.Chest then
			if self.ChestHP > 0 then
				self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
				ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 9)

				self.ChestHP = self.ChestHP - damage

				dmginfo:ScaleDamage(0.015)
			else
				self.Chest = false
				self:SetBodygroup(3,1)

				self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
				self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)	
				attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)

				attacker:GivePoints(50)

				ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 9)

				if !self:GetSpecialAnimation() then
					self:DoSpecialAnimation("nz_base_zmb_raz_pain_chest_armor")
				end
			end
		end
	elseif (hitpos:DistToSqr(armpos) < 16^2) then
		if self.ArmCannon and self.UsingArmCannon then
			self:StopParticles()
			self.UsingArmCannon = false

			if self.ArmCannonHP > 0 then
				self.ArmCannonHP = self.ArmCannonHP - damage
				--print(self.ArmCannonHP)

        		attacker:EmitSound(self.CannonInterruptSounds[math.random(#self.CannonInterruptSounds)],SNDLVL_TALKING,math.random(95,105))
				self:DoSpecialAnimation("nz_base_zmb_raz_attack_shoot_01_pain")
			else
				self.ArmCannon = false
				self:DoSpecialAnimation("nz_base_zmb_raz_attack_shoot_01_pain_gib")
			end
		end
		dmginfo:ScaleDamage(0.25)
	else
		dmginfo:ScaleDamage(0.15)
	end
end

function ENT:OnGameOver()
	if !self.yousuck then
		self.yousuck = true
		self:DoSpecialAnimation("nz_base_zmb_raz_com_summon")
	end
end

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:CustomAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large

	if e == "step_right_small" or e == "step_left_small" or e == "step_right_large" or e == "step_left_large" then
		util.ScreenShake(self:GetPos(),1,1,0.2,450)
		self:EmitSound(self.WalkFootstepsSounds[math.random(#self.WalkFootstepsSounds)], 70)
		self:EmitSound(self.WalkFootstepsGearSounds[math.random(#self.WalkFootstepsGearSounds)], 65)
	end
	if e == "raz_melee_whoosh" then
		self:EmitSound(self.MeleeWhooshSounds[math.random(#self.MeleeWhooshSounds)], 80)
		self:EmitSound(self.MeleeWhooshSWTSounds[math.random(#self.MeleeWhooshSWTSounds)], 80)
	end

	if e == "raz_charge" then
		self:EmitSound("nz_moo/zombies/vox/_raz/_t10/cannon/charge.mp3", 90)
		self:EmitSound("nz_moo/zombies/vox/_raz/_t10/cannon/charge_swt.mp3", 90)
		ParticleEffectAttach("hcea_hunter_ab_charge", PATTACH_POINT_FOLLOW, self, 13)
	end
	if e == "raz_shoot" then
		self:StopParticles()
		self:EmitSound(self.ArmCannonShootSounds[math.random(#self.ArmCannonShootSounds)], 90)
		ParticleEffectAttach("hcea_hunter_ab_muzzle", PATTACH_POINT_FOLLOW, self, 13)

		self:Retarget()

		local rarmfx_tag = self:GetBonePosition(self:LookupBone("j_weapon_spin"))
		local target = self:GetTarget()

		if IsValid(target) then
			self.ZapShot = ents.Create("nz_proj_mangler_shot_cw")
			self.ZapShot:SetPos(rarmfx_tag)
			self.ZapShot:SetAngles((target:GetPos() - self:GetPos()):Angle())
			self.ZapShot:Spawn()
			self.ZapShot:SetVictim(target)
		end

		if self.Enraged then 
			self.RandomEnrage = CurTime() + math.random(7,18)
		end

		self.Enraged = false
		self:SetRunSpeed(1)
		self:SpeedChanged()
	end

	if e == "raz_mangler_explode" then
		self.NextSound = CurTime() + self.SoundDelayMax
		self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
        self:EmitSound(self.CannonInterruptSounds[math.random(#self.CannonInterruptSounds)],100,math.random(95,105))
        self:EmitSound(self.DeathExploSounds[math.random(#self.DeathExploSounds)],100,math.random(95,105))
		ParticleEffectAttach("bo3_explosion_micro", PATTACH_POINT_FOLLOW, self, 13)
	end

	if e == "raz_mangler_gib" then
		self.NextSound = CurTime() + self.SoundDelayMax
		self:SetBodygroup(1,1)
		self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
		self:EmitSound(self.MeleeWhooshSounds[math.random(#self.MeleeWhooshSounds)], 80)
		self:EmitSound(self.MeleeWhooshSWTSounds[math.random(#self.MeleeWhooshSWTSounds)], 80)
		self:EmitSound(self.BloodSounds[math.random(#self.BloodSounds)],75,math.random(95, 105))
		self:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(3)..".mp3",100)
		ParticleEffectAttach("ins_blood_dismember_limb", 4, self, 6)
	end

	if e == "raz_enrage" then
		self.NextSound = CurTime() + self.SoundDelayMax
		self:EmitSound(self.EnrageSounds[math.random(#self.EnrageSounds)], 100, math.random(85, 105), 1, 2)
		self:SetRunSpeed(71)
		self:SpeedChanged()

		self.Enraged = true
	end

	if e == "raz_portal_spawn" then
		self:EmitSound("nz_moo/zombies/vox/_raz/_t9/spawn_appear.mp3",85)
	end

	if e == "raz_taunt" then
		self.NextSound = CurTime() + self.SoundDelayMax
		self:EmitSound(self.MangleTauntSounds[math.random(#self.MangleTauntSounds)], 100, math.random(85, 105), 1, 2)
	end

	if e == "raz_idle_click" then
		ParticleEffectAttach("doom_mancu_blast", PATTACH_POINT_FOLLOW, self, 13)
	end
end
