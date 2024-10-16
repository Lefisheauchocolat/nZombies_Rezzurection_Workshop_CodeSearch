AddCSLuaFile()

ENT.Base = "nz_zombie_walker_origins"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.EyeColorTable = {
	[0] = Material("models/moo/codz/t7_honorguard/mtl_c_zom_dlchd_zombie_eyes.vmt"),
	[1] = Material("models/moo/codz/t7_honorguard/mtl_c_zom_dlchd_zombie_eyes_bloat.vmt"),
	[2] = Material("models/moo/codz/t7_zombies/tomb/mtl_c_t7_zm_dlchd_origins_crusader_head_1.vmt"),
}

ENT.Models = {
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_crusader.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/tomb/moo_codz_t7_tomb_templar.mdl", Skin = 0, Bodygroups = {0,0}},
}

ENT.CustomWalkFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
}

ENT.CustomRunFootstepsSounds = {
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_00.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_01.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_02.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_03.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_04.mp3"),
	Sound("nz_moo/zombies/footsteps/_armored/step_05.mp3"),
}
