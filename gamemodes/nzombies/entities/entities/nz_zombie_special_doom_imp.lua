AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "simp"
ENT.PrintName = "Imp"
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

ENT.AttackRange = 80

ENT.DamageRange = 80

ENT.SoundDelayMin = 2
ENT.SoundDelayMax = 3

ENT.Models = {
	{Model = "models/nzr/enemies/doom_2016/monsters/imp.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.IdleSequence = "idle"
ENT.NoTargetIdle = "idle"

ENT.BarricadeTearSequences = {
	"melee_forward_1",
}

ENT.DeathSequences = {
	"death_head_1",
	"death_head_2",
	"death_head_3",
}

ENT.ImpPainSequences = {
	"pain_1",
	"pain_2",
	"pain_3",
	"pain_4",
}

ENT.FireballThrowSequences = {
	"throw_1",
	"throw_2",
	--"run_forward_throw", --this one is bugged for some reason
	"throw_charge_1",
	"throw_charge_2",
	"step_left_throw",
	"step_right_throw",
}

ENT.SpawnVoxSounds = {
	"wavy_zombie/doom/imp/imp_spawn_1.ogg",
	"wavy_zombie/doom/imp/imp_spawn_2.ogg",
	"wavy_zombie/doom/imp/imp_spawn_3.ogg",
}

local spawn = {"spawn_teleport_1","spawn_teleport_2","spawn_teleport_3","spawn_teleport_4"}

local JumpSequences = {
	{seq = "ledge_up_200"},
}

ENT.ZombieLandSequences = {
	"land", -- Will only ever be one, for easy overridding.
}

local StandAttackSequences = {
	{seq = "melee_forward_1"},
	{seq = "melee_forward_2"},
}

local AttackSequences = {
	{seq = "melee_forward_1"},
	{seq = "melee_forward_2"},
}

local RunAttackSequences = {
	{seq = "melee_forward_moving_1"},
	{seq = "melee_forward_moving_2"},
}

local walksounds = {
	Sound("wavy_zombie/doom/imp/imp_idle_1.ogg"),
	Sound("wavy_zombie/doom/imp/imp_idle_2.ogg"),
	Sound("wavy_zombie/doom/imp/imp_idle_3.ogg"),
	Sound("wavy_zombie/doom/imp/imp_idle_4.ogg"),
}

local runsounds = {
	Sound("wavy_zombie/doom/imp/imp_combat_1.ogg"),
	Sound("wavy_zombie/doom/imp/imp_combat_2.ogg"),
	Sound("wavy_zombie/doom/imp/imp_combat_3.ogg"),
	Sound("wavy_zombie/doom/imp/imp_combat_4.ogg"),
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
	"wavy_zombie/doom/imp/imp_death_1.ogg",
	"wavy_zombie/doom/imp/imp_death_2.ogg",
	"wavy_zombie/doom/imp/imp_death_3.ogg",
}

ENT.AttackSounds = {
	"wavy_zombie/doom/imp/imp_attack_melee_1.ogg",
	"wavy_zombie/doom/imp/imp_attack_melee_2.ogg",
	"wavy_zombie/doom/imp/imp_attack_melee_3.ogg",
	"wavy_zombie/doom/imp/imp_attack_melee_4.ogg",
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/doom/imp/imp_footstep_01.ogg",
	"wavy_zombie/doom/imp/imp_footstep_02.ogg",
	"wavy_zombie/doom/imp/imp_footstep_03.ogg",
	"wavy_zombie/doom/imp/imp_footstep_04.ogg",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/doom/imp/imp_footstep_01.ogg",
	"wavy_zombie/doom/imp/imp_footstep_02.ogg",
	"wavy_zombie/doom/imp/imp_footstep_03.ogg",
	"wavy_zombie/doom/imp/imp_footstep_04.ogg",
}

ENT.CustomAttackImpactSounds = {
	"wavy_zombie/doom/demon_melee_1.ogg",
	"wavy_zombie/doom/demon_melee_2.ogg",
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(300)
			self:SetMaxHealth(300)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(nzRound:GetZombieHealth() * 2 + (300 * count))
				self:SetMaxHealth(nzRound:GetZombieHealth() * 2 + (300 * count))
			else
				self:SetHealth(1000)
				self:SetMaxHealth(1000)	
			end
		end
		
		self:SetRunSpeed(71)
		self.ThrowingFireball = false
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
		
		self:EmitSound("wavy_zombie/doom/sfx_spawn_"..math.random(1,2)..".ogg", 500)
		ParticleEffect( "doom_de_spawn_medium", self:GetPos(), angle_zero )

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

	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM or damagetype == DMG_BLAST then
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
		if IsValid(target) and target:IsPlayer() and !self:TargetInRange(250) and self:TargetInRange(1250) and !self:IsAttackBlocked() and !self:GetSpecialAnimation() then
			self:ImpFireball()
		end
	end
end

function ENT:PostTookDamage(dmginfo)

	local hitforce = dmginfo:GetDamageForce()

	if SERVER then
		if !self:GetSpecialAnimation() and hitforce:Length2D() > 50000 and math.random(100) > 66 and CurTime() > self.LastStun then
			if CurTime() > self.LastStun then
				self.LastStun = CurTime() + 5
				self:DoSpecialAnimation(self.ImpPainSequences[math.random(#self.ImpPainSequences)])
			end
		end
	end
end

function ENT:ImpFireball()
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.ThrowingFireball = true
		self:PlaySequenceAndMove(self.FireballThrowSequences[math.random(#self.FireballThrowSequences)], 1, self.FaceEnemy)
		self.ThrowingFireball = false
		self:SetSpecialAnimation(false)
	end)
end

function ENT:CustomAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.

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
	if e == "imp_fireball_r" then
		self:EmitSound("wavy_zombie/doom/imp/imp_throw_"..math.random(1,3)..".ogg", 400)
		local tr = util.TraceLine({
			start = self:GetPos() + Vector(0,50,0),
			endpos = self:GetTarget():GetPos() + Vector(0,0,50),
			filter = self,
			ignoreworld = true,
		})	
		local righthand = self:LookupBone("righthand")
		if IsValid(tr.Entity) then
		self.Fireball = ents.Create("imp_fireball")
		self.Fireball:SetPos(self:GetBonePosition(righthand))
		self.Fireball:SetOwner(self:GetOwner())
		self.Fireball:Spawn()
		self.Fireball:Launch(((tr.Entity:GetPos() + Vector(0,0,50)) - self.Fireball:GetPos()):GetNormalized())
		end
	end
	if e == "imp_fireball_l" then
		self:EmitSound("wavy_zombie/doom/imp/imp_throw_"..math.random(1,3)..".ogg", 400)
		local tr = util.TraceLine({
			start = self:GetPos() + Vector(0,50,0),
			endpos = self:GetTarget():GetPos() + Vector(0,0,50),
			filter = self,
			ignoreworld = true,
		})	
		local lefthand = self:LookupBone("lefthand")
		if IsValid(tr.Entity) then
		self.Fireball = ents.Create("imp_fireball")
		self.Fireball:SetPos(self:GetBonePosition(lefthand))
		self.Fireball:SetOwner(self:GetOwner())
		self.Fireball:Spawn()
		self.Fireball:Launch(((tr.Entity:GetPos() + Vector(0,0,50)) - self.Fireball:GetPos()):GetNormalized())
		end
	end
	if e == "imp_big_fireball_l" then
		self:EmitSound("wavy_zombie/doom/imp/imp_throw_"..math.random(1,3)..".ogg", 400)
		local lefthand = self:GetBonePosition(self:LookupBone("lefthand"))
		local target = self:GetTarget()

		if IsValid(target) then
			self.ZapShot = ents.Create("imp_fireball_big")
			self.ZapShot:SetPos(lefthand)
			self.ZapShot:SetAngles((target:GetPos() - self:GetPos()):Angle())
			self.ZapShot:Spawn()
			self.ZapShot:SetVictim(target)
		end
		
		self:Retarget()
	end
	if e == "imp_big_fireball_r" then
		self:EmitSound("wavy_zombie/doom/imp/imp_throw_"..math.random(1,3)..".ogg", 400)
		local righthand = self:GetBonePosition(self:LookupBone("righthand"))
		local target = self:GetTarget()

		if IsValid(target) then
			self.ZapShot = ents.Create("imp_fireball_big")
			self.ZapShot:SetPos(righthand)
			self.ZapShot:SetAngles((target:GetPos() - self:GetPos()):Angle())
			self.ZapShot:Spawn()
			self.ZapShot:SetVictim(target)
		end
		self:Retarget()
	end
	if e == "imp_charge_sfx" then
		self:EmitSound("wavy_zombie/doom/imp/imp_charge.ogg", 500)
	end
end
