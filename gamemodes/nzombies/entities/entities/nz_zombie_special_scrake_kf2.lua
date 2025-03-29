AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Killing Floor Scrake FOR REAL ACTUAL"
ENT.PrintName = "Scrake"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

if CLIENT then 
	function ENT:Draw()
		self:DrawModel()
		self:PostDraw()
	end
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end
	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !IsValid(self.Draw_FX)) then
				self:EmitSound("wavy_zombie/kf2_scrake/scrake_chainsaw_idle.wav", 80, math.random(95, 105), 1, 3)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true
--ENT.IsMooBossZombie = true
ENT.IsMiniBoss = true

ENT.AttackRange = 90

ENT.DamageRange = 90

ENT.AttackDamage = 100

ENT.SoundDelayMin = 2
ENT.SoundDelayMax = 3

ENT.Models = {
	{Model = "models/wavy_ports/wavy_enemies/waw/kf2_scrake.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.IdleSequence = "nz_scrake_idle"
ENT.NoTargetIdle = "nz_scrake_idle"

ENT.BarricadeTearSequences = {
	"nz_scrake_attack_stand_01",
}

local spawn = {"land"}

local JumpSequences = {
	{seq = "nz_scrake_mantle"},
}

ENT.ZombieLandSequences = {
	"land", -- Will only ever be one, for easy overridding.
}

local StandAttackSequences = {
	{seq = "nz_scrake_attack_stand_01"},
	{seq = "nz_scrake_attack_stand_02"},
	{seq = "nz_scrake_attack_stand_03"},
}

local AttackSequences = {
	{seq = "nz_scrake_attack_stand_01"},
	{seq = "nz_scrake_attack_stand_02"},
	{seq = "nz_scrake_attack_stand_03"},
}

local RunAttackSequences = {
	{seq = "nz_scrake_attack_lunge_01"},
	{seq = "nz_scrake_attack_lunge_02"},
	{seq = "nz_scrake_attack_lunge_03"},
	{seq = "nz_scrake_attack_lunge_04"},
}

local walksounds = {
	Sound("wavy_zombie/kf2_scrake/scrake_vox_ambient_00.mp3"),
	Sound("wavy_zombie/kf2_scrake/scrake_vox_ambient_01.mp3"),
	Sound("wavy_zombie/kf2_scrake/scrake_vox_ambient_02.mp3"),
	Sound("wavy_zombie/kf2_scrake/scrake_vox_ambient_03.mp3"),
	Sound("wavy_zombie/kf2_scrake/scrake_vox_ambient_04.mp3"),
	Sound("wavy_zombie/kf2_scrake/scrake_vox_ambient_05.mp3"),
}

local runsounds = {
	Sound("wavy_zombie/kf2_scrake/scrake_vox_enrage_00.mp3"),
	Sound("wavy_zombie/kf2_scrake/scrake_vox_enrage_01.mp3"),
	Sound("wavy_zombie/kf2_scrake/scrake_vox_enrage_02.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_scrake_walk",
				"nz_scrake_walk_taunt",
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
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_scrake_run",
			},
			SpawnSequence = {spawn},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {StandAttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {runsounds},
		},
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/kf2_scrake/scrake_vox_death_00.mp3",
	"wavy_zombie/kf2_scrake/scrake_vox_death_01.mp3",
	"wavy_zombie/kf2_scrake/scrake_vox_death_02.mp3",
}

ENT.AttackSounds = {
	"wavy_zombie/kf2_scrake/scrake_vox_attack_00.mp3",
	"wavy_zombie/kf2_scrake/scrake_vox_attack_01.mp3",
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/kf2_scrake/scrake_step_00.mp3",
	"wavy_zombie/kf2_scrake/scrake_step_01.mp3",
	"wavy_zombie/kf2_scrake/scrake_step_02.mp3",
	"wavy_zombie/kf2_scrake/scrake_step_03.mp3",
	"wavy_zombie/kf2_scrake/scrake_step_04.mp3",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/kf2_scrake/scrake_step_00.mp3",
	"wavy_zombie/kf2_scrake/scrake_step_01.mp3",
	"wavy_zombie/kf2_scrake/scrake_step_02.mp3",
	"wavy_zombie/kf2_scrake/scrake_step_03.mp3",
	"wavy_zombie/kf2_scrake/scrake_step_04.mp3",
}

ENT.CustomAttackImpactSounds = {
	"wavy_zombie/fleshpound/stronghit1.wav",
	"wavy_zombie/fleshpound/stronghit2.wav",
	"wavy_zombie/fleshpound/stronghit3.wav",
	"wavy_zombie/fleshpound/stronghit4.wav",
	"wavy_zombie/fleshpound/stronghit5.wav",
	"wavy_zombie/fleshpound/stronghit6.wav",
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(600)
			self:SetMaxHealth(600)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 600, 3000, 30000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 600, 3000, 30000 * count))
			else
				self:SetHealth(3000)
				self:SetMaxHealth(3000)	
			end
		end
		
		self:SetCollisionBounds(Vector(-15,-15, 0), Vector(15, 15, 72))			-- Nextbots Collision Box(Mainly for interacting with the world.)
		self:SetSurroundingBounds(Vector(-28, -28, 0), Vector(28, 28, 90)) 	-- Nextbots Surrounding Bounds(For Hitbox detection.)
		
		self:SetRunSpeed(1)
		
		self.Malding = false
		beginmald = false
	end
end

function ENT:SpecialInit()
	if CLIENT then
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
	
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)	
	self.Dying = true

	self:EmitSound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)
	self:StopSound("wavy_zombie/kf2_scrake/scrake_chainsaw_idle.wav")
	ParticleEffect("grenade_explosion_01", self:WorldSpaceCenter(), angle_zero)
	ParticleEffect("bo3_annihilator_blood", self:WorldSpaceCenter(), angle_zero)
	self:EmitSound("TFA_BO3_GRENADE.Dist")
	self:EmitSound("TFA_BO3_GRENADE.Exp")
	self:EmitSound("TFA_BO3_GENERIC.Gib")
	self:EmitSound("TFA_BO3_ANNIHILATOR.Exp")
	self:Remove(dmginfo)
end

function ENT:OnRemove()
	self:StopSound("wavy_zombie/kf2_scrake/scrake_chainsaw_idle.wav")
end

function ENT:IsValidTarget( ent )
	if !ent then return false end

	-- Turned Zombie Targetting
	if self.IsTurned then return IsValid(ent) and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooSpecial and ent:IsAlive() end
	
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

--[[function ENT:PostAdditionalZombieStuff()
	if SERVER then
	if self:Health() <= (self:GetMaxHealth()/2) and !self.Malding then
		self.Malding = true
		beginmald = true
	end
	if self.Malding and beginmald then
		beginmald = false
		self:EmitSound("wavy_zombie/chainsaw/scream"..math.random(1,4)..".mp3", 500, 100, 1, 2)
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end
end
end]]

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()	
	if SERVER then
		if IsValid(attacker) and attacker:IsPlayer() and !self.Malding then
			if math.random(5) == 1 then
				self.Malding = true
				beginmald = true
				self:EmitSound("wavy_zombie/kf2_scrake/scrake_vox_lunge_attack_0"..math.random(0,4)..".mp3", 500, 100, 1, 2)
				self:SetRunSpeed(71)
				self:SpeedChanged()
			end
		end
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 70)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 70)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
	end
	if e == "melee" then
		if self.AttackSounds then
			self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		end
		self:DoAttackDamage()
	end
	if e == "death_ragdoll" then
		self:BecomeRagdoll(DamageInfo())
	end
	if e == "start_traverse" then
		--print("starttraverse")
		self.TraversalAnim = true
	end
	if e == "finish_traverse" then
		--print("finishtraverse")
		self.TraversalAnim = false
	end
	if e == "scrake_swing" then
		self:EmitSound("wavy_zombie/kf2_scrake/scrake_chainsaw_rev_0"..math.random(0,2)..".mp3", 400)
	end
end
