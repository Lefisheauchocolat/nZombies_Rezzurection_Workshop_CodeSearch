AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
--ENT.PrintName = "Fallout 4 Deathclaw"
ENT.PrintName = "Deathclaw"
ENT.Category = "Brainz"
ENT.Author = "Wavy"
ENT.Spawnable = true

local resist = {
	[DMG_BULLET] = true,
}

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true

ENT.Models = {
	{Model = "models/wavy/wavy_enemies/deathclaw/deathclaw_alpha.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_enemies/deathclaw/deathclaw_albino.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_enemies/deathclaw/deathclaw_matriarch.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_enemies/deathclaw/deathclaw_savage.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_deathclaw_spawn"}

ENT.AttackRange = 120
ENT.DamageRange = 150
ENT.AttackDamage = 70
ENT.HeavyAttackDamage = 80

local util_tracehull = util.TraceHull

ENT.IdleSequence = "nz_deathclaw_idle"

ENT.DeathSequences = {
	"nz_deathclaw_death1",
	"nz_deathclaw_death2",
}

ENT.BarricadeTearSequences = {
	"nz_deathclaw_attackleft",
	"nz_deathclaw_attackright",
}

ENT.LeapAttackSequences = {
	"nz_deathclaw_attackjumpslash",
}

ENT.DeathclawTauntSequences = {
	"nz_deathclaw_taunt",
	"nz_deathclaw_taunt2",
	"nz_deathclaw_taunt3",
}

ENT.DeathclawDodgeSequences = {
	"nz_deathclaw_evadeleft",
	"nz_deathclaw_evaderight",
}

ENT.DeathclawPainSequences = {
	"nz_deathclaw_critchest",
	"nz_deathclaw_critface",
}

local StandAttackSequences = {
	{seq = "nz_deathclaw_attackleft"},
	{seq = "nz_deathclaw_attackright"},
}

local AttackSequences = {
	{seq = "nz_deathclaw_attackleft"},
	{seq = "nz_deathclaw_attackright"},
	{seq = "nz_deathclaw_attackcombo"},
	{seq = "nz_deathclaw_attackram"},
	{seq = "nz_deathclaw_attackpower"},
}

local JumpSequences = {
	{seq = ACT_JUMP, speed = 100},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

local runsounds = {
	Sound("wavy_zombie/deathclaw/npc_deathclaw_breathe_run_01.mp3"),
	Sound("wavy_zombie/deathclaw/npc_deathclaw_breathe_run_02.mp3"),
	Sound("wavy_zombie/deathclaw/npc_deathclaw_breathe_run_03.mp3"),
	Sound("wavy_zombie/deathclaw/npc_deathclaw_breathe_run_04.mp3"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_deathclaw_walk",
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
			MovementSequence = {
				"nz_deathclaw_run",
				"nz_deathclaw_run",
				"nz_deathclaw_run",
				"nz_deathclaw_sprint",
			},
			
			SpawnSequence = {spawn},
			
			AttackSequences = {AttackSequences},
			
			StandAttackSequences = {StandAttackSequences},

			JumpSequences = {JumpSequences},

			PassiveSounds = {runsounds},
		},
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/deathclaw/npc_deathclaw_death_01.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_death_02.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_death_03.mp3",
}

ENT.AttackSounds = {
	"wavy_zombie/deathclaw/npc_deathclaw_attack_sideswipe_left_01.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_sideswipe_left_02.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_sideswipe_right_01.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_sideswipe_right_02.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_standing_left_01.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_standing_left_02.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_standing_left_03.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_standing_right_01.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_standing_right_02.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_attack_standing_right_03.mp3",
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/deathclaw/npc_deathclaw_foot_walk_01.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_foot_walk_02.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_foot_walk_03.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_foot_walk_04.mp3",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/deathclaw/npc_deathclaw_foot_run_01.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_foot_run_02.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_foot_run_03.mp3",
	"wavy_zombie/deathclaw/npc_deathclaw_foot_run_04.mp3",
}

ENT.CustomAttackImpactSounds = {
	"wavy_zombie/deathclaw/fx_deathclaw_melee_01.mp3",
	"wavy_zombie/deathclaw/fx_deathclaw_melee_02.mp3",
}

ENT.CustomMeleeWhooshSounds = {
	"wavy_zombie/deathclaw/pan_swing_miss1.wav",
	"wavy_zombie/deathclaw/pan_swing_miss2.wav",
}

ENT.DeathclawTauntSounds = {
	"wavy_zombie/deathclaw/npc_deathclaw_taunt_01.mp3",
}

ENT.BehindSoundDistance = 1 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

function ENT:StatsInitialize()
	if SERVER then

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(4000)
			self:SetMaxHealth(4000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 350, 350, 50000))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 350, 350, 50000))
			else
				self:SetHealth(1200)
				self:SetMaxHealth(1200)	
			end
		end
		
		self:SetCollisionBounds(Vector(-18,-18, 0), Vector(18, 18, 72))			-- Nextbots Collision Box(Mainly for interacting with the world.)
		self:SetSurroundingBounds(Vector(-50, -50, 0), Vector(50, 50, 100)) 	-- Nextbots Surrounding Bounds(For Hitbox detection.)
		
		self:SetRunSpeed(36)
		
		self.JumpCooldown = CurTime() + 6
		self.TauntCooldown = CurTime() + 2
		self.CanJump = false
		self.Jumping = false
		self.CanTaunt = false
		self.Taunting = false
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	self:SetModelScale(0.8,0.00001)
	self:EmitSound("wavy_zombie/deathclaw/npc_deathclaw_breathe_01_lp.wav")
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

	self:StopSound("wavy_zombie/deathclaw/npc_deathclaw_breathe_01_lp.wav")
	local damagetype = dmginfo:GetDamageType()
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
	self:EmitSound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)
end

function ENT:OnRemove()
	self:StopSound("wavy_zombie/deathclaw/npc_deathclaw_breathe_01_lp.wav")
end

function ENT:OnTakeDamage(dmginfo)
	local insta = nzPowerUps:IsPowerupActive("insta") -- Don't apply the damage reduction if insta kill is active.
	if resist[dmginfo:GetDamageType()] and !insta then
		dmginfo:ScaleDamage(0.5)
	end
end

function ENT:OnInjured(dmginfo)
	local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce 		= dmginfo:GetDamageForce()
	local hitpos 		= dmginfo:GetDamagePosition()
	local inflictor 	= dmginfo:GetInflictor()

	if !self.SpawnProtection then

		--[[ STUMBLING/STUN ]]--
		if CurTime() > self.LastStun then -- The code here is kinda bad tbh, and in turn it does weird shit because of it.
			-- Moo Mark 7/17/23: Alright... We're gonna try again.
			if self.Dying then return end
			if !self:IsAlive() then return end
			if dmginfo:IsDamageType(DMG_MISSILEDEFENSE) 
				or self:GetSpecialAnimation() 
				or self:GetIsBusy() 
				then return end

			-- 11/1/23: Have to double check the CurTime() > self.LastStun in order to stop the Zombie from being able to stumble two times in a row.
			if !self.IsBeingStunned and !self:GetSpecialAnimation() then
				if self:CrawlerForceTest(hitforce) and CurTime() > self.LastStun then
					self.IsBeingStunned = true
					self:DoSpecialAnimation(self.DeathclawPainSequences[math.random(#self.DeathclawPainSequences)], true, true)
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
	if CurTime() > self.JumpCooldown and !self.CanJump then
		self.CanJump = true
	end
	if CurTime() > self.TauntCooldown and !self.CanTaunt then
		self.CanTaunt = true
	end
	if self:TargetInRange(400) and !self:IsAttackBlocked() and self.CanJump and !nzPowerUps:IsPowerupActive("timewarp") and math.random(4) == 1 then
		if self:TargetInRange(200) then return end
		self:JumpAttack()
	end
	if self:TargetInRange(900) and !self:IsAttackBlocked() and self.CanTaunt and !nzPowerUps:IsPowerupActive("timewarp") and math.random(5) == 1 then
		if self:TargetInRange(400) then return end
		self:DeathclawTaunt()
	end
	if self:TargetInRange(800) and !self.AttackIsBlocked and math.random(15) <= 10 and CurTime() > self.LastSideStep then
		if !self:IsFacingTarget() then return end
		if !self:IsAimedAt() then return end
		if self:TargetInRange(150) then return end
		if self:GetRunSpeed() < 100 then return end
		if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
		local seq = self.DeathclawDodgeSequences[math.random(#self.DeathclawDodgeSequences)]
		if self:SequenceHasSpace(seq) and self:LookupSequence(seq) > 0 then
			self:DoSpecialAnimation(seq, true, true)
		end
			self.LastSideStep = CurTime() + 3
		end
	end
end

function ENT:JumpAttack()
	local target = self:GetTarget()
	local leapseq = self.LeapAttackSequences[math.random(#self.LeapAttackSequences)]
	self:EmitSound("wavy_zombie/deathclaw/npc_deathclaw_attack_jump_slash_01.mp3", 500, 100, 1, 6)
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Jumping = true
		self:FaceTowards(target)
		self:PlaySequenceAndMove(leapseq, 1)
		self.Jumping = false
		self.CanJump = false
		self:SetSpecialAnimation(false)
		self.JumpCooldown = CurTime() + 6
	end)
end

function ENT:DeathclawTaunt()
	local tauntseq = self.DeathclawTauntSequences[math.random(#self.DeathclawTauntSequences)]
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Taunting = true
		self:PlaySequenceAndMove(tauntseq, 1, self.FaceEnemy)
		self.Taunting = false
		self.CanTaunt = false
		self:SetSpecialAnimation(false)
		self.TauntCooldown = CurTime() + 15
	end)
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
	if e == "deathclaw_roar" then
		self:EmitSound(self.DeathclawTauntSounds[math.random(#self.DeathclawTauntSounds)], 500, math.random(95, 105), 1, 6)
	end
	if e == "deathclaw_bodyfall" then
		self:EmitSound("wavy_zombie/deathclaw/npc_deathclaw_land_01.mp3", 400)
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

--taken from Margwa, shrink collision box if stuck
--[[if SERVER then
	-- Collide When Possible
	local collidedelay = 0.25
	local bloat = Vector(5,5,0)
	function ENT:Think()
		if (self:IsAllowedToMove() and !self:GetCrawler() and self.loco:GetVelocity():Length2D() >= 125 and self.SameSquare and !self:GetIsBusy() or self:IsAllowedToMove() and self:GetAttacking() ) then -- Moo Mark
        	self.loco:SetVelocity(self:GetForward() * self:GetRunSpeed())
        end
		if self.DoCollideWhenPossible then
			if not self.NextCollideCheck or self.NextCollideCheck < CurTime() then
				local mins,maxs = self:GetCollisionBounds()
				local tr = util_tracehull({
					start = self:GetPos(),
					endpos = self:GetPos(),
					filter = self,
					mask = MASK_NPCSOLID,
					mins = mins - bloat,
					maxs = maxs + bloat,
					ignoreworld = true
				})

				local b = tr.Entity
				if !IsValid(b) then 
					self:SetSolidMask(MASK_NPCSOLID)
					self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
					self.DoCollideWhenPossible = nil
					self.NextCollideCheck = nil
				else
					self.NextCollideCheck = CurTime() + collidedelay
				end
			end
		end


        if CurTime() > self.SpawnProtectionTime and self.SpawnProtection then
        	self.SpawnProtection = false
        	--print("Can be hurt")
        end
        
		self:StuckPrevention()
		self:ZombieStatusEffects()

		if not self.NextSound or self.NextSound < CurTime() then
			self:Sound()
		end

		self:DebugThink()
		self:OnThink()
	end
	function ENT:StuckPrevention()
		if !self:GetIsBusy() and !self:GetSpecialAnimation() and !self:GetAttacking() and self:GetLastPostionSave() + 0.25 < CurTime() then
			if self:GetPos():DistToSqr( self:GetStuckAt() ) < 75 then
				self:SetStuckCounter( self:GetStuckCounter() + 1)
				--print(self:GetStuckCounter())
			else
				self:SetStuckCounter( 0 )
				local tr1 = util_tracehull({
					start = self:GetPos(),
					endpos = self:GetPos(),
					maxs = Vector(20, 20, 92) + bloat,
					mins = Vector(-20,-20, 0) - bloat,
					filter = self
				})
				if !tr1.HitWorld then
					self:SetCollisionBounds(Vector(-24,-24, 0), Vector(24, 24, 96))
				end
			end

			if self:GetStuckCounter() >= 2 then

				self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 72))

				local tr = util_tracehull({
					start = self:GetPos(),
					endpos = self:GetPos(),
					maxs = self:OBBMaxs() + bloat,
					mins = self:OBBMins() - bloat,
					filter = self
				})
				if !tr.HitWorld then
				end
				if self:GetStuckCounter() > 25 then
					if self.NZBossType then
						local spawnpoints = {}
						for k,v in pairs(ents.FindByClass("nz_spawn_zombie_special")) do -- Find and add all valid spawnpoints that are opened and not blocked
							if (v.link == nil or nzDoors:IsLinkOpened( v.link )) and v:IsSuitable() then
								table.insert(spawnpoints, v)
							end
						end
						local selected = spawnpoints[math.random(#spawnpoints)] -- Pick a random one
						self:SetPos(selected:GetPos())
					else
						self:RespawnZombie()
					end
					self:SetStuckCounter( 0 )
				end
			end
			self:SetLastPostionSave( CurTime() )
			self:SetStuckAt( self:GetPos() )
		end
	end
end]]