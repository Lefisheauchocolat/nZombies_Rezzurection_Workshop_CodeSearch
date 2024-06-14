AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Fallout 4 Glowing Ghoul"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

function ENT:PostDraw()

	local elight = DynamicLight( self:EntIndex(), true )
	if ( elight ) then
		local bone = self:LookupBone("SPINE2")
		local pos = self:GetBonePosition(bone)
		pos = pos 
		elight.pos = pos
		elight.r = 147
		elight.g = 255
		elight.b = 0
		elight.brightness = 9
		elight.Decay = 1000
		elight.Size = 50
		elight.DieTime = CurTime() + 1
		elight.style = 0
		elight.noworld = true
	end
end

if CLIENT then return end -- Client doesn't really need anything beyond the basics

--local target = NPC:GetTarget()

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true

ENT.Models = {
	{Model = "models/wavy/wavy_enemies/ghouls/glowingone.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_enemies/ghouls/glowingone_putrid1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_enemies/ghouls/glowingone_putrid2.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_ghoul_spawn1", "nz_ghoul_spawn2", "nz_ghoul_spawn3", "nz_ghoul_spawn4"}

ENT.IdleSequence = "nz_ghoul_idle"

ENT.DeathSequences = {
	"nz_ghoul_death1",
	"nz_ghoul_death2",
	"nz_ghoul_death3",
}

ENT.BarricadeTearSequences = {
	"nz_ghoul_attack1",
	"nz_ghoul_attack2",
}

ENT.LeapAttackSequences = {
	"nz_ghoul_lungeattack1",
	"nz_ghoul_lungeattack2",
}

ENT.GhoulDodgeSequences = {
	"nz_ghoul_evadeleft",
	"nz_ghoul_evaderight",
}

ENT.GhoulPainSequences = {
	"nz_ghoul_critchest",
	"nz_ghoul_critfall1",
	"nz_ghoul_critfall2",
	"nz_ghoul_critfall3",
}

ENT.GhoulHeadPainSequences = {
	"nz_ghoul_crithead",
}

ENT.GhoulLeftPainSequences = {
	"nz_ghoul_critleft",
}

ENT.GhoulRightPainSequences = {
	"nz_ghoul_critright",
}

local JumpSequences = {
	{seq = ACT_JUMP, speed = 100},
}

local StandAttackSequences = {
	{seq = "nz_ghoul_attack1"},
	{seq = "nz_ghoul_attack2"},
}

local AttackSequences = {
	{seq = "nz_ghoul_attack1"},
	{seq = "nz_ghoul_attack2"},
	{seq = "nz_ghoul_attack3"},
	{seq = "nz_ghoul_attack4"},
	{seq = "nz_ghoul_attack5"},
}

local walksounds = {
	Sound("wavy_zombie/ghouls/npc_feralghoul_idle_generic_01.mp3"),
	Sound("wavy_zombie/ghouls/npc_feralghoul_idle_generic_02.mp3"),
	Sound("wavy_zombie/ghouls/npc_feralghoul_idle_generic_03.mp3"),
	Sound("wavy_zombie/ghouls/npc_feralghoul_idle_generic_04.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				
				"nz_ghoul_walk",
			},
			SpawnSequence = {spawn},
			
			AttackSequences = {AttackSequences},
			
			StandAttackSequences = {StandAttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				
				"nz_ghoul_run",
				"nz_ghoul_run2",
				"nz_ghoul_run3",
				"nz_ghoul_sprint",
				"nz_ghoul_sprint2",
			},
			SpawnSequence = {spawn},
			
			AttackSequences = {AttackSequences},
			
			StandAttackSequences = {StandAttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/ghouls/npc_feralghoul_death_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_death_02.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_death_03.mp3",
}

ENT.AttackSounds = {
	"wavy_zombie/ghouls/npc_feralghoul_attacka_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attacka_02.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attacka_03.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attacka_04.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attacka_05.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attacka_06.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attackbite_01.mp3",
}

ENT.LeapAttackSounds = {
	"wavy_zombie/ghouls/npc_feralghoul_attackcharge_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attackcharge_02.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attackcharge_03.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_attackcharge_04.mp3",
}

ENT.Painsounds = {
	"wavy_zombie/ghouls/npc_feralghoul_injured_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_injured_02.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_injured_03.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_injured_04.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_injured_05.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_injured_06.mp3",
}

ENT.SpawnSounds = {
	"wavy_zombie/ghouls/npc_feralghoul_ambush_getup_a_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_ambush_getup_b_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_ambush_getup_c_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_ambush_getup_d_01.mp3",
}

ENT.FartSounds = {
	"wavy_zombie/ghouls/npc_feralghoulglowing_resurrect_a_01_3d.mp3",
	"wavy_zombie/ghouls/npc_feralghoulglowing_resurrect_b_01_3d.mp3",
}

ENT.BrapSounds = {
	"wavy_zombie/ghouls/npc_feralghoulglowing_resurrect_a_01_2d.mp3",
	"wavy_zombie/ghouls/npc_feralghoulglowing_resurrect_b_01_2d.mp3",
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_00.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_01.mp3"),
	Sound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_02.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/ghouls/npc_feralghoul_foot_walk_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_foot_walk_02.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_foot_walk_03.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_foot_walk_04.mp3",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/ghouls/npc_feralghoul_foot_run_01.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_foot_run_02.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_foot_run_03.mp3",
	"wavy_zombie/ghouls/npc_feralghoul_foot_run_04.mp3",
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then		
		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(4000)
			self:SetMaxHealth(4000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(nzRound:GetZombieHealth() * 2)
				self:SetMaxHealth(nzRound:GetZombieHealth() * 2)
			else
				self:SetHealth(1200)
				self:SetMaxHealth(1200)	
			end
		end
		self:SetRunSpeed(36)
		self.Cooldown = CurTime() + 6
		self.Farting = false
		self.CanFart = false
		self.LeapCooldown = CurTime() + 2
		self.Leaping = false
		self.CanLeap = false
		self.CanSit = true
		self.IsSitting = false
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	self:EmitSound("wavy_zombie/ghouls/npc_feralghoul_conscious_02_lp.wav")
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetSpecialAnimation(true)
	ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
	self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
	
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)
	self:StopSound("wavy_zombie/ghouls/npc_feralghoul_conscious_02_lp.wav")
	local damagetype = dmginfo:GetDamageType()
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
	self:EmitSound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)
end

function ENT:OnRemove()
	self:StopSound("wavy_zombie/ghouls/npc_feralghoul_conscious_02_lp.wav")
end

function ENT:OnInjured(dmginfo)
	local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce 		= dmginfo:GetDamageForce()
	local hitpos 		= dmginfo:GetDamagePosition()
	local inflictor 	= dmginfo:GetInflictor()

	if !self.SpawnProtection then
	
		--[[ GIBBING SYSTEM ]]--
		if self:GibForceTest(hitforce) then
			local head = self:LookupBone("HEAD")
			local larm = self:LookupBone("LForeArm1")
			local rarm = self:LookupBone("RForeArm1")
				
			if (larm and hitgroup == HITGROUP_LEFTARM) and !self.HasGibbed then
				self:GibArmL()
			end

			if (rarm and hitgroup == HITGROUP_RIGHTARM) and !self.HasGibbed then
				self:GibArmR()
			end
		end

		--[[ STUMBLING/STUN ]]--
		if CurTime() > self.LastStun then -- The code here is kinda bad tbh, and in turn it does weird shit because of it.
			-- Moo Mark 7/17/23: Alright... We're gonna try again.
			if self.Dying then return end
			if !self:Alive() then return end
			if dmginfo:IsDamageType(DMG_MISSILEDEFENSE) 
				or self:GetSpecialAnimation() 
				or self:GetIsBusy() 
				then return end

			-- 11/1/23: Have to double check the CurTime() > self.LastStun in order to stop the Zombie from being able to stumble two times in a row.
			if !self.IsBeingStunned and !self:GetSpecialAnimation() then
				if hitgroup == HITGROUP_HEAD and CurTime() > self.LastStun then
					if self.PainSounds then
						self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
						self.NextSound = CurTime() + self.SoundDelayMax
					end
					self.IsBeingStunned = true
					self:DoSpecialAnimation(self.GhoulHeadPainSequences[math.random(#self.GhoulHeadPainSequences)], true, true)
					self.IsBeingStunned = false
					self.LastStun = CurTime() + 8
					self:ResetMovementSequence()
				end

				if hitgroup == HITGROUP_LEFTARM and CurTime() > self.LastStun then
					if self.PainSounds then
						self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
						self.NextSound = CurTime() + self.SoundDelayMax
					end
					self.IsBeingStunned = true
					self:DoSpecialAnimation(self.GhoulLeftPainSequences[math.random(#self.GhoulLeftPainSequences)], true, true)
					self.IsBeingStunned = false
					self.LastStun = CurTime() + 8
					self:ResetMovementSequence()
				end

				if hitgroup == HITGROUP_RIGHTARM and CurTime() > self.LastStun then
					if self.PainSounds then
						self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
						self.NextSound = CurTime() + self.SoundDelayMax
					end
					self.IsBeingStunned = true
					self:DoSpecialAnimation(self.GhoulRightPainSequences[math.random(#self.GhoulRightPainSequences)], true, true)
					self.IsBeingStunned = false
					self.LastStun = CurTime() + 8
					self:ResetMovementSequence()
				end
				if self:CrawlerForceTest(hitforce) and CurTime() > self.LastStun then
					if self.PainSounds then
						self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(85, 105), 1, 2)
						self.NextSound = CurTime() + self.SoundDelayMax
					end
					self.IsBeingStunned = true
					self:DoSpecialAnimation(self.GhoulPainSequences[math.random(#self.GhoulPainSequences)], true, true)
					self.IsBeingStunned = false
					self.LastStun = CurTime() + 8
					self:ResetMovementSequence()
				end
			end
		end
	end
end

function ENT:PostAdditionalZombieStuff()
	if self:GetSpecialAnimation() then return end
	if CurTime() > self.LeapCooldown and !self.CanLeap then
		self.CanLeap = true
	end
	if CurTime() > self.Cooldown and !self.CanFart then
		self.CanFart = true
	end
	if self:TargetInRange(250) and !self:IsAttackBlocked() and self.CanLeap and !nzPowerUps:IsPowerupActive("timewarp") and math.random(2) == 1 then
		if self:TargetInRange(80) then return end
		self:LeapAttack()
	end
	if self:TargetInRange(300) and !self:IsAttackBlocked() and self.CanFart and !nzPowerUps:IsPowerupActive("timewarp") and math.random(3) == 1 then
		if !self:GetTarget():IsPlayer() then return end
		self:BrapAttack()
	end
	if self:TargetInRange(800) and !self.AttackIsBlocked and math.random(15) <= 10 and CurTime() > self.LastSideStep then
		if !self:IsFacingTarget() then return end
		if !self:IsAimedAt() then return end
		if self:TargetInRange(100) then return end
		if self:GetRunSpeed() < 100 then return end
		if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
		local seq = self.GhoulDodgeSequences[math.random(#self.GhoulDodgeSequences)]
		if self:SequenceHasSpace(seq) and self:LookupSequence(seq) > 0 then
			self:DoSpecialAnimation(seq, true, true)
		end
			self.LastSideStep = CurTime() + 3
		end
	end
end

function ENT:LeapAttack()
	local target = self:GetTarget()
	local leapseq = self.LeapAttackSequences[math.random(#self.LeapAttackSequences)]
	self:EmitSound(self.LeapAttackSounds[math.random(#self.LeapAttackSounds)], 500, 100, 1, 2)
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Leaping = true
		self:FaceTowards(target)
		self:PlaySequenceAndMove(leapseq, 1, self.FaceEnemy)
		self.Leaping = false
		self.CanLeap = false
		self:SetSpecialAnimation(false)
		self.LeapCooldown = CurTime() + 4
	end)
end

function ENT:BrapAttack()
	local target = self:GetTarget()
	self:EmitSound(self.FartSounds[math.random(#self.FartSounds)], 500, 100, 1, 6)
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Farting = true
		self:FaceTowards(target)
		self:PlaySequenceAndMove("nz_glowingone_chargepre", 1)
		self:PlaySequenceAndMove("nz_glowingone_chargerelease", 1)
		self.Farting = false
		self.CanFart = false
		self:SetSpecialAnimation(false)
		self.Cooldown = CurTime() + 10
	end)
end

function ENT:OnGameOver()
	if self.CanSit and !self.IsSitting then
	self.IsSitting = true
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.IsSitting = true
		self:PlaySequenceAndMove("PoseA_Idle1", 1)
	end)
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 75)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 75)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
	end
	if e == "melee" or e == "melee_heavy" then
		if self.AttackSounds then
			self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		end
		if e == "melee_heavy" then
			self.HeavyAttack = true
		end
		self:DoAttackDamage()
	end
	if e == "melee_whoosh" then
		if self.CustomMeleeWhooshSounds then
			self:EmitSound(self.CustomMeleeWhooshSounds[math.random(#self.CustomMeleeWhooshSounds)], 80)
		else
			self:EmitSound(self.MeleeWhooshSounds[math.random(#self.MeleeWhooshSounds)], 80)
		end
	end
	if e == "glowingone_fart" then
		local target = self:GetTarget()
		local hpdiff = target:Health() / 2
		self:EmitSound(self.BrapSounds[math.random(#self.BrapSounds)], 500)
		ParticleEffectAttach("glowingone_irradiate", 4, self, 6)
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 220)) do
			if IsValid(v) and v:IsPlayer() and !self:IsAttackEntBlocked(v) then
			    local expdamage = DamageInfo()
				expdamage:SetAttacker(self)
				expdamage:SetInflictor(self)
				expdamage:SetDamageType(DMG_RADIATION)
				expdamage:SetDamage(hpdiff)
				v:TakeDamageInfo(expdamage)
				v:NZSonicBlind(1)	
			end
			if IsValid(v) and v:IsValidZombie() and v.IsMooZombie and !v.IsMooSpecial and v:Health() > 0 then
            	v:SetRunSpeed(250)
				v.loco:SetDesiredSpeed( v:GetRunSpeed() )
				v:SetHealth( nzRound:GetZombieHealth() * 2 )
				v:SpeedChanged()
				v:SetBomberBuff(true)
			end
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
end