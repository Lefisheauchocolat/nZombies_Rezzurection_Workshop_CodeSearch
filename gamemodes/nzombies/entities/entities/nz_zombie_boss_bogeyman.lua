AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Silent Hill Hammer Guy"
ENT.PrintName = "The Bogeyman"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true

ENT.AttackDamage = 150
ENT.AttackRange = 90
ENT.DamageRange = 90

ENT.Models = {
	{Model = "models/wavy_ports/wavy_enemies/waw/wub_bogeyman.mdl", Skin = 0, Bodygroups = {0,0}},
}

local util_tracehull = util.TraceHull
local spawn = {"nz_bogeyman_spawn"}

local StandAttackSequences = {
	{seq = "nz_bogeyman_attack_01"},
	{seq = "nz_bogeyman_attack_02"},
}

local AttackSequences = {
	{seq = "nz_bogeyman_attack_01"},
	{seq = "nz_bogeyman_attack_02"},
}

local JumpSequences = {
	{seq = "nz_bogeyman_mantle"},
}

ENT.BarricadeTearSequences = {
	"nz_bogeyman_attack_01",
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.IdleSequence = "nz_bogeyman_idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_bogeyman_walk",
			},
			StandAttackSequences = {StandAttackSequences},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.AttackSounds = {
	"enemies/bosses/nemesis/swing1.ogg",
	"enemies/bosses/nemesis/swing2.ogg",
	"enemies/bosses/nemesis/swing3.ogg",
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/bogeyman/bogeyman_step_00.mp3",
	"wavy_zombie/bogeyman/bogeyman_step_01.mp3",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/bogeyman/bogeyman_step_00.mp3",
	"wavy_zombie/bogeyman/bogeyman_step_01.mp3",
}

ENT.CustomAttackImpactSounds = {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav",
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(1000)
			self:SetMaxHealth(1000)
		else
			self:SetHealth(12000 * count)
			self:SetMaxHealth(12000 * count)
		end
		
		self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))			-- Nextbots Collision Box(Mainly for interacting with the world.)
		self:SetSurroundingBounds(Vector(-32, -32, 0), Vector(32, 32, 90)) 	-- Nextbots Surrounding Bounds(For Hitbox detection.)
		
		self:SetRunSpeed(1)
		
	end
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)
	ParticleEffectAttach("driese_tp_arrival_phase1", 4, self, 1)
	self:EmitSound("wavy_zombie/bogeyman/bogeyman_spawnin.mp3", 500, math.random(97,100), 1, 0)
	
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmgInfo)
	self.Dying = true
	self:DoDeathAnimation("nz_bogeyman_death")
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndMove(seq)
		self:Remove(DamageInfo())
	end)
end

function ENT:DoAttackDamage() -- Moo Mark 4/14/23: Made the part that does damage during an attack its own function.
	local target = self:GetTarget()

	local damage = self.AttackDamage
	local dmgrange = self.DamageRange
	local range = self.AttackRange

	if self:GetIsBusy() and !self.BarricadeArmReach then return end

	if self:GetIsBusy() then
		range = self.AttackRange + 45
		dmgrange = self.DamageRange + 45
	else
		range = self.AttackRange + 25
	end

	if self:WaterBuff() and self:BomberBuff() then
		damage = self.AttackDamage * 3
	elseif self:WaterBuff() then
		damage = self.AttackDamage * 2
	end

	if IsValid(target) and target:Health() and target:Health() > 0 then -- Doesn't matter if its a player... If the zombie is targetting it, they probably wanna attack it.
		if self:TargetInRange( range ) then

			local dmgInfo = DamageInfo()
			dmgInfo:SetAttacker( self )
			dmgInfo:SetDamage( damage )
			dmgInfo:SetDamageType( DMG_CRUSH )
			dmgInfo:SetDamageForce( (target:GetPos() - self:GetPos()) * 7 + Vector( 0, 0, 16 ) )

			if self:TargetInRange( dmgrange ) then
				target:TakeDamageInfo(dmgInfo)
			if target:IsPlayer() then
				target:ViewPunch( VectorRand():Angle() * 0.1 )
				if target:IsOnGround() then
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 10 + Vector( 0, 120, 334 ) )
				else
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 7 + Vector( 0, 0, 64 ) )
				end
				
			end
				if comedyday or math.random(500) == 1 then
					if self.GoofyahAttackSounds then target:EmitSound(self.GoofyahAttackSounds[math.random(#self.GoofyahAttackSounds)], SNDLVL_TALKING, math.random(95,105)) end
				else
					if self.CustomAttackImpactSounds then
						target:EmitSound(self.CustomAttackImpactSounds[math.random(#self.CustomAttackImpactSounds)], SNDLVL_TALKING, math.random(95,105))
					else
						target:EmitSound(self.AttackImpactSounds[math.random(#self.AttackImpactSounds)], SNDLVL_TALKING, math.random(95,105))
					end
				end
			end
		end
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		util.ScreenShake(self:GetPos(),8,8,0.2,400)
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 80)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
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
	if e == "bogey_slam" then
		self:EmitSound("wavy_zombie/bogeyman/bogeyman_hammer_hit_0"..math.random(0,1)..".mp3", 500)
		ParticleEffect("bo3_panzer_landing",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
		ParticleEffect("bo3_astronaut_pulse_wave_3",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
		util.ScreenShake(self:GetPos(),25,25,0.5,600)
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
	        if not v:IsWorld() and v:IsSolid() then
	            v:SetVelocity(((v:GetPos() - self:GetPos()):GetNormalized()*150) + v:GetUp()*200)
	            
	            if v:IsValidZombie() and !v.IsMooSpecial then
	                if v == self then continue end
	                if v:EntIndex() == self:EntIndex() then continue end
	                if v:Health() <= 0 then continue end
	                if !v:IsAlive() then continue end

	                local seq = v.ThunderGunSequences[math.random(#v.ThunderGunSequences)]
	                if v:HasSequence(seq) then
						v:DoSpecialAnimation(seq)
					end
	            end

	            if v:IsPlayer() and v:IsOnGround() then
	            	v:SetGroundEntity(nil)
	                v:ViewPunch(Angle(-25,math.random(-10, 10),0))
					v:NZSonicBlind(1)
					local dmgInfo = DamageInfo()
					dmgInfo:SetAttacker( self )
					dmgInfo:SetDamage( 75 )
					dmgInfo:SetDamageType( DMG_CRUSH )
					dmgInfo:SetDamageForce( (v:GetPos() - self:GetPos()) * 7 + Vector( 0, 0, 16 ) )
					v:TakeDamageInfo(dmgInfo)
	            end
	        end
	    end
	end
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end