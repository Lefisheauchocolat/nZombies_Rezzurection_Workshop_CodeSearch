AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.PrintName = "Mimic"
ENT.Spawnable = true

function ENT:InitDataTables()
	self:NetworkVar("Bool", 6, "UsingGrab")
	self:NetworkVar("Entity", 6, "CurrentPlayer")
	self:NetworkVar("Entity", 7, "Mimic")
	self:NetworkVar("Bool", 8, "IsHidden")
end

if CLIENT then

	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t10_zombies/jup/mimic/xmaterial_8609a04b7a0ac9f.vmt"),
		[1] = Material("models/moo/codz/t10_zombies/jup/mimic/xmaterial_bc747d1cdacd55a.vmt"),
	}

	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()

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
	function ENT:PostDraw()
		if self:Alive() and !self:GetIsHidden() then
			if !IsValid(self) then return end
			self:SetMaterial("")
			local color = nzMapping.Settings.zombieeyecolor
			if (!self.Draw_FX or !IsValid(self.Draw_FX)) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 12)
				self.Draw_FX:SetControlPoint(2, Vector(color.r/255, color.g/255, color.b/255)) -- Color
			end
			if (!self.Draw_SFX or !IsValid(self.Draw_SFX)) then
				self.Draw_SFX = "nz_moo/zombies/vox/_mimic/_t10/xsound_6bd46bbceff897b.wav"

				self:EmitSound(self.Draw_SFX, 65, math.random(95, 105), 1, 3)
			end
		
		else
			self:SetMaterial("null")
			if self.Draw_FX or IsValid(self.Draw_FX) then
				self.Draw_FX:StopEmission(false, true)
				self.Draw_FX = nil
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true
ENT.IsMiniBoss = true

ENT.SoundDelayMin = 3
ENT.SoundDelayMax = 8

ENT.AttackRange 			= 115
ENT.DamageRange 			= 115
ENT.AttackDamage 			= 50
ENT.HeavyAttackDamage 		= 75

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_mimic.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_mimic.mdl", Skin = 1, Bodygroups = {0,0}},
}

local spawnslow = {"nz_ai_mimic_arrive_02"}
local spawnfast = {"nz_ai_mimic_arrive_01"}

ENT.DeathSequences = {
	"nz_ai_mimic_death_01",
}

ENT.BarricadeTearSequences = {
	"nz_ai_mimic_stand_attack_01",
	"nz_ai_mimic_stand_attack_02",
	"nz_ai_mimic_stand_attack_03",
	"nz_ai_mimic_stand_attack_04",
	"nz_ai_mimic_stand_attack_05",
}

local AttackSequences = {
	{seq = "nz_ai_mimic_stand_attack_01"},
	{seq = "nz_ai_mimic_stand_attack_02"},
	{seq = "nz_ai_mimic_stand_attack_03"},
	{seq = "nz_ai_mimic_stand_attack_04"},
	{seq = "nz_ai_mimic_stand_attack_05"},
}

local WalkAttackSequences = {
	{seq = "nz_ai_mimic_walk_attack_01"},
}

local RunAttackSequences = {
	{seq = "nz_ai_mimic_run_attack_01"},
	{seq = "nz_ai_mimic_run_attack_02"},
	{seq = "nz_ai_mimic_run_attack_03"},
	{seq = "nz_ai_mimic_run_attack_04"},
}

local JumpSequences = {
	{seq = "nz_ai_mimic_run_mantle_36"},
}
local ambsounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_1/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_1/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_1/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_1/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_1/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_1/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_1/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_1/amb_07.mp3"),

	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_2/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_2/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_2/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_2/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_2/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_2/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/amb/series_2/amb_06.mp3"),
}

ENT.IdleSequence = "nz_ai_mimic_idle_01"
ENT.IdleSequenceAU = "nz_ai_mimic_idle_01"
ENT.NoTargetIdle = "nz_ai_mimic_idle_01"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_ai_mimic_walk_01",
				"nz_ai_mimic_walk_02",
			},
			
			StandAttackSequences = {AttackSequences},
			AttackSequences = {WalkAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {ambsounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_ai_mimic_run_01",
				"nz_ai_mimic_run_02",
			},
			
			StandAttackSequences = {AttackSequences},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {ambsounds},
		},
	}},
}

ENT.CustomMantleOver48 = {
	"nz_ai_mimic_run_mantle_48",
}

ENT.CustomMantleOver72 = {
	"nz_ai_mimic_run_mantle_72",
}

ENT.CustomMantleOver96 = {
	"nz_ai_mimic_run_mantle_128",
}

ENT.CustomMantleOver128 = {
	"nz_ai_mimic_run_mantle_128",
}

ENT.ZombieLandSequences = {
	"nz_ai_mimic_jump_land",
}

ENT.CommandGrabSequences = {
	"nz_ai_mimic_command_grab_success_01",
	--"nz_ai_mimic_command_grab_success_02",
}

ENT.RangedAttackSequences = {
	"nz_ai_mimic_ranged_attack_01",
	"nz_ai_mimic_ranged_attack_02",
}

ENT.HiddenSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_04.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_05.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_06.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_07.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_08.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_09.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_10.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_11.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_12.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_13.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_14.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_15.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_16.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_17.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_18.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_19.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_20.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_21.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_22.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_23.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_24.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_25.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_26.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_27.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_28.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/hidden/hidden_29.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/death/death_03.mp3"),
}

ENT.ScreamSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/gp_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_pull/funni_scream_00.mp3"),
	Sound("npc/stalker/go_alert2a.wav"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/attack/attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/attack/attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/attack/attack_05.mp3"),
}

ENT.HeavyAttackImpactSounds = {
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/bite_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/funni_bite_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/funni_bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/bite/funni_bite_02.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_01.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_02.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_03.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_04.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_05.mp3"),
	Sound("nz_moo/zombies/plr_impact/_s4/zmb_swiped_plr_06.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_1d9281c1371e06d.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_1e9ad61ed086937.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_34919d990b29e7b.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_766d864990abc49.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_a8e18fe0ef9bab8.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_d06eb2a0d9bc56.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_e2955856d0f3f52.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_e5a527272b8fec4.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/react/xsound_e63c67a4936325e.mp3"),
}

ENT.FootStepSounds = {
	Sound("nz_moo/zombies/vox/_mimic/steps/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/steps/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/steps/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/steps/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/steps/step_04.mp3"),
}

ENT.RevealSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/reveal/reveal_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/reveal/reveal_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/reveal/reveal_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/reveal/reveal_03.mp3"),
}

ENT.GrabSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_start/gs_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_start/gs_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_start/gs_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_start/gs_03.mp3"),
}

ENT.TentWhooshSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_tent/gt_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_tent/gt_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_tent/gt_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/grab_tent/gt_03.mp3"),
}

ENT.LandSounds = {
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_dirt_01.mp3"),
	Sound("nz_moo/zombies/vox/_aliens/foley/land/alien_land_dirt_02.mp3"),
}

ENT.ExplodeSounds = {
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_02.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

ENT.BehindSoundDistance = 250 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_mimic/_t10/behind/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/behind/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/behind/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/_t10/behind/behind_03.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		
		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(2250)
			self:SetMaxHealth(2250)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 150 + (250 * count), 1000, 60000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 150 + (250 * count), 1000, 60000 * count))
			else
				self:SetHealth(2250)
				self:SetMaxHealth(2250)	
			end
		end

		self:SetRunSpeed( 100 )
		self:SetBodygroup(1,0)

		self:SetSurroundingBounds(Vector(-84, -84, 0), Vector(84, 84, 115))
		self:SetCollisionBounds(Vector(-12,-12, 0), Vector(12, 12, 72))

		self:SetMimic(self)
		self:SetIsHidden(false)

		self.SpitCooldown = CurTime() + 1
		self.GrabCooldown = CurTime() + 5
		self.HideCooldown = CurTime() + 1
		self.HidePlyDistTick = CurTime() + 1
		self.TimeToBeHidden = CurTime() + 1

		self.Hiding = false
		self.SelectedHideType = false
		self.Hidden = false
		self.HideReveal = false

		self:SetUsingGrab(false)
		self:SetCurrentPlayer(nil)

		self.GrabHitboxTick = CurTime() + 0.15
		self.GrabHitboxActive = false
		self.GrabbedPlayer = false
		self.ReleasePlayer = false
		self.SaveGrabbedPlyPos = nil
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	if math.random(100) < 25 then
		self.Hiding = true

		self:SetStop(true)
		self:SetIsBusy(true)
		--self:DoSpecialAnimation("nz_ai_mimic_trans_prop")

		self.Hidden = true
		self:SetIsHidden(true)
		self:SpawnFalseDrop()

		self.TimeToBeHidden = CurTime() + 60

		ParticleEffect("zmb_mimic_hide", self:GetPos(), Angle(0,0,0), self)
		self:EmitSound("nz_moo/zombies/vox/_mimic/evt/transform.mp3", 100, math.random(95,105))
	else
		local effectData = EffectData()
		effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
		effectData:SetMagnitude( 1 )
		effectData:SetEntity(nil)
		util.Effect("panzer_spawn_tp", effectData)

		self:EmitSound("nz_moo/zombies/vox/_mimic/evt/spawn.mp3", 511, math.random(95,105))

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
end

-- Instead of making a copy of the function above, use this.
function ENT:CustomAnimEvent(a,b,c,d,e) 
	
	self.OverrideLsmall = true
	self.OverrideLLarge = true
	self.OverrideRsmall = true
	self.OverrideRLarge = true

	if e == "step_left_small" then
		self:EmitSound(self.HandStepSounds[math.random(#self.HandStepSounds)], 75)
	end
	if e == "step_right_small" then
		self:EmitSound(self.HandStepSounds[math.random(#self.HandStepSounds)], 75)
	end
	if e == "step_left_large" then
		self:EmitSound(self.FootStepSounds[math.random(#self.FootStepSounds)], 75)
	end
	if e == "step_right_large" then
		self:EmitSound(self.FootStepSounds[math.random(#self.FootStepSounds)], 75)
	end

	if e == "mimic_explode" then
		if IsValid(self) then
			self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 

			self:Remove()
		end
	end

	if e == "mimic_grapple_vox" then
		self:EmitSound(self.GrabSounds[math.random(#self.GrabSounds)], 85,math.random(95,105))
	end

	if e == "mimic_grapple_whoosh" then
		self:EmitSound(self.TentWhooshSounds[math.random(#self.TentWhooshSounds)], 85, math.random(95,105))
	end

	if e == "mimic_ranged_attack" then
		local tag = self:GetAttachment(self:LookupAttachment("jaw_fx_tag"))

		local target = self:GetTarget()
		if IsValid(target) then
			self.Spit = ents.Create("nz_proj_mimic_spit")
			self.Spit:SetPos(tag.Pos)
			self.Spit:Spawn()

        	ParticleEffect("bo3_mangler_blast_glow", tag.Pos, Angle(0, 0, 0), nil)

			local phys = self.Spit:GetPhysicsObject()
			if IsValid(phys) then
			 	phys:SetVelocity(self.Spit:getvel(target:GetPos() + target:GetVelocity() * math.Clamp(target:GetVelocity():Length2D(),0,1.2), self:EyePos(), 0.75))
			 end
		end
	end

	if e == "mimic_transform_into_prop" then
		self.Hidden = true
		self:SetIsHidden(true)
		self:SpawnFalseDrop()

		self.TimeToBeHidden = CurTime() + 60

		ParticleEffect("zmb_mimic_hide", self:GetPos(), Angle(0,0,0), self)
		self:EmitSound("nz_moo/zombies/vox/_mimic/evt/transform.mp3", 100, math.random(95,105))
	end

	if e == "mimic_fool_tell" then
		ParticleEffect("zmb_mimic_trans", self:GetPos(), Angle(0,0,0), self)
		self:EmitSound("nz_moo/zombies/vox/_mimic/evt/transform.mp3", 100, math.random(95,105))
		self:EmitSound("nz_moo/zombies/vox/_mimic/evt/reveal.mp3", 100, math.random(95,105))
	end

	if e == "mimic_fool_show" then
		self.Hidden = false
		self.Hiding = false
		self.HideReveal = false

		self:SetIsHidden(false)

		self:EmitSound(self.RevealSounds[math.random(#self.RevealSounds)], 100, math.random(95,105))
	end

	if e == "mimic_scream" then
		local ply = self:GetCurrentPlayer()
		ply:EmitSound(self.ScreamSounds[math.random(#self.ScreamSounds)],90,math.random(95,105))
	end

	if e == "mimic_grapple_hitbox_enable" then
		self.GrabHitboxActive = true
	end
	if e == "mimic_grapple_hitbox_disable" then
		self.GrabHitboxActive = false
	end

	if e == "mimic_grapple_release_player" then
		self.ReleasePlayer = true
	end
end

function ENT:AI()
	local target = self:GetTarget()

	if !self.Hiding then
		-- Command Grab(Grab Attack)
		if IsValid(target) and target:IsPlayer() and !self:IsAttackBlocked() and self:TargetInRange(215) then
			if CurTime() > self.GrabCooldown then
				self:AttemptGrab()
			end
		end

		-- Spit(Ranged Attack)
		if IsValid(target) and !self:IsAttackBlocked() and !self:TargetInRange(200) and self:TargetInRange(750) then
			if CurTime() > self.SpitCooldown then
				self.SpitCooldown = CurTime() + math.Rand(6.25, 10.5)
				self:DoSpecialAnimation(self.RangedAttackSequences[math.random(#self.RangedAttackSequences)])
			end
		end

		-- Hiding/Comedy(THE MIMIC)
		if IsValid(target) and target:IsPlayer()and !self.Hiding and self:IsAttackBlocked() and !self:TargetInRange(295) then
			if CurTime() > self.HideCooldown and math.random(25) < 25 then

				local nav = navmesh.GetNearestNavArea(self:GetPos(), false, 500, false, true, -2)
				local hidingspots
				local spot
				if IsValid(nav) then
					hidingspots = nav:GetHidingSpots(1)
					spot = hidingspots[math.random(#hidingspots)]
				end

				if isvector(spot) then

					self:MoveToPos(spot, 
					{
						lookahead = 1,
						tolerance = 10,
						draw = false,
						maxage = 3,
						repath = 3,
					})
					self.Hiding = true

					self:SetStop(true)
					self:SetIsBusy(true)
					self:DoSpecialAnimation("nz_ai_mimic_trans_prop")
				end
			end
		end

		--[[if !self:GetIsHidden() then

			self.Hiding = true
			self:SetIsHidden(true)
			ParticleEffect("zmb_mimic_hide", self:GetPos(), Angle(0,0,0), self)
			self:EmitSound("nz_moo/zombies/vox/_mimic/evt/transform.mp3", 100, math.random(95,105))

			self.FalseDrop = ents.Create("nz_prop_effect_attachment")
			self.FalseDrop:SetPos(self:GetPos())
			self.FalseDrop:SetAngles(self:GetAngles())
			self.FalseDrop:SetParent(self,1)
			self.FalseDrop:SetModel("models/player/odessa.mdl")
			self.FalseDrop:Spawn()

			self:DeleteOnRemove(self.FalseDrop)
		end]]
	end
end

function ENT:SpawnFalseDrop()
	self.FalseDrop = ents.Create("nz_ent_mimic_fake_pow")
	self.FalseDrop:SetPos(self:GetPos() + Vector(0,0,50))
	self.FalseDrop:SetParent(self)
	self.FalseDrop:Spawn()
end

function ENT:OnThink()
	local ply = self:GetCurrentPlayer()
	
	if !self:GetStop() and !self.Hiding then
		if IsValid(ply) and ply:Alive() and !self.ReleasePlayer then

			-- Save the grabbed player's position before they start getting moved.
			if !isvector(self.SaveGrabbedPlyPos) then self.SaveGrabbedPlyPos = ply:GetPos() end

			ply:NZMimicGrab(0.5, ply)
		elseif IsValid(ply) and self.ReleasePlayer then
			ply:SetParent(nil)
			self.GrabbedPlayer = false
			self:SetCurrentPlayer(nil)
			ply.MimicParent = nil
		end

		if self:GetUsingGrab() and self.GrabHitboxActive and !self.GrabbedPlayer then
			if CurTime() > self.GrabHitboxTick then

				self.GrabHitboxTick = CurTime() + 0.35

				local bone = self:GetAttachment(self:LookupAttachment("player_attach")) -- lol... lmao even.
				pos = bone.Pos
				local mins = Vector(0, -20, -10)
				local maxs = Vector(200, 20, 52)
				local tr = util.TraceHull({
					start = pos,
					endpos = pos + bone.Ang:Forward()*500,
					filter = self,
					mask = MASK_PLAYERSOLID,
					collisiongroup = COLLISION_GROUP_INTERACTIVE_DEBRIS,
					ignoreworld = true,
					mins = mins,
					maxs = maxs,
				})
			
				debugoverlay.BoxAngles(pos, mins, maxs, bone.Ang, 1, Color( 255, 255, 255, 10))

				if self:IsValidTarget(tr.Entity) and !self:IsAttackBlocked() then
					if tr.Entity:IsPlayer() then
						local ply = tr.Entity
						self.GrabbedPlayer = true
						self:SetCurrentPlayer(ply)
						ply.MimicParent = self
						self.GrabHitboxActive = false
					end
				end
			end
		end
	end

	if self.Hidden then
		self:SetMaterial("null")
		if CurTime() > self.HidePlyDistTick then

			self.HidePlyDistTick = CurTime() + 0.95

			for k,v in nzLevel.GetTargetableArray() do
				if !IsValid(v) then continue end
				if IsValid(v) and v == self then continue end

				if (CurTime() > self.TimeToBeHidden or !IsValid(self.FalseDrop) or self:GetRangeTo( v:GetPos() ) < 175 and v:IsPlayer()) and !self.HideReveal then
					self:SetStop(false)
					self:SetIsBusy(false)
					self.HideReveal = true

					self.HideCooldown = CurTime() + math.Rand(7.5, 15.75)

					if IsValid(v) then
						self:FaceTowards(v:GetPos())
						if math.random(100) < 50 then
							self:DoSpecialAnimation("nz_ai_mimic_prop_emerge_2_stand")
						else
							if self:CanGrab() then
								self:AttemptGrab(true)
							else
								self:DoSpecialAnimation("nz_ai_mimic_prop_emerge_2_stand")
							end
						end
					else
						self:DoSpecialAnimation("nz_ai_mimic_prop_emerge_2_stand")
					end

					if IsValid(self.FalseDrop) then
						SafeRemoveEntity(self.FalseDrop)
					end
				end
			end
		end
	else
		self:SetMaterial("")
	end

	-- Just do this again just in case. So the mimic doesn't become a ghost...
	-- Because of this entity doesn't exist and GetStop is false, the mimic probably wants to chase people.
	if !IsValid(self.FalseDrop) and !self:GetStop() then
		self:SetMaterial("")
		self:SetStop(false)
		self:SetIsBusy(false)

		self.Hidden = false
		self.Hiding = false
		self:SetIsHidden(false)
	end
end

function ENT:AttemptGrab(revealed)
	local target = self:GetTarget()
	local seq = "nz_ai_mimic_command_grab_in_01"

	if !IsValid(target) then return end
	if !self:CanGrab() then return end

	if revealed then seq = "nz_ai_mimic_prop_emerge_2_grab" end

	self.GrabCooldown = CurTime() + math.random(6,12)
	self:SetUsingGrab(true)
	self.ReleasePlayer = false

	self:FaceTowards(target:GetPos())
	self:TempBehaveThread(function(self)
		self:SolidMaskDuringEvent(MASK_NPCSOLID_BRUSHONLY)
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndMove(seq, 1)

		if self.GrabbedPlayer then
			self:PlaySequenceAndMove(self.CommandGrabSequences[math.random(#self.CommandGrabSequences)], 1)
			self.GrabbedPlayer = false
		else
			self:PlaySequenceAndMove("nz_ai_mimic_command_grab_miss_01", 1)
		end

		self:SetUsingGrab(false)
		self:SetSpecialAnimation(false)
		self:CollideWhenPossible()

	end)
end

function ENT:CanGrab()
	local bone = self:GetAttachment(self:LookupAttachment("player_attach")) -- lol... lmao even.
	pos = bone.Pos
	local mins = Vector(0, -20, 20)
	local maxs = Vector(200, 20, 82)
	local tr = util.TraceHull({
		start = pos,
		endpos = pos + bone.Ang:Forward()*500,
		filter = self,
		mask = MASK_PLAYERSOLID,
		collisiongroup = COLLISION_GROUP_INTERACTIVE_DEBRIS,
		ignoreworld = false,
		mins = mins,
		maxs = maxs,
	})
			
	debugoverlay.BoxAngles(pos, mins, maxs, bone.Ang, 1, Color( 255, 255, 255, 10))


	if tr.HitWorld then
		return false 
	else
		return true
	end
end

function ENT:PerformDeath(dmgInfo)
	
	self.Dying = true

	if self:GetSpecialAnimation() then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 

			self:Remove()
		end
	else
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then
			self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
			ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 
			
			self:Remove()
		end
	end)
end

function ENT:OnTakeDamage(dmginfo) -- Added by Ethorbit for implementation of the ^^^
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local dmgtype = dmginfo:GetDamageType()

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
	local hitforce = dmginfo:GetDamageForce()

	local headpos = self:GetBonePosition(self:LookupBone("j_head"))

	if (self.SpawnProtection or self.Hidden or self.GrabbedPlayer) and !self.BeingNuked then
		dmginfo:ScaleDamage(0) -- Stop zombies from taking damage if they're being spawnprotected.
		return 				   -- A humble surprise is that this seems to stop Zero Health Zombies from appearing like 90% of the time. I'm being optimistic with the 90%.
	end

	if (hitpos:DistToSqr(headpos) < 20^2) then
		dmginfo:ScaleDamage(0.5)
	else
		dmginfo:ScaleDamage(0.1)
	end

	self:PostTookDamage(dmginfo)

	self:SetLastHurt(CurTime())
end


function ENT:Sound()
	if self:GetAttacking() or !self:Alive() or self:GetDecapitated() then return end

	local vol = self.SoundVolume

	for k,v in nzLevel.GetZombieArray() do -- FUCK YOU, ARRAYS ARE AWESOME!!!
		if k < 2 then vol = 511 else vol = self.SoundVolume end
	end

	if self.BehindSoundDistance > 0 -- We have enabled behind sounds
		and IsValid(self.Target)
		and self.Target:IsPlayer() -- We have a target and it's a player within distance
		and self:GetRangeTo(self.Target) <= self.BehindSoundDistance
		and (self.Target:GetPos() - self:GetPos()):GetNormalized():Dot(self.Target:GetAimVector()) >= 0 then -- If the direction towards the player is same 180 degree as the player's aim (away from the zombie)
			self:PlaySound(self.BehindSounds[math.random(#self.BehindSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2) -- Play the behind sound, and a bit louder!
	
	--[[ A big "if then" thingy for playing other sounds. ]]--
	elseif self.Hidden then
		self:PlaySound(self.HiddenSounds[math.random(#self.HiddenSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		self.NextSound = CurTime() + self.SoundDelayMax
	elseif self.PassiveSounds then
		self:PlaySound(self.PassiveSounds[math.random(#self.PassiveSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	else


		-- We still delay by max sound delay even if there was no sound to play
		self.NextSound = CurTime() + self.SoundDelayMax
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_mimic/_t10/xsound_6bd46bbceff897b.wav")
end