AddCSLuaFile()

ENT.Base = "nz_zombie_walker_poolday"
ENT.Type = "nextbot"
ENT.PrintName = "Zombie"
ENT.Category = "Brainz"
ENT.Author = "GhostlyMoo"
ENT.Spawnable = true

if CLIENT then 
	return 
end -- Client doesn't really need anything beyond the basics

ENT.EyeColorTable = {
	[0] = Material("models/moo/codz/codol_zombies/_common/mtl_eyeball_cormack.vmt"),
}

ENT.Models = {
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
	{Model = "models/moo/_codz_ports/codol/juggernaut/moo_codz_codol_marine_zombie.mdl", Skin = 0, Bodygroups = {0,0}},
}

function ENT:StatsInitialize()
	if SERVER then
		local speeds 	= nzRound:GetZombieCoDSpeeds()
		local hp 		= nzRound:GetZombieHealth() * 4

		if speeds then
			self:SetRunSpeed( nzMisc.WeightedRandom(speeds) + math.random(0,35) )
		else
			self:SetRunSpeed( 100 )
		end

		-- I would do scale damage to reduce damage, but increasing the health given works fine.
		self:SetHealth( hp or 75 )
		self.AttackDamage = nzRound:GetZombieDamage() or 50
	end
end
