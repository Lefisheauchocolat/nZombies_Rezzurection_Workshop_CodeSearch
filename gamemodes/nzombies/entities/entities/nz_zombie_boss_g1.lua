AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "SHE....RRY..."
ENT.PrintName = "William Berkin"
ENT.Category = "Brainz"
ENT.Author = "Laby and GhostlyMoo"

--like scoob this expired meat kinda hitting

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true

ENT.AttackRange = 100

ENT.TraversalCheckRange = 80

ENT.Models = {
	{Model = "models/bosses/g1.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"slow_flinch_head"}

ENT.DeathSequences = {
	"death"
}

ENT.WalkFootstepsSounds = {
	Sound("enemies/bosses/re2/em7000/step1.ogg"),
	Sound("enemies/bosses/re2/em7000/step2.ogg"),
}


ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

local AttackSequences = {
	{seq = "att1"},
	{seq = "att2"},
	{seq = "att3"},
}

local MadAttackSequences = {
	{seq = "att11"},
	{seq = "att12"}
}

local JumpSequences = {
	{seq = "land"}
}

local walksounds = {
	Sound("enemies/bosses/re2/em7000/vo/idle1.ogg"),
	Sound("enemies/bosses/re2/em7000/vo/idle2.ogg"),
	Sound("enemies/bosses/re2/em7000/vo/idle3.ogg"),
	Sound("enemies/bosses/re2/em7000/vo/idle4.ogg"),
	Sound("enemies/bosses/re2/em7000/vo/idle5.ogg"),
	Sound("enemies/bosses/re2/em7000/vo/idle6.ogg"),
	Sound("enemies/bosses/re2/em7000/vo/idle7.ogg"),
	Sound("enemies/bosses/re2/em7000/vo/idle8.ogg"),
	Sound("enemies/bosses/re2/em7000/vo/idle9.ogg"),

}

local madsounds = {
	Sound("enemies/bosses/re2/em7000/idle1.ogg"),
	Sound("enemies/bosses/re2/em7000/idle2.ogg"),
	Sound("enemies/bosses/re2/em7000/idle3.ogg"),
	Sound("enemies/bosses/re2/em7000/idle4.ogg"),
	Sound("enemies/bosses/re2/em7000/idle5.ogg"),
	Sound("enemies/bosses/re2/em7000/idle6.ogg"),
	Sound("enemies/bosses/re2/em7000/yell1.ogg"),
	Sound("enemies/bosses/re2/em7000/yell2.ogg"),
	Sound("enemies/bosses/re2/em7000/yell3.ogg"),
	Sound("enemies/bosses/re2/em7000/yell4.ogg"),
	Sound("enemies/bosses/re2/em7000/yell5.ogg"),
	Sound("enemies/bosses/re2/em7000/yell6.ogg"),
}

ENT.AttackSounds = {
	"enemies/bosses/re2/em7000/vo/mutate7.ogg",
	"enemies/bosses/re2/em7000/vo/mutate8.ogg",
	"enemies/bosses/re2/em7000/vo/idle4.ogg",
	"enemies/bosses/re2/em7000/vo/idle2.ogg",

}

ENT.AttackSoundsMAD = {
	"enemies/bosses/re2/em7000/attack1.ogg",
	"enemies/bosses/re2/em7000/attack2.ogg",
	"enemies/bosses/re2/em7000/attack3.ogg",
	"enemies/bosses/re2/em7000/attack4.ogg",
	"enemies/bosses/re2/em7000/attack5.ogg",
	"enemies/bosses/re2/em7000/attack6.ogg",
}
ENT.PainSounds = {
	"physics/flesh/flesh_impact_bullet1.wav",
	"physics/flesh/flesh_impact_bullet2.wav",
	"physics/flesh/flesh_impact_bullet3.wav",
	"physics/flesh/flesh_impact_bullet4.wav",
	"physics/flesh/flesh_impact_bullet5.wav"
}

ENT.DeathSounds = {
	"enemies/bosses/re2/em7000/pain6.ogg"
}

ENT.IdleSequence = "idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"slow_walk"
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 100, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"fast_walk",
				"fast_run"
			},
			AttackSequences = {MadAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {madsounds},
		},
	}}
}

function ENT:StatsInitialize()
	if SERVER then
		local data = nzRound:GetBossData(self.NZBossType)
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(500)
			self:SetMaxHealth(500)
			baseHealth = 500
		else
			self:SetHealth(nzRound:GetNumber() * data.scale + (data.health * count))
			self:SetMaxHealth(nzRound:GetNumber() * data.scale + (data.health * count))
			baseHealth = nzRound:GetNumber() * data.scale + (data.health * count)
		end
		self.Mutated = false
		enraged = false
		self.Deadge = false
		self.MutateTime = 0
		self.NextAction = 0
		self.NextTeleporTime = 0
		self:SetMooSpecial(true)
		self:SetRunSpeed( 50 )
		self.loco:SetDesiredSpeed( 50 )
		self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 70))
	end
end

function ENT:OnSpawn()

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:EmitSound("enemies/bosses/re2/em7000/hit_world4.ogg",511,100)
	ParticleEffect("bo3_panzer_landing",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)
	local seq = self:SelectSpawnSequence()
	if seq then
		self:PlaySequenceAndWait(seq)
			self:EmitSound("enemies/bosses/re2/em7000/vo/idle1.ogg",511,100)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmgInfo)
	
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		self:SetSpecialShouldDie(true)
		self:DoSpecialAnimation("death")
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/re2/em7100/down.ogg", 94, math.random(90,100))
			ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
				self.MutateTime = CurTime()  + math.Rand(1, 4) 
			self.Deadge = true
		--self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
end

function ENT:OnThink()
	if CurTime() > self.MutateTime and self.Deadge then
	self.G3 = ents.Create("nz_zombie_boss_G2")
				self.G3:SetPos(self:GetPos())
				self.G3:Spawn()
				self:Remove()
	end




end

function ENT:bonescaleup(a)
	for i=0,9 do
		timer.Simple(0.1*i,function()
			self:ManipulateBoneScale(self:LookupBone("R_UpperArm_s_scale"), Vector(0.3+(0.05*i),0.5+(0.05*i),0.5+(0.1*i)))
			self:ManipulateBoneScale(self:LookupBone("R_UpperArm_scale"), Vector(0.5+(0.05*i),0.7+(0.05*i),0.7+(0.05*i)))
			self:ManipulateBoneScale(self:LookupBone("R_Forearm_scale"), Vector(0.5+(0.05*i),0.7+(0.05*i),0.7+(0.15*i)))
			self:ManipulateBoneScale(self:LookupBone("R_Palm_scale"), Vector(0.5+(0.05*i),0.7+(0.05*i),0.7+(0.15*i)))
		end)
	end
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then
		--self:EmitSound("enemies/bosses/gunker/death_gore"..math.random(1,2)..".ogg", 90, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/re2/em7100/down.ogg", 94, math.random(90,100))
			ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
				self.MutateTime = CurTime()  + math.Rand(1, 4) 
			self.Deadge = true
		print("oops")
			--ParticleEffect("nbnz_gib_explosion",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			--self:Remove()
		end
	end)
end


function ENT:PlayAttackAndWait( name, speed )

	local len = self:SetSequence( name )
	speed = speed or 1

	self:ResetSequenceInfo()
	self:SetCycle( 0 )
	self:SetPlaybackRate( speed )

	local endtime = CurTime() + len / speed

	while ( true ) do

		if ( endtime < CurTime() ) then
			if !self:GetStop() then
				self:StartActivity( ACT_WALK )
				if enraged then
				enraged = false
				self:SetRunSpeed(100)
				self.loco:SetDesiredSpeed(100)
				self:SpeedChanged() -- Updates current anim to be a sprinting one.
				else
					self.loco:SetDesiredSpeed( self:GetRunSpeed() )
				end
			
			end
			return
		end
		if self:IsValidTarget( self:GetTarget() ) then
			self.loco:FaceTowards( self:GetTarget():GetPos() )
		end

		coroutine.yield()

	end

end

function ENT:OnInjured( dmgInfo )
		if dmgInfo:GetDamage() > self:Health() and not self.Deadge then
		dmgInfo:ScaleDamage(0)
		self:SetInvulnerable(true)
		self:SetSpecialShouldDie(true)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/re2/em7100/down.ogg", 94, math.random(90,100))
			ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
				self.MutateTime = CurTime()  + 8
			self.Deadge = true
		print("oops")
		self:DoSpecialAnimation("death")
		
		end
	local hitpos = dmgInfo:GetDamagePosition()
		local eyeball = self:GetBonePosition(self:LookupBone("ShoulderEyeball"))
	local headpos = self:GetBonePosition(self:LookupBone("Head"))
		
		if (hitpos:DistToSqr(headpos) < 20^2) or (hitpos:DistToSqr(eyeball) < 20^2) then
		print("ow that hurt asshole")
		dmgInfo:ScaleDamage(2)
		else
		dmgInfo:ScaleDamage(1)
		end
		if not self.Mutated and self:Health()< (baseHealth/2) then
	self:EmitSound("enemies/bosses/re2/em7000/vo/pain_big"..math.random(6)..".ogg")
	self:SetInvulnerable(true)
	self.Mutated = true
		print("its time for me to beat your ass")
				self:EmitSound("enemies/bosses/re2/em7000/vo/mutate"..math.random(6)..".ogg",511)
				self:EmitSound("enemies/bosses/re2/em7000/mutate"..math.random(3)..".ogg",511)
				self:DoSpecialAnimation("slow_change")
				self:bonescaleup()
				self:EmitSound("enemies/bosses/re2/em7000/mutate_finish"..math.random(6)..".ogg",511)
				self:SetRunSpeed(200)
				self.loco:SetDesiredSpeed(200)
				self:SpeedChanged() -- Updates current anim to be a sprinting one.
				self:SetInvulnerable(false)
			
end
end

function ENT:HandleAnimEvent(a,b,c,d,e)
	if e == "attackhit" then
		self:EmitSound("enemies/bosses/re2/em7000/swing"..math.random(1,6)..".ogg",80,math.random(95,100))
		if self.Mutated then
		self:EmitSound(self.AttackSoundsMAD[math.random(#self.AttackSoundsMAD)], 100, math.random(85, 105), 1, 2)
		else
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		end
		
		self:DoAttackDamage()
	end
	if e == "attackslam" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/re2/em7000/hit_world"..math.random(1,6)..".ogg",80,math.random(95,100))
		self:DoAttackDamage()
	end
	if e == "step" then
		self:EmitSound("enemies/bosses/re2/em7000/step"..math.random(1,6)..".ogg",80,math.random(95,100))
	end
		if e == "steprun" then
		self:EmitSound("enemies/bosses/re2/em7000/step_run"..math.random(1,6)..".ogg",80,math.random(95,100))
	end
end

-- A standard attack you can use it or create something fancy yourself


function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid( ent ) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end