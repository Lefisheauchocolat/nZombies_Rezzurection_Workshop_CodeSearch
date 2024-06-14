AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "FlamingFox's Husband"
ENT.Category = "Brainz"
ENT.Author = "Ghostlymoo"

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t8_zombies/common/mtl_c_t8_zmb_eyes.vmt"),
		[1] = Material("models/moo/codz/t8_zombies/mansion/werewolf/xmaterial_6a6e9a8be605768"),
		[2] = Material("models/moo/codz/t8_zombies/mansion/werewolf/xmaterial_a20f89354eb7bfc"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = false -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooBossZombie = true
ENT.IsMooSpecial = true

ENT.AttackDamage = 85
ENT.HeavyAttackDamage = 120

ENT.AttackRange = 130
ENT.DamageRange = 130

ENT.Models = {
	{Model = "models/moo/_codz_ports/t8/mansion/moo_codz_t8_msn_werewolf.mdl", Skin = 0, Bodygroups = {0,0}},
}

local util_tracehull = util.TraceHull
local spawn = {"nz_ai_wrwlf_idle_2_howl"}

local AttackSequences = {
	{seq = "nz_ai_wrwlf_attack_swipe_dlb_01"},
	{seq = "nz_ai_wrwlf_attack_swipe_l_01"},
	{seq = "nz_ai_wrwlf_attack_swipe_l_02"},
	{seq = "nz_ai_wrwlf_attack_swipe_r_01"},
	{seq = "nz_ai_wrwlf_attack_swipe_r_02"},
}

local JumpSequences = {
	{seq = "nz_ai_wrwlf_mantle_36"},
}

ENT.BarricadeTearSequences = {
	"nz_ai_wrwlf_attack_swipe_l_01",
	"nz_ai_wrwlf_attack_swipe_l_02",
	"nz_ai_wrwlf_attack_swipe_r_01",
	"nz_ai_wrwlf_attack_swipe_r_02",
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.DeathSequences = {
	"nz_ai_wrwlf_dth_01",
	"nz_ai_wrwlf_silver_bullet_dth",
}

ENT.IdleSequence = "nz_ai_wrwlf_idle_01"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ai_wrwlf_walk_01",
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
				"nz_ai_wrwlf_run_01",
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
				"nz_ai_wrwlf_quad_run_01",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.ZombieLandSequences = {
	"nz_ai_wrwlf_land",
}

ENT.CustomMantleOver48 = {
	"nz_ai_wrwlf_mantle_48"
}

ENT.CustomMantleOver72 = {
	"nz_ai_wrwlf_mantle_72"
}

ENT.CustomMantleOver128 = {
	"nz_ai_wrwlf_mantle_128",
}

ENT.CustomNormalJumpUp128 = {
	"nz_ai_wrwlf_jump_up_128"
}

ENT.CustomNormalJumpDown128 = {
	"nz_ai_wrwlf_jump_dn_128"
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.267.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.268.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.269.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.270.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.271.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_09.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_10.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_11.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/atk/zmb_werewolf_attack_12.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_wrwlf/vox/death/zmb_werewolf_death_00.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/death/zmb_werewolf_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/death/zmb_werewolf_death_02.mp3"),
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_margwa/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_06.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_margwa/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_06.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.518.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.519.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.520.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.521.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.522.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.523.mp3"),
}

ENT.GrowlSounds = {
	Sound("nz_moo/zombies/vox/_wrwlf/vox/growl/growl_00.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/growl/growl_01.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/growl/growl_02.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/growl/growl_03.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/growl/growl_04.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/growl/growl_05.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/growl/growl_06.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/vox/growl/growl_07.mp3"),
}

ENT.HowlSounds = {
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.432.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.514.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.515.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.516.mp3"),
	Sound("nz_moo/zombies/vox/_wrwlf/zm_mansion.all.sabl.517.mp3"),
}

ENT.CustomAttackImpactSounds = {
	"npc/zombie/claw_strike1.wav",
	"npc/zombie/claw_strike2.wav",
	"npc/zombie/claw_strike3.wav",
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		local playerhpmod = 1

		local basehealth = 10500
		local basehealthmax = 197500

		local bosshealth = basehealth

		local healthincrease = 1000
		local coopmultiplier = 0.35

		if count > 1 then
			playerhpmod = count * coopmultiplier
		end

		bosshealth = math.Round(playerhpmod * (basehealth + (healthincrease * nzRound:GetNumber())))

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(basehealth)
			self:SetMaxHealth(basehealth)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(bosshealth, basehealth, basehealthmax * playerhpmod))
				self:SetMaxHealth(math.Clamp(bosshealth, basehealth, basehealthmax * playerhpmod))
			else
				self:SetHealth(basehealth)
				self:SetMaxHealth(basehealth)	
			end
		end
		
		self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 72))			-- Nextbots Collision Box(Mainly for interacting with the world.)
		self:SetSurroundingBounds(Vector(-50, -50, 0), Vector(50, 50, 150)) 	-- Nextbots Surrounding Bounds(For Hitbox detection.)
		
		self:SetRunSpeed(1)
		
		self.Charge = false
		self.ChargeTime = CurTime() + math.Rand(7.5, 20.25)

		self.StunCoolDown = CurTime() + 1

		self.Trail = nil
	end
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)
	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
	effectData:SetMagnitude( 1 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)
	
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)
		
	self.Dying = true

	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)

	if damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo) -- Only Thundergun and Wavegun Ragdolls constantly.
	end
	if damagetype == DMG_REMOVENORAGDOLL then
		self:Remove(dmginfo)
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:PostAdditionalZombieStuff()
	if SERVER then
		if !self.Charge and CurTime() > self.ChargeTime then
			self.Charge = true
			self:SetRunSpeed(71)
			self:SpeedChanged()
		end

		if self.Charge and self:TargetInRange(275) and !self:IsAttackBlocked() then
			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove("nz_ai_wrwlf_run_attack_leap_f_spike_256", 1, self.FaceEnemy)
			self:SetSpecialAnimation(false)

			self.Charge = false
			self.ChargeTime = CurTime() + math.Rand(10.5, 20.25) 
			self:SetRunSpeed(36)
			self:SpeedChanged()
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
	local hitforce = dmginfo:GetDamageForce()

	local damage = dmginfo:GetDamage()

	local chestpos = self:GetBonePosition(self:LookupBone("j_spinelower"))

	if (hitpos:DistToSqr(chestpos) < 38^2) then
		dmginfo:ScaleDamage(2)
		if math.random(100) < 25 and !self:GetSpecialAnimation() and CurTime() > self.StunCoolDown then
			ParticleEffect("bo3_thrasher_blood",chestpos, Angle(0,0,0), nil)
			self.StunCoolDown = CurTime() + 7
			self:DoSpecialAnimation("nz_ai_wrwlf_pain_weakpoint_chest")
		end
	else
		dmginfo:ScaleDamage(0.15)
	end
end

function ENT:HandleAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.
	if e == "wrwlf_howl" then
		self:EmitSound(self.HowlSounds[math.random(#self.HowlSounds)], 511, math.random(95, 105))
	end
	if e == "wrwlf_growl" then
		self:EmitSound(self.GrowlSounds[math.random(#self.GrowlSounds)], 100, math.random(95, 105))
	end
	if e == "wrwlf_bark" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(95, 105))
	end
	if e == "wrwlf_pain" then
		self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(95, 105))
	end

	if e == "wrwlf_lunge_start" then
		local color = nzMapping.Settings.zombieeyecolor or Color(255, 45, 0, 255)
		self.Trail = util.SpriteTrail(self, 9, Color(color.r, color.g, color.b, 255), true, 70, 45, 0.35, 1 / 40 * 0.3, "materials/trails/plasma")
	end
	if e == "wrwlf_lunge_end" then
		if IsValid(self.Trail) then
			self.Trail:Remove()
		end
	end

	if e == "step_left_large" or e == "step_left_small" then
		util.ScreenShake(self:GetPos(),8,8,0.2,400)
		ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,11)
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 80)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_right_small" then
		util.ScreenShake(self:GetPos(),8,8,0.2,600)
		ParticleEffectAttach("panzer_land_dust",PATTACH_POINT,self,12)
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 80)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
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
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end