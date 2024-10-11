AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Margwadog"
ENT.PrintName = "Abomination"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:InitDataTables()
	self:NetworkVar("Bool", 5, "OpenMidHead")
	self:NetworkVar("Bool", 6, "OpenLeftHead")
	self:NetworkVar("Bool", 7, "OpenRightHead")
	self:NetworkVar("Bool", 8, "UsingLaser")
end

if CLIENT then 
	function ENT:PostDraw()
		if self:Alive() then
			if !IsValid(self) then return end
			local color = Color(93,0,255)
			if (!self.Draw_FX or !IsValid(self.Draw_FX)) and (self:GetOpenMidHead() or self:GetOpenLeftHead() or self:GetOpenRightHead()) then
				if self:GetOpenRightHead() then
					self.Draw_FX = CreateParticleSystem(self, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 17)
				elseif self:GetOpenMidHead() then
					self.Draw_FX = CreateParticleSystem(self, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 12)
				else
					self.Draw_FX = CreateParticleSystem(self, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 13)
				end
				self.Draw_FX:SetControlPoint(2, Vector(color.r/255, color.g/255, color.b/255)) -- Color
			end
			if (self.Draw_FX or IsValid(self.Draw_FX)) and (!self:GetOpenMidHead() and !self:GetOpenLeftHead() and !self:GetOpenRightHead()) then
				self.Draw_FX:StopEmission(false, true)
				self.Draw_FX = nil
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true

ENT.AttackDamage = 75
ENT.AttackRange = 175
ENT.DamageRange = 175

ENT.TraversalCheckRange = 50

ENT.Models = {
	{Model = "models/moo/_codz_ports/t9/tungsten/moo_codz_t9_abomination.mdl", Skin = 0, Bodygroups = {0,0}},
}

local util_tracehull = util.TraceHull
local spawn = {"nz_ai_abom_bull_stop"}

local StandAttackSequences = {
	{seq = "nz_ai_abom_stand_bite"},
}

local AttackSequences = {
	{seq = "nz_ai_abom_run_bite"},
}

local BashAttackSequences = {
	{seq = "nz_ai_abom_bull_hit"},
}

local JumpSequences = {
	{seq = "nz_ai_abom_mantle_over_36"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_abom/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_abom/amb/amb_13.mp3"),
}

ENT.IdleSequence = "nz_ai_abom_idle_01"
ENT.LaserFireSequence = "nz_ai_abom_ranged_attack_aim"
ENT.ZombieLandSequences = { "nz_ai_abom_land", }

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_ai_abom_walk",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {StandAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			MovementSequence = {
				"nz_ai_abom_run",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {StandAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			MovementSequence = {
				"nz_ai_abom_sprint",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {StandAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 155, Sequences = {
		{
			MovementSequence = {
				"nz_ai_abom_bull_loop",
			},
			SpawnSequence = {spawn},
			AttackSequences = {BashAttackSequences},
			StandAttackSequences = {BashAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

ENT.CustomMantleOver48 = {
	"nz_ai_abom_mantle_over_48",
}

ENT.CustomMantleOver72 = {
	"nz_ai_abom_mantle_over_72",
}

ENT.CustomMantleOver96 = {
	"nz_ai_abom_mantle_over_96",
}

ENT.CustomMantleOver128 = {
	"nz_ai_abom_mantle_over_128",
}

ENT.LaserChargeSequences = {
	"nz_ai_abom_ranged_charge_1",
	--"nz_ai_abom_ranged_charge_2",
	"nz_ai_abom_ranged_charge_3",
}

ENT.AttackSounds = {
	--Sound("nz_moo/zombies/vox/_abom/attack/attack_03.mp3"),
	--Sound("nz_moo/zombies/vox/_abom/attack/attack_04.mp3"),
	--Sound("nz_moo/zombies/vox/_abom/attack/attack_09.mp3"),
	--Sound("nz_moo/zombies/vox/_abom/attack/attack_11.mp3"),
	--Sound("nz_moo/zombies/vox/_abom/attack/attack_12.mp3"),
	--Sound("nz_moo/zombies/vox/_abom/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_10.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_13.mp3"),
	Sound("nz_moo/zombies/vox/_abom/attack/attack_14.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_abom/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_abom/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_abom/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_abom/death/death_03.mp3"),
}

ENT.RoarSounds = {
	--Sound("nz_moo/zombies/vox/_abom/roar/roar_00.mp3"),
	Sound("nz_moo/zombies/vox/_abom/roar/roar_01.mp3"),
	Sound("nz_moo/zombies/vox/_abom/roar/roar_02.mp3"),
}

ENT.CustomAttackImpactSounds = {
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

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_abom/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_06.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_07.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_08.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_09.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_10.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_11.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_12.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_13.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_14.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_15.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_16.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_17.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_18.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_19.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_20.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_21.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_22.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_23.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_24.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_25.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_26.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_27.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_28.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_29.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_30.mp3"),
	Sound("nz_moo/zombies/vox/_abom/step/step_31.mp3"),
}

ENT.HeavyAttackImpactSounds = {
	Sound("wavy_zombie/hulk/pound_victim_1.wav"),
	Sound("wavy_zombie/hulk/pound_victim_2.wav"),
}

ENT.HeadExploSounds = {
	Sound("nz_moo/zombies/vox/_abom/head_explo/head_explo_00.mp3"),
	Sound("nz_moo/zombies/vox/_abom/head_explo/head_explo_01.mp3"),
	Sound("nz_moo/zombies/vox/_abom/head_explo/head_explo_02.mp3"),
	Sound("nz_moo/zombies/vox/_abom/head_explo/head_explo_03.mp3"),
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

ENT.WeakImpactSounds = {
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_00.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_01.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_02.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_03.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_04.mp3"),
}

ENT.SkidSounds = {
	Sound("nz_moo/zombies/vox/_abom/bullcharge/stop_00.mp3"),
	Sound("nz_moo/zombies/vox/_abom/bullcharge/stop_01.mp3"),
	Sound("nz_moo/zombies/vox/_abom/bullcharge/stop_02.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(4500)
			self:SetMaxHealth(4500)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 500 + (500 * count), 4500, 10500 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 500 + (500 * count), 4500, 10500 * count))
			else
				self:SetHealth(5000)
				self:SetMaxHealth(5000)	
			end
		end

		self.MidHeadHP = self:Health() * 0.15
		self.LeftHeadHP = self:Health() * 0.15
		self.RightHeadHP = self:Health() * 0.15

		self.MidHead = true
		self.LeftHead = true
		self.RightHead = true

		self:SetOpenMidHead(false)
		self:SetOpenLeftHead(false)
		self:SetOpenRightHead(false)

		self.HeadCount = 0

		self.LostAHead = false
		self.GainSpeed = false

		self.IFrames = CurTime() + 3

		self:SetRunSpeed(1)

		self.Enraged = false

		self.BullCharge = false
		self.StopBullCharge = false
		self.BullChargeTime = CurTime() + 3
		self.BullChargeCooldown = CurTime() + 3

		self:SetUsingLaser(false)
		self.StandingLaser = false
		self.LaserTime = CurTime() + 2
		self.LaserHitTargetTime = CurTime() + 4
		self.NextLaserTrace = CurTime()
		self.LaserCooldown = CurTime() + math.Rand(6.6, 12.25)

		initiatethelaser = false
		imbreathinglasersnshit = false

		self.OpenMouthTime = CurTime() + 3
		self.NextMouthOpen = CurTime() + math.Rand(3.5, 7.5)
	end
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
	effectData:SetMagnitude( 5 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)

	self:SetBodygroup(1,0)
	self:SetBodygroup(2,0)
	self:SetBodygroup(3,0)

	self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 72))
	self:SetSurroundingBounds(Vector(-50, -50, 0), Vector(50, 50, 100))
		
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)

	self:EmitSound("nz_moo/zombies/vox/_abom/spawn.mp3",511)

	if seq then
		self:PlaySequenceAndMove(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmgInfo)	
	self.Dying = true

	self:StopLaser()
	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:DoDeathAnimation("nz_ai_abom_death")
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndWait(seq)
		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 
		self:Remove(DamageInfo())
	end)
end

function ENT:OnAttack()
	if self.BullCharge then
		local target = self:GetTarget()

		self.BullCharge = false
		self.StopBullCharge = true
		self.BullChargeCooldown = CurTime() + 7

		if IsValid(target) and target:IsPlayer() and !self:IsAttackBlocked() then
			local dmgInfo = DamageInfo()
			dmgInfo:SetAttacker( self )
			dmgInfo:SetDamage( 100 )
			dmgInfo:SetDamageType( DMG_SLASH )

			if self:TargetInRange(self.DamageRange) then
				target:NZSonicBlind(1.75)
				target:TakeDamageInfo(dmgInfo)

				target:ViewPunch( VectorRand():Angle() * 0.05 )
				if target:IsOnGround() then
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 20 + Vector( 0, 35, 0 ) )
				else
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 5 + Vector( 0, 35, 14 ) )
				end
			end
		end
	end
end

function ENT:PostAttack()
	if self.StopBullCharge then
		self.StopBullCharge = false
		self.Enraged = false -- No longer enraged after a charge


		self:SetRunSpeed(1)
		self:SpeedChanged()

		if IsValid(self.Trail) then
			self.Trail:Remove()
		end
	end
end

function ENT:AI()
	local target = self:GetTarget()

	if !IsValid(target) then return end

	-- MOUTH LASER
	if !self:GetSpecialAnimation() and target:IsPlayer() and CurTime() > self.LaserCooldown and math.random(100) <= 45 and !self:IsAttackBlocked() and self:IsFacingTarget() and self:TargetInRange(535) and !self:TargetInRange(250) then
		if self.BullCharge then return end

		self.StandingLaser = true
		self:ZombieGestureSequences()

		self.BullChargeCooldown = CurTime() + 12

		if !initiatethelaser then 
			initiatethelaser = true 

			self:TempBehaveThread(function(self)
				self:SetSpecialAnimation(true)
				self:PlaySequenceAndMove(self.LaserChargeSequences[math.random(#self.LaserChargeSequences)])
				self:SetSpecialAnimation(false)
				self:SetStop(true)
			end)
		end
	end

	-- BULL CHARGE
	if IsValid(target) and target:IsPlayer() and self:TargetInRange(800) and !self:TargetInRange(250) and !self:IsAttackBlocked() then

		if CurTime() > self.BullChargeCooldown and !self.BullCharge and !self.IsTurned and math.random(100) <= 50 then

			self.BullCharge = true
			self.BullChargeTime = CurTime() + math.Rand(4.25, 4.95)

			self:SetRunSpeed(155)
			self:SpeedChanged()

			self:DoSpecialAnimation("nz_ai_abom_bull_start")

			self.Trail = util.SpriteTrail(self, 9, Color(93, 0, 255, 255), true, 70, 45, 0.45, 1 / 40 * 0.3, "materials/trails/plasma")
		end
	end

	-- STOP BULL CHARGE
	if CurTime() > self.BullChargeTime and self.BullCharge then
		--print(self.ManIsMad)
		self.OpenMouthTime = CurTime() + 0.1
		self.NextMouthOpen = CurTime() + math.Rand(3.1, 4.5)

		self:DoSpecialAnimation("nz_ai_abom_bull_stop")

		self.BullCharge = false
		self.BullChargeCooldown = CurTime() + 12

		self.Enraged = false -- No longer enraged after a charge

		self:SetRunSpeed(36)
		self:SpeedChanged()

		if IsValid(self.Trail) then
			self.Trail:Remove()
		end
	end

	-- OPEN MOUTH
	if !self:GetSpecialAnimation() or !self.BullCharge or !self.StandingLaser then
		if CurTime() > self.NextMouthOpen then
			local maxheads = 3 - self.HeadCount

			self.NextMouthOpen = CurTime() + math.Rand(3.25, 6.15)
			self.OpenMouthTime = CurTime() + 1.95
			if maxheads == 3 then -- A dreaded elseif pyramid.
				self:SetOpenRightHead(true)
			elseif maxheads == 2 then
				self:SetOpenLeftHead(true)
			else
				self:SetOpenMidHead(true)
			end
		end

		if CurTime() > self.OpenMouthTime then
			self:SetOpenMidHead(false)
			self:SetOpenLeftHead(false)
			self:SetOpenRightHead(false)
		end
	else
		self:ZombieGestureSequences()
	end

	-- RANDOMLY RUSH TARGET ON DAMAGE
	if self.Enraged and !self.BullCharge then
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end

	-- Knock normal zombies aside
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.Non3arcZombie and !v.IsMooSpecial and v ~= self then
			if self:GetRangeTo( v:GetPos() ) < 13^2 then	
				if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() then
					if v.PainSequences then
						v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
					end
				end
			end
		end
	end
end

function ENT:OnThink()
	if not IsValid(self) then return end
	local target = self.Target

	if self:GetUsingLaser() and self.NextLaserTrace + 0.125 < CurTime() then -- This controls how offten the trace for the flamethrower updates it's position. This shit is very costly so I wanted to try limit how much it does it.
		self:FiringMyLaser()
	end

	-- Stop toasting if any of these pass.
	if self:GetUsingLaser() and CurTime() > self.LaserTime and (self.Dying or self:IsAttackBlocked() or !self:IsFacingTarget() or !self:TargetInRange(400) or CurTime() > self.LaserHitTargetTime) then
		--self.CancelCurrentAction = true
		self:StopLaser()
	end

	-- Allows the Abomination to "aim" in your general direction.
	if self:GetUsingLaser() then
		if IsValid(target) then
			local blend_bot_dist = 625
			local blend_top_dist = 1250 - blend_bot_dist

			if !self:TargetInRange(300) then
				blend_bot_dist = 750
				blend_top_dist = 1500 - blend_bot_dist
			end

			local diff = self:WorldToLocal(target:GetPos())
			local pose_p = ((diff.y - blend_bot_dist)/blend_top_dist) * 2 + 2
			--print(pose_p)
			--print(pose_r)

			self:SetPoseParameter("aim_leftright", pose_p)
			self:SetPoseParameter("aim_updown", -1)
		end
	end
end

function ENT:FiringMyLaser()
	self:SetUsingLaser(true)
	if self:GetUsingLaser() then
		self:SetStuckCounter(0)
		self.NextLaserTrace = CurTime()

		if !self.NextLaser or self.NextLaser < CurTime() then
			local bone = self:GetAttachment(self:LookupAttachment("headlaser_fx_tag"))
			pos = bone.Pos
			local mins = Vector(0, -12, -25)
			local maxs = Vector(325, 20, 25)
			local tr = util.TraceHull({
				start = pos,
				endpos = pos + bone.Ang:Forward()*535,
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_INTERACTIVE_DEBRIS,
				ignoreworld = true,
				mins = mins,
				maxs = maxs,
			})
		
			local target = tr.Entity

			debugoverlay.BoxAngles(pos, mins, maxs, bone.Ang, 1, Color( 255, 255, 255, 10))
			
			if IsValid(target) and target:IsPlayer() and target:Alive() and !self:IsAttackEntBlocked(tr.Entity) then
				local dmg = DamageInfo()
				dmg:SetAttacker(self)
				dmg:SetInflictor(self)
				dmg:SetDamage(6)
				dmg:SetDamageType(DMG_ENERGYBEAM)
						
				tr.Entity:TakeDamageInfo(dmg)
				tr.Entity:NZSonicBlind(0.12)
				--tr.Entity:Ignite(3, 0)
			end
		end
		self.NextLaser = CurTime() + 0.1
	end
end

function ENT:StopLaser()
	if self:GetUsingLaser() then
		self:StopParticles()
		self:SetStop(false)
		self.StandingLaser = false
		self:SetUsingLaser(false)
		self.LaserCooldown = CurTime() + math.Rand(6.6, 12.25)

		if imbreathinglasersnshit then
			imbreathinglasersnshit = false
			initiatethelaser = false 

			self:EmitSound("nz_moo/zombies/vox/_abom/beam/fire_swt_01.mp3",100, math.random(85, 105))
			self:StopSound("nz_moo/zombies/vox/_abom/beam/loop_main.wav")
			self:StopSound("nz_moo/zombies/vox/_abom/beam/loop_lizard.wav")

			self:TempBehaveThread(function(self)
				self:SetSpecialAnimation(true)
				self:PlaySequenceAndMove("nz_ai_abom_roar_out")
				self:SetSpecialAnimation(false)
			end)
		end
	end
end

function ENT:ZombieGestureSequences()

	if !self:GetSpecialAnimation() and !self.StandingLaser and !self.BullCharge and CurTime() < self.OpenMouthTime then
		if self:GetOpenMidHead() then
			self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
			self:AddGesture(ACT_GESTURE_FLINCH_HEAD, true)
		end
		if self:GetOpenLeftHead() then
			self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
			self:AddGesture(ACT_GESTURE_FLINCH_LEFTARM, true)
		end
		if self:GetOpenRightHead() then
			self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
			self:AddGesture(ACT_GESTURE_FLINCH_RIGHTARM, true)
		end
	else
		self:SetOpenMidHead(false)
		self:SetOpenLeftHead(false)
		self:SetOpenRightHead(false)
		self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
		self:RemoveGesture(ACT_GESTURE_FLINCH_LEFTARM)
		self:RemoveGesture(ACT_GESTURE_FLINCH_RIGHTARM)
	end
end

function ENT:OnInjured(dmginfo)
	if !self:Alive() then return end

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce = dmginfo:GetDamageForce()
	local damage = dmginfo:GetDamage()

	local attacker = dmginfo:GetAttacker()


	local middlehead = self:GetBonePosition(self:LookupBone("j_head"))

	local lefthead = self:GetBonePosition(self:LookupBone("j_head_le"))

	local righthead = self:GetBonePosition(self:LookupBone("j_head_ri"))

	if math.random(100) <= 25 and !self.Enraged then
		self.Enraged = true
	end

	if hitpos:DistToSqr(middlehead) < 35^2 and self.MidHead and self:GetOpenMidHead() and CurTime() > self.IFrames then
		if self.MidHeadHP > 0 then
			self.MidHeadHP = self.MidHeadHP - damage

			self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
			attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		else
			self.IFrames = CurTime() + 3
			self.LostAHead = true
			self.MidHead = false
			self.HeadCount = self.HeadCount + 1
			self:SetBodygroup(1,1)
    		ParticleEffectAttach("hcea_hunter_shade_cannon_explode_ergy_fbl_trcr_ball_smk", 4, self, 2)
    		self:EmitSound(self.HeadExploSounds[math.random(#self.HeadExploSounds)], 511)

			self:SetOpenMidHead(false)
			self:SetOpenLeftHead(false)
			self:SetOpenRightHead(false)
			
    		if IsValid(attacker) then
    			attacker:GivePoints(500)
    		end
    		timer.Simple(engine.TickInterval(), function()
				if self.HeadCount >= 3 then
					self:OnKilled(dmginfo)
				else
					self:TempBehaveThread(function(self)
						self:SetSpecialAnimation(true)
						self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
						self:PlaySequenceAndMove("nz_ai_abom_shot_middle_head", {gravity = true})
						self:CollideWhenPossible()
						self:SetSpecialAnimation(false) -- Stops them from going back to idle.
					end)
				end
			end)
		end
	end
	if hitpos:DistToSqr(lefthead) < 33^2 and self.LeftHead and self:GetOpenLeftHead() and CurTime() > self.IFrames then
		if self.LeftHeadHP > 0 then
			self.LeftHeadHP = self.LeftHeadHP - damage

			self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
			attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		else
			self.IFrames = CurTime() + 3
			self.LostAHead = true
			self.LeftHead = false
			self.HeadCount = self.HeadCount + 1
			self:SetBodygroup(2,1)
    		ParticleEffectAttach("hcea_hunter_shade_cannon_explode_ergy_fbl_trcr_ball_smk", 4, self, 3)
    		self:EmitSound(self.HeadExploSounds[math.random(#self.HeadExploSounds)], 511)

			self:SetOpenMidHead(false)
			self:SetOpenLeftHead(false)
			self:SetOpenRightHead(false)
			
    		if IsValid(attacker) then
    			attacker:GivePoints(500)
    		end
    		timer.Simple(engine.TickInterval(), function()
				if self.HeadCount >= 3 then
					self:OnKilled(dmginfo)
				else
					self:TempBehaveThread(function(self)
						self:SetSpecialAnimation(true)
						self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
						self:PlaySequenceAndMove("nz_ai_abom_shot_left_head", {gravity = true})
						self:CollideWhenPossible()
						self:SetSpecialAnimation(false) -- Stops them from going back to idle.
					end)
				end
			end)
		end
	end
	if hitpos:DistToSqr(righthead) < 33^2 and self.RightHead and self:GetOpenRightHead() and CurTime() > self.IFrames then
		if self.RightHeadHP > 0 then
			self.RightHeadHP = self.RightHeadHP - damage

			self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
			attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		else
			self.IFrames = CurTime() + 3
			self.LostAHead = true
			self.RightHead = false
			self.HeadCount = self.HeadCount + 1
			self:SetBodygroup(3,1)
    		ParticleEffectAttach("hcea_hunter_shade_cannon_explode_ergy_fbl_trcr_ball_smk", 4, self, 4)
    		self:EmitSound(self.HeadExploSounds[math.random(#self.HeadExploSounds)], 511)

			self:SetOpenMidHead(false)
			self:SetOpenLeftHead(false)
			self:SetOpenRightHead(false)
			
    		if IsValid(attacker) then
    			attacker:GivePoints(500)
    		end
    		timer.Simple(engine.TickInterval(), function()
				if self.HeadCount >= 3 then
					self:OnKilled(dmginfo)
				else
					self:TempBehaveThread(function(self)
						self:SetSpecialAnimation(true)
						self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
						self:PlaySequenceAndMove("nz_ai_abom_shot_right_head", {gravity = true})
						self:CollideWhenPossible()
						self:SetSpecialAnimation(false) -- Stops them from going back to idle.
					end)
				end
			end)
		end
	end

	dmginfo:ScaleDamage(0.05) -- My fella here takes a small amount of damage normally... Shoot their heads.
end

function ENT:CustomAnimEvent(a,b,c,d,e) 

	self.OverrideLLarge = true
	self.OverrideRLarge = true

	if e == "step_left_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 75)
		else
			self:EmitSound(self.NormalRunFootstepsSounds[math.random(#self.NormalRunFootstepsSounds)], 75)
		end
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
		ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,10)
	end
	if e == "step_right_large"then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 75)
		else
			self:EmitSound(self.NormalRunFootstepsSounds[math.random(#self.NormalRunFootstepsSounds)], 75)
		end
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
		ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,11)
	end
	if e == "drag_foot" then
		self:EmitSound("nz_moo/zombies/vox/_abom/bullcharge/prepare.mp3", 95, math.random(95,105))
	end
	if e == "abom_roar_quick" then
		self.NextSound = CurTime() + self.SoundDelayMax
		self:PlaySound(self.RoarSounds[math.random(#self.RoarSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	end
	if e == "abom_explode" then
		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,45), Angle(0,0,0), nil) 
		self:Remove()
	end
	if e == "abom_laser_start" then
		local comedyday 	= os.date("%d-%m") == "01-04"

		self.LaserTime = CurTime() + 2
		self.LaserHitTargetTime = CurTime() + 4
		self:FiringMyLaser()

		if not imbreathinglasersnshit then
			if self.MidHead then
				ParticleEffectAttach("zmb_abom_beam",PATTACH_POINT_FOLLOW,self,15)
			end
			if self.LeftHead then
				ParticleEffectAttach("zmb_abom_beam",PATTACH_POINT_FOLLOW,self,16)
			end
			if self.RightHead then
				ParticleEffectAttach("zmb_abom_beam",PATTACH_POINT_FOLLOW,self,17)
			end
			
			if math.random(100) <= 1 or comedyday then
				self:EmitSound("nz_moo/zombies/vox/_abom/beam/loop_lizard.wav",100, 100)
			else
				self:EmitSound("nz_moo/zombies/vox/_abom/beam/loop_main.wav",100, 100)
			end

			self:EmitSound("nz_moo/zombies/vox/_abom/beam/fire_main.mp3",95, math.random(85, 105))
			imbreathinglasersnshit = true
		end
	end
	if e == "abom_range_tell" then
		self:EmitSound("nz_moo/zombies/vox/_abom/beam/charge_vox.mp3", 95, math.random(99,101))
		self:EmitSound("nz_moo/zombies/vox/_abom/beam/charge_swt.mp3", 80, math.random(99,101))
	end
	if e == "skid" then
		self:EmitSound(self.SkidSounds[math.random(#self.SkidSounds)], 80, math.random(95,105))
	end
end

function ENT:PerformIdle()
	if self:GetSpecialAnimation() and !self.IsTornado and !self.IsXbowSpinning then return end
	if self:GetUsingLaser() then
		self:ResetSequence(self.LaserFireSequence)
	elseif self:GetJumping() then
		if !self:GetCrawler() then
			self:GetSequenceActivity(ACT_JUMP)
		else
			self:GetSequenceActivity(ACT_HOP)
		end
	else
		self:ResetSequence(self.IdleSequence)
		if !self.IsIdle and !IsValid(self:GetTarget()) then
			self.IsIdle = true
		end
	end
end

function ENT:IsValidTarget( ent )
	if !ent then return false end

	-- Turned Zombie Targetting
	if self.IsTurned then
		return IsValid(ent) and ent:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooBossZombie and ent:Alive() 
	end
	
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_abom/beam/loop_main.wav")
	self:StopSound("nz_moo/zombies/vox/_abom/beam/loop_lizard.wav")
end
