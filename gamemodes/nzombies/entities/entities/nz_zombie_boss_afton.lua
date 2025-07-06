AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Springtrap"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

local util_tracehull = util.TraceHull

ENT.RedEyes = true
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true

ENT.AttackRange = 105
ENT.DamageRange = 105

ENT.AttackDamage = 90
ENT.HeavyAttackDamage = 150

ENT.TraversalCheckRange = 40

ENT.SoundDelayMin = 8
ENT.SoundDelayMax = 15

ENT.MinSoundPitch = 98
ENT.MaxSoundPitch = 102


ENT.Models = {
	{Model = "models/moo/_moo_ports/dbd/slashers/springtrap/moo_dbd_slasher_springtrap.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.BarricadeTearSequences = {}

local spawn = {"nz_base_slasher_springtrap_spawn"}

local StandAttackSequences = {
	{seq = "nz_base_slasher_springtrap_attack_01"},
	{seq = "nz_base_slasher_springtrap_attack_02"},
}

local AttackSequences = {
	{seq = "nz_base_slasher_springtrap_attack_01"},
	{seq = "nz_base_slasher_springtrap_attack_02"},
}

local SprintAttackSequences = {
	{seq = "nz_boss_attack_sprint"},
}

local JumpSequences = {
	{seq = "nz_base_slasher_springtrap_traverse_window"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.IdleSequence = "nz_base_slasher_springtrap_idle"
ENT.IdleSequenceAU = "nz_base_slasher_springtrap_idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_base_slasher_springtrap_walk_slow",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			MovementSequence = {
				"nz_base_slasher_springtrap_walk",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			MovementSequence = {
				"nz_base_slasher_springtrap_run",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}}
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.SWTFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_remnant/fly/footsteps/swt/step_swt_00.mp3"),
	Sound("nz_moo/zombies/vox/_remnant/fly/footsteps/swt/step_swt_01.mp3"),
	Sound("nz_moo/zombies/vox/_remnant/fly/footsteps/swt/step_swt_02.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_pyromech/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_06.mp3"),
	Sound("nz_moo/zombies/vox/_pyromech/step/step_07.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(5000)
			self:SetMaxHealth(5000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 500 + (97500 * count), 97500, 500000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 500 + (97500 * count), 97500, 500000 * count))
			else
				self:SetHealth(5000)
				self:SetMaxHealth(5000)	
			end
		end

		self:SetTargetCheckRange(60000) -- He will always know where you are.

		self:SetBodygroup(1,0)
		self:SetBodygroup(2,0)
		self:SetRunSpeed(1)
	end
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()

	self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))
	self:SetSurroundingBounds(Vector(-25, -25, 0), Vector(25, 25, 100))
	
	self:SetNoDraw(true)
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)

	self:EmitSound("nz_moo/zombies/vox/_director/_sfx/zmb_director_yellow_beam_PCM.mp3",577)
	ParticleEffect("summon_beam",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
	ParticleEffect("driese_tp_arrival_ambient",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
	ParticleEffect("driese_tp_arrival_ambient_lightning",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)

	self:TimeOut(1.5)

	self:SetInvulnerable(false)
	self:CollideWhenPossible()
	self:SetNoDraw(false)

	self:EmitSound("nz_moo/zombies/vox/_cellbreaker/slam/initial_zap_0"..math.random(0,3)..".mp3",100)
	self:EmitSound("nz_moo/zombies/vox/_cellbreaker/slam/rubble_0"..math.random(0,3)..".mp3",100,math.random(95,105))
	self:EmitSound("nz_moo/zombies/vox/_director/_sfx/zmb_director_beam_PCM.mp3", 577)
	ParticleEffect("driese_tp_arrival_phase2",self:LocalToWorld(Vector(60,-30,0)),Angle(0,0,0),nil)
	ParticleEffect("driese_tp_arrival_ambient",self:LocalToWorld(Vector(60,-30,0)),Angle(0,0,0),nil)

	self:PlaySequenceAndWait(seq)
	self:SetSpecialAnimation(false)
end

function ENT:PerformDeath(dmgInfo)
	--[[for k,v in pairs(player.GetAllPlaying()) do
		if TFA.BO3GiveAchievement then
			if !v.Quiet_on_the_set then
				TFA.BO3GiveAchievement("Quiet on the Set", "vgui/overlay/achievment/Quiet_on_the_Set_BO1.png", v)
				v.Quiet_on_the_set = true
			end
		end
	end]]

	ParticleEffect("driese_tp_arrival_ambient",self:LocalToWorld(Vector(60,-30,0)),Angle(0,0,0),nil)
	ParticleEffectAttach("bo3_thrasher_aura", 5, self, 1)

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)],577, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	self:DoDeathAnimation("nz_base_slasher_springtrap_death")
end

function ENT:AI()
end

function ENT:CustomAnimEvent(a,b,c,d,e) 
	
	self.OverrideLsmall = true
	self.OverrideLLarge = true
	self.OverrideRsmall = true
	self.OverrideRLarge = true

	if e == "spawn_roar" then
		self:EmitSound("nz_moo/zombies/vox/_remnant/robot.mp3", 511, 80)
	end

	if e == "step_left_small" then
		self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 70)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 70)

		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	if e == "step_left_large" then
		self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 70)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 70)

		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	if e == "step_right_small" then
		self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 70)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 70)

		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	if e == "step_right_large" then
		self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 70)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 70)

		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
	
end

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end