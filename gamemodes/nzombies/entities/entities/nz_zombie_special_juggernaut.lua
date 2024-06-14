AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Yet another big guy that runs on you YEEEEEEEEEEEAH"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

local resist = {
	[DMG_BULLET] = true,
}

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.

ENT.AttackRange = 80
ENT.DamageRange = 80 
ENT.AttackDamage = 70

ENT.Models = {
	{Model = "models/wavy_ports/wavy_enemies/waw_custom/mw2_juggernaut.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_jnaut_spawn"}

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
	{seq = "nz_barricade_run_1"},
}

local AttackSequences = {
	{seq = "nz_jnaut_melee_01"},
	{seq = "nz_jnaut_melee_02"},
	{seq = "nz_jnaut_melee_03"},
}

ENT.DeathSequences = {
	"nz_jnaut_death_01",
	"nz_jnaut_death_02",
	"nz_jnaut_death_expl"
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_jnaut_walk",
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
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_jnaut_run",
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

ENT.JuggernautStepSounds = {
	"wavy_zombie/mw2_juggernaut/juggernaut_step_00.mp3",
	"wavy_zombie/mw2_juggernaut/juggernaut_step_01.mp3"
}

ENT.CustomMeleeWhooshSounds = {
	"enemies/bosses/nemesis/swing1.ogg",
	"enemies/bosses/nemesis/swing2.ogg",
	"enemies/bosses/nemesis/swing3.ogg",
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		local zhealth = nzRound:GetZombieHealth()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(1000)
			self:SetMaxHealth(1000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(zhealth * 4 + (1000 * count), 3000, 60000))
				self:SetMaxHealth(math.Clamp(zhealth * 4 + (1000 * count), 3000, 60000))
			else
				self:SetHealth(3000)
				self:SetMaxHealth(3000)	
			end
		end

		self:SetRunSpeed(71)

		self.Fucking = false
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
	self:EmitSound("wavy_zombie/mw2_juggernaut/motd_brutus_yell2.mp3", 500, 100, 1)
	self:EmitSound("nz_moo/zombies/vox/_cellbreaker/smoke_grenade/smoke.mp3")
	if IsValid(self) then ParticleEffect("ins_m203_smokegrenade", self:WorldSpaceCenter(), Angle(0,0,0), self) end
	
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)

	local damagetype = dmginfo:GetDamageType()
	
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:PostTookDamage(dmginfo)

	local insta = nzPowerUps:IsPowerupActive("insta") -- Don't apply the damage reduction if insta kill is active.
	
	if resist[dmginfo:GetDamageType()] and !insta then
		dmginfo:ScaleDamage(0.5)
	end
	
end

function ENT:AI()

	local target = self:GetTarget()
	local hp = self:Health()
	local maxhp = self:GetMaxHealth()

	if IsValid(target) and target:IsPlayer() and self:TargetInRange(200) and hp <= (maxhp * 0.33) and math.random(4) == 1 then
		self:GetFucked()
	end
	
end

function ENT:GetFucked()
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Fucking = true
		self:PlaySequenceAndMove("nz_jnaut_mindfuck", 1)
		self:PlaySequenceAndMove("nz_jnaut_fuckexplode", 1)
		self:SetSpecialAnimation(false)
	end)
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
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 5 + Vector( 0, 120, 334 ) )
				else
					target:SetVelocity( (target:GetPos() - self:GetPos()) * 3 + Vector( 0, 0, 64 ) )
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

function ENT:CustomAnimEvent(a,b,c,d,e)

	if e == "jnaut_step" then
		util.ScreenShake(self:GetPos(),8,8,0.2,400)
		self:EmitSound(self.JuggernautStepSounds[math.random(#self.JuggernautStepSounds)], 400)
	end
	
	if e == "jnaut_mindfuck" then
		self:EmitSound("nz_moo/zombies/vox/_cellbreaker/helmet_ping.mp3",511, 100)
	end
	
	if e == "jnaut_fuckexplode" then
		if IsValid(self) then	
			util.ScreenShake(self:GetPos(),12,100,1,400)

			self:EmitSound("NZ.ShatterBlast.Exp")
			self:EmitSound("NZ.ShatterBlast.Deep")
			self:EmitSound("NZ.ShatterBlast.Low")
			ParticleEffect("hound_explosion",self:WorldSpaceCenter(),Angle(0,0,0),nil)

			self:Explode(200, true)
		end
	end
	
	--[[if e == "jnaut_shoot" then
		local target = self:GetTarget()
		local tr = util.TraceLine({
			start = self:GetPos() + Vector(0,50,0),
			endpos = self:GetTarget():GetPos() + Vector(0,0,50),
			filter = self,
			ignoreworld = true,
		})	
		if IsValid(tr.Entity) then
		local shootPos = self:GetAttachment(1).Pos
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self:GetAttachment(1).Pos
		bullet.Dir = (target:GetPos() - self:GetPos()):GetNormalized()
		bullet.Spread = Vector(0.07,0.07,0.07)
		bullet.Tracer	= 1
		bullet.TracerName	= "AR2Tracer"
		bullet.HullSize	= 5
		bullet.Force = math.random(2)*math.random(4)
		bullet.Damage	= 15
		bullet.AmmoType = "AR2"
		bullet.Filter = {self}
		bullet.Callback = function(ent, tr, dmg)
			dmg:SetAttacker(self)
			dmg:SetInflictor(self)
		end
		self:FireBullets(bullet)
	end
	end]]

end
