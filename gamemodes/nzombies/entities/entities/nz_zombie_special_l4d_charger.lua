AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Charger"
ENT.Category = "Brainz"
ENT.Author = "Wavy"
ENT.Spawnable = true

if CLIENT then
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMiniBoss = true
ENT.RedEyes = false

ENT.AttackRange 			= 95
ENT.DamageRange 			= 95
ENT.AttackDamage 			= 60
ENT.HeavyAttackDamage 		= 75

ENT.SoundDelayMin = 1.5
ENT.SoundDelayMax = 2.5
ENT.MinSoundPitch = 98 				-- Limits the minimum pitch for passive sounds the zombie can make.
ENT.MaxSoundPitch = 102 				-- Limits the maximum pitch for passive sounds the zombie can make.

ENT.Models = {
	{Model = "models/wavy_ports/wavy_enemies/l4d/charger.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_charger_land"}

local AttackSequences = {
	{seq = "nz_charger_attack_stand"},
}

local WalkAttackSequences = {
	{seq = "nz_charger_attack_walk"},
}

local RunAttackSequences = {
	{seq = "nz_charger_attack_run"},
	{seq = "nz_charger_attack_run2"},
}

local SprintAttackSequences = {
	{seq = "nz_charger_charge_hit"},
}

local JumpSequences = {
	{seq = ACT_JUMP, speed = 100},
}

local walksounds = {
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_01.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_02.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_03.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_04.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_05.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_06.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_07.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_08.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_09.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_10.wav"),
	
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_11.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_12.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_13.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_14.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_15.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_16.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_17.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_18.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_19.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_20.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_21.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_22.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_lurk_23.wav"),
}

ENT.IdleSequence = "nz_charger_idle"
ENT.NoTargetIdle = "nz_charger_idle"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_charger_walk",
			},
			AttackSequences = {WalkAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_charger_run",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_charger_charge",
			},
			AttackSequences = {SprintAttackSequences},
			StandAttackSequences = {SprintAttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
}

ENT.ZombieLandSequences = {
	"nz_charger_land", -- Will only ever be one, for easy overridding.
}

ENT.ShotPainSounds = {
	Sound("wavy_zombie/charger/voice/pain/charger_pain_01.wav"),
	Sound("wavy_zombie/charger/voice/pain/charger_pain_02.wav"),
	Sound("wavy_zombie/charger/voice/pain/charger_pain_03.wav"),
	Sound("wavy_zombie/charger/voice/pain/charger_pain_04.wav"),
	Sound("wavy_zombie/charger/voice/pain/charger_pain_05.wav"),
	Sound("wavy_zombie/charger/voice/pain/charger_pain_06.wav"),
}

ENT.DeathSounds = {
	Sound("wavy_zombie/charger/voice/die/charger_die_01.wav"),
	Sound("wavy_zombie/charger/voice/die/charger_die_02.wav"),
	Sound("wavy_zombie/charger/voice/die/charger_die_03.wav"),
	Sound("wavy_zombie/charger/voice/die/charger_die_04.wav"),
}

ENT.ChargeSounds = {
	Sound("wavy_zombie/charger/voice/attack/charger_charge_01.wav"),
	Sound("wavy_zombie/charger/voice/attack/charger_charge_02.wav"),
}

ENT.SpawnSounds = {
	Sound("wavy_zombie/charger/voice/idle/charger_spotprey_01.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_spotprey_02.wav"),
	Sound("wavy_zombie/charger/voice/idle/charger_spotprey_03.wav"),
	Sound("wavy_zombie/charger/voice/warn/charger_warn_01.wav"),
	Sound("wavy_zombie/charger/voice/warn/charger_warn_02.wav"),
	Sound("wavy_zombie/charger/voice/warn/charger_warn_03.wav"),
}

ENT.AttackSounds = {
	Sound("wavy_zombie/charger/voice/attack/charger_pummel01.wav"),
	Sound("wavy_zombie/charger/voice/attack/charger_pummel02.wav"),
	Sound("wavy_zombie/charger/voice/attack/charger_pummel03.wav"),
	Sound("wavy_zombie/charger/voice/attack/charger_pummel04.wav"),
}

ENT.CustomAttackImpactSounds = {
	Sound("wavy_zombie/charger/hit/charger_smash_01.wav"),
	Sound("wavy_zombie/charger/hit/charger_smash_02.wav"),
	Sound("wavy_zombie/charger/hit/charger_smash_03.wav"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_left_01.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_left_02.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_left_03.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_left_04.wav"),
	
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_right_01.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_right_02.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_right_03.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_right_04.wav"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_left_01.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_left_02.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_left_03.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_left_04.wav"),
	
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_right_01.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_right_02.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_right_03.wav"),
	Sound("wavy_zombie/charger/foot/charger/run/charger_run_right_04.wav"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		if nzRound:GetNumber() == -1 then
			self:SetHealth(math.random(2500, 7500))
		else
			self:SetHealth( math.Clamp( nzRound:GetZombieHealth() * 5, 2000, 60000 ) or 2000 )
		end

		self:SetRunSpeed(71)

		self.ManIsMad = false -- The REAL Man is mad.
		self.ManNoLongerMad = false
		self.ManIsMadTime = CurTime() + 6
		self.ManIsMadCooldown = CurTime() + 6
		self.PainSoundCooldown = CurTime() + 1
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

	self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 72))
	self:SetSurroundingBounds(Vector(-28, -28, 0), Vector(28, 28, 80))
		
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)

	self:EmitSound(self.SpawnSounds[math.random(#self.SpawnSounds)], 500, math.random(98, 102), 1, 2)

	if seq then
		self:PlaySequenceAndMove(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)	
	self.Dying = true

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 100, math.random(90, 105), 1, 2)
	self:BecomeRagdoll(dmginfo)
end

--[[nction ENT:PostTookDamage(dmginfo) 
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local dmgtype = dmginfo:GetDamageType()

	local hitpos = dmginfo:GetDamagePosition()

	local weakspot = self:GetAttachment(self:LookupAttachment("tag_back_weakspot")).Pos

	if (hitpos:DistToSqr(weakspot) < 10^2) then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(3)
	else
		dmginfo:ScaleDamage(0.25)
	end

	if CurTime() > self.ManIsMadCooldown and !self.ManIsMad and !self.IsTurned and math.random(100) <= 50 then
		self.ManIsMad = true
		self.ManIsMadTime = CurTime() + math.Rand(4.25, 4.95)

		self:SetRunSpeed(155)
		self:SpeedChanged()

		self:DoSpecialAnimation("nz_base_follower_charge_react")
	end
end]]

function ENT:OnAttack()

	local target = self:GetTarget()
	
	if self.ManIsMad then
		self.ManIsMad = false
		self.ManNoLongerMad = true
		self.ManIsMadCooldown = CurTime() + 9
		
		if IsValid(target) and target:IsPlayer() and !self:IsAttackBlocked() then
			local dmgInfo = DamageInfo()
			dmgInfo:SetAttacker( self )
			dmgInfo:SetDamage( 75 )
			dmgInfo:SetDamageType( DMG_SLASH )

			if self:TargetInRange(self.DamageRange) then
				target:TakeDamageInfo(dmgInfo)
				
				target:EmitSound("wavy_zombie/charger/hit/charger_smash_0"..math.random(1,3)..".wav", SNDLVL_GUNFIRE, math.random(95,105))

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
	if self.ManNoLongerMad then
		self.ManNoLongerMad = false

		self:SetRunSpeed(72)
		self:SpeedChanged()
	end
end

function ENT:PostTookDamage(dmginfo)
	if !self:Alive() then return end
	
	if CurTime() > self.PainSoundCooldown then
		self:EmitSound(self.ShotPainSounds[math.random(#self.ShotPainSounds)], 100, 100, 1, 2)
		self.PainSoundCooldown = CurTime() + 1
	end
end

function ENT:AI()

	local target = self:GetTarget()
	
	if IsValid(target) and target:IsPlayer() and self:TargetInRange(1000) and !self:TargetInRange(250) and !self:IsAttackBlocked() then

		if CurTime() > self.ManIsMadCooldown and !self.ManIsMad and !self.IsTurned and math.random(100) <= 50 then

			self.ManIsMad = true
			self.ManIsMadTime = CurTime() + math.Rand(2.2, 2.8)

			self:SetRunSpeed(156)
			self:SpeedChanged()
			
			self:EmitSound(self.ChargeSounds[math.random(#self.ChargeSounds)], 511, 100, 1, 2)

			--self.Trail = util.SpriteTrail(self, 9, Color(93, 0, 255, 255), true, 70, 45, 0.45, 1 / 40 * 0.3, "materials/trails/plasma")
		end
	end

	-- STOP BULL CHARGE
	if CurTime() > self.ManIsMadTime and self.ManIsMad then
		--print(self.ManIsMad)
		self:DoSpecialAnimation("Shoved_Forward")

		self.ManIsMad = false
		self.ManIsMadCooldown = CurTime() + 9

		self:SetRunSpeed(72)
		self:SpeedChanged()
	end
	
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.Non3arcZombie and !v.IsMooSpecial and v ~= self then
			if self:GetRangeTo( v:GetPos() ) < 13^2 and self.ManIsMad then	
				if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() then
					if v.PainSequences then
						v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
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

function ENT:CustomAnimEvent(a,b,c,d,e) 

	-- Say you wanted to override some the existing events, use one of these bool below when doing so.
	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large


	if e == "step_left_small" then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 85)
		else
			self:EmitSound(self.NormalWalkFootstepsSounds[math.random(#self.NormalWalkFootstepsSounds)], 85)
		end
	end
	if e == "step_right_small" then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 85)
		else
			self:EmitSound(self.NormalWalkFootstepsSounds[math.random(#self.NormalWalkFootstepsSounds)], 85)
		end
	end
	if e == "step_left_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 85)
		else
			self:EmitSound(self.NormalRunFootstepsSounds[math.random(#self.NormalRunFootstepsSounds)], 85)
		end
	end
	if e == "step_right_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 85)
		else
			self:EmitSound(self.NormalRunFootstepsSounds[math.random(#self.NormalRunFootstepsSounds)], 85)
		end
	end

end