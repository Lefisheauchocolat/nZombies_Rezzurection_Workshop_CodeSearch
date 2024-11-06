AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Licker"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true
ENT.AttackRange = 100
ENT.DamageRange = 90
ENT.AttackDamage = 20

ENT.Models = {
	{Model = "models/specials/licker.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"reaction"}

local AttackSequences = {
	{seq = "att1"},
	{seq = "att2"}
}


local JumpSequences = {
	{seq = ACT_JUMP, speed = 100},
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

ENT.IdleSequence = "idle"

ENT.DeathSequences = {
	"flinch_kb_2",
}

ENT.ElectrocutionSequences = {
	"flinch_kb_2",
}

ENT.AttackSounds = {
	"enemies/specials/licker/atk1.ogg",
	"enemies/specials/licker/atk2.ogg",
	"enemies/specials/licker/atk3.ogg",
	"enemies/specials/licker/atk4.ogg",
	"enemies/specials/licker/atk5.ogg",
	"enemies/specials/licker/atk6.ogg",
}

local walksounds = {
	Sound("enemies/specials/licker/idle1.ogg"),
	Sound("enemies/specials/licker/idle2.ogg"),
	Sound("enemies/specials/licker/idle3.ogg"),
	Sound("enemies/specials/licker/idle4.ogg"),
	Sound("enemies/specials/licker/idle5.ogg"),
	Sound("enemies/specials/licker/idle6.ogg"),
	Sound("enemies/specials/licker/idle7.ogg"),
	Sound("enemies/specials/licker/idle8.ogg"),
	Sound("enemies/specials/licker/idle9.ogg"),
	Sound("enemies/specials/licker/idle10.ogg"),
	Sound("enemies/specials/licker/idle11.ogg"),
	Sound("enemies/specials/licker/idle12.ogg"),

}

ENT.DeathSounds = {
	"enemies/specials/licker/death1.ogg",
	"enemies/specials/licker/death2.ogg",
	"enemies/specials/licker/death3.ogg",
	"enemies/specials/licker/death4.ogg",
	"enemies/specials/licker/death5.ogg",
	"enemies/specials/licker/death6.ogg",
}

ENT.AppearSounds = {
	"enemies/specials/licker/spawn1.ogg",
	"enemies/specials/licker/spawn2.ogg",
	"enemies/specials/licker/spawn3.ogg",
	"enemies/specials/licker/spawn4.ogg",
	"enemies/specials/licker/spawn5.ogg",
	"enemies/specials/licker/spawn6.ogg",
}

ENT.ExplodeSounds = {
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_00.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_01.mp3"),
	Sound("nz_moo/zombies/vox/_mimic/explode/explode_02.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

ENT.LickerDodgeSequences = {
	"dodge_b",
	"dodge_l",
	"dodge_r",
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"walk",
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
		self:SetRunSpeed( 101 )
		self.loco:SetDesiredSpeed( 101 )
	end

	self.DodgeTime = CurTime() + math.Rand(1.34, 3.12)
end

function ENT:OnSpawn()
	self:SetMaterial("invisible")
	self:SetInvulnerable(true)
	self:SetBlockAttack(true)
	self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

	self:EmitSound("nz/hellhound/spawn/prespawn.wav",511,100)
	ParticleEffect("hound_summon",self:GetPos(),self:GetAngles(),nil)
	--ParticleEffect("fx_hellhound_summon",self:GetPos(),self:GetAngles(),nil)

	self:TimeOut(0.85)
	self:SetBodygroup(2,0)
	self:EmitSound("nz/hellhound/spawn/strike.wav",511,100)
	ParticleEffectAttach("ins_skybox_lightning",PATTACH_ABSORIGIN_FOLLOW,self,0)
	
	self:SetMaterial("")
	self:SetInvulnerable(nil)
	self:SetBlockAttack(false)
	self:CollideWhenPossible()
	self:EmitSound(self.AppearSounds[math.random(#self.AppearSounds)], 511, math.random(85, 105), 1, 2)

	nzRound:SetNextSpawnTime(CurTime() + 3) -- This one spawning delays others by 3 seconds
end

function ENT:PerformDeath(dmginfo)

	self.Dying = true

	local damagetype = dmginfo:GetDamageType()
	if damagetype == DMG_REMOVENORAGDOLL then
		self:Remove(dmginfo)
	end
	if IsValid(self) then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		self:EmitSound(self.ExplodeSounds[math.random(#self.ExplodeSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		self:EmitSound(self.ExplodeSWTSounds[math.random(#self.ExplodeSWTSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		ParticleEffect("zmb_monster_explosion", self:GetPos() + Vector(0,0,10), Angle(0,0,0), nil) 

		if IsValid(dmginfo) then
			self:Remove(dmginfo)
		else
			self:Remove()
		end
	end
end

function ENT:AI()
	local target = self.Target

	-- Attempt to jump out of target's aim.
	if self:IsAimedAt() and !nzPowerUps:IsPowerupActive("timewarp") then
		if self:TargetInRange(750) and !self.AttackIsBlocked and CurTime() > self.DodgeTime then
			if !self:IsFacingEnt(target) then return end
			if self:TargetInRange(70) then return end
			if IsValid(target) and target:IsPlayer() then
				local seq = self.LickerDodgeSequences[math.random(#self.LickerDodgeSequences)]

				if self:SequenceHasSpace(seq) and self:HasSequence(seq) then
					self:DoSpecialAnimation(seq, true, true)
					-- If there isn't space at all, don't dodge.
					self.DodgeTime = CurTime() + math.Rand(1.34, 3.12)
				end
			end
		end
	end

end

function ENT:HandleAnimEvent(a,b,c,d,e)
	if e == "attackhit" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "step" then
		self:EmitSound("enemies/specials/licker/step"..math.random(1,6)..".ogg",80,math.random(95,100))
	end
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid( ent ) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end