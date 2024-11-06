AddCSLuaFile()

ENT.Base = "nz_zombie_walker_greenflu_c_ci"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.Models = {
	-- Theres like 300+ skins for these fuckers. So I just added code that forces it to pick a random one.

	-- Males
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male02.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_rual01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_military_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_police_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_baggagehandler_01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_tsaagent_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_pilot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_baggagehandler_01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_tsaagent_male01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_male_pilot.mdl", Skin = 0, Bodygroups = {0,0}},

	-- Females
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female01_suit.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_rural01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_rural01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_rural01.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_moo_rerigs/cuba_ci_revision/moo_l4d_common_female_rural01.mdl", Skin = 0, Bodygroups = {0,0}},
}
