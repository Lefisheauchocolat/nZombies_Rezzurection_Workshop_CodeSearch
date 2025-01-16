
if (SERVER) then
	util.AddNetworkString("nz_player_event_notif")

	local function GetPerkIconMaterial(perk, usemmo)
		local style = usemmo and nzMapping.Settings.mmohudtype or nzMapping.Settings.icontype
		return nzPerks:GetPerkIcon(perk, style)
	end

	local function GetPowerupIconMaterial(powerup)
	    local powerupType = nzMapping.Settings.poweruptype
	    if not powerupType then return end

	    return nzPowerUps:GetPowerupIcon(powerup, powerupType)
	end

	function nzDisplay:SendPlayerEvent(filepath, name, color, index, extra)
		local players = {}
		for _, p in pairs(player.GetAll()) do
			if p:GetInfoNum("nz_hud_show_player_events_feed", 0) > (extra and 1 or 0) then
				players[#players + 1] = p
			end
		end

		if table.IsEmpty(players) then return end

		net.Start("nz_player_event_notif")
			net.WriteString(filepath)
			net.WriteString(name)
			net.WriteVector(color)
			net.WriteUInt(index, 8)
		net.Send(players)
	end

	//basic info
	//perks, power-ups, pack-a-punch, specialgrenade pickup
	hook.Add("OnPlayerGetPerk", "nzPlayerEventsHUD", function(ply, id)
		if not id then return end
		if id == "wunderfizz" then return end
		if id == "gum" then return end
		if id == "pap" then return end

		local filepath = GetPerkIconMaterial(id):GetName()
		filepath = string.sub(filepath, 8, #filepath + 1)..".png"
		local name = IsValid(ply) and ply:IsPlayer() and ply:Nick() or ""
		local color = IsValid(ply) and ply:IsPlayer() and ply:GetPlayerColor() or Vector(1,1,1)
		local index = IsValid(ply) and ply:EntIndex() or 0

		nzDisplay:SendPlayerEvent(filepath, name, color, index)
	end)

	hook.Add("OnPlayerPickupPowerUp", "nzPlayerEventsHUD", function(ply, id, ent)
		if not id then return end

		local filepath = GetPowerupIconMaterial(id):GetName()
		filepath = string.sub(filepath, 8, #filepath + 1)..".png"
		local name = IsValid(ply) and ply:IsPlayer() and ply:Nick() or ""
		local color = IsValid(ply) and ply:IsPlayer() and ply:GetPlayerColor() or Vector(1,1,1)
		local index = IsValid(ply) and ply:EntIndex() or 0

		nzDisplay:SendPlayerEvent(filepath, name, color, index)
	end)

	/*hook.Add("OnPlayerBuyPackAPunch", "nzPlayerEventsHUD", function(ply, wep, ent)
		if not IsValid(wep) then return end

		local filepath = GetPowerupIconMaterial("bonfiresale"):GetName()
		filepath = string.sub(filepath, 8, #filepath + 1)..".png"
		local name = IsValid(ply) and ply:IsPlayer() and ply:Nick() or ""
		local color = IsValid(ply) and ply:IsPlayer() and ply:GetPlayerColor() or Vector(1,1,1)
		local index = IsValid(ply) and ply:EntIndex() or 0

		nzDisplay:SendPlayerEvent(filepath, name, color, index)
	end)*/

	local illegalspecials = {
		["display"] = true,
		["grenade"] = true,
		["knife"] = true,
		["trap"] = true,
	}

	local lesslegalspecials = {
		["shield"] = true,
		["specialist"] = true,
	}

	hook.Add("WeaponEquip", "nzPlayerEventsHUD", function(wep, ply)
		if not IsValid(wep) or not wep.NZHudIcon or wep.NZHudIcon:IsError() then return end
		local special = wep.NZSpecialCategory
		if !special or (illegalspecials[special] and !wep.NZWonderWeapon) then return end

		local hudtype = nzMapping.Settings.hudtype
		local icon = nzDisplay.classicrevive[hudtype] and NZHudIcon_cod5 or (nzDisplay.t6revive[hudtype] or nzDisplay.t5revive[hudtype]) and wep.NZHudIcon_t5 or wep.NZHudIcon
		if not icon or icon:IsError() then
			icon = wep.NZHudIcon
		end

		local filepath = icon:GetName()
		filepath = string.sub(filepath, 8, #filepath + 1)..".png"

		local players = {}
		for _, p in pairs(player.GetAll()) do
			local val = p:GetInfoNum("nz_hud_show_player_events_feed", 0)
			if val > 0 and (!lesslegalspecials[special] or val > 1) then
				players[#players + 1] = p
			end
		end

		if table.IsEmpty(players) then return end

		net.Start("nz_player_event_notif")
			net.WriteString(filepath)
			net.WriteString(IsValid(ply) and ply:IsPlayer() and ply:Nick() or "")
			net.WriteVector(IsValid(ply) and ply:IsPlayer() and ply:GetPlayerColor() or Vector(1,1,1))
			net.WriteUInt(IsValid(ply) and ply:EntIndex() or 0, 8)
		net.Send(players)
	end)

	//more specific (and redudant) info
	//player revived, player died, build part pickup, key pickup, weapon chalk pickup
	hook.Add("PlayerRevived", "nzPlayerEventsHUD", function(ply, revivor)
		if !IsValid(revivor) or revivor == ply then return end
		local name = IsValid(revivor) and revivor:IsPlayer() and revivor:Nick() or ""
		local color = IsValid(revivor) and revivor:IsPlayer() and revivor:GetPlayerColor() or Vector(1,1,1)
		local index = IsValid(revivor) and revivor:EntIndex() or 0

		nzDisplay:SendPlayerEvent("nz_moo/huds/cod5/hud_syrette.png", name, color, index, true)
	end)

	hook.Add("PlayerKilled", "nzPlayerEventsHUD", function(ply)
		local name = IsValid(ply) and ply:IsPlayer() and ply:Nick() or ""
		local color = IsValid(ply) and ply:IsPlayer() and ply:GetPlayerColor() or Vector(1,1,1)
		local index = IsValid(ply) and ply:EntIndex() or 0

		nzDisplay:SendPlayerEvent("nz_moo/icons/hud_status_dead.png", name, color, index, true)
	end)

	hook.Add("PlayerPickupBuildpart", "nzPlayerEventsHUD", function(ply, ent)
		if !IsValid(ent) or !ent.GetBuildable or !ent.GetPartID then return end

		local build = ent:GetBuildable()
		local tbl = nzBuilds:GetBuildParts(build)
		if not tbl then return end

		local id = ent:GetPartID()
		local icon = tbl[id].icon
		if not icon or icon:IsError() then return end

		local filepath = icon:GetName()
		filepath = string.sub(filepath, 8, #filepath + 1)..".png"
		local name = IsValid(ply) and ply:IsPlayer() and ply:Nick() or ""
		local color = IsValid(ply) and ply:IsPlayer() and ply:GetPlayerColor() or Vector(1,1,1)
		local index = IsValid(ply) and ply:EntIndex() or 0

		nzDisplay:SendPlayerEvent(filepath, name, color, index, true)
	end)

	hook.Add("PlayerPickupLockerKey", "nzPlayerEventsHUD", function(ply, ent)
		if !IsValid(ent) or !ent.GetHudIcon then return end

		local filepath = ent:GetHudIcon()
		if !filepath or filepath == "" or !file.Exists("materials/"..filepath, "GAME") then
			filepath = "vgui/icon/hud_icon_key.png"
		end

		local name = IsValid(ply) and ply:IsPlayer() and ply:Nick() or ""
		local color = IsValid(ply) and ply:IsPlayer() and ply:GetPlayerColor() or Vector(1,1,1)
		local index = IsValid(ply) and ply:EntIndex() or 0

		nzDisplay:SendPlayerEvent(filepath, name, color, index, true)
	end)

	hook.Add("PlayerPickupWeaponChalk", "nzPlayerEventsHUD", function(ply, ent)
		if !IsValid(ent) or !ent.GetHudIcon then return end

		local filepath = ent:GetHudIcon()
		if !filepath or filepath == "" or !file.Exists("materials/"..filepath, "GAME") then
			filepath = "vgui/icon/zom_hud_icon_buildable_weap_chalk.png"
		end

		local name = IsValid(ply) and ply:IsPlayer() and ply:Nick() or ""
		local color = IsValid(ply) and ply:IsPlayer() and ply:GetPlayerColor() or Vector(1,1,1)
		local index = IsValid(ply) and ply:EntIndex() or 0

		nzDisplay:SendPlayerEvent(filepath, name, color, index, true)
	end)
end

if (CLIENT) then
	if GetConVar("nz_hud_show_player_events_feed") == nil then
		CreateClientConVar("nz_hud_show_player_events_feed", 0, true, true, "Enable or disable showing the player events feed in the top left. Inspired by a similar feature in ZCT maps on W@W. (0 disabled, 1 enabled, 2 extra info), Default is 0.", 0, 2)
	end

	if GetConVar("nz_hud_player_events_feed_max") == nil then
		CreateClientConVar("nz_hud_player_events_feed_max", 1, true, false, "Max amount of events that can be listed on screen at once. Default is 1.", 0, 10)
	end

	if GetConVar("nz_hud_player_events_feed_duration") == nil then
		CreateClientConVar("nz_hud_player_events_feed_duration", 30, true, false, "Duration that the last even will stay on screen, in seconds. Default is 30, 0 to never remove.", 0, 600)
	end

	local nz_showeventsfeed = GetConVar("nz_hud_show_player_events_feed")
	local nz_eventfeedmax = GetConVar("nz_hud_player_events_feed_max")
	local nz_eventfeedlife = GetConVar("nz_hud_player_events_feed_duration")
	local nz_betterscaling = GetConVar("nz_hud_better_scaling")
	local nz_useplayercolor = GetConVar("nz_hud_use_playercolor")

	local evenhud_data = {}
	local last_maxevents = 1

	hook.Add("OnRoundEnd", "nzEventsHUDReset", function()
		timer.Simple(nzRound:GameOverDuration() - engine.TickInterval(), function()
			evenhud_data = {}
		end)
	end)

	net.Receive("nz_player_event_notif", function()
		if not nz_showeventsfeed:GetBool() then return end

		local n_maxfeedsize = nz_eventfeedmax:GetInt()
		if n_maxfeedsize < last_maxevents then
			evenhud_data = {}
		end
		last_maxevents = n_maxfeedsize

		if #evenhud_data >= n_maxfeedsize then
			table.remove(evenhud_data, 1)
		end

		local pathtoicon = net.ReadString()
		local playername = net.ReadString()
		local playercolor = net.ReadVector()
		local playerindex = net.ReadUInt(8)

		local ply = Entity(playerindex)
		if IsValid(ply) and ply:IsPlayer() then
			playername = ply:Nick()
		end

		for i, data in pairs(evenhud_data) do
			if i == #evenhud_data and data and data.icon and data.icon == Hudmat(pathtoicon) and data.name == playername then
				return
			end
		end

		table.insert(evenhud_data, {
			icon = Hudmat(pathtoicon),
			name = playername,
			color = playercolor,
			start = CurTime(),
			fade = 1,
		})
	end)

	local function PlayerEventsHUD()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if !ply:ShouldDrawHUD() then return end
		if !ply:ShouldDrawScoreHUD() then return end
		if ply:IsScoreboardOpen() then return end

		local font = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))
		local w, h = ScrW(), ScrH()

		local pscale = 1
		if nz_betterscaling:GetBool() then
			pscale = (w/1920 + 1) / 2
		end

		local lifetime = nz_eventfeedlife:GetFloat()
		local ct = CurTime()

		for i, data in pairs(evenhud_data) do
			if not data then continue end

			if lifetime > 0 and data.start + lifetime < ct then
				data.fade = math.max(data.fade - RealFrameTime(), 0)
			end

			if data.icon and not data.icon:IsError() then
				surface.SetMaterial(data.icon)
				surface.SetDrawColor(ColorAlpha(color_white, 255*data.fade))
				surface.DrawTexturedRect(4*pscale, 4*pscale + (36*(i - 1))*pscale, 34*pscale, 34*pscale)
			end

			if data.name and data.name ~= "" then
				local fontColor = nz_useplayercolor:GetBool() and data.color and data.color:ToColor() or nzMapping.Settings.textcolor
				draw.SimpleTextOutlined(data.name, font, 42*pscale, 36 + (36*(i - 1))*pscale, ColorAlpha(fontColor or color_white, 255*data.fade), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, (nzMapping.Settings.fontthicc or 2), ColorAlpha(color_black, 100*data.fade))
			end

			if data.fade and data.fade <= 0 then
				table.remove(evenhud_data, i)
			end
		end
	end

	hook.Add("HUDPaint", "playereventsHUD", PlayerEventsHUD )
end