AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "TAAAAAAAAANK!"
ENT.PrintName = "Tank"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "Wavy"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

local resist = {
	[DMG_BLAST] = true,
	[DMG_ENERGYBEAM] = true,
	[DMG_MISSILEDEFENSE] = true,
}

local meleetypes = {
    [DMG_CLUB] = true,
    [DMG_SLASH] = true,
    [DMG_CRUSH] = true,
}

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true

ENT.AttackRange = 110
ENT.DamageRange = 110
ENT.AttackDamage = 80

ENT.SoundDelayMin = 1.75
ENT.SoundDelayMax = 2.75
ENT.MinSoundPitch = 98 				-- Limits the minimum pitch for passive sounds the zombie can make.
ENT.MaxSoundPitch = 102 				-- Limits the maximum pitch for passive sounds the zombie can make.
ENT.SoundVolume = 150

ENT.Models = {
	{Model = "models/wavy_ports/wavy_enemies/l4d/l4d1_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/l4d2_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/sacrifice_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/kbar_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/flesh_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/warfare_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/urban_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/mutilated_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/maniac_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/haggard_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/football_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/military_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_ports/wavy_enemies/l4d/police_hulk.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_ports/l4d/infected/hulk_remastered/spicyjam_hulk.mdl", Skin = 0, Bodygroups = {0,0}}, -- Army man
}

local util_tracehull = util.TraceHull
local spawn = {"nz_hulk_traverse_climbup150", "nz_hulk_traverse_climbup166"}

ENT.DeathSequences = {
	"nz_hulk_death_1",
	"nz_hulk_death_2"
}

ENT.IdleSequence = "nz_hulk_idle"

ENT.BarricadeTearSequences = {
	"nz_hulk_attack_stand"
}

local SlowClimbUp36 = {
	"nz_hulk_traverse_climbup38"
}
local SlowClimbUp48 = {
	"nz_hulk_traverse_climbup50"
}
local SlowClimbUp72 = {
	"nz_hulk_traverse_climbup70"
}
local SlowClimbUp96 = {
	"nz_hulk_traverse_climbup115"
}
local SlowClimbUp128 = {
	"nz_hulk_traverse_climbup130"
}
local SlowClimbUp160 = {
	"nz_hulk_traverse_climbup150"
}

local AttackSequences = {
	{seq = "nz_hulk_attack_stand"},
}

local RunAttackSequences = {
	{seq = "nz_hulk_attack"},
}

local JumpSequences = {
	{seq = "nz_hulk_traverse"},
}

ENT.RockThrowSequences = {
	"nz_hulk_rockthrow_1",
	"nz_hulk_rockthrow_2",
	"nz_hulk_rockthrow_3",
}

ENT.VictorySequences = {
	"nz_hulk_victory_1",
	"nz_hulk_victory_2",
	"nz_hulk_victory_3",
	"nz_hulk_victory_4",
}

local walksounds = {
	Sound("wavy_zombie/hulk/tank_breathe_01.wav"),
	Sound("wavy_zombie/hulk/tank_breathe_02.wav"),
	Sound("wavy_zombie/hulk/tank_breathe_03.wav"),
	Sound("wavy_zombie/hulk/tank_breathe_04.wav"),
	Sound("wavy_zombie/hulk/tank_breathe_05.wav"),
	Sound("wavy_zombie/hulk/tank_breathe_06.wav"),
	Sound("wavy_zombie/hulk/tank_breathe_07.wav"),
	Sound("wavy_zombie/hulk/tank_breathe_08.wav"),
}

local runsounds = {
	Sound("wavy_zombie/hulk/tank_yell_01.wav"),
	Sound("wavy_zombie/hulk/tank_yell_02.wav"),
	Sound("wavy_zombie/hulk/tank_yell_03.wav"),
	Sound("wavy_zombie/hulk/tank_yell_04.wav"),
	Sound("wavy_zombie/hulk/tank_yell_05.wav"),
	Sound("wavy_zombie/hulk/tank_yell_06.wav"),
	Sound("wavy_zombie/hulk/tank_yell_07.wav"),
	Sound("wavy_zombie/hulk/tank_yell_08.wav"),
	Sound("wavy_zombie/hulk/tank_yell_09.wav"),
	Sound("wavy_zombie/hulk/tank_yell_10.wav"),
	Sound("wavy_zombie/hulk/tank_yell_12.wav"),
	Sound("wavy_zombie/hulk/tank_yell_16.wav"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_hulk_walk",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},

			PassiveSounds = {walksounds},
		}
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnrun},
			MovementSequence = {
				"nz_hulk_run_1",
				"nz_hulk_run_2",
			},
			SpawnSequence = {spawn},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},

			PassiveSounds = {runsounds},
		}
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_hulk_run_angry",
			},
			SpawnSequence = {spawn},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},

			PassiveSounds = {runsounds},
		}
	}}
}

ENT.DeathSounds = {
	"wavy_zombie/hulk/tank_death_01.wav",
	"wavy_zombie/hulk/tank_death_02.wav",
	"wavy_zombie/hulk/tank_death_03.wav",
	"wavy_zombie/hulk/tank_death_04.wav",
	"wavy_zombie/hulk/tank_death_05.wav",
	"wavy_zombie/hulk/tank_death_06.wav",
	"wavy_zombie/hulk/tank_death_07.wav",
	"wavy_zombie/hulk/hulk_die_2.wav",
}

ENT.AttackSounds = {
	"wavy_zombie/hulk/tank_attack_01.wav",
	"wavy_zombie/hulk/tank_attack_02.wav",
	"wavy_zombie/hulk/tank_attack_03.wav",
	"wavy_zombie/hulk/tank_attack_04.wav",
	"wavy_zombie/hulk/tank_attack_05.wav",
	"wavy_zombie/hulk/tank_attack_06.wav",
	"wavy_zombie/hulk/tank_attack_07.wav",
	"wavy_zombie/hulk/tank_attack_08.wav",
	"wavy_zombie/hulk/tank_attack_09.wav",
	"wavy_zombie/hulk/tank_attack_10.wav"
}

ENT.CustomWalkFootstepsSounds = {
	"wavy_zombie/hulk/tank_walk01.wav",
	"wavy_zombie/hulk/tank_walk02.wav",
	"wavy_zombie/hulk/tank_walk03.wav",
	"wavy_zombie/hulk/tank_walk04.wav",
	"wavy_zombie/hulk/tank_walk05.wav",
	"wavy_zombie/hulk/tank_walk06.wav",
}

ENT.CustomRunFootstepsSounds = {
	"wavy_zombie/hulk/tank_walk01.wav",
	"wavy_zombie/hulk/tank_walk02.wav",
	"wavy_zombie/hulk/tank_walk03.wav",
	"wavy_zombie/hulk/tank_walk04.wav",
	"wavy_zombie/hulk/tank_walk05.wav",
	"wavy_zombie/hulk/tank_walk06.wav",
}

ENT.RockThrowSounds = {
	"wavy_zombie/hulk/tank_throw_01.wav",	
	"wavy_zombie/hulk/tank_throw_02.wav",
	"wavy_zombie/hulk/tank_throw_03.wav",
	"wavy_zombie/hulk/tank_throw_04.wav",
	"wavy_zombie/hulk/tank_throw_05.wav",
	"wavy_zombie/hulk/tank_throw_06.wav",
	"wavy_zombie/hulk/tank_throw_09.wav",
	"wavy_zombie/hulk/tank_throw_10.wav",
	"wavy_zombie/hulk/tank_throw_11.wav",
}

ENT.TankMusic = {
	"wavy_zombie/hulk/tank.wav",
	"wavy_zombie/hulk/taank.wav",
	"wavy_zombie/hulk/midnighttank.wav",
	"wavy_zombie/hulk/onebadtank.wav",
	"wavy_zombie/hulk/tank_metal.wav",
	"wavy_zombie/hulk/tank_tbm.wav",
	"wavy_zombie/hulk/tank.wav",
	"wavy_zombie/hulk/taank.wav",
	"wavy_zombie/hulk/midnighttank.wav",
	"wavy_zombie/hulk/onebadtank.wav",
	"wavy_zombie/hulk/tank_metal.wav",
	"wavy_zombie/hulk/tank_tbm.wav",
	"wavy_zombie/hulk/tank.wav",
	"wavy_zombie/hulk/taank.wav",
	"wavy_zombie/hulk/midnighttank.wav",
	"wavy_zombie/hulk/onebadtank.wav",
	"wavy_zombie/hulk/tank_metal.wav",
	"wavy_zombie/hulk/tank_tbm.wav",
	"wavy_zombie/hulk/tank.wav",
	"wavy_zombie/hulk/taank.wav",
	"wavy_zombie/hulk/midnighttank.wav",
	"wavy_zombie/hulk/onebadtank.wav",
	"wavy_zombie/hulk/tank_metal.wav",
	"wavy_zombie/hulk/tank_tbm.wav",
	"wavy_zombie/hulk/tank_x.wav",
}

ENT.CustomAttackImpactSounds = {
	"wavy_zombie/hulk/hulk_punch_1.wav",
}

ENT.ShotPainSounds = {
	Sound("wavy_zombie/hulk/tank_pain_01.wav"),
	Sound("wavy_zombie/hulk/tank_pain_02.wav"),
	Sound("wavy_zombie/hulk/tank_pain_03.wav"),
	Sound("wavy_zombie/hulk/tank_pain_04.wav"),
	Sound("wavy_zombie/hulk/tank_pain_05.wav"),
	Sound("wavy_zombie/hulk/tank_pain_06.wav"),
	Sound("wavy_zombie/hulk/tank_pain_07.wav"),
	Sound("wavy_zombie/hulk/tank_pain_08.wav"),
	Sound("wavy_zombie/hulk/tank_pain_09.wav"),
	Sound("wavy_zombie/hulk/tank_pain_10.wav"),
}

ENT.BehindSoundDistance = 1 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(1000)
			self:SetMaxHealth(1000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 1500 + (3000 * count), 10000, 63000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 1500 + (3000 * count), 10000, 63000 * count))
			else
				self:SetHealth(10000)
				self:SetMaxHealth(10000)	
			end
		end

		-- Now using because the timeout no longer pauses nextbot movements.
		self:SetRunSpeed(nzRound:GetNumber() >= 35 and 155 or 71) -- could be useful later, but the tanks supersprint is so fast he constantly times out lol
		--self:SetRunSpeed(71)
		self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 72))			-- Nextbots Collision Box(Mainly for interacting with the world.)
		self:SetSurroundingBounds(Vector(-40, -40, 0), Vector(40, 40, 90)) 	-- Nextbots Surrounding Bounds(For Hitbox detection.)
		
		self.SmashCooldown = CurTime() + 4
		self.CanSmash = false
		self.Smashing = false
		self.RockCooldown = CurTime() + 4
		self.CanThrow = false
		self.Throwing = false
		self.HasPoppedOff = false
		self.IsPoppingOff = false
		self.PainSoundCooldown = CurTime() + 1
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)
	ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
	ParticleEffect("bo3_panzer_landing",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)

	self:StartMusic()

	self:EmitSound("wavy_zombie/hulk/hulk_yell_"..math.random(1,8)..".wav", 511, 100, 1, 2)
	self:EmitSound("enemies/bosses/thrasher/tele_hand_up.ogg", 511)
	self:EmitSound("nz/zombies/spawn/zm_spawn_dirt"..math.random(1,2)..".wav",80,math.random(95,105))

	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:OnTakeDamage(dmginfo)
	if !self:Alive() then return end
	if resist[dmginfo:GetDamageType()] then
		dmginfo:ScaleDamage(0.2)
	end
	if meleetypes[dmginfo:GetDamageType()] then
		dmginfo:ScaleDamage(3)
	end
	if CurTime() > self.PainSoundCooldown then
		self:EmitSound(self.ShotPainSounds[math.random(#self.ShotPainSounds)], 150, 100, 1, 2)
		self.PainSoundCooldown = CurTime() + 1
	end
end

function ENT:PostDeath()
	self:StopSound("wavy_zombie/hulk/tank.wav")
	self:StopSound("wavy_zombie/hulk/taank.wav")
	self:StopSound("wavy_zombie/hulk/midnighttank.wav")
	self:StopSound("wavy_zombie/hulk/onebadtank.wav")
	self:StopSound("wavy_zombie/hulk/tank_x.wav")
	self:StopSound("wavy_zombie/hulk/tank_metal.wav")
	self:StopSound("wavy_zombie/hulk/tank_tbm.wav")
	self:StartMusic()
end

function ENT:OnRemove()
	self:StopSound("wavy_zombie/hulk/tank.wav")
	self:StopSound("wavy_zombie/hulk/taank.wav")
	self:StopSound("wavy_zombie/hulk/midnighttank.wav")
	self:StopSound("wavy_zombie/hulk/onebadtank.wav")
	self:StopSound("wavy_zombie/hulk/tank_x.wav")
	self:StopSound("wavy_zombie/hulk/tank_metal.wav")
	self:StopSound("wavy_zombie/hulk/tank_tbm.wav")
	self:StartMusic()
end

function ENT:PerformDeath(dmginfo)

	self.Dying = true

	local damagetype = dmginfo:GetDamageType()
	local attacker = dmginfo:GetAttacker()
	if IsValid(attacker) and attacker:IsPlayer() and TFA.BO3GiveAchievement and meleetypes[dmginfo:GetDamageType()] then
		if not attacker.TANK_BURGER then
		TFA.BO3GiveAchievement("TANK BURGER", "vgui/Achievement_Tank_Burger.png", attacker)
		attacker.TANK_BURGER = true
		end
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 500, math.random(95, 105), 1, 2)
end

function ENT:PostAdditionalZombieStuff()
	if self:GetSpecialAnimation() then return end
	if CurTime() > self.SmashCooldown and !self.CanSmash then
		self.CanSmash = true
	end
	if CurTime() > self.RockCooldown and !self.CanThrow then
		self.CanThrow = true
	end
	if self:TargetInRange(250) and !self:IsAttackBlocked() and self.CanSmash then
		if !self:GetTarget():IsPlayer() then return end
		self:HulkSmash()
	end
	if self:TargetInRange(900) and !self:IsAttackBlocked() and self.CanThrow then 
		if !self:GetTarget():IsPlayer() then return end
		if self:TargetInRange(300) then return end
		self:RockThrow()
	end


	-- Knock normal zombies aside
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.Non3arcZombie and (v.IsMooSpecial and v.MooSpecialZombie or !v.IsMooSpecial and !v.MooSpecialZombie) and v ~= self then
			if self:GetRangeTo( v:GetPos() ) < 10^2 then	
				if v.IsMooZombie and (v.IsMooSpecial and v.MooSpecialZombie or !v.IsMooSpecial and !v.MooSpecialZombie) and !v:GetSpecialAnimation() and self:GetRunSpeed() > 36 then
					if v.PainSequences then
						v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
					end
				end
			end
		end
	end
end

function ENT:HulkSmash()
	self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(95, 105), 1, 2)
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Smashing = true
		self:PlaySequenceAndMove("nz_hulk_attack_low_2", 1)
		self.Smashing = false
		self.CanSmash = false
		self:SetSpecialAnimation(false)
		self.SmashCooldown = CurTime() + 8
	end)
end

function ENT:RockThrow()
	local rockseq = self.RockThrowSequences[math.random(#self.RockThrowSequences)]
	local vicseq = self.VictorySequences[math.random(#self.VictorySequences)]
	self:EmitSound("wavy_zombie/hulk/rip_up_rock_1.wav", 511, 100, 1, 2)
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Throwing = true
		self:PlaySequenceAndMove(rockseq, 1, self.FaceEnemy)
		if math.random(3) == 1 then
			self:PlaySequenceAndMove(vicseq, 1)
		end
		self.Throwing = false
		self.CanThrow = false
		self:SetSpecialAnimation(false)
		self.RockCooldown = CurTime() + 6
	end)
end

-- Multiple Tanks won't cause music overlap -Moo :wind_blowing_face:
-- Thanks for the Twitch Prime :baby_tone5:
function ENT:StartMusic()
	local found = false
	for k, v in pairs(ents.FindByClass("nz_zombie_boss_hulk")) do
		if IsValid(v) and !found and !v.Dying and v:Alive() then
			found = true
			v:EmitSound("nz_moo/zombies/vox/mute_00.wav", 1, 1, 1, -1)
			v:EmitSound(v.TankMusic[math.random(#v.TankMusic)], 577, 100, 1, -1)
		end
	end
end

function ENT:OnGameOver()
	if !self.HasPoppedOff and !self.IsPoppingOff then
	self.HasPoppedOff = true
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.IsPoppingOff = true
		self:PlaySequenceAndMove("nz_hulk_popoff", 1)
		self.IsPoppingOff = false
		self:SetSpecialAnimation(false)
	end)
	end
end

function ENT:DoAttackDamage() -- Moo Mark 4/14/23: Made the part that does damage during an attack its own function.
	local target = self:GetTarget()

	local damage = self.AttackDamage
	local dmgrange = self.DamageRange
	local range = self.AttackRange

	if self:GetIsBusy() and !self.BarricadeArmReach then return end

	if self:GetIsBusy() then
		range = self.AttackRange + 45
		dmgrange = self.DamageRange + 45
	else
		range = self.AttackRange + 25
	end

	if self:WaterBuff() and self:BomberBuff() then
		damage = self.AttackDamage * 3
	elseif self:WaterBuff() then
		damage = self.AttackDamage * 2
	end

	if IsValid(target) and target:Health() and target:Health() > 0 then -- Doesn't matter if its a player... If the zombie is targetting it, they probably wanna attack it.
		if self:TargetInRange( range ) then

			local dmgInfo = DamageInfo()
			dmgInfo:SetAttacker( self )
			dmgInfo:SetDamage( damage )
			dmgInfo:SetDamageType( DMG_SLASH )
			dmgInfo:SetDamageForce( (target:GetPos() - self:GetPos()) * 7 + Vector( 0, 0, 16 ) )

			if self:TargetInRange( dmgrange ) then
				target:TakeDamageInfo(dmgInfo)
			if target:IsPlayer() then
				target:ViewPunch( VectorRand():Angle() * 0.1 )
				if target:IsOnGround() then
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 10 + Vector( 0, 120, 334 ) )
				else
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 7 + Vector( 0, 0, 64 ) )
				end
				
			end
				if comedyday or math.random(500) == 1 then
					if self.GoofyahAttackSounds then target:EmitSound(self.GoofyahAttackSounds[math.random(#self.GoofyahAttackSounds)], SNDLVL_TALKING, math.random(95,105)) end
				else
					if self.CustomAttackImpactSounds then
						target:EmitSound(self.CustomAttackImpactSounds[math.random(#self.CustomAttackImpactSounds)], SNDLVL_TALKING, math.random(95,105))
					else
						target:EmitSound(self.AttackImpactSounds[math.random(#self.AttackImpactSounds)], SNDLVL_TALKING, math.random(95,105))
					end
				end
			end
		end
	end
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" then
		util.ScreenShake(self:GetPos(),10,10,0.2,500)
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 90)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		util.ScreenShake(self:GetPos(),10,10,0.2,800)
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 90)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
	end
	if e == "melee" then
		if self.AttackSounds then
			self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(95, 100), 1, 2)
		end
		self:DoAttackDamage()
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
	if e == "hulk_smash" then
		self:EmitSound("wavy_zombie/hulk/pound_victim_"..math.random(1,2)..".wav", 500)
		ParticleEffect("bo3_panzer_landing",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
		util.ScreenShake(self:GetPos(),25,25,0.5,600)
		local util_traceline = util.TraceLine		
		local pos = self:WorldSpaceCenter()
        local tr = {
            start = pos,
            filter = self,
           	mask = MASK_NPCSOLID_BRUSHONLY
        }
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
			if IsValid(v) and v:IsPlayer() and !self:IsAttackEntBlocked(v) then
            if v:GetClass() == self:GetClass() then continue end
            if v == self then continue end
            if v:EntIndex() == self:EntIndex() then continue end
            if v:Health() <= 0 then continue end
			if !v:IsOnGround() then continue end
            tr.endpos = v:WorldSpaceCenter()
            local tr1 = util_traceline(tr)
            if tr1.HitWorld then continue end
			v:NZSonicBlind(2)
			end
			if IsValid(v) and v:IsValidZombie() and v.IsMooZombie and v:Health() > 0 and !v:GetSpecialAnimation() then
			local smashdamage = DamageInfo()
            smashdamage:SetAttacker(self)
            smashdamage:SetInflictor(self)
            smashdamage:SetDamageType(DMG_MISSILEDEFENSE)
            smashdamage:SetDamage(75)
            v:TakeDamageInfo(smashdamage)
			end
		end
	end
	if e == "hulk_rock_tear" then
		ParticleEffect("tank_rock_throw_ground_generic",self:GetPos()+Vector(0,0,1),Angle(0,0,0),nil)
		local larmfx_tag = self:LookupBone("ValveBiped.debris_bone")
		self.Debris = ents.Create("nz_prop_effect_attachment")
		self.Debris:SetModel("models/props_debris/concrete_chunk01a.mdl")

		-- Doing it in this order allows the debris model to be positioned correctly.
		self.Debris:SetParent(self, 7)
		self.Debris:SetAngles( self:GetAngles() + Angle(0,90,0) )
		self.Debris:SetPos(self:GetAttachment(self:LookupAttachment("debris")).Pos)

		self.Debris:Spawn()
		self:DeleteOnRemove( self.Debris )
	end
	if e == "hulk_rock_throw" then
		self.Debris:Remove()
		self:EmitSound(self.RockThrowSounds[math.random(#self.RockThrowSounds)], 511, math.random(95,105), 1, 2)
		local larmfx_tag = self:LookupBone("ValveBiped.Bip01_Spine3")
		self.Rock = ents.Create("hulk_rock")
		self.Rock:SetPos(self:GetBonePosition(larmfx_tag))
		self.Rock:SetOwner(self:GetOwner())
		self.Rock:Spawn()
		local phys = self.Rock:GetPhysicsObject()
        local target = self:GetTarget()
        if IsValid(phys) and IsValid(target) then
             phys:SetVelocity(self.Rock:getvel(target:GetPos() + Vector(0,0,15) + target:GetVelocity() * math.Clamp(target:GetVelocity():Length2D(),0,0.75), self:EyePos(), math.Rand(0.6,0.9)))
        end
	end
end