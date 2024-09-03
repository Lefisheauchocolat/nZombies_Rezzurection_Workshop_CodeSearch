AddCSLuaFile()

ENT.Base = "nz_zombie_walker_jup"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.EyeColorTable = {
	[0] = Material("models/moo/codz/t10_zombies/jup/xmaterial_e739cc7eabf07b.vmt"),
}

ENT.Models = {
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_male.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_female.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_male.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_female.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_male.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_female.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_male.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_female.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_male.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_female.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_male.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_female.mdl", Skin = 0, Bodygroups = {0,0}},
}
