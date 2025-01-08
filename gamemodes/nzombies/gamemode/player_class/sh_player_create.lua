DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.Health				= nzMapping.Settings.hp
PLAYER.WalkSpeed 			= 200
PLAYER.RunSpeed				= 400
PLAYER.JumpPower			= 200
PLAYER.CanUseFlashlight     = true

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Bool", 0, "UsingSpecialWeapon")
	self.Player:NetworkVar("Entity", 0, "TeleporterEntity")
	self.Player:NetworkVar("Int", 0, "DownButtons") //KeyDown is not networked, so we do this
	self.Player:NetworkVar("Int", 1, "LastPressedButtons") //idk maybe this will be usefull
end

function PLAYER:Init()
end

function PLAYER:Loadout()
	-- Creation Tools
	self.Player:Give( "weapon_physgun" )
	self.Player:Give( "weapon_hands" )
	self.Player:Give( "nz_multi_tool" )
end

local cvar_bleedout = GetConVar("nz_downtime")
local cvar_revive = GetConVar("nz_revivetime")
local cvar_perkmax = GetConVar("nz_difficulty_perks_max")

function PLAYER:Spawn()
	self.Player:SetHealth(nzMapping.Settings.hp or 150)
	self.Player:SetMaxHealth(nzMapping.Settings.hp or 150)
	self.Player:SetArmor(nzMapping.Settings.startarmor or 0)
	self.Player:SetMaxArmor(nzMapping.Settings.armor or 200)
	self.Player:SetJumpPower(nzMapping.Settings.jumppower or 200)

	self.Player:AllowFlashlight(true)
	self.Player:SetTargetPriority(TARGET_PRIORITY_PLAYER)
	self.Player:SetUsingSpecialWeapon(false)

	self.Player:SetBleedoutTime(cvar_bleedout:GetFloat())
	self.Player:SetReviveTime(cvar_revive:GetFloat())
	self.Player:SetMaxPerks(cvar_perkmax:GetInt())

	self.Player:MoveToSpawn()
end

/*function PLAYER:ViewModelChanged(vm, oldmodel, newmodel)
	local wep
	for k, v in ipairs(self.Player:GetWeapons()) do
		if v:GetWeaponViewModel() == newmodel then
			wep = v
			break
		end
	end

	if not IsValid(vm) or not IsValid(wep) then return end
	if wep.NZCamoBlacklist then return end
	if wep.NZSpecialCategory then return end
	if not wep:HasNZModifier("pap") then return end

	nzCamos:UpdatePlayerViewmodel(self.Player, newmodel)
end*/

player_manager.RegisterClass( "player_create", PLAYER, "player_default" )
