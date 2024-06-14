AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Gold Digger"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

if CLIENT then 

	function ENT:PostDraw()
		self:EffectsAndSounds()
	end

	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if !self.Draw_SFX or !IsValid(self.Draw_SFX) then
				self.Draw_SFX = "wavy_zombie/ghost/ghost_loop.wav"
				
				self:EmitSound(self.Draw_SFX, 75, math.random(95, 105), 1, 3)

			end
			if !self.Draw_FX or !IsValid(self.Draw_FX) then
				self.Draw_FX = CreateParticleSystem(self, "ds3_dw_mist", PATTACH_POINT_FOLLOW, 9)

			end			
		end
	end

	return 
end -- Client doesn't really need anything beyond the basics

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
--ENT.IsMooBossZombie = true
--ENT.IsMiniBoss = true

ENT.AttackRange = 75
ENT.DamageRange = 75 
ENT.AttackDamage = 40
ENT.SoundDelayMin = 1
ENT.SoundDelayMax = 3

ENT.Models = {
	{Model = "models/wavy_ports/wavy_enemies/bo2/wavy_codz_t6_buried_ghost.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_ghostwoman_spawn"}

ENT.BarricadeTearSequences = {
	"nz_ghostwoman_melee",
}

ENT.DeathSequences = {
	"nz_ghostwoman_death",
	"nz_ghostwoman_death2"
}

local JumpSequences = {
	{seq = "nz_ghostwoman_traverse"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ghostwoman_walk",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 70, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ghostwoman_sprint",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/ghost/death.mp3"
}

ENT.AttackSounds = {
	"nz_moo/zombies/vox/mute_00.wav"
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		self:SetRunSpeed( 1 )
		self:SetHealth( math.random(100,500) )

		self:SetSurroundingBounds(Vector(-25, -25, 0), Vector(25, 25, 80))

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

	self:EmitSound("wavy_zombie/ghost/appear.mp3", 511, 100, 1, 2)

	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)
	self:StopSound("wavy_zombie/ghost/ghost_loop.wav")
	self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	ParticleEffectAttach("ds3_boss_dissolve", 4, self, 0)
end

function ENT:OnRemove()
	self:StopSound("wavy_zombie/ghost/ghost_loop.wav")
	self:StopParticles()
end

function ENT:DoDeathAnimation(seq, dmginfo)
	self.BehaveThread = coroutine.create(function()
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndMove(seq, 1)
		self:EmitSound("wavy_zombie/ghost/cloud.mp3", 75, math.random(95, 105), 1, 3)
		ParticleEffect("har_explosion_b_smoke_b", self:WorldSpaceCenter(), Angle(0,0,0), nil)
		self:Remove(dmginfo)
	end)
end

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:OnThink()
	if self:TargetInAttackRange() then
		if SERVER then
		end
	end
end

function ENT:Attack()
	local victim = self:GetTarget()
	if IsValid(victim) then
		if victim:IsPlayer() and victim:GetPoints() > 0 then
		print("child support")
		victim:NZAstroSlow(2)
		self:PlaySequenceAndWait("nz_ghostwoman_pointdrain", 1, self.FaceEnemy)
		elseif (victim:IsPlayer() and victim:GetPoints() <= 0) or !victim:IsPlayer() then
		print("broke ass nigga")
		self:EmitSound("wavy_zombie/ghost/attack/attack_0"..math.random(0,1)..".mp3", 90, math.random(95, 105), 1, 3)
		self:PlaySequenceAndWait("nz_ghostwoman_melee", 1, self.FaceEnemy)
		end
	end
end

function ENT:AI()
	local tar = self:GetTarget()
	if IsValid(tar) then
		if self:TargetInRange(200) then
			self:SetRunSpeed(1)
			self:SpeedChanged()
		else
			self:SetRunSpeed(71)
			self:SpeedChanged()
		end
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
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
	if e == "point_drain" then
		local guygettingrobbed = self:GetTarget()
		if IsValid(self) and guygettingrobbed:IsPlayer() and guygettingrobbed:GetPos():Distance( self:GetPos()) < 100 then
		guygettingrobbed:TakePoints(2000)
		guygettingrobbed:EmitSound("wavy_zombie/ghost/drain.mp3")
		guygettingrobbed:SetAmmo(4, GetNZAmmoID("grenade"))
		print("child support collected")
		end
	end
end
