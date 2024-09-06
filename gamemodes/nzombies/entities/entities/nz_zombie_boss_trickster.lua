AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zaballin'"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end

	function ENT:DrawEyeGlow() end

	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if !self.Draw_FX or !IsValid(self.Draw_FX) then -- PVS will no longer eat the particle effect.
				self.Draw_FX = CreateParticleSystem(self, "zmb_trickster_aura", PATTACH_POINT_FOLLOW, 1)
			end
			if !self.Draw_FX2 or !IsValid(self.Draw_FX2) then -- PVS will no longer eat the particle effect.
				self.Draw_FX2 = CreateParticleSystem(self, "zmb_zct_fire_red", PATTACH_POINT_FOLLOW, 2)
			end
			if (!self.Draw_SFX or !IsValid(self.Draw_SFX)) then
				self.Draw_SFX = "nz_moo/zombies/vox/_deceiver/deceiver_amb_lp.wav"

				self:EmitSound(self.Draw_SFX, 75, math.random(95, 105), 1, 3)
			end
		end
	end 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.IsMooSpecial = true
ENT.IsMooBossZombie = true
ENT.IsMiniBoss = true

ENT.AttackRange = 77
ENT.DamageRange = 77

ENT.AttackDamage = 75
ENT.HeavyAttackDamage = 100

ENT.MinSoundPitch = 95
ENT.MaxSoundPitch = 105
ENT.SoundVolume = 65 	

ENT.SoundDelayMin = 0.25
ENT.SoundDelayMax = 2

ENT.Models = {
	{Model = "models/moo/_codz_ports/s4/skorpion/moo_codz_s4_demon_trickster.mdl", Skin = 0, Bodygroups = {0,0}},
}

local spawn = {"nz_base_deceiver_spawn"}

ENT.DeathSequences = {
	"nz_base_deceiver_death_01",
}

ENT.BarricadeTearSequences = {
	"nz_base_deceiver_attack_01",
	"nz_base_deceiver_attack_02",
	"nz_base_deceiver_attack_03",
}

local AttackSequences = {
	{seq = "nz_base_deceiver_attack_01"},
	{seq = "nz_base_deceiver_attack_02"},
	{seq = "nz_base_deceiver_attack_03"},
}

local JumpSequences = {
	{seq = "nz_base_deceiver_mantle_over_36"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_deceiver/elec/deceiver_elec_swt_00.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/elec/deceiver_elec_swt_01.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/elec/deceiver_elec_swt_02.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/elec/deceiver_elec_swt_03.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/elec/deceiver_elec_swt_04.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/elec/deceiver_elec_swt_05.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/elec/deceiver_elec_swt_06.mp3"),
}

-- This is a very large and messy looking table... But it gets the job done.
ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawn},
			MovementSequence = {
				"nz_base_deceiver_walk_01",
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
				"nz_base_deceiver_sprint_01",
			},
			
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

ENT.IdleSequence 	= "nz_base_deceiver_idle"
ENT.IdleSequenceAU 	= "nz_base_deceiver_idle"
ENT.NoTargetIdle 	= "nz_base_deceiver_idle"

ENT.ZombieLandSequences = { "nz_base_deceiver_land",}

ENT.CustomMantleOver48 = {"nz_base_deceiver_mantle_over_48",}
ENT.CustomMantleOver72 = {"nz_base_deceiver_mantle_over_72",}
ENT.CustomMantleOver96 = {"nz_base_deceiver_mantle_over_96",}

ENT.TeleportBeginVox = {
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcb_hereigoagain.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcb_nowyouseemenowyoured.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcb_uhohlookoutnow.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcb_youaskedforthis.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcb_youhurtmeikillyou.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcb_youvegotthiscoming.mp3"),
}

ENT.MaskBreakVox = {
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfa_ahilltakeyourfacenow.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfa_myface.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfa_mymaskyouwilldiefort.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfa_nonotmymask.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfa_thatmaskwassacred.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfa_whathaveyoudonetomym.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfa_youbreakmyfaceibreak.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfa_nonotmymask.mp3"),
}

ENT.MaskLastVox = {
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfb_anothermaskthishasto.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfb_nonotanother.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfb_onefaceleftthatsalli.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfb_paincrystopbreakingm.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfb_stopitstoptakingmyfa.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfb_thatisthelastmaskyou.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfb_thatstwomasksnomore.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezfb_twomasksbrokenthatis.mp3"),
}

ENT.LaughVox = {
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezca_laugh1.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezca_laugh2.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezca_laugh3.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezca_laugh4.mp3"),
}

ENT.ScreamVox = {
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcc_scream1.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcc_scream2.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcc_scream3.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/_voicelines/zm_caiz_eaiz_zbla_ezcc_scream4.mp3"),
}

ENT.PulseChargeSounds = {
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_start_00.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_start_01.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_start_02.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_start_03.mp3"),
}

ENT.PulsePopChargeSounds = {
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_00.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_01.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_02.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/bomb/deceiver_bomb_exp_03.mp3"),
}

ENT.MaskBreakSounds = {
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_00.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_01.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/head_explo/deceiver_head_explo_02.mp3"),
}

ENT.SpawnPortalSounds = {
	Sound("nz_moo/zombies/vox/_deceiver/spawn/deceiver_spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/spawn/deceiver_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_deceiver/spawn/deceiver_spawn_02.mp3"),
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_deceiver/deceiver_death_00.mp3"),
}

ENT.BehindSoundDistance = 0 -- When the zombie is within 200 units of a player, play these sounds instead

function ENT:StatsInitialize()
	if SERVER then
		local count = #player.GetAllPlaying()
		local playerhpmod = 1

		local basehealth = 575
		local basehealthmax = 55750

		local bosshealth = basehealth

		local healthincrease = 950
		local coopmultiplier = 0.75

		if count > 1 then
			playerhpmod = count * coopmultiplier
		end

		bosshealth = math.Round(playerhpmod * (basehealth + (healthincrease * nzRound:GetNumber())))

		if nzRound:InState( ROUND_CREATE ) then
			self:SetHealth(5000)
			self:SetMaxHealth(5000)
		else
			if nzRound:InState( ROUND_PROG ) then
				self:SetHealth(math.Clamp(bosshealth, basehealth, basehealthmax * playerhpmod))
				self:SetMaxHealth(math.Clamp(bosshealth, basehealth, basehealthmax * playerhpmod))
			else
				self:SetHealth(basehealth)
				self:SetMaxHealth(basehealth)	
			end
		end

		self:SetRunSpeed(1)

		self.HasMMask = true
		self.HasLMask = true
		self.HasRMask = true
		self.MaskCount = 3

		self.MineCooldown = CurTime() + math.Rand(2.75, 5.95)
		self.NextMineSpawn = CurTime() + 0.75
		self.TotalMineSpawns = 0
		self.UsingMine = false

		self.ShouldReappear = false

		self.PulseCooldown = CurTime() + math.Rand(5.95, 9.99)

		self.CanCancelAttack = true
		self:SetSurroundingBounds(Vector(-32, -32, 0), Vector(32, 32, 96))
	end
end

function ENT:OnSpawn(animation, grav, dirt)
	animation = self:SelectSpawnSequence()

	-- Mask Bodygroups
	self:SetBodygroup(1,0) -- Middle
	self:SetBodygroup(2,0) -- Left
	self:SetBodygroup(3,0) -- Right

	ParticleEffect("zmb_trickster_portal",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
	self:EmitSound("nz_moo/zombies/vox/_deceiver/deceiver_appear_00.mp3",100,math.random(95,105))
	self:EmitSound(self.SpawnPortalSounds[math.random(#self.SpawnPortalSounds)],100,math.random(95,105))

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
	if IsValid(target) and target:IsPlayer() then

		if CurTime() > self.PulseCooldown and self:TargetInRange(self.AttackRange + 50) and !self:IsAttackBlocked() then
			self.PulseCooldown = CurTime() + math.Rand(5.95, 9.99)
			self:DoSpecialAnimation("nz_base_deceiver_special_attack_01")
		end

		if CurTime() > self.MineCooldown and self:TargetInRange(750) and !self.UsingMine then
			if math.random(100) < 25 then
				self:EmitSound(self.TeleportBeginVox[math.random(#self.TeleportBeginVox)], 85, math.random(self.MinSoundPitch, self.MaxSoundPitch),1 ,2)
				self.NextSound = CurTime() + 10
			end

			self:BeginTeleport()
		end
	end
end

function ENT:OnThink()
	local target = self.Target
	if IsValid(target) and target:IsPlayer() then
		if self.UsingMine then
			self:SetStop(true)
			if CurTime() > self.NextMineSpawn then
				self:SetNoDraw(true)
				self:StopParticles()
				self.TotalMineSpawns = self.TotalMineSpawns + 1
				self.NextMineSpawn = CurTime() + 0.75

				local boomer = ents.Create("nz_proj_deceiver_mine")
				boomer:SetPos(target:GetPos() + Vector(0,0,25))
				boomer:Spawn()
			end
			if self.TotalMineSpawns >= 3 then
				self.UsingMine = false
			end
		end
		if !self.UsingMine and self.TotalMineSpawns >= 3 then
			self:SetStop(false)
			self.TotalMineSpawns = 0
			self.ShouldReappear = true
		end
	end
	if !self.UsingMine then
		self:SetNoDraw(false)
		self.SpawnProtection = false
	end
	if self.ShouldReappear then
		self.UsingMine = false
		local pos = self:FindSpotBehindPlayer(target:GetPos(), 25, 115)

		self:SetPos(pos)
		self.ShouldReappear = false

		self:FaceTowards(target:GetPos())
		self:DoSpecialAnimation("nz_base_deceiver_appear_01")
		self:CollideWhenPossible()

		if math.random(100) < 25 then
			self:EmitSound(self.LaughVox[math.random(#self.LaughVox)], 85, math.random(self.MinSoundPitch, self.MaxSoundPitch),1 ,2)
			self.NextSound = CurTime() + 10
		end
	end
end

function ENT:Explode(ent)
    local dmg = 90

    if SERVER then
        local pos = self:WorldSpaceCenter()

        local tr = {
            start = pos,
            filter = self,
            mask = MASK_NPCSOLID_BRUSHONLY
        }

        for k, v in pairs(ents.FindInSphere(pos, self.AttackRange + 50)) do
            local expdamage = DamageInfo()
            expdamage:SetDamageType(DMG_ENERGYBEAM)

            local distfac = pos:Distance(v:WorldSpaceCenter())
            distfac = 1 - math.Clamp((distfac/50), 0, 1)

            expdamage:SetAttacker(self)
            expdamage:SetDamage(dmg * distfac)
            expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

            if v:IsPlayer() then
                v:TakeDamageInfo(expdamage)
                v:NZSonicBlind(0.75)
            end
        end

        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())

        --util.Effect("Explosion", effectdata)
        util.ScreenShake(self:GetPos(), 20, 255, 0.5, 100)
    end
end

function ENT:OnInjured(dmginfo)
	local hitgroup 		= util.QuickTrace(dmginfo:GetDamagePosition(), dmginfo:GetDamagePosition()).HitGroup
	local hitforce 		= dmginfo:GetDamageForce()
	local hitpos 		= dmginfo:GetDamagePosition()
	local inflictor 	= dmginfo:GetInflictor()

	local hp = self:GetMaxHealth()

	dmginfo:ScaleDamage(0.75)

	if self.HasLMask and self:Health() <= hp * 0.25 then
		self.HasLMask = false
		self:BreakMask(1)
		if !self:GetSpecialAnimation() and self:Alive() and !self.Dying then
			self:BeginTeleport(true)
		end
	end
	if self.HasRMask and self:Health() <= hp * 0.75 then
		self.HasRMask = false
		self:BreakMask(2)
		if !self:GetSpecialAnimation() and self:Alive() and !self.Dying then
			self:BeginTeleport(true)
		end
	end
end

function ENT:BreakMask(mask)
	if isnumber(mask) and mask == 1 then
		self:SetBodygroup(2, 1)
	end
	if isnumber(mask) and mask == 2 then
		self:SetBodygroup(3, 1)
	end
	if isnumber(mask) and mask == 3 then
		self:SetBodygroup(1, 1)
	end
	ParticleEffectAttach("zmb_disciple_blast", 4, self, 1)
	self:EmitSound(self.MaskBreakSounds[math.random(#self.MaskBreakSounds)], 95, math.random(85,115))

	self.MaskCount = self.MaskCount - 1

	if math.random(100) < 25 then

		self.NextSound = CurTime() + 10

		if self.MaskCount == 2 then
			self:EmitSound(self.MaskBreakVox[math.random(#self.MaskBreakVox)], 95, math.random(85,115))
		end
		if self.MaskCount == 1 then
			self:EmitSound(self.MaskLastVox[math.random(#self.MaskLastVox)], 95, math.random(85,115))
		end
	end
end

function ENT:BeginTeleport(isstun)
	local seq = "nz_base_deceiver_disappear_01"

	if isstun then seq = "nz_base_deceiver_stun_blend" end

	self.SpawnProtection = true
	self.SpawnProtectionTime = CurTime() + 10

	self:TempBehaveThread(function(self)

		self:SolidMaskDuringEvent(MASK_NPCSOLID_BRUSHONLY)
		self.MineCooldown = CurTime() + math.Rand(10.75, 18.95)
		self:SetSpecialAnimation(true)
		self:PlaySequenceAndMove(seq, 1)
		self.UsingMine = true
		self:SetSpecialAnimation(false)
	end)
end

function ENT:PerformDeath(dmginfo)
		
	self.Dying = true

	local damagetype = dmginfo:GetDamageType()

	self:PostDeath(dmginfo)

	self:DissolveEffect()

	self:BreakMask(3)

    self:EmitSound("nz_moo/zombies/vox/_deceiver/deceiver_death_00.mp3", 511, math.random(95,105))

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

function ENT:CustomAnimEvent(a,b,c,d,e)
	if e == "deceiver_portal" then
		ParticleEffect("zmb_trickster_portal",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound(self.SpawnPortalSounds[math.random(#self.SpawnPortalSounds)],100,math.random(95,105))
	end
	if e == "deceiver_attack_charge" then
		ParticleEffectAttach("zmb_trickster_charge_tell", 4, self, 1)
		self:EmitSound(self.PulseChargeSounds[math.random(#self.PulseChargeSounds)], 85, math.random(85,115))
	end
	if e == "deceiver_attack" then
		ParticleEffectAttach("zmb_disciple_blast", 4, self, 9)
		self:EmitSound(self.PulsePopChargeSounds[math.random(#self.PulsePopChargeSounds)], 85, math.random(85,115))
		self:Explode()
	end
	if e == "deceiver_fixmask_charge" then

	end
	if e == "deceiver_fixmask_burst" then

	end
	if e == "deceiver_stun_burst" then
	end
end

function ENT:OnRemove()
	self:StopSound("nz_moo/zombies/vox/_deceiver/deceiver_amb_lp.wav")
end


function ENT:IsValidTarget( ent )
	if not ent then return false end
	
	-- Ignore a player who might be timing out. They may come back from it so leave them alone as to not unfairly kill them.
	if ent:IsPlayer() and ent:IsTimingOut() then return false end 
	if ent:IsPlayer() and !ent:Alive() then return false end

	-- Turned Zombie Targetting
	if self.IsTurned then
		return IsValid(ent) and ent:GetTargetPriority() == TARGET_PRIORITY_MONSTERINTERACT and ent:IsValidZombie() and !ent.IsTurned and !ent.IsMooBossZombie and ent:Alive() 
	end
	
	return IsValid(ent) and ent:GetTargetPriority() ~= TARGET_PRIORITY_NONE and ent:GetTargetPriority() ~= TARGET_PRIORITY_MONSTERINTERACT and ent:GetTargetPriority() ~= TARGET_PRIORITY_SPECIAL and ent:GetTargetPriority() ~= TARGET_PRIORITY_FUNNY
end
