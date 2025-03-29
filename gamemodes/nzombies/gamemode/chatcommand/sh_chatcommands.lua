concommand.Add("spawnpowerup", function(ply, cmd, args)
	if IsValid(ply) and ply.IsSuperAdmin and ply:IsSuperAdmin() then
		nzPowerUps:SpawnPowerUp(ply:GetEyeTrace().HitPos + ply:GetEyeTrace().HitNormal, args[1])
	end
end)

concommand.Add("spawnantipowerup", function(ply, cmd, args)
	if IsValid(ply) and ply.IsSuperAdmin and ply:IsSuperAdmin() then
		nzPowerUps:SpawnAntiPowerUp(ply:GetEyeTrace().HitPos + ply:GetEyeTrace().HitNormal, args[1])
	end
end)

concommand.Add("triggerpowerup", function(ply, cmd, args)
    if ply.IsSuperAdmin and ply:IsSuperAdmin() then
        nzPowerUps:Activate(args[1], ply)
    end
end)



concommand.Add("propocalypse", function(ply, cmd, args)
   -- if ply.IsSuperAdmin and ply:IsSuperAdmin() then
      for _,ent in pairs(ents.GetAll()) do if nzMapping.MarkedProps[ent:MapCreationID()] then 
	  ent:Remove()
		end
	  end
	--end
end)


-- fixes

nzChatCommand.Add("/fixme", SERVER, function(ply, text)
	if IsValid(ply) then
		ply:SetUsingSpecialWeapon(false)
		ply:EquipPreviousWeapon()
		ply:ConCommand("snd_restart")

		timer.Simple(0, function()
			if not IsValid(ply) then return end
			nzMapping:SendMapData(ply)
		end)

		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep:HasNZModifier("pap") then
			nzCamos:GenerateCamo(ply, wep)
		end
	end
end, true, "If something fucky is afoot, try this. No guarantees.")

nzChatCommand.Add("/fixbarricades", SERVER, function(ply, text) -- Moo Mark: Added this so new barricades can automatically be reposed correctly(Just don't do it more than once.)
    if IsValid(ply) and ply:IsAdmin() then
        for k, v in pairs(ents.FindByClass("breakable_entry")) do
        	v:SetPos(v:GetPos() - Vector(0,0,45))
    	end
    end
end, false, "Fixes the positions on ALL the barricades if they're using the old ones.")

nzChatCommand.Add("/revertbarricades", SERVER, function(ply, text)
    if IsValid(ply) and ply:IsAdmin() then
        for k, v in pairs(ents.FindByClass("breakable_entry")) do
        	v:SetPos(v:GetPos() + Vector(0,0,45))
    	end
    end
end, false, "Reverts barricade's positions back to the original ones.")

nzChatCommand.Add("/preloadbox", SERVER, function(ply, text)
    if IsValid(ply) and ply:IsAdmin() then
		local thingy = ents.Create("random_box_windup_precache")
		thingy:SetAngles(ply:GetAngles())
		thingy:SetPos( ply:GetPos() + Vector(0,0,45) )
		thingy:Spawn()
    end
end, false, "Spawns a dumby entity that cycles through the Box weapons in an effort to reduce freezing and hitching during inital box spins.")

nzChatCommand.Add("/home", SERVER, function(ply, text)
	local spawns = ents.FindByClass("player_spawns")
	if not IsValid(spawns[1]) then return end

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

	ply:SetPos(finalpos + vector_up)
end, true, "Teleport to first available player spawn, use if stuck.")

-- general

nzChatCommand.Add("/cheats", CLIENT, function(ply, text)
	if CLIENT then
		if !IsValid(g_nz_cheats) then
			g_nz_cheats = vgui.Create("NZCheatFrame")
		else
			g_nz_cheats:Remove()
		end
	else
		return true
	end
end, false, "Opens the cheat panel.")

nzChatCommand.Add("/printperks", SERVER, function(ply, text)
	for k, v in pairs(nzPerks.Data) do
		if v.specialmachine then continue end
		ply:PrintMessage(HUD_PRINTCONSOLE, k)
	end
end, true, "Prints all perks internal names to console.")

nzChatCommand.Add("/printgums", SERVER, function(ply, text)
	for k, v in pairs(nzPerks.Gums) do
		ply:PrintMessage(HUD_PRINTCONSOLE, k)
	end
end, true, "Prints all perks internal names to console.")

nzChatCommand.Add("/printpowerups", SERVER, function(ply, text)
	for k, v in pairs(nzPowerUps.Data) do
		ply:PrintMessage(HUD_PRINTCONSOLE, k)
	end
end, true, "Prints all powerup internal names to console.")

nzChatCommand.Add("/help", SERVER, function(ply, text)
	ply:PrintMessage( HUD_PRINTTALK, "[NZ] Available commands:" )
	ply:PrintMessage( HUD_PRINTTALK, "Arguments in [] are optional." )

	local commands = {}
	for _, cmd in pairs(nzChatCommand.commands) do
		local cmdText = cmd[1]
		if cmd[4] then
			cmdText = cmdText .. " " .. cmd[4]
		end
		if cmd[3] or (!cmd[3] and ply:IsSuperAdmin()) then
			commands[#commands + 1] = cmdText
		end
	end

	for i=1, #commands do
		local msg = commands[i]
		timer.Simple(i*engine.TickInterval(), function()
			ply:PrintMessage(HUD_PRINTTALK, msg)
		end)
	end

	timer.Simple((#commands + 1)*engine.TickInterval(), function()
		ply:PrintMessage(HUD_PRINTTALK, "")
	end)
end, true, "Print this list.")

nzChatCommand.Add("/ready", SERVER, function(ply, text)
	ply:ReadyUp()
end, true, "Mark yourself as ready.")

nzChatCommand.Add("/unready", SERVER, function(ply, text)
	ply:UnReady()
end, true, "Mark yourself as unready.")

nzChatCommand.Add("/dropin", SERVER, function(ply, text)
	ply:DropIn()
end, true, "Drop into the next round.")

nzChatCommand.Add("/dropout", SERVER, function(ply, text)
	ply:DropOut()
end, true, "Drop out of the current round.")

nzChatCommand.Add("/create", SERVER, function(ply, text)
	local plyToCreate
	if text[1] then plyToCreate = player.GetByName(text[1]) else plyToCreate = ply end
	
	if IsValid(plyToCreate) then
		plyToCreate:ToggleCreativeMode()
	else
		ply:ChatPrint("[NZ] Could not find player '"..text[1].."', are you sure they exist?")
	end
end, false, "Respawn in creative mode.")

nzChatCommand.Add("/save", SERVER, function(ply, text)
	if nzRound:InState( ROUND_CREATE ) then
		net.Start("nz_SaveConfig")
			net.WriteString(nzMapping.CurrentConfig or "")
		net.Send(ply)
	else
		ply:PrintMessage( HUD_PRINTTALK, "[NZ] You can't save a config outside of creative mode." )
	end
end, false, "Save your changes to a config.")

nzChatCommand.Add("/load", SERVER, function(ply, text)
	if nzRound:InState( ROUND_CREATE) or nzRound:InState( ROUND_WAITING ) then
		nzInterfaces.SendInterface(ply, "ConfigLoader", nzMapping:GetConfigs())
	else
		ply:PrintMessage( HUD_PRINTTALK, "[NZ] You can't load while playing!" )
	end
end, false, "Open the map config load dialog.")

nzChatCommand.Add("/clean", SERVER, function(ply, text)
	if nzRound:InState( ROUND_CREATE) or nzRound:InState( ROUND_WAITING ) then
		nzMapping:ClearConfig()

		local data = nzMapping.Settings
		nzMapping:LoadMapSettings(data)
	else
		ply:PrintMessage( HUD_PRINTTALK, "[NZ] You can't clean while playing!" )
	end
end)

-- Tests

nzChatCommand.Add("/spectate", SERVER, function(ply, text)
	if !nzRound:InProgress() or nzRound:InState( ROUND_INIT ) then
		ply:PrintMessage( HUD_PRINTTALK, "[NZ] No round in progress, couldnt set you to spectator!" )
	elseif ply:IsReady() then
		ply:UnReady()
		ply:SetSpectator()
	else
		ply:SetSpectator()
	end
end, true)

-- admin only cheat commands

nzChatCommand.Add("/maxammo", SERVER, function(ply, text)
	nzPowerUps:Activate('maxammo')
end, false, "Gives all players max ammo.")

nzChatCommand.Add("/powerup", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local powerup = text[1]
		local plyv = text[2] and player.GetByName(text[2]) or ply
		if not IsValid(plyv) then return end

		if nzPowerUps:Get(powerup) then
			nzPowerUps:Activate(powerup, plyv)
		else
			ply:ChatPrint("[NZ] No valid powerup provided.")
		end
	end
end, false, "Activates given powerup.")

nzChatCommand.Add("/antipowerup", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local powerup = text[1]
		local plyv = text[2] and player.GetByName(text[2]) or ply
		if not IsValid(plyv) then return end

		if nzPowerUps:Get(powerup) and nzPowerUps:Get(powerup).antifunc then
			nzPowerUps:ActivateAnti(powerup, plyv)
		else
			ply:ChatPrint("[NZ] No valid anti powerup provided.")
		end
	end
end, false, "Activates given anti powerup, if it exists.")

nzChatCommand.Add("/revive", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local plyToRev = text[1] and player.GetByName(text[1]) or ply
		if IsValid(plyToRev) and !plyToRev:GetNotDowned() then
			plyToRev:RevivePlayer()
		else
			ply:ChatPrint("[NZ] Player could not be revived, are you sure they're down?")
		end
	end
end, false, "[playerName] Revive yourself or another player.")

nzChatCommand.Add("/givepoints", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local plyToGiv = player.GetByName(text[1])
		local points

		if !plyToGiv then
			points = tonumber(text[1])
			plyToGiv = ply
		else
			points = tonumber(text[2])
		end

		if IsValid(plyToGiv) and plyToGiv:Alive() and (plyToGiv:IsPlaying() or nzRound:InState(ROUND_CREATE)) then
			if points then
				plyToGiv:GivePoints(points)
			else
				ply:ChatPrint("[NZ] No valid number provided.")
			end
		else
			ply:ChatPrint("[NZ] The player you have selected is either not valid or not alive.")
		end
	end
end, false, "[playerName] pointAmount Give points to yourself or another player.")

nzChatCommand.Add("/giveweapon", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local plyToGiv = player.GetByName(text[1])

		local wep

		if !plyToGiv then
			wep = weapons.Get(text[1])
			plyToGiv = ply
		else
			wep = weapons.Get(text[2])
		end
		if IsValid(plyToGiv) and plyToGiv:Alive() and (plyToGiv:IsPlaying() or nzRound:InState(ROUND_CREATE)) then
			if wep then
				plyToGiv:Give(wep.ClassName, true)
			else
				ply:ChatPrint("[NZ] No valid weapon provided.")
			end
		else
			ply:ChatPrint("[NZ] The player you have selected is either not valid or not alive.")
		end
	end
end, false, "[playerName] weaponName Give a weapon to yourself or another player.")

nzChatCommand.Add("/giveperk", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local plyToGiv = player.GetByName(text[1])

		local perk

		if !plyToGiv then
			perk = text[1]
			plyToGiv = ply
		else
			perk = text[2]
		end
		if IsValid(plyToGiv) and plyToGiv:Alive() and (plyToGiv:IsPlaying() or nzRound:InState(ROUND_CREATE)) then
			if nzPerks:Get(perk) then
				local wep = plyToGiv:Give(nzMapping.Settings.bottle or "tfa_perk_bottle")
				if IsValid(wep) then wep:SetPerk(perk) end
				plyToGiv:GivePerk(perk)
			else
				ply:ChatPrint("[NZ] No valid perk provided.")
			end
		else
			ply:ChatPrint("[NZ] They player you have selected is either not valid or not alive.")
		end
	end
end, false, "[playerName] perkID Give a perk to yourself or another player.")

nzChatCommand.Add("/giveupgrade", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local plyToGiv = player.GetByName(text[1])

		local perk

		if !plyToGiv then
			perk = text[1]
			plyToGiv = ply
		else
			perk = text[2]
		end
		if IsValid(plyToGiv) and plyToGiv:Alive() and (plyToGiv:IsPlaying() or nzRound:InState(ROUND_CREATE)) then
			if nzPerks:Get(perk) then
				if not plyToGiv:HasPerk(perk) then
					local wep = plyToGiv:Give(nzMapping.Settings.bottle or "tfa_perk_bottle")
					if IsValid(wep) then wep:SetPerk(perk) end
					plyToGiv:GivePerk(perk)
				end
				plyToGiv:GiveUpgrade(perk)
			else
				ply:ChatPrint("[NZ] No valid perk provided.")
			end
		else
			ply:ChatPrint("[NZ] They player you have selected is either not valid or not alive.")
		end
	end
end, false, "[playerName] perkID Give a perk upgrade to yourself or another player.")

nzChatCommand.Add("/removeperk", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local plyToGiv = player.GetByName(text[1])

		local perk

		if !plyToGiv then
			perk = text[1]
			plyToGiv = ply
		else
			perk = text[2]
		end
		if IsValid(plyToGiv) and plyToGiv:Alive() and (plyToGiv:IsPlaying() or nzRound:InState(ROUND_CREATE)) then
			if nzPerks:Get(perk) then
				if plyToGiv:HasPerk(perk) then
					plyToGiv:RemovePerk(perk)
				else
					ply:ChatPrint("[NZ] Player does not have perk.")
				end
			else
				ply:ChatPrint("[NZ] No valid perk provided.")
			end
		else
			ply:ChatPrint("[NZ] They player you have selected is either not valid or not alive.")
		end
	end
end, false, "[playerName] perkID Give a perk to yourself or another player.")

nzChatCommand.Add("/givegum", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local plyToGiv = player.GetByName(text[1])

		local gum

		if !plyToGiv then
			gum = text[1]
			plyToGiv = ply
		else
			gum = text[2]
		end
		if IsValid(plyToGiv) and plyToGiv:Alive() and (plyToGiv:IsPlaying() or nzRound:InState(ROUND_CREATE)) then
			if nzGum.Gums[gum] then
				local wep = plyToGiv:Give("tfa_nz_gum")
				if IsValid(wep) then wep:SetGum(gum) end

				nzGum:SetActiveGum(plyToGiv, gum)
			else
				ply:ChatPrint("[NZ] No valid gum provided.")
			end
		else
			ply:ChatPrint("[NZ] They player you have selected is either not valid or not alive.")
		end
	end
end, false, "[playerName] gumID Give a gobble gum to yourself or another player.")

nzChatCommand.Add("/reroll", SERVER, function(ply, text)
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		nzCamos:RandomizeCamo(wep, wep.nzPaPCamo)
	end
end, true, "Randomizes currently held weapon's pap camo.")

nzChatCommand.Add("/pap", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and (wep.OnPaP or wep.NZPaPReplacement) then
			if wep.NZPaPReplacement then
				local wep2 = ply:Give(wep.NZPaPReplacement)
				wep2:ApplyNZModifier("pap")
				ply:SelectWeapon(wep2:GetClass())
				ply:StripWeapon(wep:GetClass())
			else
				wep:ApplyNZModifier("pap")

				if wep.IsTFAWeapon then
					wep:ResetFirstDeploy()
					wep:CallOnClient("ResetFirstDeploy", "")
					wep:Deploy()
					wep:CallOnClient("Deploy", "")
				end
			end
		end
	end
end, false, "Applys 'pap' modifier to currently held weapon.")

nzChatCommand.Add("/repap", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep.OnPaP then
			if not wep:HasNZModifier("pap") then
				wep:ApplyNZModifier("pap")
			end
			wep:ApplyNZModifier("repap")

			if wep.IsTFAWeapon then
				wep:ResetFirstDeploy()
				wep:CallOnClient("ResetFirstDeploy", "")
				wep:Deploy()
				wep:CallOnClient("Deploy", "")
			end
		end
	end
end, false, "Applys 'repap' modifier to currently held weapon.")

nzChatCommand.Add("/aat", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) then
			local aat = text[1]
			if nzAATs:Get(aat) then
				print("Applying ["..aat.."] Alt Ammo Type to "..ply:Nick().."'s "..wep.PrintName)
				wep:SetNW2String("nzAATType", aat)
				ply.LastNZAATType = aat
			end
		end
	end
end, false, "Applys given 'Alt Ammo Type' to currently held weapon.")

nzChatCommand.Add("/notarget", SERVER, function(ply, text)
	local plyv = text[1] and player.GetByName(text[1]) or ply
	if plyv:GetTargetPriority() == TARGET_PRIORITY_NONE then
		plyv.NZNoTargetPlease = nil
		plyv:ChatPrint("[NZ] Target priority set to PLAYER.")
		plyv:SetTargetPriority(TARGET_PRIORITY_PLAYER)
	else
		plyv.NZNoTargetPlease = true
		plyv:ChatPrint("[NZ] Target priority set to NONE.")
		plyv:SetTargetPriority(TARGET_PRIORITY_NONE)
	end
end, true, "Toggles notarget on and off.")

nzChatCommand.Add("/targetpriority", SERVER, function(ply, text)
	local plyToGiv
	local strstart, strend = string.find(text[1], "entity(", 1, true)
	if strstart then
		local _, strstop = string.find(text[1], ")", strend, true)
		local ent = string.sub(text[1], strend + 1, strstop - 1)
		if ent and IsValid(Entity(ent)) then
			plyToGiv = Entity(ent)
		end
	else
		plyToGiv = player.GetByName(text[1])
	end

	local priority

	if !plyToGiv then
		priority = tonumber(text[1])
		plyToGiv = ply
	else
		priority = tonumber(text[2])
	end
	if IsValid(plyToGiv) and (!plyToGiv:IsPlayer() or (plyToGiv:Alive() and (plyToGiv:IsPlaying() or nzRound:InState(ROUND_CREATE)))) then
		if priority then
			plyToGiv:SetTargetPriority(priority)
		else
			ply:ChatPrint("[NZ] No valid priority provided.")
		end
	else
		ply:ChatPrint("[NZ] The player you have selected is either not valid or not alive.")
	end
end)

nzChatCommand.Add("/turnon", SERVER, function(ply, text)
	local plyv = text[1] and player.GetByName(text[1]) or ply
	if IsValid(plyv) and plyv:IsAdmin() then
		local ent = plyv:GetEyeTrace().Entity
		if IsValid(ent) and ent.TurnOn then
			ent:TurnOn()
		end
	end
end, false, "Activates the perk machine you're looking at.")

nzChatCommand.Add("/turnoff", SERVER, function(ply, text)
	local plyv = text[1] and player.GetByName(text[1]) or ply
	if IsValid(plyv) and plyv:IsAdmin() then
		local ent = plyv:GetEyeTrace().Entity
		if IsValid(ent) and ent.TurnOn then
			ent:TurnOff()
		end
	end
end, false, "Deactivates the perk machine you're looking at.")

nzChatCommand.Add("/elec", SERVER, function(ply, text)
	nzElec:Activate()
end, false, "Activates power.")

nzChatCommand.Add("/resetelec", SERVER, function(ply, text)
	nzElec:Reset()
end, false, "Resets power.")

nzChatCommand.Add("/forcepowerup", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		nzPowerUps:SetPowerUpChance(99)
		ply:ChatPrint("[NZ] Next zombie will drop a powerup.")
	end
end, false, "Sets the current global PowerUpChance to 99.")

nzChatCommand.Add("/forceantipowerup", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		nzPowerUps:SetAntiPowerUpChance(nzMapping.Settings.antipowerupchance)
		ply:ChatPrint("[NZ] Next powerup dropped will be an anti powerup.")
	end
end, false, "Sets the current global AntiPowerUpChance to the map setting max.")

nzChatCommand.Add("/resetdropcycle", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		nzPowerUps:ResetDropCycle()
		PrintMessage(HUD_PRINTTALK, "[NZ] Powerup drop cycle reset.")
	end
end, false, "Resets the drop cycle for the current round.")

nzChatCommand.Add("/resetpowerups", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		for id, data in pairs(nzPowerUps.ActivePowerUps) do
			nzPowerUps.ActivePowerUps[id] = 0
			continue
		end
	end
end, false, "Causes all currently active global powerups to expire.")

local powerupcheatsheet = {
	[1] = {
		["vulture"] = true,
		["vultures"] = true,
		["vultureaid"] = true,
	},
	[2] = {
		["widow"] = true,
		["widows"] = true,
		["widowswine"] = true,
	},
	[3] = {
		["tomb"] = true,
		["tombs"] = true,
		["tombstone"] = true,
	},
}

nzChatCommand.Add("/spawnpowerup", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		if powerupcheatsheet[1][text[1]] then
			local drop = ents.Create("drop_vulture")
			drop:SetOwner(ply)
			drop:SetPos(ply:GetEyeTrace().HitPos + ply:GetEyeTrace().HitNormal*2)
			drop:SetAngles(Angle(0,math.random(-180,180),0))

			if text[2] and nzPerks:GetVultureDrop(text[2]) then
				drop:SetDropType(text[2])
			end

			drop:Spawn()
		elseif powerupcheatsheet[2][text[1]] then
			local drop = ents.Create("drop_widows")
			drop:SetOwner(ply)
			drop:SetPos(ply:GetEyeTrace().HitPos + ply:GetEyeTrace().HitNormal+50)
			drop:SetAngles(Angle(0,math.random(-180,180),0))
			drop:Spawn()
		elseif powerupcheatsheet[3][text[1]] then
			local plyv = text[2] and player.GetByName(text[2])
			if not IsValid(plyv) then plyv = ply end

			local drop = ents.Create("drop_tombstone")
			drop:SetOwner(plyv)
			drop:SetFunny(math.random(100) == 1 or text[2] == "funny")
			drop:SetPos(plyv:GetEyeTrace().HitPos + ply:GetEyeTrace().HitNormal*50)
			drop:Spawn()

			local weps = {}
			for _, wep in pairs(plyv:GetWeapons()) do
				if not wep.PrintName then continue end //physgun is fucky
				table.insert(weps, {class = wep:GetClass(), pap = wep:HasNZModifier("pap")})
			end

			if not drop.OwnerData then drop.OwnerData = {} end
			drop.OwnerData.weps = weps
			drop.OwnerData.perks = plyv:GetPerks()
			drop.OwnerData.upgrade = false

			drop:SetOwner(plyv)
			drop:CallOnRemove("creative_physgun_fix"..drop:EntIndex(), function(ent)
				local ply = ent:GetOwner()
				if IsValid(ply) and not ply:HasWeapon("weapon_physgun") then
					ply:Give("weapon_physgun")
				end
			end)
		elseif nzPowerUps:Get(text[1]) then
			nzPowerUps:SpawnPowerUp(ply:GetEyeTrace().HitPos + ply:GetEyeTrace().HitNormal, text[1])
		end
	end
end, false, "Spawns a Powerup where the player is currenty looking.")

nzChatCommand.Add("/spawnantipowerup", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		if nzPowerUps:Get(text[1]) then
			nzPowerUps:SpawnAntiPowerUp(ply:GetEyeTrace().HitPos + ply:GetEyeTrace().HitNormal, text[1])
		end
	end
end, false, "Spawns an Anti Powerup where the player is currenty looking.")

nzChatCommand.Add("/giveall", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		ply:GiveMaxAmmo()
		ply:GiveAllPerks()

		ply:SetHealth(ply:GetMaxHealth())
		ply:SetArmor(ply:GetMaxArmor())

		local specials = ply.NZSpecialWeapons
		local shield = weapons.Get(nzMapping.Settings.shield or "")
		if !specials or !specials["shield"] and shield then
			local gun = ply:Give(nzMapping.Settings.shield)
			if shield.OnPaP then
				timer.Simple(0, function()
					if not IsValid(gun) then return end
					gun:ApplyNZModifier("pap")
				end)
			end
		end
	end
end, false, "Gives the player max ammo, 200 armor, a shield, and all perks.")

nzChatCommand.Add("/spawnboss", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() and nzRound:InProgress() then
		local boss = tostring(text[1])
		for id, data in pairs(nzRound.BossData) do
			if data.class == boss then
				boss = id
				break
			end
		end

		if nzRound.BossData[boss] then
			if text[2] then
				local num = math.min(99, tonumber(text[2]))
				local ratio = 2 - math.Remap(num, 1, 99, 0, 1 + (2/3))
				for i=1, num do
					timer.Simple((i - 1)*ratio, function()
						nzRound:SpawnBoss(boss)
					end)
				end
			else
				nzRound:SpawnBoss(boss)
			end
		end
	end
end, false, "Spawn a given boss by its class name, second input of a number is supported.")

nzChatCommand.Add("/forcenukedround", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() then
		nzPerks.NextNukedRound = 0
	end
end, false, "Forces next round to drop a perk machine if nuketown perks are enabled.")

-- QOL

nzChatCommand.Add("/navflush", SERVER, function(ply, text)
	nzNav.FlushAllNavModifications()
	PrintMessage(HUD_PRINTTALK, "[NZ] Navlocks and NavZones successfully flushed. Remember to redo them for best playing experience.")
end)

nzChatCommand.Add("/tools", SERVER, function(ply, text)
	if ply:IsInCreative() then
		ply:Give("weapon_physgun")
		ply:Give("nz_multi_tool")
		ply:Give("weapon_hands")
	end
end, true, "Give creative mode tools to yourself if in Creative.")

nzChatCommand.Add("/clearscoreboard", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() and nzRound:InState(ROUND_CREATE) then
		for k, v in pairs(player.GetAll()) do
			v:SetPoints(0)
			v:SetTotalKills(0)
			v:SetTotalDowns(0)
			v:SetTotalRevives(0)
		end
	end
end, false, "Clears the Scoreboard.")

nzChatCommand.Add("/giveloadout", SERVER, function(ply, text)
	if ply:IsInCreative() then
		if nzMapping.Settings.startwep and weapons.Get(tostring(nzMapping.Settings.startwep)) then
			ply:Give(nzMapping.Settings.startwep)
		else
			ply:Give("tfa_bo3_wepsteal")
			ply:PrintMessage( HUD_PRINTTALK, "You have to change the starting weapon in Map Settings!" )
		end

		if nzMapping.Settings.knife and weapons.Get(tostring(nzMapping.Settings.knife)) then
			ply:Give(nzMapping.Settings.knife)
		else
			ply:Give("tfa_bo1_knife")
		end

		if nzMapping.Settings.grenade and weapons.Get(tostring(nzMapping.Settings.grenade)) then
			local nade = ply:Give(nzMapping.Settings.grenade)
			nade.NoSpawnAmmo = true
		else
			ply:Give("tfa_bo1_m67")
		end
	end
end, true, "Give player spawn loadout to yourself if in Creative.")

//tool related
nzChatCommand.Add("/setnukedspawn", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() and nzRound:InState(ROUND_CREATE) then
		nzMapping.Settings.nukedspawn = ply:EyePos()
		nzMapping:LoadMapSettings(nzMapping.Settings)

		local fucker = tostring(nzMapping.Settings.nukedspawn)
		PrintMessage(HUD_PRINTTALK, "[NZ] Nuked perk spawn set to Vector("..fucker..")")
	end
end, false, "If Nuketown Perks is enabled, sets where perks should fall from the sky to the players current position.")

nzChatCommand.Add("/removenukedspawn", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() and nzRound:InState(ROUND_CREATE) and nzMapping.Settings.nukedspawn then
		nzMapping.Settings.nukedspawn = nil
		nzMapping:LoadMapSettings(nzMapping.Settings)
	end
end, false, "Removes the spawn point for Nuketown Perks.")

nzChatCommand.Add("/gotogocamera", SERVER, function(ply, text)
	if IsValid(ply) and ply:IsAdmin() and nzRound:InState(ROUND_CREATE) and nzMapping.Settings.gocamerastart and text[1] and nzMapping.Settings.gocamerastart[tonumber(text[1])] then
		ply:SetPos(nzMapping.Settings.gocamerastart[tonumber(text[1])])
		if nzMapping.Settings.gocameraend and nzMapping.Settings.gocameraend[tonumber(text[1])] then
			ply:SetEyeAngles((nzMapping.Settings.gocameraend[tonumber(text[1])] - ply:GetPos()):Angle())
		end
	end
end, false, "Teleporters player to given Game Over camera start.")

nzChatCommand.Add("/fizzlist", SERVER, function(ply, text)
    local fizzlist = nzMapping.Settings.wunderfizzperklist
    local blockedperks = { pap = true, wunderfizz = true }

    ply:ChatPrint("[NZ] Enabled Wunderfizz Perks:")
    for perk, data in pairs(fizzlist) do
        if data[1] and not blockedperks[perk] then
            ply:ChatPrint(" - " .. perk)
        end
    end

end, true, "Shows all enabled perks in the wunderfizz.")
