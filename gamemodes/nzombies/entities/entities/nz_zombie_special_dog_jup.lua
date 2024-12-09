AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.PrintName = "Hellhound"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

if CLIENT then 
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")

	function ENT:DrawEyeGlow()
		local eyeColor = Color(255,50,0)
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

	function ENT:PostDraw()
		if self:Alive() then
			if (!self.Draw_FX or !IsValid(self.Draw_FX)) then
				self.Draw_FX = CreateParticleSystem(self, "doom_hellunit_aura", PATTACH_POINT_FOLLOW, 1)
			end
			if (!self.Draw_SFX or !IsValid(self.Draw_SFX)) then
				self.Draw_SFX = "nz_moo/zombies/vox/_devildog/_t10/xsound_1b53c53a4a04f38.wav"

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
ENT.AttackRange = 90
ENT.DamageRange = 90
ENT.AttackDamage = 25

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_dog.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawnslow = {"nz_ai_dog_spawn_ground_slow_01", "nz_ai_dog_spawn_ground_slow_02"}
local spawnfast = {"nz_ai_dog_spawn_ground_fast_01", "nz_ai_dog_spawn_ground_fast_02"}

local AttackSequences = {
	{seq = "nz_ai_dog_attack_low_01"},
	{seq = "nz_ai_dog_attack_high_01"},
}

local RunAttackSequences = {
	{seq = "nz_ai_dog_leap_attack_01"},
	{seq = "nz_ai_dog_leap_attack_02"},
}

local SprintAttackSequences = {
	{seq = "nz_ai_dog_leap_attack_03"},
	{seq = "nz_ai_dog_leap_attack_04"},
}

local JumpSequences = {
	{seq = "nz_ai_dog_run_mantle_36"},
}

ENT.DeathSequences = {
	"nz_ai_dog_death_f_01",
	"nz_ai_dog_death_f_02",
	"nz_ai_dog_death_b_01",
	"nz_ai_dog_death_b_02",
	"nz_ai_dog_death_b_03",
	"nz_ai_dog_death_l_01",
	"nz_ai_dog_death_l_02",
	"nz_ai_dog_death_r_01",
	"nz_ai_dog_death_r_02",
	"nz_ai_dog_death_nomove_01",
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

ENT.IdleSequence = "nz_ai_dog_idle_01"

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_devildog/_t10/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/attack/attack_03.mp3"),
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_13.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_14.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_15.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_16.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_17.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_18.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_19.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_20.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_21.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_22.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_23.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_24.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_25.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_26.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_27.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_28.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_29.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_30.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_31.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_32.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/amb/amb_33.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_devildog/_t10/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/death/death_04.mp3"),
}

ENT.DeathSoulSounds = {
	Sound("nz_moo/zombies/vox/_devildog/_t10/death_soul/death_soul_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/death_soul/death_soul_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/death_soul/death_soul_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/death_soul/death_soul_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/death_soul/death_soul_04.mp3"),
}

ENT.AppearSounds = {
	Sound("nz_moo/zombies/vox/_devildog/_zhd/spawn/zmb_hellhound_spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_zhd/spawn/zmb_hellhound_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_zhd/spawn/zmb_hellhound_spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_zhd/spawn/zmb_hellhound_spawn_03.mp3"),
}

ENT.SpawnExploSounds = {
	Sound("nz_moo/zombies/vox/_devildog/_t10/spawn/spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/spawn/spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/spawn/spawn_02.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			MovementSequence = {
				"nz_ai_dog_run_01",
				"nz_ai_dog_run_02",
			},
			PatrolMovementSequence = {
				"nz_ai_dog_walk_01",
				"nz_ai_dog_patrol_01",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_ai_dog_sprint_01",
				"nz_ai_dog_sprint_02",
			},
			PatrolMovementSequence = {
				"nz_ai_dog_walk_01",
				"nz_ai_dog_patrol_01",
			},
			AttackSequences = {SprintAttackSequences},
			StandAttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.ZombieLandSequences = {
	"nz_ai_dog_land",
}

ENT.CustomMantleOver48 = {
	"nz_ai_dog_run_mantle_48",
}

ENT.CustomMantleOver72 = {
	"nz_ai_dog_run_mantle_72",
}

ENT.CustomMantleOver96 = {
	"nz_ai_dog_run_mantle_96",
}

ENT.CustomMantleOver128 = {
	"nz_ai_dog_run_mantle_128",
}

ENT.DogFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_04.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_05.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_06.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_07.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_08.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_09.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_10.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_11.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_12.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_13.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_14.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_15.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_16.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_17.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_18.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/steps/step_19.mp3"),
}

ENT.BehindSoundDistance = 750
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_devildog/_t10/behind/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/behind/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/behind/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/behind/behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/behind/behind_04.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/behind/behind_05.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/behind/behind_06.mp3"),
	Sound("nz_moo/zombies/vox/_devildog/_t10/behind/behind_07.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local speeds = nzRound:GetZombieCoDSpeeds()
		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 100 )
		end
		self:SetHealth( nzRound:GetZombieHealth() * 0.25 or 75 )
		self:SetMaxHealth( self:Health() )

		self.Exploded = false
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = animation or self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	local stype

	if IsValid(self.SpawnIndex) then
		stype = self.SpawnIndex:GetSpawnType()
	end

	if dirt then
		local SpawnMatSound = {
			[MAT_DIRT] = "nz_moo/zombies/spawn/dirt/pfx_zm_spawn_dirt_0"..math.random(0,1)..".mp3",
			[MAT_SNOW] = "nz_moo/zombies/spawn/snow/pfx_zm_spawn_snow_0"..math.random(0,1)..".mp3",
			[MAT_SLOSH] = "nz_moo/zombies/spawn/mud/pfx_zm_spawn_mud_00.mp3",
			[0] = "nz_moo/zombies/spawn/default/pfx_zm_spawn_default_00.mp3",
		}
		SpawnMatSound[MAT_GRASS] = SpawnMatSound[MAT_DIRT]
		SpawnMatSound[MAT_SAND] = SpawnMatSound[MAT_DIRT]

		local norm = (self:GetPos()):GetNormalized()
		local tr = util.QuickTrace(self:GetPos(), norm*10, self)

		if tr.Hit then
			local finalsound = SpawnMatSound[tr.MatType] or SpawnMatSound[0]
			self:EmitSound(finalsound)
		end

		ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
	end

	if IsValid(self.SpawnIndex) then
		if stype == 11 or stype == 1 then
			animation = "nz_ai_dog_spawn_air_01"

			self:SetNoDraw(true)
			self:SetInvulnerable(true)
			self:SetBlockAttack(true)
			self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
			self:EmitSound("nz_moo/zombies/vox/_devildog/_t10/spawn/molotov_prespawn_00.mp3",511,100)
			ParticleEffect("doom_wraith_teleport",self:GetPos(),self:GetAngles(),nil)
			ParticleEffect("zmb_dog_spawn_fireball",self:GetPos() + Vector(0,0,50),self:GetAngles(),nil)

		end
	end

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

function ENT:DogExplode()
	if self.Exploded then self:Remove() return end

	self.Exploded = true -- Prevent a possible infinite loop that causes crashes.

	local firepit = ents.Create("hellhound_firepit")
    firepit:SetPos(self:GetPos() + Vector(0,0,5))
	firepit:SetAngles(Angle(0,0,0))
    firepit:Spawn()

    self:Explode( math.random( 25, 50 ))

	if IsValid(self) then
		self:Remove()
	end
end

function ENT:PerformDeath(dmginfo)
	self.Dying = true

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:PlaySound(self.DeathSoulSounds[math.random(#self.DeathSoulSounds)], 100, math.random(85, 105))

	if !self:GetSpecialAnimation() then
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)], true)
	else
		self:DogExplode()
	end
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:CustomAnimEvent(a,b,c,d,e)

	self.OverrideLsmall = true
	self.OverrideLLarge = true
	self.OverrideRsmall = true
	self.OverrideRLarge = true

	if e == "step_left_small" then
		if self.DogFootstepsSounds then
			self:EmitSound(self.DogFootstepsSounds[math.random(#self.DogFootstepsSounds)], 70)
		end
	end
	if e == "step_right_small" then
		if self.DogFootstepsSounds then
			self:EmitSound(self.DogFootstepsSounds[math.random(#self.DogFootstepsSounds)], 70)
		end
	end
	if e == "step_left_large" then
		if self.DogFootstepsSounds then
			self:EmitSound(self.DogFootstepsSounds[math.random(#self.DogFootstepsSounds)], 70)
		end
	end
	if e == "step_right_large" then
		if self.DogFootstepsSounds then
			self:EmitSound(self.DogFootstepsSounds[math.random(#self.DogFootstepsSounds)], 70)
		end
	end

	if e == "dog_lightning_spawn_show" then

		ParticleEffect("doom_caco_blast",self:GetPos() + Vector(0,0,50),self:GetAngles(),nil)

		self:SetNoDraw(false)
		self:SetInvulnerable(nil)
		self:SetBlockAttack(false)
		self:CollideWhenPossible()
		self:EmitSound(self.AppearSounds[math.random(#self.AppearSounds)], 511, math.random(85, 105), 1, 2)
		self:EmitSound(self.SpawnExploSounds[math.random(#self.SpawnExploSounds)], 511, math.random(85, 105))
	end
	if e == "dog_explode" then
		self:DogExplode()
	end
end

function ENT:OnRemove()
	if self.NoRagdoll and !self.Exploded then
		self:DogExplode()
	end
	self:StopSound("nz_moo/zombies/vox/_devildog/_t10/xsound_1b53c53a4a04f38.wav")
end