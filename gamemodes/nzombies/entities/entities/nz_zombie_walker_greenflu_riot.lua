AddCSLuaFile()

ENT.Base = "nz_zombie_walker_greenflu"
ENT.Type = "nextbot"
ENT.PrintName = "Riot Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

if CLIENT then return end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/wavy/wavy_rigs/l4d/common_inf/wavy_zombie_commoninf_riot.mdl", Skin = 5, Bodygroups = {0,0}},
}

local resist = {
	[DMG_BULLET] = true,
}

function ENT:OnTakeDamage(dmginfo)
	local insta = nzPowerUps:IsPowerupActive("insta") -- Don't apply the damage reduction if insta kill is active.
	if resist[dmginfo:GetDamageType()] and !insta then
		dmginfo:ScaleDamage(0.4)
	end
end

-- Franshish :)

-- https://twitter.com/ghostlymoo1/status/1631776813050482688


