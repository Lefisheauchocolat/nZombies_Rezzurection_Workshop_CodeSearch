AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Disciple"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

function ENT:InitDataTables()
	self:NetworkVar("Bool", 6, "UsingLifeDrain")
	self:NetworkVar("Entity", 6, "CurrentTarget")
end

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t10_zombies/jup/disciple/xmaterial_2d0375ff3b4bf12.vmt"),
		[1] = Material("models/moo/codz/t10_zombies/jup/disciple/xmaterial_6d54dc818dff8d7.vmt"),
		[2] = Material("models/moo/codz/t10_zombies/jup/xmaterial_e739cc7eabf07b.vmt"),
		[3] = Material("models/moo/codz/t10_zombies/jup/xmaterial_7bc5221105f892b.vmt"),
	}

	local eyeglow =  Material("nz_moo/sprites/moo_glow1")

	local defaultColor = Color(255, 75, 0, 255)

	function ENT:Draw() //Runs every frame
		self:DrawModel()
		self:PostDraw()
		if self.RedEyes == true and self:IsAlive() and !self:GetDecapitated() then
			self:DrawEyeGlow() 
		end

		if GetConVar( "nz_zombie_debug" ):GetBool() then
			render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
		end
	end

	function ENT:PostDraw() 

		if self:GetUsingLifeDrain() and IsValid(self:GetCurrentTarget()) and !IsValid(self.Beam) then
			local p = CreateParticleSystem(self, "zmb_disciple_lifedrain", PATTACH_ABSORIGIN_FOLLOW)
			p:AddControlPoint(0, self, PATTACH_POINT_FOLLOW, "rhand_fx_tag", Vector(0,0,0))
			p:AddControlPoint(1, self:GetCurrentTarget(), PATTACH_ABSORIGIN_FOLLOW, "chest", Vector(0,0,50))
			self.Beam = p
		elseif !self:GetUsingLifeDrain() or !IsValid(self:GetCurrentTarget()) then
			if IsValid(self.Beam) then
				self.Beam:StopEmission(false, true)
				self.Beam = nil
			end
		end

		if self:IsAlive() then
			local col = nzMapping.Settings.zombieeyecolor
			local elight = DynamicLight( self:EntIndex(), true )
			if ( elight ) then
				local bone = self:LookupBone("j_spineupper")
				local pos = self:GetBonePosition(bone)
				pos = pos 
				elight.pos = pos
				elight.r = 95
				elight.g = 0
				elight.b = 255
				elight.brightness = 6
				elight.Decay = 1000
				elight.Size = 40
				elight.DieTime = CurTime() + 1
				elight.style = 0
				elight.noworld = true
			end
		end

		self:EffectsAndSounds()
	end

	function ENT:DrawEyeGlow()
		local eyeColor = nzMapping.Settings.zombieeyecolor
		local nocolor = Color(0,0,0)

		if eyeColor == nocolor then return end


		local latt = self:LookupAttachment("lefteye")
		local ratt = self:LookupAttachment("righteye")

		if latt == nil then return end
		if ratt == nil then return end

		local leye = self:GetAttachment(latt)
		local reye = self:GetAttachment(ratt)

		if leye == nil then return end
		if reye == nil then return end

		local righteyepos = leye.Pos + leye.Ang:Forward()*0.49
		local lefteyepos = reye.Pos + reye.Ang:Forward()*0.49

		if lefteyepos and righteyepos then
			render.SetMaterial(eyeglow)
			render.DrawSprite(lefteyepos, 5, 5, eyeColor)
			render.DrawSprite(righteyepos, 5, 5, eyeColor)
		end


		if self.EyeColorTable then
			-- Go through every material given and set the color.
			local eyecolor = nzMapping.Settings.zombieeyecolor
			local col = Color(eyecolor.r,eyecolor.g,eyecolor.b):ToVector()

			for k,v in pairs(self.EyeColorTable) do
				v:SetVector("$emissiveblendtint", col)
			end
		end
	end
	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_disciple_aura", PATTACH_POINT_FOLLOW, 9)
			end
			if !self.Draw_SFX or !IsValid(self.Draw_SFX) then
				self.Draw_SFX = "nz_moo/zombies/vox/_sonoforda/xsound_2668586603af8b4.wav"

				self:EmitSound(self.Draw_SFX, 65, math.random(95, 105), 1, 3)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true
ENT.IsMooSpecial = true
ENT.IsMiniBoss = true
--ENT.IsNZAlly = true

ENT.AttackRange 			= 1
ENT.DamageRange 			= 275
ENT.AttackDamage 			= 25

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_disciple.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_ai_disciple_startle"}

ENT.DeathSequences = {
	"nz_ai_disciple_death",
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
}

local AttackSequences = {
	{seq = "nz_attack_stand_ad_1"},
}

local JumpSequences = {
	{seq = "nz_ai_disciple_mantle_48"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.IdleSequence = "nz_ai_disciple_idle_01"
ENT.IdleSequenceAU = "nz_ai_disciple_idle_02"
ENT.NoTargetIdle = "nz_ai_disciple_idle_03"

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ai_disciple_fly_walk",
			},
			TurnedMovementSequence = {
				"nz_ai_disciple_fly_sprint",
			},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ai_disciple_fly_run",
				"nz_ai_disciple_fly_sprint",
			},
			TurnedMovementSequence = {
				"nz_ai_disciple_fly_sprint",
			},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_ai_disciple_fly_supersprint",
			},
			TurnedMovementSequence = {
				"nz_ai_disciple_fly_sprint",
			},
			AttackSequences = {AttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

ENT.CustomMantleOver48 = {
	"nz_ai_disciple_mantle_48",
}
ENT.CustomMantleOver72 = {
	"nz_ai_disciple_mantle_72",
}
ENT.CustomMantleOver96 = {
	"nz_ai_disciple_mantle_96",
}
ENT.CustomMantleOver128 = {
	"nz_ai_disciple_mantle_128",
}

ENT.BustSWTSounds = {
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_00.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_01.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_02.mp3"),
}

ENT.BuffVoxSounds = {
	Sound("nz_moo/zombies/vox/_sonoforda/buff/buff_vox_00.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/buff/buff_vox_01.mp3"),
}

ENT.BuffWispSounds = {
	Sound("nz_moo/zombies/vox/_sonoforda/buff/buff_wisp_00.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/buff/buff_wisp_01.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/buff/buff_wisp_02.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/buff/buff_wisp_03.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_sonoforda/evt/death.mp3"),
}

ENT.DashSounds = {
	Sound("nz_moo/zombies/vox/_sonoforda/dash/dash_00.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/dash/dash_01.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/dash/dash_02.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/dash/dash_03.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/dash/dash_04.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/dash/dash_05.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_sonoforda/expose/expose_vox_00.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/expose/expose_vox_01.mp3"),
	Sound("nz_moo/zombies/vox/_sonoforda/expose/expose_vox_02.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/mute_00.wav"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(2250)
			self:SetMaxHealth(2250)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 500 + (250 * count), 2250, 60000 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 500 + (150 * count), 2250, 60000 * count))
			else
				self:SetHealth(2250)
				self:SetMaxHealth(2250)	
			end
		end

		self:SetRunSpeed( 71 )
		self:SetBodygroup(0,0)

		self.Revealed = false
		self.MaskHP = self:Health() * 0.65

		self:SetUsingLifeDrain(false)
		self.InLifeDrain = false
		self.LifeDrainCooldown = CurTime() + 3
		self.LifeDrainDmgTick = CurTime() + 0.75

		self.BuffZombies = false
		self.BuffedZombies = false
		self.BuffZombiesCooldown = CurTime() + 5
		self.BuffZombiesTick = CurTime() + 1
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	self:SetSurroundingBounds(Vector(-45, -45, 0), Vector(45, 45, 80))
	
	local effectData = EffectData()
	effectData:SetOrigin( self:GetPos() + Vector(0, 0, 50)  )
	effectData:SetMagnitude( 1 )
	effectData:SetEntity(nil)
	util.Effect("panzer_spawn_tp", effectData)

	self.Trail = util.SpriteTrail(self, 9, Color(95, 0, 255), true, 70, 45, 0.35, 1 / 40 * 0.3, "materials/trails/plasma")

	self:EmitSound("nz_moo/zombies/vox/_sonoforda/evt/spawn.mp3", 100, math.random(95, 105))

	if animation then
		self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
		self:SetSpecialAnimation(true)
		self:SetIsBusy(true)
		
		self:PlaySequenceAndMove(animation, {gravity = grav})

		self:SetSpecialAnimation(false)
		self:SetIsBusy(false)
		self:CollideWhenPossible()
	end
end

function ENT:FinishLifeDrain()
	self:DoSpecialAnimation("nz_ai_disciple_lifedrain_finish", true)
	self.LifeDrainCooldown = CurTime() + 5
	self.InLifeDrain = false
end

function ENT:AI()
	local target = self:GetTarget()

	-- Buff Zombies
	if CurTime() > self.BuffZombiesCooldown and (!self.BuffZombies and !self.IsTurned and !self.IsNZAlly) then
		for k,v in nzLevel.GetZombieArray() do
			if IsValid(v) and v:IsValidZombie() and v.IsMooZombie and !v.HasDiscipleBuff and self:GetRangeTo( v:GetPos() ) < 800 and !self:IsAttackEntBlocked(v) then
				if v.IsMooSpecial or v.IsMooBossZombie or v.NZBossType or v.IsCatalyst or v:WaterBuff() then continue end -- will ignore itself and Bosses
				self.BuffZombies = true
				self:Retarget()

				self:EmitSound(self.DashSounds[math.random(#self.DashSounds)], 80, math.random(95,105))
				self:SetRunSpeed(155)
				self:SpeedChanged()
			end
		end
	end
	if self.BuffZombies then
		for k,v in nzLevel.GetZombieArray() do
			if k < 1 then
				self.BuffZombies = false
				self:SetRunSpeed(36)
				self:SpeedChanged()
			end
		end
	end

	-- Life Drain
	if CurTime() > self.LifeDrainCooldown and !self:IsAttackBlocked() and !self.BuffZombies then

		self:TryDash()

		if !IsValid(target) then return end
		if (target:IsPlayer() and !self.IsTurned or self.IsTurned or self.IsNZAlly) and self:TargetInRange(self.DamageRange) and !self.InLifeDrain then
			self.InLifeDrain = true
			self:DoSpecialAnimation("nz_ai_disciple_lifedrain_start", true)
			self:EmitSound("nz_moo/zombies/vox/_sonoforda/lifedrain/lifedrain_start.mp3", 90, math.random(95,105))
			self:EmitSound("nz_moo/zombies/vox/_sonoforda/lifedrain/lifedrain_start_sting.mp3", 90, math.random(95,105))
			self:EmitSound("nz_moo/zombies/vox/_sonoforda/lifedrain/lifedrain_zap_0"..math.random(0,1)..".mp3", 90, math.random(95,105))

			self:FaceTowards(target:GetPos())
			self:SetStop(true)
			self:SetUsingLifeDrain(true)
			self:SetCurrentTarget(target)

			self:SetRunSpeed(36)
			self:SpeedChanged()
		end
	end
end


function ENT:TryDash()
	local target = self:GetTarget()
	if !IsValid(target) then return end
	if target:IsPlayer() and !self:TargetInRange(500) and math.random(100) < 25 and !self.InLifeDrain and !self:IsAttackBlocked() then
		self:EmitSound(self.DashSounds[math.random(#self.DashSounds)], 80, math.random(95,105))
		self:SetRunSpeed(155)
		self:SpeedChanged()
	end
end


function ENT:BuffZombiesInSphere()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 125)) do    
		if v.IsMooZombie and !v.IsMooSpecial then
			if v.IsMooSpecial or v.IsMooBossZombie or v.NZBossType or v.IsCatalyst or v:WaterBuff() then continue end -- will ignore itself and Bosses
			if !v.HasDiscipleBuff then
				self.BuffedZombies = true
				v.HasDiscipleBuff = true
				v:SetRunSpeed(250)
				v.loco:SetDesiredSpeed( v:GetRunSpeed() )
				v:SetHealth( nzRound:GetZombieHealth() * 5 )
				v:SpeedChanged()
				v:SetBomberBuff(true)
				v:SetWaterBuff(true)

				if !v:GetSpecialAnimation() then
					if v.SparkyAnim then
						v:DoSpecialAnimation(v.SparkyAnim, true, true)
			            if v.ElecSounds then	
							v:PlaySound(v.ElecSounds[math.random(#v.ElecSounds)], 90, math.random(85, 105), 1, 2)
						end
					end
				end
			end
		end
	end
end

function ENT:DebuffZombies()
	for k,v in nzLevel.GetZombieArray() do
		if IsValid(v) and v.HasDiscipleBuff then
			v.HasDiscipleBuff = false
			v:SetRunSpeed(71)
			v.loco:SetDesiredSpeed( v:GetRunSpeed() )
			v:SetHealth( nzRound:GetZombieHealth() * 0.5 )
			v:SpeedChanged()
			v:SetBomberBuff(false)
			v:SetWaterBuff(false)

			if !v:GetSpecialAnimation() then
				if v.SparkyAnim then
					v:DoSpecialAnimation(v.SparkyAnim, true, true)
			        if v.ElecSounds then	
						v:PlaySound(v.ElecSounds[math.random(#v.ElecSounds)], 90, math.random(85, 105), 1, 2)
					end
				end
			end
		end
	end
end

function ENT:OnThink()
	if CurTime() > self.LifeDrainDmgTick and self.InLifeDrain then
		local target = self:GetTarget()
		if self:IsAttackBlocked() or !self:TargetInRange(575) or (target:IsPlayer() and !target:GetNotDowned()) or !target:Alive() then
			self.InLifeDrain = false
			self:DoSpecialAnimation("nz_ai_disciple_lifedrain_finish", true)
			self:EmitSound("nz_moo/zombies/vox/_sonoforda/lifedrain/lifedrain_bust.mp3", 90, math.random(95,105))

			self:SetSpecialAnimation(false)
			self:SetStop(false)
			self:SetUsingLifeDrain(false)
			self:SetCurrentTarget(nil)
		end

		if IsValid(target) then
			target:TakeDamage(self.AttackDamage, self, self)
			self:SetHealth(self:Health() + (self.AttackDamage * 2))
		end

		--print(self:Health())

		self.LifeDrainDmgTick = CurTime() + 0.5
	end

	if CurTime() > self.BuffZombiesTick and self.BuffZombies then
		self.BuffZombiesTick = CurTime() + 1
		self:BuffZombiesInSphere()
	end

	if self.BuffedZombies then
		self:DoSpecialAnimation("nz_ai_disciple_zombie_buff_start", true)
		self.BuffedZombies = false

		self.BuffZombies = false
		self.BuffZombiesCooldown = CurTime() + math.Rand(3.5, 7.77)
		self:Retarget()

		self:EmitSound("nz_moo/zombies/vox/_sonoforda/buff/buff_sting.mp3", 95, math.random(95,105))
		self:EmitSound(self.BuffVoxSounds[math.random(#self.BuffVoxSounds)], 95, math.random(95,105))
		self:EmitSound(self.BuffWispSounds[math.random(#self.BuffWispSounds)], 95, math.random(95,105))

		self:SetRunSpeed(36)
		self:SpeedChanged()
	end
end

function ENT:PerformDeath(dmginfo)
		
	self.Dying = true

	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)

	self:DebuffZombies()

	self:DissolveEffect()

    self:EmitSound("nz_moo/zombies/vox/_sonoforda/evt/expose.mp3", 511, math.random(95,105))

	if self.DeathSounds then
		self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 511, math.random(85, 105), 1, 2)
	end

	if damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo) -- Only Thundergun and Wavegun Ragdolls constantly.
	end
	if damagetype == DMG_REMOVENORAGDOLL then
		self:Remove(dmginfo)
	end

	self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
end

function ENT:PerformIdle()
	if self:GetSpecialAnimation() and !self.IsTornado and !self.IsXbowSpinning then return end
	if self.InLifeDrain then
		self:ResetSequence("nz_ai_disciple_lifedrain_loop")
		self:SetSpecialAnimation(true)
	elseif self:GetJumping() then
		if !self:GetCrawler() then
			self:GetSequenceActivity(ACT_JUMP)
		else
			self:GetSequenceActivity(ACT_HOP)
		end
	elseif self.BO4IsTornado and self:BO4IsTornado() and self.IsTornado and (self.IsMooSpecial and self.MooSpecialZombie or !self.IsMooSpecial) then
		self:ResetSequence(self.TornadoSequence)
	elseif self.BO4IsSpinning and self:BO4IsSpinning() and self.IsXbowSpinning and (self.IsMooSpecial and self.MooSpecialZombie or !self.IsMooSpecial) then
		self:ResetSequence(self.XbowWWSequence)
	elseif self:LookupSequence(self.NoTargetIdle) > 0 and !self:HasTarget() and !nzRound:InState( ROUND_GO ) then
		self:ResetSequence(self.NoTargetIdle)
		if !self.IsIdle and !IsValid(self:GetTarget()) then
			self.IsIdle = true
		end
	elseif self.ArmsUporDown == 1 and !self:GetCrawler() and !self.IsMooSpecial then
		self:ResetSequence(self.IdleSequenceAU)
		if !self.IsIdle and !IsValid(self:GetTarget()) then
			self.IsIdle = true
		end
	else
		self:ResetSequence(self.IdleSequence)
		if !self.IsIdle and !IsValid(self:GetTarget()) then
			self.IsIdle = true
		end
	end
end

if SERVER then
	function ENT:IsValidTarget( ent )
		if not ent then return false end

		-- Turned Zombie Targetting
		if self.IsTurned or self.IsNZAlly then
			return IsValid(ent) and ent:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooBossZombie and !ent.IsNZAlly and ent:IsAlive() 
		end
		
		-- Zombie Targetting
		if self.BuffZombies then
			return IsValid(ent) and ent:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooBossZombie and !ent.IsMooSpecial and !ent.HasDiscipleBuff and !ent.IsNZAlly and !ent:IsPlayer() and ent:IsAlive() 
		end

		return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY -- This is really funny.
	end
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	local inflictor = dmginfo:GetInflictor()

	local hitpos = dmginfo:GetDamagePosition()
	local hitgroup = util.QuickTrace(hitpos, hitpos).HitGroup
	local hitforce = dmginfo:GetDamageForce()

	local damage = dmginfo:GetDamage()

	local headpos = self:GetBonePosition(self:LookupBone("j_head"))
	local armpos = self:GetBonePosition(self:LookupBone("j_wrist_ri"))

	if (hitpos:DistToSqr(headpos) < 20^2) then
		if !self.Revealed and self.MaskHP > 0 then
			self.MaskHP = self.MaskHP - damage
			dmginfo:ScaleDamage(0.15)
		elseif !self.Revealed and self.MaskHP <= 0 then
			self.Revealed = true
			self:SetBodygroup(0,1)

			self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(95,105))
        	self:EmitSound("nz_moo/zombies/vox/_sonoforda/evt/expose.mp3", 511, math.random(95,105))

			ParticleEffect("zmb_disciple_blast",self:GetPos()+Vector(0,0,50),self:GetAngles(),self)

			self:DoSpecialAnimation("nz_ai_disciple_expose_1")


			if self.InLifeDrain then
				self.InLifeDrain = false
				self:SetStop(false)

				self.LifeDrainCooldown = CurTime() + 3

				self:SetSpecialAnimation(false)
				self:SetStop(false)
				self:SetUsingLifeDrain(false)
				self:SetCurrentTarget(nil)
			end
		else
			dmginfo:ScaleDamage(0.75)
		end
	else
		dmginfo:ScaleDamage(0.1)
	end

	if (hitpos:DistToSqr(armpos) < 20^2) then
		if self.InLifeDrain then
			self.InLifeDrain = false
			self:SetStop(false)

			ParticleEffectAttach("zmb_disciple_hand_blast", PATTACH_POINT_FOLLOW, self, 11)

			self:EmitSound(self.PainSounds[math.random(#self.PainSounds)], 100, math.random(95,105))
        	self:EmitSound(self.BustSWTSounds[math.random(#self.BustSWTSounds)],511)
			self:DoSpecialAnimation("nz_ai_disciple_lifedrain_bust")
			self.LifeDrainCooldown = CurTime() + 3

			self:SetSpecialAnimation(false)
			self:SetStop(false)
			self:SetUsingLifeDrain(false)
			self:SetCurrentTarget(nil)
		end
	end

	self:TryDash()
end


function ENT:OnRemove()
	self:DebuffZombies()
	self:StopSound("nz_moo/zombies/vox/_sonoforda/xsound_2668586603af8b4.wav")
end