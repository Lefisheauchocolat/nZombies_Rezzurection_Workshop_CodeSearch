AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Brutus"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

if CLIENT then

	function ENT:Draw()
		self:DrawModel()

		self:DrawEyeGlow() 
		self:Lamp()

		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end

	function ENT:DrawEyeGlow()
		local eyeglow =  Material("nz_moo/sprites/moo_glow1")
		local eyeColor = Color(255,0,0)
		local latt = self:LookupAttachment("lefteye")
		local ratt = self:LookupAttachment("righteye")

		if latt == nil then return end
		if ratt == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)

		if leye == nil then return end
		if reye == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.5
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.5

		if lefteyepos and righteyepos then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 4, 4, eyeColor)
			render.DrawSprite(righteyepos, 4, 4, eyeColor)
		end
	end

	function ENT:Lamp()

		local lightglow = Material( "sprites/physg_glow1_noz" )
		local lightyellow = Color( 255, 255, 200, 200 )
		local bone = self:LookupAttachment("light_fx_tag")
		local spotlight = self:GetAttachment(bone)
		local pos, ang = spotlight.Pos, spotlight.Ang
		local lightglow = Material( "sprites/physg_glow1_noz" )
		local lightyellow = Color( 255, 255, 200, 200 )
		local finalpos = pos

		cam.Start3D2D(finalpos, ang, 1)
			surface.SetAlphaMultiplier(1)
			surface.SetMaterial(lightglow)
			surface.SetDrawColor(lightyellow)
			surface.DrawTexturedRect(-25,-10,100,20)
		cam.End3D2D()
		
		ang:RotateAroundAxis(ang:Forward(),90)

		cam.Start3D2D(finalpos, ang, 1)
			surface.SetAlphaMultiplier(1)
			surface.SetMaterial(lightglow)
			surface.SetDrawColor(lightyellow)
			surface.DrawTexturedRect(-25,-10,100,20)
		cam.End3D2D()
	end
end

local util_traceline 	= util.TraceLine
local util_tracehull 	= util.TraceHull

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true

ENT.AttackRange = 95
ENT.DamageRange = 100
ENT.AttackDamage = 85

ENT.Models = {
	{Model = "models/moo/_codz_ports/t6/hellcatraz/moo_codz_t6_hellcatraz_cellbreaker.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.DeathSequences = {
	"nz_base_zombie_cellbreaker_death_01",
	"nz_base_zombie_cellbreaker_death_02",
	"nz_base_zombie_cellbreaker_death_explode",
	"nz_base_zombie_cellbreaker_death_mg",
}

local JumpSequences = {
	{seq = "nz_barricade_trav_walk_1"},
	{seq = "nz_barricade_trav_walk_2"},
	{seq = "nz_barricade_trav_walk_3"},
}

local RunJumpSequences = {
	{seq = "nz_barricade_run_1"},
	{seq = "nz_l4d_mantle_over_36"},
}

local SprintJumpSequences = {
	{seq = "nz_barricade_sprint_1"},
	{seq = "nz_barricade_sprint_2"},
}

local NormalAttackSequences = {
	{seq = "nz_base_zombie_cellbreaker_attack_01"},
	{seq = "nz_base_zombie_cellbreaker_attack_02"},
	{seq = "nz_base_zombie_cellbreaker_attack_03"},
}

local LockPerkSequences = {
	{seq = "nz_base_zombie_cellbreaker_lock_perkmachine"},
}

local LockBoxSequences = {
	{seq = "nz_base_zombie_cellbreaker_lock_magicbox"},
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_0.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_1.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_2.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_3.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_4.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_5.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_6.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_7.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_8.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_9.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_10.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_defeated_d_11.mp3"),
}

ENT.AppearSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_scary_laugh_d_0.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_10.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_11.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_12.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_13.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_14.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_15.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_2.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_4.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_6.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_7.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_arrives_d_9.mp3"),
}

ENT.LockPerkSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_0.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_1.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_2.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_4.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_6.mp3"),
}

ENT.LockBoxSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_3.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_4.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_5.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_lockbox_d_7.mp3"),
}

ENT.SlamSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_0.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_1.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_2.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_3.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_4.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_5.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_6.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_7.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_8.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_9.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_10.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_11.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_12.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_13.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_14.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_15.mp3"),
}

ENT.IdleSequence = "nz_base_zombie_cellbreaker_idle_a"
ENT.IdleSequenceAU = "nz_base_zombie_cellbreaker_idle_b"
ENT.NoTargetIdle = "nz_base_zombie_cellbreaker_idle_a"

ENT.ZombieStunInSequence = "nz_base_zombie_cellbreaker_stun_in"
ENT.ZombieStunOutSequence = "nz_base_zombie_cellbreaker_stun_out"

ENT.SparkySequences = {
	"nz_base_zombie_cellbreaker_stun_loop",
	"nz_base_zombie_cellbreaker_stun_loop",
	"nz_base_zombie_cellbreaker_stun_loop",
	"nz_base_zombie_cellbreaker_stun_loop",
	"nz_base_zombie_cellbreaker_stun_loop",
}

ENT.GroundSlamSequences = {
	"nz_base_zombie_cellbreaker_ground_slam",
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_zombie_cellbreaker_walk_01",
			},
			AttackSequences = {NormalAttackSequences},
			StandAttackSequences = {NormalAttackSequences},
			LockPerkSequences = {LockPerkSequences},
			LockBoxSequences = {LockBoxSequences},
			BreakBarricadeSequences = {BreakBarricadeSequences},
			JumpSequences = {SprintJumpSequences},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_zombie_cellbreaker_run_01",
				"nz_base_zombie_cellbreaker_run_02",
				"nz_base_zombie_cellbreaker_run_03",
				"nz_base_zombie_cellbreaker_run_04",
			},
			AttackSequences = {NormalAttackSequences},
			StandAttackSequences = {NormalAttackSequences},
			LockPerkSequences = {LockPerkSequences},
			LockBoxSequences = {LockBoxSequences},
			BreakBarricadeSequences = {BreakBarricadeSequences},
			JumpSequences = {SprintJumpSequences},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_zombie_cellbreaker_sprint_01",
				"nz_base_zombie_cellbreaker_sprint_02",
				"nz_base_zombie_cellbreaker_sprint_01",
				"nz_base_zombie_cellbreaker_sprint_02",
				"nz_base_zombie_cellbreaker_sprint_01",
				"nz_base_zombie_cellbreaker_sprint_02",
				"nz_base_zombie_cellbreaker_sprint_01",
				"nz_base_zombie_cellbreaker_sprint_02",
				"nz_base_zombie_cellbreaker_sprint_01",
				"nz_base_zombie_cellbreaker_sprint_02",
				"nz_bo3_zombie_sprint_v4",
			},
			AttackSequences = {NormalAttackSequences},
			StandAttackSequences = {NormalAttackSequences},
			LockPerkSequences = {LockPerkSequences},
			LockBoxSequences = {LockBoxSequences},
			BreakBarricadeSequences = {BreakBarricadeSequences},
			JumpSequences = {SprintJumpSequences},
		},
	}}
}

ENT.FootstepSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/step/brutus_step_00.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/step/brutus_step_01.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/step/brutus_step_02.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/step/brutus_step_03.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/step/brutus_step_04.mp3"),
}

ENT.GearSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/gear/brutus_gear_00.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/gear/brutus_gear_01.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/gear/brutus_gear_02.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/gear/brutus_gear_03.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/gear/brutus_gear_04.mp3"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/swing/brutus_swing_00.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/swing/brutus_swing_01.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/swing/brutus_swing_02.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/swing/brutus_swing_03.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/swing/brutus_swing_04.mp3"),
}

ENT.SmokeBombPrimeSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/gas_drop/brutus_gas_drop_02.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/gas_drop/brutus_gas_drop_03.mp3"),
}

ENT.SmokeBombRipSounds = {
	Sound("nz_moo/zombies/vox/_bruiser/gas_drop/brutus_gas_tear_00.mp3"),
	Sound("nz_moo/zombies/vox/_bruiser/gas_drop/brutus_gas_tear_01.mp3"),
}

ENT.WeakImpactSounds = {
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_00.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_01.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_02.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_03.mp3"),
	Sound("nz_moo/zombies/gibs/prj_impact/prj_bullet_flesh_04.mp3"),
}

ENT.MetalImpactSounds = {
	Sound("physics/metal/metal_solid_impact_bullet1.wav"),
	Sound("physics/metal/metal_solid_impact_bullet2.wav"),
	Sound("physics/metal/metal_solid_impact_bullet3.wav"),
	Sound("physics/metal/metal_solid_impact_bullet4.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying() * 0.5

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(2500)
			self:SetMaxHealth(2500)
		else
			self:SetHealth(nzRound:GetNumber() * 500 + (1000 * count))
			self:SetMaxHealth(nzRound:GetNumber() * 500 + (1000 * count))
		end

		self.HelmetHP = self:Health() * 0.75
		self.HasHelmet = true

		self.AllowRallyAbility = false
		self.CanRally = false
		self.RallyCooldown = CurTime() + 1

		self.Angered = false

		self.SlamCooldown = CurTime() + math.Rand(4.75,7.89)

		self.DestructionTarget = nil
		self.GeneralDestruction = false
		self.PerkDestruction = false
		self.BoxDestruction = false
		self.BarricadeDestruction = false
		self.EntDestruction = false

		self.DestructionCoolDown = CurTime() + 10

		self:SetRunSpeed(36)
		self:SetBodygroup(0,0)
	end
end

function ENT:OnSpawn()
	self:SetSurroundingBounds(Vector(-30, -30, 0), Vector(30, 30, 80))

	self:SetNoDraw(true)
	self:SetInvulnerable(true)
	self:SetBlockAttack(true)
	self:SolidMaskDuringEvent(MASK_PLAYERSOLID)

	--self:EmitSound("nz_moo/zombies/vox/_bruiser/brutus_spawn_2d.mp3",511)

	self:TimeOut(2.75)
	
	self:SetNoDraw(false)
	--self:EmitSound("nz_moo/zombies/vox/_bruiser/brutus_spawn_02.mp3",511)
	nzSounds:PlayFile("nz_moo/zombies/vox/_bruiser/brutus_spawn_02.mp3")
	self:EmitSound("nz_moo/zombies/vox/_bruiser/brutus_spawn.mp3",577,math.random(95,105))
	ParticleEffectAttach("ins_skybox_lightning",PATTACH_ABSORIGIN_FOLLOW,self,0)
	ParticleEffect("dusty_explosion_rockets",self:GetPos(),self:GetAngles(),nil)
	util.ScreenShake(self:GetPos(),10000,5000,2,999000)
	
	self:SetInvulnerable(nil)
	self:SetBlockAttack(false)
	self:CollideWhenPossible()
	self:EmitSound(self.AppearSounds[math.random(#self.AppearSounds)], 577)

	self:DoSpecialAnimation("nz_base_zombie_cellbreaker_spawn")
end

function ENT:OnNuke() 
	self:PerformStun(math.random(2,5))
end

function ENT:PerformDeath(dmgInfo)
	self.Dying = true

	self:SetBodygroup(0,1)

	-- These sounds are 2d and play on the client... Just like in real life.
	nzSounds:PlayFile("nz_moo/zombies/vox/_bruiser/death.mp3")
	nzSounds:PlayFile(self.DeathSounds[math.random(#self.DeathSounds)])

	ParticleEffectAttach("driese_tp_arrival_ambient",PATTACH_ABSORIGIN,self,0)
	if self:GetSpecialAnimation() then
		self:BecomeRagdoll(dmgInfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:AI()
	local target = self.Target

	if !self:IsAlive() then return end

	-- Ground Slam Attack
	if CurTime() > self.SlamCooldown and !self:IsAttackBlocked() and IsValid(target) and target:IsPlayer() and self:TargetInRange(150) and !self.HasHelmet then
		self.SlamCooldown = CurTime() + math.Rand(7.75,12.89)
		self:DoSpecialAnimation(self.GroundSlamSequences[math.random(#self.GroundSlamSequences)])
	end

	-- RALLY THE "INMATES"
	if self.AllowRallyAbility then
		for k,v in nzLevel.GetZombieArray() do
			if k >= 10 then
				self.CanRally = true
			else
				self.CanRally = false
			end
		end
		if self.CanRally and CurTime() > self.RallyCooldown and math.random(100) < 15 and !self:GetSpecialAnimation() then
			self.RallyCooldown = CurTime() + math.Rand(18.25,24.5)

			self:TempBehaveThread(function(self)
				self:SetSpecialAnimation(true)
				self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
				self:PlaySequenceAndMove("nz_base_zombie_cellbreaker_enrage_start")
				self:PlaySequenceAndMove("nz_base_zombie_cellbreaker_summondogs")

				self:SetTargetPriority(TARGET_PRIORITY_MONSTERINTERACT)
				self:SetSpecialAnimation(false)
			end)
		end
	end

	-- The BRUHDIS Logic
	if !self.GeneralDestruction then
		local roll = math.random(4)
		if roll == 1 then
			for k,v in nzLevel.GetVultureArray() do //cheeky innit?
				if not IsValid(v) then continue end
				if v:GetClass() ~= "perk_machine" then continue end

				local d = self:GetRangeTo(v)
				self.GeneralDestruction = true
				if d < 400 then
					if v:IsOn() and !v:GetBeingUsed() and !v:GetBrutusLocked() and self:IsInBrutusLoS(v) then
						self.PerkDestruction = true
					else
						self.GeneralDestruction = false
					end
				else
					self.GeneralDestruction = false
				end
			end
		elseif roll == 2 then
			for k,v in nzLevel.GetVultureArray() do
				if not IsValid(v) then continue end
				if v:GetClass() ~= "random_box" then continue end

				local d = self:GetRangeTo(v)
				self.GeneralDestruction = true
				if d < 400 and !nzPowerUps:IsPowerupActive("firesale") and self:IsInBrutusLoS(v) then
					if v:GetActivated() and !v:GetOpen() and !v.Moving then
						self.BoxDestruction = true
					else
						self.GeneralDestruction = false
					end
				else
					self.GeneralDestruction = false
				end
			end
		elseif roll == 3 then
			for k,v in nzLevel.GetBrutusEntityArray() do //ents with a specific bool
				if not IsValid(v) or v:GetNoDraw() then continue end

				if v.BrutusDestructable and self:IsInBrutusLoS(v) then
					local d = self:GetRangeTo(v)
					self.GeneralDestruction = true
					if d < 400 then
						if !v:GetBrutusLocked() then
							self.EntDestruction = true
						else
							self.GeneralDestruction = false
						end
					else
						self.GeneralDestruction = false
					end
				end
			end
		end
	end
end

-- Modified version of the IsAttackBlocked for Brutus so he can properly detect if he can reach something or not by testing if its in his line of sight.
function ENT:IsInBrutusLoS(ent)
	if IsValid(ent) then
		local pos = self:EyePos()

		local tr = util_traceline({
			start = pos,
			endpos = ent:GetPos(),
			filter = self,
			mask = MASK_PLAYERSOLID,
			collisiongroup = COLLISION_GROUP_WORLD,
			ignoreworld = false
		})

		local tent = tr.Entity


		if IsValid(tent) and tent:IsPlayer() then return false end
		if tent:IsWorld() then return false end


		-- Return true if the entity hit is the one testing if it can be seen.
		if IsValid(tent) and (tent:EntIndex() == ent:EntIndex()) then 
			self.DestructionTarget = tent -- Making sure so that the entity he hits is the one we're actually checking for. For example Dtap has been taking blows for Juicers and Jugg on Contagion this whole time.
			return true 
		end
	end
end


function ENT:PostTookDamage(dmginfo) 
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local dmgtype = dmginfo:GetDamageType()
	local damage = dmginfo:GetDamage()

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
	local hitforce = dmginfo:GetDamageForce()

	local head = self:GetBonePosition(self:LookupBone("j_head"))

	if hitpos:DistToSqr(head) < 12^2 then
		if self.HasHelmet then
			if self.HelmetHP > 0 then

				self:EmitSound(self.MetalImpactSounds[math.random(#self.MetalImpactSounds)], 95, math.random(95,105))
				ParticleEffectAttach("npcarmor_hit", PATTACH_POINT_FOLLOW, self, 10)

				self.HelmetHP = self.HelmetHP - damage

				dmginfo:ScaleDamage(0.015)
			else
				self.HasHelmet = false

				self:SetBodygroup(0,1)
				nzSounds:PlayFile("nz_moo/zombies/vox/_bruiser/brutus_helmet.mp3")
				nzSounds:PlayFile("nz_moo/zombies/vox/_bruiser/brutus_helmet_flux.mp3")
				ParticleEffectAttach("npcarmor_break", PATTACH_POINT_FOLLOW, self, 10)

				self:DoSpecialAnimation("nz_base_zombie_cellbreaker_gasattack")

				self:SetRunSpeed(72)
				self:SpeedChanged()
			end
		else
			self:EmitSound(self.WeakImpactSounds[math.random(#self.WeakImpactSounds)], 95, math.random(95,105))
			dmginfo:ScaleDamage(0.5)
		end
	else
		dmginfo:ScaleDamage(0.15)
	end
end

function ENT:OnRemove() end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	if self.EntDestruction then return IsValid(ent) and ent.BrutusDestructable and !ent:GetBrutusLocked() end
	if self.PerkDestruction then return IsValid(ent) and ent:GetClass() == "perk_machine" and !ent:GetBrutusLocked() and ent == self.DestructionTarget end
	if self.BoxDestruction then return IsValid(ent) and ent:GetClass() == "random_box" and ent == self.DestructionTarget end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:CustomAnimEvent(a,b,c,d,e)

	self.OverrideLsmall = true
	self.OverrideLLarge = true
	self.OverrideRsmall = true
	self.OverrideRLarge = true

	if e == "cellbreaker_gasattack" then
		self:EmitSound(self.SmokeBombPrimeSounds[math.random(#self.SmokeBombPrimeSounds)], 90)
	end

	if e == "cellbreaker_gas_rip" then
		self:EmitSound(self.SmokeBombRipSounds[math.random(#self.SmokeBombRipSounds)], 90, math.random(95,105))
	end

	if e == "cellbreaker_gasattack_end" then
		util.ScreenShake(self:GetPos(), 10, 255, 1, 150)
		ParticleEffectAttach("ins_m203_smokegrenade",PATTACH_POINT,self,1)
		self:EmitSound("nz_moo/zombies/vox/_bruiser/gas_drop/brutus_canister.mp3")
	end

	if e == "cellbreaker_slam_warn" then
		self:EmitSound(self.SlamSounds[math.random(#self.SlamSounds)], 100, math.random(85, 105), 1, 2)
	end

	if e == "cellbreaker_slam" then
		local target = self:GetTarget()
		self:EmitSound("nz_moo/zombies/vox/_cellbreaker/slam/initial_zap_0"..math.random(0,3)..".mp3",100)
		self:EmitSound("nz_moo/zombies/vox/_cellbreaker/slam/rubble_0"..math.random(0,3)..".mp3",100,math.random(95,105))
		ParticleEffect("driese_tp_arrival_phase2",self:LocalToWorld(Vector(60,-30,0)),Angle(0,0,0),nil)
		ParticleEffect("driese_tp_arrival_ambient",self:LocalToWorld(Vector(60,-30,0)),Angle(0,0,0),nil)
		util.ScreenShake(self:GetPos(),10000,5000,1,1000)

		if target:IsPlayer() and self:TargetInRange(175) then
			local dmgInfo = DamageInfo()
			dmgInfo:SetAttacker( self )
			dmgInfo:SetDamage( 75 )
			dmgInfo:SetDamageType( DMG_SHOCK )

			target:TakeDamageInfo(dmgInfo)
			target:NZSonicBlind(3)
		end

		for k,v in nzLevel.GetZombieArray() do
			if IsValid(v) and !v:GetSpecialAnimation() and v.IsMooZombie and !v.IsMooSpecial and v ~= self then
				if self:GetRangeTo( v:GetPos() ) < 10^2 then	
					if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() then
						if v.PainSequences then
							v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], true, true)
						end
					end
				end
			end
		end
	end

	if e == "cellbreaker_rally_scene_lightning" then
		self:EmitSound("nz_moo/zombies/vox/_cellbreaker/slam/initial_zap_0"..math.random(0,3)..".mp3",100)
		ParticleEffect("driese_tp_arrival_phase2",self:LocalToWorld(Vector(60,-30,0)),Angle(0,0,0),nil)
		ParticleEffect("driese_tp_arrival_ambient",self:LocalToWorld(Vector(60,-30,0)),Angle(0,0,0),nil)
		util.ScreenShake(self:GetPos(),10000,5000,1,1000)

		for k,v in nzLevel.GetZombieArray() do
			if IsValid(v) and v.IsMooZombie and !v.IsMooSpecial and v ~= self then
				if self:GetRangeTo( v:GetPos() ) < 10^2 then	
					if v.IsMooZombie then
						v:PerformStun(2)
						v:SetRunSpeed(250)
						v.loco:SetDesiredSpeed( v:GetRunSpeed() )
						v:SpeedChanged()
						v:SetBomberBuff(true)
						v:SetWaterBuff(true)
					end
				end
			end
		end
	end

	if e == "cellbreaker_lock_perkmachine" then
		local perk = self:GetTarget()
		if IsValid(perk) then
			perk:OnBrutusLocked()
			self.EntDestruction = false
			self.PerkDestruction = false
			self.GeneralDestruction = false
			self.DestructionTarget = nil
			nzSounds:PlayFile("nz_moo/zombies/vox/_bruiser/clang.mp3")

			self:PlaySound(self.LockPerkSounds[math.random(#self.LockPerkSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch))
			--self.DestructionCoolDown = CurTime() + 10
		end
	end

	if e == "cellbreaker_lock_magicbox" then
		local box = self:GetTarget()
		if IsValid(box) then
			box:MoveAway()
			self.BoxDestruction = false
			self.GeneralDestruction = false
			self.DestructionTarget = nil
			nzSounds:PlayFile("nz_moo/zombies/vox/_bruiser/clang.mp3")

			self:PlaySound(self.LockBoxSounds[math.random(#self.LockBoxSounds)], 100, math.random(self.MinSoundPitch, self.MaxSoundPitch))
			--self.DestructionCoolDown = CurTime() + 10
		end
	end

	if e == "step_left_small" then

		self:EmitSound(self.FootstepSounds[math.random(#self.FootstepSounds)], 80, math.random(95,100))
		self:EmitSound(self.GearSounds[math.random(#self.GearSounds)], 80, math.random(95,100))
		util.ScreenShake(self:GetPos(),125,500,0.2,1000)
		ParticleEffectAttach("brutus_burning_footstep",PATTACH_POINT,self,11)
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end

	if e == "step_right_small" then

		self:EmitSound(self.FootstepSounds[math.random(#self.FootstepSounds)], 80, math.random(95,100))
		self:EmitSound(self.GearSounds[math.random(#self.GearSounds)], 80, math.random(95,100))
		util.ScreenShake(self:GetPos(),125,500,0.2,1000)
		ParticleEffectAttach("brutus_burning_footstep",PATTACH_POINT,self,12)
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end

	if e == "step_left_large" then

		self:EmitSound(self.FootstepSounds[math.random(#self.FootstepSounds)], 80, math.random(95,100))
		self:EmitSound(self.GearSounds[math.random(#self.GearSounds)], 80, math.random(95,100))
		util.ScreenShake(self:GetPos(),125,500,0.2,1000)
		ParticleEffectAttach("brutus_burning_footstep",PATTACH_POINT,self,11)
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end

	if e == "step_right_large" then
		
		self:EmitSound(self.FootstepSounds[math.random(#self.FootstepSounds)], 80, math.random(95,100))
		self:EmitSound(self.GearSounds[math.random(#self.GearSounds)], 80, math.random(95,100))
		util.ScreenShake(self:GetPos(),125,500,0.2,1000)
		ParticleEffectAttach("brutus_burning_footstep",PATTACH_POINT,self,12)
		if self:ZombieWaterLevel() > 0 then
			self:EmitSound(self.WaterFootstepsSounds[math.random(#self.WaterFootstepsSounds)], 70)
		end
	end
end

function ENT:Attack( data )
	self:SetLastAttack(CurTime())

	local useswalkframes = false

	data = data or {}
			
	data.attackseq = data.attackseq
	if !data.attackseq then

		local attacktbl = self.AttackSequences

		self:SetStandingAttack(false)

		if self.PerkDestruction then
			attacktbl = self.LockPerkSequences
		elseif self.BoxDestruction then
			attacktbl = self.LockBoxSequences
		elseif self.BarricadeDestruction then
			attacktbl = self.BreakBarricadeSequences
		elseif self.EntDestruction then
			attacktbl = self.LockPerkSequences
		end

		if self:GetTarget():GetVelocity():LengthSqr() < 175 and self.Target:IsPlayer() and !self.IsTurned then
			if self.StandAttackSequences then
				attacktbl = self.StandAttackSequences
			end
			self:SetStandingAttack(true)
		end

		local target = type(attacktbl) == "table" and attacktbl[math.random(#attacktbl)] or attacktbl

		if type(target) == "table" then
			local id, dur = self:LookupSequenceAct(target.seq)
			if target.dmgtimes then
				data.attackseq = {seq = id, dmgtimes = target.dmgtimes }
				useswalkframes = false
			else
				data.attackseq = {seq = id} -- Assume that if the selected sequence isn't using dmgtimes, its probably using notetracks.
				useswalkframes = true
			end
			data.attackdur = dur
		elseif target then -- It is a string or ACT
			local id, dur = self:LookupSequenceAct(attacktbl)
			data.attackseq = {seq = id, dmgtimes = {dur/2}}
			data.attackdur = dur
		else
			local id, dur = self:LookupSequence("swing")
			data.attackseq = {seq = id, dmgtimes = {1}}
			data.attackdur = dur
		end
	end

	self:SetAttacking( true )
	if IsValid(self:GetTarget()) and self:GetTarget():Health() and self:GetTarget():Health() > 0 then -- Doesn't matter if its a player... If the zombie is targetting it, they probably wanna attack it.
		if data.attackseq.dmgtimes then
			for k,v in pairs(data.attackseq.dmgtimes) do
				self:TimedEvent( v, function()
					if self.AttackSounds then self:PlaySound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2) end
					self:EmitSound("nz_moo/zombies/fly/attack/whoosh/zmb_attack_med_0"..math.random(0,2)..".mp3", 75)
					self:DoAttackDamage()
				end)
			end
		end
	end

	self:TimedEvent(data.attackdur, function()
		self:SetAttacking(false)
		self:SetLastAttack(CurTime())
	end)

	if useswalkframes then
		self:PlaySequenceAndMove(data.attackseq.seq, 1, self.FaceEnemy)
	else
		self:PlayAttackAndWait(data.attackseq.seq, 1)
	end
end
