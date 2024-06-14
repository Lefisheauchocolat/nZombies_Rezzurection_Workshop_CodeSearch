AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "friendly neighbourhood werewolf"
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

ENT.AttackRange = 150
ENT.DamageRange = 150
ENT.AttackDamage = 1

ENT.Models = {
	{Model = "models/cpthazama/werewolf/werewolf.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_hulk_victory_2"}

ENT.DeathSequences = {
	"nz_hulk_death_1",
	"nz_hulk_death_2"
}

ENT.IdleSequence = "nz_hulk_idle"

ENT.BarricadeTearSequences = {
	"nz_hulk_attack_stand"
}

local SlowClimbUp36 = {
	"nz_hulk_traverse_climbup38"
}
local SlowClimbUp48 = {
	"nz_hulk_traverse_climbup50"
}
local SlowClimbUp72 = {
	"nz_hulk_traverse_climbup70"
}
local SlowClimbUp96 = {
	"nz_hulk_traverse_climbup115"
}
local SlowClimbUp128 = {
	"nz_hulk_traverse_climbup130"
}
local SlowClimbUp160 = {
	"nz_hulk_traverse_climbup150"
}

local AttackSequences = {
	{seq = "nz_hulk_attack_stand"},
}

local RunAttackSequences = {
	{seq = "nz_hulk_attack"},
}

local JumpSequences = {
	{seq = "nz_hulk_traverse"},
}

ENT.RockThrowSequences = {
	"nz_hulk_rockthrow_1",
	"nz_hulk_rockthrow_2",
	"nz_hulk_rockthrow_3",
}

ENT.VictorySequences = {
	"nz_hulk_victory_1",
	"nz_hulk_victory_2",
	"nz_hulk_victory_3",
	"nz_hulk_victory_4",
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_hulk_walk",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},

			PassiveSounds = {walksounds},
		}
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnrun},
			MovementSequence = {
				"nz_hulk_run_1",
				--"nz_hulk_run_2",
			},
			SpawnSequence = {spawn},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},

			PassiveSounds = {runsounds},
		}
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_hulk_run_angry",
			},
			SpawnSequence = {spawn},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},

			PassiveSounds = {runsounds},
		}
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/werewolf/zombiedog_death1.wav",
	"wavy_zombie/werewolf/zombiedog_death2.wav",
}

ENT.AttackSounds = {
	"wavy_zombie/werewolf/zombiedog_attack1.wav",
	"wavy_zombie/werewolf/zombiedog_attack2.wav",
	"wavy_zombie/werewolf/zombiedog_attack3.wav",
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/hulk/tank_walk01.wav",
	"wavy_zombie/hulk/tank_walk02.wav",
	"wavy_zombie/hulk/tank_walk03.wav",
	"wavy_zombie/hulk/tank_walk04.wav",
	"wavy_zombie/hulk/tank_walk05.wav",
	"wavy_zombie/hulk/tank_walk06.wav",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/hulk/tank_walk01.wav",
	"wavy_zombie/hulk/tank_walk02.wav",
	"wavy_zombie/hulk/tank_walk03.wav",
	"wavy_zombie/hulk/tank_walk04.wav",
	"wavy_zombie/hulk/tank_walk05.wav",
	"wavy_zombie/hulk/tank_walk06.wav",
}

ENT.RockThrowSounds = {
	"wavy_zombie/hulk/tank_throw_01.wav",	
	"wavy_zombie/hulk/tank_throw_02.wav",
	"wavy_zombie/hulk/tank_throw_03.wav",
	"wavy_zombie/hulk/tank_throw_04.wav",
	"wavy_zombie/hulk/tank_throw_05.wav",
	"wavy_zombie/hulk/tank_throw_06.wav",
	"wavy_zombie/hulk/tank_throw_09.wav",
	"wavy_zombie/hulk/tank_throw_10.wav",
	"wavy_zombie/hulk/tank_throw_11.wav",
}

ENT.BehindSoundDistance = 1 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		local data = nzRound:GetBossData(self.NZBossType)
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(1000)
			self:SetMaxHealth(1000)
		else
			self:SetHealth(100000)
			self:SetMaxHealth(100000)
		end
		--self:SetRunSpeed(nzRound:GetNumber() >= 30 and 155 or 71) -- could be useful later, but the tanks supersprint is so fast he constantly times out lol
		self:SetRunSpeed(71)
		--self:SetBodygroup(0,0)
		self:SetCollisionBounds(Vector(-21,-21, 0), Vector(21, 21, 75))
		self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
		
		self.SmashCooldown = CurTime() + 2
		self.CanSmash = false
		self.Smashing = false
		self.WerewolfGoByeBye = CurTime() + 25
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
	self:EmitSound("wavy_zombie/werewolf/howl.wav",511)
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Close")
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Flash")
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Snap")
	ParticleEffect("driese_tp_arrival_phase2", self:WorldSpaceCenter(), angle_zero)

	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if attacker:IsPlayer() then
		dmginfo:ScaleDamage(0)
	end
end

function ENT:OnRemove()
	ParticleEffect("driese_tp_arrival_phase2", self:WorldSpaceCenter(), angle_zero)
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Close")
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Flash")
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Snap")
	self:EmitSound(self.DeathSounds[math.random(#self.DeathSounds)], 100)
end

function ENT:OnThink()	
	if SERVER then
		if self.WerewolfGoByeBye < CurTime() then
			self:Remove()
		end
	end
end

function ENT:AdditionalZombieStuff ()
	if self:GetSpecialAnimation() then return end
	if CurTime() > self.SmashCooldown and !self.CanSmash then
		self.CanSmash = true
	end
	if self:TargetInRange(250) and !self:IsAttackBlocked() and self.CanSmash then
		self:HulkSmash()
	end
	if self.loco:GetVelocity():Length2D() < 75 then
        self:TraversalCheck()
    end
end

function ENT:HulkSmash()
	self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(95, 105), 1, 2)
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Smashing = true
		self:PlaySequenceAndMove("nz_hulk_attack_low_2", 1)
		self.Smashing = false
		self.CanSmash = false
		self:SetSpecialAnimation(false)
		self.SmashCooldown = CurTime() + 6
	end)
end

function ENT:DoAttackDamage() -- Moo Mark 4/14/23: Made the part that does damage during an attack its own function.
		local target = self:GetTarget()
		if IsValid(target) and target:Health() and target:Health() > 0 then -- Doesn't matter if its a player... If the zombie is targetting it, they probably wanna attack it.
			if self:IsValid(target) and (self:GetIsBusy() and self:TargetInRange( self.AttackRange + 45 ) or self:TargetInRange( self.AttackRange + 5 )) then
				local dmgInfo = DamageInfo()
				dmgInfo:SetAttacker( self )
				if self:WaterBuff() and self:BomberBuff() then
					dmgInfo:SetDamage( self.AttackDamage * 3 ) -- Moo Mark. 6/15/23: The Tri-Buff of being inflicted by a Water Cat and Nova Bomba causes them to wanna LIFE OVVA!!!
				elseif self:WaterBuff() then
					dmgInfo:SetDamage( self.AttackDamage * 2 ) 
				else
					dmgInfo:SetDamage( target:GetMaxHealth() + 666 )
				end
				dmgInfo:SetDamageType( DMG_MISSILEDEFENSE )
				dmgInfo:SetDamageForce( (target:GetPos() - self:GetPos()) * 7 + Vector( 0, 0, 64 ) )
				if self:TargetInRange( self.DamageRange ) then 
					if !IsValid(target) then return end
					target:TakeDamageInfo(dmgInfo)
					target:EmitSound( "wavy_zombie/werewolf/claw_hit_flesh_"..math.random(1,4)..".wav", SNDLVL_TALKING, math.random(95,105))
			end
		end
	end
end

function ENT:IsValidTarget( ent )
if not ent then return false end

return IsValid(ent) and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooSpecial and ent:Alive() and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		util.ScreenShake(self:GetPos(),10,10,0.2,500)
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 90)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		util.ScreenShake(self:GetPos(),10,10,0.2,800)
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 90)
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
	if e == "hulk_smash" then
		self:EmitSound("wavy_zombie/hulk/pound_victim_"..math.random(1,2)..".wav")
		ParticleEffect("bo3_panzer_landing",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
		util.ScreenShake(self:GetPos(),25,25,0.5,600)
		local util_traceline = util.TraceLine		
		local pos = self:WorldSpaceCenter()
        local tr = {
            start = pos,
            filter = self,
           	mask = MASK_NPCSOLID_BRUSHONLY
        }
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 300)) do
			if IsValid(v) and v:IsValidZombie() and v.IsMooZombie and v:Health() > 0 then
			local smashdamage = DamageInfo()
            smashdamage:SetAttacker(self)
            smashdamage:SetInflictor(self)
            smashdamage:SetDamageType(DMG_MISSILEDEFENSE)
            smashdamage:SetDamage(v:GetMaxHealth() + 666)
            v:TakeDamageInfo(smashdamage)
			end
		end
	end
	if e == "hulk_rock_tear" then
		ParticleEffect("tank_rock_throw_ground_generic",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
		local larmfx_tag = self:LookupBone("ValveBiped.debris_bone")
		self.Debris = ents.Create("nz_prop_effect_attachment")
		self.Debris:SetModel("models/props_debris/concrete_chunk01a.mdl")
		self.Debris:SetAngles( self:GetAngles() + Angle(0,90,0) )
		self.Debris:SetPos(self:GetAttachment(self:LookupAttachment("debris")).Pos)
		self.Debris:Spawn()
		self.Debris:SetParent(self)
		self.Debris:FollowBone( self, larmfx_tag )
		self:DeleteOnRemove( self.Debris )
	end
	if e == "hulk_rock_throw" then
		self.Debris:Remove()
		self:EmitSound(self.RockThrowSounds[math.random(#self.RockThrowSounds)], 511, math.random(95,105), 1, 2)
		local larmfx_tag = self:LookupBone("ValveBiped.Bip01_Spine3")
		self.Rock = ents.Create("hulk_rock")
		self.Rock:SetPos(self:GetBonePosition(larmfx_tag))
		self.Rock:SetOwner(self:GetOwner())
		self.Rock:Spawn()
		local phys = self.Rock:GetPhysicsObject()
        local target = self:GetTarget()
        if IsValid(phys) and IsValid(target) then
             phys:SetVelocity(self.Rock:getvel(target:GetPos() + Vector(0,0,15), self:EyePos(), math.Rand(0.6,0.8)))
        end
	end
end