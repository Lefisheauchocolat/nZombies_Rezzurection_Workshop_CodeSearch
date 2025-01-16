if (CLIENT) then
	zmhud_icon_missing = Material("nz_moo/icons/statmon_warning_scripterrors.png", "unlitgeneric smooth")

	function GetFontType(id)
		if id == "Classic NZ" 		then return "classic" 	end
		if id == "Old Treyarch" 	then return "waw" 		end
		if id == "BO2/3" 			then return "blackops2" end
		if id == "Comic Sans" 		then return "xd" 		end
		if id == "Warprint" 		then return "grit" 		end
		if id == "Road Rage" 		then return "rage" 		end
		if id == "Black Rose" 		then return "rose" 		end
		if id == "Reborn" 			then return "reborn" 	end
		if id == "Rio Grande" 		then return "rio" 		end
		if id == "Bad Signal" 		then return "signal" 	end
		if id == "Infection" 		then return "infected" 	end
		if id == "Brutal World" 	then return "brutal" 	end
		if id == "Generic Scifi" 	then return "ugly" 		end
		if id == "Tech" 			then return "tech" 		end
		if id == "Krabby" 			then return "krabs" 	end
		if id == "Default NZR" 		then return "default" 	end
		if id == "BO4" 				then return "blackops4" end
		if id == "Black Ops 1" 		then return "bo1"		end
		if id == "WW2" 				then return "ww2"		end
		if id == "IW" 				then return "iw7"		end
		return "classic"
	end

	function GetPerkIconMaterial(perk, usemmo)
		local style = usemmo and nzMapping.Settings.mmohudtype or nzMapping.Settings.icontype
		return nzPerks:GetPerkIcon(perk, style)
	end

	function GetPowerupIconMaterial(powerup)
	    local powerupType = nzMapping.Settings.poweruptype
	    if not powerupType then return end

	    local b_dontflash = false
	    local data = nzPowerUps:Get(powerup)
	    if data and data.noflashing ~= nil then
	    	b_dontflash = tobool(data.noflashing)
	    end

	    return nzPowerUps:GetPowerupIcon(powerup, powerupType), b_dontflash
	end

	function GetPerkFrameMaterial(usemmo)
		local style = usemmo and nzMapping.Settings.mmohudtype or nzMapping.Settings.icontype
		return nzPerks:GetPerkBorder(style)
	end
end

if (SERVER) then
	util.AddNetworkString("nz_game_end_notif")

	//every hud needs a unique netmessage string
	util.AddNetworkString("nz_points_notification_bo1") 		//Black Ops 1
	util.AddNetworkString("nz_points_notification_bo2") 		//Black Ops 2
	util.AddNetworkString("nz_points_notification_bo2_dlc") 	//Black Ops 2 (Buried/Origins/MOTD)
	util.AddNetworkString("nz_points_notification_bo3") 		//Black Ops 3
	util.AddNetworkString("nz_points_notification_bo3_zod") 	//Shadows of Evil
	util.AddNetworkString("nz_points_notification_snowglobe") 	//Snowglobe
	util.AddNetworkString("nz_points_notification_oilrig") 		//Industrial Estate
	util.AddNetworkString("nz_points_notification_tomb_hd") 	//Origins (HD)
	util.AddNetworkString("nz_points_notification_encampment") 	//Encampment
	util.AddNetworkString("nz_points_notification_waw") 		//World at War
	util.AddNetworkString("nz_points_notification_prison_hd") 	//Mob of the Dead (HD)
	util.AddNetworkString("nz_points_notification_factory_hd")	//Der Riese Declassified
end

nzDisplay = nzDisplay or AddNZModule("Display")

//used to differentiate from PNG swap huds
nzDisplay.reworkedHUDs = {
	["Tranzit (Black Ops 2)"]	= true,
	["Black Ops 1"]				= true,
	["Buried"]					= true,
	["Mob of the Dead"]			= true,
	["Origins (Black Ops 2)"]	= true,
	["Black Ops 3"]				= true,
	["Shadows of Evil"]			= true,
	["Snowglobe"]				= true,
	["Industrial Estate"]		= true,
	["Origins (HD)"] 			= true,
	["Encampment"] 				= true,
	["World at War"] 			= true,
	["Mob of the Dead (HD)"] 	= true,
	["Der Riese Declassified"]	= true,
}

//used for sending points notification
nzDisplay.HUDnetstrings = {
	["Shadows of Evil"] 		= "nz_points_notification_bo3_zod",
	["Black Ops 3"] 			= "nz_points_notification_bo3",
	["Black Ops 1"] 			= "nz_points_notification_bo1",
	["Tranzit (Black Ops 2)"] 	= "nz_points_notification_bo2",
	["Mob of the Dead"] 		= "nz_points_notification_bo2_dlc",
	["Buried"] 					= "nz_points_notification_bo2_dlc",
	["Origins (Black Ops 2)"]	= "nz_points_notification_bo2_dlc",
	["Snowglobe"] 				= "nz_points_notification_snowglobe",
	["Industrial Estate"] 		= "nz_points_notification_oilrig",
	["Encampment"]				= "nz_points_notification_encampment",
	["Origins (HD)"]			= "nz_points_notification_tomb_hd",
	["World at War"]			= "nz_points_notification_waw",
	["Mob of the Dead (HD)"]	= "nz_points_notification_prison_hd",
	["Der Riese Declassified"]	= "nz_points_notification_factory_hd",
}

//used to set what powerup notification function to call per hud (scroll towards bottom of file)
nzDisplay.MaxAmmoNotifs = {
	["Tranzit (Black Ops 2)"]	= "ClassicMaxAmmo",
	["Black Ops 1"]				= "ClassicMaxAmmo",
	["Buried"] 					= "ClassicMaxAmmo",
	["Mob of the Dead"]			= "ClassicMaxAmmo",
	["Origins (Black Ops 2)"]	= "ClassicMaxAmmo",
	["Snowglobe"]				= "ClassicMaxAmmo",
	["Industrial Estate"]		= "ClassicMaxAmmo",
	["Encampment"]				= "ClassicMaxAmmo",
	["World at War"]			= "ClassicMaxAmmo",
	["Black Ops 3"]				= "T7MaxAmmo",
	["Shadows of Evil"]			= "T7ZODMaxAmmo",
	["Origins (HD)"]			= "T7TombMaxAmmo",
	["Mob of the Dead (HD)"]	= "T7PrisonMaxAmmo",
	["Der Riese Declassified"]	= "T7FactoryMaxAmmo",
}

//used for huds that have points on the left (so things can be shifted around if needed)
nzDisplay.leftsidedHUDs = {
	["Black Ops 3"]				= true,
	["Shadows of Evil"]			= true,
	["Origins (HD)"]			= true,
	["Mob of the Dead (HD)"]	= true,
	["Der Riese Declassified"]	= true,
	["Encampment"]				= true,
}

//used in cl_target for the black background on hint strings
nzDisplay.modernHUDs = {
	["Black Ops 3"] 			= true,
	["Black Ops 4"] 			= true,
	["Shadows of Evil"]			= true,
	["Origins (HD)"] 			= true,
	["Mob of the Dead (HD)"]	= true,
	["Der Riese Declassified"]	= true,
}

//used to get what font to use for what hud
nzDisplay.fonttypebyHUDs = {
	["Tranzit (Black Ops 2)"]	= "blackops2",
	["Black Ops 1"]				= "bo1",
	["Buried"] 					= "blackops2",
	["Mob of the Dead"]			= "blackops2",
	["Origins (Black Ops 2)"]	= "blackops2",
	["Snowglobe"]				= "bo1",
	["Industrial Estate"]		= "bo1",
	["Encampment"]				= "blackops2",
	["World at War"]			= "waw",
	["Black Ops 3"]				= "blackops2",
	["Shadows of Evil"]			= "blackops2",
	["Origins (HD)"]			= "blackops2",
	["Mob of the Dead (HD)"]	= "blackops2",
	["Der Riese Declassified"]	= "blackops2",
}

//used for different revive icon styles
nzDisplay.classicrevive = {
	["World at War"]			= true,
}

nzDisplay.t5revive = {
	["Black Ops 1"]				= true,
	["Industrial Estate"]		= true,
	["Snowglobe"]				= true,
}

nzDisplay.t6revive = {
	["Buried"]					= true,
	["Mob of the Dead"]			= true,
	["Origins (Black Ops 2)"]	= true,
	["Tranzit (Black Ops 2)"]	= true,
	["Encampment"]				= true,
}

nzDisplay.t7revive = {
	["Black Ops 3"]				= true,
	["Shadows of Evil"]			= true,
	["Origins (HD)"]			= true,
	["Mob of the Dead (HD)"]	= true,
	["Der Riese Declassified"]	= true,
}

//to be used later
nzDisplay.hudstruct = {
	"missingicon",
	"bloodoverlay",
	"playerindicator",
	"deathindicator",
	"deadshotindicator",
	"talkballoonicon",
	"thirdpersonicon",
}

//for gumball
nzDisplay.GumPosition = {
	["Tranzit (Black Ops 2)"]	= {x = 370, y = 248, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Black Ops 1"] 			= {x = 370, y = 268, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Buried"] 					= {x = 370, y = 248, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Mob of the Dead"] 		= {x = 370, y = 248, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Origins (Black Ops 2)"] 	= {x = 370, y = 248, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Black Ops 3"]				= {x = 162, y = 340, icon_size = 76, ring_size = 39, width = 6},
	["Shadows of Evil"] 		= {x = 162, y = 340, icon_size = 76, ring_size = 39, width = 6},
	["Snowglobe"] 				= {x = 370, y = 268, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Industrial Estate"] 		= {x = 370, y = 268, icon_size = 72, ring_size = 32, width = 5, zcounter_x = 42, armor_x = 32},
	["Origins (HD)"] 			= {x = 162, y = 340, icon_size = 76, ring_size = 39, width = 6},
	["Encampment"] 				= {x = 132, y = 280, icon_size = 76, ring_size = 39, width = 6},
	["World at War"] 			= {x = 4000, y = 4000, icon_size = 0, ring_size = 0, width = 1, custom = true},
	["Mob of the Dead (HD)"] 	= {x = 162, y = 340, icon_size = 76, ring_size = 39, width = 6},
	["Der Riese Declassified"]	= {x = 162, y = 340, icon_size = 76, ring_size = 39, width = 6},
	//["World at War"]			= {x = 384, y = 234, icon_size = 72, ring_size = 32, width = 5, armor_x = 32}, //has a custom one hud element for gum
}

//for use in adding custom powerup icon sets
//requires modifying sh_powerupicons to register different sets
nzDisplay.PowerupHudData = nzDisplay.PowerupHudData or {}
function nzDisplay:AddPowerupHUDType(id, dataname)
	if dataname then
		nzDisplay.PowerupHudData[id] = dataname
	else
		nzDisplay.PowerupHudData[id] = nil
	end
end

//Exmaple
/*nzDisplay:AddPowerupHUDType("Name", "Name")*/

nzDisplay:AddPowerupHUDType("Black Ops 1", "Black Ops 1") 
nzDisplay:AddPowerupHUDType("Black Ops 2", "Black Ops 2")
nzDisplay:AddPowerupHUDType("Black Ops 3", "Black Ops 2")
nzDisplay:AddPowerupHUDType("Shadows of Evil (Incomplete)", "Shadows of Evil (Incomplete)")
nzDisplay:AddPowerupHUDType("Black Ops 4", "Black Ops 4")
nzDisplay:AddPowerupHUDType("Cold War", "Cold War")
nzDisplay:AddPowerupHUDType("Black Ops 6", 	"Black Ops 6")
nzDisplay:AddPowerupHUDType("Comic Book", "Comic Book")
nzDisplay:AddPowerupHUDType("Velvet", "Velvet")
nzDisplay:AddPowerupHUDType("Christmas", "Christmas")
nzDisplay:AddPowerupHUDType("Modern Warfare Zombies", "Modern Warfare Zombies")

//for use in adding custom vulture icons to your own entities
nzDisplay.vultureHUDicons = nzDisplay.vultureHUDicons or {}
function nzDisplay:AddVultureIcon(id, material)
	if material then
		nzDisplay.vultureHUDicons[id] = material
	else
		nzDisplay.vultureHUDicons[id] = nil
	end
end

//Exmaple
/*nzDisplay:AddVultureIcon("entity_class", Material("path/to/icon.png", "smooth unlitgeneric"))*/

nzDisplay:AddVultureIcon("nz_ammo_matic", Material("nz_moo/vulture/fxt_zmb_question_mark.png", "smooth unlitgeneric")) 
nzDisplay:AddVultureIcon("pap", Material("nz_moo/vulture/fxt_zmb_perk_pap.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("wall_buys", Material("nz_moo/vulture/fxt_zmb_perk_rifle.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("random_box", Material("nz_moo/vulture/fxt_zmb_perk_magic_box.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("wunderfizz_machine", Material("nz_moo/vulture/fxt_zmb_question_mark.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("drop_widows", Material("nz_moo/vulture/t7_hud_mp_inventory_semtex.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("drop_tombstone", Material("nz_moo/vulture/specialty_tombstone_zombies.png", "smooth unlitgeneric"))
nzDisplay:AddVultureIcon("nz_gummachine", Material("nz_moo/vulture/fxt_zmb_gobblegum.png", "smooth unlitgeneric"))

//used in revive_system for hud based down/revive sounds 
nzDisplay.HUDdowndata = nzDisplay.HUDdowndata or {}
function nzDisplay:AddDownSoundsType(id, data)
	if data then
		nzDisplay.HUDdowndata[id] = data
	else
		nzDisplay.HUDdowndata[id] = nil
	end
end

//Exmaple
/*nzDisplay:AddDownSoundsType("Name", {
	down = "path/to/down_sound.wav", --not required
	loop = "path/to/down_loop_sound.wav",
	revive = "path/to/revived_sound.wav",
	delay = 0.5, --delay before playing downed loop after going down
	volume = 0.25, --downed loop sound level, you want this to be low
})*/

nzDisplay:AddDownSoundsType("Classic", {
	loop = "nz_moo/player/t6/laststand_loop.wav",
	revive = "nz_moo/player/t6/plr_revived.wav",
	delay = 0,
	volume = 0.5,
})

nzDisplay:AddDownSoundsType("Black Ops 3", {
	down = "nz_moo/player/t7/player_downed.wav",
	loop = "nz_moo/player/t7/player_downed_loop.wav",
	revive = "nz_moo/player/t7/player_revived.wav",
	delay = 0.5,
	volume = 0.25,
})




//-----------------------------------------------------------------------------------------------------//
//powerup notification code moved from cl_hud to here and turned into a table of function names per hud
//defaults to black ops 4 notification if not set manually
//-----------------------------------------------------------------------------------------------------//

if CLIENT then
	local t8_powerup_maxammotray = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_tray.png", "unlitgeneric smooth")
	local t8_powerup_maxammobg = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_bg.png", "unlitgeneric smooth")
	local t8_powerup_maxammocircle = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_circle.png", "unlitgeneric smooth")
	local t8_powerup_maxammoglow = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_glow.png", "unlitgeneric smooth")
	local t8_powerup_maxammospikes = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_spikes.png", "unlitgeneric smooth")
	local t8_powerup_maxammostar = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_star.png", "unlitgeneric smooth")
	local t8_powerup_maxammoswish = Material("nz_moo/huds/bo4/t8_zmhud_maxammo_swish.png", "unlitgeneric smooth")

	local t7_powerup_maxammobg = Material("nz_moo/huds/bo3/uie_t7_zm_hud_notif_backdesign_factory.png", "unlitgeneric smooth")
	local t7_powerup_maxammofg = Material("nz_moo/huds/bo3/uie_t7_zm_hud_notif_factory.png", "unlitgeneric smooth")

	local tomb_powerup_maxammobg = Material("nz_moo/huds/t7_tomb/uie_t7_zm_hud_notif_backdesign_factory.png", "unlitgeneric smooth")
	local tomb_powerup_maxammofg = Material("nz_moo/huds/t7_tomb/uie_t7_zm_hud_notif_factory.png", "unlitgeneric smooth")

	local t7zod_powerup_maxammobg = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_backdesign.png", "unlitgeneric smooth")
	local t7zod_powerup_maxammofg = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_cthuluph.png", "unlitgeneric smooth")
	local t7zod_powerup_maxammotext = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_txtbacking.png", "unlitgeneric smooth")
	local t7zod_powerup_maxammoctnr = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_txtcontainer.png", "unlitgeneric smooth")

	local t7prison_powerup_maxammobg = Material("nz_moo/huds/t7_prison/uie_t7_zm_hud_notif_backdesign_prison.png", "unlitgeneric smooth")
	local t7prison_powerup_maxammofg = Material("nz_moo/huds/t7_prison/uie_t7_zm_hud_notif_prison.png", "unlitgeneric smooth")
	local t7prison_powerup_maxammotext = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_txtbacking.png", "unlitgeneric smooth")
	local t7prison_powerup_maxammoctnr = Material("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_txtcontainer.png", "unlitgeneric smooth")

	local t7factory_powerup_maxammobg = Material("nz_moo/huds/t7_factory/uie_t7_zm_hud_notif_backdesign_factory.png", "unlitgeneric smooth")
	local t7factory_powerup_maxammofg = Material("nz_moo/huds/t7_factory/uie_t7_zm_hud_notif_factory.png", "unlitgeneric smooth")

	local color_black_180 = Color(0, 0, 0, 180)
	local color_t7 = Color(140, 255, 255, 255)
	local color_t7_outline = Color(0, 220, 255, 10)
	local color_t7zod = Color(255, 250, 100, 255)
	local color_t7zod_outline = Color(255, 120, 10, 40)
	local color_t7tomb = Color(255, 245, 245, 255)
	local color_t7tomb_outline = Color(200, 40, 80, 10)
	local color_t7factory = Color(255, 250, 245, 255)
	local color_t7factory_outline = Color(255, 140, 20, 10)
	local color_yellow = Color(255, 178, 0, 255)

	net.Receive("nzPowerUps.PickupHud", function( length )
		local text = net.ReadString()
		local dosound = net.ReadBool()
		
		nzDisplay:PowerupNotification(text, dosound)
	end)

	function nzDisplay:PowerupNotification(text, dosound)
		if not text then
			text = "Max Ammo!"
		end

		if dosound then
			if nzDisplay.MaxAmmoNotifs[nzMapping.Settings.hudtype] == "ClassicMaxAmmo" then
				surface.PlaySound("nz_moo/powerups/maxammo_flux.mp3")
			else
				surface.PlaySound("nz_moo/powerups/maxammo_flux_alt.mp3")
			end
		end

		local ply = LocalPlayer()
		if !ply:ShouldDrawHUD() then return end
		if !ply:ShouldDrawNotificationHUD() then return end

		local hudtype = nzMapping.Settings.hudtype

		if hudtype and nzDisplay.MaxAmmoNotifs[hudtype] then
			nzDisplay[nzDisplay.MaxAmmoNotifs[hudtype]](nzDisplay, text) //wow this looks fucking weird, but it works
		else
			nzDisplay:T8MaxAmmo(text)
		end
	end

	//black ops 4 style
	function nzDisplay:T8MaxAmmo(text)
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.5
		local faderateout = 0.3

		local timername = "t8_PowerupDraw"..LocalPlayer():EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t8_PowerupDraw", function()
			local ctime = CurTime()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2
			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			local powerupcol = ColorAlpha(color_white, alpha)
			local powerupcol2 = ColorAlpha(color_white, alpha*0.15)

			//--------------------------------MAXAMMO--------------------------------\\
			//---------BACKROUND---------\\	
			surface.SetMaterial(t8_powerup_maxammobg) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRect(w/2 - 125, 60, 250, 250)
			//---------BACKROUND---------\\

			//---------CIRCLE---------\\
			surface.SetMaterial(t8_powerup_maxammocircle) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRectRotated(w/2, 185, 250, 250, ctime * 10 % 360)
			//---------CIRCLE---------\\

			//---------SPIKES---------\\
			surface.SetMaterial(t8_powerup_maxammospikes) 
			surface.SetDrawColor(powerupcol2)	
			surface.DrawTexturedRectRotated(w/2, 185, 250, 250, ctime * -3 % 360)
			//---------SPIKES---------\\

			//---------STAR---------\\
			surface.SetMaterial(t8_powerup_maxammostar) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRectRotated(w/2, 185, 250, 250, ctime * -10 % 360)
			//---------STAR---------\\

			//---------GLOW---------\\
			surface.SetMaterial(t8_powerup_maxammoglow) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRect(w/2 - 125, 60, 250, 250)
			//---------GLOW---------\\

			//---------SWISH---------\\
			surface.SetMaterial(t8_powerup_maxammoswish) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRectRotated(w/2, 185, 250, 250, ctime * -500 % 360)
			//---------SWISH---------\\

			//---------TRAY---------\\
			surface.SetMaterial(t8_powerup_maxammotray) 
			surface.SetDrawColor(powerupcol)	
			surface.DrawTexturedRect(w/2 - 130, 210, 260, 30)
			//---------TRAY---------\\

			//---------TEXT---------\\
			draw.SimpleTextOutlined(text, "nz.pointsmain.blackops4", w/2, 230, ColorAlpha(color_yellow, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_black_180, 180*timescale))
			//---------TEXT---------\\
			//--------------------------------MAXAMMO--------------------------------\\	
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t8_PowerupDraw")
		end)
	end

	//black ops 3 style
	function nzDisplay:T7MaxAmmo(text)
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.6
		local faderateout = 0.3

		local timername = "t7_PowerupDraw"..LocalPlayer():EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t7_PowerupDraw", function()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2
			local ctime = CurTime()

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			//---------SPIKES---------\\
			surface.SetMaterial(t7_powerup_maxammobg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha*0.55))	
			surface.DrawTexturedRectRotated(w/2, 185*scale, 200*scale, 200*scale, ctime * 10 % 360)

			//---------BACKROUND---------\\	
			surface.SetMaterial(t7_powerup_maxammofg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha))	
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------TEXT---------\\
			draw.SimpleTextOutlined(text, "nz.ammo.bo3.main", w/2, 280*scale, ColorAlpha(color_t7, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_t7_outline, 10*timescale))
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t7_PowerupDraw")
		end)
	end

	//origins hd
	function nzDisplay:T7TombMaxAmmo(text)
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.6
		local faderateout = 0.3

		local timername = "tomb_PowerupDraw"..LocalPlayer():EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "tomb_PowerupDraw", function()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2
			local ctime = CurTime()

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			//---------SPIKES---------\\
			surface.SetMaterial(tomb_powerup_maxammobg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha*0.55))	
			surface.DrawTexturedRectRotated(w/2, 185*scale, 200*scale, 200*scale, ctime * 10 % 360)

			//---------BACKROUND---------\\	
			surface.SetMaterial(tomb_powerup_maxammofg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha))	
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------TEXT---------\\
			draw.SimpleTextOutlined(text, "nz.ammo.bo3.main", w/2, 280*scale, ColorAlpha(color_t7tomb, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_t7tomb_outline, 10*timescale))
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "tomb_PowerupDraw")
		end)
	end

	//shadows of evil
	function nzDisplay:T7ZODMaxAmmo(text)
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.6
		local faderateout = 0.3

		local timername = "t7zod_PowerupDraw"..LocalPlayer():EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t7zod_PowerupDraw", function()
			local ctime = CurTime()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			local powerupcol = ColorAlpha(color_white, alpha)

			//---------SPIKES---------\\
			surface.SetMaterial(t7zod_powerup_maxammobg) 
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------BACKROUND---------\\	
			surface.SetMaterial(t7zod_powerup_maxammofg) 
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------TEXT---------\\
			surface.SetMaterial(t7zod_powerup_maxammotext) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha*0.1))
			surface.DrawTexturedRect(w/2 - 114*scale, 220*scale, 228*scale, 60*scale)

			surface.SetMaterial(t7zod_powerup_maxammoctnr) 
			surface.SetDrawColor(ColorAlpha(color_t7zod_outline, alpha))	
			surface.DrawTexturedRect(w/2 - 144*scale, 220*scale, 288*scale, 48*scale)

			local notiffilm = surface.GetTextureID("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_glowfilm")
			surface.SetTexture(notiffilm)
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 290*scale, 10*scale, 624*scale, 360*scale)

			draw.SimpleTextOutlined(text, "nz.ammo.bo3zod.main", w/2, 280*scale, ColorAlpha(color_t7zod, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_t7zod_outline, 10*timescale))
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t7zod_PowerupDraw")
		end)
	end

	//mob of the dead hd
	function nzDisplay:T7PrisonMaxAmmo(text)
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.6
		local faderateout = 0.3

		local timername = "t7prison_PowerupDraw"..LocalPlayer():EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t7prison_PowerupDraw", function()
			local ctime = CurTime()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			local powerupcol = ColorAlpha(color_white, alpha)

			//---------SPIKES---------\\
			surface.SetMaterial(t7prison_powerup_maxammobg) 
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------BACKROUND---------\\	
			surface.SetMaterial(t7prison_powerup_maxammofg) 
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------TEXT---------\\
			surface.SetMaterial(t7zod_powerup_maxammotext) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha*0.1))
			surface.DrawTexturedRect(w/2 - 114*scale, 220*scale, 228*scale, 60*scale)

			surface.SetMaterial(t7zod_powerup_maxammoctnr) 
			surface.SetDrawColor(ColorAlpha(color_t7zod_outline, alpha))	
			surface.DrawTexturedRect(w/2 - 144*scale, 220*scale, 288*scale, 48*scale)

			local notiffilm = surface.GetTextureID("nz_moo/huds/t7_zod/uie_t7_zm_hud_notif_glowfilm")
			surface.SetTexture(notiffilm)
			surface.SetDrawColor(powerupcol)
			surface.DrawTexturedRect(w/2 - 290*scale, 10*scale, 624*scale, 360*scale)

			draw.SimpleTextOutlined(text, "nz.ammo.bo3zod.main", w/2, 280*scale, ColorAlpha(color_t7zod, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 4, ColorAlpha(color_t7zod_outline, 10*timescale))
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t7zod_PowerupDraw")
		end)
	end

	//black ops 3 but red
	function nzDisplay:T7FactoryMaxAmmo(text)
		local alpha = 0
		local decaytime = nil

		//variables
		local lifetime = 3.3
		local duration = 3

		//more is faster, less is slower
		local faderatein = 0.6
		local faderateout = 0.3

		local timername = "t7factory_PowerupDraw"..LocalPlayer():EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t7factory_PowerupDraw", function()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2
			local ctime = CurTime()

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			local timescale = math.Clamp((decaytime - CurTime()) / faderateout, 0, 1)
			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			//---------SPIKES---------\\
			surface.SetMaterial(t7factory_powerup_maxammobg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha*0.55))	
			surface.DrawTexturedRectRotated(w/2, 185*scale, 200*scale, 200*scale, ctime * 10 % 360)

			//---------BACKROUND---------\\	
			surface.SetMaterial(t7factory_powerup_maxammofg) 
			surface.SetDrawColor(ColorAlpha(color_white, alpha))	
			surface.DrawTexturedRect(w/2 - 100*scale, 90*scale, 200*scale, 200*scale)

			//---------TEXT---------\\
			draw.SimpleTextOutlined(text, "nz.ammo.bo3zod.main", w/2, 280*scale, ColorAlpha(color_t7factory, 255*timescale), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 1, ColorAlpha(color_t7factory_outline, 40*timescale))
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t7factory_PowerupDraw")
		end)
	end

	//classic style maxammo
	function nzDisplay:ClassicMaxAmmo(text)
		local alpha = 0
		local decaytime = nil
		local smallfont = ("nz.small.bo1")

		//variables
		local lifetime = 2.4
		local duration = 2

		//more is faster, less is slower
		local faderatein = 0.5
		local faderateout = 0.2
		local riserate = 0.2
		local traveldist = 200 //in pixels

		local timername = "t5_PowerupDraw"..LocalPlayer():EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		hook.Add("HUDPaint", "t5_PowerupDraw", function()
			local ctime = CurTime()
			local w, h = ScrW(), ScrH()/1080
			local scale = ((w/1920) + 1) / 2

			if not decaytime then
				decaytime = ctime + duration
			end

			local tickrate = 1 / engine.TickInterval()
			local fadein = (tickrate * faderatein) * tickrate
			local fadeout = (tickrate * faderateout) * tickrate

			if ctime < decaytime and alpha < 255 then
				alpha = math.min(alpha + fadein*FrameTime(), 255)
			end
			if ctime > decaytime and alpha > 0 then
				alpha = math.max(alpha - fadeout*FrameTime(), 0)
			end

			local white_fade = ColorAlpha(color_white, alpha)
			local black_fade = ColorAlpha(color_black_180, math.Clamp(alpha, 0, 180))
			local time = math.Clamp((decaytime - ctime) / duration, 0, 1)

			draw.SimpleTextOutlined(text, smallfont, w/2, h + ((750*scale) + (traveldist*(time*riserate)) * scale), white_fade, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, 2, black_fade)
		end)

		timer.Create(timername, lifetime, 1, function()
			hook.Remove("HUDPaint", "t5_PowerupDraw")
		end)
	end
end