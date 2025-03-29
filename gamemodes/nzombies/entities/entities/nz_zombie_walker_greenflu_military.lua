AddCSLuaFile()

ENT.Base = "nz_zombie_walker_greenflu"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_ranger.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_ranger.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_ranger.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_ranger.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_ranger.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_military_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police.mdl", Skin = 3, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_police_ext.mdl", Skin = 2, Bodygroups = {0,0}},
	
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_ranger.mdl", Skin = 0, Bodygroups = {0,0}},
}

-- Franshish :)

-- https://twitter.com/ghostlymoo1/status/1631776813050482688


