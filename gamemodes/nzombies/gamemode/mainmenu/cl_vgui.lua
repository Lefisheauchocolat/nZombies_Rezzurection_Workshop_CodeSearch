CreateClientConVar("nz_key_settings", KEY_F1, true, true, "Sets the key for opening the settings menu.")

local w, h = ScrW(), ScrH()
local scale = ((w / 1920) + 1) / 2

surface.CreateFont( "pier_large", {
	font = "Helveticaneue Condensed",
	size = 48 * scale,
	antialias = true,
} )

surface.CreateFont( "pier_medium", {
	font = "Helveticaneue Condensed",
	size = 24 * scale,
	antialias = true,
} )

surface.CreateFont( "pier_small", {
	font = "Helveticaneue Condensed",
	size = 20 * scale,
	antialias = true,
} )

surface.CreateFont( "pier_smaller", {
	font = "Helveticaneue Condensed",
	size = 15 * scale,
	antialias = true,
} )

surface.CreateFont("BO6_Lobby48", {
    font = "Helveticaneue Condensed",
    extended = true,
    size = 40 * scale,
})

surface.CreateFont("BO6_Lobby32", {
    font = "Helveticaneue Condensed",
    extended = true,
    size = 24 * scale,
})

local soundPack = GetConVar("nz_lobby_ui_sfx"):GetString()
--local logoMat = Material("nz_moo/logo_fool.png")	
local logoMat = Material("bo6/other/logo.png")	

local MenuFrame = {}

AccessorFunc( MenuFrame, "fLastSpawnSwitch", "LastSpawnSwitch", FORCE_NUMBER )

function MenuFrame:Init()
	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)
	gui.EnableScreenClicker(true)

	self:SetMouseInputEnabled(true)  
	self:SetKeyboardInputEnabled(true)

	self.ToolBar = vgui.Create("NZMainMenuToolBar", self)
	self.Content = vgui.Create("NZMainMenuContent", self)
	self.PlayerList = vgui.Create("NZMainMenuPlayerList", self)

	self.CameraPos = LocalPlayer():GetPos() + Vector(30, 30, 30)
	self:SetLastSpawnSwitch(CurTime())

	self.MapInfoPanel = vgui.Create("NZMainMenuMapInfo", self)
end

function MenuFrame:Think()
	local ply = LocalPlayer()
	if ply:Alive() then return end
	if self:GetLastSpawnSwitch() + 15 < CurTime() then
		local sPoints = ents.FindByClass( "player_spawns" )
		if sPoints then
			local sPoint = sPoints[ math.random( #sPoints ) ]
			if IsValid( sPoint ) then
				ply:SetPos( sPoint:GetPos() )
				self.CameraPos = LocalPlayer():GetPos() + Vector( 20, 20, 40 )
				self:SetLastSpawnSwitch( CurTime() )
			end
		end
	end
	local vec1 = self.CameraPos
	local vec2 = ply:GetPos() + Vector( 0, 0, 20 )
	local ang = ( vec2 - vec1 ):Angle()
	ang:RotateAroundAxis( Vector( 0, 0, 1), math.sin( CurTime()/20 ) * 360 )
	ply:SetEyeAngles( ang )
	self:MoveToBack()
end

local matcolor = Material("color")
function MenuFrame:Paint()
	Derma_DrawBackgroundBlur( self, self.startTime )
	return
end

--It's not actually a frame but whatever
vgui.Register( "NZMainMenuFrame", MenuFrame, "DPanel")

local MapInfoPanel = {}

function MapInfoPanel:Init()
	self:SetZPos(110)
    self:SetSize(500 * scale, 330 * scale)
    self:SetPos(w - (520 * scale), h - (350 * scale))
    self:SetMouseInputEnabled(false)

    self.mapImagePath = nzSettings:GetSimpleSetting("Lobby_MapImage", "bo6/other/default_map.jpg")
    self.mapMaterial = Material(self.mapImagePath)
    self.mapName = nzSettings:GetSimpleSetting("Lobby_MapName", "Unknown Map")
    self.mapLocation = nzSettings:GetSimpleSetting("Lobby_MapLocation", "Unknown Location")
end

function MapInfoPanel:Think()
    local newPath = nzSettings:GetSimpleSetting("Lobby_MapImage", "bo6/other/default_map.jpg")
    if self.mapImagePath ~= newPath then
        self.mapImagePath = newPath
        self.mapMaterial = Material(newPath)
    end
    
    self.mapName = nzSettings:GetSimpleSetting("Lobby_MapName", "Unknown Map")
    self.mapLocation = nzSettings:GetSimpleSetting("Lobby_MapLocation", "Unknown Location")
end

function MapInfoPanel:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
    
    local imageW, imageH = w * 0.85, (w * 0.85) * (9 / 16)
    local imageX, imageY = (w - imageW) / 9, h * 0.25
    
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(self.mapMaterial)
    surface.DrawTexturedRect(imageX, imageY, imageW, imageH)
    
    draw.SimpleText(self.mapLocation, "BO6_Lobby32", 10, 15, Color(200, 200, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(self.mapName, "BO6_Lobby48", 10, 40, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end

vgui.Register("NZMainMenuMapInfo", MapInfoPanel, "DPanel")

local PlayerList = {}

function PlayerList:Init()
    local offsetX, offsetY = 70, h - (980 * scale)
    local width, height = 250, 50 + (#player.GetAll() * 40)

	self:SetZPos(110)
    self:SetMouseInputEnabled(false)
    self:SetPos(ScrW() - offsetX - width, offsetY)
    self:SetSize(width, height)
end

function PlayerList:Paint(w, h)
    surface.SetDrawColor(0, 0, 0, 200)
    surface.DrawRect(0, 0, w, h)

    draw.SimpleText("PLAYERS:", "pier_small", 10, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALfIGN_CENTER) -- spelling error. yeah no error and fixing it makes it not line up so im not fixing it :D
    
    surface.SetDrawColor(255, 255, 255)
    surface.DrawRect(10, 30, w - 20, 2)

    local yOffset = 30
    for k, v in ipairs(player.GetAll()) do
        if IsValid(v) then
            local nick = v:Nick()
            surface.SetFont("pier_smaller")
            local nick_w = surface.GetTextSize(nick)

            if nick_w > 120 then
                nick = string.Left(nick, 20) .. "..."
            end

            local status
            if v:IsReady() then
                status = "Ready"
            elseif nzRound:InState(ROUND_CREATE) and v:Alive() then
                status = "In Creative"
            else
                status = "Not Ready"
            end

            surface.SetFont("pier_small")
            local status_w = surface.GetTextSize(status)

            surface.SetDrawColor(80, 80, 80, 255)
            surface.DrawRect(10, yOffset + 10, w - 20, 30)

            draw.SimpleText(k .. ". " .. nick, "pier_smaller", 20, yOffset + 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            draw.SimpleText(status, "pier_smaller", w - 20 - status_w, yOffset + 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

            yOffset = yOffset + 40
        end
    end
end


vgui.Register("NZMainMenuPlayerList", PlayerList, "DPanel")

local MenuToolBar = {}
function MenuToolBar:Init()
    self:SetSize(ScrW(), ScrH())
    self:SetPos(0, 0)
	self:SetZPos(100)

    self.Entries = {}
    local yOffset = h - (850 * scale)
    local xOffset = 40 * scale
    local spacing = 15 * scale
    local buttonYOffset = 0

	local function AddMenuButton(label, fontSize, cmd, args, thinkFunc, yOffsetOverride, xOffsetOverride, isSubButton)
	    local entry = vgui.Create("DButton", self)
	    entry:SetText("")

	    entry:SetSize(300, 60)
	    entry:SetPos(xOffsetOverride or xOffset, yOffsetOverride or yOffset)

	    entry.Think = function(self)
	        if isfunction(thinkFunc) then
	            local newText = thinkFunc() or label
	            if self.CurrentText ~= newText then
	                self.CurrentText = newText
	            end
	        else
	            self.CurrentText = label
	        end
	    end

	    entry.Paint = function(self, w, h)
	        local isHovered = self:IsHovered()
	        draw.RoundedBox(8, 0, 0, w, h, isHovered and Color(235, 235, 235, 200) or Color(0, 0, 0, 200))
	        draw.SimpleText(self.CurrentText or label, 
	            fontSize == "large" and "pier_large" or fontSize == "medium" and "pier_medium" or "pier_small", 
	            10, h / 2, isHovered and Color(0, 0, 0) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	    end

	    entry.DoClick = function()
	        if isfunction(cmd) then
	            cmd()
	        elseif isstring(cmd) then
	            RunConsoleCommand(cmd, args)
	        end
            surface.PlaySound(isSubButton and "nz_moo/effects/ui/" .. soundPack .. "/main_click_fnt.mp3" or "nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
        end

        entry.OnCursorEntered = function(self)
            surface.PlaySound(isSubButton and "nz_moo/effects/ui/" .. soundPack .. "/slider_fnt.mp3" or "nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
        end

        if not yOffsetOverride then
            yOffset = yOffset + entry:GetTall() + spacing
        end
	    table.insert(self.Entries, entry)
	    return entry
	end


	AddMenuButton("READY UP", "medium", nil, nil, function() -- ready button
	    if nzRound:InProgress() then
	        return LocalPlayer():Alive() and "DROP OUT" or "DROP IN"
	    else
	        return LocalPlayer():IsReady() and "UNREADY" or "READY UP"
	    end
	end).DoClick = function()
	    if LocalPlayer():IsReady() then
	        RunConsoleCommand("nz_chatcommand", "/unready")
	    else
	        if nzRound:InState(ROUND_CREATE) then
	            RunConsoleCommand("nz_chatcommand", "/create")
	        end
	        RunConsoleCommand("nz_chatcommand", "/ready")
	    end
		RunConsoleCommand("nz_settings")
	end


    AddMenuButton("SPECTATE", "medium", "nz_chatcommand", "/spectate")

	AddMenuButton("SWITCH TO CREATIVE", "medium", function()
	    RunConsoleCommand("nz_chatcommand", "/create")
	end, nil, function() 
	    return LocalPlayer():IsInCreative() and "SWITCH TO SURVIVAL" or "SWITCH TO CREATIVE"
	end)

    AddMenuButton("KEYBINDS", "medium", function()
        nzLobby:CreateKeybindsMenu()
    end)

    AddMenuButton("DISCORD LINK", "medium", function()
        gui.OpenURL("https://discord.gg/KtVZmu24EZ")
    end)

    AddMenuButton("CLOSE MENU", "medium", function()
        RunConsoleCommand("nz_settings")
    end)

    AddMenuButton("Load Config", "small", function()
        RunConsoleCommand("nz_chatcommand", "/load")
    end, nil, nil, h - (100 * scale), nil, true)

    AddMenuButton("Save Config", "small", function()
        RunConsoleCommand("nz_chatcommand", "/save")
    end, nil, nil, h - (100 * scale), 370, true)  

    AddMenuButton("Quick Commands", "small", function()
        RunConsoleCommand("nz_chatcommand", "/cheats")
    end, nil, nil, h - (100 * scale), 685, true)   
end

local col = Color( 100, 0, 0, 0)
local nzmenubg = Material("nz_moo/nz_menu_leakmod_remake_remaster_rerun_gunga_swunga_bloodorcrip_v5.png", "noclamp smooth")


function MenuToolBar:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, col)
    surface.SetDrawColor(255, 0, 0, 255)
    surface.SetMaterial(nzmenubg)
    surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(logoMat)
    surface.DrawTexturedRect(0, 0, 750 * scale, 180 * scale)  
end

function MenuToolBar:AddEntry( lbl, fontSize, cmd, args )
	local entry = vgui.Create( "NZMainMenuToolBarEntry", self )
	if fontSize == "large" then
		entry:SetFont( "pier_large" )
	elseif fontSize == "medium" then
		entry:SetFont( "pier_medium" )
	else
		entry:SetFont( "pier_small" )
	end
	local nextPos = 300
	for _, v in pairs( self.Entries ) do
		nextPos = nextPos + v:GetWide() + 30
	end
	entry:SetPos( nextPos, 0 )
	entry:SetTall( self:GetTall() )
	if isfunction( cmd ) then
		entry.DoClick = cmd
	elseif isstring( cmd ) then
		entry:SetConsoleCommand( cmd, args )
	end
	entry:SetText( lbl )
	entry:SetContentAlignment( 5 )

	table.insert( self.Entries, 1, entry )

	return self.Entries[ 1 ]
end

vgui.Register( "NZMainMenuToolBar", MenuToolBar, "DPanel")


local MenuToolBarEntry = {}

function MenuToolBarEntry:Init()
	self:SetSize( 260, 60 )
	self:SetFont( "pier_large" )
	self:SetContentAlignment( 5 )
	self:SetTextColor( Color( 255, 255, 255 ) )
end

function MenuToolBarEntry:Paint()

end

vgui.Register( "NZMainMenuToolBarEntry", MenuToolBarEntry, "DButton")

local MenuContent = {}

function MenuContent:Init()
	self.Layouts = {}
	self.ActiveLayout = "main"
	self:SetSize(ScrW(), ScrH() - 80 )
	self:SetPos( 0, 80 )

	--Main Page of the menu
	local mainLayout = vgui.Create( "NZMainMenuContentLayout" )

	self:AddLayout( "main", mainLayout )

	--Set Active page to main on Init
	self:SetActiveLayout( "main" )

end

function MenuContent:SetActiveLayout( name )
	self:GetActiveLayout():SetVisible( false )
	self.ActiveLayout = name
	self:GetActiveLayout():SetVisible( true )
end

function MenuContent:GetActiveLayout()
	return self.Layouts[ self.ActiveLayout ]
end

function MenuContent:Paint()
	return
end

function MenuContent:AddLayout( name, layout )
	layout:SetParent( self )
	self.Layouts[name] = layout
end

vgui.Register( "NZMainMenuContent", MenuContent, "DPanel")


local MenuContentLayout = {}

function MenuContentLayout:Init()
	self.Panels = {}
	self:SetSize( 768, 512 )
	self:SetPos( ScrW() / 2 - 384, ScrH() / 2 - 20 )
	self:SetVisible( false )
end

function MenuContentLayout:GetPanels()
	return self.Panels
end

function MenuContentLayout:Paint()
	return
end

function MenuContentLayout:AddPanel( pnl, startGridX, startGridY, gridSizeX, gridSizeY )
	local gridSize = 128
	pnl:SetParent( self )
	pnl:SetPos( gridSize * ( startGridX - 1 ), gridSize * (startGridY - 1) )
	pnl:SetSize( gridSize * gridSizeX, gridSize * gridSizeY )
	table.insert( self.Panels, pnl )
end

vgui.Register( "NZMainMenuContentLayout", MenuContentLayout, "DPanel")

local function showSettings(ply, cmd, args)
    if gui.IsGameUIVisible() then
        if IsValid(g_Settings) and g_Settings:IsVisible() then
            g_Settings:Hide()
            surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/sys_close.mp3")
            gui.EnableScreenClicker(false)
            g_Settings:Remove()
        end
        return
    end

    if not IsValid(g_Settings) then
        g_Settings = vgui.Create("NZMainMenuFrame")
        g_Settings:SetVisible(false)
    end

    if IsValid(g_Settings) then
        if g_Settings:IsVisible() then
            g_Settings:Hide()
            surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/sys_close.mp3")
            gui.EnableScreenClicker(false)
            g_Settings:Remove()
        else
            g_Settings:Show()
            surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/sys_open.mp3")
            gui.EnableScreenClicker(true)
            g_Settings:SetVisible(true)

            if IsValid(nzInterfaces.ConfigVoter) then 
                nzInterfaces.ConfigVoter:Show() 
            end
        end
    end
end
local lastPress = 0
hook.Add("Think", "nZ_Settings_Think", function()
    if gui.IsGameUIVisible() and IsValid(g_Settings) and g_Settings:IsVisible() then
        g_Settings:Hide()
        gui.EnableScreenClicker(false)
        g_Settings:Remove()
    end
    if input.IsKeyDown(LocalPlayer():GetInfoNum("nz_key_settings", KEY_F1)) then
        if not LocalPlayer().lastPress or CurTime() - LocalPlayer().lastPress > 0.2 then
            LocalPlayer().lastPress = CurTime()
            LocalPlayer():ConCommand("nz_settings")
        end
    end
end)

concommand.Add("nz_settings", showSettings)

/*hook.Add("InitPostEntity", "AutoOpenMenu", function()
	LocalPlayer():ConCommand("nz_settings")
end)*/
