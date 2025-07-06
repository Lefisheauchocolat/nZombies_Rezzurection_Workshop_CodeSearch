AddCSLuaFile()

ENT.Base = "nz_zombie_walker_diemachine"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
}
