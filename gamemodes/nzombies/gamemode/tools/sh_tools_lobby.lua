-- Made by Hari exclusive for nZombies Onslaught. Copying this code is prohibited!

nzTools:CreateTool("lobbysettings", {
	displayname = "Lobby Settings",
	desc = "Just set settings in tool menu",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)

	end,
	SecondaryAttack = function(wep, ply, tr, data)

	end,
	Reload = function(wep, ply, tr, data)
		-- Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Lobby Settings",
	desc = "Just set settings in tool menu",
	icon = "icon16/building_link.png",
	weight = 5.4,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		local Row1 = DProperties:CreateRow("Config Settings", "Enable Lobby System?")
		Row1:Setup("Boolean")
		Row1:SetValue(nzSettings:GetSimpleSetting("Lobby_Enabled", false))
		nzSettings:SyncValueToElement("Lobby_Enabled", Row1)
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("Lobby_Enabled", tobool(val))
		end
		
		local Row2 = DProperties:CreateRow("Config Settings", "Ready Players Percent to Start")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("Lobby_Percent", 75))
		nzSettings:SyncValueToElement("Lobby_Percent", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("Lobby_Percent", tonumber(val) or 75)
		end

		local Row2 = DProperties:CreateRow("Config Settings", "Time Before Start")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("Lobby_TimeBeforeStart", 10))
		nzSettings:SyncValueToElement("Lobby_TimeBeforeStart", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("Lobby_TimeBeforeStart", tonumber(val) or 10)
		end

		local Row2 = DProperties:CreateRow("Config Settings", "Map Name")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("Lobby_MapName", "Zombie Invasion"))
		nzSettings:SyncValueToElement("Lobby_MapName", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("Lobby_MapName", tostring(val))
		end

		local Row2 = DProperties:CreateRow("Config Settings", "Map Location")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("Lobby_MapLocation", "Setup Config"))
		nzSettings:SyncValueToElement("Lobby_MapLocation", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("Lobby_MapLocation", tostring(val))
		end

		local Row2 = DProperties:CreateRow("Config Settings", "Map Image Path")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("Lobby_MapImage", "bo6/other/default_map.jpg"))
		nzSettings:SyncValueToElement("Lobby_MapImage", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("Lobby_MapImage", tostring(val))
		end

		local Row1 = DProperties:CreateRow("Background Settings", "Lobby Background Image Path")
		Row1:Setup("Generic")
		Row1:SetValue(nzSettings:GetSimpleSetting("Lobby_Background", "bo6/other/lobby_bg.png"))
		nzSettings:SyncValueToElement("Lobby_Background", Row2)
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("Lobby_Background", tostring(val))
		end

		local Row2 = DProperties:CreateRow("Background Settings", "Lobby Music Path")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("Lobby_Music", "nz_moo/menuthemes/damned_1.ogg"))
		nzSettings:SyncValueToElement("Lobby_Music", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("Lobby_Music", tostring(val))
		end
		
  		local defaultAmbient = Vector(1, 0.71, 0.71)
        local defaultBacklight = Vector(0.349, 0.098, 0.098)
        local defaultFrontlight = Vector(1, 0.64, 0.52)

        local colorSettingsPanel = vgui.Create("DPanel", DProperties)
        colorSettingsPanel:SetSize(480, 180)
        colorSettingsPanel:SetPos(0, 207)
        colorSettingsPanel:SetBackgroundColor(Color(245, 245, 245))


        local function addLabel(panel, text, x, y)
            local label = vgui.Create("DLabel", panel)
            label:SetText(text)
            label:SetFont("Trebuchet18")
            label:SetTextColor(Color(0, 0, 0))
            label:SetPos(x, y)
            label:SizeToContents()
        end
        addLabel(colorSettingsPanel, "Ambient Light Color", 10, 5)
        addLabel(colorSettingsPanel, "Backlight Color", 160, 5)
        addLabel(colorSettingsPanel, "Frontlight Color", 310, 5)


        local function createColorMixer(panel, setting, default, x, y)
            local colorMixer = vgui.Create("DColorMixer", panel)
            local storedColor = nzSettings:GetSimpleSetting(setting, default)
            colorMixer:SetColor(Color(storedColor.x * 255, storedColor.y * 255, storedColor.z * 255))
            colorMixer:SetPalette(false)
            colorMixer:SetAlphaBar(false)
            colorMixer:SetWangs(true)
            colorMixer:SetPos(x, y)
            colorMixer:SetSize(140, 120)
            colorMixer.ValueChanged = function(col)
                timer.Simple(0, function()
                    local color = colorMixer:GetColor()
                    nzSettings:SetSimpleSetting(setting, Vector(color.r / 255, color.g / 255, color.b / 255))
                end)
            end
            return colorMixer
        end

        local ambientColorMixer 	= createColorMixer(colorSettingsPanel, "AmbientLightColor", defaultAmbient, 10, 30)
        local backlightColorMixer 	= createColorMixer(colorSettingsPanel, "BacklightColor", defaultBacklight, 160, 30)
        local frontlightColorMixer 	= createColorMixer(colorSettingsPanel, "FrontlightColor", defaultFrontlight, 310, 30)

        -- Reset Button
        local resetButton = vgui.Create("DButton", DProperties)
        resetButton:SetText("Reset to Default Colors")
        resetButton:SetPos(10, 360)
        resetButton:SetSize(150, 25)
        resetButton.DoClick = function()
            ambientColorMixer:SetColor(Color(defaultAmbient.x 			* 255, defaultAmbient.y * 255, defaultAmbient.z * 255))
            backlightColorMixer:SetColor(Color(defaultBacklight.x 		* 255, defaultBacklight.y * 255, defaultBacklight.z * 255))
            frontlightColorMixer:SetColor(Color(defaultFrontlight.x 	* 255, defaultFrontlight.y * 255, defaultFrontlight.z * 255))

            nzSettings:SetSimpleSetting	("AmbientLightColor", defaultAmbient)
            nzSettings:SetSimpleSetting	("BacklightColor", defaultBacklight)
            nzSettings:SetSimpleSetting	("FrontlightColor", defaultFrontlight)
        end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Lobby module made by Hari, Background & color customization made by Latte")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 400)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		return DProperties
	end,
	--defaultdata = {}
})