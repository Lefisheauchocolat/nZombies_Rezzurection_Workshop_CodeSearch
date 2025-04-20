AddCSLuaFile()

ENT.Base = "nz_zombie_walker_cyborg"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Animatronic"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t7/_custommaps/flipside/moo_codz_t7_endoskeleton.mdl", Skin = 0, Bodygroups = {0,0}}, -- the nazi in question is now an Endo
	
	{Model = "models/wavy/wavy_rigs/fnaf/freddy/wavy_fnaf_zombie_freddy.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/fnaf/bonnie/wavy_fnaf_zombie_bonnie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/fnaf/chica/wavy_fnaf_zombie_chica.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/fnaf/foxy/wavy_fnaf_zombie_foxy.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps-2.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps-3.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps-4.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/slow/deep steps-5.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run-2.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run-3.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run-4.mp3"),
	Sound("nz_moo/zombies/footsteps/_fredricks/fast/run-5.mp3"),
}

-- har har harhar har har harhar harhar
