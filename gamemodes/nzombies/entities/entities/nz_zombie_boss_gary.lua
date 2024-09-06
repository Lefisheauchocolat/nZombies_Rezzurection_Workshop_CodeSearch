AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Gary"
ENT.Category = "Brainz"
ENT.Author = "Laby and GhostlyMoo"

--Gary the Snail if he trained for 1 day

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.RedEyes = true
ENT.IsMooSpecial = true

ENT.AttackRange = 150

ENT.TraversalCheckRange = 80

ENT.Models = {
	{Model = "models/bosses/flood_tank.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"stalker_to_tank"}



ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

local AttackSequences = {
	{seq = "attack1"},
	{seq = "attack2"},
	{seq = "attack3"},
	{seq = "attack4"},
	{seq = "attack5"},
}


local JumpSequences = {
	{seq = "walk_protected"}
}


local walksounds = {
	Sound("enemies/bosses/flood_tank/slow1.mp3"),
	Sound("enemies/bosses/flood_tank/slow2.mp3"),
	Sound("enemies/bosses/flood_tank/slow3.mp3"),
	Sound("enemies/bosses/flood_tank/slow4.mp3"),
	Sound("enemies/bosses/flood_tank/slow5.mp3"),
	Sound("enemies/bosses/flood_tank/slow6.mp3"),
	Sound("enemies/bosses/flood_tank/slow7.mp3"),
	Sound("enemies/bosses/flood_tank/slow8.mp3"),
	Sound("enemies/bosses/flood_tank/slow9.mp3"),
	Sound("enemies/bosses/flood_tank/slow10.mp3"),
	Sound("enemies/bosses/flood_tank/slow11.mp3"),
	Sound("enemies/bosses/flood_tank/slow12.mp3"),
	Sound("enemies/bosses/flood_tank/slow13.mp3"),
	Sound("enemies/bosses/flood_tank/slow14.mp3"),
	Sound("enemies/bosses/flood_tank/slow15.mp3"),
	Sound("enemies/bosses/flood_tank/slow16.mp3"),
	Sound("enemies/bosses/flood_tank/slow17.mp3"),

}

local MADSOUNDS = {
	Sound("enemies/bosses/flood_tank/charge1.mp3"),
	Sound("enemies/bosses/flood_tank/charge2.mp3"),
	Sound("enemies/bosses/flood_tank/charge3.mp3"),
	Sound("enemies/bosses/flood_tank/charge4.mp3"),
	Sound("enemies/bosses/flood_tank/charge5.mp3")

}
ENT.AttackSounds = {
	"enemies/bosses/flood_tank/melee1.mp3",
	"enemies/bosses/flood_tank/melee2.mp3",
	"enemies/bosses/flood_tank/melee3.mp3",
	"enemies/bosses/flood_tank/melee4.mp3",
	"enemies/bosses/flood_tank/melee5.mp3",
	"enemies/bosses/flood_tank/melee6.mp3"


}

ENT.PainSounds = {
	"physics/flesh/flesh_impact_bullet1.wav",
	"physics/flesh/flesh_impact_bullet2.wav",
	"physics/flesh/flesh_impact_bullet3.wav",
	"physics/flesh/flesh_impact_bullet4.wav",
	"physics/flesh/flesh_impact_bullet5.wav"
}

ENT.DeathSounds = {
	"enemies/bosses/flood_tank/dth1.mp3",
	"enemies/bosses/flood_tank/dth2.mp3",
	"enemies/bosses/flood_tank/dth3.mp3",
	"enemies/bosses/flood_tank/dth4.mp3",
	"enemies/bosses/flood_tank/dth5.mp3",
	"enemies/bosses/flood_tank/dth6.mp3",
	"enemies/bosses/flood_tank/dth7.mp3",
	"enemies/bosses/flood_tank/dth8.mp3",
	"enemies/bosses/flood_tank/dth9.mp3",
	"enemies/bosses/flood_tank/dth10.mp3",
	"enemies/bosses/flood_tank/dth11.mp3",
	"enemies/bosses/flood_tank/dth12.mp3",
	"enemies/bosses/flood_tank/dth13.mp3",
}

ENT.IdleSequence = "idle", "idle2"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"walk_protected"
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
				"walk"
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 200, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"run",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {MADSOUNDS},
		},
	}}
}

function ENT:StatsInitialize()
	if SERVER then
		local data = nzRound:GetBossData(self.NZBossType)
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(1000)
			self:SetMaxHealth(1000)
		else
			self:SetHealth(nzRound:GetNumber() * data.scale + (data.health * count))
			self:SetMaxHealth(nzRound:GetNumber() * data.scale + (data.health * count))
		end
		dmgbuffer = 0
		weblockthose = false
		enraged = false
		self.Deadge = false
		self.NextAction = 0
		self.NextHealTime =200
		self:SetMooSpecial(true)
		self:SetRunSpeed( 110 )
		self.loco:SetDesiredSpeed( 110 )
		self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 70))
	end
end


function ENT:OnSpawn()

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
--self:EmitSound("enemies/bosses/thrasher/tele_hand_up.ogg",511)
	self:SetInvulnerable(true)
	ParticleEffect("bo3_margwa_death",self:LocalToWorld(Vector(0,0,0)),Angle(0,0,0),nil)
		self:EmitSound("enemies/bosses/gunker/death_gore"..math.random(1,2)..".ogg", 90, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		self:EmitSound("enemies/bosses/divider/divider_merge_18.ogg", 94, math.random(90,100))
		--for i = 1,self:GetBoneCount()/2 do
			--ParticleEffect("cpt_blood_flood",self:GetBonePosition(math.random(0,self:GetBoneCount())),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
		--end
	self:EmitSound("enemies/bosses/flood_tank/charge1.mp3",511,100)
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
	
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			self:EmitSound("physics/flesh/flesh_bloody_break.wav",math.random(80,95),math.random(85,100))
		for i = 1,self:GetBoneCount() -1 do
			ParticleEffect("cpt_blood_flood",self:GetBonePosition(i),Angle(math.Rand(0,360),math.Rand(0,360),math.Rand(0,360)),nil)
		end
			self:Remove()
		end
end

function ENT:OnThink()
if CurTime() < self.NextHealTime then return end
self:SetHealth(self:Health() + dmgbuffer)
dmgbuffer = 0
self.NextHealTime = CurTime() + math.random(5, 15)
end

function ENT:OnPathTimeOut()
	local target = self:GetTarget()
	local actionchance = math.random(6)
	
local distToTarget = self:GetPos():Distance(target:GetPos())
	if CurTime() < self.NextAction then return end
			--if  distToTarget < 500 and actionchance == 7 and CurTime() > self.NextAction then
			--GET HIS ASS, MY DEMONSPAWN
			--self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 90, math.random(85, 105), 1, 2)
			--self:DoSpecialAnimation(self.SlamSequences[math.random(#self.SlamSequences)])
				--self.NextAction = CurTime() + math.random(1, 20)
			
			if not enraged and not weblockthose and actionchance == 2 and CurTime() > self.NextAction then
				enraged = true -- YOU HAVE ANGERED GARY
				self:EmitSound("enemies/bosses/flood_tank/charge1.mp3",511,100)
				--ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,60)),Angle(0,0,0),nil)	
				--self:DoSpecialAnimation("attack_big3a")
				self:SetRunSpeed(200)
				self.loco:SetDesiredSpeed(200)
				self:SpeedChanged() -- Updates current anim to be a sprinting one.
				self.NextAction = CurTime() + math.random(10, 15)
			end
		end


function ENT:PlayAttackAndWait( name, speed )

	local len = self:SetSequence( name )
	speed = speed or 1

	self:ResetSequenceInfo()
	self:SetCycle( 0 )
	self:SetPlaybackRate( speed )
	weblockthose=false
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
		
		if weblockthose then
		dmgInfo:ScaleDamage(0.4)
		else
		dmgInfo:ScaleDamage(0.8)
		dmgbuffer = dmgbuffer + dmgInfo:GetDamage()
		end
		if not weblockthose and not enraged and dmgbuffer > 450 then
		dmgbuffer = 0
				weblockthose = true
				self:SetRunSpeed(90)
				self.loco:SetDesiredSpeed(90)
				self:SpeedChanged() -- Updates current anim to be a sprinting one.
				self.NextAction = CurTime() + math.random(1, 20)
		end
			
end


function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "tank_step" then
		util.ScreenShake(self:GetPos(),1,1,0.2,650)
		self:EmitSound("enemies/bosses/re2/em7100/step"..math.random(1,2)..".ogg",70)
	end
	if e == "event_mattack" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "event_impact"  then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:EmitSound("enemies/bosses/re2/em7100/slam"..math.random(1,2)..".ogg", 100)
		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_far.mp3", 511)
		ParticleEffect("bo3_margwa_slam",self:GetPos(),self:GetAngles(),nil)
		util.ScreenShake(self:GetPos(),100000,500000,0.4,2000)
				for k, v in pairs(ents.FindInSphere(self:GetPos(), 300)) do
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
                	expdamage:SetDamage(75)
                	expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
                	v:TakeDamageInfo(expdamage)
					v:NZSonicBlind(1)
            	end
        	end
			util.ScreenShake(self:GetPos(), 20, 255, 1.5, 400)
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
				self:EmitSound("enemies/bosses/re2/em7000/swing"..math.random(1,6)..".ogg",80,math.random(95,100))
				
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