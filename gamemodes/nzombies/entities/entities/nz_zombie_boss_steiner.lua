AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "The Megaton aka Magnatron(According to IServerOutVibes) I AM MEGALON!!!!!!!!!"
ENT.PrintName = "Megaton"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

ENT.EyeColorTable = {
	[0] = Material("models/moo/codz/t9_zombies/steiner/mtl_c_t9_zmb_radz_eye.vmt"),
}

if CLIENT then 
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")

	function ENT:DrawEyeGlow()
		local eyeColor = Color(170, 255, 0, 255)

		local latt = self:LookupAttachment("lefteye")
		local ratt = self:LookupAttachment("righteye")

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

local util_traceline = util.TraceLine
local util_tracehull = util.TraceHull

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true

ENT.AttackRange = 100
ENT.DamageRange = 100

ENT.AttackDamage = 75
ENT.HeavyAttackDamage = 95

ENT.MinSoundPitch = 95
ENT.MaxSoundPitch = 105

ENT.SoundDelayMin = 3
ENT.SoundDelayMax = 3

ENT.Models = {
	{Model = "models/moo/_codz_ports/t9/silver/moo_codz_t9_steiner.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.DeathSequences = {
	"nz_ai_steiner_pain_split_01",
}

ENT.BarricadeTearSequences = {}

local JumpSequences = {
	{seq = "nz_ai_steiner_mantle_32"},
}

local AttackSequences = {
	{seq = "nz_ai_steiner_stn_atk_melee_01"},
	{seq = "nz_ai_steiner_stn_atk_melee_02"},
	{seq = "nz_ai_steiner_stn_atk_melee_03"},
	{seq = "nz_ai_steiner_stn_atk_melee_04"},
}

local WalkAttackSequences = {
	{seq = "nz_ai_steiner_walk_atk_melee_01"},
	{seq = "nz_ai_steiner_walk_atk_melee_02"},
	{seq = "nz_ai_steiner_walk_atk_melee_03"},
	{seq = "nz_ai_steiner_walk_atk_melee_04"},
}

local RunAttackSequences = {
	{seq = "nz_ai_steiner_sprint_atk_melee_01"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.NormalMantleOver48 = {
	"nz_ai_steiner_mantle_48",
}

ENT.NormalMantleOver72 = {
	"nz_ai_steiner_mantle_72",
}

ENT.NormalMantleOver96 = {
	"nz_ai_steiner_mantle_96",
}

ENT.NormalMantleOver128 = {
	"nz_ai_steiner_mantle_128",
}

ENT.NormalJumpUp128 = {
	"nz_ai_steiner_jump_up_128",
}

ENT.NormalJumpUp128Quick = {
	"nz_ai_steiner_jump_up_128",
}

ENT.NormalJumpDown128 = {
	"nz_ai_steiner_jump_dn_128",
}

ENT.ShootSequences = {
	"nz_ai_steiner_stn_atk_blast_quick", -- Shoots a simple blast
	"nz_ai_steiner_stn_atk_bomb_quick", -- Shoots an AOE bomb
}

ENT.SpecialIdleSequences = {
	"nz_ai_steiner_idle_02",
	"nz_ai_steiner_idle_03",
}

ENT.IdleSequence = "nz_ai_steiner_idle_01"
ENT.IdleSequenceAU = "nz_ai_steiner_idle_01"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_ai_steiner_walk_01",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {WalkAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			MovementSequence = {
				"nz_ai_steiner_sprint_01",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.InhaleSounds = {
	Sound("nz_moo/zombies/vox/_steiner/vocals/inhale_slow/slow_ inhale_00.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/inhale_slow/slow_ inhale_01.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/inhale_slow/slow_ inhale_02.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/inhale_slow/slow_ inhale_03.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/inhale_slow/slow_ inhale_04.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/inhale_slow/slow_ inhale_05.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/inhale_slow/slow_ inhale_06.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/inhale_slow/slow_ inhale_07.mp3"),
}

ENT.ExhaleSounds = {
	Sound("nz_moo/zombies/vox/_steiner/vocals/exhale_slow/slow_exhale_00.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/exhale_slow/slow_exhale_01.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/exhale_slow/slow_exhale_02.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/exhale_slow/slow_exhale_03.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/exhale_slow/slow_exhale_04.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/exhale_slow/slow_exhale_05.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/exhale_slow/slow_exhale_06.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/exhale_slow/slow_exhale_07.mp3"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_steiner/attacks/melee_swing/melee_swing_00.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/melee_swing/melee_swing_01.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/melee_swing/melee_swing_02.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/melee_swing/melee_swing_03.mp3"),
}

ENT.WalkFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_margwa/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_06.mp3"),
}

ENT.DeathExploSounds = {
	Sound("nz_moo/zombies/vox/_steiner/split_explo/steinersplit_death_explo_00.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/split_explo/steinersplit_death_explo_01.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/split_explo/steinersplit_death_explo_02.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/split_explo/steinersplit_death_explo_03.mp3"),
}

ENT.SpawnExploSounds = {
	Sound("nz_moo/zombies/vox/_steiner/spawn_stinger/spawn_explo_00.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/spawn_stinger/spawn_explo_01.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/spawn_stinger/spawn_explo_02.mp3"),
}

ENT.BlastShotSounds = {
	Sound("nz_moo/zombies/vox/_steiner/attacks/atk_blast_shot/atk_blast_shot_00.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/atk_blast_shot/atk_blast_shot_01.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/atk_blast_shot/atk_blast_shot_02.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/atk_blast_shot/atk_blast_shot_03.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/atk_blast_shot/atk_blast_shot_04.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/atk_blast_shot/atk_blast_shot_05.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/attacks/atk_blast_shot/atk_blast_shot_06.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_steiner/vocals/melee/melee_00.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/melee/melee_01.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/melee/melee_02.mp3"),
	Sound("nz_moo/zombies/vox/_steiner/vocals/melee/melee_03.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(1000)
			self:SetMaxHealth(1000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 1500 + (750 * count), 1000, 95000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 1500 + (750 * count), 1000, 95000 * count))
			else
				self:SetHealth(5000)
				self:SetMaxHealth(5000)	
			end
		end

		self.NextShoot = CurTime() + 3

		self.ShouldEnrage = false
		self.Enraged = false

		self.Inhale = true
		self.Exhale = false

		self.RemoveMeTime = 0

		self.UseCustomAttackDamage = true

		self.SpecialIdle = CurTime() + 5

		self:SetRunSpeed(1)
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	self:SetCollisionBounds(Vector(-14,-14, 0), Vector(14, 14, 72))
	self:SetSurroundingBounds(Vector(-45, -45, 0), Vector(45, 45, 85))
	
	if self.EyeColorTable then
		local eyecolor = Color(170, 255, 0, 255)
		local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()

		for k,v in pairs(self.EyeColorTable) do
			v:SetVector("$emissiveblendtint", col)
		end
	end

	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
	effectData:SetMagnitude( 1 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)
	
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)

	self:EmitSound("nz_moo/zombies/vox/_steiner/spawn_mus/mus_steiner_v1_00_mas.mp3", 577)
	self:EmitSound("nz_moo/zombies/vox/_steiner/spawn_swt/spawn_sweetener.mp3", 577)
	self:EmitSound(self.SpawnExploSounds[math.random(#self.SpawnExploSounds)], 577)

	self:TimeOut(2)

	self:CollideWhenPossible()
end

function ENT:AI()
	if CurTime() > self.NextShoot then
		if !self:IsAttackBlocked() and self:TargetInRange(500) and !self:TargetInRange(150) then
			self:TempBehaveThread(function(self)
				self.NextShoot = CurTime() + math.random(7,10)

				self:SetSpecialAnimation(true)

				self:EmitSound("nz_moo/zombies/vox/_steiner/attacks/atk_blast_rise/atk_blast_charge_00.mp3",80,100)
				self:PlaySequenceAndMove(self.ShootSequences[math.random(#self.ShootSequences)], 1, self.FaceEnemy)
				
				self:StopParticles()
				self:SetSpecialAnimation(false)
			end)
		end
	end

	-- Always Sprint when enraged
	if !self.Enraged and self.ShouldEnrage then
		self.Enraged = true
		self.ShouldEnrage = false
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end

	-- Sprint to catch up to Target
	if IsValid(self.Target) and self.Target:IsPlayer() and !self.Enraged then
		if self:TargetInRange(450) then
			self:SetRunSpeed(1)
			self:SpeedChanged()
		else
			self:SetRunSpeed(71)
			self:SpeedChanged()
		end
	end

	-- Knock normal zombies aside
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.Non3arcZombie and !v.IsMooSpecial and v ~= self then
			if self:GetRangeTo( v:GetPos() ) < 7^2 then	
				if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() and self:GetRunSpeed() > 36 then
					if v.PainSequences then
						v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
					end
				end
			end
		end
	end

	-- Idle Animations
	if CurTime() > self.SpecialIdle and !self:HasTarget() then
		self:DoSpecialAnimation(self.SpecialIdleSequences[math.random(#self.SpecialIdleSequences)])
		self.SpecialIdle = CurTime() + math.random(8,15)
	end
end

function ENT:OnThink()
	if self.RemoveMeNOW and CurTime() > self.RemoveMeTime then
		self:Remove()
	end
end

function ENT:Sound()
	if self:GetAttacking() or !self:IsAlive() or self:GetDecapitated() then return end

	local vol = self.SoundVolume

	local chance = math.random(100)

	for k,v in nzLevel.GetZombieArray() do -- FUCK YOU, ARRAYS ARE AWESOME!!!
		if k < 2 then vol = 511 else vol = self.SoundVolume end
	end

	if self.Inhale then
		self.Inhale = false
		self.Exhale = true
		self:PlaySound(self.InhaleSounds[math.random(#self.InhaleSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	elseif self.Exhale then
		self.Inhale = true
		self.Exhale = false
		self:PlaySound(self.ExhaleSounds[math.random(#self.ExhaleSounds)],vol, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
	else
		-- We still delay by max sound delay even if there was no sound to play
		self.NextSound = CurTime() + self.SoundDelayMax
	end
end

function ENT:PerformDeath(dmginfo)
		
	self.Dying = true

	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)
	
	ParticleEffect("hcea_flood_runner_death",self:GetPos(),self:GetAngles(),self)
	self:EmitSound("nz_moo/zombies/vox/_quad/gas_cloud/cloud_0"..math.random(0,3)..".mp3")

	if damagetype == DMG_REMOVENORAGDOLL then
		self:Remove(dmginfo)
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() then
		self:Remove(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:OnInjured(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
	local hitforce = dmginfo:GetDamageForce()

	local damage = dmginfo:GetDamage()

	if self:Health() <= self:GetMaxHealth() / 2 then
		self.ShouldEnrage = true
	end

	dmginfo:ScaleDamage(0.25)
end

function ENT:CustomAttackDamage(target, dmg) 
	if !target or !dmg then return end
	local dmgInfo = DamageInfo()
	dmgInfo:SetAttacker( self )
	dmgInfo:SetDamage( dmg )
	dmgInfo:SetDamageType( DMG_SLASH )

	target:TakeDamageInfo(dmgInfo)

	if target:IsPlayer() then
		target:ViewPunch( VectorRand():Angle() * 0.05 )
		if target:IsOnGround() then
			target:SetVelocity( (target:GetPos() - self:GetPos()) * 20 + Vector( 0, 35, 0 ) )
		else
			target:SetVelocity( (target:GetPos() - self:GetPos()) * 5 + Vector( 0, 35, 14 ) )
		end
	end
end

function ENT:OnGameOver()
	if !self.yousuck then
		self.yousuck = true
		self:DoSpecialAnimation("nz_ai_steiner_summon_01")
	end
end

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "step_right_small" or e == "step_left_small" or e == "step_right_large" or e == "step_left_large" then
		util.ScreenShake(self:GetPos(),2,2,0.2,450)
		self:EmitSound(self.WalkFootstepsSounds[math.random(#self.WalkFootstepsSounds)], 65)
	end
	if e == "melee_whoosh" then
		if self.CustomMeleeWhooshSounds then
			self:EmitSound(self.CustomMeleeWhooshSounds[math.random(#self.CustomMeleeWhooshSounds)], 80)
		else
			self:EmitSound(self.MeleeWhooshSounds[math.random(#self.MeleeWhooshSounds)], 80)
		end
	end
	if e == "melee" or e == "melee_heavy" then
		if self:BomberBuff() and self.GasAttack then
			self:EmitSound(self.GasAttack[math.random(#self.GasAttack)], 100, math.random(95, 105), 1, 2)
		else
			if self.AttackSounds then
				self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
			end
		end
		if e == "melee_heavy" then
			self.HeavyAttack = true
		end
		self:DoAttackDamage()
	end

	if e == "steiner_blast_charge" then
		ParticleEffectAttach("hcea_hunter_frg_charge", 4, self, 11)
	end
	if e == "steiner_split_start" then
	end
	if e == "steiner_split_end" then
		--[[ParticleEffect("hcea_flood_runner_death",self:GetPos(),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/vox/_quad/gas_cloud/cloud_0"..math.random(0,3)..".mp3")
		self.RemoveMeTime = CurTime() + 0.5
		self.RemoveMeNOW = true]]
	end
	if e == "steiner_bomb_charge" then
	end
	if e == "steiner_bomb_shoot" then
		self:EmitSound(self.BlastShotSounds[math.random(#self.BlastShotSounds)],80,100)

		self:Retarget()

		local rarmfx_tag = self:GetBonePosition(self:LookupBone("j_wrist_le"))
		local target = self:GetTarget()

		if IsValid(target) then
			self.BombShot = ents.Create("nz_proj_steiner_bomb")
			self.BombShot:SetPos(rarmfx_tag)
			self.BombShot:Spawn()
			self.BombShot:Launch(((target:EyePos() - Vector(0,0,7)) - self.BombShot:GetPos()):GetNormalized())
		end
	end
	if e == "steiner_ww_stun" then
	end
	if e == "steiner_blast_shoot" then
		local mouth = self:GetBonePosition(self:LookupBone("j_jaw_radz"))
		ParticleEffect("hcea_hunter_frg_muzzle",mouth,self:GetAngles(),self)
		self:EmitSound(self.BlastShotSounds[math.random(#self.BlastShotSounds)],80,100)

		self:Retarget()

		local rarmfx_tag = self:GetBonePosition(self:LookupBone("j_jaw_radz"))
		local target = self:GetTarget()

		if IsValid(target) then
			self.BlastShot = ents.Create("nz_proj_steiner_blast")
			self.BlastShot:SetPos(rarmfx_tag)
			self.BlastShot:Spawn()
			self.BlastShot:Launch(((target:EyePos() - Vector(0,0,7)) - self.BlastShot:GetPos()):GetNormalized())
		end

	end

	if e == "steiner_summon" then
		self.NextSound = CurTime() + self.SoundDelayMax
		--self:EmitSound(self.MangleTauntSounds[math.random(#self.MangleTauntSounds)], 100, math.random(85, 105), 1, 2)
	end

	if e == "start_traverse" then
		--print("starttraverse")
		self.TraversalAnim = true
	end
	if e == "finish_traverse" then
		--print("finishtraverse")
		self.TraversalAnim = false
	end
	if e == "remove_zombie" then
		self:Remove()
	end
end
