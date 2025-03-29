-------------------------
-- Localize
local pairs, IsValid, LocalPlayer, CurTime, Color, ScreenScale =
	pairs, IsValid, LocalPlayer, CurTime, Color, ScreenScale

local math, surface, table, input, string, draw, killicon, file =
	math, surface, table, input, string, draw, killicon, file

local file_exists, input_getkeyname, input_isbuttondown, input_lookupbinding, table_insert, table_remove =
	file.Exists, input.GetKeyName, input.IsButtonDown, input.LookupBinding, table.insert, table.remove

local string_len, string_split, string_gsub, string_upper, string_rep, string_match =
	string.len, string.Split, string.gsub, string.upper, string.rep, string.match

local TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, TEXT_ALIGN_BOTTOM =
	TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, TEXT_ALIGN_BOTTOM

local voiceloopback = GetConVar("voice_loopback")
local cl_drawhud = GetConVar("cl_drawhud")
local sv_clientpoints = GetConVar("nz_point_notification_clientside")
local nz_clientpoints = GetConVar("nz_hud_clientside_points")
local nz_perkmax = GetConVar("nz_difficulty_perks_max")

local nz_showhealth = GetConVar("nz_hud_show_health")
local nz_showhealthmp = GetConVar("nz_hud_show_health_mp")
local nz_showstamina = GetConVar("nz_hud_show_stamina")

local nz_showmmostats = GetConVar("nz_hud_show_perkstats")
local nz_showcompass = GetConVar("nz_hud_show_compass")
local nz_shownames = GetConVar("nz_hud_show_names")
local nz_showgun = GetConVar("nz_hud_show_wepicon")
local nz_showperkframe = GetConVar("nz_hud_show_perk_frames")
local nz_showzcounter = GetConVar("nz_hud_show_alive_counter")
local nz_showpoweruptimer = GetConVar("nz_hud_show_powerup_time")
local nz_showportrait = GetConVar("nz_hud_show_player_portrait")
local nz_showgamebegintext = GetConVar("nz_hud_show_game_start_text")

local nz_indicators = GetConVar("nz_hud_player_indicators")
local nz_indicatorangle = GetConVar("nz_hud_player_indicator_angle")
local nz_useplayercolor = GetConVar("nz_hud_use_playercolor")
local nz_powerupstyle = GetConVar("nz_hud_powerup_style")

local nz_aatstyle = GetConVar("nz_hud_aat_style")
local nz_aatcolor = GetConVar("nz_hud_aat_textcolor")
local nz_perkrowmod = GetConVar("nz_hud_perk_row_modulo")
local nz_mapfont = GetConVar("nz_hud_use_mapfont")
local nz_healthbarstyle = GetConVar("nz_hud_health_style")
local nz_bleedoutstyle = GetConVar("nz_hud_bleedout_style")
local nz_bleedouttime = GetConVar("nz_downtime")

local function GetPerkColor(perk)
	local perkData = nzPerks:Get(perk)
	return perkData and perkData.color or color_white
end

local color_white_50 = Color(255, 255, 255, 50)
local color_white_100 = Color(255, 255, 255, 100)
local color_white_150 = Color(255, 255, 255, 150)
local color_white_200 = Color(255, 255, 255, 200)
local color_black_180 = Color(0, 0, 0, 180)
local color_black_100 = Color(0, 0, 0, 100)
local color_black_50 = Color(0, 0, 0, 50)
local color_red_200 = Color(200, 0, 0, 255)
local color_red_255 = Color(255, 0, 0, 255)

local color_grey_100 = Color(100,100,100,255)
local color_grey = Color(200, 200, 200, 255)
local color_used = Color(250, 200, 120, 255)
local color_gold = Color(255, 255, 100, 255)
local color_green = Color(100, 255, 10, 255)
local color_armor = Color(135, 160, 255)
local color_health = Color(80, 0, 0, 160)

local color_blood = Color(100, 0, 0, 255)
local color_blood_score = Color(120, 0, 0, 255)

local color_points1 = Color(255, 200, 0, 255)
local color_points2 = Color(100, 255, 70, 255)
local color_points4 = Color(255, 0, 0, 255)

local t6_dlcHUDs = {
	["Buried"] = true,
	["Mob of the Dead"] = true,
	["Origins (Black Ops 2)"] = true,
}

//--------------------------------------------------/GhostlyMoo and Fox's BO2 DLC HUD\------------------------------------------------\\

//t6 hud
local t6_hud_score = Material("nz_moo/huds/t6/scorebar_zom_5.png", "unlitgeneric smooth")

local t6_hud_healthbar = Material("nz_moo/icons/t5hud_healthbar.png", "unlitgeneric smooth")
local t6_hud_health = Material("nz_moo/icons/mori2_hud_health_logo.png", "unlitgeneric smooth")
local t6_hud_shield = Material("nz_moo/huds/t7/uie_t7_icon_inventory_dlc3_dragonshield_fill.png", "unlitgeneric smooth")

local t6_hud_dpad_dlc = {
	["Mob of the Dead"] = Material("nz_moo/huds/t6/hud_hell_dpad.png", "unlitgeneric smooth"),
	["Buried"] = Material("nz_moo/huds/t6/hud_buried_dpad.png", "unlitgeneric smooth"),
	["Origins (Black Ops 2)"] = Material("nz_moo/huds/t6/hud_tomb_dpad.png", "unlitgeneric smooth"),
}
local t6_hud_dpad_bar_dlc = {
	["Mob of the Dead"] = Material("nz_moo/huds/t6/hud_hell_dpad_bar.png", "unlitgeneric smooth"),
	["Buried"] = Material("nz_moo/huds/t6/hud_buried_dpad_bar.png", "unlitgeneric smooth"),
	["Origins (Black Ops 2)"] = Material("nz_moo/huds/t6/hud_tomb_dpad_bar.png", "unlitgeneric smooth"),
}
local t6_hud_num_line = {
	["Mob of the Dead"] = Material("nz_moo/huds/t6/hud_hell_zom_num_line.png", "unlitgeneric smooth"),
	["Buried"] = Material("nz_moo/huds/t6/hud_buried_zom_num_line.png", "unlitgeneric smooth"),
	["Origins (Black Ops 2)"] = Material("nz_moo/huds/t6/hud_tomb_zom_num_line.png", "unlitgeneric smooth"),
}
local t6_hud_num_slash = {
	["Mob of the Dead"] = Material("nz_moo/huds/t6/hud_hell_zom_num_slash.png", "unlitgeneric smooth"),
	["Buried"] = Material("nz_moo/huds/t6/hud_buried_zom_num_slash.png", "unlitgeneric smooth"),
	["Origins (Black Ops 2)"] = Material("nz_moo/huds/t6/hud_tomb_zom_num_slash.png", "unlitgeneric smooth"),
}

local t6_hud_hell_numbers = {
	Material("nz_moo/huds/t6/hud_hell_zom_num_0.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_1.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_2.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_3.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_4.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_5.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_6.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_7.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_8.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_hell_zom_num_9.png", "unlitgeneric smooth"),
}

local t6_hud_buried_numbers = {
	Material("nz_moo/huds/t6/hud_buried_zom_num_0.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_1.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_2.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_3.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_4.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_5.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_6.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_7.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_8.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_buried_zom_num_9.png", "unlitgeneric smooth"),
}

local t6_hud_tomb_numbers = {
	Material("nz_moo/huds/t6/hud_tomb_zom_num_0.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_1.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_2.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_3.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_4.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_5.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_6.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_7.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_8.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/hud_tomb_zom_num_9.png", "unlitgeneric smooth"),
}

//t6 powerup
/*local t6_powerup_minigun = Material("nz_moo/icons/bo2/charred_powerup_deathmachine.png", "unlitgeneric")
local t6_powerup_blood = Material("nz_moo/icons/bo2/charred_powerup_blood_alt_alt.png", "unlitgeneric")
local t6_powerup_2x = Material("nz_moo/icons/bo2/charred_powerup_2x.png", "unlitgeneric")
local t6_powerup_killjoy = Material("nz_moo/icons/bo2/charred_powerup_instakill.png", "unlitgeneric")
local t6_powerup_firesale = Material("nz_moo/icons/bo2/charred_powerup_sale.png", "unlitgeneric")
local t6_powerup_bonfiresale = Material("nz_moo/icons/bo2/charred_powerup_bonfire.png", "unlitgeneric")
local t6_powerup_timewarp = Material("vgui/charred_powerup_slow.png", "unlitgeneric")
local t6_powerup_berzerk = Material("vgui/t6_bzk.png", "unlitgeneric")
local t6_powerup_infinite = Material("vgui/bo2_infinite.png", "unlitgeneric")
local t6_powerup_godmode = Material("vgui/bo2_greyson.png", "unlitgeneric")
local t6_powerup_quick = Material("vgui/bo2_quick.png", "unlitgeneric")*/

//t6 inventory
local t6_icon_shield = Material("nz_moo/icons/zm_riotshield_icon.png", "unlitgeneric smooth")
local t6_icon_special = Material("nz_moo/huds/t6/hud_minigun.png", "unlitgeneric smooth")
local t6_icon_grenade = Material("nz_moo/hud_grenade_bo2.png", "unlitgeneric smooth")
local t6_icon_semtex = Material("nz_moo/huds/t5/hud_sticky_grenade.png", "unlitgeneric smooth")
local t6_icon_trap = Material("nz_moo/icons/zm_turbine_icon.png", "unlitgeneric smooth")
local t6_icon_gl = Material("nz_moo/huds/t6/hud_gl_select_big.png", "unlitgeneric smooth")
local t6_icon_shovel = Material("nz_moo/huds/t6/zom_hud_craftable_tank_shovel.png", "unlitgeneric smooth")
local t6_icon_shovel_gold = Material("nz_moo/huds/t6/zom_hud_shovel_gold.png", "unlitgeneric smooth")

//universal
local zmhud_vulture_glow = Material("nz_moo/huds/t6/specialty_vulture_zombies_glow.png", "unlitgeneric smooth")
local zmhud_dpad_compass = Material("nz_moo/huds/t6/compass_white.png", "unlitgeneric smooth noclamp")
local zmhud_icon_holygrenade = Material("nz_moo/hud_holygrenade.png", "unlitgeneric smooth")
local zmhud_icon_frame = Material("nz_moo/icons/perk_frame.png", "unlitgeneric smooth")
local zmhud_icon_missing = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")
local zmhud_icon_player = Material("nz_moo/icons/offscreenobjectivepointer.png", "unlitgeneric smooth")
local zmhud_icon_death = Material("nz_moo/icons/hud_status_dead.png", "unlitgeneric smooth")
local zmhud_icon_mule = Material("nz_moo/icons/bo1/mulekick.png", "unlitgeneric smooth")
local zmhud_icon_talk = Material("nz_moo/icons/talkballoon.png", "unlitgeneric smooth")
local zmhud_icon_voiceon = Material("nz_moo/icons/voice_on.png", "unlitgeneric smooth")
local zmhud_icon_voicedim = Material("nz_moo/icons/voice_on_dim.png", "unlitgeneric smooth")
local zmhud_icon_voiceoff = Material("nz_moo/icons/voice_off.png", "unlitgeneric smooth")
local zmhud_icon_offscreen = Material("nz_moo/icons/offscreen_arrow.png", "unlitgeneric smooth")
local zmhud_icon_zedcounter = Material("nz_moo/icons/ugx_talkballoon.png", "unlitgeneric smooth")
local zmhud_player_teleporting = Material("effects/tp_eyefx/tpeye.vmt")

local illegalspecials = {
	["specialgrenade"] = true,
	["grenade"] = true,
	["knife"] = true,
	["display"] = true,
}

local PointsNotifications = {}
local function PointsNotification(ply, amount, profit_id)
	if not IsValid(ply) then return end
	local data = {ply = ply, amount = amount, diry = math.random(-25, 25), time = CurTime(), profit = profit_id}
	table_insert(PointsNotifications, data)
end

net.Receive("nz_points_notification_bo2_dlc", function()
	if nz_clientpoints:GetBool() then return end

	local amount = net.ReadInt(20)
	local ply = net.ReadEntity()
	local profit_id = net.ReadInt(9)
	PointsNotification(ply, amount, profit_id)
end)

//Equipment
local function InventoryHUD_t6_dlc()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawInventoryHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local ammofont =  "nz.ammo.blackops2"
	local ammo2font =  "nz.ammo2.blackops2"
	if nz_mapfont:GetBool() then
		ammofont = "nz.ammo."..GetFontType(nzMapping.Settings.ammofont)
		ammofont = "nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font)
	end

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local plyweptab = ply:GetWeapons()

	// Special Weapon Categories
	for _, wep in pairs(plyweptab) do
		// Traps
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "trap" then
			local icon = t6_icon_trap
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 45*scale) - (24*scale), (h - 115*scale) - (24*scale), 48*scale, 48*scale)

			local ammo = wep:GetPrimaryAmmoType()
			if ammo > 0 and not wep.TrapCanBePlaced then
				local ammocount = ply:GetAmmoCount(ammo) + wep:Clip1()
				draw.SimpleTextOutlined(ammocount, ammo2font, w - 42*scale, h - 98*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
			end
		end

		// Specialists
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "specialist" then
			local icon = t6_icon_special
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 92*scale) - (24*scale), (h - 60*scale) - (24*scale), 48*scale, 48*scale)
		end

		// Shield Slot Occupier
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "shield" and wep.NZHudIcon and not wep.ShieldEnabled then
			local icon = t6_icon_shield
			if wep.NZHudIcon then
				icon = wep.NZHudIcon
			end
			if not icon or icon:IsError() then
				icon = zmhud_icon_missing
			end

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 92*scale) - (24*scale), (h - 165*scale) - (24*scale), 48*scale, 48*scale)
		end
	end

	// Shield
	if ply.GetShield and IsValid(ply:GetShield()) then
		local shield = ply:GetShield()
		local wep = shield:GetWeapon()

		local icon = t6_icon_shield
		if IsValid(wep) and wep.NZHudIcon then
			icon = wep.NZHudIcon
		end
		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect((w - 92*scale) - (24*scale), (h - 165*scale) - (24*scale), 48*scale, 48*scale)
	
		if wep.Secondary and wep.Secondary.ClipSize > 0 then
			local clip2 = wep:Clip2()
			local clip2rate = wep.Secondary.AmmoConsumption
			local clip2i = math.floor(clip2/clip2rate)

			draw.SimpleTextOutlined(clip2i, ammo2font, w - 90*scale, h - 152*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_100)
		end
	end
end

local function ScoreHud_t6_dlc()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawScoreHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local hudtype = nzMapping.Settings.hudtype
	if not t6_dlcHUDs[hudtype] then return end

	local smallfont = "nz.small.blackops2"
	local fontsmall = "nz.points.blackops2"
	local ammo2font =  "nz.ammo2.blackops2"
	local fontnade = "nz.grenade"
	if nz_mapfont:GetBool() then
		smallfont = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
		fontsmall = "nz.points."..GetFontType(nzMapping.Settings.ammofont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local offset = 5
	local healthmodder = (not nz_healthbarstyle:GetBool() and nz_showhealth:GetBool())
	if nz_showcompass:GetBool() then
		offset = healthmodder and 45*scale or 60*scale
	end
	if healthmodder then
		offset = offset + 35*scale
	end

	local index = ply:EntIndex()
	local pcolor = player.GetColorByIndex(index)
	if nz_useplayercolor:GetBool() then
		pcolor = ply:GetPlayerColor():ToColor()
	end

	surface.SetDrawColor(color_white)
	local function DrawPointsNum(points, index, offset, big)
		local numtab = string_split(points, "")
		if numtab[1] ~= "-" then
			if hudtype == "Mob of the Dead" then
				surface.SetMaterial(t6_hud_hell_numbers[numtab[index]+1])
			elseif hudtype == "Buried" then
				surface.SetMaterial(t6_hud_buried_numbers[numtab[index]+1])
			elseif hudtype == "Origins (Black Ops 2)" then
				surface.SetMaterial(t6_hud_tomb_numbers[numtab[index]+1])
			end
		end
		surface.DrawTexturedRect(w - ((big and 250 or 240) - index*24)*scale, h - ((big and 235 or 245)*scale) - offset, 32*scale, 64*scale)
	end

	//points
	surface.SetDrawColor(color_blood_score)
	surface.SetMaterial(t6_hud_score)
	surface.DrawTexturedRect(w - 235*scale, h - 230*scale - offset, 210*scale, 50*scale)

	local points = ply:GetPoints()
	surface.SetDrawColor(color_white)
	for i=1, string_len(points) do
		DrawPointsNum(points, i, offset, true)
	end
	ply.PointsSpawnPosition = {x = w - 240*scale, y = h - (205*scale) - offset}

	//icon
	if nz_showportrait:GetBool() then
		local pmpath = Material("spawnicons/"..string_gsub(ply:GetModel(),".mdl",".png"), "unlitgeneric smooth")
		if not pmpath or pmpath:IsError() then
			pmpath = zmhud_icon_missing
		end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(pmpath)
		surface.DrawTexturedRect(w - 60*scale, h - 230*scale - offset, 48*scale, 48*scale)

		surface.SetDrawColor(pcolor)
		surface.DrawOutlinedRect(w - 60*scale, h - 230*scale - offset, 50*scale, 50*scale, 2)
	end

	//shovel
	if ply.GetShovel and IsValid(ply:GetShovel()) then
		local pshovel = ply:GetShovel()

		surface.SetMaterial(pshovel:IsGolden() and t6_icon_shovel_gold or t6_icon_shovel)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w - (90*scale), h - (210*scale) - offset, 32, 32)
	end

	//nickname
	if nz_shownames:GetBool() then
		local nick = ply:Nick()
		if #nick > 20 then
			nick = string.sub(nick, 1, 20) //limit name to 20 chars
		end

		if ply:IsSpeaking() then
			local icon = zmhud_icon_voicedim
			if ply:VoiceVolume() > 0 then
				icon = zmhud_icon_voiceon
			end
			if ply:IsMuted() then
				icon = zmhud_icon_voiceoff
			end
			if not voiceloopback:GetBool() then
				icon = zmhud_icon_voiceon
			end

			surface.SetFont(fontsmall)
			local tw, th = surface.GetTextSize(nick)

			surface.SetMaterial(icon)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect((w - 215*scale) - 32, h - (248*scale) - offset - 16, 32, 32)
		end

		draw.SimpleTextOutlined(nick, fontsmall, w - 215*scale, h - (248*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)

		offset = offset + 25 //nickname offset buffer
	end

	offset = offset + 45*scale

	local plytab = player.GetAll()
	for k, v in ipairs(plytab) do
		if v == ply then continue end

		local index = v:EntIndex()
		local pcolor = player.GetColorByIndex(index)
		if nz_useplayercolor:GetBool() then
			pcolor = v:GetPlayerColor():ToColor()
		end

		if nz_showhealthmp:GetBool() then
			offset = offset + 25*scale //health bar offset buffer
		end

		local points = v:GetPoints()
		surface.SetDrawColor(color_white)
		for i=1, string_len(points) do
			DrawPointsNum(points, i, offset, false)
		end
		v.PointsSpawnPosition = {x = w - 240*scale, y = h - (205*scale) - offset}

		//icon
		if nz_showportrait:GetBool() then
			local pmpath = Material("spawnicons/"..string_gsub(v:GetModel(),".mdl",".png"), "unlitgeneric smooth")
			if not pmpath or pmpath:IsError() then
				pmpath = zmhud_icon_missing
			end

			surface.SetDrawColor(color_white)
			surface.SetMaterial(pmpath)
			surface.DrawTexturedRect(w - 60*scale, h - 235*scale - offset, 40*scale, 40*scale)

			if v.GetTeleporterEntity and IsValid(v:GetTeleporterEntity()) then
				surface.SetMaterial(zmhud_player_teleporting)
				surface.DrawTexturedRect(w - 60*scale, h - 250 * scale - offset, 40*scale, 40*scale)
			end

			if v.IsOnFire and v:IsOnFire() or v:GetNW2Float("nzLastBurn", 0) + 1.5 > CurTime() then
				surface.SetMaterial(zmhud_player_onfire)
				surface.DrawTexturedRect(w - 60*scale, h - 250 * scale - offset, 40*scale, 40*scale)
			end

			if v:GetNW2Float("nzLastShock", 0) + 1.5 > CurTime() then
				surface.SetMaterial(zmhud_player_shocked)
				surface.DrawTexturedRect(w - 60*scale, h - 250 * scale - offset, 40*scale, 40*scale)
			end

			if v:HasPerk("pop") then
				local delay = v:GetNW2Float("nz.EPopDecay", 0)
				if delay > CurTime() then
					local effect = v:GetNW2Int("nz.EPopEffect", 1)
					local fadefac = 0

					if delay > CurTime() then
						fadefac = delay - CurTime()
						fadefac = math.Clamp(fadefac / 1, 0, 1)
					end

					if fadefac > 0 then
						surface.SetMaterial(nzPerks.EPoPIcons[effect])
						surface.SetDrawColor(ColorAlpha(color_white, 255*fadefac))
						surface.DrawTexturedRect(w - 60*scale + (2*scale), h - 250*scale + (16*scale) - offset, 24*scale, 48*scale)
					end
				end
			end

			if v.HasVultureStink and v:HasVultureStink() then
				surface.SetMaterial(zmhud_player_stink)
				surface.DrawTexturedRect(w - 60*scale, h - 250 * scale - offset, 40*scale, 40*scale)

				surface.SetMaterial(Material("color"))
				surface.SetDrawColor(160, 255, 0, math.max(24 * math.abs(math.sin(CurTime())), 14))
				surface.DrawTexturedRect(w - 60*scale, h - 250 * scale - offset, 40*scale, 40*scale)
			end

			surface.SetDrawColor(pcolor)
			surface.DrawOutlinedRect(w - 60*scale, h - 235*scale - offset, 42*scale, 42*scale, 2)
		end

		//shovel
		if v.GetShovel and IsValid(v:GetShovel()) then
			local pshovel = v:GetShovel()

			surface.SetMaterial(pshovel:IsGolden() and t6_icon_shovel_gold or t6_icon_shovel)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w - (90*scale), h - (225*scale) - offset, 32, 32)
		end

		//indicator
		if nz_indicators:GetBool() and v:GetNotDowned() then
			local pos = ply:GetPos()
			local epos = v:GetPos()

			local ang = nz_indicatorangle:GetFloat()
			local dir = ply:EyeAngles():Forward()
			local facing = (pos - epos):GetNormalized()

			if (facing:Dot(dir) + 1) / 2 > ang then
				local screen = ScreenScale(8)
				local xscale = ScreenScale(260)
				local yscale = ScreenScale(160)

				local dist = math.Clamp(pos:Distance(epos) / 200, 0, 1)
				local dir = (epos - pos):Angle()
				dir = dir - EyeAngles()
				local angle = dir.y + 90

				local x = (math.cos(math.rad(angle)) * xscale) + w / 2
				local y = (math.sin(math.rad(angle)) * -yscale) + h / 2

				surface.SetMaterial(zmhud_icon_player)
				surface.SetDrawColor(pcolor)
				if v:IsDormant() then
					surface.SetDrawColor(ColorAlpha(pcolor, 40))
				end
				if v:GetNW2Float("nz.LastHit", 0) + 0.35 > CurTime() then
					surface.SetDrawColor(color_used)
				end

				surface.DrawTexturedRectRotated(x, y, screen*2, screen, angle - 90)
			end
		end

		if nz_showhealthmp:GetBool() then
			local phealth = v:Health()
			local pmaxhealth = v:GetMaxHealth()
			local phealthscale = math.Clamp(phealth / pmaxhealth, 0, 1)
			local lowres = scale < 0.96

			surface.SetMaterial(t6_hud_healthbar)
			surface.SetDrawColor(color_health)
			surface.DrawTexturedRectUV(w - 222*scale, h - 190*scale - offset, 264*0.8*scale, 32*0.6*scale, 0, 0, 1, 1)

			surface.SetMaterial(t6_hud_healthbar)
			surface.SetDrawColor(color_blood_score)
			surface.DrawTexturedRectUV(w - 218*scale, h - 188*scale - offset, 256*0.8*phealthscale*scale, 24*0.6*scale, 0, 0, 1*phealthscale, 1)

			if nz_showhealthmp:GetInt() > 1 then
				draw.SimpleTextOutlined(phealth, ammo2font, w - 200*scale, h - 181*scale - offset, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
			end

			local armor = v:Armor()
			if armor > 0 then
				local maxarmor = v:GetMaxArmor()
				local armorscale = math.Clamp(armor / maxarmor, 0, 1)

				surface.SetMaterial(t6_hud_shield)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(w - 244*scale, h - 196*scale - offset, 32*scale, 32*scale)

				surface.SetMaterial(t6_hud_shield)
				surface.SetDrawColor(color_armor)
				surface.DrawTexturedRectUV(w - 244*scale, h - 196*scale - offset, 32*scale, 32*armorscale*scale, 0, 0, 1, 1*armorscale)

				if nz_showhealthmp:GetInt() > 1 then
					draw.SimpleTextOutlined(armor, ammo2font, w - (lowres and 229 or 228)*scale, h - 181*scale - offset, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
				end
			end
		end

		//nickname
		if nz_shownames:GetBool() then
			local nick = v:Nick()
			if #nick > 20 then
				nick = string.sub(nick, 1, 20) //limit name to 20 chars
			end

			if v:IsSpeaking() then
				local icon = zmhud_icon_voicedim
				if v:VoiceVolume() > 0 then
					icon = zmhud_icon_voiceon
				end
				if v:IsMuted() then
					icon = zmhud_icon_voiceoff
				end

				surface.SetFont(fontsmall)
				local tw, th = surface.GetTextSize(nick)

				surface.SetMaterial(icon)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect((w - 215*scale) - 32, h - (248*scale) - offset - 16, 32, 32)
			end

			draw.SimpleTextOutlined(nick, fontsmall, w - 215*scale, h - (248*scale) - offset, pcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)

			offset = offset + 25 //nickname offset buffer
		end

		offset = offset + (45*scale)
	end

	if nz_clientpoints:GetBool() or sv_clientpoints:GetBool() then
		for k, v in ipairs(plytab) do
			if not v.LastPoints then v.LastPoints = v:GetPoints() end

			if v:GetPoints() ~= v.LastPoints then
				PointsNotification(v, v:GetPoints() - v.LastPoints, 0)
				v.LastPoints = v:GetPoints()
			end
		end
	end

	for k, v in pairs(PointsNotifications) do
		local fade = math.Clamp((CurTime()-v.time), 0, 1)
		local fadeinvert = 1 - fade
		local points1 = ColorAlpha(color_points1, 255*fadeinvert)
		local points2 = ColorAlpha(color_points2, 255*fadeinvert)
		local points4 = ColorAlpha(color_points4, 255*fadeinvert)

		if not v.ply.PointsSpawnPosition then return end

		if v.amount >= 0 then
			if v.profit and v.profit > 0 then
				local pvcol = Entity(v.profit):GetPlayerColor()
				pvcol = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)

				draw.SimpleText("+"..v.amount, fontsmall, v.ply.PointsSpawnPosition.x - 50*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, pvcol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			else
				if v.amount >= 100 then --If you're earning 100 points or more, the notif will be green!
					draw.SimpleText("+"..v.amount, fontsmall, v.ply.PointsSpawnPosition.x - 50*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
				if v.amount < 100 then --If you're earning less than 100 points, the notif will be gold!
					draw.SimpleText("+"..v.amount, fontsmall, v.ply.PointsSpawnPosition.x - 50*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				end
			end
		else --If you're doing something that subtracts points, the notif will be red!
			draw.SimpleText(v.amount, fontsmall, v.ply.PointsSpawnPosition.x - 50*fade, v.ply.PointsSpawnPosition.y + v.diry*fade, points4, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end

		if fade >= 1 then
			table_remove(PointsNotifications, k)
		end
	end
end

local lerpcol_white = Color(255, 255, 255, 255)
local lerpcol_red = Color(200, 0, 0, 255)
local emptyclipdie = false
local emptycliptime = 0

local emptyclip2die = false
local emptyclip2time = 0

local function GunHud_t6_dlc()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawGunHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local wep = ply:GetActiveWeapon()

	local hudtype = nzMapping.Settings.hudtype
	if not t6_dlcHUDs[hudtype] then return end

	local ammofont = "nz.ammo.blackops2"
	local ammo2font = "nz.ammo2.blackops2"
	local smallfont = "nz.small.blackops2"
	local mainfont = "nz.main.blackops2"
	local fontsmall = "nz.points.blackops2"
	if nz_mapfont:GetBool() then
		ammofont = "nz.ammo."..GetFontType(nzMapping.Settings.ammofont)
		ammo2font = "nz.ammo2."..GetFontType(nzMapping.Settings.ammo2font)
		mainfont = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
		smallfont = "nz.small."..GetFontType(nzMapping.Settings.smallfont)
		fontsmall = "nz.points."..GetFontType(nzMapping.Settings.ammofont)
	end

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor

	surface.SetDrawColor(color_white)

	//main hud
	surface.SetMaterial(t6_hud_dpad_bar_dlc[hudtype])
	surface.DrawTexturedRect(w - 480*scale, h - 70*scale, 256*scale*1.5, 16*scale*1.5)

	surface.SetMaterial(t6_hud_dpad_dlc[hudtype])
	surface.DrawTexturedRect(w - 190*scale, h - 210*scale, 128*scale*1.5, 128*scale*1.5)

	//compass hud
	if nz_showcompass:GetBool() then
		local angle = -ply:EyeAngles().y/360 + 0.016

		surface.SetMaterial(zmhud_dpad_compass)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectUV(w - 256*scale, h - 242*scale, 256*scale, 64*scale, 0 + angle , 0, 0.5 + angle , 1)
	end

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local function DrawClipNum(clip, index, color)
		if not color then color = color_white end
		surface.SetDrawColor(color)
		local num = string_split(string.reverse(clip), "")[index]+1
		if hudtype == "Mob of the Dead" then
			surface.SetMaterial(t6_hud_hell_numbers[num])
		elseif hudtype == "Buried" then
			surface.SetMaterial(t6_hud_buried_numbers[num])
		elseif hudtype == "Origins (Black Ops 2)" then
			surface.SetMaterial(t6_hud_tomb_numbers[num])
		end
		surface.DrawTexturedRect(w - (270 + index*32)*scale, h - 150*scale, 32*scale*1.4, 64*scale*1.4)
	end

	local function DrawClip2Num(clip2, index, buffer, color)
		if not color then color = color_white end
		surface.SetDrawColor(color)
		local num = string_split(string.reverse(clip2), "")[index]+1
		if hudtype == "Mob of the Dead" then
			surface.SetMaterial(t6_hud_hell_numbers[num])
		elseif hudtype == "Buried" then
			surface.SetMaterial(t6_hud_buried_numbers[num])
		elseif hudtype == "Origins (Black Ops 2)" then
			surface.SetMaterial(t6_hud_tomb_numbers[num])
		end
		surface.DrawTexturedRect(w - ((270 + buffer) + index*32)*scale, h - 150*scale, 32*scale*1.4, 64*scale*1.4)
	end

	local function DrawAmmoNum(ammo, index)
		surface.SetDrawColor(color_white)
		local num = string_split(ammo, "")[index]+1
		if hudtype == "Mob of the Dead" then
			surface.SetMaterial(t6_hud_hell_numbers[num])
		elseif hudtype == "Buried" then
			surface.SetMaterial(t6_hud_buried_numbers[num])
		elseif hudtype == "Origins (Black Ops 2)" then
			surface.SetMaterial(t6_hud_tomb_numbers[num])
		end

		surface.DrawTexturedRect(w - (270 - index*24)*scale, h - 130*scale, 32*scale, 64*scale)
	end

	//weapon hud
	if IsValid(wep) then
		local class = wep:GetClass()
		if wep.NZWonderWeapon then
			fontColor = Color(0, 255, 255, 255)
		end
		if wep.NZSpecialCategory == "specialist" then
			fontColor = Color(180, 0, 0, 255)
		end

		if class == "nz_multi_tool" then
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].displayname or wep.ToolMode, ammofont, w - 170*scale, h - 145*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
			draw.SimpleTextOutlined(nzTools.ToolData[wep.ToolMode].desc or "", smallfont, w - 170*scale, h - 70*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black)
		elseif (illegalspecials[wep.NZSpecialCategory] and not wep.NZSpecialShowHUD) then
			local name = wep:GetPrintName()
			draw.SimpleTextOutlined(name, fontsmall, w - 170*scale, h - 145*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
		else
			if wep.Primary then
				local clip = wep.Primary.ClipSize
				local resclip = wep.Primary.DefaultClip
				local clip1 = wep:Clip1()

				local flashing_sin = math.abs(math.sin(CurTime()*4))
				local ammoType = wep:GetPrimaryAmmoType()
				local ammoTotal = ply:GetAmmoCount(ammoType)

				local ammoCol = Color(255, 255, 255, 255)
				local lowclip = false

				if wep.CanBeSilenced and wep:GetSilenced() then
					if wep.Clip3 then
						clip = wep.Tertiary.ClipSize
						resclip = wep.Tertiary.DefaultClip
						clip1 = wep:Clip3()
					else
						clip = wep.Secondary.ClipSize
						resclip = wep.Secondary.DefaultClip
						clip1 = wep:Clip2()
					end
					ammoTotal = ply:GetAmmoCount(wep:GetSecondaryAmmoType())
				end

				if clip and (clip > 1 or clip1 == 0) and clip1 <= math.ceil(clip/4) then
					lowclip = true

					ammoCol.r = Lerp(flashing_sin, lerpcol_red.r, lerpcol_white.r)
					ammoCol.g = Lerp(flashing_sin, lerpcol_red.g, lerpcol_white.g)
					ammoCol.b = Lerp(flashing_sin, lerpcol_red.b, lerpcol_white.b)
				end

				local ammolen = string_len(ammoTotal)
				local cliplen = string_len(clip1)

				if clip and clip > 0 then
					if ammoType == -1 then
						//for weapons that only use clip1 and dont have an ammo pool
						for i=1, cliplen do
							DrawClipNum(clip1, i, ammoCol)
							surface.SetDrawColor(color_white)
							surface.SetMaterial(t6_hud_num_slash[hudtype])
							surface.DrawTexturedRect(w - (265*scale), h - 130*scale, 32*scale, 64*scale)
							for i=1, string_len(resclip) do
								DrawAmmoNum(resclip, i)
							end
						end
					else
						//normal weapons
						for i=1, cliplen do
							DrawClipNum(clip1, i, ammoCol)
						end
						if resclip and resclip > 0 then
							surface.SetDrawColor(color_white)
							surface.SetMaterial(t6_hud_num_slash[hudtype])
							surface.DrawTexturedRect(w - (265*scale), h - 130*scale, 32*scale, 64*scale)
							for i=1, ammolen do
								DrawAmmoNum(ammoTotal, i)
							end
						end
					end
				else
					//weapons that dont have a clip1 and use the ammo pool
					if resclip and resclip > 0 then
						for i=1, ammolen do
							DrawClipNum(ammoTotal, i, color_white)
							surface.SetDrawColor(color_white)
							surface.SetMaterial(t6_hud_num_slash[hudtype])
							surface.DrawTexturedRect(w - (265*scale), h - 130*scale, 32*scale, 64*scale)
							for i=1, string_len(resclip) do
								DrawAmmoNum(resclip, i)
							end
						end
					end
				end
			end

			if wep.Secondary and (not wep.CanBeSilenced or (wep.CanBeSilenced and not wep:GetSilenced() and wep.Clip3)) then
				local clip2size = wep.Secondary.ClipSize
				local resclip2 = wep.Secondary.DefaultClip
				local clip2 = wep:Clip2()

				local flashing_sin = math.abs(math.sin(CurTime()*4))
				local clipsize = wep.Primary.ClipSize
				local ammoTotal = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
				local ammoType2 = wep:GetSecondaryAmmoType()
				local ammoTotal2 = ply:GetAmmoCount(ammoType2)

				local ammoCol = Color(255, 255, 255, 255)
				local lowclip = false

				if clip2size and clip2size > 0 and clip2 <= math.ceil(clip2size/4) then
					lowclip = true

					ammoCol.r = Lerp(flashing_sin, lerpcol_red.r, lerpcol_white.r)
					ammoCol.g = Lerp(flashing_sin, lerpcol_red.g, lerpcol_white.g)
					ammoCol.b = Lerp(flashing_sin, lerpcol_red.b, lerpcol_white.b)
					ammoCol.a = Lerp(flashing_sin, lerpcol_red.a, lerpcol_white.a)
				end

				local diff2 = math.max(string_len(wep:Clip1()), 1.5)*(32*1.4)

				if clip2size and clip2size > 0 then
					//akimbo weapons
					surface.SetDrawColor(color_white)
					surface.SetMaterial(t6_hud_num_line[hudtype])
					surface.DrawTexturedRect(w - (270 + diff2)*scale, h - 145*scale, 32*scale*1.4, 64*scale*1.4)
					for i=1, string_len(clip2) do
						DrawClip2Num(clip2, i, diff2, ammoCol)
					end
				else
					//weapons that have a secondary ammo pool but no clip2
					if ammoTotal2 and ammoTotal2 > 0 then
						surface.SetDrawColor(color_white)
						surface.SetMaterial(t6_hud_num_line[hudtype])
						surface.DrawTexturedRect(w - (270 + diff2)*scale, h - 145*scale, 32*scale*1.4, 64*scale*1.4)
						for i=1, string_len(ammoTotal2) do
							DrawClip2Num(ammoTotal2, i, diff2, ammoCol)
						end
					end
				end
			end

			//silencer/underbarrel/altattack
			if wep.CanBeSilenced then
				local icon = t6_icon_gl
				if wep.NZHudIcon then
					icon = wep.NZHudIcon
				end
				if not icon or icon:IsError() then
					icon = zmhud_icon_missing
				end

				surface.SetMaterial(icon)
				surface.DrawTexturedRect((w - 140*scale) - (24*scale), (h - 115*scale) - (24*scale), 48*scale, 48*scale)

				local ammoTotal2 = ply:GetAmmoCount(wep:GetSecondaryAmmoType()) + (wep.Clip3 and wep:Clip3() or wep:Clip2())
				if ammoTotal2 > 0 then
					draw.SimpleTextOutlined(ammoTotal2, ammofont, w - 135*scale, h - 100*scale, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)
				end
			end

			local aat = wep:GetNW2String("nzAATType", "")
			local style = nz_aatstyle:GetInt()
			local name = wep:GetPrintName()

			if aat ~= "" and style > 0 then
				name = name.." ("..nzAATs:Get(aat).name..")"
			end
			if aat ~= "" and nz_aatcolor:GetBool() then
				fontColor = nzAATs:Get(aat).color
			end

			draw.SimpleTextOutlined(name, fontsmall, w - 170*scale, h - 145*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 2, color_black_50)

			if nz_showgun:GetBool() and killicon.Exists(class) and aat == "" then
				surface.SetFont(fontsmall)
				local tw, th = surface.GetTextSize(name)

				killicon.Draw(w - 170*scale - (64*scale) - tw, h - 145*scale - (32*scale), class, 255)
			end

			if aat ~= "" and style == 0 then
				local fade = 255
				if wep:GetNW2Float("nzAATDelay", 0) > CurTime() then
					fade = 90
				end

				surface.SetFont(fontsmall)
				local tw, th = surface.GetTextSize(name)
				surface.SetMaterial(nzAATs:Get(aat).icon)
				surface.SetDrawColor(ColorAlpha(color_white, fade))
				surface.DrawTexturedRect(w - 170*scale - (58*scale) - tw, h - 140*scale - (48*scale), 48*scale, 48*scale)
			end

			if ply:HasPerk("mulekick") then
				surface.SetDrawColor(color_white_50)
				if IsValid(wep) and wep:GetNWInt("SwitchSlot") == 3 then
					surface.SetDrawColor(color_white)
				end
				surface.SetMaterial(GetPerkIconMaterial("mulekick", true))
				surface.DrawTexturedRect(w - 165*scale, h - 200*scale, 35*scale, 35*scale)
			end
		end
	end

	//grenade hud
	local specialweps = ply.NZSpecialWeapons or {}
	local tacnade = specialweps["specialgrenade"]
	local grenade = specialweps["grenade"]
	local num = ply:GetAmmoCount(GetNZAmmoID("grenade") or -1)
	local numspecial = ply:GetAmmoCount(GetNZAmmoID("specialgrenade") or -1)
	local scale = (w/1920 + 1) / 2

	if num > 0 then
		local icon = t6_icon_grenade
		if grenade and IsValid(grenade) and grenade.NZHudIcon_t5 then
			icon = grenade.NZHudIcon
		end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(icon)

		for i = num, 1, -1 do
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w - 70*scale - i*(35*scale), h - 35*scale, 32*scale, 32*scale)
		end
	end

	if numspecial > 0 then
		local icon = t5_icon_grenade
		if tacnade and IsValid(tacnade) and tacnade.NZHudIcon then
			icon = tacnade.NZHudIcon_t6 or tacnade.NZHudIcon
		end

		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		surface.SetMaterial(icon)
		for i = numspecial, 1, -1 do
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w - 230*scale - i*(35*scale), h - 35*scale, 32*scale, 32*scale)
		end
	end
end

local function PerksMMOHud_t6_dlc()
	if not nz_showmmostats:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawPerksHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and (illegalspecials[wep.NZSpecialCategory] or wep:GetClass() == "nz_multi_tool") then return end

	local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_red_200 or nzMapping.Settings.textcolor
	local w, h = ScrW(), ScrH()
	local scale = ((w/1920) + 1) / 2
	local curtime = CurTime()

	local traycount = 0
	for k, v in pairs(ply:GetPerks()) do
		local data = nzPerks:Get(v)
		if not data or not data.mmohud then continue end

		local mmohud = data.mmohud
		if not mmohud.style then continue end
		if mmohud.upgradeonly and not ply:HasUpgrade(v) then continue end

		surface.SetDrawColor(color_white)
		if (mmohud.countup and mmohud.max and ply:GetNW2Int(tostring(mmohud.count), 0) >= mmohud.max) or (mmohud.countdown and ply:GetNW2Int(tostring(mmohud.count), 0) == 0) or (mmohud.delay and ply:GetNW2Float(tostring(mmohud.delay), 0) > curtime) then
			surface.SetDrawColor(color_white_50)
		end

		surface.SetMaterial(GetPerkIconMaterial(v, true))
		surface.DrawTexturedRect(w - 405*scale - (40*traycount*scale), h - 75*scale, 35*scale, 35*scale)

		if ply:HasUpgrade(v) and mmohud.border and ply:GetNW2Float(tostring(mmohud.upgrade), 0) < curtime then
			surface.SetDrawColor(GetPerkColor(perk))
			surface.SetMaterial(GetPerkFrameMaterial(true))
			surface.DrawTexturedRect(w - 405*scale - (40*traycount*scale), h - 75*scale, 35*scale, 35*scale)
		end

		if mmohud.style == "toggle" then
		elseif mmohud.style == "count" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0), ChatFont, w - 370*scale - (40*traycount*scale), h - 35*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		elseif mmohud.style == "%" then
			local perkpercent = 100
			if mmohud.time then
				local perktime = ply:GetNW2Float(tostring(mmohud.delay), 0)
				local time = math.max(perktime - curtime, 0)
				perkpercent = math.Round(100 * (1 - math.Clamp(time / mmohud.max, 0, 1)))
			else
				perkpercent = 100 * (1 - math.Clamp(ply:GetNW2Int(tostring(mmohud.count), 0) / mmohud.max, 0, 1))
			end

			if (not mmohud.hide) or (mmohud.hide and perkpercent < 100) then
				draw.SimpleTextOutlined(perkpercent.."%", ChatFont, w - 370*scale - (40*traycount*scale), h - 35*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
			end
		elseif mmohud.style == "chance" then
			draw.SimpleTextOutlined(ply:GetNW2Int(tostring(mmohud.count), 0).."/"..mmohud.max, ChatFont, w - 370*scale - (40*traycount*scale), h - 35*scale, fontColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM, 1, color_black)
		end

		traycount = traycount + 1
	end
end

local stinkfade = 0
local function PerksHud_t6_dlc()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawPerksHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local scale = (ScrW()/1920 + 1)/2
	local perks = ply:GetPerks()

	local bleedtime = ply.GetBleedoutTime and ply:GetBleedoutTime() or nz_bleedouttime:GetFloat()
	local data = nzRevive.Players[ply:EntIndex()]
	if nz_bleedoutstyle:GetInt() == 0 and data then
		local pdata = data.PerksToKeep
		if pdata and next(pdata) ~= nil then
			perks = {}
			for k, v in ipairs(pdata) do
				perks[k] = v.id
			end
		end
	end

	local maxperks = ply:GetMaxPerks()
	local w = ScrW()/1920 + 10
	local h = ScrH()
	local size = 45

	local num = 0
	local row = 0
	local num_b = 0
	local row_b = 0

	//perk borders
	local perk_borders = nz_showperkframe:GetInt()
	if perk_borders > 0 and maxperks > 0 then
		local modded = false
		surface.SetMaterial(GetPerkFrameMaterial())
		surface.SetDrawColor(color_white_100)
		for i=1, ply:GetMaxPerks() do
			if i == 4 and nzMapping.Settings.modifierslot and perk_borders < 2 then
				surface.SetDrawColor(color_gold)
				modded = true
			end
			if i > #perks then
				surface.DrawTexturedRect(w + num_b*(size + 15)*scale, h - 210*scale - (64*row_b)*scale, 52*scale, 52*scale)
			end

			if modded then
				modded = false
				surface.SetDrawColor(color_white_100)
			end

			num_b = num_b + 1
			if num_b%(nz_perkrowmod:GetInt()) == 0 then
				row_b = row_b + 1
				num_b = 0
			end
		end
	end

	//perk icons
	for i, perk in pairs(perks) do
		local icon = GetPerkIconMaterial(perk)
		if not icon or icon:IsError() then
			icon = zmhud_icon_missing
		end

		local fuckset = 0
		local pulse = 1
		local perkcolor = color_white
		if data and data.DownTime and data.PerksToKeep and data.PerksToKeep[i] then
			local pdata = data.PerksToKeep[i]
			if pdata.lost then
				perkcolor = color_grey_100
			elseif !data.ReviveTime then
				local timetodeath = data.DownTime + bleedtime - CurTime()
				if (timetodeath / bleedtime) < (pdata.prc + (1/(#data.PerksToKeep + 1))) then
					local wave = math.Clamp(math.sin(CurTime()*6), 0, 1)
					pulse = math.Remap(wave, 0, 1, 1, 1.2)
					fuckset = 5.2*math.Remap(wave, 0, 1, 0, 1)
				end
			end
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(perkcolor)
		surface.DrawTexturedRect(w + num*(size + 15)*scale - fuckset*scale, h - (210 + fuckset)*scale - (64*row)*scale, 52*pulse*scale, 52*pulse*scale)

		if ply:HasUpgrade(perk) then
			surface.SetDrawColor(GetPerkColor(perk))
			surface.SetMaterial(GetPerkFrameMaterial())
			surface.DrawTexturedRect(w + num*(size + 15)*scale - fuckset*scale, h - (210 + fuckset)*scale - (64*row)*scale, 52*pulse*scale, 52*pulse*scale)
		end

		if perk == "vulture" then
			if ply:HasVultureStink() then
				stinkfade = 1
			end

			if stinkfade > 0 then
				surface.SetDrawColor(ColorAlpha(color_white, 255*stinkfade))

				surface.SetMaterial(zmhud_vulture_glow)
				surface.DrawTexturedRect((w + num*(size + 15)*scale) - 24*scale, (h - 210*scale - (64*row)*scale) - 24*scale, 100*scale, 100*scale)
				
				local stink = surface.GetTextureID("nz_moo/huds/t6/zm_hud_stink_ani_green")
				surface.SetTexture(stink)
				surface.DrawTexturedRect((w + num*(size + 15)*scale), (h - 210*scale - (64*row)*scale) - 62*scale, 64*scale, 64*scale)
			
				stinkfade = math.max(stinkfade - FrameTime()*3, 0)
			end
		end

		num = num + 1
		if num%(nz_perkrowmod:GetInt()) == 0 then
			row = row + 1
			num = 0
		end
	end
end

//This is a modified Classic nZ Round Counter... If you want a Counter thats styled after the classic era of Zombies, use this one.
local round_white = 0
local round_alpha = 255
local round_num = 0

local infmat = Material("materials/nz_moo/round_tallies/chalk_infinity.png", "smooth")
local tallymats = {
	Material("nz_moo/huds/t6/chalkmarks_1.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/chalkmarks_2.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/chalkmarks_3.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/chalkmarks_4.png", "unlitgeneric smooth"),
	Material("nz_moo/huds/t6/chalkmarks_5.png", "unlitgeneric smooth")
}

local round_posdata = {}
local round_intro = false
local intro_white = 255
local intro_alpha = 255
local intro_fade = 0
local intro_time = 0
local kys_time = 0

local tally_offset_killme = {
	[1] = 23,
	[2] = 45,
	[3] = 55,
	[4] = 68,
	[5] = 68,
	[6] = 150,
	[7] = 150,
	[8] = 150,
	[9] = 150,
	[10] = 150,
}

local function ResetRoundPos()
	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

	round_posdata[1] = wscale + 10*scale
	round_posdata[2] = h - 115*scale

	round_posdata[3] = wscale
	round_posdata[4] = h - 150*scale

	round_posdata[5] = wscale + 150*scale
	round_posdata[6] = h - 150*scale

	round_posdata[7] = wscale + 15*scale
	round_posdata[8] = h + 15
end

local function GameBeginRound(round)
	round_intro = true
	intro_time = CurTime() + 6.5
	intro_fade = 0
	nzDisplay.HUDIntroDuration = intro_time

	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

	local font = "nz.rounds.bo1"
	if nz_mapfont:GetBool() then
		font = "nz.rounds."..GetFontType(nzMapping.Settings.roundfont)
	end

	surface.SetFont(font)
	local tw, th = surface.GetTextSize(round or nzRound:GetNumber())

	round_posdata[1] = w/2 - 100*scale
	round_posdata[2] = h/2 + 25*scale

	round_posdata[3] = w/2 - (tally_offset_killme[round] or 15)*scale
	round_posdata[4] = h/2 + 2*scale

	round_posdata[5] = w/2 + (150 - (tally_offset_killme[round] or 15))*scale
	round_posdata[6] = h/2 + 2*scale

	round_posdata[7] = w/2 - tw/2
	round_posdata[8] = h/2 + th

	hook.Add("HUDPaint", "nz_fuckoffshitt", function()
		if intro_time > CurTime() then return end

		if kys_time == 0 then
			kys_time = CurTime() + 2
		end

		local kysratio = math.Clamp(((kys_time - 1) - CurTime())/1, 0, 1)
		intro_alpha = Lerp(kysratio, 0, 255)

		if kys_time < CurTime() then
			hook.Remove("HUDPaint", "nz_fuckoffshitt")

			round_intro = false
			intro_white = 255
			intro_alpha = 255
			intro_fade = 0
			kys_time = 0

			ResetRoundPos()
		end
	end)
end

local function RoundHud_t6_dlc()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawRoundHUD() then return end
	if ply:IsNZMenuOpen() then return end

	local font = "nz.rounds.blackops2"
	local font2 = "nz.main."..GetFontType(nzMapping.Settings.roundfont)
	if nz_mapfont:GetBool() then
		font = "nz.rounds."..GetFontType(nzMapping.Settings.roundfont)
	end

	local w, h = ScrW(), ScrH()
	local scale = (ScrW()/1920 + 1)/2
	local wscale = w/1920*scale

	local ourwhite = round_intro and intro_white or round_white
	local ouralpha = (round_intro and (intro_time > CurTime() and intro_fade or intro_alpha) or round_alpha)

	local color = Color(math.min(color_blood.r + ourwhite, 255), ourwhite, ourwhite, ouralpha)
	surface.SetDrawColor(color)

	if round_intro then
		if intro_time - 4.5 < CurTime() then
			intro_white = math.Approach(intro_white, 0, FrameTime()*140)
		end

		if nz_showgamebegintext:GetBool() then
			surface.SetFont(font2)
			local tw, th = surface.GetTextSize(nzMapping.Settings.gamebegintext)

			local fuck_alpha = math.Clamp(255 - intro_white, 0, 255)
			if intro_time < CurTime() then
				fuck_alpha = intro_alpha
			end

			draw.SimpleTextOutlined(nzMapping.Settings.gamebegintext, font2, ScrW()/2, h/2 - 2, Color(math.min(90 + ourwhite, 255), ourwhite, ourwhite, ouralpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, ColorAlpha(color_black, fuck_alpha))
		end

		if intro_time < CurTime() then
			color = Color(math.min(color_blood.r + ourwhite, 255), ourwhite, ourwhite, 255)
			surface.SetDrawColor(color)
		elseif intro_time > CurTime() and intro_fade < 255 then
			local iwandieratio = 1 - math.Clamp(((intro_time - 5) - CurTime())/1, 0, 1)
			intro_fade = Lerp(iwandieratio, 0, 255)
		end
	elseif round_posdata[1] ~= (wscale + 10*scale) then
		ResetRoundPos()
	end

	surface.SetFont(font)

	if table.IsEmpty(round_posdata) then
		ResetRoundPos()
	end
	if intro_time < CurTime() and kys_time > CurTime() then
		local kysratio = math.Clamp((kys_time - CurTime())/2, 0, 1)
		local tw, th = surface.GetTextSize(round_num)

		round_posdata[1] = Lerp(kysratio, wscale + 10*scale, w/2 - 100*scale)
		round_posdata[2] = Lerp(kysratio, h - 115*scale, h/2 + 25*scale)

		round_posdata[3] = Lerp(kysratio, wscale, w/2 - (tally_offset_killme[round_num] or 15)*scale)
		round_posdata[4] = Lerp(kysratio, h - 150*scale, h/2 + 2*scale)

		round_posdata[5] = Lerp(kysratio, wscale + 150*scale, w/2 + (150 - (tally_offset_killme[round_num] or 15))*scale)
		round_posdata[6] = Lerp(kysratio, h - 150*scale, h/2 + 2*scale) 

		round_posdata[7] = Lerp(kysratio, wscale + 15*scale, w/2 - tw/2)
		round_posdata[8] = Lerp(kysratio, h + 15, h/2 + th)
	end

	if round_num == -1 then
		surface.SetMaterial(infmat)
		surface.DrawTexturedRect(round_posdata[1], round_posdata[2], 200*scale, 100*scale)
		return
	end
	if round_num <= 10 and round_num > 0 then
		if round_num <= 5 then -- Instead of using text for the tallies, We're now using the actual tally textures instead.
			surface.SetMaterial(tallymats[round_num])
			surface.DrawTexturedRect(round_posdata[3], round_posdata[4], 140*scale, 140*scale)
		end
		if round_num <= 10 and round_num > 5 then
			surface.SetMaterial(tallymats[5]) -- Always display five.
			surface.DrawTexturedRect(round_posdata[3], round_posdata[4], 140*scale, 140*scale)

			surface.SetMaterial(tallymats[round_num - 5])
			surface.DrawTexturedRect(round_posdata[5], round_posdata[6], 140*scale, 140*scale)
		end
	else
		draw.SimpleText(round_num, font, round_posdata[7], round_posdata[8], color, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	end
end

local roundchangeending = false
local prevroundspecial = false
local function StartChangeRound_t6_dlc()
	local lastround = nzRound:GetNumber()

	if lastround >= 1 then
		if prevroundspecial then
			nzSounds:Play("SpecialRoundEnd")
		else
			nzSounds:Play("RoundEnd")
		end
	elseif lastround == -2 then
		surface.PlaySound("nz/round/round_-1_prepare.mp3")
	else
		round_num = 1
	end

	if !nzDisplay.HasPlayedRoundIntro then
		nzDisplay.HasPlayedRoundIntro = true
		GameBeginRound(lastround + 1)
	end

	roundchangeending = false
	round_white = 255
	local round_charger = 0.25
	local alphafading = false
	local haschanged = false
	hook.Add("HUDPaint", "nz_roundnumWhiteFade", function()
		if not alphafading then
			round_white = math.Approach(round_white, round_charger > 0 and 255 or 0, round_charger*350*FrameTime())
			if round_white >= 255 and not roundchangeending then
				alphafading = true
				round_charger = -1
			elseif round_white <= 0 and roundchangeending then
				hook.Remove("HUDPaint", "nz_roundnumWhiteFade")
			end
		else
			round_alpha = math.Approach(round_alpha, round_charger > 0 and 255 or 0, round_charger*350*FrameTime())
			if round_alpha >= 255 then
				if haschanged then
					round_charger = -0.25
					alphafading = false
				else
					round_charger = -1
				end
			elseif round_alpha <= 0 then
				if roundchangeending then
					round_num = nzRound:GetNumber()
					round_charger = 0.5
					if round_num == -1 then
					elseif nzRound:IsSpecial() then
						nzSounds:Play("SpecialRoundStart")
						prevroundspecial = true
					elseif nzRound:GetNumber() == 1 then
						nzSounds:Play("FirstRoundStart")
					else
						nzSounds:Play("RoundStart")
						prevroundspecial = false
					end
					haschanged = true
				else
					round_charger = 1
				end
			end
		end
	end)
end

local function EndChangeRound_t6_dlc()
	roundchangeending = true
end

local function ResetRound_t6_dlc()
	timer.Create("round_reseter", 0, 0, function()
		local ply = LocalPlayer()
		if not IsValid(ply) or not ply:Alive() then
			timer.Remove("round_reseter")
			round_white = 0
			round_alpha = 255
			round_num = 0
		end
	end)

	nzDisplay.HasPlayedRoundIntro = nil
end

local function PlayerHealthHUD_t6_dlc()
	if not nz_showhealth:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawScoreHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local wr = w - 260*scale
	local hr = h - 214*scale
	local lowres = scale < 0.96

	local armor = ply:Armor()
	local health = ply:Health()
	local maxhealth = ply:GetMaxHealth()
	local healthscale = math.Clamp(health / maxhealth, 0, 1)

	if nz_healthbarstyle:GetBool() then
		wr = 34*scale
		hr = h - 246*scale

		local row = 0
		local num = 0
		local perks = #ply:GetPerks()
		if ply:GetMaxPerks() > perks then
			perks = ply:GetMaxPerks()
		end
		perks = perks + #ply:GetPerks(true)

		for i=1, perks do
			if num%(nz_perkrowmod:GetInt()) == 0 then
				row = row + 1
				num = 0
			end
			num = num + 1
		end

		hr = hr - 64*(row - 1)

		if armor > 0 then
			wr = 64*scale
		end
	elseif nz_showcompass:GetBool() then
		hr = h - 258*scale
	end

	local smallfont = "nz.ammo2.blackops2"
	if nz_mapfont:GetBool() then
		smallfont = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end

	surface.SetMaterial(t6_hud_health)
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRect(wr - (34*scale), hr - 7*scale, 36*scale, 36*scale)

	surface.SetMaterial(t6_hud_healthbar)
	surface.SetDrawColor(color_health)
	surface.DrawTexturedRectUV(wr - (4*scale), hr - 4*scale, 264*scale, 32*scale, 0, 0, 1, 1)

	surface.SetMaterial(t6_hud_healthbar)
	surface.SetDrawColor(ColorAlpha(color_blood_score, 220))
	surface.DrawTexturedRectUV(wr, hr, 256*healthscale*scale, 24*scale, 0, 0, 1*healthscale, 1)

	if nz_showhealth:GetInt() > 1 then
		draw.SimpleTextOutlined(health, smallfont, wr - (lowres and 16 or 15)*scale, hr + 10*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
	end

	if armor > 0 then
		wr = wr - 32*scale
		local maxarmor = ply:GetMaxArmor()
		local armorscale = math.Clamp(armor / maxarmor, 0, 1)

		surface.SetMaterial(t6_hud_shield)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(wr - (38*scale), hr - 12*scale, 46*scale, 46*scale)

		surface.SetMaterial(t6_hud_shield)
		surface.SetDrawColor(color_armor)
		surface.DrawTexturedRectUV(wr - (38*scale), hr - 12*scale, 46*scale, 46*armorscale*scale, 0, 0, 1, 1*armorscale)

		if nz_showhealth:GetInt() > 1 then
			draw.SimpleTextOutlined(armor, smallfont, wr - (lowres and 16 or 15)*scale, hr + 10*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black_180)
		end
	end
end

local function PlayerStaminaHUD_t6_dlc()
end

local function ZedCounterHUD_t6_dlc()
	if not nz_showzcounter:GetBool() then return end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if !ply:ShouldDrawHUD() then return end
	if !ply:ShouldDrawScoreHUD() then return end
	if ply:IsNZMenuOpen() then return end

	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end
	
	if not (nzRound:InProgress() or nzRound:InState(ROUND_CREATE)) then return end

	local w, h = ScrW(), ScrH()
	local scale = (w/1920 + 1) / 2
	local wr = w - 340*scale
	local hr = h - 234*scale
	if nz_showcompass:GetBool() then
		hr = h - 262*scale
	end
	if nz_showhealth:GetBool() and LocalPlayer():Armor() > 0 and not nz_healthbarstyle:GetBool() then
		wr = w - 368*scale
	end

	surface.SetDrawColor(color_health)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr - (3*scale), hr - (2*scale), 52*scale, 52*scale)

	surface.SetDrawColor(color_blood_score)
	surface.SetMaterial(zmhud_icon_zedcounter)
	surface.DrawTexturedRect(wr, hr, 49*scale, 49*scale)

	local smallfont = "nz.ammo2.bo1"
	if nz_mapfont:GetBool() then
		smallfont = "nz.ammo2."..GetFontType(nzMapping.Settings.smallfont)
	end

	draw.SimpleTextOutlined(GetGlobal2Int("AliveZombies", 0), smallfont, wr + 25*scale, hr + 24*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_50)
end

-- Hooks
hook.Add("HUDPaint", "nzHUDswapping_t6_dlc", function()
	if t6_dlcHUDs[nzMapping.Settings.hudtype] then
		hook.Add("HUDPaint", "PlayerHealthBarHUD", PlayerHealthHUD_t6_dlc )
		hook.Add("HUDPaint", "PlayerStaminaBarHUD", PlayerStaminaHUD_t6_dlc )
		hook.Add("HUDPaint", "scoreHUD", ScoreHud_t6_dlc )
		hook.Add("HUDPaint", "perksHUD", PerksHud_t6_dlc )
		hook.Add("HUDPaint", "roundnumHUD", RoundHud_t6_dlc )
		hook.Add("HUDPaint", "perksmmoinfoHUD", PerksMMOHud_t6_dlc )
		hook.Add("HUDPaint", "0nzhudlayer", GunHud_t6_dlc )
		hook.Add("HUDPaint", "1nzhudlayer", InventoryHUD_t6_dlc )
		hook.Add("HUDPaint", "zedcounterHUD", ZedCounterHUD_t6_dlc )

		hook.Add("OnRoundPreparation", "BeginRoundHUDChange", StartChangeRound_t6_dlc )
		hook.Add("OnRoundStart", "EndRoundHUDChange", EndChangeRound_t6_dlc )
		hook.Add("OnRoundEnd", "GameEndHUDChange", ResetRound_t6_dlc )
	end
end)

//--------------------------------------------------/GhostlyMoo and Fox's BO2 DLC HUD\------------------------------------------------\\
