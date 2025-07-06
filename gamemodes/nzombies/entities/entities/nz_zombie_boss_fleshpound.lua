AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Killing Floor Fleshpound"
ENT.PrintName = "Fleshpound"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "Wavy"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true

ENT.AttackRange = 100
ENT.DamageRange = 100
ENT.AttackDamage = 75

local weaktype = {
	[DMG_BLAST] = true,
}

ENT.Models = {
	{Model = "models/wavy/wavy_enemies/fleshpound/fleshpound_kf1.mdl", Skin = 0, Bodygroups = {0,0}},
}

local util_tracehull = util.TraceHull
local spawn = {"nz_fleshpound_stun"}

ENT.IdleSequence = "nz_fleshpound_idle"

ENT.BarricadeTearSequences = {
	"nz_fleshpound_stand_attack"
}

local StandAttackSequences = {
	{seq = "nz_fleshpound_stand_attack"},
}

local AttackSequences = {
	{seq = "nz_fleshpound_walk_attack1"},
	{seq = "nz_fleshpound_walk_attack2"},
	{seq = "nz_fleshpound_walk_attack3"},
}

local RunAttackSequences = {
	{seq = "nz_fleshpound_run_attack1"},
	{seq = "nz_fleshpound_run_attack2"},
	{seq = "nz_fleshpound_run_attack3"},
}

local JumpSequences = {
	{seq = "nz_fleshpound_traverse"},
}

local walksounds = {
	Sound("wavy_zombie/fleshpound/voiceidle/idle1.wav"),
	Sound("wavy_zombie/fleshpound/voiceidle/idle2.wav"),
	Sound("wavy_zombie/fleshpound/voiceidle/idle3.wav"),
	Sound("wavy_zombie/fleshpound/voiceidle/idle4.wav"),
	Sound("wavy_zombie/fleshpound/voiceidle/idle5.wav"),
	Sound("wavy_zombie/fleshpound/voiceidle/idle6.wav"),
	Sound("wavy_zombie/fleshpound/voiceidle/idle7.wav"),
	Sound("wavy_zombie/fleshpound/voiceidle/idle8.wav"),
	Sound("wavy_zombie/fleshpound/voiceidle/idle9.wav"),
}

local runsounds = {
	Sound("wavy_zombie/fleshpound/voicechase/chase1.wav"),
	Sound("wavy_zombie/fleshpound/voicechase/chase2.wav"),
	Sound("wavy_zombie/fleshpound/voicechase/chase3.wav"),
	Sound("wavy_zombie/fleshpound/voicechase/chase4.wav"),
	Sound("wavy_zombie/fleshpound/voicechase/chase5.wav"),
	Sound("wavy_zombie/fleshpound/voicechase/chase6.wav"),
	Sound("wavy_zombie/fleshpound/voicechase/chase7.wav"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_fleshpound_walk",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {StandAttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		}
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnrun},
			MovementSequence = {
				"nz_fleshpound_run",
			},
			SpawnSequence = {spawn},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {StandAttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {runsounds},
		}
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/fleshpound/voicedeath/death1.wav",
	"wavy_zombie/fleshpound/voicedeath/death2.wav",
	"wavy_zombie/fleshpound/voicedeath/death3.wav",
	"wavy_zombie/fleshpound/voicedeath/death4.wav",
	"wavy_zombie/fleshpound/voicedeath/death5.wav",
}

ENT.AttackSounds = {
	"wavy_zombie/fleshpound/voicemelee/attack1.wav",
	"wavy_zombie/fleshpound/voicemelee/attack2.wav",
	"wavy_zombie/fleshpound/voicemelee/attack3.wav",
	"wavy_zombie/fleshpound/voicemelee/attack4.wav",
	"wavy_zombie/fleshpound/voicemelee/attack5.wav",
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/fleshpound/tile1.wav",
	"wavy_zombie/fleshpound/tile2.wav",
	"wavy_zombie/fleshpound/tile3.wav",
	"wavy_zombie/fleshpound/tile4.wav",
	"wavy_zombie/fleshpound/tile5.wav",
	"wavy_zombie/fleshpound/tile6.wav",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/fleshpound/tile1.wav",
	"wavy_zombie/fleshpound/tile2.wav",
	"wavy_zombie/fleshpound/tile3.wav",
	"wavy_zombie/fleshpound/tile4.wav",
	"wavy_zombie/fleshpound/tile5.wav",
	"wavy_zombie/fleshpound/tile6.wav",
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
			self:SetHealth(500)
			self:SetMaxHealth(500)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 1000 + (1500 * count), 6500, 31500 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 1000 + (1500 * count), 6500, 31500 * count))
			else
				self:SetHealth(6500)
				self:SetMaxHealth(6500)	
			end
		end
		self:SetRunSpeed(36)
		self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 72))			-- Nextbots Collision Box(Mainly for interacting with the world.)
		self:SetSurroundingBounds(Vector(-30, -30, 0), Vector(30, 30, 95)) 	-- Nextbots Surrounding Bounds(For Hitbox detection.)
		
		self.ManIsMad = false
		self.Malding = false
		self.Calming = false
		self.AngryTimer = 0
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	--self:SetModelScale(0.95,0.00001)
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
	
	self:DebuffZombies()
	self:BecomeRagdoll(dmginfo)
	self:EmitSound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:PostTookDamage(dmginfo)
	if !self:IsAlive() then return end
	local attacker = dmginfo:GetAttacker()
	
	if IsValid(attacker) and attacker:IsPlayer() and !self.ManIsMad and !self:GetSpecialAnimation() and !self.Calming then
		if math.random(4) == 1 then
			self.ManIsMad = true
			self:PoundingTime()
		end
	end
	if weaktype[dmginfo:GetDamageType()] then
		dmginfo:ScaleDamage(3)
	end
end

function ENT:PoundingTime()
	local pos = self:GetPos()
	self:EmitSound("wavy_zombie/fleshpound/voicerage/rage"..math.random(1,4)..".wav", 500, 100, 1, 2)
	self:EmitSound("wavy_zombie/fleshpound/malletrage"..math.random(1,2)..".wav", 500)
	self:SetSkin(1)
	ParticleEffectAttach("bo2_tomahawk_ring", 4, self, 10)
	
	for k, v in pairs(ents.FindInSphere(pos, 100)) do

        if IsValid(v) and v.IsMooZombie and !v.IsMooSpecial and v:Health() > 0 then
			if !v.HasFleshBuff then
				v.HasFleshBuff = true
				v:SetRunSpeed(250)
				v.loco:SetDesiredSpeed( v:GetRunSpeed() )
				v:SpeedChanged()
				v:SetBomberBuff(true)
				v:SetWaterBuff(true)
			end
		end
			
		if v:IsValidZombie() and !v:GetSpecialAnimation() and !v.IsMooSpecial and v ~= self then
			v:PerformStun( math.Rand(1,2) )
		end
	end
	
	
	self.AngryTimer = CurTime() + math.random(15,25)
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Malding = true
		self:PlaySequenceAndMove("nz_fleshpound_rage", 1)
		self.Malding = false
		self:SetSpecialAnimation(false)
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end)
end

function ENT:DebuffZombies()
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and v.HasFleshBuff then
			v.HasFleshBuff = false
			v:SetRunSpeed(71)
			v.loco:SetDesiredSpeed( v:GetRunSpeed() )
			v:SetHealth( nzRound:GetZombieHealth() * 0.5 )
			v:SpeedChanged()
			v:SetBomberBuff(false)
			v:SetWaterBuff(false)
		end
	end
end

function ENT:AI()
	local target = self:GetTarget()
	
	if IsValid(target) and target:IsPlayer() and self:TargetInRange(900) and !self:IsAttackBlocked() and !self.ManIsMad and !self:GetSpecialAnimation() and !self.Calming then
		if math.random(10) == 1 then
			self.ManIsMad = true
			self:PoundingTime()
		end
	end
	
	if CurTime() > self.AngryTimer and self.ManIsMad and !self:GetSpecialAnimation() then
		self.ManIsMad = false
		self:CalmTime()
	end

end

function ENT:CalmTime()
	self:SetSkin(0)
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Calming = true
		self:PlaySequenceAndMove("nz_fleshpound_stun", 1)
		self.Calming = false
		self:SetSpecialAnimation(false)
		self:SetRunSpeed(1)
		self:SpeedChanged()
	end)
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		util.ScreenShake(self:GetPos(),8,8,0.2,400)
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 75)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		util.ScreenShake(self:GetPos(),8,8,0.2,600)
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 75)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
	end
	if e == "melee" then
		if self.AttackSounds then
			self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(95, 100), 1, 2)
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
	if e == "fleshpound_swing" then
		self:EmitSound("wavy_zombie/fleshpound/malletattack"..math.random(1,4)..".wav", 500)
	end
	if e == "fleshpound_spin" then
		self:EmitSound("wavy_zombie/fleshpound/malletrage"..math.random(1,2)..".wav", 500)
	end
end