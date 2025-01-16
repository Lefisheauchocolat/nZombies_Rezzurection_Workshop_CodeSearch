AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Cyborg Hound"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true

ENT.BloodType = "Robot"

ENT.Models = {
	{Model = "models/moo/_codz_ports/codol/cyborg/moo_codz_codol_cyborg_dog.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"idle"}

local AttackSequences = {
	{seq = "nz_ai_dog_attack_01"},
}

local JumpSequences = {
	{seq = "nz_ai_dog_run_mantle"},
}


ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

ENT.IdleSequence = "nz_ai_dog_idle_01"

ENT.DeathSequences = {
	"nz_ai_dog_death_01",
	"nz_ai_dog_death_02",
}

ENT.ElectrocutionSequences = {
	"nz_ai_dog_death_tesla_01",
	"nz_ai_dog_death_tesla_02",
	"nz_ai_dog_death_tesla_03",
	"nz_ai_dog_death_tesla_04",
	"nz_ai_dog_death_tesla_05",
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
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_devildog/vox/close/close_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/close/close_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/close/close_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/close/close_03.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_devildog/vox/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/attack/attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/attack/attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/attack/attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/attack/attack_06.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_devildog/vox/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/death/death_04.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/death/death_05.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/vox/death/death_06.mp3"),
}

ENT.SpiritSounds = {
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/exp_bo3/spirit/exp_hellhound_spirit_04.mp3"),
}

ENT.AppearSounds = {
	Sound("nz_moo/zombies/vox/_devildog/spawn/spawn_01.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_cyborg/steps/giant_demoman_step_01.mp3"),
	Sound("nz_moo/zombies/vox/_cyborg/steps/giant_demoman_step_02.mp3"),
	Sound("nz_moo/zombies/vox/_cyborg/steps/giant_demoman_step_03.mp3"),
	Sound("nz_moo/zombies/vox/_cyborg/steps/giant_demoman_step_04.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_cyborg/steps/giant_demoman_step_01.mp3"),
	Sound("nz_moo/zombies/vox/_cyborg/steps/giant_demoman_step_02.mp3"),
	Sound("nz_moo/zombies/vox/_cyborg/steps/giant_demoman_step_03.mp3"),
	Sound("nz_moo/zombies/vox/_cyborg/steps/giant_demoman_step_04.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ai_dog_walk_01",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ai_dog_trot_01",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ai_dog_run_01",
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
	end
	self:SetCollisionBounds(Vector(-9,-9, 0), Vector(9, 9, 72))
	self:SetSurroundingBounds(Vector(-20, -20, 0), Vector(20, 20, 72))
	
	self:SetRunSpeed( 36 )
	self.loco:SetDesiredSpeed( 36 )
	self:SetBloodColor(DONT_BLEED)
end

function ENT:OnSpawn()
	self:SetMaterial("invisible")
	self:SetInvulnerable(true)
	self:SetBlockAttack(true)
	self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/pre_spawn.mp3",511,100)
	ParticleEffect("hound_summon",self:GetPos(),self:GetAngles(),nil)
	--ParticleEffect("fx_hellhound_summon",self:GetPos(),self:GetAngles(),nil)

	self:TimeOut(0.85)
	
	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/strikes_00.mp3",511,100)

	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/spn_flux_l.mp3",100,100)
	self:EmitSound("nz_moo/zombies/vox/_devildog/spawn/spn_flux_r.mp3",100,100)

	ParticleEffectAttach("ins_skybox_lightning",PATTACH_ABSORIGIN_FOLLOW,self,0)
	
	self:SetMaterial("")
	self:SetInvulnerable(nil)
	self:SetBlockAttack(false)
	self:CollideWhenPossible()
	self:EmitSound(self.AppearSounds[math.random(#self.AppearSounds)], 511, math.random(85, 105), 1, 2)

end

function ENT:PerformDeath(dmgInfo)
	self.Dying = true
	if self:GetSpecialAnimation() then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		if IsValid(self) then
			if self.IgnitedFoxy then
				ParticleEffect("zmb_cyborg_hound_explosion",self:GetPos(),self:GetAngles(),nil)
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

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:PlaySequenceAndWait(seq)
		if IsValid(self) then
			self:EmitSound(self.SpiritSounds[math.random(#self.SpiritSounds)], 511, math.random(95, 105), 1, 2)
			
			if self.IgnitedFoxy then
				ParticleEffect("zmb_cyborg_hound_explosion",self:GetPos(),self:GetAngles(),nil)
				self:Explode( math.random( 25, 50 )) -- Doggy goes Kaboom! Since they explode on death theres no need for them to play death anims.
				self:Remove()
			else
				self:Remove()
			end
		end
	end)
end


function ENT:AI()
	if IsValid(self:GetTarget()) then
		local distToTarget = self:GetPos():Distance(self:GetTargetPosition())
		if not self.Sprinting and distToTarget < 750 then
			self.Sprinting = true
			self.IgnitedFoxy = true
			self:SetRunSpeed( 71 )
			self.loco:SetDesiredSpeed( 71 )
			self:SpeedChanged()

			util.SpriteTrail(self, 5, Color(0, 100, 255, 255), true, 45, 20, 0.75, 1 / 40 * 0.3, "materials/trails/plasma")
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

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end
