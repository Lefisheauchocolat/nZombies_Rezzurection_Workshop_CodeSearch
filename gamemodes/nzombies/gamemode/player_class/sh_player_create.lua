DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

--
-- See gamemodes/base/player_class/player_default.lua for all overridable variables
--
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 400
PLAYER.CanUseFlashlight     = true

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Bool", 0, "UsingSpecialWeapon")
	self.Player:NetworkVar("Entity", 0, "TeleporterEntity")
end

function PLAYER:Init()
	-- Don't forget Colours
	-- This runs when the player is first brought into the game
	-- print("create")
end

function PLAYER:Loadout()

	-- Creation Tools
	self.Player:Give( "weapon_physgun" )
	self.Player:Give( "weapon_hands" )
	self.Player:Give( "nz_multi_tool" )
	
	timer.Simple(0.1, function()
		if IsValid(self.Player) then
			if !self.Player:HasWeapon( "weapon_physgun" ) then
				self.Player:Give( "weapon_physgun" )
			end
			if !self.Player:HasWeapon( "weapon_hands" ) then
				self.Player:Give( "weapon_hands" )
			end
			if !self.Player:HasWeapon( "nz_multi_tool" ) then
				self.Player:Give( "nz_multi_tool" )
			end
		end
	end)

end

local cvar_bleedout = GetConVar("nz_downtime")
local cvar_revive = GetConVar("nz_revivetime")
local cvar_perkmax = GetConVar("nz_difficulty_perks_max")

function PLAYER:Spawn()
	-- if we are in create or debuging make zombies target us
	if nzRound:InState(ROUND_CREATE) or GetConVar( "nz_zombie_debug" ):GetBool() then --TODO this is bullshit?
		self.Player:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		self.Player:SetHealth(nzMapping.Settings.hp or 100)
		self.Player:SetMaxHealth(nzMapping.Settings.hp or 100)
		self.Player:AllowFlashlight(true)
	end
	self.Player:SetUsingSpecialWeapon(false)

	self.Player:SetBleedoutTime(cvar_bleedout:GetFloat())
	self.Player:SetReviveTime(cvar_revive:GetFloat())
	self.Player:SetMaxPerks(cvar_perkmax:GetInt())
end

player_manager.RegisterClass( "player_create", PLAYER, "player_default" )
