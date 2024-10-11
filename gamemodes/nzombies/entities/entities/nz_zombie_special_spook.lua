AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "WOLOLOLOLOLOLOLOLOLOLOLOLO"
ENT.PrintName = "PD2 Cloaker"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

if CLIENT then 
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")

	function ENT:DrawEyeGlow()
	
		local eyeColor = Color(80, 210, 0, 255)

		local latt = self:LookupAttachment("spook_lefteye")
		local ratt = self:LookupAttachment("spook_righteye")

		if latt == nil then return end
		if ratt == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)

		if leye == nil then return end
		if reye == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward() * 0.1 + leye.Ang:Right()
		local lefteyepos = reye.Pos + reye.Ang:Forward() * 0.1 + reye.Ang:Right()

		if lefteyepos and righteyepos then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 6, 6, eyeColor)
			render.DrawSprite(righteyepos, 6, 6, eyeColor)
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMiniBoss = true

ENT.AttackRange = 60
ENT.DamageRange = 90 
ENT.AttackDamage = 225

ENT.Models = {
	{Model = "models/wavy_ports/wavy_enemies/waw_custom/pd2_cloaker.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
}

local JumpSequences = {
	{seq = "nz_barricade_trav_walk_1"},
	{seq = "nz_barricade_trav_walk_2"},
	{seq = "nz_barricade_trav_walk_3"},
}

local RunJumpSequences = {
	{seq = "nz_barricade_sprint_1"},
	{seq = "nz_barricade_sprint_2"},
}

local AttackSequences = {
	{seq = "nz_spook_jump_kick"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_spook_walk",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
			AttackSequences = {AttackSequences},
		},
	}},
	{Threshold = 70, Sequences = {
		{
			MovementSequence = {
				"nz_spook_run",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			JumpSequences = {RunJumpSequences},
			PassiveSounds = {walksounds},
			AttackSequences = {AttackSequences},
		},
	}}
}

ENT.DeathSounds = {
	"nz_moo/zombies/vox/mute_00.wav",
}

ENT.CustomWalkFootstepsSounds = {
	"nz_moo/zombies/vox/_astro/fly_step/step_00.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_01.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_02.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_03.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_04.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_05.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_06.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_07.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_08.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_09.mp3"
}

ENT.CustomRunFootstepsSounds = {
	"nz_moo/zombies/vox/_astro/fly_step/step_00.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_01.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_02.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_03.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_04.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_05.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_06.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_07.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_08.mp3",
	"nz_moo/zombies/vox/_astro/fly_step/step_09.mp3"
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		local zhealth = nzRound:GetZombieHealth()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(500)
			self:SetMaxHealth(500)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(zhealth * 2 + (500 * count), 1000, 30000))
				self:SetMaxHealth(math.Clamp(zhealth * 2 + (500 * count), 1000, 30000))
			else
				self:SetHealth(2500)
				self:SetMaxHealth(2500)	
			end
		end

		self:SetRunSpeed(1)

		self.wololo = false
		self.WololoCooldown = CurTime() + 0
		self.RunCooldown = CurTime() + 3
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	self:EmitSound("wavy_zombie/pd2_cloaker/cloaker_spawn.mp3", 100)
	if IsValid(self) then ParticleEffect("bo3_gersch_kill", self:WorldSpaceCenter(), Angle(0,0,0), self) end
end

function ENT:PerformDeath(dmginfo)
	self:BecomeRagdoll(dmginfo)
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

function ENT:PostTookDamage(dmginfo)

	local attacker = dmginfo:GetAttacker()
	local target = self:GetTarget()
	
	if IsValid(attacker) and attacker:IsPlayer() and ( target:IsPlayer() and self:TargetInRange(1500) ) and CurTime() > self.RunCooldown and !self.wololo then
		self:EmitSound("wavy_zombie/pd2_cloaker/cloaker_agro.mp3", 500, 100, 1)
		self:SetRunSpeed(71)
		self:SpeedChanged()
		self.wololo = true
		self.WololoCooldown = CurTime() + 3.75
	end

end

function ENT:AI()

	local target = self:GetTarget()
	
	if CurTime() > self.WololoCooldown and self.wololo then
		self:SetRunSpeed(1)
		self:SpeedChanged()
		self.wololo = false
		self.RunCooldown = CurTime() + 3
	end
	
	if IsValid(target) then
		if target:IsPlayer() and self:TargetInRange(350) and !self:IsAttackBlocked() and CurTime() > self.RunCooldown and !self.wololo then
			self:EmitSound("wavy_zombie/pd2_cloaker/cloaker_agro.mp3", 500, 100, 1)
			self:SetRunSpeed(71)
			self:SpeedChanged()
			self.wololo = true
			self.WololoCooldown = CurTime() + 3.75
		end
	end
	
	--hiding code
	
end

function ENT:CustomAnimEvent(a,b,c,d,e)

	if e == "spook_kick" then
	
		local karatekid = self:GetTarget()
		local headbone = self:LookupBone( "j_head" )
		local headpos = self:GetBonePosition(headbone)
	
		if IsValid(karatekid) and karatekid:IsPlayer() then
			print("HIYAAAAAA")
			karatekid:NZAstroSlow(1)
			karatekid:SetEyeAngles( (headpos - karatekid:GetShootPos()):Angle() )
		end
		
		if math.random(10) == 1 then 
			self:EmitSound("wavy_zombie/pd2_cloaker/mk3_05595.mp3", 511, 100, 1)
		else
			self:EmitSound("wavy_zombie/pd2_cloaker/cloaker_attack_hit.mp3", 500, 100, 1)
		end
		if self.wololo then
			self:SetRunSpeed(1)
			self:SpeedChanged()
			self.wololo = false
			self.RunCooldown = CurTime() + 3
		end
	end

end
