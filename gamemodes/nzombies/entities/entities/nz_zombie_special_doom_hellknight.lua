AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Ripe and Pear until it's Bun."
ENT.PrintName = "Hellknight"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true
--ENT.IsMooBossZombie = true
ENT.IsMiniBoss = true

ENT.AttackRange = 110

ENT.DamageRange = 110

ENT.AttackDamage = 75

ENT.SoundDelayMin = 2
ENT.SoundDelayMax = 3

ENT.Models = {
	{Model = "models/nzr/enemies/doom_2016/monsters/hellknight.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.IdleSequence = "idle"
ENT.NoTargetIdle = "idle"

ENT.BarricadeTearSequences = {
	"meleeforward_close",
}

ENT.DeathSequences = {
	"death_1",
	"death_2",
}

ENT.RageSequences = {
	"rage_taunt_1",
	"rage_taunt_2",
	"rage_taunt_3",
	"rage_taunt_4",
}

ENT.WalkPainSequences = {
	"pain_1",
	"pain_2",
}

ENT.RunPainSequences = {
	"pain_moving_1",
	"pain_moving_2",
	"pain_moving_3",
}

ENT.SpawnSounds = {
	"nz_moo/zombies/vox/_napalm/spawn/evt/evt_napalm_zombie_spawn_00.mp3",
	"nz_moo/zombies/vox/_napalm/spawn/evt/evt_napalm_zombie_spawn_01.mp3",
	"nz_moo/zombies/vox/_napalm/spawn/evt/evt_napalm_zombie_spawn_02.mp3",
	"nz_moo/zombies/vox/_napalm/spawn/evt/evt_napalm_zombie_spawn_03.mp3",
}

ENT.SpawnVoxSounds = {
	"wavy_zombie/doom/hellknight/hellknight_spawn_1.ogg",
	"wavy_zombie/doom/hellknight/hellknight_spawn_2.ogg",
	"wavy_zombie/doom/hellknight/hellknight_spawn_3.ogg",
}

local spawn = {"spawn_teleport1","spawn_teleport2","spawn_teleport3"}

local JumpSequences = {
	{seq = "ledge_up_200"},
}

ENT.ZombieLandSequences = {
	"land", -- Will only ever be one, for easy overridding.
}

local StandAttackSequences = {
	{seq = "meleeforward_close"},
	{seq = "meleeforward_close6"},
}

local AttackSequences = {
	{seq = "meleeforward_close"},
	{seq = "meleeforward_close6"},
}

local RunAttackSequences = {
	{seq = "meleeforward3_1"},
	{seq = "meleeforward5_1"},
	{seq = "leapattack1"},
	{seq = "leapattack2"},
}

local walksounds = {
	Sound("wavy_zombie/doom/hellknight/hellknight_idle_1.ogg"),
	Sound("wavy_zombie/doom/hellknight/hellknight_idle_2.ogg"),
	Sound("wavy_zombie/doom/hellknight/hellknight_idle_3.ogg"),
}

local runsounds = {
	Sound("wavy_zombie/doom/hellknight/hellknight_combat_1.ogg"),
	Sound("wavy_zombie/doom/hellknight/hellknight_combat_2.ogg"),
	Sound("wavy_zombie/doom/hellknight/hellknight_combat_3.ogg"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"walk",
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
				"run",
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
	"wavy_zombie/doom/hellknight/hellknight_death_1.ogg",
	"wavy_zombie/doom/hellknight/hellknight_death_2.ogg",
	"wavy_zombie/doom/hellknight/hellknight_death_3.ogg",
}

ENT.AttackSounds = {
	"wavy_zombie/doom/hellknight/hellknight_melee_1.ogg",
	"wavy_zombie/doom/hellknight/hellknight_melee_2.ogg",
	"wavy_zombie/doom/hellknight/hellknight_melee_3.ogg",
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/doom/hellknight/hellknight_step_1.ogg",
	"wavy_zombie/doom/hellknight/hellknight_step_2.ogg",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/doom/hellknight/hellknight_step_1.ogg",
	"wavy_zombie/doom/hellknight/hellknight_step_2.ogg",
}

ENT.CustomAttackImpactSounds = {
	"wavy_zombie/doom/hellknight/hellknight_swipe_1.ogg",
	"wavy_zombie/doom/hellknight/hellknight_swipe_2.ogg",
	"wavy_zombie/doom/hellknight/hellknight_swipe_3.ogg",
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(10000)
			self:SetMaxHealth(10000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 600 + (600 * count), 4000, 60000))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 600 + (600 * count), 4000, 60000))
			else
				self:SetHealth(4000)
				self:SetMaxHealth(4000)	
			end
		end
		
		self:SetCollisionBounds(Vector(-15,-15, 0), Vector(15, 15, 72))			-- Nextbots Collision Box(Mainly for interacting with the world.)
		self:SetSurroundingBounds(Vector(-30, -30, 0), Vector(30, 30, 100)) 	-- Nextbots Surrounding Bounds(For Hitbox detection.)
		
		self:SetRunSpeed(1)
		
		self.Malding = false
		beginmald = false
		self.LastStun = CurTime() + 2
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()

	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)
	
	self:EmitSound("ambient/energy/weld"..math.random(2)..".wav",500,math.random(95,105))
	
	ParticleEffect( "doom_wraith_teleport", self:GetPos(), angle_zero )

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)

	self:SetNoDraw(true)
	
	self:TimeOut(1)
	
	if seq then
		self:StopParticles()
		self:SetNoDraw(false)
		
		self:EmitSound("wavy_zombie/doom/sfx_spawn_heavy.ogg", 500)
		ParticleEffect( "doom_de_spawn_big", self:GetPos(), angle_zero )

		self:PlaySound(self.SpawnVoxSounds[math.random(#self.SpawnVoxSounds)], 500, math.random(95, 105), 1, 2)
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)	

	local damagetype = dmginfo:GetDamageType()

	self.Dying = true

	self:EmitSound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)

	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
		ParticleEffectAttach( "doom_de_corpsedecay", 4, self, 9 )
	end
end

function ENT:IsValidTarget( ent )
	if !ent then return false end

	-- Turned Zombie Targetting
	if self.IsTurned then return IsValid(ent) and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooSpecial and ent:IsAlive() end
	
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:AI()

	local target = self:GetTarget()
	
	if SERVER then
		if self:Health() <= (self:GetMaxHealth()/2) and !self.Malding then
			self.Malding = true
			beginmald = true
		end
		if self.Malding and beginmald then
			beginmald = false
			self:TempBehaveThread(function(self)
			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove(self.RageSequences[math.random(#self.RageSequences)], 1, self.FaceEnemy)
			self:SetSpecialAnimation(false)			
		end)
			self:EmitSound("wavy_zombie/doom/hellknight/hellklnight_alert_"..math.random(1,3)..".ogg", 500, 100, 1, 2)
			self:SetRunSpeed(71)
			self:SpeedChanged()
		end
	end
end

function ENT:PostTookDamage(dmginfo)

	local hitpos = dmginfo:GetDamagePosition()
	local hitforce = dmginfo:GetDamageForce()
	local headpos = self:GetBonePosition(self:LookupBone("head"))

	if SERVER then
		if !self:GetSpecialAnimation() and hitforce:Length2D() > 50000 and math.random(100) > 66 and CurTime() > self.LastStun then
			if !self.Malding then
				if CurTime() > self.LastStun then
					self.LastStun = CurTime() + 5
					self:DoSpecialAnimation(self.WalkPainSequences[math.random(#self.WalkPainSequences)])
				end
			else
				if CurTime() > self.LastStun then
					self.LastStun = CurTime() + 5
					self:DoSpecialAnimation(self.RunPainSequences[math.random(#self.RunPainSequences)])
				end
			end
		end
	end
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

function ENT:CustomAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.

	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large
	
	if e == "step_left_small" then
		util.ScreenShake(self:GetPos(),8,8,0.3,300)
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 85)
		else
			self:EmitSound(self.NormalWalkFootstepsSounds[math.random(#self.NormalWalkFootstepsSounds)], 85)
		end
	end
	if e == "step_right_small" then
		util.ScreenShake(self:GetPos(),8,8,0.3,300)
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 85)
		else
			self:EmitSound(self.NormalWalkFootstepsSounds[math.random(#self.NormalWalkFootstepsSounds)], 85)
		end
	end
	if e == "step_left_large" then
		util.ScreenShake(self:GetPos(),8,8,0.3,500)
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 85)
		else
			self:EmitSound(self.NormalRunFootstepsSounds[math.random(#self.NormalRunFootstepsSounds)], 85)
		end
	end
	if e == "step_right_large" then
		util.ScreenShake(self:GetPos(),8,8,0.3,500)
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 85)
		else
			self:EmitSound(self.NormalRunFootstepsSounds[math.random(#self.NormalRunFootstepsSounds)], 85)
		end
	end
	if e == "hellknight_leap" then
		self:EmitSound("wavy_zombie/doom/hellknight/hellknight_groundpound_1.ogg", 500)
		self:EmitSound("wavy_zombie/doom/hellknight/hellknight_groundpound_2.ogg", 500)
		util.ScreenShake(self:GetPos(),15,15,1,500)
		ParticleEffectAttach( "doom_de_hellknight_groundpound", 4, self, 3 )
		--ParticleEffect("bo3_panzer_landing",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
		
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 160)) do
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
