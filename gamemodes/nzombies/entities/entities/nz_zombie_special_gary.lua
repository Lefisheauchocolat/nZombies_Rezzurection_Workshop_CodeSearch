AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Gary"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true
ENT.AttackRange = 80

ENT.Models = {
	{Model = "models/specials/Gary6.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"idle"}

local AttackSequences = {
	{seq = "Skill 1", dmgtimes = {0.3}},
}

local JumpSequences = {
	{seq = "Skill 2 Start", speed = 100},
}


ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

ENT.IdleSequence = "idle"

ENT.DeathSequences = {
	"Death",
}

ENT.ElectrocutionSequences = {
	"Victory",
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_04.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_05.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_06.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_07.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_08.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_09.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_10.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/move/move_11.mp3"),
	Sound("gary/meow.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_devildog/vox/close/close_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/close/close_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/close/close_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/close/close_03.mp3"),
}

ENT.AttackSounds = {
	Sound("gary/hiss.mp3"),
}

ENT.DeathSounds = {
		Sound("gary/death.mp3"),
}

ENT.SpiritSounds = {
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_04.mp3"),
}

ENT.AppearSounds = {
	Sound("gary/meow.mp3"),
}

ENT.niggaimgonnablow = {
	Sound("gary/bombs1.wav"),
	Sound("gary/bombs2.wav"),
	Sound("gary/bombs3.wav"),
	Sound("gary/bombs4.wav"),
	Sound("gary/bombs5.wav"),
}
ENT.DogStepSounds = {
	Sound("gary/sfx_ch_gary_ftstp_001.mp3"),
	Sound("gary/sfx_ch_gary_ftstp_002.mp3"),
	Sound("gary/sfx_ch_gary_ftstp_003.mp3"),
	Sound("gary/sfx_ch_gary_ftstp_004.mp3"),
	Sound("gary/sfx_ch_gary_ftstp_005.mp3"),
	Sound("gary/sfx_ch_gary_ftstp_006.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"Walk",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 90, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"Run1",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 190, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"Run2",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 390, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"Run3",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 790, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"Run4",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 900, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"imkillingyou",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}}
	
}

function ENT:StatsInitialize()
	if SERVER then
		self:SetHealth( nzRound:GetZombieHealth() * 0.25 or 75 )
		self:SetMaxHealth( self:Health() )
		
		self.Sprinting = false
		self.IgnitedFoxy = false
		self.anger = 100
	end
	self:SetCollisionBounds(Vector(-9,-9, 0), Vector(9, 9, 72))
	self:SetSurroundingBounds(Vector(-20, -20, 0), Vector(20, 20, 72))
	self.SameSquare = false
	self:SetRunSpeed( 80 )
	self.loco:SetDesiredSpeed( 80 )
	self:SpeedChanged()
end

function ENT:OnSpawn()
	self:SetMaterial("invisible")
	self:SetInvulnerable(true)
	self:SetBlockAttack(true)
	self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/pre_spawn.mp3",511,100)
	self:EmitSound("gary/flux1.mp3",100,100)
	ParticleEffect("hound_summon",self:GetPos(),self:GetAngles(),nil)
	--ParticleEffect("fx_hellhound_summon",self:GetPos(),self:GetAngles(),nil)

	self:TimeOut(0.85)
	
	self:EmitSound("gary/flux2.mp3",100,100)
	--self:EmitSound("gary/meow.mp3",100,100)
	--self:EmitSound("gary/meow.mp3",100,100)
	ParticleEffectAttach("ins_skybox_lightning",PATTACH_ABSORIGIN_FOLLOW,self,0)
	
	self:SetMaterial("")
	self:SetInvulnerable(nil)
	self:SetBlockAttack(false)
	self:CollideWhenPossible()
	self:SetRunSpeed( 80 )
	self.loco:SetDesiredSpeed( 80 )
	self:SpeedChanged()
	self:EmitSound(self.AppearSounds[math.random(#self.AppearSounds)], 511, math.random(85, 105), 1, 2)

end

function ENT:PerformDeath(dmgInfo)
	self.Dying = true
	if self:GetSpecialAnimation() then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			if self.IgnitedFoxy then
				ParticleEffect("hound_explosion",self:GetPos(),self:GetAngles(),self)
				self:Explode( math.random( 25, 50 )) -- Doggy goes Kaboom! Since they explode on death theres no need for them to play death anims.
				self:Remove()
			else
				self:Remove()
			end
		end
	else
		if dmgInfo:GetDamageType() == DMG_SHOCK then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			self:DoDeathAnimation(self.ElectrocutionSequences[math.random(#self.ElectrocutionSequences)])
		else
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
		end
	end
end

function ENT:OnRemove()
	self:StopSound("gary/goodbye.wav")
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then
			self:EmitSound(self.DeathSounds[math.random(#self.DeathSounds)], 511, math.random(95, 105), 1, 2)
			
			--if self.IgnitedFoxy then
				ParticleEffect("hound_explosion",self:GetPos(),self:GetAngles(),self)
				self:PlaySound(self.niggaimgonnablow[math.random(#self.niggaimgonnablow)])
				self:Explode( math.random( 25, 50 )) -- Doggy goes Kaboom! Since they explode on death theres no need for them to play death anims.
				self:Remove()
			--else
			--	self:Remove()
			--end
		end
	end)
end


function ENT:AI()
	if IsValid(self:GetTarget()) then
		local distToTarget = self:GetPos():Distance(self:GetTargetPosition())
		if not self.Sprinting and distToTarget < 200 then
			self.Sprinting = true
			--self.IgnitedFoxy = true
			print("im coming")
			self:SetRunSpeed( 500 )
			self.loco:SetDesiredSpeed( 500 )
			self:SpeedChanged()
			--self:Flames(true)
		end
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
				self:ResetMovementSequence()
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

function ENT:OnInjured(dmginfo)
	 if not self.Sprinting then
	 self.anger = self.anger * 2
	 if self.anger >900 then
	 self.Sprinting = true
	 end
	 print("your pissin me off")
			self:SetRunSpeed( self.anger )
			self.loco:SetDesiredSpeed( self.anger )
			self:SpeedChanged()
	 end
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "melee" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "death_ragdoll" then
		self:BecomeRagdoll(DamageInfo())
	end
	if e == "Death" then
		self:EmitSound("gary/goodbye.wav")
	end
	if e == "start_traverse" then
		--print("starttraverse")
		self.TraversalAnim = true
	end
	if e == "finish_traverse" then
		--print("finishtraverse")
		self.TraversalAnim = false
	end
	if e == "MoveS" then
		self:EmitSound(self.DogStepSounds[math.random(#self.DogStepSounds)], 75, math.random(95,105))
	end
end