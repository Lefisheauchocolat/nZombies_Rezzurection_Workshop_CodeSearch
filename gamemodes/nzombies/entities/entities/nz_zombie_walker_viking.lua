AddCSLuaFile()

ENT.Base = "nz_zombie_walker_ugx"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

ENT.Models = {
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_4.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_3.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/t5/cosmodrome/moo_codz_t5_rus_cosmodrome_4.mdl", Skin = 0, Bodygroups = {0,0}},
}

function ENT:SpecialInit() 
	if self:GetBodygroup(1) == 2 then self:SetBodygroup(1,math.random(0,1)) end
end