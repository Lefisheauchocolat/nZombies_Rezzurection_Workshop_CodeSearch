AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	ENT.EyeColorTable = {
		[0] = Material("models/moo/codz/t7_zombies/cosmodrome/mtl_c_zom_dlchd_monkey_eyes.vmt"),
	}
	return 
end -- Client doesn't really need anything beyond the basics

ENT.AttackRange 			= 80
ENT.DamageRange 			= 80

ENT.AttackDamage 			= 25
ENT.HeavyAttackDamage 		= 50 

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t7/cosmodrome/moo_codz_t7_cosmodrome_monkey.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"idle"}

ENT.DeathSequences = {
	"nz_base_monkey_death_v1",
	"nz_base_monkey_death_v2",
}

local AttackSequences = {
	{seq = "nz_base_monkey_attack_v1"},
	{seq = "nz_base_monkey_attack_v2"},
	{seq = "nz_base_monkey_attack_v3"},
	{seq = "nz_base_monkey_attack_v4"},
	{seq = "nz_base_monkey_attack_v5"},
	{seq = "nz_base_monkey_attack_v6"},
	{seq = "nz_base_monkey_attack_v7"},
}

local WalkAttackSequences = {
	{seq = "nz_base_monkey_attack_v1"},
	{seq = "nz_base_monkey_attack_v2"},
	{seq = "nz_base_monkey_attack_v3"},
	{seq = "nz_base_monkey_attack_v4"},
	{seq = "nz_base_monkey_attack_v5"},
	{seq = "nz_base_monkey_attack_v6"},
	{seq = "nz_base_monkey_attack_v7"},
}

local JumpSequences = {
	{seq = "nz_base_monkey_mantle_over"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_monkey/amb/vox_monkey_ambient_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/amb/vox_monkey_ambient_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/amb/vox_monkey_ambient_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/amb/vox_monkey_ambient_03.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/amb/vox_monkey_ambient_04.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/amb/vox_monkey_ambient_05.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/amb/vox_monkey_ambient_06.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/amb/vox_monkey_ambient_07.mp3"),
	
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_monkey_run_v1",
				"nz_base_monkey_run_v2",
			},
			
			AttackSequences = {WalkAttackSequences},
			StandAttackSequences = {AttackSequences},

			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}}
}

ENT.IdleSequence = "nz_base_monkey_idle_v1"
ENT.IdleSequenceAU = "nz_base_monkey_idle_v2" 
ENT.NoTargetIdle = "nz_base_monkey_idle_v1"

ENT.ZombieLandSequences = {
	"nz_base_monkey_jump_land",
}

ENT.TauntSequences = {
	"nz_base_monkey_taunt_v1",
	"nz_base_monkey_taunt_v2",
	"nz_base_monkey_taunt_v3",
	"nz_base_monkey_taunt_v4",
	"nz_base_monkey_taunt_v5",
}

ENT.ThundergunRollSequences = {
	"nz_base_monkey_thundergun_roll_v1",
	"nz_base_monkey_thundergun_roll_v2",
	"nz_base_monkey_thundergun_roll_v3",
	"nz_base_monkey_thundergun_roll_v4",
}

ENT.ThrowGrenadeSequences = {
	"nz_base_monkey_grenade_throwback_v1",
	"nz_base_monkey_grenade_throwback_v2",
	"nz_base_monkey_grenade_throwback_v3",
	"nz_base_monkey_grenade_throwback_v4",
}

ENT.FreakedSequences = {
	"nz_base_monkey_freaked_v1",
	"nz_base_monkey_freaked_v2",
	"nz_base_monkey_freaked_v3",
	"nz_base_monkey_freaked_v4",
}

ENT.GroundPoundSequences = {
	"nz_base_monkey_groundpound_v1",
	"nz_base_monkey_groundpound_v2",
	"nz_base_monkey_groundpound_v3",
	"nz_base_monkey_groundpound_v4",
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_monkey/_bo1/death/death_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/death/death_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/death/death_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/death/death_03.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/death/death_04.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/death/death_05.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/death/death_06.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_monkey/attack/vox_monkey_attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/attack/vox_monkey_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/attack/vox_monkey_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/attack/vox_monkey_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/attack/vox_monkey_attack_04.mp3"),
}

ENT.LandSounds = {
	Sound("nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_00.mp3"),
	Sound("nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_01.mp3"),
	Sound("nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_02.mp3"),
	Sound("nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_03.mp3"),
	Sound("nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_04.mp3"),
	Sound("nz_moo/zombies/fly/jumpland_heavy/bodyfall_heavy_05.mp3"),
}

ENT.FreakoutSounds = {
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_09.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/attack/attack_10.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_03.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_04.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_05.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_06.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_07.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_08.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/_bo1/amb/ambient_09.mp3"),
}

ENT.MonkeyStepSounds = {
	Sound("nz_moo/zombies/vox/_monkey/steps/fly_cosmo_monkey_step_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/steps/fly_cosmo_monkey_step_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/steps/fly_cosmo_monkey_step_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/steps/fly_cosmo_monkey_step_03.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/steps/fly_cosmo_monkey_step_04.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/steps/fly_cosmo_monkey_step_05.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/steps/fly_cosmo_monkey_step_06.mp3"),
}

ENT.ChestpoundSounds = {
	Sound("nz_moo/zombies/vox/_monkey/chestpound/fly_monkey_chest_pound_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/chestpound/fly_monkey_chest_pound_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/chestpound/fly_monkey_chest_pound_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/chestpound/fly_monkey_chest_pound_03.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/chestpound/fly_monkey_chest_pound_04.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/chestpound/fly_monkey_chest_pound_05.mp3"),
}

ENT.GroundpoundSounds = {
	Sound("nz_moo/zombies/vox/_monkey/groundpound/ground_pound_sweet_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/groundpound/ground_pound_sweet_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/groundpound/ground_pound_sweet_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/groundpound/ground_pound_sweet_03.mp3"),
}

ENT.CustomMeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_monkey/swing/fly_monkey_swing_00.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/swing/fly_monkey_swing_01.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/swing/fly_monkey_swing_02.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/swing/fly_monkey_swing_03.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/swing/fly_monkey_swing_04.mp3"),
	Sound("nz_moo/zombies/vox/_monkey/swing/fly_monkey_swing_05.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		if nzRound:GetNumber() == -1 then
			self:SetRunSpeed( math.random(25, 220) )
			self:SetHealth( math.random(100, 1500) )
		else
			local speeds = nzRound:GetZombieCoDSpeeds()
			if speeds then
				self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
			else
				self:SetRunSpeed( 100 )
			end
			self:SetHealth( nzRound:GetZombieHealth() or 75 )
		end

		self.GrenadeThrowCoolDown = CurTime() + 1
		self.GroundPoundCoolDown = CurTime() + 1

		self.Enraged = false
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = animation or self:SelectSpawnSequence()
	grav = grav
	dirt = dirt

	if IsValid(self) then
		self:EmitSound("nz_moo/effects/teleport_in_00.mp3", 100)
		ParticleEffect("panzer_spawn_tp", self:GetPos() + Vector(0,0,18), Angle(0,0,0), self)
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

function ENT:AI()
	local target = self.Target
	if self:Health() <= self:GetMaxHealth() * 0.5 and !self.Enraged then
		self.Enraged = true
	end
	if self.Enraged and !self.BecomeEnraged then
		self.BecomeEnraged = true
		self:DoSpecialAnimation(self.TauntSequences[math.random(#self.TauntSequences)])
	end
	if IsValid(target) and target:IsPlayer() and !self:IsAttackBlocked() then
		if self:TargetInRange(self.AttackRange + 75) and CurTime() > self.GroundPoundCoolDown then
			self:DoSpecialAnimation(self.GroundPoundSequences[math.random(#self.GroundPoundSequences)])
			self.GroundPoundCoolDown = CurTime() + 4
		end
	end
	if IsValid(target) and target:IsPlayer() and !self:TargetInRange(100) and self:TargetInRange(750) and !self:IsAttackBlocked() and CurTime() > self.GrenadeThrowCoolDown and self.Enraged then
		self.GrenadeThrowCoolDown = CurTime() + math.Rand(2,6)
		self:DoSpecialAnimation(self.ThrowGrenadeSequences[math.random(#self.ThrowGrenadeSequences)])
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) 
	if e == "evt_monkey_step" then
		self:EmitSound(self.MonkeyStepSounds[math.random(#self.MonkeyStepSounds)], 75, math.random(95,105))
	end
	if e == "evt_monkey_land" then
		self:EmitSound(self.LandSounds[math.random(#self.LandSounds)], 75, math.random(95,105))
	end
	if e == "evt_monkey_slam" then
		self:EmitSound(self.GroundpoundSounds[math.random(#self.GroundpoundSounds)], 100, math.random(95,105))
		ParticleEffect("bo3_panzer_landing",self:LocalToWorld(Vector(0,20,0)),Angle(0,0,0),nil)
		util.ScreenShake(self:GetPos(),100000,500000,0.1,500)

		for k,v in nzLevel.GetTargetableArray() do
			if IsValid(v) and v:IsPlayer() and !self:IsAttackEntBlocked(v) then
				if self:GetRangeTo( v:GetPos() ) < self.AttackRange + 75 then
					local perks = v:GetPerks()
					if not table.IsEmpty(perks) then
						--[[if v:HasPerk("phd") then
							v:RemovePerk("phd", true)
						elseif v:HasPerk("jugg") then
							v:RemovePerk("jugg", true)
						elseif v:HasPerk("mask") then
							v:RemovePerk("mask", true)
						else
							v:RemovePerk(perks[math.random(#perks)], true)
						end]]
						v:RemovePerk(perks[math.random(#perks)], true)
					end

					v:TakeDamage(self.HeavyAttackDamage, self, nil)
					v:NZSonicBlind(2)
				end
			end
		end
	end
	if e == "evt_monkey_throw_grenade" then
		self:EmitSound("TFA.BO1.M67.Throw")

		local chance = math.random(50)
		local shit = ents.Create("bomber_grenade")

		if chance <= 1 then
			shit = ents.Create("bomber_flashbang")
		end


		shit:SetPos(self:GetAttachment(self:LookupAttachment("rarm_fx_tag")).Pos)
		shit:SetOwner(self:GetOwner())
		shit:Spawn()
		local phys = shit:GetPhysicsObject()
        local target = self:GetTarget()

        if IsValid(phys) and IsValid(target) then
             phys:SetVelocity(shit:getvel(target:GetPos() + target:GetVelocity() * math.Clamp(target:GetVelocity():Length2D(),0,1.2), self:EyePos(), 0.85))
        end
	end
	if e == "evt_monkey_chestbeat" then
		self:EmitSound(self.ChestpoundSounds[math.random(#self.ChestpoundSounds)], 75, math.random(95,105))
	end
	if e == "vox_monkey_taunt" then
		self:EmitSound(self.TauntSounds[math.random(#self.TauntSounds)], 80, math.random(95,105), 1, 2)
	end
	if e == "vox_monkey_freakout" then
		self:EmitSound(self.FreakoutSounds[math.random(#self.FreakoutSounds)], 80, math.random(95,105), 1, 2)
	end
end