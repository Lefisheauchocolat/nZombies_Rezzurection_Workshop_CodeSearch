AddCSLuaFile()

ENT.Base = "nz_zombie_walker_moon"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.EyeColorTable = {
	[0] = Material("models/moo/codz/_common/mtl_c_zom_dlchd_zombie_eyes.vmt"),
	[1] = Material("models/moo/codz/_common/mtl_c_zom_dlchd_zombie_eyes_bloat.vmt"),
}

ENT.Models = {
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_1.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_2.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_3.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t7/moon/moo_codz_t7_moon_tech_4.mdl", Skin = 2, Bodygroups = {0,0}},
}
