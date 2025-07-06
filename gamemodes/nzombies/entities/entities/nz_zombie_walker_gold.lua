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
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_shirtless_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_shirtless_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_shirtless_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_officer_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_officer_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_officer_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_soldier_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_soldier_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/outbreak/moo_codz_t9_zmb_usa_soldier_1.mdl", Skin = 0, Bodygroups = {0,0}},
	
	{Model = "models/moo/_codz_ports/t9/silver/moo_codz_t9_light_body_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/silver/moo_codz_t9_light_body_2_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/silver/moo_codz_t9_light_body_2_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_shirtless_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_shirtless_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_shirtless_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_zmb_gold_charred_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_officer_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_officer_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_officer_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_soldier_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/gold/moo_codz_t9_gold_soldier_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/outbreak/moo_codz_t9_zmb_usa_soldier_1.mdl", Skin = 0, Bodygroups = {0,0}},
	
	{Model = "models/moo/_codz_ports/t9/silver/moo_codz_t9_light_body_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/silver/moo_codz_t9_light_body_2_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t9/silver/moo_codz_t9_light_body_2_2.mdl", Skin = 0, Bodygroups = {0,0}},
}
