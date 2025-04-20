AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Panzer Soldat (Der Eisendrache)"
ENT.PrintName = "Panzerhund"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

AccessorFunc( ENT, "fLastToast", "LastToast", FORCE_NUMBER)
if CLIENT then 
	function ENT:Draw()
		self:DrawModel()

			
		--self:EffectsAndSounds()

		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end

	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			--if !self.Draw_FX or !IsValid(self.Draw_FX) then -- PVS will no longer eat the particle effect.
			--	self.Draw_FX = CreateParticleSystem(self, "doom_rev_missile_trail_smoke", PATTACH_POINT_FOLLOW, 2)
			--end
		end
	end

	return 
end

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true
ENT.CanCancelSpecial = false
ENT.CanCancelAttack = false
ENT.AttackRange = 200
ENT.DamageRange 			= 200
ENT.AttackDamage 			= 75
ENT.BloodType 				= "Robot" 

ENT.TraversalCheckRange = 100

ENT.Models = {
	{Model = "models/enemies/wolfenstein/nz_panzerhund3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/enemies/wolfenstein/nz_panzerhund1960.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"idl1_to_sprint"}

ENT.DeathSequences = {
	"walk_to_sprint",
}

local AttackSequences = {
	{seq = "melee1"},
	{seq = "melee2"},
	{seq = "melee3"},
	{seq = "melee4"},
}

local walksounds = {
	Sound("panzerhund/idle/idle_01.wav"),
	Sound("panzerhund/idle/idle_02.wav"),
	Sound("panzerhund/idle/idle_03.wav"),
	Sound("panzerhund/idle/idle_04.wav"),
	Sound("panzerhund/idle/idle_05.wav"),
	Sound("panzerhund/idle/idle_06.wav"),
	Sound("panzerhund/idle/idle_07.wav"),
	Sound("panzerhund/idle/idle_08.wav"),
	Sound("panzerhund/idle/idle_09.wav"),
	Sound("panzerhund/idle/idle_10.wav"),
	Sound("panzerhund/idle/idle_11.wav"),
}

ENT.IdleSequence = "idle1"


ENT.BarricadeTearSequences = {
	"melee3",
	"melee2",
}


ENT.ZombieStunInSequence = "walk_to_idle2"
ENT.ZombieStunOutSequence = "idle1_to_sprint"

ENT.SparkySequences = {
	"idle2",
	"idle2",
	"idle2",
	"idle2",
	"idle2",
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"walk",
			},
			FlameMovementSequence = {
				"specialattack",
			},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"sprint",
			},
			FlameMovementSequence = {
				"specialattack",
			},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},
			PassiveSounds = {walksounds},
		},
	}}
}


ENT.AttackSounds = {
	Sound("panzerhund/attack/ph_claw_whoosh_01.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_02.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_03.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_04.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_05.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_06.wav"),
}


ENT.AttackWhooshSounds = {
	Sound("panzerhund/attack/ph_claw_whoosh_01.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_02.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_03.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_04.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_05.wav"),
	Sound("panzerhund/attack/ph_claw_whoosh_06.wav"),

}

ENT.LandSounds = {
	Sound("nz_moo/zombies/vox/_mechz/v2/land/land_00.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/v2/land/land_01.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/v2/land/land_02.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_mechz/vox/pain/pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/vox/pain/pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/vox/pain/pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/vox/pain/pain_03.mp3"),
}

ENT.AngrySounds = {
	Sound("nz_moo/zombies/vox/_mechz/vox/angry_nh/angry_nh_00.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/vox/angry_nh/angry_nh_01.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/vox/angry_nh/angry_nh_02.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/vox/angry_nh/angry_nh_03.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_mechz/vox/death_nh/death_nh_00.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/vox/death_nh/death_nh_01.mp3"),
	Sound("nz_moo/zombies/vox/_mechz/vox/death_nh/death_nh_02.mp3"),
}

ENT.StepSounds = {
	Sound("panzerhund/walk/front_foot_walk_01.wav"),
	Sound("panzerhund/walk/front_foot_walk_02.wav"),
	Sound("panzerhund/walk/front_foot_walk_03.wav"),
	Sound("panzerhund/walk/front_foot_walk_04.wav"),
}

ENT.StepSoundsRear = {
	Sound("panzerhund/walk/backfoot_walk_01.wav"),
	Sound("panzerhund/walk/backfoot_walk_02.wav"),
	Sound("panzerhund/walk/backfoot_walk_03.wav"),
	Sound("panzerhund/walk/backfoot_walk_04.wav"),
}

ENT.ServoSounds = {
	Sound("panzerhund/walk/single_servo_var1_1.wav"),
	Sound("panzerhund/walk/single_servo_var1_2.wav"),
	Sound("panzerhund/walk/single_servo_var1_3.wav"),
	Sound("panzerhund/walk/single_servo_var1_2.wav"),
	Sound("panzerhund/walk/single_servo_var2_1.wav")
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying() * 0.5

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(4300)
			self:SetMaxHealth(4300)
		else
			self:SetHealth(nzRound:GetNumber() * 950 + (1000 * count))
			self:SetMaxHealth(nzRound:GetNumber() * 950 + (1000 * count))
		end

		self.CanCutoff = true


		self.SpawnProtection = true -- Zero Health Zombies tend to be created right as they spawn.
		self.SpawnProtectionTime = CurTime() + 5 -- So this is an experiment to see if negating any damage they take for a second will stop this.

		angering = false
		leftthetoasteron = false


		-- It is a 100% known fact that bools control at least 90% of the world... This comment is now false.
		self.UsingFlamethrower = false
		self.DisallowFlamethrower = false
		self:SetLastToast(CurTime())
		self.Damaged = false
		self.spawnHealth = self:GetMaxHealth()
		self.CanCancelAttack = true
		self:SetMooSpecial(true)
		self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))
		self:SetSurroundingBounds(Vector(-120,-30,0),Vector(120,30,90))
		self.LastBURN = CurTime() + 5
		self:SetRunSpeed( 100 )
	end
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetSpecialAnimation(true)

	self:EmitSound("enemies/bosses/newpanzer/incoming_alarm_new.ogg",511)
	self:EmitSound("enemies/bosses/newpanzer/mechz_entrance.ogg",100,100)
	self.spawnHealth = self:Health()
	debugoverlay.BoxAngles(self:GetPos() + self:GetUp() * 75, Vector(-5,-5,0), Vector(5,5,750), self:GetAngles(), 3, Color( 255, 255, 255, 10))


	
		local effectData = EffectData()
		effectData:SetOrigin( self:GetPos() + Vector(0, 0, 80)  )
		effectData:SetMagnitude( 5 )
		effectData:SetEntity(nil)
		util.Effect("panzer_spawn_tp", effectData) -- Express Portal to their destination.
	

	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:CollideWhenPossible()
	end
end

function ENT:AI()
	local target = self:GetTarget()
	if IsValid(target) and target:IsPlayer() then

		if !self:IsAlive() or self:GetIsBusy() then return end -- Not allowed to do anything.


		-- FLAMETHROWER
		if !self:GetSpecialAnimation() and !self:IsAttackBlocked() and self:TargetInRange(400) and CurTime() > self.LastBURN then
			if self.DisallowFlamethrower then return end
			self:DoSpecialAnimation("specialattack", false)
			self.LastBURN = CurTime() + math.random(4,6)
			--self:PlaySequenceAndMove("specialattack", 1, self.FaceEnemy) --uh oh mario i've GOOPED
		end

	end

	--nz_soldat_ft_sweep
	--nz_soldat_ft_sweep_up
	--nz_soldat_jump_forward
end

function ENT:PerformDeath(dmgInfo)	
	self.Dying = true

	self:EmitSound("nz_moo/zombies/vox/_mechz/v2/death/rise.mp3", 100, math.random(85,105))
	self:EmitSound("nz_moo/zombies/vox/_mechz/v2/death/killshot.mp3", 100, math.random(85,105))
	self:EmitSound("nz_moo/zombies/vox/_mechz/vox/death/death_00.mp3", 100, math.random(85,105))

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
end

function ENT:OnTargetInAttackRange()
		if self.UsingFlamethrower then
			self:StopToasting()
		end
		if !self:GetBlockAttack() then
			self:Attack()
		end
end

-- Called when the zombie wants to idle. Play an animation here
function ENT:PerformIdle()
	if self.UsingFlamethrower then
		self:StopToasting()
	end
	
		self:ResetSequence(self.IdleSequence)
	
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		self:EmitSound("enemies/bosses/newpanzer/explode.ogg", 511)
   		self:Explode(50, false)
		self:BecomeRagdoll(DamageInfo())
	end)
end

function ENT:StartToasting()
	self.UsingFlamethrower = true
	if self.UsingFlamethrower then
		--print("I'm Nintoasting!!!")

		if not leftthetoasteron then
			ParticleEffectAttach("asw_mnb_flamethrower",PATTACH_POINT_FOLLOW,self,1)
			self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/start.mp3",95, math.random(85, 105))
			self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav",100, 100)
			leftthetoasteron = true
		end

		self:SetLastToast(CurTime())
		if !self.NextFireParticle or self.NextFireParticle < CurTime() then
			local bone = self:GetAttachment(self:LookupAttachment("dog_flame"))
			pos = bone.Pos
			local mins = Vector(0, -8, -15)
			local maxs = Vector(325, 20, 15)
			local tr = util.TraceHull({
				start = pos,
				endpos = pos + bone.Ang:Forward()*500,
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_INTERACTIVE_DEBRIS,
				ignoreworld = true,
				mins = mins,
				maxs = maxs,
			})
		
			debugoverlay.BoxAngles(pos, mins, maxs, bone.Ang, 1, Color( 255, 255, 255, 10))
					
			if self:IsValidTarget(tr.Entity) then
				local dmg = DamageInfo()
				dmg:SetAttacker(self)
				dmg:SetInflictor(self)
				dmg:SetDamage(5)
				dmg:SetDamageType(DMG_BURN)
						
				tr.Entity:TakeDamageInfo(dmg)
				--tr.Entity:Ignite(3, 0)
			end
		end
		self.NextFireParticle = CurTime() + 0.1
	end
end

function ENT:StopToasting()
	if self.UsingFlamethrower then
		--print("I'm no longer Nintoasting.")
		if leftthetoasteron then
			self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/end.mp3",100, math.random(85, 105))
			self:StopSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav")
			leftthetoasteron = false
		end
		self.UsingFlamethrower = false
		self:StopParticles()
	end
end


function ENT:OnInjured( dmgInfo )
		if self:Health() < (self.spawnHealth/2) and not self.Damaged  then
		self.Damaged = true
		self:SetRunSpeed(100)
				self.loco:SetDesiredSpeed(100)
				self:SpeedChanged() -- Updates current anim to be a sprinting one.
		end
		end


function ENT:OnThink()
	if !IsValid(self) then return end

	if self.UsingFlamethrower and self:GetLastToast() + 0.1 < CurTime() and !self.Dying then -- This controls how offten the trace for the flamethrower updates it's position. This shit is very costly so I wanted to try limit how much it does it.
		self:StartToasting()

		-- Stop toasting if any of these pass.
		if IsValid(target) and self.StandingFlamethrower and (self:IsAttackBlocked() or !self:IsFacingTarget() or !self:TargetInRange(650)) then
			self.CancelCurrentAction = true
		end
	end
	if !self.UsingFlamethrower then
		self:StopSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav")
	end
	if self:GetAttacking() or self:GetSpecialAnimation() or self:GetIsBusy() then
		--self:StopToasting()
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav")
	self:StopToasting()
end

function ENT:HandleAnimEvent(a,b,c,d,e)
	if e == "atk" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "flameon" then
		self:StartToasting()
	end
	
	if e == "flameoff" then
		self:StopToasting()
	end
	
	if e == "atk_swing" then
		self:EmitSound(self.AttackWhooshSounds[math.random(#self.AttackWhooshSounds)], 100, math.random(85, 105))
	end
	if e == "front_step" then
		self:EmitSound(self.StepSounds[math.random(#self.StepSounds)], 80, math.random(95, 100))
		
		--self:EmitSound("nz/panzer/servo/mech_servo_0"..math.random(0,1)..".wav",65,math.random(95,100))
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
		--ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,13)
	end
	if e == "rear_step" then
		self:EmitSound(self.StepSoundsRear[math.random(#self.StepSoundsRear)], 80, math.random(95, 100))
		self:EmitSound(self.ServoSounds[math.random(#self.ServoSounds)], 70, math.random(95, 100))
		--self:EmitSound("nz/panzer/servo/mech_servo_0"..math.random(0,1)..".wav",65,math.random(95,100))
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
		--ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,14)
	end
	if e == "hydraulic" then
		self:EmitSound(self.ServoSounds[math.random(#self.ServoSounds)], 70, math.random(95, 100))
		--util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
	end
end

function ENT:IsValidTarget( ent )
		if not ent then return false end

		-- Turned Zombie Targetting
		if self.IsTurned then
			return IsValid(ent) and ent:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooBossZombie and ent:IsAlive() 
		end
	
		return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY -- This is really funny.
	end

function ENT:HasHelmet() return self:GetHelmet() end
