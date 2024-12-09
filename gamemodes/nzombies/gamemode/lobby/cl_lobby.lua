-- Made by Hari exclusive for nZombies Rezzurrection. Copying this code is prohibited!

nzLobby = nzLobby or {}

local showLobbyBG = CreateConVar("nz_lobby_show_bg", "1", FCVAR_ARCHIVE, "Change how the background is displayed in the pregame lobby. (0: No Background, 1: Default Background, 2: Simple Background)")
local showLobbyCharacters = CreateConVar("nz_lobby_show_characters", "1", FCVAR_ARCHIVE, "Hide or show playermodels in the pregame lobby. (0: Hide Playermodels 1: Show Playermodels)")
local showLobbyLogo = CreateConVar("nz_lobby_show_logo", "1", FCVAR_ARCHIVE, "Hide or show the logo in the pregame lobby. (0: Hide Logo 1: Show Logo)")
local textAlignmentConVar = CreateConVar("nz_lobby_text_alignment", "0", FCVAR_ARCHIVE, "Change text alignment for lobby buttons. (0: Left 1: Center)")

local gradientBG = Material("bo6/other/lobby_bg_simple.png")
local logoMat = Material("bo6/other/logo.png")
local markMat = Material("vgui/menu_lobby_ready.png", "mips")
local crossMat = Material("vgui/menu_lobby_not_ready.png", "mips")
local musicchannel = nil
local lobbypanel = nil
local animtab = {"nz_idles_f_crossedfront", "nz_idles_m_armsback", "nz_idles_m_armsfront", "nz_idles_m_hipleft", "nz_idles_m_hipright", "nz_idles_m_hips"}
local campostab1 = {Vector(100,0,60), Vector(120,-16,60), Vector(120,16,60), Vector(140,-32,60), Vector(140,32,60)}
local campostab2 = {Vector(0,0,60), Vector(0,-20,60), Vector(0,20,60), Vector(0,-40,60), Vector(0,40,60)}

local function We(x)
    return x/1920*ScrW()
end

local function He(y)
    return y/1080*ScrH()
end

local function ScaleToAspect(origWidth, origHeight, maxWidth, maxHeight) 
    local aspectRatio = origWidth / origHeight
    local scaleWidth, scaleHeight

    if maxWidth / maxHeight > aspectRatio then
        scaleWidth = maxHeight * aspectRatio
        scaleHeight = maxHeight
    else
        scaleWidth = maxWidth
        scaleHeight = maxWidth / aspectRatio
    end

    return scaleWidth, scaleHeight
end
       
surface.CreateFont("BO6_Lobby96", {
    font = "Helveticaneue Condensed",
    extended = true,
    size = He(88),
})

surface.CreateFont("BO6_Lobby48", {
    font = "Helveticaneue Condensed",
    extended = true,
    size = He(40),
})

surface.CreateFont("BO6_Lobby32", {
    font = "Helveticaneue Condensed",
    extended = true,
    size = He(24),
})

surface.CreateFont("BO6_Lobby18", {
    font = "Helveticaneue Condensed",
    extended = true,
    size = He(18),
})

surface.CreateFont("BO6_Lobby14", {
    font = "Helveticaneue Condensed",
    extended = true,
    size = He(14),
})

function nzLobby:CanOpenLobby()
    local ply = LocalPlayer()
    if nzRound:GetState() != ROUND_WAITING or gui.IsGameUIVisible() or ply:Alive() or nzLobby:HaveOpenedPanels() then
        return false 
    end
    return true
end

function nzLobby:HaveOpenedPanels()
    local bool = false 
    for _, child in pairs(vgui.GetWorldPanel():GetChildren()) do
        if child != lobbypanel and child:IsVisible() and ( child:GetName() == "NZMainMenuFrame" ) then
            bool = true
        end
    end
    return bool
end

function nzLobby:ClosePanels()
    for _, child in pairs(vgui.GetWorldPanel():GetChildren()) do
        if (!IsValid(lobbypanel) or child != lobbypanel) and child:IsVisible() then
            if ( child:GetName() == "NZMainMenuFrame" ) then
                RunConsoleCommand("nz_settings")
            end
        end
    end
end

local function setup_mp(pnl, vec1, vec2)
    pnl:SetCamPos(vec1)
    if vec2 then
        pnl:SetLookAt(vec2)
    end

    local bgOption = showLobbyBG:GetInt()
    local ambientColor = nzSettings:GetSimpleSetting("AmbientLightColor", Vector(1, 0.71, 0.71))
    local backlightColor = nzSettings:GetSimpleSetting("BacklightColor", Vector(0.349, 0.098, 0.098))
    local frontlightColor = nzSettings:GetSimpleSetting("FrontlightColor", Vector(1, 0.64, 0.52))

    local function vectorToColor(vec)
        return Color(vec.x * 255, vec.y * 255, vec.z * 255)
    end

    if bgOption == 0 then
        pnl:SetAmbientLight(Color(200, 200, 200))
        pnl:SetDirectionalLight(BOX_FRONT, Color(200, 200, 200))
        pnl:SetDirectionalLight(BOX_RIGHT, Color(255, 255, 255))
    elseif bgOption == 2 then
        pnl:SetAmbientLight(Color(165, 154, 149))
        pnl:SetDirectionalLight(BOX_FRONT, Color(255, 201, 165))
        pnl:SetDirectionalLight(BOX_RIGHT, Color(255, 255, 255))
    else
        pnl:SetAmbientLight(vectorToColor(ambientColor))
        pnl:SetDirectionalLight(BOX_FRONT, vectorToColor(backlightColor))
        pnl:SetDirectionalLight(BOX_RIGHT, vectorToColor(frontlightColor)) 
    end

    pnl:SetDirectionalLight(BOX_TOP, Color(0, 0, 0))
    pnl:SetDirectionalLight(BOX_BOTTOM, Color(0, 0, 0))
    pnl:SetDirectionalLight(BOX_LEFT, Color(0, 0, 0))
    pnl:SetDirectionalLight(BOX_BACK, Color(0, 0, 0))
end


local pmmodels = {}
local maxMeatbags = 5

function nzLobby:CreatePlayerModels(frame)
    if showLobbyCharacters:GetBool() then
        for _, p in pairs(pmmodels) do
            p:Remove()
        end
        pmmodels = {}

        local tab = table.Copy(player.GetAll())
        table.Shuffle(tab)

        local totalPlayers = math.min(#tab, maxMeatbags)

        for k = 1, totalPlayers do
            local ply = tab[k]
            if not campostab1[k] then break end

            local mdl = vgui.Create("DModelPanel", frame)
            mdl:MoveToBack()
            mdl:SetSize(frame:GetSize())
            mdl:SetPos(180, 0)
            mdl:SetModel(ply:GetModel())
            mdl:GetEntity():SetSequence(table.Random(animtab) .. "_loop")
            mdl:GetEntity():SetCycle(math.Rand(0, 1))
            mdl:GetEntity():SetEyeTarget(campostab1[k])

            local playerSkin = ply:GetSkin() or 0
            mdl:GetEntity():SetSkin(playerSkin)

            for bodyGroupIndex = 0, mdl:GetEntity():GetNumBodyGroups() - 1 do
                local groupValue = ply:GetBodygroup(bodyGroupIndex) or 0
                mdl:GetEntity():SetBodygroup(bodyGroupIndex, groupValue)
            end

            local playerColor = ply:GetPlayerColor() or Vector(1, 1, 1)
            mdl:GetEntity().GetPlayerColor = function() return playerColor end

            table.insert(pmmodels, mdl)
            setup_mp(mdl, campostab1[k], campostab2[k])

            function mdl:LayoutEntity(ent)
                if IsValid(ply) then
                    if ply:GetModel() ~= ent:GetModel() then
                        ent:SetModel(ply:GetModel())
                        ent:SetSequence(table.Random(animtab) .. "_loop")
                        ent:SetCycle(math.Rand(0, 1))
                        ent:SetEyeTarget(campostab1[k])
                    end

                    ent:SetSkin(ply:GetSkin() or 0)
                    for bodyGroupIndex = 0, ent:GetNumBodyGroups() - 1 do
                        ent:SetBodygroup(bodyGroupIndex, ply:GetBodygroup(bodyGroupIndex) or 0)
                    end

                    ent.GetPlayerColor = function() return ply:GetPlayerColor() or Vector(1, 1, 1) end
                end

                self:RunAnimation()
                if ent:GetCycle() == 1 and string.match(ent:GetSequenceName(ent:GetSequence()), "_loop") then
                    ent:SetCycle(0)
                end
            end
        end

        frame.PaintOver = function(self)
            if #pmmodels ~= totalPlayers then
                nzLobby:CreatePlayerModels(self)
            end
        end
    else
        for _, p in pairs(pmmodels) do
            p:Remove()
        end
        pmmodels = {}
    end
end

local function open_lobby_menu()
    if !nzSettings:GetSimpleSetting("Lobby_Enabled", true) or IsValid(lobbypanel) then return end

    RunConsoleCommand("stopsound")
    timer.Simple(0.01, function()
        if IsValid(musicchannel) then 
            musicchannel:Stop() 
            musicchannel = nil
        end
        if nzSettings:GetSimpleSetting("Lobby_Music", "nz_moo/menuthemes/damned_1.ogg") != "" then
            sound.PlayFile("sound/"..nzSettings:GetSimpleSetting("Lobby_Music", "nz_moo/menuthemes/damned_1.ogg"), "", function(ch)
                if !IsValid(ch) then return end
                musicchannel = ch
            end)
        end
    end)
    nzLobby:ClosePanels()

    local map_image_name = nzSettings:GetSimpleSetting("Lobby_MapImage", "bo6/other/default_map.jpg")
    local map_image = Material(map_image_name)
    local time_before_start = 0
    local time_before_start_delta = 0
    local time_before_start_last = 0
    local time_num_height = 0
    local time_num_alpha = 0
    local frame = vgui.Create("DFrame")

    local maxMapWidth, maxMapHeight = We(480), He(270)
    local origWidth, origHeight = map_image:Width(), map_image:Height()
    local mapWidth, mapHeight = ScaleToAspect(origWidth, origHeight, maxMapWidth, maxMapHeight)

    frame:SetTitle("")
    frame:SetSize(ScrW(), ScrH())
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame:MakePopup()
    lobbypanel = frame
    frame.Think = function(self)
        if map_image_name != nzSettings:GetSimpleSetting("Lobby_MapImage", "bo6/other/default_map.jpg") then
            map_image_name = nzSettings:GetSimpleSetting("Lobby_MapImage", "bo6/other/default_map.jpg")
            map_image = Material(map_image_name)
        end

        if nzLobby:CanStart() and time_before_start == 1 and not self.BlackScreenEnd then
            local blk = vgui.Create("DPanel", frame)
            blk:SetSize(ScrW(), ScrH())
            blk.Paint = function(self, w, h)
                surface.SetDrawColor(0,0,0)
                surface.DrawRect(0, 0, w, h)
            end
            blk:AlphaTo(0, 0)
            LocalPlayer():ScreenFade(SCREENFADE.IN, color_black, 1, 2)
            blk:AlphaTo(255, 1, 0, function()
                frame:Remove()
                nzLobby:ClosePanels()
            end)
            self.BlackScreenEnd = blk
        end
    end
    frame.OnRemove = function()
        timer.Simple(0.02, function()
            if IsValid(musicchannel) then 
                musicchannel:Stop() 
                musicchannel = nil
            end
        end)
    end
    frame.Paint = function(self, w, h)
        local bgOption = showLobbyBG:GetInt()
        local lobbyBG_name = nzSettings:GetSimpleSetting("Lobby_Background", "bo6/other/lobby_bg.png")
        local lobbyBG = Material(lobbyBG_name)

        if bgOption == 1 then
            surface.SetDrawColor(150, 150, 150, 255)
            surface.SetMaterial(lobbyBG)
            surface.DrawTexturedRect(0, 0, w, h)
        elseif bgOption == 2 then
            surface.SetDrawColor(0, 0, 0, 255)
            surface.SetMaterial(gradientBG)
            surface.DrawTexturedRect(0, 0, w, h)
        end

        --logo
        if showLobbyLogo:GetBool() then
        local logoWidth, logoHeight = ScaleToAspect(logoMat:Width(), logoMat:Height(), We(1000), He(240))
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(logoMat)
        surface.DrawTexturedRect(We(600), 0, logoWidth, logoHeight)
        end

        --left
        draw.SimpleText("CONFIG: ", "BO6_Lobby48", We(70), He(90), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawRect(We(70), He(88), We(200), He(2))

        --players
        local height = 20
        local tab = player.GetAll()
        surface.SetDrawColor(10, 10, 10, 230)
        surface.DrawRect(We(1700), He(100), We(200), He(height+(40*#tab)))
        draw.SimpleText("PLAYERS: ", "BO6_Lobby48", We(1700), He(90), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawRect(We(1700), He(88), We(200), He(2))
        for k, v in pairs(tab) do
            local nick = v:Nick()
            surface.SetFont("BO6_Lobby14")
            local nick_w = surface.GetTextSize(nick)
            if nick_w > 120 then
                nick = string.Left(nick, 20).."..."
            end
            surface.SetDrawColor(40, 40, 40, 230)
            surface.DrawRect(We(1710), He(70+(k*40)), We(180), He(30))
            draw.SimpleText(k..".  "..nick, "BO6_Lobby14", We(1750), He(85+(k*40)), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            if v:IsReady() then
                local markWidth, markHeight = ScaleToAspect(markMat:Width(), markMat:Height(), We(24), He(24))
                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(markMat)
                surface.DrawTexturedRect(We(1715), He(72 + (k * 40)), markWidth, markHeight)
            else
                local crossWidth, crossHeight = ScaleToAspect(crossMat:Width(), crossMat:Height(), We(24), He(24))
                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(crossMat)
                surface.DrawTexturedRect(We(1715), He(72 + (k * 40)), crossWidth, crossHeight)
            end
        end

        --map
        local can = !nzLobby:CanStart()
        if can then
            time_before_start_delta = CurTime()+nzSettings:GetSimpleSetting("Lobby_TimeBeforeStart", 10)
            draw.SimpleText("Requires "..nzLobby:CountReadyPlayers(true).." ready players to start the game...", "BO6_Lobby18", We(75), He(640), Color(200,200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        else
            draw.SimpleText("Get ready to start...", "BO6_Lobby18", We(75), He(640), Color(150,250,150,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            if time_before_start_last != time_before_start then
                time_before_start_last = time_before_start
                time_num_alpha = 0
                time_num_height = 16
                surface.PlaySound("nz_moo/effects/ui/main_click_rear.mp3")
            end
            time_num_height = math.max(time_num_height-FrameTime()/0.05, 0)
            time_num_alpha = math.min(time_num_alpha+FrameTime()/0.005, 255)
        end
        time_before_start = math.ceil(math.max(time_before_start_delta-CurTime(), 0))
        draw.RoundedBox(8, We(60), He(650), We(500), He(370), Color(0,0,0,200))
        if nzLobby:CanStart() then
            surface.SetDrawColor(75,75,75)
            surface.SetMaterial(map_image)
            surface.DrawTexturedRect(We(70), He(740), mapWidth, mapHeight)
            draw.SimpleText(time_before_start, "BO6_Lobby96", We(310), He(875-time_num_height), Color(255,255,255,time_num_alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            if time_before_start <= 5 then
                for i, m in pairs(pmmodels) do
                    m = m:GetEntity()
                    local name = m:GetSequenceName(m:GetSequence())
                    if string.match(name, "_loop") then
                        m:SetCycle(0)
                        m:SetPlaybackRate(0.4)
                        m:SetSequence(string.Left(name, #name-5).."_toready")
                    end
                end
            end
        else
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(map_image)
    surface.DrawTexturedRect(We(70), He(740), mapWidth, mapHeight)
            for i, m in pairs(pmmodels) do
                if !IsValid(m) then continue end
                m = m:GetEntity()
                local name = m:GetSequenceName(m:GetSequence())
                if string.match(name, "_toready") then
                    m:SetCycle(math.Rand(0,1))
                    m:SetPlaybackRate(1)
                    m:SetSequence(string.Left(name, #name-8).."_loop")
                end
            end
        end
    surface.SetDrawColor(35, 35, 35)
    surface.DrawOutlinedRect(We(70), He(740), mapWidth, mapHeight, 3)
        draw.SimpleText(nzSettings:GetSimpleSetting("Lobby_MapLocation", "Setup Config"), "BO6_Lobby32", We(75), He(690), Color(175,175,175), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText(nzSettings:GetSimpleSetting("Lobby_MapName", "Zombie Invasion"), "BO6_Lobby48", We(75), He(730), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        draw.SimpleText("Lobby module made by Hari. Scaling fix & customizability by Latte.", "BO6_Lobby14", We(75), He(1060), Color(200,200,200,200), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    end
    
    nzLobby:CreatePlayerModels(frame)

    local but = vgui.Create("DButton", frame)
    but:SetText("")
    but:SetSize(We(300), He(50))
    but:SetPos(We(70), He(210))
    but.Paint = function(self, w, h)
        local alignment = textAlignmentConVar:GetInt() == 0 and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER
        local xOffset = alignment == TEXT_ALIGN_LEFT and We(10) or w / 2
        local text = LocalPlayer():IsReady() and "UNREADY" or "READY"
        
        if self:IsHovered() then
            draw.RoundedBox(8, 0, 0, w, h, Color(235, 235, 235, 200))
            draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, Color(0, 0, 0), alignment, TEXT_ALIGN_CENTER)
        else
            draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))
            draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, color_white, alignment, TEXT_ALIGN_CENTER)
        end
    end
    but.DoClick = function()
        if LocalPlayer():IsReady() then
            RunConsoleCommand( "nz_chatcommand", "/unready" )
        else
            RunConsoleCommand( "nz_chatcommand", "/ready" )
        end
        surface.PlaySound("nz_moo/effects/ui/2nd_click_rear.mp3")
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/slider_rear.mp3")
    end

    local but = vgui.Create("DButton", frame)
    but:SetText("")
    but:SetSize(We(300), He(50))
    but:SetPos(We(70), He(265))
    but.Paint = function(self, w, h)
        local alignment = textAlignmentConVar:GetInt() == 0 and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER
        local xOffset = alignment == TEXT_ALIGN_LEFT and We(10) or w / 2
        local text = "SELECT CHARACTER" -- Modify this text for each button

        if self:IsHovered() then
            draw.RoundedBox(8, 0, 0, w, h, Color(235, 235, 235, 200))
            draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, Color(0, 0, 0), alignment, TEXT_ALIGN_CENTER)
        else
            draw.RoundedBox(8, 0, 0, w, h, Color(5, 5, 5, 200))
            draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, color_white, alignment, TEXT_ALIGN_CENTER)
        end
    end

    but.DoClick = function()
        surface.PlaySound("nz_moo/effects/ui/2nd_click_rear.mp3")
        nzLobby:PlayerModelEditor(frame)
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/slider_rear.mp3")
    end

    local but = vgui.Create("DButton", frame)
    but:SetText("")
    but:SetSize(We(300), He(50))
    but:SetPos(We(70), He(320))
    but.Paint = function(self, w, h)
        local alignment = textAlignmentConVar:GetInt() == 0 and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER
        local xOffset = alignment == TEXT_ALIGN_LEFT and We(10) or w / 2
        local text = "LEGACY SETTINGS" -- Modify this text for each button

        if self:IsHovered() then
            draw.RoundedBox(8, 0, 0, w, h, Color(235, 235, 235, 200))
            draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, Color(0, 0, 0), alignment, TEXT_ALIGN_CENTER)
        else
            draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))
            draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, color_white, alignment, TEXT_ALIGN_CENTER)
        end
    end

    but.DoClick = function()
        if nzLobby:CanStart() then return end
        surface.PlaySound("nz_moo/effects/ui/2nd_click_rear.mp3")
        frame:Remove()
        LocalPlayer():ConCommand("nz_settings")
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/slider_rear.mp3")
    end

    local but = vgui.Create("DButton", frame)
    but:SetText("")
    but:SetSize(We(300), He(50))
    but:SetPos(We(70), He(375))
    but.Paint = function(self, w, h)
        local alignment = textAlignmentConVar:GetInt() == 0 and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER
        local xOffset = alignment == TEXT_ALIGN_LEFT and We(10) or w / 2
        local text = "MAIN MENU" -- Modify this text for each button

        if self:IsHovered() then
            draw.RoundedBox(8, 0, 0, w, h, Color(235, 235, 235, 200))
            draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, Color(0, 0, 0), alignment, TEXT_ALIGN_CENTER)
        else
            draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))
            draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, color_white, alignment, TEXT_ALIGN_CENTER)
        end
    end

    but.DoClick = function()
        if nzLobby:CanStart() then return end
        surface.PlaySound("nz_moo/effects/ui/2nd_click_rear.mp3")
        frame:Close()
        gui.ActivateGameUI()
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/slider_rear.mp3")
    end

    if LocalPlayer():IsSuperAdmin() then
        local but = vgui.Create("DButton", frame)
        but:SetText("")
        but:SetSize(We(300), He(50))
        but:SetPos(We(70), He(470))
        but.Paint = function(self, w, h)
            local alignment = textAlignmentConVar:GetInt() == 0 and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER
            local xOffset = alignment == TEXT_ALIGN_LEFT and We(10) or w / 2
            local text = "LOAD CONFIG" -- Modify this text for each button

            if self:IsHovered() then
                draw.RoundedBox(8, 0, 0, w, h, Color(235, 235, 235, 200))
                draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, Color(0, 0, 0), alignment, TEXT_ALIGN_CENTER)
            else
                draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))
                draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, color_white, alignment, TEXT_ALIGN_CENTER)
            end
        end

        but.DoClick = function()
            if nzLobby:CanStart() then return end
            surface.PlaySound("nz_moo/effects/ui/2nd_click_rear.mp3")
            RunConsoleCommand("nz_chatcommand", "/load")
        end
        but.OnCursorEntered = function()
            surface.PlaySound("nz_moo/effects/ui/slider_rear.mp3")
        end

        local but = vgui.Create("DButton", frame)
        but:SetText("")
        but:SetSize(We(300), He(50))
        but:SetPos(We(70), He(525))
        but.Paint = function(self, w, h)
            local alignment = textAlignmentConVar:GetInt() == 0 and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER
            local xOffset = alignment == TEXT_ALIGN_LEFT and We(10) or w / 2
            local text = "CREATIVE MODE" -- Modify this text for each button

            if self:IsHovered() then
                draw.RoundedBox(8, 0, 0, w, h, Color(235, 235, 235, 200))
                draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, Color(0, 0, 0), alignment, TEXT_ALIGN_CENTER)
            else
                draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))
                draw.SimpleText(text, "BO6_Lobby48", xOffset, h / 2, color_white, alignment, TEXT_ALIGN_CENTER)
            end
        end

        but.DoClick = function()
            if nzLobby:CanStart() then return end
            surface.PlaySound("nz_moo/effects/ui/2nd_click_rear.mp3")
            RunConsoleCommand("nz_chatcommand", "/create")
            frame:Close()
            timer.Simple(0.01, function()
            RunConsoleCommand("stopsound")
                if IsValid(musicchannel) then 
                    musicchannel:Stop() 
                    musicchannel = nil
                end
            end)
        end
        but.OnCursorEntered = function()
            surface.PlaySound("nz_moo/effects/ui/slider_rear.mp3")
        end
    end

    local blk = vgui.Create("DPanel", frame)
    blk:SetSize(ScrW(), ScrH())
    blk.Paint = function(self, w, h)
        surface.SetDrawColor(0,0,0)
        surface.DrawRect(0, 0, w, h)
    end
    blk:AlphaTo(0, 1, 0.2, function()
        blk:Remove()
    end)
end

local function close_lobby_menu()
    if IsValid(lobbypanel) then
        lobbypanel:Remove()
    end
end

hook.Add("InitPostEntity", "nZ_LobbyInit", function()
    timer.Simple(1, function()
        nzLobby:ClosePanels()
        if GetConVar("cl_playermodel_selector_force") then
            RunConsoleCommand("cl_playermodel_selector_force", "0")
        end
    end)
end)

hook.Add("Think", "nZ_Lobby_Think", function()
    if nzLobby:CanOpenLobby() then
        open_lobby_menu()
    else
        close_lobby_menu()
    end
end)


--PLAYERMODEL SELECTOR--

function nzLobby:PlayerModelEditor(parent)
    local window = vgui.Create("DFrame", parent)
    window:SetWidth(960)
    window:SetHeight(700)
    window:SetTitle("Player Model")
    window.Paint = function(self,w,h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0,0,100,200))
    end
    window.OnRemove = function()
        net.Start("nZR.LobbySkin")
        net.SendToServer()
    end

    local mdl = window:Add( "DModelPanel" )
    mdl:Dock( FILL )
    mdl:SetFOV( 36 )
    mdl:SetCamPos( Vector( 0, 0, 0 ) )
    mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 160, 80, 255 ) )
    mdl:SetDirectionalLight( BOX_LEFT, Color( 80, 160, 255, 255 ) )
    mdl:SetAmbientLight( Vector( -64, -64, -64 ) )
    mdl:SetAnimated( true )
    mdl.Angles = Angle( 0, 0, 0 )
    mdl:SetLookAt( Vector( -100, 0, -22 ) )

    local sheet = window:Add( "DPropertySheet" )
    sheet:Dock( RIGHT )
    sheet:SetSize( 430, 0 )

    local PanelSelect = sheet:Add( "DPanelSelect" )
    PanelSelect.Paint = function(self,w,h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0,0,0,200))
    end

    for name, model in SortedPairs( player_manager.AllValidModels() ) do

        local icon = vgui.Create( "SpawnIcon" )
        icon:SetModel( model )
        icon:SetSize( 64, 64 )
        icon:SetTooltip( name )
        icon.playermodel = name

        PanelSelect:AddPanel( icon, { cl_playermodel = name } )

    end

    sheet:AddSheet( "Model", PanelSelect, "icon16/user.png" )

    local controls = window:Add( "DPanel" )
    controls:DockPadding( 8, 8, 8, 8 )

    local lbl = controls:Add( "DLabel" )
    lbl:SetText( "Player color" )
    lbl:SetTextColor( Color( 0, 0, 0, 255 ) )
    lbl:Dock( TOP )

    local plycol = controls:Add( "DColorMixer" )
    plycol:SetAlphaBar( false )
    plycol:SetPalette( false )
    plycol:Dock( TOP )
    plycol:SetSize( 200, 260 )

    local lbl = controls:Add( "DLabel" )
    lbl:SetText( "Physgun color" )
    lbl:SetTextColor( Color( 0, 0, 0, 255 ) )
    lbl:DockMargin( 0, 32, 0, 0 )
    lbl:Dock( TOP )

    local wepcol = controls:Add( "DColorMixer" )
    wepcol:SetAlphaBar( false )
    wepcol:SetPalette( false )
    wepcol:Dock( TOP )
    wepcol:SetSize( 200, 260 )
    wepcol:SetVector( Vector( GetConVarString( "cl_weaponcolor" ) ) );

    sheet:AddSheet( "Colors", controls, "icon16/color_wheel.png" )

    local bdcontrols = window:Add( "DPanel" )
    bdcontrols:DockPadding( 8, 8, 8, 8 )

    local bdcontrolspanel = bdcontrols:Add( "DPanelList" )
    bdcontrolspanel:EnableVerticalScrollbar( true )
    bdcontrolspanel:Dock( FILL )

    local bgtab = sheet:AddSheet( "Bodygroups", bdcontrols, "icon16/cog.png" )

    -- Helper functions

    local function MakeNiceName( str )
        local newname = {}

        for _, s in pairs( string.Explode( "_", str ) ) do
            if ( string.len( s ) == 1 ) then table.insert( newname, string.upper( s ) ) continue end
            table.insert( newname, string.upper( string.Left( s, 1 ) ) .. string.Right( s, string.len( s ) - 1 ) ) -- Ugly way to capitalize first letters.
        end

        return string.Implode( " ", newname )
    end

    local function PlayPreviewAnimation( panel, playermodel )

        if ( !panel or !IsValid( panel.Entity ) ) then return end

        local anims = list.Get( "PlayerOptionsAnimations" )

        local anim = "idle_all_01"
        if ( anims[ playermodel ] ) then
            anims = anims[ playermodel ]
            anim = anims[ math.random( 1, #anims ) ]
        end

        local iSeq = panel.Entity:LookupSequence( anim )
        if ( iSeq > 0 ) then panel.Entity:ResetSequence( iSeq ) end

    end

    -- Updating

    local function UpdateBodyGroups( pnl, val )
        if ( pnl.type == "bgroup" ) then

            mdl.Entity:SetBodygroup( pnl.typenum, math.Round( val ) )

            local str = string.Explode( " ", GetConVarString( "cl_playerbodygroups" ) )
            if ( #str < pnl.typenum + 1 ) then for i = 1, pnl.typenum + 1 do str[ i ] = str[ i ] or 0 end end
            str[ pnl.typenum + 1 ] = math.Round( val )
            RunConsoleCommand( "cl_playerbodygroups", table.concat( str, " " ) )

        elseif ( pnl.type == "skin" ) then

            mdl.Entity:SetSkin( math.Round( val ) )
            RunConsoleCommand( "cl_playerskin", math.Round( val ) )

        end
    end

    local function RebuildBodygroupTab()
        bdcontrolspanel:Clear()
        
        bgtab.Tab:SetVisible( false )

        local nskins = mdl.Entity:SkinCount() - 1
        if ( nskins > 0 ) then
            local skins = vgui.Create( "DNumSlider" )
            skins:Dock( TOP )
            skins:SetText( "Skin" )
            skins:SetDark( true )
            skins:SetTall( 50 )
            skins:SetDecimals( 0 )
            skins:SetMax( nskins )
            skins:SetValue( GetConVarNumber( "cl_playerskin" ) )
            skins.type = "skin"
            skins.OnValueChanged = UpdateBodyGroups
            
            bdcontrolspanel:AddItem( skins )

            mdl.Entity:SetSkin( GetConVarNumber( "cl_playerskin" ) )
            
            bgtab.Tab:SetVisible( true )
        end

        local groups = string.Explode( " ", GetConVarString( "cl_playerbodygroups" ) )
        for k = 0, mdl.Entity:GetNumBodyGroups() - 1 do
            if ( mdl.Entity:GetBodygroupCount( k ) <= 1 ) then continue end

            local bgroup = vgui.Create( "DNumSlider" )
            bgroup:Dock( TOP )
            bgroup:SetText( MakeNiceName( mdl.Entity:GetBodygroupName( k ) ) )
            bgroup:SetDark( true )
            bgroup:SetTall( 50 )
            bgroup:SetDecimals( 0 )
            bgroup.type = "bgroup"
            bgroup.typenum = k
            bgroup:SetMax( mdl.Entity:GetBodygroupCount( k ) - 1 )
            bgroup:SetValue( groups[ k + 1 ] or 0 )
            bgroup.OnValueChanged = UpdateBodyGroups
            
            bdcontrolspanel:AddItem( bgroup )

            mdl.Entity:SetBodygroup( k, groups[ k + 1 ] or 0 )
            
            bgtab.Tab:SetVisible( true )
        end
    end

    local function UpdateFromConvars()

        local model = LocalPlayer():GetInfo( "cl_playermodel" )
        local modelname = player_manager.TranslatePlayerModel( model )
        util.PrecacheModel( modelname )
        mdl:SetModel( modelname )
        mdl.Entity.GetPlayerColor = function() return Vector( GetConVarString( "cl_playercolor" ) ) end
        mdl.Entity:SetPos( Vector( -100, 0, -61 ) )

        plycol:SetVector( Vector( GetConVarString( "cl_playercolor" ) ) )
        wepcol:SetVector( Vector( GetConVarString( "cl_weaponcolor" ) ) )

        PlayPreviewAnimation( mdl, model )
        RebuildBodygroupTab()

    end

    local function UpdateFromControls()

        RunConsoleCommand( "cl_playercolor", tostring( plycol:GetVector() ) )
        RunConsoleCommand( "cl_weaponcolor", tostring( wepcol:GetVector() ) )

    end

    plycol.ValueChanged = UpdateFromControls
    wepcol.ValueChanged = UpdateFromControls

    UpdateFromConvars()

    function PanelSelect:OnActivePanelChanged( old, new )

        if ( old != new ) then -- Only reset if we changed the model
            RunConsoleCommand( "cl_playerbodygroups", "0" )
            RunConsoleCommand( "cl_playerskin", "0" )
        end

        timer.Simple( 0.1, function() UpdateFromConvars() end )

    end

    -- Hold to rotate

    function mdl:DragMousePress()
        self.PressX, self.PressY = gui.MousePos()
        self.Pressed = true
    end

    function mdl:DragMouseRelease() self.Pressed = false end

    function mdl:LayoutEntity( Entity )
        if ( self.bAnimated ) then self:RunAnimation() end

        if ( self.Pressed ) then
            local mx, my = gui.MousePos()
            self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )
            
            self.PressX, self.PressY = gui.MousePos()
        end

        Entity:SetAngles( self.Angles )
    end
    
    gui.EnableScreenClicker(true)
    
    window:MakePopup()
    window:Center()  
end

concommand.Add("hari_lobby_close", function()
    if IsValid(lobbypanel) then
        lobbypanel:Remove()
    end
end)

concommand.Add("nz_beatmygrandma3000", function()
    if IsValid(lobbypanel) then
        lobbypanel:Remove() -- Close the lobby
    end

    timer.Simple(0.5, function()
        if IsValid(musicchannel) then 
            musicchannel:Stop() 
            musicchannel = nil
        end
        if nzSettings:GetSimpleSetting("Lobby_Music", "nz_moo/menuthemes/damned_1.ogg") != "" then
            sound.PlayFile("sound/"..nzSettings:GetSimpleSetting("Lobby_Music", "nz_moo/menuthemes/damned_1.ogg"), "", function(ch)
                if !IsValid(ch) then return end
                musicchannel = ch
            end)
        end
        if not IsValid(lobbypanel) then
            open_lobby_menu() -- Reopen the lobby
        end
    end)
end)