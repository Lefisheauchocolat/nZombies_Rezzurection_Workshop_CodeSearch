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

    -- Find all available spawn points
    for _, spawn in ipairs(spawns) do
        local isSpawnOccupied = false
        for _, ply in ipairs(player.GetAll()) do
            if ply:GetPos() == spawn:GetPos() then
                isSpawnOccupied = true -- i dont think this actually does what i was trying to get it to do, but it WILL prevent people from spawning on top of people!
                break
            end
        end
        if not isSpawnOccupied then
            table.insert(availableSpawns, spawn)
        end
    end

    -- Randomly select a spawn point
    local selectedSpawn = table.Random(availableSpawns)
    if IsValid(selectedSpawn) then
        self.Player:SetPos(selectedSpawn:GetPos())
    else
		print("No spawn set for player: " .. v:Nick())
    end

    self.Player:SetUsingSpecialWeapon(false)

    -- Resend the map data to any player that spawns/respawns(They might've joined late and haven't recived the mapsettings.)
    nzMapping:SendMapData(self.Player)
end


function PLAYER:OnTakeDamage(dmginfo)
end

player_manager.RegisterClass( "player_ingame", PLAYER, "player_default" )
