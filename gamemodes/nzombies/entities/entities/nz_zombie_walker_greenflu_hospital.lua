AddCSLuaFile()

ENT.Base = "nz_zombie_walker_greenflu"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_female_nurse.mdl", Skin = 4, Bodygroups = {0,0}},

	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_patient.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_surgeon.mdl", Skin = 4, Bodygroups = {0,0}},
}

-- Franshish :)

-- https://twitter.com/ghostlymoo1/status/1631776813050482688


