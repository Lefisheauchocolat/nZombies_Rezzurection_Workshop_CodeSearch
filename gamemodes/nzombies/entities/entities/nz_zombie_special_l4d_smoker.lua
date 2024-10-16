AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Smoker"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

function ENT:FinishGrab()
	if CLIENT then return end
	if self:GetStop() then
		self.WaitForTongue = true
	end
end

if CLIENT then 
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end
	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_smoker_aura", 4, 3)
			end
		end
	end

	hook.Add("CreateClientsideRagdoll", "noSmokerBodygroups", function(ent, ragdoll)
        if not IsValid(ent) or not IsValid(ragdoll) then return end
        if not ent:IsValidZombie() then return end
        if ent:GetClass() ~= "nz_zombie_special_l4d_smoker" then return end
        
        for k, v in pairs(player.GetAll()) do
        	if IsValid(v) and (nzGum:GetActiveGum(v) and nzGum:GetActiveGumData(v).name == "Newtonian Negation") then
        		--local phys = ragdoll:GetPhysicsObject()
        		local bones = ragdoll:GetPhysicsObjectCount()
        		for i = 0, bones - 1 do

					local phys = ragdoll:GetPhysicsObjectNum( i )
					if ( IsValid( phys ) ) then
						phys:EnableGravity( false )
						phys:Wake()
					end
				end
        	end
        end
        
        ragdoll:SetBodygroup(1,1)
        ragdoll:SetBodygroup(2,1)

        if ent.Draw_FX and IsValid(ent.Draw_FX) then
            ent.Draw_FX:StopEmissionAndDestroyImmediately()
        end

    end)
	return 
end -- Client doesn't really need anything beyond the basics

local util_traceline = util.TraceLine

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.IsMooSpecial = true
ENT.RedEyes = true

ENT.MinSoundPitch 	= 95
ENT.MaxSoundPitch 	= 105

ENT.Models = {
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d_special_smoker.mdl", Skin = 0, Bodygroups = {0,0}},

	-- Extra Skins by SirWololo, Revenant100, Rise, TOG | K1CHWA
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d_special_smoker.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d_special_smoker.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d_special_smoker.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d_special_smoker.mdl", Skin = 4, Bodygroups = {0,0}},
	
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d2_special_smoker.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d2_special_smoker.mdl", Skin = 0, Bodygroups = {0,0}},

	-- Credit to Spicy_Jam
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d2_special_smoker_remastered.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d2_special_smoker_remastered.mdl", Skin = 0, Bodygroups = {0,0}},

	-- Credit to SirWololo
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d2_special_smoker_coldseason.mdl", Skin = 0, Bodygroups = {0,0}}, 
	{Model = "models/moo/_moo_ports/l4d/infected/smoker/moo_l4d2_special_smoker_coldseason.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"smoker"}

local CrawlAttackSequences = {
	{seq = "smoker_crouch_attack_01"},
	{seq = "smoker_crouch_attack_02"},
	{seq = "smoker_crouch_attack_03"},
}

local AttackSequences = {
	{seq = "smoker_stand_attack_01"},
	{seq = "smoker_stand_attack_02"},
	{seq = "smoker_stand_attack_03"},
}

local WalkAttackSequences = {
	{seq = "smoker_walk_attack_01"},
	{seq = "smoker_walk_attack_02"},
	{seq = "smoker_walk_attack_03"},
}

local RunAttackSequences = {
	{seq = "smoker_run_attack_01"},
	{seq = "smoker_run_attack_02"},
	{seq = "smoker_run_attack_03"},
}

local JumpSequences = {
	{seq = "smoker_barricade_jump"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_06.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_08.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_09.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_10.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_11.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_12.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_13.mp3"),
}

ENT.IdleSequence = "smoker_idle_01"
ENT.IdleSequenceAU = "smoker_idle_02"
ENT.CrawlIdleSequence = "smoker_crouch_idle_01"
ENT.ZombieLandSequences = {
	"smoker_land",
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"smoker_walk_01",
			},
			CrawlMovementSequence = {
				"smoker_crouch_walk_01",
			},
			AttackSequences = {WalkAttackSequences},
			StandAttackSequences = {AttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {JumpSequences},
			CrawlJumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"smoker_run_01",
			},
			CrawlMovementSequence = {
				"smoker_crouch_walk_01",
			},
			AttackSequences = {RunAttackSequences},
			StandAttackSequences = {AttackSequences},
			CrawlAttackSequences = {CrawlAttackSequences},

			JumpSequences = {JumpSequences},
			CrawlJumpSequences = {JumpSequences},

			PassiveSounds = {walksounds},
		},
	}},
}

ENT.PainSequences = {
	"smoker_stumble_forward",
	"smoker_stumble_left",
	"smoker_stumble_right",
	"smoker_stumble_back",
	"smoker_stumble_forward",
	"smoker_stumble_left",
	"smoker_stumble_right",
	"smoker_stumble_back",
}

ENT.ThunderGunSequences = {
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
	"smoker_stumble_back",
}

ENT.SpawnSounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/alert/smoker_alert_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/alert/smoker_alert_02.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/alert/smoker_alert_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/alert/smoker_alert_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/alert/smoker_alert_05.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/alert/smoker_alert_06.mp3"),
}

ENT.PainSounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_pain_02.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_pain_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_pain_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_pain_05.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_pain_06.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_painshort_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_painshort_02.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_painshort_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_painshort_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_painshort_05.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/pain/smoker_painshort_06.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/death/smoker_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/death/smoker_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/death/smoker_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/death/smoker_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/death/smoker_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/death/smoker_death_06.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_09.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_10.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_attack_11.mp3"),
}

ENT.WarnSounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/warn/smoker_warn_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/warn/smoker_warn_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/warn/smoker_warn_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/warn/smoker_warn_05.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/warn/smoker_warn_06.mp3"),
}

ENT.TongueLaunchSounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_launchtongue_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_launchtongue_02.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_launchtongue_03.mp3"),
}

ENT.CrawlerSounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_06.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_08.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_09.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_10.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_11.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_12.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_13.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_06.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_08.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_09.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_10.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_11.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_12.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/idle/smoker_lurk_13.mp3"),
}

ENT.MeleeWhooshSounds = {
	Sound("nz_moo/zombies/vox/_hunter/fly/miss/claw_miss_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/miss/claw_miss_2.mp3"),
}

ENT.CustomAttackImpactSounds = {
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/claw_hit_flesh_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/claw_hit_flesh_2.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/claw_hit_flesh_3.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/claw_hit_flesh_4.mp3"),
}

ENT.HeavyAttackImpactSounds = {
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_1.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_2.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_3.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_4.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_5.mp3"),
	Sound("nz_moo/zombies/vox/_hunter/fly/hit/zombie_slice_6.mp3"),
}

ENT.DeathExplodeSounds = {
	Sound("nz_moo/zombies/vox/_smoker/death/smoker_explode_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/death/smoker_explode_02.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/death/smoker_explode_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/death/smoker_explode_04.mp3"),
}

ENT.SpawnStingSounds = {
	Sound("nz_moo/zombies/vox/_smoker/music/smokerbacteria.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/music/smokerbacterias.mp3"),
}

ENT.BehindSoundDistance = 0

function ENT:StatsInitialize()
	if SERVER then
		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 1 )
		end
		self:SetHealth( nzRound:GetZombieHealth() * 1.75 or 75 )
		self:SetMaxHealth( nzRound:GetZombieHealth() * 1.75 or 75 )

		self:SetBodygroup(1,0)
		self:SetBodygroup(2,0)

		self.NextSting = CurTime() + math.Rand(25.7, 60.3)

		self.UsingTongue = false
		self.WaitForTongue = false
		self.TongueCooldown = CurTime() + math.Rand(3.75, 4.5)
	end
end

function ENT:SpecialInit()
	if CLIENT then
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

	self:SetCollisionBounds(Vector(-6,-6, 0), Vector(6, 6, 72))	
		
	self:SolidMaskDuringEvent(MASK_SOLID_BRUSHONLY)
	self:SetInvulnerable(true)

	self:EmitSound(self.SpawnSounds[math.random(#self.SpawnSounds)], 500, math.random(98, 102), 1, 2)

	self:TimeOut(1)

	self:SetSpecialAnimation(true)

	if seq then

		self:PlaySequenceAndMove(seq)
		self:SetSpecialAnimation(false)
		self:SetInvulnerable(false)
		self:CollideWhenPossible()
	end
end

function ENT:AI()
	local target = self.Target

	-- Spooky Music
	if CurTime() > self.NextSting then
		self.NextSting = CurTime() + math.Rand(25.7, 60.3)
		self:EmitSound(self.SpawnStingSounds[math.random(#self.SpawnStingSounds)], 577)
	end

	-- Tongue
	if CurTime() > self.TongueCooldown and self:TargetInRange(1250) and !self:TargetInRange(225) then
		if self:IsAttackBlocked() then return end
		if self:GetSpecialAnimation() then return end
		if !IsValid(target) then return end

		self:TempBehaveThread(function(self)

			self:FaceTowards(target:GetPos())

			self.UsingTongue = true
			self:SetSpecialAnimation(true)
			self:PlaySequenceAndMove("smoker_tongue_attack_start", 1, self.FaceEnemy)
			
			self.KillTongue = CurTime() + 4
			self.TongueCooldown = CurTime() + math.Rand(5.75, 7.14)
		end)
	end
end

function ENT:OnThink()
	if self.WaitForTongue and self:GetStop() then
		self:SetBodygroup(1,0)

		self:SetStop(false)
		self:SetSpecialAnimation(false)

		self.WaitForTongue = false
		self.UsingTongue = false
	end
	if self.UsingTongue and !IsValid(self.Tongue) then
		self:FinishGrab()
	end
end

function ENT:PostDeath(dmginfo)
	self:EmitSound(self.DeathExplodeSounds[math.random(#self.DeathExplodeSounds)], 95, math.random(95,105))
	ParticleEffect("zmb_smoker_cloud", self:GetPos() + Vector(0,0,10), Angle(0,0,0), nil)
end

-- Called when the zombie wants to idle. Play an animation here
function ENT:PerformIdle()
	if self:GetSpecialAnimation() and !self.UsingTongue then return end
	if self.UsingTongue and self:GetStop() then
		self:ResetSequence("smoker_tongue_attack_loop")
	elseif self:GetCrawler() then
		self:ResetSequence(self.CrawlIdleSequence)
	elseif self:GetJumping() then
		if !self:GetCrawler() then
			self:GetSequenceActivity(ACT_JUMP)
		else
			self:GetSequenceActivity(ACT_HOP)
		end
	elseif self.ArmsUporDown == 1 and !self:GetCrawler() then
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
	-- This function is really only used for normal zombies a lot, so this can be overridden without problems.
	function ENT:OnInjured(dmginfo)
		local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
		local hitforce 		= dmginfo:GetDamageForce()
		local hitpos 		= dmginfo:GetDamagePosition()
		local inflictor 	= dmginfo:GetInflictor()

		if !self.SpawnProtection then

			--[[ STUMBLING/STUN ]]--
			if CurTime() > self.LastStun then -- The code here is kinda bad tbh, and in turn it does weird shit because of it.
				-- Moo Mark 7/17/23: Alright... We're gonna try again.
				if self.Dying then return end
				if !self:Alive() then return end
				if dmginfo:IsDamageType(DMG_MISSILEDEFENSE) 
					or self:GetSpecialAnimation() 
					or self:GetCrawler() 
					or self:GetIsBusy() 
					or self.ShouldCrawl 
					then return end

				-- 11/1/23: Have to double check the CurTime() > self.LastStun in order to stop the Zombie from being able to stumble two times in a row.
				if !self.IsBeingStunned and !self:GetSpecialAnimation() then
					if allowstumble == 1 then
						if self:CrawlerForceTest(hitforce) and CurTime() > self.LastStun then
							self.IsBeingStunned = true
							self:DoSpecialAnimation(self.PainSequences[math.random(#self.PainSequences)], true, true)
							self.IsBeingStunned = false
							self.LastStun = CurTime() + 8
							self:ResetMovementSequence()
						end
					end
				end
			end
		end
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) 

	self.OverrideLsmall = true 		-- Overrides step_left_small
	self.OverrideLLarge = true 		-- Overrides step_left_large
	self.OverrideRsmall = true 		-- Overrides step_right_small
	self.OverrideRLarge = true 		-- Overrides step_right_large


	if e == "smoker_tongue_warn" then
		self:PlaySound(self.WarnSounds[math.random(#self.WarnSounds)],577, math.random(self.MinSoundPitch, self.MaxSoundPitch), 1, 2)
		self.NextSound = CurTime() + 10
	end

	if e == "smoker_tongue_attack" then
		self:EmitSound(self.TongueLaunchSounds[math.random(#self.TongueLaunchSounds)], 95, math.random(95,105))

		local pos = self:GetAttachment(self:LookupAttachment("smoker_mouth")).Pos
		
		if IsValid(self.Target) and self.Target:IsPlayer() then
			local tr = util_traceline({
				start = self:EyePos(),
				endpos = self.Target:EyePos(),
				filter = self,
				ignoreworld = false,
			})
			local b = tr.Entity

			debugoverlay.Line(self:EyePos(), self.Target:EyePos(), 5, Color( 255, 255, 255 ), false)
			
			if tr.HitWorld then 
				self.UsingTongue = false
				self:SetSpecialAnimation(false)
				return 
			end

			if IsValid(self.Target) then
				self.Tongue = ents.Create("nz_proj_smoker_tongue")
				self.Tongue:SetPos(pos)
				self.Tongue:Spawn()
				self.Tongue:SetSmoker(self)
				self.Tongue:Launch(((self.Target:GetPos() + Vector(0,0,50) + self.Target:GetVelocity() * math.Clamp(self.Target:GetVelocity():Length2D(),0,0.5)) - self.Tongue:GetPos()):GetNormalized())
			end
		end

		self:SetBodygroup(1,1)
		self:Stop()
	end

	if e == "smoker_land" then
		self:EmitSound("nz_moo/zombies/vox/_hunter/fly/bodyfall_largecreature.mp3", 80, math.random(95,105))
	end
end