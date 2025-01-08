AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "William Berkin (Stage 3)"
ENT.Category = "Brainz"
ENT.Author = "Laby and GhostlyMoo"

--my head is not a penis

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true

ENT.AttackRange = 100

ENT.TraversalCheckRange = 80

ENT.Models = {
	{Model = "models/bosses/g3v3.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"reaction"}

ENT.DeathSequences = {
	"death"
}



ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

local AttackSequences = {
	{seq = "attack1"},
	{seq = "attack2"},
	{seq = "attack3"},
	{seq = "attack4"},
}

ENT.SlamSequences = {
	"attack4b"
}

local JumpSequences = {
	{seq = "land"}
}


local walksounds = {
	Sound("enemies/bosses/re2/em7200/breathe1.ogg"),
	Sound("enemies/bosses/re2/em7200/breathe2.ogg"),
	Sound("enemies/bosses/re2/em7200/breathe3.ogg"),
	Sound("enemies/bosses/re2/em7200/idle1.ogg"),
	Sound("enemies/bosses/re2/em7200/idle2.ogg"),
	Sound("enemies/bosses/re2/em7200/idle3.ogg"),
	Sound("enemies/bosses/re2/em7200/pain1.ogg"),
	Sound("enemies/bosses/re2/em7200/pain2.ogg"),
	Sound("enemies/bosses/re2/em7200/reaction3.ogg"),
	Sound("enemies/bosses/re2/em7200/pain3.ogg")

}

ENT.AttackSounds = {
	"enemies/bosses/re2/em7200/att1.ogg",
	"enemies/bosses/re2/em7200/att2.ogg",
	"enemies/bosses/re2/em7200/att3.ogg"

}

ENT.PainSounds = {
	"physics/flesh/flesh_impact_bullet1.wav",
	"physics/flesh/flesh_impact_bullet2.wav",
	"physics/flesh/flesh_impact_bullet3.wav",
	"physics/flesh/flesh_impact_bullet4.wav",
	"physics/flesh/flesh_impact_bullet5.wav"
}

ENT.DeathSounds = {
	"enemies/bosses/re2/em7100/pain6.ogg"
}

ENT.IdleSequence = "idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"walk"
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 150, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"run",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

function ENT:StatsInitialize()
	if SERVER then
		local data = nzRound:GetBossData(self.NZBossType)
		local count = #player.GetAllPlaying()
self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))
	self:SetSurroundingBounds(Vector(-50, -50, 0), Vector(50, 50, 100))
		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(5000)
			self:SetMaxHealth(5000)
		else
			self:SetHealth(nzRound:GetNumber() * data.scale + (data.health * count))
			self:SetMaxHealth(nzRound:GetNumber() * data.scale + (data.health * count))
		end
		
		self.NextAction = 0
		self.Charge = false
		self.ChargeTime = CurTime() + math.Rand(7.5, 20.25)
		self:SetMooSpecial(true)
		self:SetRunSpeed( 75 )
		self.loco:SetDesiredSpeed( 75 )
	end
end

function ENT:OnRemove()
	self:StopSound("enemies/bosses/re2/DRAMATICMUSIC.mp3")
end


function ENT:OnSpawn()

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:EmitSound("enemies/bosses/thrasher/tele_hand_up.ogg",511)
	self:SetInvulnerable(true)
	util.ScreenShake(self:GetPos(),100000,500000,0.4,2000)
	self:EmitSound("enemies/bosses/re2/DRAMATICMUSIC.mp3", 577, 100, 1, -1)
	ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
		self:EmitSound("enemies/bosses/gunker/death_gore"..math.random(1,2)..".ogg", 90, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		ParticleEffect("nbnz_gib_explosion",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
				ParticleEffect("divider_slash2",self:LocalToWorld(Vector(20,20,0)),Angle(0,0,0),nil)
				ParticleEffect("divider_slash3",self:LocalToWorld(Vector(20,20,0)),Angle(0,0,0),nil)
				ParticleEffect("baby_dead",self:LocalToWorld(Vector(20,20,0)),Angle(0,0,0),nil)
	self:EmitSound("enemies/bosses/re2/em7200/idle3.ogg",511,100)
	self:SetSpecialAnimation(true)
	local seq = self:SelectSpawnSequence()
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmgInfo)
	if self:GetSpecialAnimation() then
		self:EmitSound("enemies/bosses/re2/em7200/reaction1.ogg",511)
		if IsValid(self) then
		self:PlaySound("enemies/bosses/gunker/death_gore"..math.random(1,2)..".ogg", 90, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
			ParticleEffect("baby_dead",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			ParticleEffect("nbnz_gib_explosion",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			nzPowerUps:SpawnPowerUp(self:GetPos(), "bottle")
			self:Remove()
		end
	else
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:PostAdditionalZombieStuff()
	if SERVER then
		if !self.Charge and CurTime() > self.ChargeTime then
			self.Charge = true
			self:SetRunSpeed(175)
			self:SpeedChanged()
		end

		if self.Charge and self:TargetInRange(200) and !self:IsAttackBlocked() then
			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove("grab_1", 1, self.FaceEnemy)
			self:SetSpecialAnimation(false)

			self.Charge = false
			self.ChargeTime = CurTime() + math.Rand(10.5, 20.25) 
			self:SetRunSpeed(75)
			self:SpeedChanged()
		end
	end
end


function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then
		self:EmitSound("enemies/bosses/gunker/death_gore"..math.random(1,2)..".ogg", 90, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/re2/em7100/down.ogg", 94, math.random(90,100))
			ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			ParticleEffect("nbnz_gib_explosion",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
			nzPowerUps:SpawnPowerUp(self:GetPos(), "bottle")
			self:Remove()
		end
	end)
end


function ENT:OnPathTimeOut()
	local target = self:GetTarget()
	local actionchance = math.random(10)
	
local distToTarget = self:GetPos():Distance(target:GetPos())
	if CurTime() < self.NextAction then return end
			if  distToTarget < 400 and actionchance == 7 and CurTime() > self.NextAction then
			--HULK SMASH
			self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 90, math.random(85, 105), 1, 2)
			self:DoSpecialAnimation(self.SlamSequences[math.random(#self.SlamSequences)])
				self.NextAction = CurTime() + math.random(1, 20)
			
		end
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
					self.loco:SetDesiredSpeed( self:GetRunSpeed() )
				
			
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
	local hitpos = dmgInfo:GetDamagePosition()
		local eyeball = self:GetBonePosition(self:LookupBone("ShoulderEyeball"))
	local headpos = self:GetBonePosition(self:LookupBone("ChestEyeball"))
		
		if (hitpos:DistToSqr(headpos) < 15^2) or (hitpos:DistToSqr(eyeball) < 30^2) then
		--print("ow that hurt asshole")
		dmgInfo:ScaleDamage(1.5)
		else
		dmgInfo:ScaleDamage(0.5)
		end
		if   (hitpos:DistToSqr(eyeball) < 30^2) and dmgInfo:GetDamage() > 500   then
		--print("ow that really hurt asshole")
		if math.random(1,7) > 5 then
		--ParticleEffectAttach("bo3_explosion_micro", PATTACH_POINT_FOLLOW, self, 10)
		self:EmitSound("enemies/bosses/re2/em7200/eye_pop"..math.random(1,3)..".ogg", 90, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
				ParticleEffect("baby_dead",eyeball,Angle(0,0,0),nil)
				self.NextAction = CurTime() + math.random(1, 25)
				if math.random(1,5) > 2 then
				self:SetInvulnerable(true)
				self:EmitSound("enemies/bosses/re2/em7200/pain"..math.random(1,3)..".ogg",511,100)
				self:DoSpecialAnimation("flinch", true, false)
				self:SetInvulnerable(false)
				else
				self:EmitSound("enemies/bosses/re2/em7200/reaction2.ogg",511,100)
				self:DoSpecialAnimation("attack5", true, false)
				end
			end
		end
			
end


function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step" then
		util.ScreenShake(self:GetPos(),3000,500,0.2,700)
		self:EmitSound("enemies/bosses/re2/em7200/step"..math.random(1,3)..".ogg",70)
	end
	if e == "attackhit" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "attackslam" or e =="slam" or e =="down" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/re2/em7100/slam"..math.random(1,2)..".ogg", 100)
		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_far.mp3", 511)
		local clawpos = self:GetBonePosition(self:LookupBone("R_SecondHand_s"))
		ParticleEffect("bo3_panzer_landing",self:LocalToWorld(Vector(20+(1),20,0)),Angle(0,0,0),nil)
		ParticleEffect("bo3_margwa_slam",clawpos,self:GetAngles(),nil)
		util.ScreenShake(self:GetPos(),100000,500000,0.4,2000)
				for k, v in pairs(ents.FindInSphere(self:GetPos(), 350)) do
            	if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
                	if v:GetClass() == self:GetClass() then continue end
                	if v == self then continue end
                	if v:EntIndex() == self:EntIndex() then continue end
                	if v:Health() <= 0 then continue end
                	--if !v:Alive() then continue end
                	local expdamage = DamageInfo()
                	expdamage:SetAttacker(self)
                	expdamage:SetInflictor(self)
                	expdamage:SetDamageType(DMG_CRUSH)
                	expdamage:SetDamage(60)
                	expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
                	v:TakeDamageInfo(expdamage)
					v:NZSonicBlind(1)
            	end
        	end
	end
end	

-- A standard attack you can use it or create something fancy yourself
function ENT:Attack( data )

	self:SetLastAttack(CurTime())

	data = data or {}
	
	data.attackseq = data.attackseq
	if !data.attackseq then
		
		local attacktbl = self.AttackSequences
		local target = type(attacktbl) == "table" and attacktbl[math.random(#attacktbl)] or attacktbl
		
		if type(target) == "table" then
			local id, dur = self:LookupSequenceAct(target.seq)
			if !target.dmgtimes then
			data.attackseq = {seq = id, dmgtimes =  {0.5} }
			else
			data.attackseq = {seq = id, dmgtimes = target.dmgtimes }
			end
			data.attackdur = dur
		elseif target then -- It is a string or ACT
			local id, dur = self:LookupSequenceAct(attacktbl)
			data.attackseq = {seq = id, dmgtimes = {dur/2}}
			data.attackdur = dur
		else
			local id, dur = self:LookupSequence("swing")
			data.attackseq = {seq = id, dmgtimes = {1}}
			data.attackdur = dur
		end
	end
	
	self:SetAttacking( true )

	if self:GetTarget():IsPlayer() then
		for k,v in pairs(data.attackseq.dmgtimes) do
			self:TimedEvent( v, function()
				if self.AttackSounds then self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2) end
				self:EmitSound( "enemies/bosses/re2/em7200/att_swing"..math.random(1,3)..".ogg", 90, math.random(95, 105))
				
				if !self:GetStop() and self:IsValidTarget( self:GetTarget() ) and self:TargetInRange( self:GetAttackRange() + 10 ) then
					local dmgInfo = DamageInfo()
					dmgInfo:SetAttacker( self )
					dmgInfo:SetDamage( 90 ) -- OW, STUPID BITCH!!!!
					dmgInfo:SetDamageType( DMG_SLASH )
					dmgInfo:SetDamageForce( (self:GetTarget():GetPos() - self:GetPos()) * 7 + Vector( 0, 0, 16 ) )
					self:GetTarget():TakeDamageInfo(dmgInfo)
					if !IsValid(self:GetTarget()) then return end
					self:GetTarget():EmitSound( "enemies/bosses/re2/em7000/hit_body"..math.random(1,6)..".ogg", SNDLVL_TALKING, math.random(95,105))
					self:GetTarget():ViewPunch( VectorRand():Angle() * 0.01 )
				end
			end)
		end
	end

	self:TimedEvent(data.attackdur, function()
		self:SetAttacking(false)
		self:SetLastAttack(CurTime())
	end)

	self:PlayAttackAndWait(data.attackseq.seq, 1)
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid( ent ) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end