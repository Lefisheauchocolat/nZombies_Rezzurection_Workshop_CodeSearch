AddCSLuaFile()

ENT.Base = "nz_zombie_walker_exo_3arc"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
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
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_1_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_1_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_2_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_2_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_3_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_3_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_4_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_4_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_5_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_male_5_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_1_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_1_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_2_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_2_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_3_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_3_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_4_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_4_2.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_5_1.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_5_2.mdl", Skin = 0, Bodygroups = {0,0}},
}

-- So we can identify if we can use the female zombie sounds or not.
ENT.Females = {
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_1_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_1_2.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_2_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_2_2.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_3_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_3_2.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_4_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_4_2.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_5_1.mdl",
	"models/moo/_codz_ports/iw7/park/moo_codz_iw7_park_female_5_2.mdl",
}

function ENT:SpecialInit()
	for _,model in pairs(self.Females) do
		if model == self:GetModel() then
			self.MinSoundPitch 	= 110
			self.MaxSoundPitch 	= 135
		end
	end
end