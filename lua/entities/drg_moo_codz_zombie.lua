if not DrGBase then return end -- return if DrGBase isn't installed
ENT.Base = "drgbase_nextbot" -- DO NOT TOUCH (obviously)

-- Misc --
ENT.PrintName = "Nazi Zombie"
ENT.Category = "Moo CoDZ"
ENT.Models = {
	"models/moo/_codz_ports/t7/honorguard/moo_codz_t7_honorguard.mdl",
	"models/moo/_codz_ports/t7/honorguard/moo_codz_t7_sumpf_honorguard.mdl",
	"models/moo/_codz_ports/t7/honorguard/moo_codz_t7_chaos_honorguard.mdl",
}
ENT.Skins = {0}
ENT.ModelScale = 1
ENT.CollisionBounds = Vector(12, 12, 72)
ENT.BloodColor = BLOOD_COLOR_RED
ENT.RagdollOnDeath = true

-- Stats --
ENT.SpawnHealth = math.random(75,125)
ENT.HealthRegen = 0
ENT.MinPhysDamage = 0
ENT.MinFallDamage = 0

-- Sounds --
ENT.OnSpawnSounds = {}

ENT.IdleSoundDelay = 2
ENT.ClientIdleSounds = false
ENT.OnDamageSounds = {}
ENT.DamageSoundDelay = 0.25
ENT.OnDownedSounds = {}
ENT.Footsteps = {}

-- AI --
ENT.Omniscient = true
ENT.RangeAttackRange = 180
ENT.MeleeAttackRange = 64
ENT.ReachEnemyRange = 50
ENT.AvoidEnemyRange = 0

-- Relationships --
ENT.Factions = {"FACTION_CODZOMBIES"}

-- Locomotion --
ENT.Acceleration = 1000
ENT.Deceleration = 1000
ENT.JumpHeight = 50
ENT.StepHeight = 20
ENT.MaxYawRate = 250
ENT.DeathDropHeight = 200

-- Movements --
ENT.UseWalkframes = true

-- Detection --
ENT.EyeBone = "j_head"
ENT.EyeOffset = Vector(7.5, 0, 5)
ENT.EyeAngle = Angle(0, 0, 0)

-- Possession --
ENT.PossessionEnabled = true
ENT.PossessionPrompt = true
ENT.PossessionCrosshair = false
ENT.PossessionMovement = POSSESSION_MOVE_FORWARD
ENT.PossessionViews = {}
ENT.PossessionBinds = {
	[IN_ATTACK] = {{
		coroutine = true,
		onkeydown = function(self)
				self:PlaySequenceAndMove(self.AttackSequence[math.random(#self.AttackSequence)], 1, self.PossessionFaceForward)
		end
	}},
	[IN_USE] = {{coroutine = true,onkeydown = function(self)
		for k,door in pairs(ents.FindInSphere(self:LocalToWorld(Vector(0,0,75)), 50)) do
			if IsValid(door) and door:GetClass() == "prop_door_rotating" then
				door:Fire("openawayfrom",self:GetName())
			elseif IsValid(door) and string.find(door:GetClass(),"door") 
			and door:GetClass() != "prop_door_rotating" then
				door:Fire("open")
			end
		end
	end}},
	[IN_ATTACK2] = {{
		coroutine = true,
		onkeydown = function(self)
			if self.Busy then return end
			self:PlaySequenceAndMove(self.SideStepSequences[math.random(#self.SideStepSequences)], 1, self.PossessionFaceForward)
		end
	}},
}

-- Moo Zombie Specific Stuff

local spawnslow = {"nz_spawn_ground_v1", "nz_spawn_ground_ad_v2", "nz_spawn_ground_v2", "nz_spawn_ground_v2_altb"}
local spawnrun = {"nz_spawn_ground_v1_run"}
local spawnfast = {"nz_spawn_ground_climbout_fast"}
local spawnsuperfast = {"nz_spawn_ground_quickrise_v1", "nz_spawn_ground_quickrise_v2", "nz_spawn_ground_quickrise_v3"}

local walkattacks = {
	"nz_t8_attack_walk_larm_1",
	"nz_t8_attack_walk_larm_2",
	"nz_t8_attack_walk_rarm_1",
	"nz_t8_attack_walk_rarm_2",
}

local runattacks = {
	"nz_t8_attack_run_larm_1",
	"nz_t8_attack_run_larm_2",
	"nz_t8_attack_run_larm_3",
	"nz_t8_attack_run_larm_4",
	"nz_t8_attack_run_rarm_1",
	"nz_t8_attack_run_rarm_2",
	"nz_t8_attack_run_rarm_3",
	"nz_t8_attack_run_rarm_4",
}

local sprintattacks = {
	"nz_t8_attack_sprint_larm_1",
	"nz_t8_attack_sprint_larm_2",
	"nz_t8_attack_sprint_larm_3",
	"nz_t8_attack_sprint_larm_4",
	"nz_t8_attack_sprint_rarm_1",
	"nz_t8_attack_sprint_rarm_2",
	"nz_t8_attack_sprint_rarm_3",
	"nz_t8_attack_sprint_rarm_4",
}

local supersprintattacks = {
	"nz_t8_attack_supersprint_larm_1",
	"nz_t8_attack_supersprint_larm_2",
	"nz_t8_attack_supersprint_rarm_1",
	"nz_t8_attack_supersprint_rarm_2",
}

ENT.BehindSounds = {
	Sound("nz_moo/zombies/vox/_zhd/behind/behind_00.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/behind/behind_01.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/behind/behind_02.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/behind/behind_03.mp3"),
}

ENT.MonkeySounds = {
	Sound("nz_moo/zombies/vox/monkey/groan_00.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_01.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_02.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_03.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_04.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_05.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_06.mp3"),
	Sound("nz_moo/zombies/vox/monkey/groan_07.mp3"),
}

local walksounds = {
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_1/amb_13.mp3"),

	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_09.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_10.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_11.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_12.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_2/amb_13.mp3"),

	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_00.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_01.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_02.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_03.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_04.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_05.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_06.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_07.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_08.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/amb/series_3/amb_09.mp3"),
}
local runsounds = {
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_1/sprint_00.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_1/sprint_01.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_1/sprint_02.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_1/sprint_03.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_1/sprint_04.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_1/sprint_05.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_1/sprint_06.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_1/sprint_07.mp3"),

	Sound("nz_moo/zombies/vox/_zhd/sprint/series_2/sprint_00.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_2/sprint_01.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_2/sprint_02.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_2/sprint_03.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_2/sprint_04.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_2/sprint_05.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_2/sprint_06.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_2/sprint_07.mp3"),

	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_00.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_01.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_02.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_03.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_04.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_05.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_06.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_07.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_08.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_09.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_10.mp3"),
	Sound("nz_moo/zombies/vox/_zhd/sprint/series_3/sprint_11.mp3"),
}

ENT.AttackSounds = {
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_00.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_01.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_02.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_03.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_04.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_05.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_06.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_07.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_1/attack_08.mp3",

	"nz_moo/zombies/vox/_zhd/attack/series_2/attack_00.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_2/attack_01.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_2/attack_02.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_2/attack_03.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_2/attack_04.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_2/attack_05.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_2/attack_06.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_2/attack_07.mp3",

	"nz_moo/zombies/vox/_zhd/attack/series_3/attack_00.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_3/attack_01.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_3/attack_02.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_3/attack_03.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_3/attack_04.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_3/attack_05.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_3/attack_06.mp3",
	"nz_moo/zombies/vox/_zhd/attack/series_3/attack_07.mp3"
}

ENT.DeathSounds = {
	"nz_moo/zombies/vox/_zhd/death/death_00.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_01.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_02.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_03.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_04.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_05.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_06.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_07.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_08.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_09.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_10.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_11.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_12.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_13.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_14.mp3",
	"nz_moo/zombies/vox/_zhd/death/death_15.mp3"
}

ENT.ElecSounds = {
	"nz_moo/zombies/vox/_classic/elec/elec_00.mp3",
	"nz_moo/zombies/vox/_classic/elec/elec_01.mp3",
	"nz_moo/zombies/vox/_classic/elec/elec_02.mp3",
	"nz_moo/zombies/vox/_classic/elec/elec_03.mp3",
	"nz_moo/zombies/vox/_classic/elec/elec_04.mp3",
	"nz_moo/zombies/vox/_classic/elec/elec_05.mp3"
}

ENT.SequenceTables = {
	{Threshold = 0, Sequences = {
		{
			SpawnSequence = {spawnslow},
			AttackSequence = {walkattacks},
			PassiveSounds = {walksounds},
			MovementSequence = {
				"nz_walk_ad1",
				"nz_walk_ad2",
				"nz_walk_ad3",
				"nz_walk_ad4",
				"nz_walk_ad7",
				"nz_walk_ad5",
				"nz_walk_ad6",
				"nz_walk_ad19",
				"nz_walk_ad20",
				"nz_walk_ad21",
				"nz_walk_ad22",
				"nz_walk_ad23",
				"nz_walk_ad24",
				"nz_walk_ad25",
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
		},
		{
			SpawnSequence = {spawnslow},
			AttackSequence = {walkattacks},
			PassiveSounds = {walksounds},
			MovementSequence = {
				"nz_walk_au1",
				"nz_walk_au2",
				"nz_walk_au3",
				"nz_walk_au4",
				"nz_walk_au5",
				"nz_walk_au6",
				"nz_walk_au7",
				"nz_walk_au8",
				"nz_walk_au10",
				"nz_walk_au11",
				"nz_walk_au12",
				"nz_walk_au13",
				"nz_walk_au15",
				"nz_walk_au20",
				"nz_walk_au21",
				"nz_walk_au23",
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
		}
	}},
	{Threshold = 36, Sequences = {
		{
			SpawnSequence = {spawnrun},
			AttackSequence = {runattacks},
			PassiveSounds = {runsounds},
			MovementSequence = {
				"nz_run_ad1",
				"nz_run_ad2",
				"nz_run_ad3",
				"nz_run_ad4",
				"nz_run_ad7",
				"nz_run_ad8",
				"nz_run_ad11",
				"nz_run_ad12",
				"nz_run_ad14",
				"nz_run_ad20",
				"nz_run_ad21",
				"nz_run_ad22",
				"nz_run_ad23",
				"nz_run_ad24",
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
		},
		{
			SpawnSequence = {spawnrun},
			AttackSequence = {runattacks},
			PassiveSounds = {runsounds},
			MovementSequence = {
				"nz_run_au1",
				"nz_run_au2",
				"nz_run_au3",
				"nz_run_au4",
				"nz_run_au5",
				"nz_run_au9",
				"nz_run_au11",
				"nz_run_au13",
				"nz_run_au20",
				"nz_run_au21",
				"nz_run_au22",
				"nz_run_au23",
				"nz_run_au24",
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
		}
	}},
	{Threshold = 71, Sequences = {
		{
			SpawnSequence = {spawnfast},
			AttackSequence = {sprintattacks},
			PassiveSounds = {runsounds},
			MovementSequence = {
				"nz_sprint_ad1",
				"nz_sprint_ad2",
				"nz_sprint_ad5",
				"nz_sprint_ad21",
				"nz_sprint_ad22",
				"nz_sprint_ad23",
				"nz_sprint_ad24",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
		},
		{
			SpawnSequence = {spawnfast},
			AttackSequence = {sprintattacks},
			PassiveSounds = {runsounds},
			MovementSequence = {
				"nz_sprint_au1",
				"nz_sprint_au2",
				"nz_sprint_au20",
				"nz_sprint_au21",
				"nz_sprint_au22",
				"nz_sprint_au25",
				"nz_fast_sprint_v1",
				"nz_fast_sprint_v2",
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
		}
	}},
	{Threshold = 155, Sequences = {
		{
			SpawnSequence = {spawnsuperfast},
			AttackSequence = {supersprintattacks},
			PassiveSounds = {walksounds},
			MovementSequence = {
				"nz_supersprint_ad1",
				"nz_supersprint_ad2",
				"nz_supersprint_ad3",
				"nz_supersprint_ad4",
				"nz_supersprint_ad5",
				"nz_supersprint_ad6",
				"nz_supersprint_ad7",
				"nz_supersprint_ad8",
				"nz_supersprint_ad9",
				"nz_supersprint_ad10",
				"nz_supersprint_ad11",
				"nz_supersprint_ad12",
				"nz_supersprint_ad13",
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
		},
		{
			SpawnSequence = {spawnsuperfast},
			AttackSequence = {supersprintattacks},
			PassiveSounds = {walksounds},
			MovementSequence = {
				"nz_supersprint_au1",
				"nz_supersprint_au2",
				"nz_supersprint_au3",
				"nz_supersprint_au4",
				"nz_supersprint_au6",
				"nz_supersprint_au8",
				"nz_supersprint_au9",
				"nz_supersprint_au12",
				"nz_supersprint_au20",
				"nz_supersprint_au21",
				"nz_supersprint_au25",
			},
			FireMovementSequence = {
				"nz_firestaff_walk_v1",
				"nz_firestaff_walk_v2",
				"nz_firestaff_walk_v3",
			},
			BlackholeMovementSequence = {
				"nz_blackhole_1",
				"nz_blackhole_2",
				"nz_blackhole_3",
			},
		}
	}}
}

-- Special Sequences --

ENT.DeathSequences = {
	"nz_death_1",
	"nz_death_2",
	"nz_death_3",
	"nz_death_f_1",
	"nz_death_f_2",
	"nz_death_f_3",
	"nz_death_f_4",
	"nz_death_f_5",
	"nz_death_f_6",
	"nz_death_f_7",
	"nz_death_f_8",
	"nz_death_f_9",
	"nz_death_f_10",
	"nz_death_f_11",
	"nz_death_f_12",
	"nz_death_f_13",
}

ENT.ElectrocutionSequences = {
	"nz_death_elec_1",
	"nz_death_elec_2",
	"nz_death_elec_3",
	"nz_death_elec_4",
}

ENT.FireDeathSequences = {
	"nz_firestaff_death_collapse_a",
	"nz_firestaff_death_collapse_b",
	"nz_firestaff_death_collapse_c",
}

ENT.MeleeDeathSequences = {
	"nz_death_falltoknees_1",
	"nz_death_falltoknees_2",
	"nz_death_nerve",
	"nz_death_neckgrab"
}

ENT.SideStepSequences = {
	"nz_dodge_sidestep_left_a",
	"nz_dodge_sidestep_left_b",
	"nz_dodge_sidestep_right_a",
	"nz_dodge_sidestep_right_b",
	"nz_dodge_roll_a",
	"nz_dodge_roll_b",
	"nz_dodge_roll_c",
}

ENT.SparkySequences = {
	"nz_sparky_a",
	"nz_sparky_b",
	"nz_sparky_c",
	"nz_sparky_d",
	"nz_sparky_e",
}

ENT.IdGunSequences = {
	"nz_idgunhole",
}

ENT.UnawareSequences = {
	"nz_unaware_idle",
	"nz_unaware_idle_2",
}

ENT.FreezeSequences = {
	"nz_dth_freeze_1",
	"nz_dth_freeze_2",
	"nz_dth_freeze_3",
}

ENT.DeathRaySequences = {
	"nz_dth_deathray_2",
	"nz_dth_deathray_3",
	"nz_dth_deathray_4",
}

ENT.TauntSequences = {
	"nz_taunt_v1",
	"nz_taunt_v2",
	"nz_taunt_v3",
	"nz_taunt_v4",
	"nz_taunt_v5",
	"nz_taunt_v6",
	"nz_taunt_v7",
	"nz_taunt_v8",
	"nz_taunt_v9"
}

-- Special Sequences --

if SERVER then

	function ENT:CustomInitialize()
		self:SetDefaultRelationship(D_HT)

		self.Busy = false
		self.ShouldDie = false
		self.OnFire = false
		self.BlackholePull = false

		self.TauntChance = 0

		self:SetCooldown("dodgetimer",math.random(5,50))

		self.RunSpeed = math.random(200) 
		self:SpeedChanged() -- My god I fucking yoinked code from my own fucking base.
		self:UpdateModel()

		self.SoundDelayMin = 2
		self.SoundDelayMax = 5
		self.BehindSoundDistance = 200 -- When the zombie is within 200 units of a player, play these sounds instead
		self.DeathRagdollForce = 2000

		-- Use Arms Up or Arms Down Anims?
  		local armsupordown = math.random(100)
  		local arms

  		if armsupordown < 50 then
  			arms = "ad"
  		else
  			arms = "au"
  		end

  		-- Randomly select a speed
  		local speed
  		if self.RunSpeed < 36 then
  			speed = "walk"
  		elseif self.RunSpeed < 71 then
  			speed = "run"
  		elseif self.RunSpeed < 155 then
  			speed = "sprint"
  		else
  			speed = "supersprint"
  		end

  		-- Set the Anims
  		self:SetAttack(self.AttackSequence, true)
   		self.IdleAnimation = "nz_idle_"..arms..""
  		self.WalkAnimation = "nz_walk_"..arms..""..math.random(4)..""
  		self.RunAnimation = self.MovementSequence
	end

  	function ENT:CustomThink()
  		if self:IsDead() then return end
  		self:RemoveAllDecals()
  		local seq = self:GetSequence(self.RunAnimation)
  		local speed = self:GetSequenceGroundSpeed(seq)
  		if !self.Busy and self:OnGround() and self.loco:GetVelocity():Length2D() >= 145 then -- Moo Mark
    		self.loco:SetVelocity(self:GetForward() * speed)
   		end

    	self:AdditionalZombieFunctions()

		if not self.NextSound or self.NextSound < CurTime() and !self.Busy then
			self:Sound()
		end
  	end

  	-- These hooks are called when the nextbot has an enemy (inside the coroutine)
  	function ENT:OnMeleeAttack(enemy)
  		if self.Busy then return end
  		if self.OnFire then return end
		self:PlaySequenceAndMove(self.AttackSequence[math.random(#self.AttackSequence)], 1, self.FaceEnemy)
  	end
  	function ENT:OnRangeAttack(enemy) 
  		if self.Busy then return end
  		if self.OnFire then return end
  		if IsValid(self:GetEnemy()) and !self:GetEnemy():IsPlayer() then return end
		if self:GetCooldown("dodgetimer") <= 0 then
			self:SetCooldown("dodgetimer",math.random(5,50))
			self:DoSpecialAnimation(self.SideStepSequences[math.random(#self.SideStepSequences)])
		end
  	end

  	function ENT:OnChaseEnemy(enemy) end
  	function ENT:OnAvoidEnemy(enemy) end

  	-- These hooks are called while the nextbot is patrolling (inside the coroutine)
  	function ENT:OnReachedPatrol(pos)
  		self.TauntChance = math.random(100)
  		if self.TauntChance <= 25 then
  			self:DoSpecialAnimation(self.TauntSequences[math.random(#self.TauntSequences)])
  		end
    	self:Wait(math.random(3, 7))
  	end 
  	function ENT:OnPatrolUnreachable(pos) end
  	function ENT:OnPatrolling(pos) end

  	-- These hooks are called when the current enemy changes (outside the coroutine)
  	function ENT:OnNewEnemy(enemy) end
  	function ENT:OnEnemyChange(oldEnemy, newEnemy) end
  	function ENT:OnLastEnemy(enemy) end

  	-- Those hooks are called inside the coroutine
  	function ENT:OnSpawn() 
  		ParticleEffect("bo3_zombie_spawn",self:GetPos()+Vector(0,0,1),self:GetAngles(),self)
		self:EmitSound("nz/zombies/spawn/zm_spawn_dirt"..math.random(1,2)..".wav",80,math.random(95,105))

		local seq = self:SelectSpawnSequence()
		self:DoSpecialAnimation(seq)
  	end

  	function ENT:OnIdle()
    	self:AddPatrolPos(self:RandomPos(1500))
  	end

  	function ENT:OnUpdateAnimation()
		if self:IsDead() then return end
		if self.Busy then return end
		if self:IsRunning() then return self.RunAnimation, self.RunAnimRate
		elseif self:IsMoving() then return self.WalkAnimation, self.WalkAnimRate
		else return self.IdleAnimation, self.IdleAnimRate end
	end

  	-- Called outside the coroutine
  	function ENT:OnTakeDamage(dmg, hitgroup)
    	self:SpotEntity(dmg:GetAttacker())
  	end
  	function ENT:OnFatalDamage(dmg, hitgroup) end
  
  	-- Called inside the coroutine
  	function ENT:OnTookDamage(dmg, hitgroup) 
  		if self.Busy then return end
  		if dmg:GetDamage() == 75 and dmg:IsDamageType(DMG_MISSILEDEFENSE) then
  			self:DoSpecialAnimation("nz_slipslide_collapse")
  		end
  		if dmg:IsDamageType(DMG_BURN) and self:Health() < 25 and !self.OnFire then -- Set on fire when you're about to die
  			self.OnFire = true
  			self.WalkAnimation = self.FireMovementSequence
  			self.RunAnimation = self.FireMovementSequence
  			self:Ignite(300, 0)
  		end
  		if self.BO4IsFrozen and self:BO4IsFrozen() then
  			self.ShouldDie = true
  			self:DoSpecialAnimation(self.FreezeSequences[math.random(#self.FreezeSequences)])
  		end
  	end

  	function ENT:OnDeath(dmg, hitgroup)
  		if self:RagdollForceTest(dmg:GetDamageForce()) or dmg:GetDamageType() == DMG_MISSILEDEFENSE or dmg:GetDamageType() == DMG_ENERGYBEAM or self.Busy then
  			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
  			self:BecomeRagdoll(dmg)
  		elseif dmg:GetDamageType() == DMG_SHOCK or dmg:GetDamageType() == DMG_DISSOLVE then
  			self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)], 90, math.random(85, 105), 1, 2)
  			self:PlaySequenceAndMove(self.ElectrocutionSequences[math.random(#self.ElectrocutionSequences)])
  		elseif (dmg:GetDamageType() == DMG_BURN or dmg:GetDamageType() == DMG_SLOWBURN) and self.OnFire then
  			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, 45, 1, 2)
  			self:PlaySequenceAndMove(self.FireDeathSequences[math.random(#self.FireDeathSequences)])
  		elseif dmg:GetDamageType() == DMG_SLASH then
			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
			self:PlaySequenceAndMove(self.MeleeDeathSequences[math.random(#self.MeleeDeathSequences)])
  		else
  			self:PlaySound(self.DeathSounds[math.random(#self.DeathSounds)], 90, math.random(85, 105), 1, 2)
  			self:PlaySequenceAndMove(self.DeathSequences[math.random(#self.DeathSequences)])
  		end
  	end

  	function ENT:OnDowned(dmg, hitgroup) end

  	function ENT:HandleAnimEvent(a,b,c,d,e)
		if e == "melee" then
			self:EmitSound(self.AttackSounds[math.random(#self.AttackSounds)], 100, math.random(85, 105), 1, 2)
			self:Attack({
				damage = 20,
				type = DMG_SLASH,
				viewpunch = Angle(20, math.random(-1, 1), 0),
			}, 
			function(self, hit)
				if #hit > 0 then
					self:EmitSound( "nz_moo/zombies/plr_impact/_zhd/evt_zombie_hit_player_0"..math.random(0,5)..".mp3", SNDLVL_TALKING, math.random(95,105))
				end
			end)
		end
	end

	--[[function ENT:OnLandOnGround()
		if self:IsDead() or self.Busy then return end
		self:CICO(function(self)
				self:PlaySequenceAndMove("nz_traverse_jump_land")
		end)
	end]]

  	function ENT:CICO(callback)
		local oldThread = self.BehaveThread
		self.BehaveThread = coroutine.create(function()
			callback(self)
			self.BehaveThread = oldThread
		end)
	end
end

if SERVER then

	function ENT:GetPath()
	if not self._DrGBasePath then
		self._DrGBasePath = Path("Follow")
		self._DrGBasePath:SetMinLookAheadDistance(10)
		return self._DrGBasePath
	else return self._DrGBasePath end
	end

	function ENT:AdditionalZombieFunctions()
		if self.Busy then return end
    	if self.BO4IsShocked and self:BO4IsShocked() or self.BO4IsScorped and self:BO4IsScorped() or self.BO4IsSpinning and self:BO4IsSpinning() or self:GetNW2Bool("OnAcid") then
  			self:DoSpecialAnimation(self.SparkySequences[math.random(#self.SparkySequences)])
  		end
    	if self.BO3IsSlipping and self:BO3IsSlipping() then
  			self:DoSpecialAnimation("nz_slipslide_collapse")
  		end
    	if self.BO3IsPulledIn and self:BO3IsPulledIn() then
  			self:DoSpecialAnimation(self.IdGunSequences[math.random(#self.IdGunSequences)])
  		end
		if self.BO3IsMystified and self:BO3IsMystified() then
			self:DoSpecialAnimation(self.UnawareSequences[math.random(#self.UnawareSequences)])
		end
		if self.BO3IsSkullStund and self:BO3IsSkullStund() then
			self:DoSpecialAnimation(self.DeathRaySequences[math.random(#self.DeathRaySequences)])
		end
  		if IsValid(self:GetEnemy()) and self:GetEnemy():GetClass() == "bo3_tac_gersch" and !self.BlackholePull then
  			self.BlackholePull = true
  			self.RunAnimation = self.BlackholeMovementSequence
  		end
  		if self.BlackholePull and IsValid(self:GetEnemy()) and self:GetEnemy():GetClass() ~= "bo3_tac_gersch" then
  			self.BlackholePull = false
  			self.RunAnimation = self.MovementSequence
  		end
  		self:IsMovingIntoObject()
	end

	function ENT:DoSpecialAnimation(seq)
		self:CICO(function(self)
			self.Busy = true
			self:PlaySequenceAndMove(seq)
			if self.ShouldDie then
  				self:Wait(666) -- Die bitch
  			else
  				self.Busy = false
  			end
		end)
	end

	function ENT:UpdateModel()
		for i,v in ipairs(self:GetBodyGroups()) do
			self:SetBodygroup( i-1, math.random(0, self:GetBodygroupCount(i-1) - 1))
		end
	end

	function ENT:SpeedChanged()
		self:UpdateMovementSequences()
	end

	function ENT:SelectSpawnSequence()
		local s
		if self.SpawnSounds then s = self.SpawnSounds[math.random(#self.SpawnSounds)] end
		return type(self.SpawnSequence) == "table" and self.SpawnSequence[math.random(#self.SpawnSequence)] or self.SpawnSequence, s
	end

	function ENT:PlaySound(s, lvl, pitch, vol, chan, delay) --Moo Mark This part is a port of the nZu zombie base sound functions.
		local delay = delay or math.Rand(self.SoundDelayMin, self.SoundDelayMax)
		if s then
			local dur = SoundDuration(s)
			self:EmitSound(s, lvl, pitch, vol, chan)
			delay = delay + dur
		end
		self.NextSound = CurTime() + delay
	end

	function ENT:Sound()
		if self.BehindSoundDistance > 0 -- We have enabled behind sounds
			and IsValid(self:GetEnemy())
			and self:GetEnemy():IsPlayer() -- We have a target and it's a player within distance
			and self:GetRangeTo(self:GetEnemy()) <= self.BehindSoundDistance
			and (self:GetEnemy():GetPos() - self:GetPos()):GetNormalized():Dot(self:GetEnemy():GetAimVector()) >= 0 then -- If the direction towards the player is same 180 degree as the player's aim (away from the zombie)
				self:PlaySound(self.BehindSounds[math.random(#self.BehindSounds)], 100, math.random(80, 110), 1, 2) -- Play the behind sound, and a bit louder!
	
		elseif self.BO4IsShocked and self:BO4IsShocked() or self.BO4IsScorped and self:BO4IsScorped() or self.BO4IsSpinning and self:BO4IsSpinning() then
			self:PlaySound(self.ElecSounds[math.random(#self.ElecSounds)],94, math.random(80, 110), 1, 2)
		elseif IsValid(self:GetEnemy()) and self:GetEnemy():GetClass() == "bo3_tac_monkeybomb" then
			self:PlaySound(self.MonkeySounds[math.random(#self.MonkeySounds)], 100, math.random(80, 110), 1, 2)
		elseif self.PassiveSounds then
			self:PlaySound(self.PassiveSounds[math.random(#self.PassiveSounds)],95, math.random(80, 110), 1, 2)
		else
			-- We still delay by max sound delay even if there was no sound to play
			self.NextSound = CurTime() + self.SoundDelayMax
		end
	end

	function ENT:UpdateMovementSequences()
		if self.SequenceTables then
			local t
			for k,v in pairs(self.SequenceTables) do
				if v.Threshold and v.Threshold > self.RunSpeed then break end
				t = v
			end
			if t then
				local seqs = t.Sequences[1] and t.Sequences[math.random(#t.Sequences)] or t.Sequences -- If Sequences is a numerical table, pick a random one (supports random selection)
				for k,v in pairs(seqs) do
					self[k] = v[math.random(#v)] -- Pick a random entry
				end
			end
		end
	end

	function ENT:RagdollForceTest(force)
		if force == nil then return nil end
		return self.DeathRagdollForce^2 <= force:LengthSqr()
	end

	function ENT:GetCenterBounds()
    	local mins = self:OBBMins()
    	local maxs = self:OBBMaxs()
    	mins[3] = mins[3] / 2
    	maxs[3] = maxs[3] / 2

    	return {["mins"] = mins, ["maxs"] = maxs}
	end

	function ENT:TraceSelf(start, endpos, dont_adjust, line_trace) -- Creates a hull trace the size of ourself, handy if you'd want to know if we'd get stuck from a position offset
    	local bounds = self:GetCenterBounds()

    	if !dont_adjust then
        	start = start and start + self:OBBCenter() / 1.01 or self:GetPos() + self:OBBCenter() / 2
    	end

    	debugoverlay.Box(start, bounds.mins, bounds.maxs, 0, Color(255,0,0,55))

    	if endpos then
        	if !dont_adjust then
            	endpos = endpos + self:OBBCenter() / 1.01
        	end

        	debugoverlay.Box(endpos, bounds.mins, bounds.maxs, 0, Color(255,0,0,55))
    	end

    	local tbl = {
        	start = start,
        	endpos = endpos or start,
        	filter = self,
        	mins = bounds.mins,
        	maxs = bounds.maxs,
        	collisiongroup = self:GetCollisionGroup(),
        	mask = MASK_NPCSOLID
    	}

    	return !line_trace and util.TraceHull(tbl) or util.TraceLine(tbl)
	end

	function ENT:IsMovingIntoObject()
    
    	local bounds = self:GetCenterBounds()
    	local stuck_tr = self:TraceSelf()
    	local startpos = self:GetPos() + self:OBBCenter() / 2
    	local endpos = startpos + self:GetForward() * 10
    	local tr = stuck_tr.Hit and stuck_tr or util.TraceHull({
        	["start"] = startpos,
        	["endpos"] = endpos,
        	["filter"] = self,
        	["mins"] = bounds.mins,
        	["maxs"] = bounds.maxs,
        	["collisiongroup"] = self:GetCollisionGroup(),
        	["mask"] = MASK_SOLID
    	})

    	local ent = tr.Entity
		if tr.Hit then 
			for k,v in pairs(ents.FindAlongRay(self:EyePos() + (self:GetForward() * 10), self:GetForward(), bounds.mins, bounds.maxs)) do
				for k,door in pairs(ents.FindInSphere(self:LocalToWorld(Vector(0,0,75)), 50)) do
					if IsValid(door) and door:GetClass() == "prop_door_rotating" then
						door:Fire("openawayfrom",self:GetName())
					elseif IsValid(door) and string.find(door:GetClass(),"door") and door:GetClass() != "prop_door_rotating" then
						door:Fire("open")
					end
				end
			end
		end
    	if IsValid(ent) and (ent:IsPlayer() or ent:IsScripted()) then return false end

    	return tr.Hit
	end
end

if CLIENT then

	function ENT:CustomDraw()
		self:DrawModel()
		if not self:IsDead() then
			self:DrawEyeGlow() 
		end
	end
	function ENT:DrawEyeGlow()
		local eyeColor = Color(255,0,0)
		local eyeglow =  Material("nz_moo/sprites/moo_glow1")
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
end

-- DO NOT TOUCH --
AddCSLuaFile()
DrGBase.AddNextbot(ENT)