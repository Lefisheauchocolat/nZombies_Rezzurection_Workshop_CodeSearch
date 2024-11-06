-- 

if SERVER then
	local plyMeta = FindMetaTable("Player")

	function plyMeta:GivePowerUp(id, duration)
		if duration > 0 then
			if not nzPowerUps.ActivePlayerPowerUps[self] then nzPowerUps.ActivePlayerPowerUps[self] = {} end
			
			nzPowerUps.ActivePlayerPowerUps[self][id] = (nzPowerUps.ActivePlayerPowerUps[self][id] or CurTime()) + duration
			nzPowerUps:SendPlayerSync(self) -- Sync this player's powerups
		end
	end

	function plyMeta:RemovePowerUp(id, nosync)
		local PowerupData = nzPowerUps:Get(id)
		if PowerupData and PowerupData.expirefunc then
			PowerupData.expirefunc(id, self) -- Call expirefunc when manually removed
		end

		if not nzPowerUps.ActivePlayerPowerUps[self] then nzPowerUps.ActivePlayerPowerUps[self] = {} end
		nzPowerUps.ActivePlayerPowerUps[self][id] = nil
		if not nosync then nzPowerUps:SendPlayerSync(self) end -- Sync this player's powerups
	end

	function plyMeta:RemoveAllPowerUps()
		if not nzPowerUps.ActivePlayerPowerUps[self] then nzPowerUps.ActivePlayerPowerUps[self] = {} return end

		for k,v in pairs(nzPowerUps.ActivePlayerPowerUps[self]) do
			self:RemovePowerUp(k, true)
		end
		nzPowerUps:SendPlayerSync(self)
	end

	function nzPowerUps:Activate(id, ply, ent)
		local PowerupData = self:Get(id)
		if not PowerupData then return end

		if hook.Call("OnPlayerPickupPowerUp", nil, ply, id, ent) then return end

		if not PowerupData.global then
			if IsValid(ply) then //swapped order to applying time first then calling func
				local exists = self.ActivePlayerPowerUps[ply] and self.ActivePlayerPowerUps[ply][id]
				ply:GivePowerUp(id, (PowerupData.duration + nzGum.TemporalGiftTime) * (ply:HasUpgrade("time") and 2 or 1))
				if not exists then -- If you don't have the powerup
					PowerupData.func(id, ply, ent)
				elseif PowerupData.reapply then
					PowerupData.reapply(id, ply, ent)
				end
			end
		else
			if PowerupData.duration ~= 0 then //swapped order to applying time first then calling func
				-- Activate for a certain time
				local exists = self.ActivePowerUps[id]
				self.ActivePowerUps[id] = (exists or CurTime()) + (PowerupData.duration + nzGum.TemporalGiftTime) * ((IsValid(ply) and ply:HasUpgrade("time")) and 2 or 1)
				if not exists then
					PowerupData.func(id, ply, ent)
				elseif PowerupData.reapply then
					PowerupData.reapply(id, ply, ent)
				end
			else
				-- Activate Once
				PowerupData.func(id, ply, ent)
			end
			-- Sync to everyone
			self:SendSync()
		end

		if PowerupData.announcement then
			local name = string.Replace(PowerupData.name, " ", "") -- Sound Events don't have spaces
			nzSounds:Play(name)
		end

		if nzMapping.Settings.antipowerups then
			self:IncreaseAntiPowerUpChance()
		end
	end

	--[[ Moo Mark 7/14/23:
		Added a drop cycle system to closer mimic
		how drops are handled in the real games.
		This will insure that you only ever get
		one of each drop per cycle.
		A cycle will be completed once the core four
		drops have appeared, these include: Insta-Kill, Double Points, Nuke, and Max Ammo.
		There is still some RNG involved but this makes drops more predictable and can
		also allow players to manipulate it by meeting criteria that stop other drops from spawning.
	]]
	local dropsthisround = 0
	//local maxdrops = 4

	-- For reference so these are ALWAYS inserted into the core drops table if any of them are enabled in the map settings.
	local ogdrops = {
		insta = true,
		nuke = true,
		dp = true,
		maxammo = true,
	}

	-- These drops are forbidden from ever being considered core. Mainly cuz these powerups have criteria that keep them from EVER spawning.
	local forbiddenfromcore = {
		zombieblood = true,
		firesale = true,
		bottle = true,
		bottleslot = true,
		carpenter = true,
		timewarp = true,
		bloodmoney = true,
		godmode = true,
	}

	local dropped = {}
	local possibledrops = {}
	local coredrops = {}
	local iscoredrop = {}
	local allowedPowerups = {}
	local possibleforcore = {}

	local antidropchances = {}
	local defaultantichances = {}

	hook.Add("OnRoundStart", "NODROPSFUCKU", function() 
		dropsthisround = 0
		/*if nzRound:IsSpecial() then
			maxdrops = 0 -- No drops on special rounds :wind_blowing_face:
		else
			maxdrops = 4
		end*/
		if nzRound:GetNumber() <= 1 then -- Reset everything on the first round... Or negative one... For some fucking reason idk, Justin Case.
			coredrops = {}
			dropped = {}
			possibledrops = {}
			iscoredrop = {}
			allowedPowerups = {}
			possibleforcore = {}

			nzPowerUps:SetupCoreDrops()
			nzPowerUps:SetupAntiDrops()
		end
	end)

	function nzPowerUps:GetCoreDrops()
		return iscoredrop
	end

	function nzPowerUps:GetDroppedPowerups()
		return dropped
	end

	function nzPowerUps:ResetDropCycle()
		dropsthisround = 0
		coredrops = {}
		dropped = {}
	end

	function nzPowerUps:SetupCoreDrops()
		if nzMapping.Settings.poweruplist then
			for k, v in pairs(nzMapping.Settings.poweruplist) do
				if v[1] then
					allowedPowerups[k] = true
					if !forbiddenfromcore[k] then
						possibleforcore[k] = true 
					end
				end
			end
		end

		-- Initial loop: Check each Original Powerup to see if it can be added(Add to the table if so.)
		for k2, v2 in pairs(ogdrops) do
			if table.Count(iscoredrop) < 4 then
				if allowedPowerups[k2] and ogdrops[k2] then
					iscoredrop[k2] = true 
				end
			end
		end

		-- Secondary loop: If any of the Original Powerups are missing(Disabled), add a new powerup to fill in for it.
		for k3, v3 in pairs(possibleforcore) do
			if table.Count(iscoredrop) < 4 then
				if !iscoredrop[k3] and !ogdrops[k3] then
					iscoredrop[k3] = true 
				end
			end
		end

		print("Core Drops for this Match:")
		PrintTable(iscoredrop)
	end

	function nzPowerUps:SetupAntiDrops()
		defaultantichances = {}

		//go through allowedpowerups and see which ones have anti functions
		for k, v in pairs(allowedPowerups) do
			local pdata = self:Get(k)
			if pdata.antifunc then
				defaultantichances[k] = 1
			end
		end

		if nzMapping.Settings.antipowerups then
			print("Anti Drops for this Match:")
			PrintTable(defaultantichances)
		end
	end

	function nzPowerUps:SelectAntiPowerup(powerups, pos)
		for k, v in pairs(powerups) do
			if v.anticondition and !v.anticondition(k, pos) then
				powerups[k] = nil
				continue
			end
		end

		return nzMisc.WeightedRandom(powerups)
	end

	function nzPowerUps:SpawnPowerUp(pos, specific)
		if specific or ((dropsthisround < (nzMapping.Settings.maxpowerupdrops or 4) or nzPowerUps.DisableDropLimit) and !nzRound:IsSpecial()) then -- If the drop is specific then it should ALWAYS spawn no matter what.
			if not pos or not isvector(pos) then
				pos = Entity(1):GetPos()
			end

			local rounddata = nzMapping.Settings.poweruprounds

			-- Queue all possible powerups
			if not specific then
				for k, v in pairs(self.Data) do
					-- Only allow max ammos on special rounds.
					if nzRound:IsSpecial() then
						if k ~= "maxammo" then
							continue
						end
					else
						if nzMapping.Settings.poweruproundbased and rounddata and rounddata[k] and rounddata[k] > nzRound:GetNumber() then
							continue
						end
					end

					//test if powerup should be able to spawn
					if v.condition and !v.condition(k, pos) then
						continue
					end

					if k ~= "ActivePowerUps" and !dropped[k] and allowedPowerups[k] then -- Now tweaked to check if the powerup is enabled.
						table.insert(possibledrops, k) -- Only insert the ones that haven't dropped yet or met the criteria to drop.
					end
				end
			end

			local powup = possibledrops[math.random(#possibledrops)] -- Now select a random powerup.

			local id = specific and specific or powup
			if not id or id == "null" then return end --  Back out

			local PowerupData = self:Get(id)

			//the evil deed
			if nzMapping.Settings.antipowerups then
				if table.IsEmpty(antidropchances) then
					antidropchances = defaultantichances
				end

				if PowerupData.antifunc then
					local cur = antidropchances[id] or 0
					antidropchances[id] = cur + 1
				end
			end

			//INTERCEPTION
			if !nzPowerUps:GetAntiPowerUpChance() then nzPowerUps:ResetAntiPowerUpChance() end
			if nzMapping.Settings.antipowerups and !specific and math.Rand(0, nzMapping.Settings.antipowerupchance) < nzPowerUps:GetAntiPowerUpChance() and !nzRound:IsSpecial() then
				nzPowerUps:SpawnAntiPowerUp(pos, nzPowerUps:SelectAntiPowerup(antidropchances, pos))
				nzPowerUps:ResetAntiPowerUpChance()
				antidropchances = defaultantichances
			else
				-- Spawn it
				local ent = ents.Create("drop_powerup")
				id = hook.Call("OnPowerUpSpawned", nil, id, ent) or id
				if not IsValid(ent) then return end -- If a hook removed the powerup

				pos = pos + Vector(0, 0, 50)

				ent:SetPowerUp(id)
				pos.z = pos.z - ent:OBBMaxs().z
				ent:SetModel(PowerupData.model)
				ent:SetPos(pos)
				ent:SetAngles(PowerupData.angle)
				ent:Spawn()
			end

			if id ~= specific and !specific then -- If the drop was specific/set, then it was probably important thus not having it count towards the cycle.
				if iscoredrop[id] and !dropped[id] then
					table.insert(coredrops, id)
				end

				dropsthisround = dropsthisround + 1
				dropped[powup] = true

				if table.Count(coredrops) >= 4 then -- All of the core drops dropped... Reset the cycle.
					coredrops = {}
					dropped = {}
				end
			end

			PrintTable(possibledrops)
			possibledrops = {}
		end
	end

	//sync entities to client for HUD related purposes
	util.AddNetworkString("nzSendPowerupHudSync")
	util.AddNetworkString("nzSendPowerupHudSyncFix")

	function nzPowerUps:PowerupHudSync(ent)
		if not IsValid(ent) then return end

		net.Start("nzSendPowerupHudSync")
			net.WriteInt(ent:EntIndex(), 16)
		net.Broadcast()
	end

	function nzPowerUps:PowerupHudRemove(ent)
		net.Start("nzSendPowerupHudSyncFix")
			net.WriteInt(ent:EntIndex(), 16)
		net.Broadcast()
	end
end

if CLIENT then
	//receive sync for powerups and queue them
	local load_queue_cl = {}

	local function ReceiveSync( length )
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		local ent = net.ReadInt(16)

		if !load_queue_cl[ply] then
			load_queue_cl[ply] = {}
		end

		table.insert(load_queue_cl[ply], ent)
	end

	local function ReceiveSyncFix(length)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		local id = net.ReadInt(16)

		if !load_queue_cl[ply] then return end

		if nzPowerUps.ClientPowerUpsTab and nzPowerUps.ClientPowerUpsTab[id] then
			nzPowerUps.ClientPowerUpsTab[id] = nil
		end

		for k, entid in pairs(load_queue_cl[ply]) do
			if entid == id then
				load_queue_cl[ply][k] = nil
				if table.IsEmpty(load_queue_cl[ply]) then
					load_queue_cl[ply] = nil
				end
				break
			end
		end
	end

	net.Receive("nzSendPowerupHudSync", ReceiveSync)
	net.Receive("nzSendPowerupHudSyncFix", ReceiveSyncFix)

	//table of existing powerup drops
	nzPowerUps.ClientPowerUpsTab = nzPowerUps.ClientPowerUpsTab or {}

	hook.Add("Think", "nzPowerupHudSync", function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if load_queue_cl[ply] then
			for k, entid in pairs(load_queue_cl[ply]) do
				local ent = Entity(entid)
				if IsValid(ent) then
					if nzPowerUps.EntityClasses and nzPowerUps.EntityClasses[ent:GetClass()] and !nzPowerUps.ClientPowerUpsTab[ent:EntIndex()] then
						nzPowerUps.ClientPowerUpsTab[ent:EntIndex()] = ent
					end

					load_queue_cl[ply][k] = nil
					if table.IsEmpty(load_queue_cl[ply]) then
						load_queue_cl[ply] = nil
					end
					break
				end
			end
		end
	end)

	local color_backup = Color(0,255,0,255)
	hook.Add("PreDrawHalos", "nzAntiPowerupHalo", function()
		if nzMapping.Settings.powerupoutline and nzMapping.Settings.powerupoutline == 0 and not nzMapping.Settings.antipowerups then return end

		//outline for powerups
		local powerupholos = nzPowerUps.ClientPowerUpsTab
		if next(powerupholos) ~= nil then
			local ourcolor = color_backup
			for id, ent in pairs(powerupholos) do
				if not IsValid(ent) then
					//clean from table if we dont exist anymore
					nzPowerUps.ClientPowerUpsTab[id] = nil
					break
				end

				if nzMapping.Settings.powerupcol then
					local cvec = nzMapping.Settings.powerupcol["local"][1]
					if ent.GlobalPowerup then //global powerups
						cvec = nzMapping.Settings.powerupcol["global"][1]
					end
					if ent.GetDropType then //vulture drops
						cvec = nzMapping.Settings.powerupcol["mini"][1]
					end
					if ent.GetAnti and ent:GetAnti() then //anti powerups
						cvec = nzMapping.Settings.powerupcol["anti"][1]
					end
					if ent.GetBeingHeld and ent:GetBeingHeld() then //held powerup
						cvec = nzMapping.Settings.powerupcol["anti"][1]
					end
					if ent.GetFunny then //tombstone drop
						cvec = nzMapping.Settings.powerupcol["tombstone"][1]
					end
					if ent.GetTreasure then //treasure drops
						cvec = nzMapping.Settings.powerupcol["treasure"][1]
					end

					ourcolor = Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255)
				end

				if (nzMapping.Settings.powerupoutline and nzMapping.Settings.powerupoutline > 0) or (ent.GetAnti and ent:GetAnti()) then
					local ignorez = nzMapping.Settings.powerupoutline == 2
					if ent.GetAnti and ent:GetAnti() then
						ignorez = true
					end
					if ent.GetSpawnedPowerUp and ent:GetSpawnedPowerUp() then
						ignorez = false
					end

					halo.Add({[1] = ent}, ourcolor, 2, 2, 1, true, ignorez)
				end
			end
		end

		//outline players under the effects of an anti powerup
		if nzMapping.Settings.antipowerups then
			local antiplayers = {}
			for ply, data in pairs(nzPowerUps.ActivePlayerAntiPowerUps) do
				if ply and next(data) ~= nil then
					table.insert(antiplayers, ply)
				end
			end

			if next(antiplayers) ~= nil then
				local ourcolor = color_backup
				if nzMapping.Settings.powerupcol then
					local cvec = nzMapping.Settings.powerupcol["anti"][1]
					ourcolor = Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255)
				end

				halo.Add(antiplayers, ourcolor, 1, 1, 1, true, true)
			end
		end
	end)
end

local plyMeta = FindMetaTable("Player")

function plyMeta:AllActivePowerUps()
	if not nzPowerUps.ActivePlayerPowerUps[self] then nzPowerUps.ActivePlayerPowerUps[self] = {} end
	return nzPowerUps.ActivePlayerPowerUps[self]
end

function nzPowerUps:IsPowerupActive(id)
	local time = self.ActivePowerUps[id]

	if time ~= nil then
		-- Check if it is still within the time.
		if CurTime() > time then
			-- Expired
			self.ActivePowerUps[id] = nil
		else
			return true
		end
	end

	return false
end

function nzPowerUps:IsPlayerPowerupActive(ply, id)
	if not self.ActivePlayerPowerUps[ply] then self.ActivePlayerPowerUps[ply] = {} end
	local time = self.ActivePlayerPowerUps[ply][id]

	if time then
		-- Check if it is still within the time.
		if CurTime() > time then
			-- Expired
			self.ActivePlayerPowerUps[ply][id] = nil
		else
			return true
		end
	end

	return false
end

function nzPowerUps:AllActivePowerUps()
	return self.ActivePowerUps
end

function nzPowerUps:NewPowerUp(id, data)
	if CLIENT then
		data.Func = nil
	end
	self.Data[id] = data
end

function nzPowerUps:GetList()
	local tbl = {}

	for k,v in pairs(nzPowerUps.Data) do
		tbl[k] = v.name
	end

	return tbl
end

function nzPowerUps:Get(id)
	return self.Data[id]
end

--[[Example
nzPowerUps:NewPowerUp("unique_id", {
	name = "Power-Up Name",
	model = "path/to/model.mdl",
	desc = "description of what powerup does",
	angle = Angle(0,0,0), //angle offset on spawn
	scale = int, //custom model scale

	global = bool, //effect applies to all players
	chance = int, //currently does nothing, originally worked like random box rarity
	duration = int, //how long powerup lasts after being picked up (if time based)
	natural = bool, //sets whether the powerup is automatically enabled when default map settings are first created
	pressuse = bool, //enable for powerup to require pressing the use key to pickup
	rare = bool, //for if the powerup should be treated differently in some scenarios
	(e.g. in powerup scrolling default powerups scroll in 1 second, rare powerups scroll in 0.25 seconds)

	announcement = bool, //enables announcer line for powerup, if it exists in sh_sounds

	loopsound = "path/to/looping_sound.wav", //delete if not needed or not time based
	stopsound = "path/to/sound.wav", //delete if not needed or not time based

	addpitch = int, //unsure of what this does
	nopitchshift = int, //unsure of what this does

	//this will get reworked later down the line
	icon_t5 = Material("path/to/icon.png", "unlitgeneric"),
	icon_t6 = Material("path/to/icon.png", "unlitgeneric"),
	icon_t7 = Material(path/to/icon.png", "unlitgeneric"),
	icon_t7zod = Material("path/to/icon.png", "unlitgeneric"),
	icon_t8 = Material("path/to/icon.png", "unlitgeneric"),
	icon_t9 = Material("path/to/icon.png", "unlitgeneric"),

	//for if the powerup requires certain conditions met to spawn (does not apply to forced powerups)
	condition = function(id, position)
		return bool //if this always returns false, the powerup will never naturally spawn and can only be spawned thru code
	end,

	spawnfunc = fuinction(id, ent) //run when the powerup entity is initialized, delete if not needed
		//useful for if powerup is a 'pressuse' type and youd like to apply a custom hint string
		//hint string will start with 'Press (+USE) - ' automatically
		ent:SetHintString("Pickup Power-Up")
	end,

	func = function(id, ply) //required, does not have to contain any actual code to run
	end,

	expirefunc = function(id, ply) //delete if not needed or not time based
	end,

	//anti stuff if you feel like coding it
	antidesc = "description of what anti powerup does",
	antiduration = int, //how long anti powerup version lasts, set to 0 if not time based

	anticondition = function(id, position)
		return bool //same as normal condition function, delete if not needed
	end,

	antifunc = function(id, ply)
	end,

	antiexpirefunc = function(id, ply)
	end,

	//this is run when a local anti-powerup spawns and tries to roll for a player to inflict its effect on
	anticond = function(ply) //delete if not needed
	end,
})
]]

-- Double Points
nzPowerUps:NewPowerUp("dp", {
	name = "Double Points",
	model = "models/powerups/w_double.mdl",
	desc = "All players gain doubled points",
	antidesc = "All players are unable to gain points",
	global = true,
	angle = Angle(25,0,0),
	scale = 1,
	chance = 4,
	duration = 30,
	antiduration = 15,
	addpitch = 50,
	nopitchshift = 0,
	natural = true,
	announcement = true,
	loopsound = "nz_moo/powerups/doublepoints_loop_zhd.wav",
	stopsound = "nz_moo/powerups/doublepoints_end.mp3",
	icon_t5 = Material("nz_moo/icons/bo1/classic_clean_powerup_double.png", "unlitgeneric"),
	icon_t6 = Material("nz_moo/icons/bo2/charred_powerup_2x.png", "unlitgeneric"),
	icon_t7 = Material("nz_moo/icons/t7/specialty_giant_2x_zombies.png", "unlitgeneric"),
	icon_t7zod = Material("nz_moo/icons/t7_zod/specialty_2x_zombies.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_2x.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_double_points.png", "unlitgeneric"),
	func = function(id, ply)
	end,
	antifunc = (function(id, ply)
		nzSounds:Play("Laugh")

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Double Points!")
			net.WriteBool(false)
		net.Broadcast()
	end),
	antiexpirefunc = (function(id, ply)
	end),
})

-- Max Ammo
nzPowerUps:NewPowerUp("maxammo", {
	name = "Max Ammo",
	model = "models/powerups/w_maxammo.mdl",
	desc = "All players weapon ammo, grenades, tacticals, equipment, specialist, and shield chargers are refilled",
	antidesc = "All players active weapons reserve ammo is emptied",
	global = true,
	angle = Angle(0,0,25),
	scale = 1,
	chance = 1,
	duration = 0,
	antiduration = 0,
	natural = true,
	icon_t5 = Material("vgui/bo1_max.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_max.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_max.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_max.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_maxammo.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_max_ammo.png", "unlitgeneric"),
	func = (function(id, ply)
		nzSounds:Play("MaxAmmo")
		
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Max Ammo!")
			net.WriteBool(true)
		net.Broadcast()

		for k,v in pairs(player.GetAll()) do
			v:GiveMaxAmmo()
		end
	end),
	antifunc = (function(id, ply)
		nzSounds:Play("Laugh")

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Max Ammo!")
			net.WriteBool(false)
		net.Broadcast()

		for _, ply in pairs(player.GetAll()) do
			if IsValid(ply) then
				local wep = ply:GetActiveWeapon()
				if not IsValid(wep) then continue end

				local ammo = wep:GetPrimaryAmmoType()
				if ammo > 0 then
					ply:SetAmmo(0, ammo)
				end

				local ammo2 = wep:GetSecondaryAmmoType()
				if ammo2 > 0 then
					ply:SetAmmo(0, ammo2)
				end
			end
		end
	end),
})

-- Insta Kill
nzPowerUps:NewPowerUp("insta", {
	name = "Insta Kill",
	model = "models/powerups/w_insta.mdl",
	desc = "All zombies die instantly from any source of damage",
	antidesc = "All players health are set to 1 and health regeneration is disabled",
	global = true,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 3,
	duration = 30,
	antiduration = 15,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = true,
	loopsound = "nz_moo/powerups/instakill_loop_zhd.wav",
	stopsound = "nz_moo/powerups/instakill_end.mp3",
	icon_t5 = Material("nz_moo/icons/bo1/classic_clean_powerup_instakill_alt.png", "unlitgeneric"),
	icon_t6 = Material("nz_moo/icons/bo2/charred_powerup_instakill.png", "unlitgeneric"),
	icon_t7 = Material("nz_moo/icons/t7/specialty_giant_killjoy_zombies.png", "unlitgeneric"),
	icon_t7zod = Material("nz_moo/icons/t7_zod/specialty_instakill_zombies.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_instakill.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_instakill.png", "unlitgeneric"),
	func = function(id, ply)
	end,
	antifunc = (function(id, ply)
		nzSounds:Play("Laugh")

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Insta Kill!")
			net.WriteBool(false)
		net.Broadcast()

		for _, ply in pairs(player.GetAll()) do
			if IsValid(ply) and ply:Alive() then
				ply:SetHealth(1)
				ply.lasthit = CurTime() + math.huge
			end
		end
	end),
	antiexpirefunc = (function(id, ply)
		for _, ply in pairs(player.GetAll()) do
			if IsValid(ply) and ply.lasthit and ply.lasthit > CurTime() then
				ply.lasthit = 0
			end
		end
	end),
})

-- Nuke
nzPowerUps:NewPowerUp("nuke", {
	name = "Nuke",
	model = "models/powerups/w_nuke.mdl",
	desc = "Eliminates all normal zombies currently on the map",
	antidesc = "All players are set on fire, stunned, and disoriented",
	global = true,
	angle = Angle(10,0,0),
	scale = 1,
	chance = 3,
	duration = 8,
	antiduration = 0,
	natural = true,
	announcement = true,
	noflashing = true,
	icon_t5 = Material("vgui/bo1_nuke.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_nuke.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_nuke.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_nuke.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_nuke.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_nuke.png", "unlitgeneric"),
	func = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Ka-Boom!")
			net.WriteBool(false)
		net.Broadcast()

		nzPowerUps:Nuke(ply:GetPos())
	end),
	expirefunc = (function(id, ply)
		if nzPowerUps.NoNukePoints then
			nzPowerUps.NoNukePoints = nil //reset after called
			return
		end

		for _, ply in pairs(player.GetAllPlaying()) do
			if !IsValid(ply) or !ply:IsPlayer() then continue end
			ply:GivePoints(ply:HasUpgrade("danger") and 1200 or 400)
		end
	end),
	antifunc = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Nuke!")
			net.WriteBool(false)
		net.Broadcast()

		for _, ply in ipairs(player.GetAll()) do
			if ply:HasPerk("danger") then //weirdness but helpful
				ply:ChatPrint("[NZ] Anti-Nuke blocked by Danger")
				continue
			end

			ply:PerkBlur(2)
			ply:NZSonicBlind(4)
			ply:Ignite(2)
			ply:ScreenFade(SCREENFADE.IN, ColorAlpha(color_white, 20), 2, 0 )
		end
	end),
})

-- Fire Sale
nzPowerUps:NewPowerUp("firesale", {
	name = "Fire Sale",
	model = "models/powerups/w_firesale.mdl",
	desc = "All box locations become active and box rolls are only 10 cents a pop",
	antidesc = "Random Box becomes unusable",
	global = true,
	angle = Angle(45,0,0),
	scale = 0.75,
	chance = 2,
	duration = 30,
	antiduration = 15,
	natural = true,
	announcement = true,
	loopsound = "nz_moo/powerups/mus_chap205_19.wav", -- This makes the Firesale Jingle 2d. Its also a good way to prank Youtubers by giving them a Copyright Claim! Now thats what I call goofy.
	stopsound = "nz_moo/powerups/doublepoints_end.mp3",
	icon_t5 = Material("nz_moo/icons/bo1/classic_clean_powerup_sale_alt.png", "unlitgeneric"),
	icon_t6 = Material("nz_moo/icons/bo2/charred_powerup_sale.png", "unlitgeneric"),
	icon_t7 = Material("nz_moo/icons/t7/specialty_giant_firesale_zombies.png", "unlitgeneric"),
	icon_t7zod = Material("nz_moo/icons/t7_zod/specialty_firesale_zombies.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_firesale.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_firesale.png", "unlitgeneric"),
	condition = function(id, pos)
		return nzPowerUps:GetBoxMoved()
	end,
	func = function(id, ply)
		--nzPowerUps:FireSale()
	end,
	expirefunc = function()
		--This is handled in the box ent itself now.

		--[[local tbl = ents.FindByClass("random_box_spawns")
		for k,v in pairs(tbl) do
			local box = v.FireSaleBox
			if IsValid(box) then
				box:StopSound("nz_firesale_jingle")
				if box.MarkForRemoval then
					box:MarkForRemoval()
					box.FireSaling = false
				else
					box:Remove()
				end
			end
		end]]
	end,
	anticondition = function(id, pos)
		return nzPowerUps:GetBoxMoved()
	end,
	antifunc = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Fire Sale!")
			net.WriteBool(false)
		net.Broadcast()

		nzSounds:Play("Bye")

		for k, v in pairs(ents.FindByClass("random_box")) do
			if v.GetActivated then
				if v.Close and v.IsOpen then
					v:Close()
				end
				v:SetActivated(false)
				v:SetActivateTime(CurTime() + math.huge)
			end
		end
	end),
	antiexpirefunc = (function(id, ply)
		for k, v in pairs(ents.FindByClass("random_box")) do
			if v.GetActivateTime then
				v:SetActivateTime(0)
			end
		end
	end),
})

-- Carpenter
nzPowerUps:NewPowerUp("carpenter", {
	name = "Carpenter",
	model = "models/powerups/w_carpenter.mdl",
	desc = "Repairs all barricades currently damage on the map",
	antidesc = "All barricades are destroyed",
	global = true,
	angle = Angle(45,0,0),
	scale = 1,
	chance = 5,
	duration = 7,
	antiduration = 0,
	natural = true,
	noflashing = true,
	loopsound = "nz_moo/powerups/carpenter_loop_classic.wav",
	stopsound = "nz_moo/powerups/carpenter_end_classic.mp3",
	icon_t5 = Material("vgui/bo1_carpenter.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_carpenter.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_carpenter.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_carpenter.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_carpenter.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_carpenter.png", "unlitgeneric"),
	condition = function(id, pos)
		local barricades = ents.FindByClass("breakable_entry")
		if #barricades >= 4 then
			local barricades_broken = 0
			for _, ent in pairs(barricades) do 
				if ent:GetHasPlanks() and (ent:GetNumPlanks() <= 0) then
					barricades_broken = barricades_broken + 1
				end
			end

			return barricades_broken >= 4
		else
			return false
		end
	end,
	func = (function(id, ply)
		local pos = vector_origin
		if IsValid(ply) then
			pos = ply:GetPos()
		end

		for _, ply in ipairs(player.GetAll()) do
			local shield = ply:GetShield()
			if IsValid(shield) then
				shield:SetHealth(shield:GetMaxHealth())
				if IsValid(shield:GetWeapon()) then
					shield:GetWeapon():SetDamage(0)
				end
			end
		end

		nzSounds:Play("Carpenter")
		nzPowerUps:Carpenter(false, pos) //(nopoints bool, starting position)
	end),
	expirefunc = (function(id, ply)
		if nzPowerUps.NoCarpenterPoints then
			nzPowerUps.NoCarpenterPoints = nil //reset after called
			return
		end

		for _, ply in pairs(player.GetAllPlaying()) do
			if !IsValid(ply) or !ply:IsPlayer() then continue end
			ply:GivePoints(200)
		end
	end),
	anticondition = function(id, pos)
		local barricades = ents.FindByClass("breakable_entry")
		if IsValid(barricades[1]) then
			local b_hasplanks = false
			for _, ent in pairs(barricades) do 
				if ent:GetHasPlanks() and ent:GetNumPlanks() > 0 then
					b_hasplanks = true
					break
				end
			end

			return b_hasplanks
		else
			return false
		end
	end,
	antifunc = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Carpenter!")
			net.WriteBool(false)
		net.Broadcast()

		local barricades = ents.FindByClass("breakable_entry")
		for _, ent in ipairs(barricades) do
			if ent.FullBreak then
				ent:FullBreak()
			end
		end
	end),
})

-- Zombie Blood
nzPowerUps:NewPowerUp("zombieblood", {
	name = "Zombie Blood",
	model = "models/powerups/w_zombieblood.mdl",
	desc = "Player is ignored by all enemies",
	antidesc = "Player is targeted by all enemies",
	global = false, -- Only applies to the player picking it up and time is handled individually per player
	angle = Angle(0,0,0),
	scale = 1,
	chance = 2,
	duration = 30,
	antiduration = 15,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = true,
	loopsound = "nz_moo/powerups/zombieblood_loop.wav",
	stopsound = "nz_moo/powerups/zombieblood_stop.mp3",
	icon_t5 = Material("nz_moo/icons/bo1/classic_clean_powerup_blood_alt_alt.png", "unlitgeneric"),
	icon_t6 = Material("nz_moo/icons/bo2/charred_powerup_blood_alt_alt.png", "unlitgeneric"),
	icon_t7 = Material("nz_moo/icons/t7/specialty_giant_blood_zombies.png", "unlitgeneric"),
	icon_t7zod = Material("nz_moo/icons/t7/specialty_giant_blood_zombies.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_blood.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_blood.png", "unlitgeneric"),
	condition = function(id, pos)
		return #player.GetAllPlaying() > 1
	end,
	func = (function(id, ply)
		if IsValid(ply) then
			ply:SetTargetPriority(TARGET_PRIORITY_NONE)
		end
	end),
	expirefunc = function(id, ply) -- ply is only passed if the powerup is non-global
		if IsValid(ply) then
			ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		end
	end,
	anticond = (function(ply)
		if IsValid(ply) and ply:Alive() and !nzPowerUps:IsPlayerPowerupActive(ply, "zombieblood") and ply:GetTargetPriority() > 0 then
			return true
		end
		return false
	end),
	anticondition = function(id, pos)
		return #player.GetAllPlaying() > 1
	end,
	antifunc = (function(id, ply)
		if not IsValid(ply) then return end

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Zombie Blood!")
			net.WriteBool(false)
		net.Send(ply)

		nzSounds:PlayEnt("Laugh", ply)

		ply.AntiBloodTarget = true
		UpdateAllZombieTargets(ply)
		ParticleEffectAttach("bo3_aat_turned", PATTACH_ABSORIGIN_FOLLOW, ply, 0)
		ply:EmitSound("NZ.POP.Turned.Impact")

		local timername = "AntiBloodRetarget"..ply:EntIndex()
		timer.Create(timername, 0.5, 0, function()
			if not IsValid(ply) then timer.Remove(timername) return end
			if !nzPowerUps:IsPlayerAntiPowerupActive(ply, "zombieblood") then timer.Remove(timername) return end
			UpdateAllZombieTargets(ply)
		end)
	end),
	antiexpirefunc = (function(id, ply)
		if not IsValid(ply) then return end

		if !nzPowerUps:IsPlayerPowerupActive(ply, "zombieblood") then
			ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		end

		if ply.AntiBloodTarget then
			ply.AntiBloodTarget = nil
			ply:StopParticles()
		end

		local timername = "AntiBloodRetarget"..ply:EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) return end
	end),
})

nzPowerUps:NewPowerUp("deathmachine", {
	name = "Death Machine",
	model = "models/powerups/w_deathmachine.mdl",
	desc = "Player gains a powerful weapon with unlimited ammo",
	antidesc = "Player is forced to use a weakened starting pistol",
	global = false,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 3,
	duration = 30,
	antiduration = 15,
	natural = true,
	announcement = true,
	icon_t5 = Material("nz_moo/icons/bo1/classic_clean_powerup_deathmachine.png", "unlitgeneric"),
	icon_t6 = Material("nz_moo/icons/bo2/charred_powerup_deathmachine.png", "unlitgeneric"),
	icon_t7 = Material("nz_moo/icons/t7/t7_hud_zm_powerup_giant_deathmachine.png", "unlitgeneric"),
	icon_t7zod = Material("nz_moo/icons/t7/t7_hud_zm_powerup_deathmachine.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_death_machine.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_death.png", "unlitgeneric"),
	func = (function(id, ply)
		local ourfucker = "deathmachine_swapper"..ply:EntIndex()
		timer.Create(ourfucker, 0, 0, function()
			if not IsValid(ply) then
				if timer.Exists(ourfucker) then
					timer.Remove(ourfucker)
				end
				return
			end

			local wep = ply:GetActiveWeapon()
			if not IsValid(wep) then return end

			if not wep.IsTFAWeapon or not wep.NZSpecialCategory or wep:Holster() then
				ply:SetUsingSpecialWeapon(true)
				ply:Give(nzMapping.Settings.deathmachine or "tfa_nz_bo3_minigun")
				ply:SelectWeapon(nzMapping.Settings.deathmachine or "tfa_nz_bo3_minigun")

				if timer.Exists(ourfucker) then
					timer.Remove(ourfucker)
				end
				return
			end
		end)
	end),
	expirefunc = function(id, ply)
		if not IsValid(ply) then return end

		local ourfucker = "deathmachine_swapper"..ply:EntIndex()
		if timer.Exists(ourfucker) then
			timer.Remove(ourfucker)
		end

		if ply:HasWeapon(nzMapping.Settings.deathmachine or "tfa_nz_bo3_minigun") then
			ply:SetUsingSpecialWeapon(false)
			ply:EquipPreviousWeapon()
			timer.Simple(0, function()
				if not IsValid(ply) then return end
				ply:StripWeapon(nzMapping.Settings.deathmachine or "tfa_nz_bo3_minigun")
			end)
		end
	end,
	anticond = (function(ply)
		if IsValid(ply) and ply:Alive() and ply:GetNotDowned() then
			return true
		end
		return false
	end),
	antifunc = (function(id, ply)
		local ourfucker = "antipistol_swapper"..ply:EntIndex()
		timer.Create(ourfucker, 0, 0, function()
			if not IsValid(ply) then
				if timer.Exists(ourfucker) then
					timer.Remove(ourfucker)
				end
				return
			end

			local wep = ply:GetActiveWeapon()
			if not IsValid(wep) then return end

			if not wep.IsTFAWeapon or not wep.NZSpecialCategory or wep:Holster() then
				ply:SetUsingSpecialWeapon(true)
				ply:Give(nzMapping.Settings.startwep.."_display")
				ply:SelectWeapon(nzMapping.Settings.startwep.."_display")

				if timer.Exists(ourfucker) then
					timer.Remove(ourfucker)
				end
				return
			end
		end)
	end),
	antiexpirefunc = function(id, ply)
		if not IsValid(ply) then return end

		local ourfucker = "antipistol_swapper"..ply:EntIndex()
		if timer.Exists(ourfucker) then
			timer.Remove(ourfucker)
		end

		if ply:HasWeapon(nzMapping.Settings.startwep.."_display") then
			ply:SetUsingSpecialWeapon(false)
			ply:EquipPreviousWeapon()
			timer.Simple(0, function()
				if not IsValid(ply) then return end
				ply:StripWeapon(nzMapping.Settings.startwep.."_display")
			end)
		end
	end,
})

//local bonus points
nzPowerUps:NewPowerUp("bloodmoney", {
	name = "Blood Money",
	model = "models/powerups/w_zmoney.mdl",
	desc = "Player gains a random amount of points",
	global = false,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 0,
	duration = 0,
	natural = false,
	icon_t5 = Material("vgui/bo1_bonus.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_bonus.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_bonus.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_bonus.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_bonus.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_bonus_points.png", "unlitgeneric"),
	announcement = true,
	condition = function(id, pos)
		return false //never spawn naturally
	end,
	func = (function(self, ply)
		ply:GivePoints(math.random(1,6)*50)
	end),
})

//global bonus points
nzPowerUps:NewPowerUp("bonuspoints", {
	name = "Bonus Points",
	model = "models/powerups/w_zmoney.mdl",
	desc = "All players gain a random amount of points",
	antidesc = "All players lose a random amount of points",
	global = true, --Bo4 enstated that Bonus Points are Rated E for everyone!
	angle = Angle(0,0,0),
	scale = 1,
	chance = 2,
	duration = 0,
	antiduration = 0,
	natural = true,
	announcement = true,
	icon_t5 = Material("vgui/bo1_bonus.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_bonus.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_bonus.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_bonus.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_bonus.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_bonus_points.png", "unlitgeneric"),
	func = (function(id, ply)
		local BONUS = (math.random(25,150) * 10) -- Everyone should get the same amount.
		for k, v in pairs(player.GetAllPlaying()) do
			v:GivePoints(BONUS)
		end
	end),
	antifunc = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Bonus Points!")
			net.WriteBool(false)
		net.Broadcast()

		local BONUS = (math.random(25,100) * 10) -- Everyone should get the same amount.
		for k, v in pairs(player.GetAll()) do
			if v:Alive() then
				v:Buy(math.min(BONUS, v:GetPoints()), nil, function() return true end)
			end
		end
	end),
})

--Perk Bottle(the one that gives you a perk slot)
nzPowerUps:NewPowerUp("bottleslot", {
	name = "Broken Bottle",
	model = "models/powerups/w_brokenbottle.mdl",
	desc = "All players gain an additional perk slot",
	antidesc = "All players lose a perk slot",
	rare = true,
	global = true,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 0,
	duration = 0,
	antiduration = 0,
	natural = false,
	announcement = true,
	icon_t5 = Material("vgui/bo1_brokenbottle.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_broken_bottle.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_brokenperk.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_brokenperk.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_perk.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_brokenbottle.png", "unlitgeneric"),
	condition = function(id, pos)
		return GetConVar("nz_difficulty_perks_max"):GetInt() < 8
	end,
	func = (function(id, ply)
		local cvar_maxperks = GetConVar("nz_difficulty_perks_max")
		cvar_maxperks:SetInt(cvar_maxperks:GetInt() + 1)

		nzPerks:IncreaseAllPlayersMaxPerks(1) //see 154 of perks/sh_meta
	end),
	anticondition = function(id, pos)
		if GetConVar("nz_difficulty_perks_max"):GetInt() <= 4 then
			return false
		end

		return nzMapping.Settings.poweruprestriction or nzRound:GetNumber() > 15
	end,
	antifunc = (function(id, ply)
		nzSounds:Play("Laugh")

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Broken Bottle!")
			net.WriteBool(false)
		net.Broadcast()

		local cvar_maxperks = GetConVar("nz_difficulty_perks_max")
		cvar_maxperks:SetInt(cvar_maxperks:GetInt() - 1)

		nzPerks:DecreaseAllPlayersMaxPerks(1)
	end),
})

-- Perk Bottle(The one that actually gives you a perk)
nzPowerUps:NewPowerUp("bottle", {
	name = "Perk Bottle",
	model = "models/powerups/w_perkbottle.mdl",
	desc = "All players gain a random perk not currently held",
	antidesc = "All players lose a random perk from their deck",
	rare = true,
	global = true,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 0,
	duration = 0,
	antiduration = 0,
	natural = false,
	announcement = true,
	icon_t5 = Material("vgui/bo1_perk.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_bottle.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_perk.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_perk.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_perk.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_random_perk_can.png", "unlitgeneric"),
	func = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Free Perk!")
			net.WriteBool(true)
		net.Broadcast()

		for k, v in pairs(player.GetAll()) do
			if v:IsPlaying() or (nzRound:InState(ROUND_CREATE) and v:IsInCreative()) then
				v:GiveRandomPerk()
			end
		end
	end),
	antifunc = (function(id, ply)
		nzSounds:Play("Laugh")

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Free Perk!")
			net.WriteBool(false)
		net.Broadcast()

		for _, ply in pairs(player.GetAll()) do
			if ply:IsPlaying() or (nzRound:InState(ROUND_CREATE) and ply:IsInCreative()) then
				local perks = #ply:GetPerks()
				if perks <= 0 then continue end

				ply:RemovePerk(ply:GetPerks()[math.random(perks)])
			end
		end
	end),
})

nzPowerUps:NewPowerUp("emptybottle", {
	name = "Empty Perk Bottle",
	model = "models/powerups/w_perkbottle.mdl",
	desc = "Player gains an additional perk slot",
	antidesc = "Player loses a perk slot",
	rare = true,
	global = false,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 0,
	duration = 0,
	antiduration = 0,
	natural = false,
	announcement = true,
	icon_t5 = Material("vgui/bo1_perk.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_bottle.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_perk.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_perk.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_perk.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_random_perk_can.png", "unlitgeneric"),
	func = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Perk Slot!")
			net.WriteBool(true)
		net.Send(ply)

		ply:SetMaxPerks(ply:GetMaxPerks() + 1)
	end),
	anticondition = function(id, pos)
		if GetConVar("nz_difficulty_perks_max"):GetInt() <= 4 then
			return false
		end

		return nzMapping.Settings.poweruprestriction or nzRound:GetNumber() > 15
	end,
	antifunc = (function(id, ply)
		nzSounds:PlayEnt("Laugh", ply)

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Perk Slot!")
			net.WriteBool(false)
		net.Send(ply)

		ply:SetMaxPerks(ply:GetMaxPerks() - 1)
	end),
})

--Bonfire Sale
nzPowerUps:NewPowerUp("bonfiresale", {
	name = "BonFire Sale",
	model = "models/powerups/w_bonfire.mdl",
	desc = "All Pack-a-Punch locations become active and upgrades are 1/5th the price",
	antidesc = "All Pack-a-Punch machines become unusable",
	rare = true,
	global = true,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 0,
	duration = 60,
	antiduration = 30,
	addpitch = 5,
	nopitchshift = 0,
	natural = false,
	announcement = true,
	loopsound = "nz_moo/powerups/omnov001l_1_l_stereo.wav",
	stopsound = "nz_moo/powerups/doublepoints_end.mp3",
	icon_t5 = Material("nz_moo/icons/bo1/classic_clean_powerup_bonfire.png", "unlitgeneric"),
	icon_t6 = Material("nz_moo/icons/bo2/charred_powerup_bonfire.png", "unlitgeneric"),
	icon_t7 = Material("nz_moo/icons/t7/powerup_bon_fire.png", "unlitgeneric"),
	icon_t7zod = Material("nz_moo/icons/t7/powerup_bon_fire.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_bonfire.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_bonfire.png", "unlitgeneric"),
	func = (function(id, ply)
	end),
	anticondition = function(id, pos)
		return nzPowerUps:GetHasPaped()
	end,
	antifunc = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Bonfire Sale!")
			net.WriteBool(false)
		net.Broadcast()

		for k, v in pairs(ents.FindByClass("perk_machine")) do
			if v.GetPerkID and v:GetPerkID() == "pap" then
				local timername = "wait_to_apply_hack"..v:EntIndex()
				timer.Create(timername, engine.TickInterval(), 0, function()
					if not IsValid(v) then timer.Remove(timername) return end
					if !v.PapWpn or !IsValid(v.PapWpn) then
						v:SetBeingUsed(true)
						v.PerkUseCoolDown = CurTime() + math.huge
						timer.Remove(timername)
						return
					end
				end)
			end
		end
	end),
	antiexpirefunc = (function(id, ply)
		for k, v in pairs(ents.FindByClass("perk_machine")) do
			if v.GetPerkID and v:GetPerkID() == "pap" then
				v:SetBeingUsed(false)
				v.PerkUseCoolDown = CurTime()

				local timername = "wait_to_apply_hack"..v:EntIndex()
				if timer.Exists(timername) then
					timer.Remove(timername)
				end
			end
		end
	end),
})

nzPowerUps:NewPowerUp("timewarp", {
	name = "TimeWarp",
	model = "models/wavy/powerups/w_timewarp.mdl",
	desc = "All zombies are slowed to shambling speeds and cannot attack players",
	antidesc = "All zombies run at super sprinting speed and spawn at the max spawn rate",
	rare = true,
	global = true,
	angle = Angle(0,0,0),
	scale = 1.5,
	chance = 1,
	duration = 30,
	antiduration = 15,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = true,
	loopsound = "nz_moo/powerups/timewarp_loop.wav",
	stopsound = "nz_moo/powerups/instakill_end.mp3",
	icon_t5 = Material("vgui/classic_clean_powerup_slow.png", "unlitgeneric"),
	icon_t6 = Material("vgui/charred_powerup_slow.png", "unlitgeneric"),
	icon_t7 = Material("vgui/icon_timewarp.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/icon_timewarp.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/powerups/t8_hud_robit_powerup_time_warp.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_time_alt.png", "unlitgeneric"),
	condition = function(id, pos)
		return nzMapping.Settings.poweruprestriction or nzRound:GetNumber() >= 9
	end,
	func = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Time-Warp!")
			net.WriteBool(true)
		net.Broadcast()
	end),
	anticondition = function(id, pos)
		return nzMapping.Settings.poweruprestriction or nzRound:GetNumber() >= 9
	end,
	antifunc = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Time-Warp!")
			net.WriteBool(false)
		net.Broadcast()

		for _, zed in nzLevel.GetZombieArray() do
			if not IsValid(zed) then continue end
			if zed:IsValidZombie() and !(zed.NZBossType or zed.IsMooBossZombie) and (!zed.IsMooSpecial or zed.IsMooSpecial and !zed.MooSpecialZombie) and zed:Alive() then
				zed:SetRunSpeed(200)
				zed:SpeedChanged()
				zed:Retarget()
			end
		end

		if nzRound:GetNumber() < 35 then
			nzRound:EnableRampage()
		end

		nzRound:SetZombieSpeeds({[200] = 100})
		nzRound:SetZombieCoDSpeeds({[200] = 100})
	end),
	antiexpirefunc = (function(id, ply)
		if nzRound:GetRampage() then
			nzRound:DisableRampage()

			nzRound:SetZombieSpeeds(nzCurves.GenerateSpeedTable(nzRound:GetNumber()))
			nzRound:SetZombieCoDSpeeds(nzCurves.GenerateCoDSpeedTable(nzRound:GetNumber()))
		end
	end),
})

nzPowerUps:NewPowerUp("berzerk", {
	name = "Berzerk",
	model = "models/wavy/powerups/w_fullpower.mdl",
	desc = "Player becomes enraged and is unable to take damage, but is reduced to just their fists that instantly kill enemies",
	antidesc = "Player becomes weak and is knocked around easily by zombies",
	global = false,
	angle = Angle(0,0,0),
	scale = 1.2,
	chance = 2,
	duration = 30,
	antiduration = 15,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = true,
	loopsound = "powerups/berzerk_loop.wav",
	stopsound = "powerups/berzerk_end.wav",
	icon_t5 = Material("vgui/t5_bzk.png", "unlitgeneric"),
	icon_t6 = Material("vgui/t6_bzk.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_bzk.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/t7_bzk.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/powerups/bo4_bzk.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_bzk.png", "unlitgeneric"),
	func = (function(id, ply)
		local ourfucker = "berzerker_swapper"..ply:EntIndex()
		timer.Create(ourfucker, 0, 0, function()
			if not IsValid(ply) then
				if timer.Exists(ourfucker) then
					timer.Remove(ourfucker)
				end
				return
			end

			local wep = ply:GetActiveWeapon()
			if not IsValid(wep) then return end

			if not wep.IsTFAWeapon or not wep.NZSpecialCategory or wep:Holster() then
				ply:SetUsingSpecialWeapon(true)
				ply:Give("nz_berzerk_fists")
				ply:SelectWeapon("nz_berzerk_fists")

				if timer.Exists(ourfucker) then
					timer.Remove(ourfucker)
				end
				return
			end
		end)
	end),
	expirefunc = function(id, ply)
		if not IsValid(ply) then return end

		local ourfucker = "berzerker_swapper"..ply:EntIndex()
		if timer.Exists(ourfucker) then
			timer.Remove(ourfucker)
		end

		if ply:HasWeapon("nz_berzerk_fists") then
			ply:SetUsingSpecialWeapon(false)
			ply:EquipPreviousWeapon()
			timer.Simple(0, function()
				if not IsValid(ply) then return end
				ply:StripWeapon("nz_berzerk_fists")
			end)
		end
	end,
	anticond = (function(ply)
		if IsValid(ply) and ply:Alive() and ply:GetNotDowned() then
			return true
		end
		return false
	end),
	antifunc = (function(id, ply)
		if not IsValid(ply) then return end
		nzSounds:Play("Laugh")

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Berzerk!")
			net.WriteBool(false)
		net.Send(ply)
	end),
	antiexpirefunc = (function(id, ply)
	end),
})

nzPowerUps:NewPowerUp("infinite", {
	name = "Infinite Ammo",
	model = "models/powerups/w_infinite.mdl",
	desc = "All players weapons dont consume ammo",
	antidesc = "All players are unable to fire their weapons",
	rare = true,
	global = true,
	angle = Angle(25,0,0),
	scale = 1.2,
	chance = 1,
	duration = 20,
	antiduration = 10,
	addpitch = 50,
	nopitchshift = 0,
	natural = true,
	announcement = true,
	loopsound = "powerups/infiniteammo_loop.wav",
	stopsound = "powerups/infiniteammo_end.mp3",
	icon_t5 = Material("vgui/bo1_infinite.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_infinite.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_infinite.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_infinite.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_bottomless_clip.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_infinite.png", "unlitgeneric"),
	func = (function(id, ply)
		local clipSizeCheckTimerName = "clipSizeCheckTimer"
		local illegalspecials = {
			["specialweapon"] = true, //would do nothing
			["grenade"] = true, //would do nothing
			["knife"] = true,
			["display"] = true,
		}

		local function RefillPlayersClip()
			for _, ply in ipairs(player.GetAll()) do
				local wep = ply:GetActiveWeapon()
				if not IsValid(wep) then continue end
				if wep.NZSpecialCategory and illegalspecials[wep.NZSpecialCategory] then continue end

				if wep.IsTFAWeapon then
					if (wep.Primary_TFA) then
						local clipsize = wep.Primary_TFA.ClipSize
						if clipsize and clipsize > 0 and wep:Clip1() < clipsize and wep:GetPrimaryAmmoType() > 0 then
							wep:SetClip1(clipsize)
						end
					end
					if (wep.Secondary_TFA) then
						local clipsize2 = wep.Secondary_TFA.ClipSize
						if clipsize2 and clipsize2 > 0 and wep:Clip2() < clipsize2 and wep:GetSecondaryAmmoType() > 0 then
							wep:SetClip2(clipsize2)
						end
					end
				else
					if wep:GetMaxClip1() > 0 then
						wep:SetClip1(wep:GetMaxClip1())
					end
					if wep:GetMaxClip2() > 0 then
						wep:SetClip2(wep:GetMaxClip2())
					end
				end
			end
		end

		RefillPlayersClip()
		timer.Create(clipSizeCheckTimerName, 0.1, 0, function()
			if nzPowerUps:IsPowerupActive("infinite") then
				RefillPlayersClip()
			else
				timer.Remove(clipSizeCheckTimerName)
			end
		end)

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Infinite Ammo!")
			net.WriteBool(true)
		net.Broadcast()
	end),
	expirefunc = (function(id, ply)
		if timer.Exists("clipSizeCheckTimer") then
			timer.Remove("clipSizeCheckTimer")
		end
	end),
	antifunc = (function(id, ply)
		hook.Add("TFA_CanPrimaryAttack", "nzAntiInfiniteAmmo", function(wep)
			if nzPowerUps:IsAntiPowerupActive("infinite") then
				return false
			end
		end)
	end),
	antiexpirefunc = (function(id, ply)
		hook.Remove("TFA_CanPrimaryAttack", "nzAntiInfiniteAmmo")
	end)
})

nzPowerUps:NewPowerUp("random", {
	name = "Mystery",
	model = "models/powerups/w_random.mdl",
	desc = "Activates a random Power-Up",
	antidesc = "Activates a random Anti Power-Up",
	global = true,
	angle = Angle(25,0,0),
	scale = 1.2,
	chance = 3,
	duration = 0,
	antiduration = 0,
	addpitch = 50,
	nopitchshift = 0,
	natural = false,
	icon_t5 = Material("vgui/bo1_mystery.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_mystery.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_mystery.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_mystery.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_mystery.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_mystery.png", "unlitgeneric"),
	func = (function(id, ply)
		local powerups = {
			["maxammo"] = 3,
			["nuke"] = 3,
			["dp"] = 3,
			["timewarp"] = 2,
			["insta"] = 2,
			["infinite"] = 2,
			["bonuspoints"] = 3, 
			["bottle"] = 1, --bottles are now much rarer
		}

		nzPowerUps:Activate(nzMisc.WeightedRandom(powerups), ply)
	end),
	antifunc = (function(id, ply)
		local powerups = {
			["maxammo"] = 3,
			["nuke"] = 3,
			["dp"] = 3,
			["timewarp"] = 2,
			["insta"] = 2,
			["infinite"] = 2,
			["bonuspoints"] = 3, 
		}

		nzPowerUps:ActivateAnti(nzMisc.WeightedRandom(powerups))
	end),
})

nzPowerUps:NewPowerUp("packapunch", {
	name = "Pack A Punch",
	model = "models/powerups/w_packapunch.mdl",
	desc = "Players held weapon is upgraded",
	antidesc = "Players held weapon is downgraded",
	rare = true,
	global = false,
	angle = Angle(25,0,0),
	scale = 0.8,
	chance = 1,
	duration = 0,
	antiduration = 0,
	addpitch = 50,
	nopitchshift = 0,
	natural = false,
	announcement = true,
	icon_t5 = Material("vgui/bo1_pap.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_pap.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_pap.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_pap.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_pap.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_pap.png", "unlitgeneric"),
	func = (function(id, ply)
		local wep = ply:GetActiveWeapon()
		if wep.NZSpecialCategory and !wep.OnPaP then
			for k, v in pairs(ply:GetWeapons()) do
				if v:GetNWInt("SwitchSlot", 0) > 0 and not v:HasNZModifier("pap") then
					wep = v
					break
				end
			end
		end
		if not IsValid(wep) then return end

		if wep.NZPaPReplacement then
			local wep2 = ply:Give(wep.NZPaPReplacement)
			wep2:ApplyNZModifier("pap")
			ply:SelectWeapon(wep2:GetClass())
			ply:StripWeapon(wep:GetClass())

			hook.Call("OnPlayerBuyPackAPunch", nil, ply, wep2, nil)
		elseif wep.OnPaP then
			if wep:HasNZModifier("pap") then
				wep:ApplyNZModifier("repap")
			else
				wep:ApplyNZModifier("pap")
			end

			wep:ResetFirstDeploy()
			wep:CallOnClient("ResetFirstDeploy", "")
			wep:Deploy()
			wep:CallOnClient("Deploy", "")

			hook.Call("OnPlayerBuyPackAPunch", nil, ply, wep, nil)
		end
	end),
	anticondition = function(id, pos)
		return nzPowerUps:GetHasPaped()
	end,
	anticond = (function(ply)
		if IsValid(ply) and ply:Alive() then
			for k, v in ipairs(ply:GetWeapons()) do
				if v:HasNZModifier("pap") then
					return true
				end
			end
			return false
		end
		return false
	end),
	antifunc = (function(id, ply)
		if not IsValid(ply) then return end
		local wep
		for k, v in ipairs(ply:GetWeapons()) do
			if v:HasNZModifier("pap") then
				wep = v
				break
			end
		end

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Pack a' Punch!")
			net.WriteBool(false)
		net.Send(ply)

		nzSounds:PlayEnt("Laugh", ply)
		ParticleEffect("bo3_qed_explode_1", ply:GetPos(), angle_zero)

		timer.Simple(0, function()
			if not IsValid(ply) or not IsValid(wep) then return end
			ply:StripWeapon(wep:GetClass())
			ply:Give(wep:GetClass())
		end)
	end),
})

nzPowerUps:NewPowerUp("godmode", {
	name = "Invulnerability",
	model = "models/powerups/w_godmode.mdl",
	desc = "Player is granted god mode, but all zombies target the player",
	antidesc = "Enemies take no damage from the player, and no points are earned",
	rare = true,
	global = false,
	angle = Angle(0, 0, 0),
	scale = 1.2,
	chance = 1,
	duration = 20,
	antiduration = 10,
	addpitch = 5,
	nopitchshift = 0,
	natural = false,
	announcement = true,
	loopsound = "powerups/lattegodmode_loop.wav",
	stopsound = "powerups/godmode_end.mp3",
	icon_t5 = Material("vgui/bo1_greyson.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_greyson.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_greyson.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_greyson.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4/bo4_greyson.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_greyson.png", "unlitgeneric"),
	condition = function(id, pos)
		return #player.GetAllPlaying() > 1
	end,
	func = (function(id, ply)
		ply:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
		UpdateAllZombieTargets(ply)
	end),
	expirefunc = function(id, ply) -- ply is only passed if the powerup is non-global
		if IsValid(ply) then
			ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		end
	end,
	anticondition = function(id, pos)
		return #player.GetAllPlaying() > 1
	end,
	anticond = (function(ply)
		if IsValid(ply) and ply:Alive() and ply:GetNotDowned() then
			return true
		end
		return false
	end),
	antifunc = (function(id, ply)
		if not IsValid(ply) then return end
		nzSounds:Play("Laugh")

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Godmode!")
			net.WriteBool(false)
		net.Send(ply)
	end),
	antiexpirefunc = (function(id, ply)
	end),
})

nzPowerUps:NewPowerUp("weapondrop", {
	name = "Random Weapon",
	model = "models/powerups/w_randomgun.mdl",
	desc = "Player acquires a random weapon from the weapon box list",
	antidesc = "Players weapon is stolen by zombies",
	global = false,
	angle = Angle(0,0,0),
	scale = 1,
	chance = 2,
	duration = 0,
	antiduration = 0,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = true,
	icon_t5 = Material("vgui/bo1_randomgun.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_randomgun.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_randomgun.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_randomgun.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_randomgun.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_randomguns.png", "unlitgeneric"),
	pressuse = true,
	spawnfunc = (function(id, ent)
		if not IsValid(ent) then return end
		if ent.GetAnti and ent:GetAnti() then
			local ply, wep
			local c = 0
			for k, v in RandomPairs(player.GetAll()) do
				for _, gun in RandomPairs(v:GetWeapons()) do
					if (gun:GetNWInt("SwitchSlot", 0) > 0 or (v:IsInCreative() and not gun.NZSpecialCategory)) and not nzConfig.WeaponBlackList[gun.ClassName] and gun.PrintName then
						c = c + 1
						if c > 1 then
							ply = v
							wep = gun
							break
						end
					end
				end
			end

			if not IsValid(ply) or not IsValid(wep) then
				ent:SetPressUse(false)
				ent:SetHintString("Uh Oh...")
				PrintMessage(HUD_PRINTTALK, "[NZ] No players alive with enough weapons, anti 'weapondrop' will select a random persons active weapon!")
				return
			end

			ent.WeaponOwner = ply
			ent.WeaponPickup = wep.ClassName
			ent:SetPressUse(false)
			ent:SetHintString(ply:Nick().."'s "..wep.PrintName)

			local wepmodel = ents.Create(wep.ClassName)
			ent:SetModel(wepmodel:GetWeaponWorldModel())
			ent:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")
			SafeRemoveEntityDelayed(wepmodel, 0)

			local ourhookname = "nzWeapnoDropAnti"..ply:EntIndex()
			hook.Add("WeaponEquip", ourhookname, function(weapon, owner)
				timer.Simple(0.2, function()
					if not IsValid(ent) then hook.Remove("WeaponEquip", ourhookname) return end
					if not IsValid(ply) then hook.Remove("WeaponEquip", ourhookname) return end
					if ent:GetPowerUp() ~= "weapondrop" then hook.Remove("WeaponEquip", ourhookname) return end
					if not IsValid(owner) or not owner:IsPlayer() then return end
					if owner ~= ply then return end
					if weapon:GetNWInt("SwitchSlot", 0) == 0 then return end
					if not owner:HasWeapon(ent.WeaponPickup) then
						ent.WeaponPickup = weapon.ClassName
						ent:SetHintString(ply:Nick().."'s "..weapon.PrintName)
						ent:SetModel(weapon.WorldModel or weapon:GetWeaponWorldModel())
						timer.Simple(0, function()
							if not IsValid(ent) then return end
							ent:StopParticles()
						end)
					end
				end)
			end)
		else
			if not nzMapping.Settings.rboxweps then
				PrintMessage(HUD_PRINTTALK, "[NZ] No box weapons setup, cannot reward gun")
				return
			end

			local guns = {}
			local blacklist = table.Copy(nzConfig.WeaponBlackList)

			local weplist = weapons.GetList()
			for _, wep in pairs(weplist) do
				if wep.NZSpecialCategory or wep.NZWonderWeapon then
					blacklist[wep.ClassName] = true
				end
			end

			for k, v in pairs(nzMapping.Settings.rboxweps) do
				if !blacklist[k] then
					guns[k] = v
				end
			end

			if table.IsEmpty(guns) then
				PrintMessage(HUD_PRINTTALK, "[NZ] No selectable guns found, cannot reward gun")
				return
			end

			local class = nzMisc.WeightedRandom(guns)
			local wep = weapons.Get(class)
			if not wep then
				PrintMessage(HUD_PRINTTALK, "[NZ] Weapon does not exist, possibly outdated box list, cannot reward gun")
				return
			end

			ent.WeaponPickup = wep.ClassName
			ent:SetHintString("Pickup "..wep.PrintName)

			local wepmodel = ents.Create(wep.ClassName)
			ent:SetModel(wepmodel:GetWeaponWorldModel())
			ent:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")
			SafeRemoveEntityDelayed(wepmodel, 0)
		end
	end),
	func = (function(id, ply, ent)
		local class = nzRandomBox.DecideWep(ply)
		if IsValid(ent) and ent.WeaponPickup then
			class = ent.WeaponPickup
		end

		ply:Give(class)
	end),
	anticondition = function(id, pos)
		return nzMapping.Settings.poweruprestriction or nzRound:GetNumber() > (#player.GetAllPlaying() > 1 and 6 or 12)
	end,
	anticond = (function(ply)
		if IsValid(ply) and ply:Alive() and ply:GetNotDowned() then
			return true
		end
		return false
	end),
	antifunc = (function(id, ply, ent)
		if not IsValid(ply) then return end

		local class
		for _, gun in RandomPairs(ply:GetWeapons()) do
			if gun:GetNWInt("SwitchSlot", 0) > 0 then
				class = gun:GetClass()
				break
			end
		end

		if IsValid(ent) and ent.WeaponOwner then
			class = ent.WeaponPickup
			ply = ent.WeaponOwner
		end

		if IsValid(ply) and class then
			net.Start("nzPowerUps.PickupHud")
				net.WriteString("Yoink")
				net.WriteBool(false)
			net.Send(ply)

			ply:StripWeapon(class)
			ply:Give("tfa_bo3_wepsteal")
			ply:SelectWeapon("tfa_bo3_wepsteal")

			nzSounds:PlayEnt("Bye", ply)
		end

		//this is probably the most illegal code ive ever wrote, and should get me thrown in jail
		for i=1, game.MaxPlayers() do
			hook.Remove("WeaponEquip", "nzWeapnoDropAnti"..i)
		end
	end),
})

nzPowerUps:NewPowerUp("quickfoot", {
	name = "Quick Foot",
	model = "models/powerups/w_quickfoot.mdl",
	desc = "Players movespeed is greatly increased",
	antidesc = "Players movespeed is greatly decreased",
	global = false,
	angle = Angle(0,0,0),
	scale = 1.2,
	chance = 2,
	duration = 30,
	antiduration = 15,
	addpitch = 5,
	nopitchshift = 0,
	natural = false,
	announcement = true,
	loopsound = "powerups/quick_loop.wav",
	stopsound = "nz_moo/powerups/zombieblood_stop.mp3",
	icon_t5 = Material("vgui/bo1_quick.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_quick.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_quick.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_quick.png", "unlitgeneric"),
	icon_t8 = Material("nz_moo/icons/bo4/t8_hud_robit_powerup_fast_feet.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_fast.png", "unlitgeneric"),
	func = (function(id, ply)
		ply:SetWalkSpeed(300)
		ply:SetRunSpeed(600)
		ply:SetMaxRunSpeed(600)
	end),
	expirefunc = function(id, ply)
		ply:SetWalkSpeed(ply:HasPerk("staminup") and 210 or (ply:IsInCreative() and 200 or 190))
		ply:SetRunSpeed(ply:HasPerk("staminup") and 341 or (ply:IsInCreative() and 400 or 310))
		ply:SetMaxRunSpeed(ply:HasPerk("staminup") and 341 or (ply:IsInCreative() and 400 or 310))
	end,
	anticond = (function(ply)
		if IsValid(ply) and ply:Alive() and !nzPowerUps:IsPlayerPowerupActive(ply, "quickfoot") then
			return true
		end
		return false
	end),
	antifunc = (function(id, ply)
		if not IsValid(ply) then return end

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Quick Foot!")
			net.WriteBool(false)
		net.Send(ply)

		ply:SetWalkSpeed(140)
		ply:SetRunSpeed(140)
		ply:SetMaxRunSpeed(140)
	end),
	antiexpirefunc = (function(id, ply)
		if not IsValid(ply) then return end

		ply:SetWalkSpeed(ply:HasPerk("staminup") and 210 or (ply:IsInCreative() and 200 or 190))
		ply:SetRunSpeed(ply:HasPerk("staminup") and 341 or (ply:IsInCreative() and 400 or 310))
		ply:SetMaxRunSpeed(ply:HasPerk("staminup") and 341 or (ply:IsInCreative() and 400 or 310))
	end),
})

nzPowerUps:NewPowerUp("fullarmor", {
	name = "Full Armor",
	model = "models/powerups/wm_s4_full_armor.mdl",
	desc = "All players gain full armor",
	antidesc = "All players lose their armor",
	global = true,
	angle = Angle(0,0,0),
	scale = 1.2,
	chance = 3,
	duration = 0,
	antiduration = 0,
	addpitch = 5,
	nopitchshift = 0,
	natural = true,
	announcement = true,
	icon_t5 = Material("vgui/bo1_mystery.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_mystery.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_mystery.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_mystery.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_mystery.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_mystery.png", "unlitgeneric"),
	func = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Full Armor!")
			net.WriteBool(true)
		net.Broadcast()

		for k, v in pairs(player.GetAll()) do
			local bonus = math.max(200, v:Armor())
			v:SetArmor(bonus)
			v:EmitSound("nzr/2023/buildables/zm_common.all.sabl.1471.wav", SNDLVL_GUNFIRE)
		end
	end),
	antifunc = (function(id, ply)
		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Full Armor!")
			net.WriteBool(true)
		net.Broadcast()

		for k, v in pairs(player.GetAll()) do
			v:SetArmor(0)
		end
	end),
})

nzPowerUps:NewPowerUp("random_gum", {
	name = "Random Gum",
	model = "models/powerups/wm_gumball.mdl",
	desc = "Player acquires a random Gobble Gum",
	global = false,
	angle = Angle(0,0,0),
	scale = 6,
	chance = 1,
	duration = 0,
	antiduration = 0,
	addpitch = 5,
	nopitchshift = 0,
	natural = false,
	announcement = true,
	icon_t5 = Material("vgui/bo1_mystery.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_mystery.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_mystery.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_mystery.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_mystery.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_mystery.png", "unlitgeneric"),
	pressuse = true,
	spawnfunc = (function(id, ent)
		if not IsValid(ent) then return end
		ent:SetHintString("Pickup random gum")
	end),
	func = function(id, ply)
		local gums = {} -- Create a list of all available gums
		for id, data in pairs(nzGum.Gums) do
			if nzMapping.Settings.gumlist and (!nzMapping.Settings.gumlist[id] or !nzMapping.Settings.gumlist[id][1]) then continue end
			if data.multiplayer and (#player.GetAllPlaying() <= 1) then continue end

			if data.canroll and !data.canroll(ply, self) then continue end
			local pgum = nzGum:GetActiveGum(ply)
			if pgum and pgum == id then continue end

			local rarity = nzGum:GetGumRare(id)
			local mult = nzGum.ChanceMultiplier[rarity]
			if nzMapping.Settings.gummultipliers and nzMapping.Settings.gummultipliers[rarity] then
				mult = nzMapping.Settings.gummultipliers[rarity]
			end

			gums[id] = nzGum.RollChance * mult
		end

		-- Check if there are any gums available
		if table.IsEmpty(gums) then
			print("No available gums!")
			return
		end

		local gum = nzMisc.WeightedRandom(gums)
		nzGum:SetActiveGum(ply, gum)

		local wep = ply:Give("tfa_nz_gum")
		if IsValid(wep) and wep.SetGum then
			wep:SetGum(gum)
		end
	end,
})

nzPowerUps:NewPowerUp("restock", {
	name = "Ammo Restock",
	model = "models/powerups/w_maxammo.mdl",
	desc = "Players weapon ammo, grenades, tacticals, and equipment are refilled",
	antidesc = "Players active weapons reserve ammo is emptied",
	global = false,
	angle = Angle(0,0,25),
	scale = 1,
	chance = 1,
	duration = 0,
	antiduration = 0,
	natural = false,
	icon_t5 = Material("vgui/bo1_max.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_max.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_max.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_max.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_maxammo.png", "unlitgeneric"),
	icon_t9 = Material("vgui/robit_cw_powerup_max_ammo.png", "unlitgeneric"),
	func = (function(id, ply)
		if not IsValid(ply) then return end

		nzSounds:PlayEnt("MaxAmmo", ply)

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Ammo Restocked!")
			net.WriteBool(true)
		net.Send(ply)

		ply:GiveMaxAmmo()
	end),
	antifunc = (function(id, ply)
		if not IsValid(ply) then return end

		net.Start("nzPowerUps.PickupHud")
			net.WriteString("Anti Ammo Restock!")
			net.WriteBool(false)
		net.Send(ply)

		nzSounds:PlayEnt("Laugh", ply)

		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end

		local ammo = wep:GetPrimaryAmmoType()
		if ammo > 0 then
			ply:SetAmmo(0, ammo)
		end

		local ammo2 = wep:GetSecondaryAmmoType()
		if ammo2 > 0 then
			ply:SetAmmo(0, ammo2)
		end
	end),
})

nzPowerUps:NewPowerUp("security", {
	name = "Security",
	model = "models/moo/_codz_ports_props/s1/zm/pickups_zombies_01_trap/_codz_pickups_zombies_01_trap.mdl",
	desc = "All Traps on the map become activated, and all barricades gain a hydrogen barrier that kills zombies",
	global = true,
	angle = Angle(0,0,0),
	scale = 1.8,
	chance = 0,
	duration = 30,
	natural = false,
	icon_t5 = Material("vgui/bo1_mystery.png", "unlitgeneric"),
	icon_t6 = Material("vgui/bo2_mystery.png", "unlitgeneric"),
	icon_t7 = Material("vgui/bo3_mystery.png", "unlitgeneric"),
	icon_t7zod = Material("vgui/bo3_mystery.png", "unlitgeneric"),
	icon_t8 = Material("vgui/bo4_mystery.png", "unlitgeneric"),
	icon_t9 = Material("vgui/cw_mystery.png", "unlitgeneric"),
	condition = function(id, position)
		return nzElec:IsOn()
	end,
	reapply = function(id, ply)
		local duration = 30
		if nzPowerUps.ActivePowerUps[id] then
			duration = math.max(nzPowerUps.ActivePowerUps[id] - CurTime(), duration)
		end

		for _, ent in pairs(ents.GetAll()) do
			if ent:IsActivatable() and ent.Trap then
				ent:Activation(nil, duration, 10)
			end
		end
	end,
	func = (function(id, ply)
		if not IsValid(ply) then return end

		nzSounds:PlayFile("nz_moo/powerups/security/zct_turret_alarm.wav")

		local duration = 30
		if nzPowerUps.ActivePowerUps[id] then
			duration = math.max(nzPowerUps.ActivePowerUps[id] - CurTime(), duration)
		end

		local b_hasturrets = false
		local b_hasbarricades = false
		for _, ent in pairs(ents.GetAll()) do
			if ent:IsActivatable() and ent.Trap then
				if ent:GetClass() == "nz_trap_turret" and !b_hasturrets then
					b_hasturrets = true
				end
				ent:Activation(nil, duration, 10)
			end

			if ent:GetClass() == "breakable_entry" then
				local zapr = ents.Create("nz_securitybarrier")
				zapr:SetPos(ent:GetPos())
				zapr:SetAngles(ent:GetAngles())
				zapr:SetParent(ent)
				zapr:SetOwner(ply)
				zapr:Spawn()

				if !b_hasbarricades then
					b_hasbarricades = true
				end
			end
		end

		if b_hasturrets then
			nzSounds:PlayFile("nz_moo/powerups/security/zct_defence_turrets.wav")

			if b_hasbarricades then
				timer.Simple(2.1, function()
					if not nzPowerUps:IsPowerupActive("security") then return end
					nzSounds:PlayFile("nz_moo/powerups/security/zct_defence_barriers.wav")
				end)
			end
		elseif b_hasbarricades then
			nzSounds:PlayFile("nz_moo/powerups/security/zct_defence_barriers.wav")
		end
	end),
	expirefunc = (function(id, ply)
		for _, ent in pairs(ents.GetAll()) do
			if ent:IsActivatable() and ent.Trap then
				ent:Deactivation()
			end
		end

		for k, v in pairs(ents.FindByClass("nz_securitybarrier")) do
			v:Remove()
		end
	end),
})