AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "I've adopted a funny little squid creature from Laby"
ENT.PrintName = "Margwa"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:InitDataTables()
	self:NetworkVar("Bool", 6, "OpenMidHead")
	self:NetworkVar("Bool", 7, "OpenLeftHead")
	self:NetworkVar("Bool", 8, "OpenRightHead")
	self:NetworkVar("String", 1, "ElementalType")
end

if CLIENT then 
	function ENT:PostDraw()
		if self:Alive() then
			if !IsValid(self) then return end
			local color = Color(255,210,0)

			if self:GetElementalType() == "Shadow" then
				color = Color(31,140,255)
			elseif self:GetElementalType() == "Fire" then
				color = Color(255,60,0)
			end

			if (!self.Draw_FX or !IsValid(self.Draw_FX)) and (self:GetOpenMidHead() or self:GetOpenLeftHead() or self:GetOpenRightHead()) then
				if self:GetOpenRightHead() then
					self.Draw_FX = CreateParticleSystem(self, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 14)
				elseif self:GetOpenMidHead() then
					self.Draw_FX = CreateParticleSystem(self, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 12)
				else
					self.Draw_FX = CreateParticleSystem(self, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 13)
				end
				self.Draw_FX:SetControlPoint(2, Vector(color.r/255, color.g/255, color.b/255)) -- Color
			end
			if (self.Draw_FX or IsValid(self.Draw_FX)) and (!self:GetOpenMidHead() and !self:GetOpenLeftHead() and !self:GetOpenRightHead()) then
				self.Draw_FX:StopEmission(false, true)
				self.Draw_FX = nil
			end
		else
			if (self.Draw_FX or IsValid(self.Draw_FX)) then
				self.Draw_FX:StopEmission(false, true)
				self.Draw_FX = nil
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.RedEyes = false
ENT.SpeedBasedSequences = true

ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true

ENT.AttackDamage = 50
ENT.HeavyAttackDamage = 150
ENT.AttackRange = 150
ENT.DamageRange = 150

ENT.CanPanzerLift = true

ENT.TraversalCheckRange = 50

ENT.Models = {
	{Model = "models/moo/_codz_ports/t7/zod/moo_codz_t7_margwa.mdl", Skin = 0, Bodygroups = {0,0}},
}

local util_tracehull = util.TraceHull
local spawn = {"nz_ai_margwa_spawn"}

local SlamAttackSequences = {
	{seq = "nz_ai_margwa_smash_attack"},
}

local StandAttackSequences = {
	{seq = "nz_ai_margwa_swipe"},
}

local AttackSequences = {
	{seq = "nz_ai_margwa_swipe"},
	{seq = "nz_ai_margwa_swipe_player"},
}

local JumpSequences = {
	{seq = "nz_ai_margwa_mantle_over_36"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_margwa/vox/ambient/vox_ambient_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/ambient/vox_ambient_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/ambient/vox_ambient_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/ambient/vox_ambient_03.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/ambient/vox_ambient_04.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/ambient/vox_ambient_05.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/ambient/vox_ambient_06.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/ambient/vox_ambient_07.mp3"),
}

ENT.IdleSequence = "nz_ai_margwa_idle_01"
ENT.TeslaSequence = "nz_ai_margwa_react_dg4_loop"

ENT.ZombieLandSequences = {
	"nz_ai_margwa_land",
}

ENT.CustomMantleOver48 = {
	"nz_ai_margwa_mantle_over_48",
}

ENT.CustomMantleOver72 = {
	"nz_ai_margwa_mantle_over_72",
}

ENT.CustomMantleOver96 = {
	"nz_ai_margwa_mantle_over_96",
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_ai_margwa_walk",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {SlamAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			MovementSequence = {
				"nz_ai_margwa_run",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {SlamAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			MovementSequence = {
				"nz_ai_margwa_run_charge",
			},
			SpawnSequence = {spawn},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {SlamAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_margwa/vox/attack/vox_attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/attack/vox_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/attack/vox_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/attack/vox_attack_03.mp3"),
}

ENT.AttackRaiseSounds = {
	Sound("nz_moo/zombies/vox/_margwa/vox/attack_warn/vox_attack_raise_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/attack_warn/vox_attack_raise_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/attack_warn/vox_attack_raise_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/attack_warn/vox_attack_raise_03.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_margwa/vox/pain/vox_pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/pain/vox_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/pain/vox_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/pain/vox_pain_03.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_margwa/vox/death/vox_death_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/death/vox_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/death/vox_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/vox/death/vox_death_03.mp3"),
}

ENT.StompSounds = {
	Sound("nz_moo/zombies/vox/_margwa/step/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/step/step_06.mp3"),
}

ENT.FireStompSounds = {
	Sound("nz_moo/zombies/vox/_margwa/elemental/fire/step/firestep_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/fire/step/firestep_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/fire/step/firestep_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/fire/step/firestep_03.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/fire/step/firestep_04.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/fire/step/firestep_05.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/fire/step/firestep_06.mp3"),
}

ENT.ShadowStompSounds = {
	Sound("nz_moo/zombies/vox/_margwa/elemental/shadow/step/shadowstep_00.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/shadow/step/shadowstep_01.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/shadow/step/shadowstep_02.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/shadow/step/shadowstep_03.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/shadow/step/shadowstep_04.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/elemental/shadow/step/shadowstep_05.mp3"),
}

ENT.HeadExploSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
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

ENT.WeakImpactSounds = {
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_00.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_01.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_02.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_03.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_04.mp3"),
}

ENT.WhipAttackSounds = {
	Sound("nz_moo/zombies/vox/_margwa/whip_attack/whip_attack_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/whip_attack/whip_attack_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/whip_attack/whip_attack_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/whip_attack/whip_attack_3.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(3500)
			self:SetMaxHealth(3500)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 250 + (500 * count), 4500, 10500 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 250 + (500 * count), 4500, 10500 * count))
			else
				self:SetHealth(5000)
				self:SetMaxHealth(5000)	
			end
		end

		self.ElementalAttackCooldown = CurTime() + 5

		self.MidHeadHP = self:Health() * 0.15
		self.LeftHeadHP = self:Health() * 0.15
		self.RightHeadHP = self:Health() * 0.15

		self.MidHead = true
		self.LeftHead = true
		self.RightHead = true

		self:SetOpenMidHead(false)
		self:SetOpenLeftHead(false)
		self:SetOpenRightHead(false)

		self.HeadCount = 0

		self.LostAHead = false
		self.GainSpeed = false

		self.IFrames = CurTime() + 3

		self:SetRunSpeed(1)

		self.Enraged = false

		self.OpenMouthTime = CurTime() + 3
		self.NextMouthOpen = CurTime() + math.Rand(3.5, 7.5)

		self.HeadTbl = {
			[1] = 1,
			[2] = 2,
			[3] = 3,
		}

		self.ElementalTypeTbl = {
			[1] = {
				Type 	= {"Normal"},
				Skin 	= {1},
			},
			[2] = {
				Type 	= {"Fire"},
				Skin 	= {2},
			},
			[3] = {
				Type 	= {"Shadow"},
				Skin 	= {3},
			},
		}

		local selectelement = math.random(3)
		self:GenesisElementals(selectelement)
	end
end

function ENT:GenesisElementals(num)
	self:SetElementalType(self.ElementalTypeTbl[num].Type[1])
	self:SetSkin(self.ElementalTypeTbl[num].Skin[1])
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	if self:GetElementalType() == "Fire" then
    	ParticleEffect("zmb_margwa_spawn_fire",self:GetPos() + Vector(0,0,45),self:GetAngles(),nil)
	elseif self:GetElementalType() == "Shadow" then
    	ParticleEffect("zmb_margwa_spawn_shadow",self:GetPos() + Vector(0,0,45),self:GetAngles(),nil)
    else
    	ParticleEffect("zmb_margwa_spawn",self:GetPos() + Vector(0,0,45),self:GetAngles(),nil)
    end

	self:SetBodygroup(1,0)
	self:SetBodygroup(2,0)
	self:SetBodygroup(3,0)

	self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 92))
	self:SetSurroundingBounds(Vector(-50, -50, 0), Vector(50, 50, 100))
		
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)

	self:SetNoDraw(true)

	self:EmitSound("nz_moo/zombies/vox/_margwa/spawn/spawn.mp3",511)
	self:EmitSound("nz_moo/zombies/vox/_margwa/spawn/spawn_2d.mp3",511)
	--ParticleEffect("hcea_hunter_shade_cannon_explode_flash",self:GetPos(),self:GetAngles(),nil)
	self:TimeOut(2.85)


	if seq then
		self:StopParticles()
		self:SetNoDraw(false)

		if self:GetElementalType() == "Fire" then
    		ParticleEffect("hcea_hunter_ab_explode",self:GetPos(),self:GetAngles(),nil)
		else
    		ParticleEffect("hcea_hunter_shade_cannon_explode_ground",self:GetPos(),self:GetAngles(),nil)
    	end

		self:EmitSound("nz_moo/zombies/vox/_margwa/teleport/teleport_in.mp3", 80, math.random(95,105))
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmgInfo)	
	self.Dying = true

	if self.MidHead then
		self:PopMidHeadEffect()
	elseif self.LeftHead then
		self:PopLeftHeadEffect()
	elseif self.RightHead then
		self:PopRightHeadEffect()
	end

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:DoDeathAnimation("nz_ai_margwa_death")
end

function ENT:DoDeathAnimation(seq)
	self.BehaveThread = coroutine.create(function()
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndMove(seq)
        ParticleEffect("bo3_margwa_death",self:GetPos(),self:GetAngles(),nil)
		self:Remove(DamageInfo())
	end)
end

function ENT:IsValidTarget( ent )
	if !ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:AI()
	local target = self:GetTarget()

	if !self:Alive() or self:GetIsBusy() or self.PanzerDGLifted and self:PanzerDGLifted() then return end -- Not allowed to do anything.

	-- ELEMENTAL ATTACK
	if self:TargetInRange(750) and !self:IsAttackBlocked() and CurTime() > self.ElementalAttackCooldown and self:GetElementalType() ~= "Normal" then
		if self:GetElementalType() == "Fire" then
			self.ElementalAttackCooldown = CurTime() + math.random(10, 16)
			self:FaceTowards(target:GetPos())
			self:DoSpecialAnimation("nz_ai_margwa_fire_attack")
		end
		if self:GetElementalType() == "Shadow" then
			self.ElementalAttackCooldown = CurTime() + math.random(12, 18)
			self:FaceTowards(target:GetPos())
			self:DoSpecialAnimation("nz_ai_margwa_elec_attack")
		end
	end

	-- ENRAGE
	if self.LostAHead and !self.GainSpeed then
		self.GainSpeed = true
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end

	-- OPEN MOUTH
	if !self:GetSpecialAnimation() or !self.BullCharge or !self.StandingLaser then
		if CurTime() > self.NextMouthOpen then
			local randomhead = table.Random(self.HeadTbl)

			self.NextMouthOpen = CurTime() + math.Rand(3.5, 4.15) - self.HeadCount
			self.OpenMouthTime = CurTime() + 1.5
			
			if randomhead == 1 and self.MidHead then
				self:SetOpenMidHead(true)
			end
			if randomhead == 2 and self.LeftHead then
				self:SetOpenLeftHead(true)
			end
			if randomhead == 3 and self.RightHead then
				self:SetOpenRightHead(true)
			end
		end

		if CurTime() > self.OpenMouthTime then
			self:SetOpenMidHead(false)
			self:SetOpenLeftHead(false)
			self:SetOpenRightHead(false)
		end
	else
		self:ZombieGestureSequences()
	end

	-- Knock normal zombies aside
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.Non3arcZombie and !v.IsMooSpecial and v ~= self then
			if self:GetRangeTo( v:GetPos() ) < 9^2 then	
				if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() then
					if v.PainSequences then
						v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
					end
				end
			end
		end
	end
end

function ENT:OnThink()
	-- DG4/DG5 Lift
	if self.PanzerDGLifted and self:PanzerDGLifted() and !self.DGLift then
		self.DGLift = true
		self:DoSpecialAnimation("nz_ai_margwa_react_dg4_intro")
	elseif !self:PanzerDGLifted() and self.DGLift then
		self.DGLift = false
		self:DoSpecialAnimation("nz_ai_margwa_react_dg4_outro")
	end
end

function ENT:ResetMovementSequence()
	if self.DGLift then
		self:ResetSequence(self.TeslaSequence)
	else
		self:ResetSequence(self.MovementSequence)
		self.CurrentSeq = self.MovementSequence
	end
	if self:GetSequenceGroundSpeed(self:GetSequence()) ~= self:GetRunSpeed() or self.UpdateSeq ~= self.CurrentSeq then -- Moo Mark 4/19/23: Finally got a system where the speed actively updates when the movement sequence set is changed.
		--print("update")
		self.UpdateSeq = self.CurrentSeq
		self:UpdateMovementSpeed()
	end
end

-- Called when the zombie wants to idle. Play an animation here
function ENT:PerformIdle()
	if self.DGLift then
		self:ResetSequence(self.TeslaSequence)
	else
		self:ResetSequence(self.IdleSequence)
	end
end

function ENT:ZombieGestureSequences()

	if !self:GetSpecialAnimation() and !self:IsAttacking() and CurTime() < self.OpenMouthTime then
		if self:GetOpenMidHead() then
			self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
			self:AddGesture(ACT_GESTURE_FLINCH_HEAD, true)
		end
		if self:GetOpenLeftHead() then
			self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
			self:AddGesture(ACT_GESTURE_FLINCH_LEFTARM, true)
		end
		if self:GetOpenRightHead() then
			self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
			self:AddGesture(ACT_GESTURE_FLINCH_RIGHTARM, true)
		end
	else
		self:SetOpenMidHead(false)
		self:SetOpenLeftHead(false)
		self:SetOpenRightHead(false)
		self:RemoveGesture(ACT_GESTURE_FLINCH_HEAD)
		self:RemoveGesture(ACT_GESTURE_FLINCH_LEFTARM)
		self:RemoveGesture(ACT_GESTURE_FLINCH_RIGHTARM)
	end
end

function ENT:OnInjured(dmginfo)
	if !self:Alive() then return end

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce = dmginfo:GetDamageForce()
	local damage = dmginfo:GetDamage()

	local attacker = dmginfo:GetAttacker()

	local middlehead = self:GetBonePosition(self:LookupBone("j_head"))
	local lefthead = self:GetBonePosition(self:LookupBone("j_head_le"))
	local righthead = self:GetBonePosition(self:LookupBone("j_head_ri"))

	local healththreshold1 = self:GetMaxHealth() * 0.65
	local healththreshold2 = self:GetMaxHealth() * 0.35

	if math.random(100) <= 25 and !self.Enraged then
		self.Enraged = true
	end

	if CurTime() > self.IFrames then
		if self:Health() <= healththreshold1 and self.HeadCount == 0 then
			self:TestMiddleHead(dmginfo)
			self:TestLeftHead(dmginfo)
			self:TestRightHead(dmginfo)
		elseif self:Health() <= healththreshold2 and self.HeadCount == 1 then
			self:TestMiddleHead(dmginfo)
			self:TestLeftHead(dmginfo)
			self:TestRightHead(dmginfo)
		end
	end

	if hitpos:DistToSqr(middlehead) < 35^2 and self.MidHead and self:GetOpenMidHead() then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(0.75)
	elseif hitpos:DistToSqr(lefthead) < 33^2 and self.LeftHead and self:GetOpenLeftHead() then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(0.75)
	elseif hitpos:DistToSqr(righthead) < 33^2 and self.RightHead and self:GetOpenRightHead() then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(0.75)
	else
		dmginfo:ScaleDamage(0.01) -- My fella here takes a small amount of damage normally... Shoot their heads.
	end
end

function ENT:PopMidHeadEffect()
	self:SetBodygroup(1,1)
	if self:GetElementalType() == "Fire" then
		ParticleEffectAttach("spit_impact_orange", 4, self, 2)

	elseif self:GetElementalType() == "Shadow" then
		ParticleEffectAttach("spit_impact_blue", 4, self, 2)

	else
		ParticleEffectAttach("spit_impact_yellow", 4, self, 2)
	end
	self:EmitSound(self.HeadExploSounds[math.random(#self.HeadExploSounds)], 511)
	self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)

	if self.HeadCount > 0 and self.HeadCount < 2 then
		self:SetRunSpeed(36)
		self:SpeedChanged()
	elseif self.HeadCount > 1 then
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end
end

function ENT:PopLeftHeadEffect()
	self:SetBodygroup(2,1)
	if self:GetElementalType() == "Fire" then
		ParticleEffectAttach("spit_impact_orange", 4, self, 2)

	elseif self:GetElementalType() == "Shadow" then
		ParticleEffectAttach("spit_impact_blue", 4, self, 2)

	else
		ParticleEffectAttach("spit_impact_yellow", 4, self, 2)
	end
	self:EmitSound(self.HeadExploSounds[math.random(#self.HeadExploSounds)], 511)
	self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)

	if self.HeadCount > 0 and self.HeadCount < 2 then
		self:SetRunSpeed(36)
		self:SpeedChanged()
	elseif self.HeadCount > 1 then
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end
end

function ENT:PopRightHeadEffect()
	self:SetBodygroup(3,1)
	if self:GetElementalType() == "Fire" then
		ParticleEffectAttach("spit_impact_orange", 4, self, 2)

	elseif self:GetElementalType() == "Shadow" then
		ParticleEffectAttach("spit_impact_blue", 4, self, 2)

	else
		ParticleEffectAttach("spit_impact_yellow", 4, self, 2)
	end
	self:EmitSound(self.HeadExploSounds[math.random(#self.HeadExploSounds)], 511)
	self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)

	if self.HeadCount > 0 and self.HeadCount < 2 then
		self:SetRunSpeed(36)
		self:SpeedChanged()
	elseif self.HeadCount > 1 then
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end
end

function ENT:TestMiddleHead(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local middlehead = self:GetBonePosition(self:LookupBone("j_head"))
	if hitpos:DistToSqr(middlehead) < 35^2 and self.MidHead and self:GetOpenMidHead() then
		local attacker = dmginfo:GetAttacker()

		self.IFrames = CurTime() + 3
		self.LostAHead = true
		self.MidHead = false
		self.HeadCount = self.HeadCount + 1

		self:PopMidHeadEffect()

		self:SetOpenMidHead(false)
		self:SetOpenLeftHead(false)
		self:SetOpenRightHead(false)
				
	    if IsValid(attacker) then
	    	attacker:GivePoints(500)
	    end
	    timer.Simple(engine.TickInterval(), function()
			if self.HeadCount <= 2 then
				self:TempBehaveThread(function(self)
					self:SetSpecialAnimation(true)
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
					self:PlaySequenceAndMove("nz_ai_margwa_shot_middle_head", {gravity = true})
					self:CollideWhenPossible()
					self:SetSpecialAnimation(false) -- Stops them from going back to idle.
				end)
			end
		end)
	end
end

function ENT:TestLeftHead(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local lefthead = self:GetBonePosition(self:LookupBone("j_head_le"))
	if hitpos:DistToSqr(lefthead) < 33^2 and self.LeftHead and self:GetOpenLeftHead() then
		local attacker = dmginfo:GetAttacker()

		self.IFrames = CurTime() + 3
		self.LostAHead = true
		self.LeftHead = false
		self.HeadCount = self.HeadCount + 1

		self:PopLeftHeadEffect()

		self:SetOpenMidHead(false)
		self:SetOpenLeftHead(false)
		self:SetOpenRightHead(false)
				
	    if IsValid(attacker) then
	    	attacker:GivePoints(500)
	    end
	    timer.Simple(engine.TickInterval(), function()
			if self.HeadCount <= 2 then
				self:TempBehaveThread(function(self)
					self:SetSpecialAnimation(true)
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
					self:PlaySequenceAndMove("nz_ai_margwa_shot_left_head", {gravity = true})
					self:CollideWhenPossible()
					self:SetSpecialAnimation(false) -- Stops them from going back to idle.
				end)
			end
		end)
	end
end

function ENT:TestRightHead(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local righthead = self:GetBonePosition(self:LookupBone("j_head_ri"))
	if hitpos:DistToSqr(righthead) < 33^2 and self.RightHead and self:GetOpenRightHead() then
		local attacker = dmginfo:GetAttacker()

		self.IFrames = CurTime() + 3
		self.LostAHead = true
		self.RightHead = false
		self.HeadCount = self.HeadCount + 1

		self:PopRightHeadEffect()

		self:SetOpenMidHead(false)
		self:SetOpenLeftHead(false)
		self:SetOpenRightHead(false)
				
	    if IsValid(attacker) then
	    	attacker:GivePoints(500)
	    end
	    timer.Simple(engine.TickInterval(), function()
			if self.HeadCount <= 2 then
				self:TempBehaveThread(function(self)
					self:SetSpecialAnimation(true)
					self:SolidMaskDuringEvent(MASK_PLAYERSOLID, collision)
					self:PlaySequenceAndMove("nz_ai_margwa_shot_right_head", {gravity = true})
					self:CollideWhenPossible()
					self:SetSpecialAnimation(false) -- Stops them from going back to idle.
				end)
			end
		end)
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e)
	self.OverrideLsmall = true
	self.OverrideLLarge = true
	self.OverrideRsmall = true
	self.OverrideRLarge = true
	self.OverrideAttack = true

	if e == "slam" then
		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_close.mp3", 100)
		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_far.mp3", 511)
		ParticleEffect("bo3_margwa_slam",self:GetPos(),self:GetAngles(),nil)
		util.ScreenShake(self:GetPos(),100000,500000,0.4,2000)
		
		self:DoAttackDamage()
	end
	if e == "step_left_large" then
		self:EmitSound(self.StompSounds[math.random(#self.StompSounds)],80,math.random(95,100))
		--self:EmitSound("nz_moo/zombies/vox/_cellbreaker/fly/keys/rattle_0"..math.random(0,4)..".mp3",80,math.random(95,100))
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)

		if self:GetElementalType() == "Shadow" then
			self:EmitSound(self.ShadowStompSounds[math.random(#self.ShadowStompSounds)],80,math.random(95,100))
			ParticleEffectAttach("shdw_margwa_footstep",PATTACH_POINT,self,18)
		elseif self:GetElementalType() == "Fire" then
			self:EmitSound(self.FireStompSounds[math.random(#self.FireStompSounds)],80,math.random(95,100))
			ParticleEffectAttach("fire_margwa_footstep",PATTACH_POINT,self,18)
			ParticleEffectAttach("zmb_mutated_plasma_step",PATTACH_POINT,self,18)
		end
	end
	if e == "step_right_large" then
		self:EmitSound(self.StompSounds[math.random(#self.StompSounds)],80,math.random(95,100))
		--self:EmitSound("nz_moo/zombies/vox/_cellbreaker/fly/keys/rattle_0"..math.random(0,4)..".mp3",80,math.random(95,100))
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)

		if self:GetElementalType() == "Shadow" then
			self:EmitSound(self.ShadowStompSounds[math.random(#self.ShadowStompSounds)],80,math.random(95,100))
			ParticleEffectAttach("shdw_margwa_footstep",PATTACH_POINT,self,19)
		elseif self:GetElementalType() == "Fire" then
			self:EmitSound(self.FireStompSounds[math.random(#self.FireStompSounds)],80,math.random(95,100))
			ParticleEffectAttach("fire_margwa_footstep",PATTACH_POINT,self,19)
			ParticleEffectAttach("zmb_mutated_plasma_step",PATTACH_POINT,self,19)
		end
	end
	if (e == "melee" or e == "melee_heavy") then
		if self.AttackSounds then
			self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		end
		if e == "melee_heavy" then
			self.HeavyAttack = true
		end
		self:DoAttackDamage()
	end

	if e == "margwa_knee" then
		self:EmitSound("nz_moo/zombies/vox/_margwa/fall/fall_knee.mp3", 100)
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
	end

	if e == "margwa_body" then
		self:EmitSound("nz_moo/zombies/vox/_margwa/fall/fall_body.mp3", 100)
		util.ScreenShake(self:GetPos(),100000,500000,0.2,1000)
	end

	if e == "elec_attack_tell" then
		self:EmitSound("nz_moo/zombies/vox/_margwa/elemental/shadow/main_attack_start.mp3", 100, math.random(95,105))
		self:PlaySound(self.AttackRaiseSounds[math.random(#self.AttackRaiseSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		ParticleEffectAttach("zmb_shadow_margwa_shadowtell", PATTACH_POINT_FOLLOW, self, 20)
		ParticleEffectAttach("zmb_shadow_margwa_shadowtell", PATTACH_POINT_FOLLOW, self, 21)
		ParticleEffectAttach("zmb_shadow_margwa_shadowtell", PATTACH_POINT_FOLLOW, self, 22)
		ParticleEffectAttach("zmb_shadow_margwa_shadowtell", PATTACH_POINT_FOLLOW, self, 23)
	end
	if e == "elec_slam" then
		local direction = self:GetPos() + self:GetForward() * 100

		self:EmitSound("nz_moo/zombies/vox/_margwa/elemental/shadow/portal_explode.mp3", 100, math.random(95,105))
    	ParticleEffect("zmb_shadow_margwa_shockwave_explo", direction, self:GetAngles(), self)
    	ParticleEffect("zmb_shadow_margwa_shadowportal", direction, self:GetAngles(), self)

		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_close.mp3", 100)
		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_far.mp3", 511)
		ParticleEffect("bo3_margwa_slam",self:GetPos(),self:GetAngles(),nil)
		util.ScreenShake(self:GetPos(),100000,500000,0.4,2000)

    	for i=1, 4 do
			timer.Simple(i * 0.35, function()
				if IsValid(self) then
					local Child = ents.Create("nz_ent_proj_chomper")
					Child:SetPos(direction + Vector(0,0,50) )
					Child:SetAngles(self:GetAngles())
					Child:Spawn()

					if (IsValid(self.Target) and self.Target:Alive() and self.Target:GetNotDowned()) then
						Child:SetVictim(self.Target)
					end
				end
			end)
		end

		for k,v in nzLevel.GetZombieArray() do
			if v:GetRangeTo(self:GetPos()) < 150 then
				if v:Alive() and v.IsMooZombie and !v.IsMooSpecial and !v.IsMooBossZombie and !v.IsMiniBoss then
					v:SetShadowBuff(true)
					if v:GetCrawler() then
						v:DoSpecialAnimation(self.CrawlSparkySequences[math.random(#self.CrawlSparkySequences)])
					else
						v:DoSpecialAnimation(self.SparkySequences[math.random(#self.SparkySequences)])
					end
				end
			end
		end
	end

	if e == "fire_attack_tell" then
		self:EmitSound("nz_moo/zombies/vox/_margwa/elemental/fire/attack_main_start.mp3", 100, math.random(95,105))
		self:PlaySound(self.AttackRaiseSounds[math.random(#self.AttackRaiseSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		ParticleEffectAttach("zmb_fire_margwa_firetell", PATTACH_POINT_FOLLOW, self, 20)
		ParticleEffectAttach("zmb_fire_margwa_firetell", PATTACH_POINT_FOLLOW, self, 21)
		ParticleEffectAttach("zmb_fire_margwa_firetell", PATTACH_POINT_FOLLOW, self, 22)
		ParticleEffectAttach("zmb_fire_margwa_firetell", PATTACH_POINT_FOLLOW, self, 23)
	end
	if e == "fire_slam" then
		local direction = self:GetPos() + self:GetForward() * 100

		local FIRE = ents.Create("nz_proj_fire_margwa_firepit")
		FIRE:SetPos(self:GetPos() + self:GetForward() * 150 + Vector(0,0,10) )
		if IsValid(self.Target) and self.Target:Alive() and self.Target:GetNotDowned() then
			FIRE:SetAngles((self.Target:GetPos() - self:GetPos()):Angle())
		else
			FIRE:SetAngles(self:GetAngles())
		end
		FIRE:Spawn()

		if (IsValid(self.Target) and self.Target:Alive() and self.Target:GetNotDowned()) then
			FIRE:SetVictim(self.Target)
		end

    	ParticleEffect("doom_rev_missile_blast", direction, self:GetAngles(), self)

		for i = 1, 2 do
			ParticleEffect("bo3_margwa_slam",self:GetPos(),self:GetAngles(),nil)
		end

		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_close.mp3", 100, math.random(95,105))
		self:EmitSound("nz_moo/zombies/vox/_margwa/slam_attack/slam_attack_far.mp3", 100, math.random(95,105))
		self:EmitSound("nz_moo/zombies/vox/_margwa/elemental/fire/attack_main_imp.mp3", 100, math.random(95,105))
	end
end
