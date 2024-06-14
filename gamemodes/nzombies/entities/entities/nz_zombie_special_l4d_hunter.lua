AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.IsMooSpecial = true

ENT.AttackRange = 80
ENT.DamageRange = 80
ENT.AttackDamage = 40
ENT.HeavyAttackDamage = 95

ENT.Models = {
	{Model = "models/cpthazama/l4d1/hunter.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/cpthazama/l4d2/hunter.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

local spawn = {"Idle_Standing_02"}

local AttackSequences = {
	{seq = "Melee_01"},
	{seq = "Melee_02"},
	{seq = "Melee_03"},
	{seq = "Melee_04"},
}

local JumpSequences = {
	{seq = "nz_quad_traverse_mantle_36"},
}

local crawlsounds = {
}

ENT.IdleSequence = "Idle_Standing_03"
ENT.CrawlIdleSequence = "Idle_Crouching_01"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"Walk_Upper_Knife",
			},
			CrawlMovementSequence = {
				"Crouch_Walk_Upper_KNIFE",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			MovementSequence = {
				"Run_Upper_Knife",
			},
			CrawlMovementSequence = {
				"Crouch_Walk_Upper_KNIFE",
				"crouchWalkN_raw",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
		},
	}}
}


ENT.DeathSounds = {
	"cpthazama/hunter/voice/death/hunter_death_02.wav",
	"cpthazama/hunter/voice/death/hunter_death_04.wav",
	"cpthazama/hunter/voice/death/hunter_death_06.wav",
	"cpthazama/hunter/voice/death/hunter_death_07.wav",
	"cpthazama/hunter/voice/death/hunter_death_08.wav",
}

ENT.AttackSounds = {
	"cpthazama/hunter/voice/attack/hunter_shred_01.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_02.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_03.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_04.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_05.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_06.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_07.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_08.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_09.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_10.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_11.wav",
	"cpthazama/hunter/voice/attack/hunter_shred_12.wav",
}

ENT.CrawlSounds = {
	"cpthazama/hunter/voice/idle/hunter_stalk_01.wav",
	"cpthazama/hunter/voice/idle/hunter_stalk_04.wav",
	"cpthazama/hunter/voice/idle/hunter_stalk_05.wav",
	"cpthazama/hunter/voice/idle/hunter_stalk_06.wav",
	"cpthazama/hunter/voice/idle/hunter_stalk_07.wav",
	"cpthazama/hunter/voice/idle/hunter_stalk_08.wav",
	"cpthazama/hunter/voice/idle/hunter_stalk_09.wav",
}

ENT.AlertSounds = {
	"cpthazama/hunter/voice/alert/hunter_alert_01.wav",
	"cpthazama/hunter/voice/alert/hunter_alert_02.wav",
	"cpthazama/hunter/voice/alert/hunter_alert_03.wav",
	"cpthazama/hunter/voice/alert/hunter_alert_04.wav",
	"cpthazama/hunter/voice/alert/hunter_alert_05.wav",
}

ENT.WarnSounds = {
	"cpthazama/hunter/voice/warn/hunter_warn_10.wav",
	"cpthazama/hunter/voice/warn/hunter_warn_14.wav",
	"cpthazama/hunter/voice/warn/hunter_warn_16.wav",
	"cpthazama/hunter/voice/warn/hunter_warn_17.wav",
	"cpthazama/hunter/voice/warn/hunter_warn_18.wav",
}

ENT.LungeSounds = {
	"cpthazama/hunter/voice/attack/hunter_attackmix_01.wav",
	"cpthazama/hunter/voice/attack/hunter_attackmix_02.wav",
	"cpthazama/hunter/voice/attack/hunter_attackmix_03.wav",
	"cpthazama/hunter/voice/attack/shriek_1.wav",
}

ENT.BacteriaSounds = {
	"cpthazama/bacteria/hunterbacteria.wav",
	"cpthazama/bacteria/hunterbacterias.wav",
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		self:SetMooSpecial(true)
		if nzRound:GetNumber() == -1 then
			self:SetRunSpeed( math.random(20, 105) )
			self:SetHealth( math.random(100, 1500) )
		else
			local speeds = nzRound:GetZombieSpeeds()
			if speeds then
				self:SetRunSpeed( nzMisc.WeightedRandom(speeds) )
			else
				self:SetRunSpeed( 100 )
			end
			self:SetHealth( nzRound:GetZombieHealth() or 75 )
		end

		self.Crawling = false
		self.CrawlSoundTime = 1

		self.JumpCooldown = CurTime() + 3
		self.Lunging = false

		self.AirTick = 0
		self.TotalAirTime = 0

		self.TryHide = false
		self.Stealth = false
		self.LastHide = CurTime() + 1

		self:SetGravity(15)
	end
end

function ENT:OnSpawn()

	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)
	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
	effectData:SetMagnitude( 1 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)
	
	self:EmitSound(self.AlertSounds[math.random(#self.AlertSounds)], 577, 100, 1, 2)
	self:EmitSound(self.BacteriaSounds[math.random(#self.BacteriaSounds)], 577)

	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end

end

function ENT:PerformDeath(dmginfo)
	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)

	if self.DeathSounds then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	end
	self:BecomeRagdoll(dmginfo)
end

function ENT:AI()

	if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then

		-- Growl Sounds
		if self.Crawling and CurTime() > self.CrawlSoundTime then
			if !self:IsAttackBlocked() and self:TargetInRange(500) then
				self:EmitSound(self.WarnSounds[math.random(#self.WarnSounds)], 577, 100, 1, 2)
			else
				self:PlaySound(self.CrawlSounds[math.random(#self.CrawlSounds)], 90, math.random(85, 105), 1, 2)
			end
			self.CrawlSoundTime = CurTime() + math.random(3,5)
		end

		-- Lunge
		if self.Crawling and self:TargetInRange(500) then
			if self:IsAttackBlocked() then return end
			if CurTime() > self.JumpCooldown then
				self:HunterJump()	
			end
		end

		-- Flee
		if CurTime() > self.LastHide and !self.TryHide and !self:IsAttackBlocked() then
			if self.Crawling then return end
			if self:GetSpecialAnimation() then return end
			self.LastHide = CurTime() + 5
			if math.random(5) > 3 then
				self.TryHide = true
				self.Crawling = false
			else
				self.TryHide = false
			end
		end
		if self.TryHide then
			local nav = navmesh.GetNavArea(self:GetPos(), 15)
			if IsValid(nav) then
				local hidingspots = nav:GetHidingSpots(1)
				local spot = hidingspots[math.random(#hidingspots)]
				if isvector(spot) then
					if self:GetPos():DistToSqr(spot) > 350^2 then
						return
					end
					self:ResetMovementSequence()
					self:MoveToPos(spot, {
						lookahead = 75,
						tolerance = 25,
						draw = true,
						maxage = 3,
						repath = 1,
					})
				else
					self:FleeTarget(1)
				end
				self.TryHide = false
			end
		end

		-- Crouch
		if (self:TargetInRange(525) and !self:TargetInRange(100) or self.Stealth) and (!self:IsAttackBlocked() and !self.TryHide and CurTime() > self.JumpCooldown) then
			if !self.Crawling then
				if math.random(100) > 25 then
					self.Crawling = true
				end
			end
		else
			self.Crawling = false
		end
	end
end

function ENT:HunterJump()
	local target = self:GetTarget()

	self:SetAttacking(true)
	self.Lunging = true

	self:EmitSound(self.LungeSounds[math.random(#self.LungeSounds)], 577, 100, 1, 2)
	self:EmitSound("cpthazama/hunter/attack/lunge_"..math.random(3)..".wav", 90)

	self:FaceTowards(target)	
	self.loco:Jump()

	ParticleEffect("hunter_leap_dust",self:GetPos(),self:GetAngles())
    self:TimedEvent( 0.2, function() self.loco:SetVelocity(((target:GetPos() + target:OBBCenter()) - (self:GetPos() + self:OBBCenter())):GetNormalized() * 1000 + self:GetUp() * 250) end)
end

function ENT:OnLandOnGroundZombie() 
	if self.Lunging then
		self.Lunging = false
		self.Crawling = false
		self:SetAttacking(false)
		self.JumpCooldown = CurTime() + 5
	end
end

function ENT:PerformIdle()
	if self:GetSpecialAnimation() then return end
	if self.Crawling then
		self:ResetSequence(self.CrawlIdleSequence)
	else
		self:ResetSequence(self.IdleSequence)
		if !self.IsIdle and !IsValid(self:GetTarget()) then
			self.IsIdle = true
		end
	end
end

function ENT:ResetMovementSequence()
	if self.Crawling then
		self:ResetSequence(self.CrawlMovementSequence)
		self.CurrentSeq = self.CrawlMovementSequence
	else
		self:ResetSequence(self.MovementSequence)
		self.CurrentSeq = self.MovementSequence
	end
	if self.UpdateSeq ~= self.CurrentSeq then -- Moo Mark 4/19/23: Finally got a system where the speed actively updates when the movement sequence set is changed.
		--print("update")
		self.UpdateSeq = self.CurrentSeq
		self:UpdateMovementSpeed()
	end
end