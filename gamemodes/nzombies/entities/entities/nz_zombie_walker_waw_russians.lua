AddCSLuaFile()

ENT.Base = "nz_zombie_walker_derriese"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 6, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 1, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 2, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 3, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 4, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 5, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t4/moo_codz_t4_rus_guard.mdl", Skin = 6, Bodygroups = {0,0}},
}

function ENT:SpecialInit() 
	for i,v in ipairs(self:GetBodyGroups()) do
		self:SetBodygroup( i-1, math.random(0, self:GetBodygroupCount(i-1) - 1))
	end
end