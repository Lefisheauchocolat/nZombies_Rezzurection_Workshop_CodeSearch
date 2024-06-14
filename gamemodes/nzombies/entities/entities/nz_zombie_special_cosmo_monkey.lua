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

ENT.AttackRange = 65
ENT.DamageRange = 65

ENT.AttackDamage = 30
ENT.HeavyAttackDamage = 50

ENT.Models = {
	{Model = "models/moo/_codz_ports/t5/cosmo/moo_codz_t5_cosmo_monkey.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.DeathSequences = {
	"nz_monkey_death_01",
	"nz_monkey_death_02",
	"nz_monkey_death_03",
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
	"nz_monkey_attack_06",
	"nz_monkey_attack_07",
}

local SpawnSequences = {"nz_monkey_taunt_02"}

local AttackSequences = {
	{seq = "nz_monkey_attack_01"},
	{seq = "nz_monkey_attack_02"},
	{seq = "nz_monkey_attack_03"},
	{seq = "nz_monkey_attack_04"},
	{seq = "nz_monkey_attack_05"},
	{seq = "nz_monkey_attack_06"},
	{seq = "nz_monkey_attack_07"},
}

local JumpSequences = {
	{seq = "nz_monkey_portal_jump_01"},
}

local walksounds = {
	--Sound("nz_moo/zombies/vox/_quad/amb/amb_00.mp3"),
}

ENT.IdleSequence = "nz_monkey_idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_monkey_run_01",
				"nz_monkey_run_02",
			},
			SpawnSequence = {SpawnSequences},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			MovementSequence = {
				"nz_monkey_sprint_01",
				"nz_monkey_sprint_02",
				"nz_monkey_sprint_03",
				"nz_monkey_sprint_04",
			},
			SpawnSequence = {SpawnSequences},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.DeathSounds = {
	"nz_moo/zombies/vox/_quad/death/death_00.mp3",
}

ENT.AttackSounds = {
	"nz_moo/zombies/vox/_quad/attack/attack_00.mp3",
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
	end
end

function ENT:OnSpawn()
	
	--if IsValid(self) then ParticleEffectAttach("novagas_trail", 4, self, 2) end
	--self:EmitSound("nz_moo/zombies/vox/_quad/spawn/spawn_0"..math.random(3)..".mp3", 511, math.random(95, 105), 1, 2)

	self:SetCollisionBounds(Vector(-12,-12, 0), Vector(12, 12, 26))

	self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

	self:SetSpecialAnimation(true)
	self:SetIsBusy(true)
	self:SetNoDraw(false)

	local seq = self:SelectSpawnSequence()

	ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
	self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))

	if seq then
		self:PlaySequenceAndMove(seq, {gravity = true})
		self:SetSpecialAnimation(false)
		self:SetIsBusy(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)
	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)

	if damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo) -- Only Thundergun and Wavegun Ragdolls constantly.
	end
	if damagetype == DMG_REMOVENORAGDOLL then
		self:Remove(dmginfo)
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() then
		if self.DeathSounds then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		end
		self:BecomeRagdoll(dmginfo)
	else
		if self:RagdollForceTest(dmginfo:GetDamageForce()) then
			if self.DeathSounds then
				self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			end
			self:BecomeRagdoll(dmginfo)
		else
			if self.DeathSounds then
				self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			end
			self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
		end
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 65)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 65)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
	end
	if e == "crawl_hand" then
		if self.CustomCrawlImpactSounds then
			self:EmitSound(self.CrawlImpactSounds[math.random(#self.CrawlImpactSounds)], 70)
		else
			self:EmitSound("CoDZ_Zombie.StepCrawl")
		end
	end
	if e == "melee" or e == "melee_heavy" then
		if self:BomberBuff() and self.GasAttack then
			self:EmitSound(self.GasAttack[math.random(#self.GasAttack)], 100, math.random(95, 105), 1, 2)
		else
			if self.AttackSounds then
				self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
			end
		end
		if e == "melee_heavy" then
			self.HeavyAttack = true
		else
			self.HeavyAttack = false
		end
		self:DoAttackDamage()
	end
	if e == "monkey_mario" then
		if math.random(50) == 1 then
			self:EmitSound("nz_moo/effects/mario_jump.mp3", 100)
		end
	end
	if e == "generic_taunt" then
		if self.TauntSounds then
			self:EmitSound(self.TauntSounds[math.random(#self.TauntSounds)], 100, math.random(85, 105), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "special_taunt" then
		if self.TauntSounds then
			self:EmitSound("nz_moo/zombies/vox/_classic/taunt/spec_taunt.mp3", 100, math.random(85, 105), 1, 2)
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end
	if e == "base_ranged_rip" then
		ParticleEffectAttach("ins_blood_dismember_limb", 4, self, 5)
		self:EmitSound("nz_moo/zombies/gibs/gib_0"..math.random(0,3)..".mp3", 100, math.random(95,105))
		self:EmitSound("nz_moo/zombies/gibs/head/head_explosion_0"..math.random(4)..".mp3", 65, math.random(95,105))
	end
	if e == "base_ranged_throw" then
		self:EmitSound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_0"..math.random(0,2)..".mp3", 95)

		local larmfx_tag = self:LookupBone("j_wrist_le")

		self.Guts = ents.Create("nz_gib")
		self.Guts:SetPos(self:GetBonePosition(larmfx_tag))
		self.Guts:Spawn()

		local phys = self.Guts:GetPhysicsObject()
		local target = self:GetTarget()
		local movementdir
		if IsValid(phys) and IsValid(target) then
			--[[if target:IsPlayer() then
				movementdir = target:GetVelocity():Normalize()
				print(movementdir)
			end]]
			phys:SetVelocity(self.Guts:getvel(target:EyePos() - Vector(0,0,7), self:EyePos(), 0.95))
		end
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

	-- WW2 Zobies	
	if e == "s2_gen_step" then
		self:EmitSound(self.StepSounds[math.random(#self.StepSounds)], 60, math.random(95, 105))
	end
	if e == "s2_taunt_vox" then
		self:PlaySound(self.TauntSounds[math.random(#self.TauntSounds)],95, math.random(95, 105), 1, 2)
	end
end