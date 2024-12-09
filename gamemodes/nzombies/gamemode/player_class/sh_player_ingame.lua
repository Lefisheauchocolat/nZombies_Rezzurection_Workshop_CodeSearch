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
local cvar_respawnonplayers = GetConVar("nz_difficulty_respawn_on_players")

local function GetClearPaths(ply, pos, tiles)
	local clearPaths = {}
	local filter = player.GetAll()
	for _, tile in pairs( tiles ) do
		local tr = util.TraceLine({
			start = pos,
			endpos = tile,
			filter = filter,
			mask = MASK_PLAYERSOLID
		})
		
		if not tr.Hit and util.IsInWorld(tile) then
			table.insert( clearPaths, tile )
		end
	end
	
	return clearPaths
end

local function GetSurroundingTiles(ply, pos)
	local tiles = {}
	local x, y, z
	local minBound, maxBound = ply:GetHull()
	local checkRange = math.max(48, maxBound.x, maxBound.y)
	
	for z = -1, 1, 1 do
		for y = -1, 1, 1 do
			for x = -1, 1, 1 do
				local testTile = Vector(x,y,z)
				testTile:Mul( checkRange )
				local tilePos = pos + testTile
				table.insert( tiles, tilePos )
			end
		end
	end
	
	return tiles
end

local function CollisionBoxClear(ply, pos, minBound, maxBound)
	local filter = {ply}
	local tr = util.TraceEntity({
		start = pos,
		endpos = pos,
		filter = filter,
		mask = MASK_PLAYERSOLID
	}, ply)

	return !tr.StartSolid || !tr.AllSolid
end

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
			if IsValid(ply) and ply:IsPlayer() and ply:Alive() then
				isSpawnOccupied = true
			end
		end

		if not isSpawnOccupied then
			availableSpawns[#availableSpawns + 1] = spawn
		end
	end

	for _, spawn in RandomPairs(availableSpawns) do
		finalpos = spawn:GetPos()
		if spawn:GetPreferred() then break end
	end

	if cvar_respawnonplayers:GetBool() and nzRound:GetNumber() > 1 then
		local spawns = player.GetAllPlaying()

		local spectator = self.Player:GetObserverTarget()
		if IsValid(spectator) and spectator:Alive() and spectator:IsPlaying() then
			finalpos = spectator:GetPos()
		elseif not table.IsEmpty(spawns) then
			for _, ply in RandomPairs(spawns) do
				finalpos = ply:GetPos()
				if !ply:GetNotDowned() then break end
				//prefer respawning on downed players :)
			end
		end
	end

	local minBound, maxBound = self.Player:GetHull()
	if not CollisionBoxClear( self.Player, finalpos, minBound, maxBound ) then
		local surroundingTiles = GetSurroundingTiles( self.Player, finalpos )
		local clearPaths = GetClearPaths( self.Player, finalpos, surroundingTiles )	
		for _, tile in pairs( clearPaths ) do
			if CollisionBoxClear( self.Player, tile, minBound, maxBound ) then
				finalpos = tile
				break
			end
		end
	end

	self.Player:SetPos(finalpos + vector_up)

	self.Player:SetUsingSpecialWeapon(false)
	self.Player:SetBleedoutTime(cvar_bleedout:GetFloat())
	self.Player:SetReviveTime(cvar_revive:GetFloat())
	self.Player:SetMaxPerks(cvar_perkmax:GetInt())
	self.Player:AllowFlashlight(tobool(nzMapping.Settings.flashlight))

	-- Resend the map data to any player that spawns/respawns(They might've joined late and haven't recived the mapsettings.)
	nzMapping:SendMapData(self.Player)
end

function PLAYER:ViewModelChanged(vm, oldmodel, newmodel)
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
end

player_manager.RegisterClass( "player_ingame", PLAYER, "player_default" )
