AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
--ENT.PrintName = "Fuel Junkie(NEW!!!)"
ENT.PrintName = "Fuel Junkie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"

AccessorFunc( ENT, "fLastToast", "LastToast", FORCE_NUMBER)

function ENT:Draw() //Runs every frame
		self:DrawModel()
		if self.RedEyes and self:Alive() and !self:GetDecapitated() and !self:GetMooSpecial() and !self.IsMooSpecial then
			self:DrawEyeGlow() 
		end

		local elight = DynamicLight( self:EntIndex(), true )
		if ( elight ) then
			local bone = self:LookupBone("j_spineupper")
			local pos = self:GetBonePosition(bone)
			pos = pos 
			elight.pos = pos
			elight.r = 100
			elight.g = 25
			elight.b = 0
			elight.brightness = 8
			elight.Decay = 1000
			elight.Size = 40
			elight.DieTime = CurTime() + 1
			elight.style = 0
			elight.noworld = true
		end

	if GetConVar( "nz_zombie_debug" ):GetBool() then
		render.DrawWireframeBox(self:GetPos(), Angle(0,0,0), self:OBBMins(), self:OBBMaxs(), Color(255,0,0), true)
	end
end

function ENT:DrawEyeGlow()
	local eyeglow =  Material("nz_moo/sprites/moo_glow1")
	local eyeColor = Color(255,50,0)
	local latt = self:LookupAttachment("lefteye")
	local ratt = self:LookupAttachment("righteye")

	if latt == nil then return end
	if ratt == nil then return end

	local leye = self:GetAttachment(latt)
	local reye = self:GetAttachment(ratt)

	local righteyepos = leye.Pos + leye.Ang:Forward()*0.5
	local lefteyepos = reye.Pos + reye.Ang:Forward()*0.5

	if lefteyepos and righteyepos then
		render.SetMaterial(eyeglow)
		render.DrawSprite(lefteyepos, 5, 5, eyeColor)
		render.DrawSprite(righteyepos, 5, 5, eyeColor)
	end
end

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true
ENT.IsMooBossZombie = true
ENT.IsMiniBoss = true

ENT.AttackRange = 72

ENT.TraversalCheckRange = 40

ENT.Models = {
	{Model = "models/moo/_codz_ports/t5/temple/moo_codz_t5_viet_special_zombie.mdl", Skin = 2, Bodygroups = {0,0}},
}

ENT.DeathSequences = {
	"nz_napalm_death_01",
	"nz_napalm_death_02",
	"nz_napalm_death_03",
}

ENT.BarricadeTearSequences = {
	"nz_legacy_door_tear_high",
	"nz_legacy_door_tear_low",
	"nz_legacy_door_tear_left",
	"nz_legacy_door_tear_right",
}

local spawnfast = {"nz_ent_ground_01", "nz_ent_ground_02"}

local JumpSequences = {
	{seq = "nz_barricade_trav_walk_1"},
	{seq = "nz_barricade_trav_walk_2"},
	{seq = "nz_barricade_trav_walk_3"},
}

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
	{seq = "nz_attack_stand_ad_1"},
	{seq = "nz_attack_stand_au_1"},
	{seq = "nz_legacy_attack_v3"},
	{seq = "nz_legacy_attack_v4"},
	{seq = "nz_legacy_attack_v11"},
	{seq = "nz_fwd_ad_attack_v1"},
	{seq = "nz_fwd_ad_attack_v2"},
	{seq = "nz_legacy_attack_superwindmill"},
	{seq = "nz_t8_attack_stand_larm_1"},
	{seq = "nz_t8_attack_stand_larm_2"},
	{seq = "nz_t8_attack_stand_larm_3"},
	{seq = "nz_t8_attack_stand_rarm_1"},
	{seq = "nz_t8_attack_stand_rarm_2"},
	{seq = "nz_t8_attack_stand_rarm_3"},
}

local WalkAttackSequences = {
	{seq = "nz_walk_ad_attack_v1"}, -- Quick single swipe
	{seq = "nz_walk_ad_attack_v2"}, -- Slowish double swipe
	{seq = "nz_walk_ad_attack_v3"}, -- Slowish single swipe
	{seq = "nz_walk_ad_attack_v4"}, -- Quickish double swipe
	{seq = "nz_t8_attack_walk_larm_1"},
	{seq = "nz_t8_attack_walk_rarm_3"},
	{seq = "nz_t8_attack_walk_larm_2"},
	{seq = "nz_t8_attack_walk_rarm_6"},
}

local SuperSprintAttackSequences = {
	{seq = "nz_t8_attack_supersprint_larm_1"},
	{seq = "nz_t8_attack_supersprint_larm_2"},
	{seq = "nz_t8_attack_supersprint_rarm_1"},
	{seq = "nz_t8_attack_supersprint_rarm_2"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_junkie/amb/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/amb/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/amb/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/amb/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/amb/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/amb/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/amb/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/amb/amb_07.mp3"),
}

local runsounds = {
	Sound("nz_moo/zombies/vox/_junkie/scream/scream_00.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/scream/scream_01.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/scream/scream_02.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/scream/scream_03.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/scream/scream_04.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/scream/scream_05.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/scream/scream_06.mp3"),
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnfast},
			MovementSequence = {
				"nz_walk_au10",
				"nz_walk_au11",
				"nz_walk_au13",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},

			Climb36 = {SlowClimbUp36},
			Climb48 = {SlowClimbUp48},
			Climb72 = {SlowClimbUp72},
			Climb96 = {SlowClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
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
			AttackSequences = {SuperSprintAttackSequences},
			JumpSequences = {SprintJumpSequences},

			Climb36 = {FastClimbUp36},
			Climb48 = {FastClimbUp48},
			Climb72 = {FastClimbUp72},
			Climb96 = {FastClimbUp96},
			Climb120 = {SlowClimbUp128},
			Climb160 = {SlowClimbUp160},
			Climb200 = {ClimbUp200},

			PassiveSounds = {runsounds},
		},
	}}
}

ENT.ExplodeAttackSequences = {
	"nz_napalm_attack_01",
	"nz_napalm_attack_02",
	"nz_napalm_attack_03"
}

ENT.SonicScreamSequences = {
	--"nz_sonic_attack_01",
	--"nz_sonic_attack_02",
	"nz_sonic_attack_03",
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_napalm/pain/zmb_napalm_zombies_vocals_pain_00.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/pain/zmb_napalm_zombies_vocals_pain_01.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/pain/zmb_napalm_zombies_vocals_pain_02.mp3")
}
ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_junkie/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/attack/attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/attack/attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/attack/attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/attack/attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/attack/attack_07.mp3"),
}
ENT.SpawnSounds = {
	Sound("nz_moo/zombies/vox/_napalm/spawn/evt/evt_napalm_zombie_spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/spawn/evt/evt_napalm_zombie_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/spawn/evt/evt_napalm_zombie_spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/spawn/evt/evt_napalm_zombie_spawn_03.mp3"),
}
ENT.SpawnVoxSounds = {
	Sound("nz_moo/zombies/vox/_napalm/spawn/evt_napalm_zombie_spawn_vocals_00.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/spawn/evt_napalm_zombie_spawn_vocals_01.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/spawn/evt_napalm_zombie_spawn_vocals_02.mp3"),
}

ENT.FootstepsSounds = {
	Sound("nz_moo/zombies/vox/_napalm/step/fly_step_napalm_close_00.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/step/fly_step_napalm_close_01.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/step/fly_step_napalm_close_02.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/step/fly_step_napalm_close_03.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/step/fly_step_napalm_close_04.mp3"),
	Sound("nz_moo/zombies/vox/_napalm/step/fly_step_napalm_close_05.mp3")
}

ENT.SWTFootstepsSounds = {
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_00.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_01.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_02.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_03.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_04.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_05.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_06.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_07.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_08.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_09.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_10.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_11.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_12.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_13.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_14.mp3"),
	Sound("nz_moo/zombies/vox/_mutated/new/_shared/step_swt/step_swt_15.mp3"),
}

ENT.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_junkie/behind/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/behind/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/behind/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/behind/behind_03.mp3"),
	Sound("nz_moo/zombies/vox/_junkie/behind/behind_04.mp3"),
}

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(2250)
			self:SetMaxHealth(2250)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(nzRound:GetNumber() * 250 + (250 * count), 2250, 5250 * count))
				self:SetMaxHealth(math.Clamp(nzRound:GetNumber() * 250 + (250 * count), 2250, 5250 * count))
			else
				self:SetHealth(2250)
				self:SetMaxHealth(2250)	
			end
		end

		self:SetRunSpeed(1)

		self:SetBodygroup(0,1)
		self:SetBodygroup(1,1)

		leftthetoasteron = false
		self:SetLastToast(CurTime())
		
		self.Cooldown = CurTime() + 7 -- Won't be allowed to explode right after spawning, so they'll attack normally until then.
		self.Screaming = false
		self.CanScream = false
		self.CanExplode = false
		self.Suicide = false

		self.Sprint = false
        --self:Flames(true)
	end
end

function ENT:OnSpawn()
	--self:PlaySound(self.SpawnSounds[math.random(#self.SpawnSounds)], 577, math.random(85, 105))
	self:PlaySound(self.SpawnVoxSounds[math.random(#self.SpawnVoxSounds)], 100, math.random(85, 105), 1, 2)
	self:EmitSound("nz_moo/zombies/vox/_napalm/evt_napalm_zombie_loop.wav", 75, math.random(95, 105), 1, 3)

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

	self:SolidMaskDuringEvent(MASK_PLAYERSOLID)
	--ParticleEffect("doom_hellunit_spawn_medium",self:GetPos(),self:GetAngles(),self)
	--ParticleEffectAttach("firestaff_victim_burning",PATTACH_ABSORIGIN_FOLLOW,self,0)
	ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
	self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
	
	self:SetSpecialAnimation(true)
	local seq = self:SelectSpawnSequence()
	if seq then
		self:PlaySequenceAndMove(seq)
		self:SetSpecialAnimation(false)
		self:CollideWhenPossible()
	end
end

function ENT:PerformDeath(dmginfo)
		
	self.Dying = true

	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)

	if damagetype == DMG_MISSILEDEFENSE or damagetype == DMG_ENERGYBEAM then
		self:BecomeRagdoll(dmginfo) -- Only Thundergun and Wavegun Ragdolls constantly.
	end
	if damagetype == DMG_REMOVENORAGDOLL then
		self:Remove(dmginfo)
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() then
		if self.DeathSounds then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		end
		self:BecomeRagdoll(dmginfo)
	else
		if self.DeathSounds then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		end
		self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
	end
end

function ENT:OnInjured(dmginfo) 
	if !self.Enraged and math.random(100) <= 25 and !self:GetSpecialAnimation() then
		self.Enraged = true

		self:SetRunSpeed(71)
		self:SpeedChanged()
		self:Flames(true)

		self:PlaySound(self.SpawnSounds[math.random(#self.SpawnSounds)], 577, math.random(85, 105))
		self:EmitSound("nz_moo/zombies/vox/_thrasher/enrage_imp_00.mp3",577)

		ParticleEffect("bo3_astronaut_pulse",self:LocalToWorld(Vector(0,0,60)),Angle(0,0,0),nil)	
		ParticleEffect("doom_hellunit_spawn_medium",self:GetPos(),self:GetAngles(),self)
		self:DoSpecialAnimation("nz_mixamo_taunt10")

		for k, v in pairs(ents.FindInSphere(self:GetPos(), 120)) do    
			if v.IsMooZombie and !v.IsMooSpecial and !v:GetSpecialAnimation() then
				if v.SparkyAnim then
					v:DoSpecialAnimation(v.SparkyAnim, true, true)
					if !v:Flames() then
	            		v:Flames(true)
	            		if v.ElecSounds then	
							v:PlaySound(v.ElecSounds[math.random(#v.ElecSounds)], 90, math.random(85, 105), 1, 2)
						end
					end
				end
			end
		end
	end
end

function ENT:PostDeath(dmginfo) 
	self:StopSound("nz_moo/zombies/vox/_napalm/evt_napalm_zombie_loop.wav")
	if !self.Suicide then
		self:NapalmDeathExplosion()
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_napalm/evt_napalm_zombie_loop.wav")
	self:StopSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav")
end

function ENT:IsValidTarget( ent )
	if !ent then return false end

	-- Turned Zombie Targetting
	if self.IsTurned then return IsValid(ent) and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooSpecial and ent:Alive() end
	
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
	-- Won't go for special targets (Monkeys), but still MAX, ALWAYS and so on
end

function ENT:PostAdditionalZombieStuff()
	if self:GetSpecialAnimation() then return end
	if CurTime() > self.Cooldown and !self.CanScream then
		self.CanScream = true
	end
	if self:TargetInRange(325) and !self:IsAttackBlocked() and self.CanScream and !self.IsTurned then
		if !self:GetTarget():IsPlayer() then return end
		if self:TargetInRange(90) then return end
		self:SonicAttack()
	end
end

function ENT:SonicAttack()
	self:TempBehaveThread(function(self)
		self:SetSpecialAnimation(true)

		self:PlaySequenceAndMove(self.SonicScreamSequences[math.random(#self.SonicScreamSequences)], 1, self.FaceEnemy)

		self:StopToasting()
		self.Screaming = false
		self.CanScream = false
		self:SetSpecialAnimation(false)
		self.Cooldown = CurTime() + 7
	end)
end

function ENT:OnThink()
	if not IsValid(self) then return end
	local target = self.Target

	if self.Screaming and (self.Dying or self.IsBeingStunned) then
		self:StopToasting()
	end
	if self.UsingFlamethrower and self:GetLastToast() + 0.125 < CurTime() and !self.Dying then -- This controls how offten the trace for the flamethrower updates it's position. This shit is very costly so I wanted to try limit how much it does it.
		self:StartToasting()
	end
end

function ENT:StartToasting()
	self.UsingFlamethrower = true
	if self.UsingFlamethrower then
		--print("I'm Nintoasting!!!")

		if not leftthetoasteron then
			ParticleEffectAttach("asw_mnb_flamethrower",PATTACH_POINT_FOLLOW,self,13)
			self:EmitSound("nz_moo/zombies/vox/_sonic/zmb_sonic_scream.mp3", 100, 70)
			self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/start.mp3",95, math.random(85, 105))
			self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav",100, 100)
			leftthetoasteron = true
		end

		self:SetLastToast(CurTime())
		if !self.NextFireParticle or self.NextFireParticle < CurTime() then
			local bone = self:GetAttachment(self:LookupAttachment("mouth_fx_tag"))
			pos = bone.Pos
			local mins = Vector(0, -8, -15)
			local maxs = Vector(325, 20, 15)
			local tr = util.TraceHull({
				start = pos,
				endpos = pos + bone.Ang:Forward()*500,
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_INTERACTIVE_DEBRIS,
				ignoreworld = true,
				mins = mins,
				maxs = maxs,
			})
			local tr2 = util.TraceHull({
				start = pos,
				endpos = pos + bone.Ang:Forward()*500,
				filter = self,
				mask = MASK_PLAYERSOLID,
				collisiongroup = COLLISION_GROUP_PLAYER,
				ignoreworld = true,
				mins = mins,
				maxs = maxs,
			})
		
			local target = tr.Entity
			local target2 = tr2.Entity

			--print(target)

			debugoverlay.BoxAngles(pos, mins, maxs, bone.Ang, 1, Color( 255, 255, 255, 10))
			
			if IsValid(target2) and target2:IsNextBot() and target2.IsMooZombie and !target2.ZombieIgnited and !target2.IsMooSpecial then
				target2:Flames(true)
			end
			if IsValid(target) and target:IsPlayer() and target:Alive() then
				local dmg = DamageInfo()
				dmg:SetAttacker(self)
				dmg:SetInflictor(self)
				dmg:SetDamage(5)
				dmg:SetDamageType(DMG_BURN)
						
				tr.Entity:TakeDamageInfo(dmg)
				--tr.Entity:Ignite(3, 0)
			end
		end
		self.NextFireParticle = CurTime() + 0.1
	end
end

function ENT:StopToasting()
	if self.UsingFlamethrower then
		--print("I'm no longer Nintoasting.")
		if leftthetoasteron then
			--self:EmitSound("nz_moo/zombies/vox/_mechz/v2/flame/end.mp3",100, math.random(85, 105))
			self:StopSound("nz_moo/zombies/vox/_mechz/v2/flame/loop.wav")
			leftthetoasteron = false
		end
		self.UsingFlamethrower = false
		self:StopParticles()
	end
end

function ENT:OnTargetInAttackRange()
	if !self:GetBlockAttack() and !self.CanExplode or self.IsTurned then
		self:Attack()
	else
		self:TimeOut(1)
	end
end

function ENT:NapalmDeathExplosion()
	if IsValid(self) then	
		util.ScreenShake(self:GetPos(),12,400,3,1000)

		self:EmitSound("nz_moo/zombies/vox/_napalm/explosion/evt_napalm_zombie_explo.mp3",511)
		self:EmitSound("nz_moo/zombies/vox/_napalm/explosion/zmb_napalm_explode.mp3",511)
		self:EmitSound("nz_moo/zombies/vox/_napalm/explosion/evt_zombie_flare_0"..math.random(0,1)..".mp3",511)

        local entParticle = ents.Create("info_particle_system")
        entParticle:SetKeyValue("start_active", "1")
        entParticle:SetKeyValue("effect_name", "napalm_postdeath_napalm")
        entParticle:SetPos(self:GetPos())
        entParticle:SetAngles(self:GetAngles())
        entParticle:Spawn()
        entParticle:Activate()
        entParticle:Fire("kill","",20)

        local firepit = ents.Create("napalm_firepit")
        firepit:SetPos(self:WorldSpaceCenter())
		firepit:SetAngles(Angle(0,0,0))
        firepit:Spawn()

		self:Explode(200, false)
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) -- Moo Mark 4/14/23: You don't know how sad I am that I didn't know about this sooner.

	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large

	if e == "step_right_small" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 85)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 70)
		ParticleEffectAttach("bo3_napalm_fs",PATTACH_POINT,self,12)
	end
	if e == "step_left_small" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 85)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 70)
		ParticleEffectAttach("bo3_napalm_fs",PATTACH_POINT,self,11)
	end
	if e == "step_right_large" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 85)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 70)
		ParticleEffectAttach("bo3_napalm_fs",PATTACH_POINT,self,12)
	end
	if e == "step_left_large" then
		self:EmitSound(self.FootstepsSounds[math.random(#self.FootstepsSounds)], 85)
		self:EmitSound(self.SWTFootstepsSounds[math.random(#self.SWTFootstepsSounds)], 70)
		ParticleEffectAttach("bo3_napalm_fs",PATTACH_POINT,self,11)
	end

	if e == "napalm_charge" then
		self:EmitSound("nz_moo/zombies/vox/_napalm/explosion/evt_napalm_charge.mp3", 100)
	end
	if e == "napalm_explode" then
		self:NapalmDeathExplosion()
	end

	if e == "sonic_scream" then
		self.Screaming = true
		self:StartToasting()
		--[[local me = self
		self:EmitSound("nz_moo/zombies/vox/_sonic/evt_sonic_attack_flux.mp3", 100, math.random(85, 105))
		self:EmitSound("nz_moo/zombies/vox/_sonic/zmb_sonic_scream.mp3", 65, math.random(85, 105))
		ParticleEffectAttach("screamer_scream", 4, self, 10)
		for k,v in pairs(ents.FindInSphere(self:GetPos(), 325)) do
			if IsValid(v) and !self:IsAttackEntBlocked(v) then
				if v:IsPlayer() then
					v:NZSonicBlind(3)
				end
			end
		end]]
	end
end


function ENT:PostTookDamage(dmginfo)
	if self:Health() < 100 then
		self.LastZombieMomento = true
	end
end
