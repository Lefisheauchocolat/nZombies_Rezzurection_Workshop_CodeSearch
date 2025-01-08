AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Krasny Soldat"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:InitDataTables()
	self:NetworkVar("Bool", 6, "Helmet")
end

AccessorFunc( ENT, "fLastToast", "LastToast", FORCE_NUMBER)

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t8_zombies/common/mtl_c_t8_zmb_eyes.vmt"),
		[1] = Material("models/moo/codz/t8_zombies/common/mtl_c_t8_zmb_eyes_lod.vmt"),
	}

	function ENT:Draw()
		self:DrawModel()

		if self.RedEyes and self:Alive() and !self:GetDecapitated() then
			self:DrawEyeGlow() 
		end	

		if self:Alive() and self:GetHelmet() then
			self:DrawLight()
		end

		self:EffectsAndSounds()

		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end

	function ENT:DrawLight()
		local color = Color(255,255,255)

		local lighttag = self:LookupAttachment("tag_headlamp_fx")
		local light = self:GetAttachment(lighttag)
		local lightpos = light.Pos + light.Ang:Forward()*1

		render.DrawSprite(lightpos, 35, 35, color)
	end

	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !IsValid(self.Draw_FX)) and self:GetHelmet() then -- PVS will no longer eat the particle effect.
				self.Draw_FX = CreateParticleSystem(self, "doom_rev_missile_trail_smoke", PATTACH_POINT_FOLLOW, 2)
			end
			if (self.Draw_FX and IsValid(self.Draw_FX)) and !self:GetHelmet() then
				self.Draw_FX:StopEmission(false, true)
			end
		end
	end

	return 
end

local util_tracehull = util.TraceHull

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true

ENT.AttackRange = 115
ENT.DamageRange = 115

ENT.MinSoundPitch 			= 95
ENT.MaxSoundPitch 			= 105 

ENT.CanPanzerLift = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_pyro_mechz.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_soldat_arrive_fast"}

ENT.DeathSequences = {
	"nz_soldat_death_1",
	"nz_soldat_death_2"
}

local WalkAttackSequences = {
	{seq = "nz_soldat_run_melee", dmgtimes = {0.7}},
}

local AttackSequences = {
	{seq = "nz_soldat_melee_a"},
	{seq = "nz_soldat_melee_b"},
}

local JumpSequences = {
	{seq = "nz_soldat_mantle_36"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_16.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_17.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_18.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_19.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_20.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_21.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_22.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_23.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_24.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_25.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/amb/amb_26.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_04.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_05.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_07.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_08.mp3"),
}

ENT.IdleSequence = "nz_soldat_idle"
ENT.JetPackIdleSequence = "nz_soldat_hover_loop"
ENT.RunePrisonSequence = "nz_soldat_runeprison_struggle_loop"
ENT.TeslaSequence = "nz_soldat_tesla_loop"

ENT.ZombieStunInSequence = "nz_soldat_head_stun_intro"
ENT.ZombieStunOutSequence = "nz_soldat_head_stun_outro"

ENT.SparkySequences = {
	"nz_soldat_head_stun_loop",
	"nz_soldat_head_stun_loop",
	"nz_soldat_head_stun_loop",
	"nz_soldat_head_stun_loop",
	"nz_soldat_head_stun_loop",
}

ENT.BarricadeTearSequences = {
	"nz_soldat_melee_a",
	"nz_soldat_melee_b",
}

ENT.FatalSequences = {
	"nz_soldat_powercore_pain",
	"nz_soldat_pain_faceplate"
}

ENT.NormalMantleOver48 = {
	"nz_soldat_mantle_48",
}

ENT.NormalMantleOver72 = {
	"nz_soldat_mantle_72",
}

ENT.NormalMantleOver96 = {
	"nz_soldat_mantle_96",
}

ENT.NormalJumpUp128 = {
	"nz_soldat_jump_up_128",
}

ENT.NormalJumpUp128Quick = {
	"nz_soldat_jump_up_128",
}

ENT.NormalJumpDown128 = {
	"nz_soldat_jump_down_128",
}

ENT.ZombieLandSequences = {
	"nz_soldat_land",
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_soldat_walk_basic",
			},
			FastMovementSequence = {
				"nz_soldat_run",
			},
			FlameMovementSequence = {
				"nz_soldat_ft_run",
			},
			FlyMovementSequence = {
				"nz_soldat_launch_pad_move_loop",
			},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_soldat_run_pyro",
			},
			FastMovementSequence = {
				"nz_soldat_run",
			},
			FlameMovementSequence = {
				"nz_soldat_ft_run",
			},
			FlyMovementSequence = {
				"nz_soldat_launch_pad_move_loop",
			},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_soldat_sprint",
			},
			FastMovementSequence = {
				"nz_soldat_sprint",
			},
			FlameMovementSequence = {
				"nz_soldat_ft_run",
			},
			FlyMovementSequence = {
				"nz_soldat_launch_pad_move_loop",
			},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}}
}

ENT.RageSounds = {
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_04.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_05.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_07.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/rage/rage_08.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_09.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_10.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_11.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_12.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_13.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_14.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_15.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_16.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_17.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_18.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/attack/attack_19.mp3"),
}

ENT.PanicSounds = {
	Sound("nz_moo/zombies/vox/_pyromech/panic/panic_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/panic/panic_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/panic/panic_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/panic/panic_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/panic/panic_04.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_07.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_08.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_09.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_10.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_11.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_12.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_13.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_14.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_15.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_16.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_17.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_18.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_19.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_20.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_21.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_22.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_23.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_24.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/pain/pain_25.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_pyromech/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_04.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_05.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_07.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_08.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_09.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/death/death_10.mp3"),
}

ENT.RunFootstepSounds = {
	--Sound("nz_moo/zombies/vox/_pyromech/step/step_00.mp3"),
	--Sound("nz_moo/zombies/vox/_pyromech/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_02.mp3"),
	--Sound("nz_moo/zombies/vox/_pyromech/step/step_03.mp3"),
	--Sound("nz_moo/zombies/vox/_pyromech/step/step_04.mp3"),
	--Sound("nz_moo/zombies/vox/_pyromech/step/step_05.mp3"),
	--Sound("nz_moo/zombies/vox/_pyromech/step/step_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_07.mp3"),
}

ENT.MechLandSounds = {
	Sound("nz_moo/zombies/vox/_pyromech/land/land_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_04.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_05.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_07.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_08.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_09.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/land/land_10.mp3"),
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

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying() * 0.5

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(4300)
			self:SetMaxHealth(4300)
		else
			self:SetHealth(nzRound:GetNumber() * 950 + (1000 * count))
			self:SetMaxHealth(nzRound:GetNumber() * 950 + (1000 * count))
		end

		self.HelmetHP = self:GetMaxHealth() * 0.5

		self.HasPSupply = true
		self.PowerSupplyHP = self:GetMaxHealth() * 0.25

		self.SpawnProtection = true -- Zero Health Zombies tend to be created right as they spawn.
		self.SpawnProtectionTime = CurTime() + 5 -- So this is an experiment to see if negating any damage they take for a second will stop this.

		angering = false
		leftthetoasteron = false

		self.JetpackSnd = "nz_moo/zombies/vox/_mechz/rocket/loop.wav"

		-- It is a 100% known fact that bools control at least 90% of the world... This comment is now false.
		self.UsingFlamethrower = false
		self.DisallowFlamethrower = false
		self.StandingFlamethrower = false
		self:SetLastToast(CurTime())
		
		self.CanCancelAttack = true

		self.UsingFireBomb = false
		self.Enraged = false

		self.MoveFaster = false

		self.Lunging = false
		self.LungFail = false
		self.LungTime = CurTime() + 0.25
		self.LungCooldown = CurTime() + 5

		self.ResetCollision = false

		self.LastFireBomb = CurTime() + 3
		self:SetMooSpecial(true)
		self:SetHelmet(true)

		self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))
		self:SetSurroundingBounds(Vector(-45, -45, 0), Vector(45, 45, 100))
	
		self:SetRunSpeed( 36 )
	end
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetSpecialAnimation(true)

	self:EmitSound("nz_moo/zombies/vox/_pyromech/spawn.mp3",511)

	self:SetBodygroup(1,0)
	self:SetBodygroup(2,0)

	debugoverlay.BoxAngles(self:GetPos() + self:GetUp() * 75, Vector(-5,-5,0), Vector(5,5,750), self:GetAngles(), 3, Color( 255, 255, 255, 10))

	local tr = util.TraceHull({
		start = self:GetPos(),
		endpos = self:GetPos(),
		filter = self,
		mask = MASK_NPCSOLID,
		ignoreworld = false,
		mins = min,
		maxs = Vector(5,5,750),
	})

	if tr.Hit then 
		seq = "nz_soldat_arrive_tomb_short" 
		self.HitRoof = true
	end

	if self.HitRoof then
		local effectData = EffectData()
		effectData:SetOrigin( self:GetPos() + Vector(0, 0, 80)  )
		effectData:SetMagnitude( 5 )
		effectData:SetEntity(nil)
		util.Effect("panzer_spawn_tp", effectData) -- Express Portal to their destination.
	end

	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:CollideWhenPossible()
	end
end

function ENT:AI()
	local target = self:GetTarget()
	if IsValid(target) and target:IsPlayer() then

		if !self:Alive() or self:GetIsBusy() or self.PanzerDGLifted and self:PanzerDGLifted() then return end -- Not allowed to do anything.

		-- ENRAGE
		if angering and !self.Enraged then
			self.Enraged = true
			self:DoSpecialAnimation("nz_soldat_berserk_1")

			self:SetRunSpeed(71)
			self:SpeedChanged()
		end

		-- FLAMETHROWER
		if !self:GetSpecialAnimation() and !self:IsAttackBlocked() and self:TargetInRange(300) and !self:TargetInRange(self.AttackRange) then
			if self.Jetpacking then return end
			if self.UsingFireBomb then return end
			if self.DisallowFlamethrower then return end
			if angering and !self.Enraged then return end
			self:StartToasting()
			if !self:TargetInRange(150) and self:IsFacingTarget() then
				self.StandingFlamethrower = true
				self:DoSpecialAnimation("nz_soldat_flamethrower_stand_aim")
			else
				self.StandingFlamethrower = false
			end
		else
			self.StandingFlamethrower = false
			self:StopToasting()
		end

		-- JETPACK JOYRIDE(LUNGE)
		if CurTime() > self.LungCooldown and !self:TargetInRange(500) and !self.Lunging and !self:IsAttackBlocked() then
			if self:GetSpecialAnimation() then return end
			if self.Lunging then return end
			if angering and !self.Enraged then return end

			debugoverlay.BoxAngles(self:GetPos() + self:GetUp() * 75, Vector(-5,-5,0), Vector(100,5,175), self:GetAngles(), 3, Color( 255, 255, 255, 10))

			local target = self:GetTarget()

			if !IsValid(target) or !target:IsOnGround() then return end

			if self:IsMovingIntoObject() then return end
			
			local targetpos = target:GetPos()

			local min = Vector(-5,-5,0)
			local max = Vector(5,5,200)

			local tr = util.TraceHull({
				start = self:GetPos() + self:GetUp() * 75,
				endpos = self:GetPos() + self:GetForward()*100,
				filter = self,
				mask = MASK_NPCSOLID,
				ignoreworld = false,
				mins = min,
				maxs = Vector(200,5,200),
			})

			local tr2 = util.TraceHull({
				start = target:GetPos() + target:GetUp() * 75,
				endpos = target:GetPos(),
				filter = target,
				mask = MASK_NPCSOLID,
				ignoreworld = false,
				mins = min,
				maxs = max,
			})

			if !tr.Hit and !tr2.Hit then
				self:JetPackJump()
				self.LungFail = false
			else
				self.LungFail = true
			end
		end

		if self.LungFail and !self.Enraged then
			self.MoveFaster = true
		else
			self.MoveFaster = false
		end

		-- FIREBOMB
		if !self:IsAttackBlocked() and self:TargetInRange(1250) and !self:TargetInRange(400) then
			if CurTime() > self.LastFireBomb then
				if self:GetSpecialAnimation() then return end
				if self.Lunging then return end
				if self.UsingFlamethrower then return end

				self:TempBehaveThread(function(self)
					self.UsingFireBomb = true
					self:SetSpecialAnimation(true)
					self:PlaySequenceAndMove("nz_soldat_weapon_intro_to_aim", 1)
					for i = 1, 1 do 
						local pos = self:GetAttachment(self:LookupAttachment("tag_gun_spin")).Pos

						self.FireBomb = ents.Create("nz_glowstick_fire")
						self.FireBomb:SetPos(pos)
						self.FireBomb:Spawn()

						local phys = self.FireBomb:GetPhysicsObject()
						local target = self:GetTarget()
						if IsValid(phys) and IsValid(target) then
			 				phys:SetVelocity(self.FireBomb:getvel(target:GetPos() + target:GetVelocity() * math.Clamp(target:GetVelocity():Length2D(),0,1.2), self:EyePos(), 1.2))
						end

						self:EmitSound("weapons/ar2/ar2_reload_rotate.wav", 75, math.random(95,105))
						self:EmitSound("weapons/ar2/ar2_altfire.wav", 100, math.random(95,105))
						self:EmitSound("weapons/ar2/npc_ar2_altfire.wav", 85, math.random(95,105))

						ParticleEffectAttach("bo4_magmagat_muzzleflash",PATTACH_POINT,self,6)
						
						self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 95, math.random(95, 105))
						self:PlaySequenceAndMove("nz_soldat_weapon_fire", 1)
					end
					self.LastFireBomb = CurTime() + math.random(3,7)
					self.UsingFireBomb = false
					self:SetSpecialAnimation(false)
				end)
			end
		end

	end
end

function ENT:OnThink()
	if !IsValid(self) then return end
	local target = self.Target

	if self.UsingFlamethrower and (self.Dying or self.IsBeingStunned) then
		self:StopToasting()
	end
	if self.UsingFlamethrower and self:GetLastToast() + 0.125 < CurTime() and !self.Dying then -- This controls how offten the trace for the flamethrower updates it's position. This shit is very costly so I wanted to try limit how much it does it.
		self:StartToasting()

		-- Stop toasting if any of these pass.
		if IsValid(target) and self.StandingFlamethrower and (self:IsAttackBlocked() or !self:IsFacingTarget() or !self:TargetInRange(400)) then
			self.CancelCurrentAction = true
		end
	end
	if !self.UsingFlamethrower then
		self.CancelCurrentAction = false
		self:StopSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav")
	end
	
	-- Justin is here to make sure the Krasny isn't defeated if he hits a wall during his flight.
	if self.Lunging and CurTime() > self.LungTime then
		self.Lunging = CurTime() + 0.25
		local qtr = util.QuickTrace(self:OBBCenter(), self:GetForward()*200, self)
		if self:TargetInRange(85) or self:IsMovingIntoObject() then
			--print("I hit something and need to land.")
			self:JetPackLand()
		end
	end

	-- DG4/DG5 Lift
	if self.PanzerDGLifted and self:PanzerDGLifted() and !self.DGLift then
		self.DGLift = true
		self:DoSpecialAnimation("nz_soldat_tesla_intro")
	elseif !self:PanzerDGLifted() and self.DGLift then
		self.DGLift = false
		self:DoSpecialAnimation("nz_soldat_tesla_outro")
	end

	-- Allows the Panzer to "aim" in your general direction.
	if self.UsingFlamethrower or self.UsingFireBomb then
		if IsValid(self:GetTarget()) then
			local blend_bot_dist = 625
			local blend_top_dist = 1250 - blend_bot_dist

			if !self:TargetInRange(450) then
				blend_bot_dist = 750
				blend_top_dist = 1500 - blend_bot_dist
			end


			local diff = self:WorldToLocal(self:GetTarget():GetPos())
			local pose_p = ((diff.y - blend_bot_dist)/blend_top_dist) * 2 + 2
			--print(pose_p)
			--print(pose_r)


			self:SetPoseParameter("aim_leftright", pose_p)
			self:SetPoseParameter("aim_updown", -1)
		end
	end
end

function ENT:OnGameOver() 
	if !self.yousuck then
		self.yousuck = true
		self:DoSpecialAnimation("nz_soldat_com_summon")
	end
end

function ENT:PerformDeath(dmgInfo)	
	self.Dying = true

	local attacker = dmgInfo:GetAttacker()

	self:StopToasting()
	if IsValid(self.Claw) then self.Claw:Remove() end
	self:EmitSound("nz_moo/zombies/vox/_mechz/v2/death/killshot.mp3", 100, math.random(85,105))

	if IsValid(attacker) then
		attacker:EmitSound("nz_moo/zombies/vox/_mechz/v2/death/killshot.mp3", SNDLVL_GUNFIRE, math.random(85,105))
	end

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
end

function ENT:PostTookDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local dmgtype = dmginfo:GetDamageType()
	local damage = dmginfo:GetDamage()

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
	local hitforce = dmginfo:GetDamageForce()

	local damagemod = 0.95

	local headpos = self:GetAttachment(self:LookupAttachment("eyes")).Pos
	local powerpos = self:GetAttachment(self:LookupAttachment("tag_powersupply")).Pos

	--print(hitforce:Length2D())
	--print(dmgtype)

	--[[ Armor ]]--

	-- The Faceplate(Helmet) and Powersupply will both contribute as damage reductors.
	if self:GetHelmet() and (hitpos:DistToSqr(headpos) < 15^2) then
		if self.HelmetHP > 0 then

			self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
			ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 10)

			self.HelmetHP = self.HelmetHP - damage

			dmginfo:ScaleDamage(0.015)
		else
			self:SetHelmet(false)
			self:SetBodygroup(1,1)
			angering = true

			self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)
			attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)
			ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 10)

			attacker:GivePoints(90)

			if !self.IsBeingStunned then
				self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)

				self.IsBeingStunned = true
				self:DoSpecialAnimation("nz_soldat_pain_faceplate", true, true)
				self.IsBeingStunned = false
				self.LastStun = CurTime() + 8
				self:ResetMovementSequence()
			end
		end
	end

	if self.HasPSupply and (hitpos:DistToSqr(powerpos) < 12^2) then
		if self.PowerSupplyHP > 0 then

			self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
			ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 17)

			self.PowerSupplyHP = self.PowerSupplyHP - damage

			dmginfo:ScaleDamage(0.015)
		else
			self.HasPSupply = false
			self:SetBodygroup(2,1)

			self:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], 95)
			attacker:EmitSound(self.ArmorBreakSounds[math.random(#self.ArmorBreakSounds)], SNDLVL_GUNFIRE)
			ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 17)

			attacker:GivePoints(90)

			if !self.IsBeingStunned then
				self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)

				self.IsBeingStunned = true
				self:DoSpecialAnimation("nz_soldat_powercore_pain", true, true)
				self.IsBeingStunned = false
				self.LastStun = CurTime() + 8
				self:ResetMovementSequence()
			end
		end
	end

	if self:GetHelmet() then
		damagemod = damagemod * 0.75
	end

	if self.HasPSupply then
		damagemod = damagemod * 0.25
	end

	-- 25% Chance to get knocked over if hit by a high damage force without power supply.
	if !self:GetSpecialAnimation() and !self.HasPSupply and hitforce:Length2D() > 50000 and math.random(100) > 75 and CurTime() > self.LastStun then
		if CurTime() > self.LastStun then
			self.LastStun = CurTime() + 8
			self:DoSpecialAnimation("nz_soldat_knockgetup_blend")
		end
	end

	-- 25% Chance to get stunned if hit by a high damage force with the dissolve damage type without power supply.
	if !self:GetSpecialAnimation() and !self.HasPSupply and hitforce:Length2D() > 4500 and dmgtype == DMG_DISSOLVE and math.random(100) > 75 then
		if CurTime() > self.LastStun then
			self:PlaySound(self.PanicSounds[math.random(#self.PanicSounds)], 90, math.random(85, 105), 1, 2)

			self.LastStun = CurTime() + 8
			self:DoSpecialAnimation("nz_soldat_pain_jetpack")
		end
	end

	dmginfo:ScaleDamage(damagemod)
end

function ENT:OnTargetInAttackRange()
	if self.UsingFlamethrower then
		self:StopToasting()
	end
	if !self:GetBlockAttack() then
		self:Attack()
	else
		self:TimeOut(1)
	end
end

function ENT:ResetMovementSequence()
	if self.UsingFlamethrower then
		self:ResetSequence(self.FlameMovementSequence)
		self.CurrentSeq = self.FlameMovementSequence
	elseif self.Lunging then
		self:ResetSequence(self.FlyMovementSequence)
		self.CurrentSeq = self.FlyMovementSequence
	elseif self.DGLift then
		self:ResetSequence(self.TeslaSequence)
	elseif self.MoveFaster then
		self:ResetSequence(self.FastMovementSequence)
		self.CurrentSeq = self.FastMovementSequence
	else
		self:ResetSequence(self.MovementSequence)
		self.CurrentSeq = self.MovementSequence
	end
	if self:GetSequenceGroundSpeed(self:GetSequence()) ~= self:GetRunSpeed() or self.UpdateSeq ~= self.CurrentSeq then -- Moo Mark 4/19/23: Finally got a system where the speed actively updates when the movement sequence set is changed.
		--print("update")
		self.UpdateSeq = self.CurrentSeq
		self:UpdateMovementSpeed()
	end
end

-- Called when the zombie wants to idle. Play an animation here
function ENT:PerformIdle()
	if self.UsingFlamethrower then
		self:StopToasting()
	end
	if self.Stunned then
		self:ResetSequence(self.SparkyAnim)
	elseif self.Jetpacking then
			self:ResetSequence(self.JetPackIdleSequence)
	elseif self.DGLift then
		self:ResetSequence(self.TeslaSequence)
	else
		self:ResetSequence(self.IdleSequence)
	end
end

function ENT:StartToasting()
	self.UsingFlamethrower = true
	if self.UsingFlamethrower then
		--print("I'm Nintoasting!!!")

		if not leftthetoasteron then
			ParticleEffectAttach("asw_mnb_flamethrower",PATTACH_POINT_FOLLOW,self,5)
			self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/start.mp3",95, math.random(85, 105))
			self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav",100, 100)
			leftthetoasteron = true
		end

		self:SetLastToast(CurTime())
		if !self.NextFireParticle or self.NextFireParticle < CurTime() then
			local bone = self:GetAttachment(self:LookupAttachment("tag_flamethrower_fx"))
			pos = bone.Pos
			local mins = Vector(0, -8, -15)
			local maxs = Vector(325, 20, 15)
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
			local tr2 = util.TraceHull({
				start = pos,
				endpos = pos + bone.Ang:Forward()*500,
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_PLAYER,
				ignoreworld = true,
				mins = mins,
				maxs = maxs,
			})
		
			local target = tr.Entity
			local target2 = tr2.Entity

			--print(target)

			debugoverlay.BoxAngles(pos, mins, maxs, bone.Ang, 1, Color( 255, 255, 255, 10))
			
			if IsValid(target2) and target2:IsNextBot() and target2.IsMooZombie and !target2.ZombieIgnited and !target2.IsMooSpecial then
				target2:Flames(true)
			end
			if IsValid(target) and target:IsPlayer() and target:Alive() then
				local dmg = DamageInfo()
				dmg:SetAttacker(self)
				dmg:SetInflictor(self)
				dmg:SetDamage(6)
				dmg:SetDamageType(DMG_BURN)
						
				tr.Entity:TakeDamageInfo(dmg)
				--tr.Entity:Ignite(3, 0)
			end
		end
		self.NextFireParticle = CurTime() + 0.1
	end
end

function ENT:StopToasting()
	if self.UsingFlamethrower then
		--print("I'm no longer Nintoasting.")
		if leftthetoasteron then
			self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/end.mp3",100, math.random(85, 105))
			self:StopSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav")
			leftthetoasteron = false
		end
		self.UsingFlamethrower = false
		self:StopParticles()
	end
end

function ENT:JetPackJump()
	local target = self:GetTarget()

	self.Lunging = true

	local comedyday = os.date("%d-%m") == "01-04"
	if math.random(50) == 50 or comedyday then
		self.JetpackSnd = "nz_moo/zombies/vox/_mechz/v2/rocket/joyride.wav"
	else
		self.JetpackSnd = "nz_moo/zombies/vox/_mechz/v2/rocket/loop.wav"
	end

	self:EmitSound(self.JetpackSnd, 85)
	self:EmitSound("nz_moo/zombies/vox/_mechz/v2/rocket/start.mp3", 85)

	ParticleEffectAttach("bo3_panzer_engine",PATTACH_POINT_FOLLOW,self,4)
	ParticleEffectAttach("bo3_panzer_engine",PATTACH_POINT_FOLLOW,self,3)

	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndMove("nz_soldat_jump_start", 1, self.FaceEnemy)
		self:SetSpecialAnimation(false)
	end)

	self:FaceTowards(target)	
	self.loco:Jump()

    self:TimedEvent( 0.2, function() self.loco:SetVelocity(((target:GetPos() + target:OBBCenter()) - (self:GetPos() + self:OBBCenter())):GetNormalized() * self:GetRangeTo(target:GetPos()) + self:GetUp() * math.Clamp(self:GetRangeTo(target:GetPos()), 235, 595)) end)
end

function ENT:JetPackLand()

	self.Lunging = false
	self.LungCooldown = CurTime() + 10
	self.CancelCurrentPath = true

	self:StopParticles()
	self:EmitSound("nz_moo/zombies/vox/_mechz/v2/rocket/stop.mp3", 85)
	self:StopSound(self.JetpackSnd)

	util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
	ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,13)
	ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,14)

	self.loco:SetVelocity(self:GetForward() * -50) 
end

function ENT:OnLandOnGroundCustom() 
	if self.Lunging then
		self:JetPackLand()
	end
end

function ENT:OnRemove()
	self:StopSound(self.JetpackSnd)
	self:StopSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav")
	self:StopToasting()
end

function ENT:CustomAnimEvent(a,b,c,d,e)
	if e == "mech_melee_whoosh" then
		self:EmitSound("enemies/bosses/newpanzer/melee_a.ogg",80)
	end
	if e == "mech_stomp_le" then
		self:EmitSound(self.RunFootstepSounds[math.random(#self.RunFootstepSounds)],75,math.random(95,100))
		--self:EmitSound("nz/panzer/servo/mech_servo_0"..math.random(0,1)..".wav",65,math.random(95,100))
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
		ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,13)
	end
	if e == "mech_stomp_ri" then
		self:EmitSound(self.RunFootstepSounds[math.random(#self.RunFootstepSounds)],75,math.random(95,100))
		--self:EmitSound("nz/panzer/servo/mech_servo_0"..math.random(0,1)..".wav",65,math.random(95,100))
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
		ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,14)
	end
	if e == "mech_land" then
		self:EmitSound(self.MechLandSounds[math.random(#self.MechLandSounds)],80,math.random(95,100))
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
		
		for i = 1, 3 do
			ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,1)
		end

	end
	if e == "mech_jetflames_start" then
		ParticleEffectAttach("bo3_panzer_engine",PATTACH_POINT_FOLLOW,self,4)
		ParticleEffectAttach("bo3_panzer_engine",PATTACH_POINT_FOLLOW,self,3)
	end
	if e == "mech_jetflames_stop" then
		self:StopParticles()
	end
	if e == "mech_yell" then
		self:EmitSound(self.RageSounds[math.random(#self.RageSounds)], 95, math.random(95,105))
		self.NextSound = CurTime() + 5
	end
	if e == "mech_arrive_in" then
		self:EmitSound("nz_moo/zombies/vox/_mechz/v2/jump_in_118.mp3",100,100)
	end
	if e == "mech_alarm" then
		self:EmitSound("nz_moo/zombies/vox/_mechz/vox/alarm_2.mp3", 90, math.random(95, 105))
	end
	if e == "mech_spawn_land" then
		-- Knock normal zombies aside
		for k,v in nzLevel.GetZombieArray() do
			if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.Non3arcZombie and !v.IsMooSpecial and v ~= self then
				if self:GetRangeTo( v:GetPos() ) < 10^2 then	
					if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() and self:GetRunSpeed() > 36 then
						if v.PainSequences then
							v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
						end
					end
				end
			end
		end
	end
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	
	-- Turned Zombie Targetting
	if self.IsTurned then
		return IsValid(ent) and ent:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooBossZombie and ent:Alive() 
	end
	
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end
