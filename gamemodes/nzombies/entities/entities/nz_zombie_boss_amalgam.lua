AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Meat Sausage"
ENT.PrintName = "Amalgam"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

function ENT:InitDataTables()
	self:NetworkVar("Entity", 	6, 	"CurrentPlayer")
	self:NetworkVar("Entity", 	7, 	"Mimic")
	self:NetworkVar("Bool", 	6, 	"UsingGrab")
	self:NetworkVar("Bool", 	7, 	"TopHead")
	self:NetworkVar("Bool", 	8, 	"MiddleHead")
	self:NetworkVar("Bool", 	9, 	"BottomHead")
	self:NetworkVar("Bool", 	10, "IsEnraged")
end

function ENT:FinishGrab()
	if CLIENT then return end
	--print("Finish")
	if self:GetStop() then
		--print("Stopped")
		self.WaitForGrab = true
	end
end

if CLIENT then 

	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t10_zombies/zm/c_t10_zmb_zombie_base_body_01_eyes.vmt"),
		[1] = Material("models/moo/codz/t10_zombies/zm/xmaterial_7bc047c19822a5.vmt"),
	}

	local eyeglow =  Material("nz/zlight")
	function ENT:Draw() //Runs every frame
		self:DrawModel()
		if self.RedEyes and self:IsAlive() and !self:GetDecapitated() then
			self:DrawEyeGlow() 
		end
		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
		
		self:EffectsAndSounds()
	end

	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if self:GetIsEnraged() and (!self.Draw_FX or !IsValid(self.Draw_FX)) then
				self.Draw_FX = CreateParticleSystem(self, "bo3_thrasher_aura", PATTACH_POINT_FOLLOW, 1)
			end
		end
	end

	function ENT:DrawEyeGlow()
		local eyeColor = nzMapping.Settings.zombieeyecolor
		local nocolor = Color(0,0,0)

		if self.EyeColorTable then
			-- Go through every material given and set the color.
			local eyecolor = nzMapping.Settings.zombieeyecolor
			local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()

			for k,v in pairs(self.EyeColorTable) do
				v:SetVector("$emissiveblendtint", col)
			end
		end
		
		if eyeColor == nocolor then return end

		local latt = self:LookupAttachment("leye_head_fx_tag")
		local ratt = self:LookupAttachment("reye_head_fx_tag")
		local latt2 = self:LookupAttachment("leye_head2_fx_tag")
		local ratt2 = self:LookupAttachment("reye_head2_fx_tag")
		local latt3 = self:LookupAttachment("leye_head3_fx_tag")
		local ratt3 = self:LookupAttachment("reye_head3_fx_tag")

		if latt == nil then return end
		if ratt == nil then return end
		if latt2 == nil then return end
		if ratt2 == nil then return end
		if latt3 == nil then return end
		if ratt3 == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)
		local leye2 = self:GetAttachment(latt2)
		local reye2 = self:GetAttachment(ratt2)
		local leye3 = self:GetAttachment(latt3)
		local reye3 = self:GetAttachment(ratt3)

		if leye == nil then return end
		if reye == nil then return end
		if leye2 == nil then return end
		if reye2 == nil then return end
		if leye3 == nil then return end
		if reye3 == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.49
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.49
		local righteyepos2 = leye2.Pos + leye2.Ang:Forward()*0.49
		local lefteyepos2 = reye2.Pos + reye2.Ang:Forward()*0.49
		local righteyepos3 = leye3.Pos + leye3.Ang:Forward()*0.49
		local lefteyepos3 = reye3.Pos + reye3.Ang:Forward()*0.49

		if lefteyepos and righteyepos and righteyepos2 and lefteyepos2 and righteyepos3 and lefteyepos3 then
			render.SetMaterial(eyeglow)
			if self:GetTopHead() then
				render.DrawSprite(lefteyepos, 5, 5, eyeColor)
				render.DrawSprite(righteyepos, 5, 5, eyeColor)
			end
			if self:GetMiddleHead() then
				render.DrawSprite(lefteyepos2, 5, 5, eyeColor)
				render.DrawSprite(righteyepos2, 5, 5, eyeColor)
			end
			if self:GetBottomHead() then
				render.DrawSprite(lefteyepos3, 5, 5, eyeColor)
				render.DrawSprite(righteyepos3, 5, 5, eyeColor)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.RedEyes = true

ENT.AttackRange = 100
ENT.DamageRange = 110
ENT.AttackDamage = 90
ENT.HeavyAttackDamage = 150

ENT.TraversalCheckRange = 80

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/zm/moo_codz_t10_zmb_amalgam.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_base_amalgam_arrive_01", "nz_base_amalgam_arrive_02", "nz_base_amalgam_arrive_03", "nz_base_amalgam_arrive_04"}

ENT.DeathSequences = {
	"nz_base_amalgam_death",
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

local AttackSequences = {
	{seq = "nz_base_amalgam_stand_attack_01"},
	{seq = "nz_base_amalgam_stand_attack_02"},
}

local RunAttackSequences = {
	{seq = "nz_base_amalgam_run_attack_01"},
	{seq = "nz_base_amalgam_run_attack_02"},
	{seq = "nz_base_amalgam_run_attack_03"},
}

local JumpSequences = {
	{seq = "nz_base_amalgam_run_mantle_over_32"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_amal/amb/vox_amal_amb_13.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_02.mp3"),
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_03.mp3"),
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_04.mp3"),
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_05.mp3"),
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_06.mp3"),
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_07.mp3"),
	Sound("nz_moo/zombies/vox/_amal/sprint/vox_amal_sprint_08.mp3"),
}

ENT.IdleSequence = "nz_base_amalgam_idle"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_amalgam_walk_01",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_amalgam_run_01",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_amalgam_sprint_01",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {RunAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {runsounds},
		},
	}},
}

ENT.PainSequences = {
	"nz_base_amalgam_run_pain_01",
	"nz_base_amalgam_run_pain_02",
	"nz_base_amalgam_run_pain_03",
}

ENT.ZombieLandSequences = {
	"nz_base_amalgam_land",
}

ENT.CustomMantleOver48 = {
	"nz_base_amalgam_run_mantle_over_48"
}

ENT.CustomMantleOver72 = {
	"nz_base_amalgam_run_mantle_over_72"
}

ENT.CustomMantleOver96 = {
	"nz_base_amalgam_run_mantle_over_96"
}

ENT.CustomMantleOver128 = {
	"nz_base_amalgam_run_mantle_over_128"
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_amal/attack/vox_amal_attack_08.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_amal/pain/vox_amal_pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/pain/vox_amal_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/pain/vox_amal_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_amal/pain/vox_amal_pain_03.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_amal/death/vox_amal_death.mp3"),
}

ENT.RoarSounds = {
	Sound("nz_moo/zombies/vox/_amal/roar/vox_amal_roar_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/roar/vox_amal_roar_02.mp3"),
	Sound("nz_moo/zombies/vox/_amal/roar/vox_amal_roar_03.mp3"),
	Sound("nz_moo/zombies/vox/_amal/roar/vox_amal_roar_05.mp3"),
	Sound("nz_moo/zombies/vox/_amal/roar/vox_amal_roar_08.mp3"),
	Sound("nz_moo/zombies/vox/_amal/roar/vox_amal_roar_10.mp3"),
}

ENT.BiteSounds = {
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_00.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_01.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_02.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_03.mp3"),
	Sound("nz_moo/zombies/vox/_thrasher/bite/bite_04.mp3"),
}

ENT.StompSounds = {
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_04.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_05.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_06.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_07.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_08.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_09.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_10.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_11.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_step_12.mp3"),
}

ENT.WeakImpactSounds = {
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_00.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_01.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_02.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_03.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_04.mp3"),
}

ENT.GrabSounds = {
	Sound("nz_moo/zombies/vox/_amal/grab/vox_amal_grab_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/grab/vox_amal_grab_01.mp3"),
}

ENT.GrabFlySounds = {
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_grab_arm_launch_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_grab_arm_launch_01.mp3"),
}

ENT.RegenSounds = {
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_regen_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_regen_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_regen_02.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_regen_03.mp3"),
}

ENT.GibSounds = {
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_02.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_03.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_04.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_05.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_06.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_07.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_08.mp3"),
}

ENT.HeadExplodeSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

ENT.ExplodeSWTSounds = {
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_0.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_1.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_2.mp3"),
	Sound("nz_moo/zombies/vox/_margwa/head_explo/margwa_head_explo_3.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(10350)
			self:SetMaxHealth(10350)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 800 + (750 * count), 3500, 398700 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 800 + (750 * count), 3500, 398700 * count))
			else
				self:SetHealth(10350)
				self:SetMaxHealth(10350)	
			end
		end
		
		self.EnrageTime = CurTime() + math.random(35, 60)
		self.Enraged = false
		self:SetIsEnraged(false)

		self:SetTopHead(true)
		self:SetMiddleHead(true)
		self:SetBottomHead(true)

		self.RegenCount = 0

		self.HeadCount = 0
		self.RegenCooldown = CurTime() + 5

		self.IFrames = CurTime() + 3

		self:SetRunSpeed( 36 )

		self.UsingGrab = false
		self.WaitForGrab = false
	end
end

function ENT:OnSpawn()
	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
	effectData:SetMagnitude( 5 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)

	self:SetCollisionBounds(Vector(-16,-16, 0), Vector(16, 16, 72))
	self:SetSurroundingBounds(Vector(-50, -50, 0), Vector(50, 50, 100))
		
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)

	self:EmitSound("nz_moo/zombies/vox/_amal/spawn/evt_amal_spawn.mp3",511)
	self:SetBodygroup(1,0)
	util.SpriteTrail(self, 9, Color(100, 0, 5, 125), true, 95, 45, 0.85, 1 / 40 * 0.3, "materials/trails/plasma")

	if seq then
		self:PlaySequenceAndMove(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmgInfo)	
	self.Dying = true

	if self:GetTopHead() then
		self:PopTopHeadEffect()
	elseif self:GetMiddleHead() then
		self:PopMiddleHeadEffect()
	elseif self:GetBottomHead() then
		self:PopBottomHeadEffect()
	end

	ParticleEffectAttach("zmb_amal_death_drops", 4, self, 1)
	ParticleEffectAttach("zmb_amal_death_model", 4, self, 1)

	ParticleEffect("zmb_amal_death", self:GetPos() + Vector(0,0,1) * self:GetForward() * 10, self:GetAngles(), nil)

	self:EmitSound("nz_moo/zombies/vox/_amal/fly/fly_amal_death_sfx.mp3", 100)
	self:EmitSound("nz_moo/zombies/vox/_amal/fly/fly_amal_death_swt.mp3", 100)
	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:DoDeathAnimation("nz_base_amalgam_death")
end

function ENT:DoDeathAnimation(seq,noragdoll,triggerfakekill)
	self.BehaveThread = coroutine.create(function()
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndMove(seq, 1)
		self:Remove()
	end)
end

function ENT:AI()
	local target = self:GetTarget()
	
	-- ENRAGE
	if !self.Enraged and self.HeadCount == 2 then

		self:DoSpecialAnimation("nz_base_amalgam_taunt")

		self.Enraged = true
		self:SetRunSpeed(71)
		self:SpeedChanged()
	end

	-- Regen from Zombies
	if self.SporeCount ~= 0 and CurTime() > self.RegenCooldown and self.RegenCount < 3 then
		for k,v in nzLevel.GetZombieArray() do
			if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.IsMooSpecial and v ~= self then
				if self:GetRangeTo( v:GetPos() ) < 85 then
					local seq = "nz_base_amalgam_grab_release"
					if self:SequenceHasSpace(seq) then
						if !IsValid(v) then return end

						local dmgInfo = DamageInfo()
						dmgInfo:SetAttacker( self )
						dmgInfo:SetDamage( v:Health() + 666 )
						dmgInfo:SetDamageType( DMG_ALWAYSGIB )

						v:TakeDamageInfo(dmgInfo)

						self.RegenCooldown = CurTime() + 10
						self:TempBehaveThread(function(self)

							self:RegenHead()
							self:SetSpecialAnimation(true)
							self:SetIsBusy(true)
							self:PlaySequenceAndMove(seq, 1)

							self:SetSpecialAnimation(false)
							self:SetIsBusy(false)
						end)
					end
				end
			end
		end
	end

	-- Knock normal zombies aside
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.Non3arcZombie and !v.IsMooSpecial and v ~= self then
			if self:GetRangeTo( v:GetPos() ) < 8^2 then	
				if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() and self:GetRunSpeed() > 36 then
					if v.PainSequences then
						v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
					end
				end
			end
		end
	end
end

function ENT:RegenHead()

	local healththreshold1 = self:GetMaxHealth() * 0.85
	local healththreshold2 = self:GetMaxHealth() * 0.45
	local hpgained = false

	self.RegenCount = self.RegenCount + 1
	self.HeadCount = self.HeadCount - 1

	-- Health just goes back up to previous threshold
	if self:Health() < healththreshold2 and !hpgained then 
		self:SetHealth(healththreshold2) 
		hpgained = true
	elseif self:Health() < healththreshold1 and !hpgained then
		self:SetHealth(healththreshold1)
		hpgained = true
	end

	self:EmitSound(self.RegenSounds[math.random(#self.RegenSounds)], 100)

	if !self:GetTopHead() then
		self:SetTopHead(true)
		self:ManipulateBoneScale(self:LookupBone("bone_8333bcec2fc7db7"), Vector(1,1,1))
		return
	end
	if !self:GetMiddleHead() then
		self:SetMiddleHead(true)
		self:ManipulateBoneScale(self:LookupBone("bone_a5d66c82c8bb797"), Vector(1,1,1))
		return
	end
	if !self:GetBottomHead() then
		self.SetBottomHead(true)
		self:ManipulateBoneScale(self:LookupBone("bone_81cab2d35e92028"), Vector(1,1,1))
		return
	end
end

function ENT:OnInjured(dmginfo)
	if !self:IsAlive() then return end

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce = dmginfo:GetDamageForce()
	local damage = dmginfo:GetDamage()

	local attacker = dmginfo:GetAttacker()

	local head1 = self:LookupBone("bone_8333bcec2fc7db7")
	local head1pos = self:GetAttachment(14).Pos

	local head2 = self:LookupBone("bone_a5d66c82c8bb797")
	local head2pos = self:GetAttachment(16).Pos

	local head3 = self:LookupBone("bone_81cab2d35e92028")
	local head3pos = self:GetAttachment(18).Pos

	local healththreshold1 = self:GetMaxHealth() * 0.65
	local healththreshold2 = self:GetMaxHealth() * 0.35

	if dmginfo:GetDamage() == 18.75 and dmginfo:IsDamageType(DMG_MISSILEDEFENSE) and !self:GetSpecialAnimation() then
		--print("Uh oh Luigi, I'm about to commit insurance fraud lol.")
		self:DoSpecialAnimation("nz_base_amalgam_fatal_02")
		if inflictor and inflictor:GetClass() == "nz_zombie_boss_hulk" then dmginfo:ScaleDamage(0) return end
	end

	if CurTime() > self.IFrames then
		if self:Health() <= healththreshold1 and self.HeadCount == 0 then
			self:TestHead1(dmginfo)
			self:TestHead2(dmginfo)
			self:TestHead3(dmginfo)
		elseif self:Health() <= healththreshold2 and self.HeadCount == 1 then
			self:TestHead1(dmginfo)
			self:TestHead2(dmginfo)
			self:TestHead3(dmginfo)
		end
	end

	if hitpos:DistToSqr(head1pos) < 11^2 and self:GetTopHead() and CurTime() > self.IFrames then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(1)
	elseif hitpos:DistToSqr(head2pos) < 11^2 and self:GetMiddleHead() and CurTime() > self.IFrames then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(1)
	elseif hitpos:DistToSqr(head3pos) < 11^2 and self:GetBottomHead() and CurTime() > self.IFrames then
		self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
		attacker:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], SNDLVL_GUNFIRE, math.random(95,105))
		dmginfo:ScaleDamage(1)
	else
		dmginfo:ScaleDamage(0.25)
	end
end

function ENT:TestHead1(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local head1 = self:LookupBone("bone_8333bcec2fc7db7")
	local head1pos = self:GetAttachment(14).Pos
	if hitpos:DistToSqr(head1pos) < 6.5^2 and self:GetTopHead() then
		local attacker = dmginfo:GetAttacker()

		self.RegenCooldown = CurTime() + 5
		self.IFrames = CurTime() + 4
		self.EnrageTime = 0
		self:SetTopHead(false)
		self.HeadCount = self.HeadCount + 1

		self:PopTopHeadEffect()

    	if IsValid(attacker) then
    		attacker:GivePoints(50)
    	end
	end
end

function ENT:TestHead2(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local head2 = self:LookupBone("bone_a5d66c82c8bb797")
	local head2pos = self:GetAttachment(16).Pos
	if hitpos:DistToSqr(head2pos) < 6.5^2 and self:GetMiddleHead() then
		local attacker = dmginfo:GetAttacker()

		self.RegenCooldown = CurTime() + 5
		self.IFrames = CurTime() + 4
		self.EnrageTime = 0
		self:SetMiddleHead(false)
		self.HeadCount = self.HeadCount + 1

		self:PopMiddleHeadEffect()

    	if IsValid(attacker) then
    		attacker:GivePoints(50)
    	end
	end
end

function ENT:TestHead3(dmginfo)
	local hitpos = dmginfo:GetDamagePosition()
	local head3 = self:LookupBone("bone_81cab2d35e92028")
	local head3pos = self:GetAttachment(18).Pos
	if hitpos:DistToSqr(head3pos) < 6.5^2 and self:GetBottomHead() then
		local attacker = dmginfo:GetAttacker()

		self.RegenCooldown = CurTime() + 5
		self.IFrames = CurTime() + 4
		self.EnrageTime = 0
		self:SetBottomHead(false)
		self.HeadCount = self.HeadCount + 1

		self:PopBottomHeadEffect()

    	if IsValid(attacker) then
    		attacker:GivePoints(50)
    	end
	end
end

function ENT:PopTopHeadEffect()
	local head1 = self:LookupBone("bone_8333bcec2fc7db7")
	local head1pos = self:GetAttachment(14).Pos

	self:ManipulateBoneScale(head1, Vector(0.00001,0.00001,0.00001))
	ParticleEffect("bo3_thrasher_blood",head1pos, Angle(0,0,0), nil)
	self:EmitSound(self.HeadExplodeSounds[math.random(#self.HeadExplodeSounds)], 511)
	self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
	self:DoSpecialAnimation("nz_base_amalgam_run_pain_01")
end

function ENT:PopMiddleHeadEffect()
	local head2 = self:LookupBone("bone_a5d66c82c8bb797")
	local head2pos = self:GetAttachment(16).Pos

	self:ManipulateBoneScale(head2, Vector(0.00001,0.00001,0.00001))
	ParticleEffect("bo3_thrasher_blood",head2pos, Angle(0,0,0), nil)
	self:EmitSound(self.HeadExplodeSounds[math.random(#self.HeadExplodeSounds)], 511)
	self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
	self:DoSpecialAnimation("nz_base_amalgam_run_pain_02")
end

function ENT:PopBottomHeadEffect()
	local head3 = self:LookupBone("bone_81cab2d35e92028")
	local head3pos = self:GetAttachment(18).Pos

	self:ManipulateBoneScale(head3, Vector(0.00001,0.00001,0.00001))
	ParticleEffect("bo3_thrasher_blood",head3pos, Angle(0,0,0), nil)
	self:EmitSound(self.HeadExplodeSounds[math.random(#self.HeadExplodeSounds)], 511)
	self:PlaySound(self.PainSounds[math.random(#self.PainSounds)], 90, math.random(85, 105), 1, 2)
	self:DoSpecialAnimation("nz_base_amalgam_run_pain_03")
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:AttemptGrab(short)
	local target = self:GetTarget()
	local seq_in = "nz_base_amalgam_grab_long_in"
	local seq_out = "nz_base_amalgam_grab_long_out"

	if !IsValid(target) then return end
	--if !self:CanGrab() then short = true end

	if short then
		seq_in = "nz_base_amalgam_grab_short_in"
		seq_out = "nz_base_amalgam_grab_short_out"
	end

	self.GrabCooldown = CurTime() + math.random(6,12)
	self:SetUsingGrab(true)
	self.ReleasePlayer = false

	self:FaceTowards(target:GetPos())
	self:TempBehaveThread(function(self)
		self:SolidMaskDuringEvent(MASK_NPCSOLID_BRUSHONLY)
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndMove(seq_in, 1)

		local target = self.Target
		local grabpos = self:GetAttachment(13).Pos

		if IsValid(target) and target:IsPlayer() then
			if !self:IsEntBlocked(target:GetPos(), grabpos) and grabpos:DistToSqr(target:GetPos()) < 210^2 then
				self.GrabbedPlayer = true
				self:SetCurrentPlayer(target)
				target.MimicParent = self
			end
		end

		if self.GrabbedPlayer then
			self:PlaySequenceAndMove(seq_out, 1)
			self:PlaySequenceAndMove("nz_base_amalgam_grab_release", 1)
			self.GrabbedPlayer = false
		else
			self:PlaySequenceAndMove(seq_out, 1)
			self:PlaySequenceAndMove("nz_base_amalgam_grab_release", 1)
		end

		self:SetUsingGrab(false)
		self:SetSpecialAnimation(false)
		self:CollideWhenPossible()

	end)
end

function ENT:OnNuke() 
	self:PerformStun(5)
end

function ENT:CustomAnimEvent(a,b,c,d,e)

	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large

	if e == "amalgam_grab_hitbox" then
	end
	if e == "step_right_small" or e == "step_left_small" then
		self:EmitSound(self.StompSounds[math.random(#self.StompSounds)], 80, math.random(95,105))
		util.ScreenShake(self:GetPos(),1,1,0.2,450)
	end
	if e == "step_right_large" or e == "step_left_large" then
		self:EmitSound(self.StompSounds[math.random(#self.StompSounds)], 80, math.random(95,105))
		util.ScreenShake(self:GetPos(),1,1,0.2,450)
	end
	if e == "amalgam_taunt" then
		self:PlaySound(self.RoarSounds[math.random(#self.RoarSounds)], 90, math.random(85, 105), 1, 2)
		self:EmitSound("nz_moo/zombies/vox/_thrasher/enrage_imp_00.mp3",577)
		ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,60)),Angle(0,0,0),nil)	
	end

	if e == "amalgam_grab_launch" then
		self:PlaySound(self.GrabSounds[math.random(#self.GrabSounds)], 90, math.random(85, 105), 1, 2)
		self:EmitSound("nz_moo/zombies/vox/_amal/fly/fly_amal_grab_arm_retract_long.mp3", 80, math.random(95,105))
	end

	if e == "amalgam_grab_release_victim" then
		self.ReleasePlayer = true
	end
end

function ENT:OnThink()
	if self.WaitForGrab and self:GetStop() then
		self:SetStop(false)
		self:SetSpecialAnimation(false)

		self.WaitForGrab = false
		self.UsingGrab = false
	end
	if self.UsingGrab and !IsValid(self.Grab) then
		self:FinishGrab()
	end
end

function ENT:OnRemove()
	if IsValid(self.Grab) then self.Grab:Remove() end
end