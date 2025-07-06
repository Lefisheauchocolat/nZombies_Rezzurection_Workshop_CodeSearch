AddCSLuaFile()

ENT.Base = "nz_zombie_walker_exo_3arc"
ENT.Type = "nextbot"
ENT.PrintName = "Police Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo and Wavy"
ENT.Spawnable = true

if CLIENT then
	return 
end -- Client doesn't really need anything beyond the basics

ENT.SpeedBasedSequences = true
ENT.IsMooZombie = true
ENT.RedEyes = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_police_officer.mdl", Skin = 0, Bodygroups = {0,0}},
}

function ENT:SpecialInit()
	if SERVER then
		self:SetHealth( nzRound:GetZombieHealth() * 2 or 75 )
	end
end
