AddCSLuaFile()

ENT.Base = "nz_zombie_walker_prototype"
ENT.Type = "nextbot"
ENT.Category = "Brainz"
ENT.PrintName = "Zombie"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 8, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 9, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 10, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 11, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 12, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 13, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 14, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 15, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 8, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 9, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 10, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 11, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 12, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 13, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 14, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_honorguard.mdl", Skin = 15, Bodygroups = {0,0}},

	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 8, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 9, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 10, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 11, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 12, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 13, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 14, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 15, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 8, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 9, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 10, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 11, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 12, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 13, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 14, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_ger_waffen.mdl", Skin = 15, Bodygroups = {0,0}},
}

function ENT:SpecialInit() 
	for i,v in ipairs(self:GetBodyGroups()) do
		self:SetBodygroup( i-1, math.random(0, self:GetBodygroupCount(i-1) - 1))
	end
end