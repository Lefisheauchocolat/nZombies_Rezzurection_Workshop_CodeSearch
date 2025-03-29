AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Morgan"
ENT.PrintName = "Tesla Zombie"
ENT.Category = "Brainz"
ENT.Author = "Wavy"

function ENT:Draw() //Runs every frame
		self:DrawModel()

		local elight = DynamicLight( self:EntIndex(), true )
		if ( elight ) then
			local bone = self:LookupBone("j_spineupper")
			local pos = self:GetBonePosition(bone)
			pos = pos 
			elight.pos = pos
			elight.r = 0
			elight.g = 25
			elight.b = 255
			elight.brightness = 9
			elight.Decay = 1000
			elight.Size = 50
			elight.DieTime = CurTime() + 1
			elight.style = 0
			elight.noworld = true
		end

	if GetConVar( "nz_zombie_debug" ):GetBool() then
		render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
	end
end

if CLIENT then 
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end

	function ENT:EffectsAndSounds()
		if self:IsAlive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if !self.Draw_FX or !IsValid(self.Draw_FX) then
				self.Draw_FX = "ambient/energy/electric_loop.wav"

				self:EmitSound(self.Draw_FX, 75, math.random(95, 105), 1, 3)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.MooSpecialZombie = true -- They're a Special Zombie, but is still close enough to a normal zombie to be able to do normal zombie things.
ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true
ENT.IsMiniBoss = true

ENT.Models = {
	{Model = "models/wavy_rigs/lethal_necrotics/wavy_zombie_hev_new.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy_rigs/lethal_necrotics/wavy_zombie_hev_new.mdl", Skin = 1, Bodygroups = {0,0}},
}

ENT.DeathSequences = {
	"nz_death_elec_1",
	"nz_death_elec_2",
	"nz_death_elec_3",
	"nz_death_elec_4",
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
}

local spawnsuperfast = {"nz_spawn_ground_jumpout"}

local SprintJumpSequences = {
	{seq = "nz_barricade_sprint_1"},
	{seq = "nz_barricade_sprint_2"},
}

local SlowClimbUp36 = {
	"nz_traverse_climbup36"
}
local SlowClimbUp48 = {
	"nz_traverse_climbup48"
}
local SlowClimbUp72 = {
	"nz_traverse_climbup72"
}
local SlowClimbUp96 = {
	"nz_traverse_climbup96"
}
local SlowClimbUp128 = {
	"nz_traverse_climbup128"
}
local SlowClimbUp160 = {
	"nz_traverse_climbup160"
}
local FastClimbUp36 = {
	"nz_traverse_fast_climbup36"
}
local FastClimbUp48 = {
	"nz_traverse_fast_climbup48"
}
local FastClimbUp72 = {
	"nz_traverse_fast_climbup72"
}
local FastClimbUp96 = {
	"nz_traverse_fast_climbup96"
}
local ClimbUp200 = {
	"nz_traverse_climbup200"
}

local AttackSequences = {
	{seq = "nz_iw7_cp_zom_stand_attack_l_01"},
	{seq = "nz_iw7_cp_zom_stand_attack_l_02"},
	{seq = "nz_iw7_cp_zom_stand_attack_r_01"},
	{seq = "nz_iw7_cp_zom_stand_attack_r_02"},
	{seq = "nz_zom_core_stand_attack_2h_01"},
	{seq = "nz_zom_core_stand_attack_2h_02"},
}

local SprintAttackSequences = {
	{seq = "nz_t8_attack_sprint_larm_1"},
	{seq = "nz_t8_attack_sprint_larm_2"},
	{seq = "nz_t8_attack_sprint_larm_3"},
	{seq = "nz_t8_attack_sprint_larm_4"},
	{seq = "nz_t8_attack_sprint_rarm_1"},
	{seq = "nz_t8_attack_sprint_rarm_2"},
	{seq = "nz_t8_attack_sprint_rarm_3"},
	{seq = "nz_t8_attack_sprint_rarm_4"},
}

local walksounds = {
	Sound("wavy_zombie/hev/crimhead_attack1.wav"),
	Sound("wavy_zombie/hev/crimhead_attack2.wav"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			MovementSequence = {
				"nz_t9_base_player_sprint_v01",
				"nz_t9_base_player_sprint_v02",
				"nz_t9_base_player_sprint_v03",
				"nz_t9_base_player_sprint_v04",
				"nz_t9_base_player_sprint_v05",
				"nz_t9_base_player_sprint_v06",
				"nz_t9_base_player_sprint_v07",
				"nz_t9_base_player_sprint_v08",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			LowgMovementSequence = {
				"nz_run_lowg_v1",
				"nz_run_lowg_v2",
				"nz_run_lowg_v3",
				"nz_run_lowg_v4",
			},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {SprintAttackSequences},
			JumpSequences = {SprintJumpSequences},

			Climb36 = {FastClimbUp36},
			Climb48 = {FastClimbUp48},
			Climb72 = {FastClimbUp72},
			Climb96 = {FastClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {walksounds},
		},
	}}
}

ENT.ElecScreamSequences = {
	"nz_sonic_attack_01",
	"nz_sonic_attack_02",
	"nz_sonic_attack_03",
}

ENT.DeathSounds = {
	"wavy_zombie/hev/crimhead_die.wav",
	"wavy_zombie/hev/crimhead_pain.wav",
}
ENT.AttackSounds = {
	"wavy_zombie/hev/crimhead_attack1.wav",
	"wavy_zombie/hev/crimhead_attack2.wav",
}
ENT.SpawnSounds = {
	"wavy_zombie/hev/crimhead_alert.wav",
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(500)
			self:SetMaxHealth(500)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 600 + (1000 * count), 3300, 18900 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 600 + (1000 * count), 3300, 18900 * count))
			else
				self:SetHealth(3300)
				self:SetMaxHealth(3300)	
			end
		end
		self:SetRunSpeed(71)

		self.Cooldown = CurTime() + 3 -- Won't be allowed to explode right after spawning, so they'll attack normally until then.
		self.Screaming = false
		self.CanScream = false
	end
end

function ENT:SpecialInit()
	if CLIENT then
	end
end

function ENT:OnSpawn()
	ParticleEffect( "driese_tp_arrival_phase2", self:GetPos(), angle_zero )
	self:EmitSound("TFA_BO3_WAFFE.Impact")
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Close")
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Flash")
	self:EmitSound("TFA_BO3_GENERIC.Lightning.Snap")
	self:EmitSound("wavy_zombie/hev/crimhead_alert.wav", 100, math.random(85, 105))

	local seq = self:SelectSpawnSequence()
	local _, dur = self:LookupSequence(seq)

	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)
	self:SetSpecialAnimation(true)
	
	if seq then
		self:PlaySequenceAndWait(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)	
	self.Dying = true

	self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
	self:EmitSound("wavy_zombie/hev/flatline.wav")
	self:EmitSound("wavy_zombie/hev/hev_dead_shutdown01.wav")
	self:StopSound("ambient/energy/electric_loop.wav")
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() or damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo)
	else
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:OnRemove()
	self:StopSound("ambient/energy/electric_loop.wav")
end

function ENT:IsValidTarget( ent )
	if not ent then return false end
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end

function ENT:PostAdditionalZombieStuff()
	if self:GetSpecialAnimation() then return end
	if CurTime() > self.Cooldown and !self.CanScream then
		self.CanScream = true
	end
	if self:TargetInRange(325) and !self:IsAttackBlocked() and self.CanScream and math.random(2) == 1 then
		if !self:GetTarget():IsPlayer() then return end
		self:SonicAttack()
	end
end

function ENT:SonicAttack()
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)
		self.Screaming = true
		self:PlaySequenceAndMove(self.ElecScreamSequences[math.random(#self.ElecScreamSequences)], 1, self.FaceEnemy)
		self.Screaming = false
		self.CanScream = false
		self:SetSpecialAnimation(false)
		self.Cooldown = CurTime() + 9
	end)
end

function ENT:HandleAnimEvent(a,b,c,d,e)
	if e == "step_right_small" or e == "step_left_small" then
		if self.CustomWalkFootstepsSounds then
			self:EmitSound(self.CustomWalkFootstepsSounds[math.random(#self.CustomWalkFootstepsSounds)], 60)
		else
			self:EmitSound("CoDZ_Zombie.StepWalk")
		end
	end
	if e == "step_right_large" or e == "step_left_large" then
		if self.CustomRunFootstepsSounds then
			self:EmitSound(self.CustomRunFootstepsSounds[math.random(#self.CustomRunFootstepsSounds)], 60)
		else
			self:EmitSound("CoDZ_Zombie.StepRun")
		end
	end
	if e == "crawl_hand" then
		if self.CustomCrawlImpactSounds then
			self:EmitSound(self.CrawlImpactSounds[math.random(#self.CrawlImpactSounds)], 60)
		else
			self:EmitSound("CoDZ_Zombie.StepCrawl")
		end
	end
	if e == "melee" then
		self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
		self:DoAttackDamage()
	end
	if e == "pull_plank" then
		if IsValid(self) and self:IsAlive() then
			if IsValid(self.BarricadePlankPull) and IsValid(self.Barricade) then
				self.Barricade:RemovePlank(self.BarricadePlankPull)
			end
		end
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
	if e == "sonic_scream" then
		self:EmitSound("wavy_zombie/hev/crimhead_alert.wav", 100, math.random(85, 105))
		self:EmitSound("wavy_zombie/hev/hzv"..math.random(1,14)..".wav", 100, math.random(85, 105))
		self:EmitSound("ambient/energy/zap"..math.random(1,3)..".wav")
		ParticleEffectAttach("driese_tp_arrival_phase1", 4, self, 10)
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 175)) do
			if IsValid(v) and v:IsPlayer() and !self:IsAttackEntBlocked(v) then
				v:NZSonicBlind(2)	
			end
			if IsValid(v) and v:IsValidZombie() and v.IsMooZombie and !v.IsMooSpecial and v:Health() > 0 then
				v:SetRunSpeed(250)
				v.loco:SetDesiredSpeed( v:GetRunSpeed() )
				v:SpeedChanged()
			end
			if v:IsValidZombie() and !v:GetSpecialAnimation() and !v.IsMooSpecial and v ~= self then
				v:PerformStun( math.Rand(1,2) )
			end
		end
	end
end

--[[function ENT:Explode()
	for k,v in pairs(ents.FindInSphere(self:GetPos(), 175)) do
		if IsValid(v) and v:IsPlayer() and !self:IsAttackEntBlocked(v) then
			v:NZSonicBlind(2)	
		end
		if IsValid(v) and v:IsValidZombie() and v.IsMooZombie and !v.IsMooSpecial and v:Health() > 0 then
			v:SetRunSpeed(250)
			v.loco:SetDesiredSpeed( v:GetRunSpeed() )
			v:SpeedChanged()
		end
	end
	ParticleEffectAttach("driese_tp_arrival_phase1", 4, self, 10)
	self:EmitSound("ambient/energy/zap"..math.random(1,3)..".wav")
end]]