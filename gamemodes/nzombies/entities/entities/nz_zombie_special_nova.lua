AddCSLuaFile()

ENT.Base = "nz_zombiebase_moo"
ENT.Type = "nextbot"
ENT.PrintName = "Nova Crawler"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then
	function ENT:PostDraw()
		self:EffectsAndSounds()
	end
	function ENT:EffectsAndSounds()
		if self:Alive() then
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !self.Draw_FX:IsValid()) then
				self.Draw_FX = CreateParticleSystem(self, "zmb_gas_trail", PATTACH_POINT_FOLLOW, 2)
			end
		end
	end
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = false
ENT.IsMooSpecial = true
ENT.MooSpecialZombie = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t5/quad/moo_codz_t5_quad_crawler.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.DeathSequences = {
	"nz_base_quad_death_01",
	"nz_base_quad_death_02",
	"nz_base_quad_death_03",
	"nz_base_quad_death_04",
	"nz_base_quad_death_05",
	"nz_base_quad_death_06",
}

ENT.ElectrocutionSequences = {
	"nz_base_quad_death_tesla_01",
	"nz_base_quad_death_tesla_02",
	"nz_base_quad_death_tesla_03",
	"nz_base_quad_death_tesla_04",
}

ENT.BarricadeTearSequences = {
	--Leave this empty if you don't intend on having a special enemy use tear anims.
}

local spawnslow = {"nz_base_quad_traverse_ground_slow"}
local spawnfast = {"nz_base_quad_traverse_ground_fast"}

local AttackSequences = {
	{seq = "nz_base_quad_attack_01"},
	{seq = "nz_base_quad_attack_02"},
	{seq = "nz_base_quad_attack_03"},
	{seq = "nz_base_quad_attack_04"},
	{seq = "nz_base_quad_attack_05"},
	{seq = "nz_base_quad_attack_06"},
	{seq = "nz_base_quad_attack_double_01"},
	{seq = "nz_base_quad_attack_double_02"},
	{seq = "nz_base_quad_attack_double_03"},
	{seq = "nz_base_quad_attack_double_04"},
	{seq = "nz_base_quad_attack_double_05"},
	{seq = "nz_base_quad_attack_double_06"},
}

local SprintAttackSequences = {
	{seq = "nz_base_quad_attack_leap_01"},
}

local JumpSequences = {
	{seq = "nz_barricade_crawl_1"},
	{seq = "nz_barricade_crawl_2"},
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_01.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_02.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_03.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_04.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_05.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_06.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_07.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_08.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_09.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_10.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/amb/quad_ambient_11.mp3"),
}

ENT.IdleSequence = "nz_base_quad_idle_01"
ENT.IdleSequenceAU = "nz_base_quad_idle_02"
ENT.NoTargetIdle = "nz_base_quad_idle_02"

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			MovementSequence = {
				"nz_base_quad_crawl_01",
				"nz_base_quad_crawl_02",
				"nz_base_quad_crawl_03",
			},
			LowgMovementSequence = {
				"nz_base_quad_crawl_moon_01",
				"nz_base_quad_crawl_moon_02",
			},
			BlackholeMovementSequence = {
				"nz_base_quad_blackhole_crawl_slow_01",
				"nz_base_quad_blackhole_crawl_slow_02",
			},
			CrawlMovementSequence = {
				"nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",
			},
			SpawnSequence = {spawnslow},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 36, Sequences = {
		{
			MovementSequence = {
				"nz_base_quad_crawl_run_01",
				"nz_base_quad_crawl_run_02",
				"nz_base_quad_crawl_run_03",
				"nz_base_quad_crawl_run_04",
				"nz_base_quad_crawl_run_05",
			},
			LowgMovementSequence = {
				"nz_base_quad_crawl_run_moon_01",
				"nz_base_quad_crawl_run_moon_02",
				"nz_base_quad_crawl_run_moon_03",
				"nz_base_quad_crawl_run_moon_04",
				"nz_base_quad_crawl_run_moon_05",
			},
			BlackholeMovementSequence = {
				"nz_base_quad_blackhole_crawl_fast_01",
				"nz_base_quad_blackhole_crawl_fast_02",
			},
			CrawlMovementSequence = {
				"nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",
			},
			SpawnSequence = {spawnfast},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 71, Sequences = {
		{
			MovementSequence = {
				"nz_base_quad_crawl_sprint_01",
				"nz_base_quad_crawl_sprint_02",
				"nz_base_quad_crawl_sprint_03",
			},
			LowgMovementSequence = {
				"nz_base_quad_crawl_sprint_moon_01",
				"nz_base_quad_crawl_sprint_moon_02",
				"nz_base_quad_crawl_sprint_moon_03",
			},
			BlackholeMovementSequence = {
				"nz_base_quad_blackhole_crawl_fast_01",
				"nz_base_quad_blackhole_crawl_fast_02",
			},
			CrawlMovementSequence = {
				"nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",
			},
			SpawnSequence = {spawnfast},
			AttackSequences = {AttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
	{Threshold = 155, Sequences = {
		{
			MovementSequence = {
				"nz_base_quad_crawl_supersprint_01",
			},
			LowgMovementSequence = {
				"nz_base_quad_crawl_sprint_moon_01",
				"nz_base_quad_crawl_sprint_moon_02",
				"nz_base_quad_crawl_sprint_moon_03",
			},
			BlackholeMovementSequence = {
				"nz_base_quad_blackhole_crawl_fast_01",
				"nz_base_quad_blackhole_crawl_fast_02",
			},
			CrawlMovementSequence = {
				"nz_crawl_slow_v1",
				"nz_crawl_slow_v2",
				"nz_crawl_slow_v3",
				"nz_crawl_on_hands",
				"nz_crawl_on_hands_c",
			},
			SpawnSequence = {spawnfast},
			StandAttackSequences = {AttackSequences},
			AttackSequences = {SprintAttackSequences},
			JumpSequences = {JumpSequences},
			PassiveSounds = {walksounds},
		},
	}},
}

ENT.ZombieLandSequences = {
	"nz_base_quad_traverse_land", 
}

ENT.LowCeilingDropSpawnSequences = {
	"nz_base_quad_traverse_wall_l",
}

ENT.HighCeilingDropSpawnSequences = {
	"nz_base_quad_traverse_wall_h",
}

ENT.TauntSequences = {
	"nz_base_quad_taunt_01",
	"nz_base_quad_taunt_02",
	"nz_base_quad_taunt_03",
	"nz_base_quad_taunt_04",
	"nz_base_quad_taunt_05",
	"nz_base_quad_taunt_06",
}

ENT.LongPhaseSequences = {
	"nz_base_quad_phaseforward_long_01",
	--"nz_base_quad_phaseforward_long_02",
	"nz_base_quad_phaseleft_long_01",
	--"nz_base_quad_phaseleft_long_02",
	"nz_base_quad_phaseright_long_01",
	--"nz_base_quad_phaseright_long_02",
}

ENT.ShortPhaseSequences = {
	"nz_base_quad_phaseforward_short_01",
	--"nz_base_quad_phaseforward_short_02",
	"nz_base_quad_phaseleft_short_01",
	--"nz_base_quad_phaseleft_short_02",
	"nz_base_quad_phaseright_short_01",
	--"nz_base_quad_phaseright_short_02",
}

ENT.SparkySequences = {
	"nz_base_quad_stunned_electrobolt",
	"nz_base_quad_stunned_electrobolt",
	"nz_base_quad_stunned_electrobolt",
	"nz_base_quad_stunned_electrobolt",
	"nz_base_quad_stunned_electrobolt",
	"nz_base_quad_stunned_electrobolt",
	"nz_base_quad_stunned_electrobolt",
	"nz_base_quad_stunned_electrobolt",
	"nz_base_quad_stunned_electrobolt",
}

ENT.UnawareSequences = {
	"nz_base_quad_idle_02",
	"nz_base_quad_idle_02",
	"nz_base_quad_idle_02",
	"nz_base_quad_idle_02",
}

ENT.FreezeSequences = {
	"nz_base_quad_death_freeze_01",
	"nz_base_quad_death_freeze_02",
	"nz_base_quad_death_freeze_01",
	"nz_base_quad_death_freeze_02",
}

ENT.IceStaffSequences = {
	"nz_base_quad_death_freeze_01",
	"nz_base_quad_death_freeze_02",
	"nz_base_quad_death_freeze_01",
	"nz_base_quad_death_freeze_02",
	"nz_base_quad_death_freeze_01",
	"nz_base_quad_death_freeze_02",
	"nz_base_quad_death_freeze_01",
	"nz_base_quad_death_freeze_02",
}

ENT.ThunderGunSequences = {
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
}

ENT.SlipGunSequences = {
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
	"nz_base_quad_knockdown_facedown_blend",
	"nz_base_quad_knockdown_faceup_blend",
}

ENT.MicrowaveSequences = {
	"nz_base_quad_death_microwave_01",
	"nz_base_quad_death_microwave_02",
	"nz_base_quad_death_microwave_03",
}

ENT.CrawlBlackHoleDeathSequences = {
	"nz_base_quad_death_blackhole_01",
	"nz_base_quad_death_blackhole_02",
	"nz_base_quad_death_blackhole_01",
	"nz_base_quad_death_blackhole_02",
	"nz_base_quad_death_blackhole_01",
	"nz_base_quad_death_blackhole_02",
}

ENT.BlackHoleDeathSequences = {
	"nz_base_quad_death_blackhole_01",
	"nz_base_quad_death_blackhole_02",
	"nz_base_quad_death_blackhole_01",
	"nz_base_quad_death_blackhole_02",
	"nz_base_quad_death_blackhole_01",
	"nz_base_quad_death_blackhole_02",
}

ENT.DeathSounds = {
	Sound("nz_moo/zombies/vox/_quad/_classic/death/quad_death_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/death/quad_death_01.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/death/quad_death_02.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/death/quad_death_03.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/death/quad_death_04.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/death/quad_death_05.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/death/quad_death_06.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/death/quad_death_07.mp3"),
}

ENT.AttackSounds = {
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_01.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_02.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_03.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_04.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_05.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_06.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_07.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_08.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/attack/quad_attack_09.mp3"),
}

ENT.SpawnStingSounds = {
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/tell/quad_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/tell/quad_01.mp3"),
}

ENT.SpawnSounds = {
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_03.mp3"),
}

ENT.TauntSounds = {
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_03.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_03.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_03.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_00.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_01.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_02.mp3"),
	Sound("nz_moo/zombies/vox/_quad/_classic/spawn/quad_spawn_03.mp3"),
}

ENT.BehindSoundDistance = 0

function ENT:StatsInitialize()
	if SERVER then
		local speeds = nzRound:GetZombieCoDSpeeds()
		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 100 )
		end
		self:SetHealth( nzRound:GetZombieHealth() or 75 )

		self:SetCollisionBounds(Vector(-6,-6, 0), Vector(6, 6, 45))
		self:SetSurroundingBounds(Vector(-32, -32, 0), Vector(32, 32, 56))

		self.Exploded = false

		self.MoonBehaviour = false
		self.PhaseCooldown = CurTime() + 1
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

	self:EmitSound(self.SpawnSounds[math.random(#self.SpawnSounds)], 85, math.random(85,105))
	self:EmitSound(self.SpawnStingSounds[math.random(#self.SpawnStingSounds)], 577, math.random(95,105))

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

		ParticleEffect("zmb_zombie_spawn_dirt",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz_moo/zombies/spawn/_generic/dirt/dirt_0"..math.random(0,2)..".mp3",100,math.random(95,105))
	end

	if IsValid(self.SpawnIndex) then
		if stype == 11 or stype == 1 then
			animation = "idle"
			if IsValid(self) then
				self:EmitSound("nz_moo/effects/teleport_in_00.mp3", 100)
				if IsValid(self) then ParticleEffect("panzer_spawn_tp", self:GetPos() + Vector(0,0,20), Angle(0,0,0), self) end
			end
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

function ENT:AI()

	-- Moon Teleporting(Makes these fuckers be little shits.)
	if self.MoonBehaviour and self:TargetInRange(500) and !self.AttackIsBlocked and CurTime() > self.PhaseCooldown then
		if !self:IsFacingEnt(self:GetTarget()) then return end
		if self:TargetInRange(70) then return end
		if IsValid(self:GetTarget()) and self:GetTarget():IsPlayer() then
			local seq = self.LongPhaseSequences[math.random(#self.LongPhaseSequences)]

			if !self:SequenceHasSpace(seq) then
				seq = self.ShortPhaseSequences[math.random(#self.ShortPhaseSequences)]
			end
						
			if self:SequenceHasSpace(seq) and self:HasSequence(seq) then
				self:DoSpecialAnimation(seq, true, true)
			end
			self.PhaseCooldown = CurTime() + 3.15
		end
	end

	if self:GetRunSpeed() < 125 and !self.IsMooSpecial and nzRound:InProgress() and nzRound:GetNumber() >= 4 and !nzRound:IsSpecial() and nzRound:GetZombiesKilled() >= nzRound:GetZombiesMax() - 3 then
		if self:GetCrawler() then return end
		self.LastZombieMomento = true
	end
	if self.LastZombieMomento and !self:GetSpecialAnimation() --[[and !self.ZCTGiveGreenStats]] then
		--print("Uh oh Mario, I'm about to beat your fucking ass lol.")
		self.LastZombieMomento = false
		self:SetRunSpeed(100)
		self:SpeedChanged()
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
	if IsValid(self.Target) and self.Target.BHBomb and !self.IsMooSpecial then
		if self.DeathSounds then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		end
		if self:GetCrawler() then
			self:DoDeathAnimation(self.CrawlBlackHoleDeathSequences[math.random(#self.CrawlBlackHoleDeathSequences)])
		else
			self:DoDeathAnimation(self.BlackHoleDeathSequences[math.random(#self.BlackHoleDeathSequences)])
		end
	end
	if self.DeathRagdollForce == 0 or self:GetSpecialAnimation() then
		if self.DeathSounds then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
		end
		self:BecomeRagdoll(dmginfo)
	else
		if self:RagdollForceTest(dmginfo:GetDamageForce()) then
			if self.DeathSounds then
				self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			end
			self:BecomeRagdoll(dmginfo)
		elseif damagetype == DMG_SHOCK then
			if self.ElecSounds then
				self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)], 90, math.random(85, 105), 1, 2)
			end
			self:DoDeathAnimation(self.ElectrocutionSequences[math.random(#self.ElectrocutionSequences)])
		else
			if self.DeathSounds then
				self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			end
			self:DoDeathAnimation(self.DeathSequences[math.random(#self.DeathSequences)])
		end
	end
end

function ENT:PostDeath(dmginfo)
	if math.random(2) == 2 then
		if self.Exploded then return end
		self.Exploded = true -- Prevent a possible infinite loop that causes crashes.
		--print("Stinky Child... Gross")
		local fuckercloud = ents.Create("nova_gas_cloud")
		fuckercloud:SetPos(self:GetPos())
		fuckercloud:SetAngles(Angle(0,0,0))
		fuckercloud:Spawn()
	end
end

function ENT:CustomAnimEvent(a,b,c,d,e) 
	if e == "no_gas" then
		self.Exploded = true
	end
	if e == "quad_portal" then
		if IsValid(self) then
			local mainroot = self:GetBonePosition(self:LookupBone("j_mainroot"))

			self:EmitSound("nz_moo/effects/teleport_in_00.mp3", 100)
			if IsValid(self) then ParticleEffect("panzer_spawn_tp", mainroot, Angle(0,0,0), self) end
		end
	end
	if e == "quad_phase_in" then
		self:EmitSound("nz_moo/zombies/vox/_quad/_classic/phase_in.mp3", 100)
		if IsValid(self) then ParticleEffectAttach("zmb_quad_teleport", 3, self, 2) end
		self:SetMaterial("invisible")
		--self:SetNoDraw(true)
	end
	if e == "quad_phase_out" then
		--self:SetNoDraw(false)
		self:SetMaterial("")
		self:EmitSound("nz_moo/zombies/vox/_quad/_classic/phase_out.mp3", 100)
		if IsValid(self) then ParticleEffectAttach("zmb_quad_teleport", 3, self, 2) end
	end
end
