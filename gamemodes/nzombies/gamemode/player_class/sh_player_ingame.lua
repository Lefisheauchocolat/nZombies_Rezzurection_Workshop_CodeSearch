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
		self.Player:Give(nzMapping.Settings.grenade)
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
local cvar_respawnonplayers = GetConVar("nz_difficulty_respawn_on_players")

function PLAYER:Spawn()
	local starting = nzMapping.Settings.startpoints or 500
	local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
	local points = round * starting

	if not self.Player:CanAfford(starting) then
		self.Player:SetPoints(points)
	end

	local health = nzMapping.Settings.hp
	self.Player:SetHealth(health or 100)
	self.Player:SetMaxHealth(health or 100)

	self.Player:RemovePerks()
	self.Player:RemoveUpgrades()

	self.Player:SetTargetPriority(TARGET_PRIORITY_PLAYER)

	--Charlotte here, this took 2 fucking hours. I've never been so happy to have something done >:3
	local spawns = ents.FindByClass("player_spawns")
	local availableSpawns = {}
	local finalpos = spawns[math.random(#spawns)]:GetPos()

	-- Find all available spawn points
	for _, spawn in ipairs(spawns) do
		local isSpawnOccupied = false

		local mins, maxs = spawn:GetCollisionBounds()
		for _, ply in pairs(ents.FindInBox(spawn:LocalToWorld(mins), spawn:LocalToWorld(maxs))) do
			if IsValid(ply) and ply:IsPlayer() and ply:Alive() and ply:IsPlaying() then
				isSpawnOccupied = true
			end
		end

		if not isSpawnOccupied then
			availableSpawns[#availableSpawns + 1] = spawn
		end
	end

	-- Randomly select a spawn point
	local selectedSpawn = table.Random(availableSpawns)
	if IsValid(selectedSpawn) then
		finalpos = selectedSpawn:GetPos()
	end

	if cvar_respawnonplayers:GetBool() and nzRound:GetNumber() > 1 then
		local spawns = nzRound:InState(ROUND_CREATE) and player.GetAll() or player.GetAllPlayingAndAlive()

		local spectator = self.Player:GetObserverTarget()
		if IsValid(spectator) and spectator:Alive() and spectator:IsPlaying() then
			finalpos = spectator:GetPos()
		elseif not table.IsEmpty(spawns) then
			finalpos = spawns[math.random(#spawns)]:GetPos()
		end
	end

	self.Player:SetPos(finalpos)

	self.Player:SetUsingSpecialWeapon(false)
	self.Player:SetBleedoutTime(cvar_bleedout:GetFloat())
	self.Player:SetReviveTime(cvar_revive:GetFloat())
	self.Player:SetMaxPerks(cvar_perkmax:GetInt())
	self.Player:AllowFlashlight(tobool(nzMapping.Settings.flashlight))

	/*-- Resend the map data to any player that spawns/respawns(They might've joined late and haven't recived the mapsettings.)
	nzMapping:SendMapData(self.Player)*/
	//see line #38 in sv_players.lua
end


function PLAYER:OnTakeDamage(dmginfo)
end

player_manager.RegisterClass( "player_ingame", PLAYER, "player_default" )
