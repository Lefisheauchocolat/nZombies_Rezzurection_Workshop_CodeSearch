AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "The Mangle... er"
ENT.PrintName = "Mangler"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

if CLIENT then
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")
	--local eyeglow = Material("nz_moo/sprites/hud_particle_glow_04")

	local defaultColor = Color(255, 75, 0, 255)

	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t8_zombies/common/mtl_c_t8_zmb_eyes.vmt"),
	}

	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()
		self:DrawEyeGlow()

		if self.EyeColorTable then
			-- Go through every material given and set the color.
			local eyecolor = nzMapping.Settings.zombieeyecolor
			local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()

			for k,v in pairs(self.EyeColorTable) do
				v:SetVector("$emissiveblendtint", col)
			end
		end
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end
	function ENT:DrawEyeGlow()
		local eyeColor = nzMapping.Settings.zombieeyecolor
		local nocolor = Color(0,0,0)

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


		if self.EyeColorTable then
			-- Go through every material given and set the color.
			local eyecolor = nzMapping.Settings.zombieeyecolor
			local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()

			for k,v in pairs(self.EyeColorTable) do
				v:SetVector("$emissiveblendtint", col)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

local util_traceline = util.TraceLine
local util_tracehull = util.TraceHull

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true
ENT.IsMiniBoss = true

ENT.AttackRange = 95
ENT.DamageRange = 95

ENT.AttackDamage = 75
ENT.HeavyAttackDamage = 115

ENT.MinSoundPitch = 95
ENT.MaxSoundPitch = 105

ENT.SoundDelayMin = 7
ENT.SoundDelayMax = 12

ENT.Models = {
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_raz_mangler.mdl", Skin = 0, Bodygroups = {0,0}},
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
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/amb_13.mp3"),
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

ENT.SparkySequences = {
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
			PatrolMovementSequence = {
				"nz_base_zmb_raz_unaware_walk",
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
			PatrolMovementSequence = {
				"nz_base_zmb_raz_unaware_walk",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.EnrageSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/rage/rage_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/rage/rage_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/rage/rage_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/rage/rage_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/rage/rage_04.mp3"),
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
	Sound("nz_moo/zombies/vox/_raz/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/step/step_02.mp3"),
}

ENT.WalkFootstepsGearSounds = {
	Sound("nz_moo/zombies/vox/_raz/gear/gear_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_05.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_06.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_07.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_08.mp3"),
	Sound("nz_moo/zombies/vox/_raz/gear/gear_09.mp3"),
}

ENT.ArmCannonShootSounds = {
	Sound("nz_moo/zombies/vox/_raz/mangler/shot/fire_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/mangler/shot/fire_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/mangler/shot/fire_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/mangler/shot/fire_03.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/pain/pain_09.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/death/death_03.mp3"),
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

ENT.CannonInterruptSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/mangler/raz_charge_interrupt_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/mangler/raz_charge_interrupt_01.mp3"),
}

ENT.ManglerLinesSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/I_will_destroy.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/bleed_break_burn.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/death_will_come.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/eliminate_all_threats.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/enemy_will_be_crushed.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/exterminate_all_enemies.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/find_them_kill_all.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/will_not_be_destroyed.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/find_them_kill_all.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/you_are_weak_creatures.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/your_land_will_be_our_land.mp3"),
}

ENT.MangleTauntSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/feast_minions.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/lines/bleed_them_dry.mp3"),
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

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_09.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_10.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_11.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_12.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_13.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_14.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_15.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_16.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_17.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_18.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_19.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_20.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_21.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_22.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_23.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_24.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_25.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_26.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_27.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_28.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_29.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_30.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_31.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_32.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_33.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_34.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_35.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_36.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_37.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_38.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_39.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_40.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_41.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_42.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_43.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/attack/attack_44.mp3"),
}

ENT.MumbleSounds = {
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_00.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_01.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_02.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_03.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_04.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_05.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_06.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_07.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_08.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_09.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_10.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_11.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_12.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_13.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_14.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_15.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_16.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_17.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_18.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_19.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_20.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_21.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_22.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_23.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_24.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_25.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_26.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_27.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_28.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_29.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_30.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_31.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_32.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_33.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_34.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_35.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_36.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_37.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_38.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_39.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_40.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_41.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_42.mp3"),
	Sound("nz_moo/zombies/vox/_raz/_t9/voxt9/amb/mumble/mumble_43.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_01.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_02.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_03.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_04.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_05.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_06.mp3"),
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
			self:SetHealth(2500)
			self:SetMaxHealth(2500)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 950 + (500 * count), 1000, 55000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 950 + (500 * count), 1000, 55000 * count))
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
		self.HelmetHP = self:GetMaxHealth() * 0.25

		self.Chest = true
		self.ChestHP = self:GetMaxHealth() * 0.25

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
	-- If you win the lottery, you get a space chicken instead.
	local comedyday = os.date("%d-%m") == "01-04"
	if math.random(10000) == 1 or comedyday then
		self.RISE = ents.Create("nz_zombie_boss_gigan")
		self.RISE:SetPos(self:GetPos())
		self.RISE:SetAngles(self:GetAngles())
		self.RISE:Spawn()
		self:Remove()
	end

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

function ENT:AI()
	if CurTime() > self.NextShoot and self.ArmCannon and self:IsOnGround() and IsValid(self.Target) then
		if !self:IsAttackBlocked() and self:TargetInRange(750) and !self:TargetInRange(150) and self:IsFacingEnt(self.Target) then
			self:TempBehaveThread(function(self)
				self.NextShoot = CurTime() + math.random(3,9)

				self:SetSpecialAnimation(true)

				self.UsingArmCannon = true
				self:PlaySequenceAndMove(self.ShootSequences[math.random(#self.ShootSequences)], 1, self.FaceEnemy)
				
				self.UsingArmCannon = false
				self:StopParticles()
				self:SetSpecialAnimation(false)
			end)
		end
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

function ENT:Sound()
	if self:GetAttacking() or !self:Alive() or self:GetDecapitated() then return end

	local vol = self.SoundVolume

	local chance = math.random(100)

	for k,v in nzLevel.GetZombieArray() do -- FUCK YOU, ARRAYS ARE AWESOME!!!
		if k < 2 then vol = 511 else vol = self.SoundVolume end
	end

	if !self:HasTarget() then
		self:PlaySound(self.MumbleSounds[math.random(#self.MumbleSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	elseif chance < 25 then
		self:PlaySound(self.ManglerLinesSounds[math.random(#self.ManglerLinesSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	elseif self.PassiveSounds then
		self:PlaySound(self.PassiveSounds[math.random(#self.PassiveSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	else

		-- We still delay by max sound delay even if there was no sound to play
		self.NextSound = CurTime() + self.SoundDelayMax
	end
end

function ENT:PerformDeath(dmginfo)
		
	self.Dying = true

	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)

	self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
	self:Explode(25)

	self:ManipulateBoneScale(self:LookupBone("j_head_attach"), Vector(0.00001,0.00001,0.00001))
	self:ManipulateBoneScale(self:LookupBone("j_spine4_attach"), Vector(0.00001,0.00001,0.00001))
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

        self:EmitSound(self.DeathExploSounds[math.random(#self.DeathExploSounds)],85)
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

				self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
				self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)	
				attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)

				self:ManipulateBoneScale(self:LookupBone("j_head_attach"), Vector(0.00001,0.00001,0.00001))
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

				self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
				self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)	
				attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)

				self:ManipulateBoneScale(self:LookupBone("j_spine4_attach"), Vector(0.00001,0.00001,0.00001))
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
		self:EmitSound("nz_moo/zombies/vox/_raz/_t9/mangler/raz_charge_oneshot.mp3", 90)
		ParticleEffectAttach("bo3_mangler_charge", PATTACH_POINT_FOLLOW, self, 13)
	end
	if e == "raz_shoot" then
		self:StopParticles()
		self:EmitSound(self.ArmCannonShootSounds[math.random(#self.ArmCannonShootSounds)], 90)
		ParticleEffectAttach("bo3_mangler_blast", PATTACH_POINT_FOLLOW, self, 13)

		self:Retarget()

		local rarmfx_tag = self:GetBonePosition(self:LookupBone("j_weapon_spin"))
		local target = self:GetTarget()

		if IsValid(target) then
			self.ZapShot = ents.Create("nz_proj_mangler_shot_bo3")
			self.ZapShot:SetPos(rarmfx_tag)
			self.ZapShot:Spawn()
			self.ZapShot:Launch(((target:EyePos() - Vector(0,0,7) + target:GetVelocity() * math.Clamp(target:GetVelocity():Length2D(),0,0.5)) - self.ZapShot:GetPos()):GetNormalized())
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
