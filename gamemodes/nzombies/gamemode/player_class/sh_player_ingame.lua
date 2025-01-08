DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.Health				= nzMapping.Settings.hp
PLAYER.WalkSpeed 			= 190 -- Moo Mark. Lowered player speed slightly, Sprinting Zombies should only slowly lose distance on you. But Supersprinting Zombies have no issue catching up. This was done testing player speed in BO4 so I don't wanna hear any shit.
PLAYER.RunSpeed				= 310 -- Don't worry, the overall stamina is being increased to around 8 seconds to make up for this.
PLAYER.JumpPower			= 200
PLAYER.CanUseFlashlight     = true

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Bool", 0, "UsingSpecialWeapon")
	self.Player:NetworkVar("Entity", 0, "TeleporterEntity") -- So we can know what Teleporter is teleporting us
	self.Player:NetworkVar("Int", 0, "DownButtons") //KeyDown is not networked, so we do this
	self.Player:NetworkVar("Int", 1, "LastPressedButtons") //idk maybe this will be usefull
end

function PLAYER:Init()
end

function PLAYER:Loadout()
	if nzMapping.Settings.startwep and weapons.Get(tostring(nzMapping.Settings.startwep)) then
		self.Player:Give(nzMapping.Settings.startwep)
	else
		self.Player:Give("tfa_bo3_wepsteal")
		self.Player:PrintMessage( HUD_PRINTTALK, "You have to change the starting weapon in Map Settings!" )
	end

	self.Player:GiveMaxAmmo()

	if not GetConVar("nz_papattachments"):GetBool() and FAS2_Attachments ~= nil then
		for k,v in pairs(FAS2_Attachments) do
			self.Player:FAS2_PickUpAttachment(v.key)
		end
	end

	if nzMapping.Settings.knife and weapons.Get(tostring(nzMapping.Settings.knife)) then
		self.Player:Give(nzMapping.Settings.knife)
	else
		self.Player:Give("tfa_bo1_knife")
	end

	if nzMapping.Settings.grenade and weapons.Get(tostring(nzMapping.Settings.grenade)) then
		local nade = self.Player:Give(nzMapping.Settings.grenade)
		nade.NoSpawnAmmo = true
	else
		self.Player:Give("tfa_bo1_m67")
	end

	local oldweapons = self.Player.OldWeapons
	if oldweapons and istable(oldweapons) and not table.IsEmpty(oldweapons) then
		local ply = self.Player
		for _, data in pairs(oldweapons) do
			if data.special and data.special == "specialist" then
				ply:Give(data.class)
			end 
		end
		self.Player.OldWeapons = nil
	end
end

local cvar_bleedout = GetConVar("nz_downtime")
local cvar_revive = GetConVar("nz_revivetime")
local cvar_perkmax = GetConVar("nz_difficulty_perks_max")

function PLAYER:Spawn()
	local starting = nzMapping.Settings.startpoints or 500
	local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
	local points = round * starting

	if not self.Player:CanAfford(starting) then
		self.Player:SetPoints(points)
	end

	local health = nzMapping.Settings.hp
	self.Player:SetHealth(health or 150)
	self.Player:SetMaxHealth(health or 150)
	self.Player:SetArmor(nzMapping.Settings.startarmor or 0)
	self.Player:SetMaxArmor(nzMapping.Settings.armor or 200)
	self.Player:SetJumpPower(nzMapping.Settings.jumppower or 200)

	self.Player:SetTargetPriority(TARGET_PRIORITY_PLAYER)

	self.Player:RemovePerks()
	self.Player:RemoveUpgrades()
	self.Player:MoveToSpawn()

	self.Player:SetUsingSpecialWeapon(false)
	self.Player:SetBleedoutTime(cvar_bleedout:GetFloat())
	self.Player:SetReviveTime(cvar_revive:GetFloat())
	self.Player:SetMaxPerks(cvar_perkmax:GetInt())
	self.Player:AllowFlashlight(tobool(nzMapping.Settings.flashlight))

	-- Resend the map data to any player that spawns/respawns(They might've joined late and haven't recived the mapsettings.)
	nzMapping:SendMapData(self.Player)
end

//well cant say i didnt try, has issues in mp with the camo getting reset
//probably related to how tfa caches stuff and my lack of understanding that

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

player_manager.RegisterClass( "player_ingame", PLAYER, "player_default" )
