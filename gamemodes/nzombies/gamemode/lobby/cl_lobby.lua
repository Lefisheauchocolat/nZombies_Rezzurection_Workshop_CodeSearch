-- Made by Hari exclusive for nZombies Rezzurrection. Copying this code is prohibited!

nzLobby = nzLobby or {}

local showLobbyBG = CreateConVar("nz_lobby_show_bg", "1", FCVAR_ARCHIVE, "Change how the background is displayed in the pregame lobby. (0: No Background, 1: Default Background, 2: Simple Background)")
local showLobbyCharacters = CreateConVar("nz_lobby_show_characters", "1", FCVAR_ARCHIVE, "Hide or show playermodels in the pregame lobby. (0: Hide Playermodels 1: Show Playermodels)")
local showLobbyLogo = CreateConVar("nz_lobby_show_logo", "1", FCVAR_ARCHIVE, "Hide or show the logo in the pregame lobby. (0: Hide Logo 1: Show Logo)")
local textAlignmentConVar = CreateConVar("nz_lobby_text_alignment", "0", FCVAR_ARCHIVE, "Change text alignment for lobby buttons. (0: Left 1: Center)")
local nzLobbySfxConVar = CreateClientConVar("nz_lobby_ui_sfx", "bo1", true, false, "Select UI sound set. (Ex. waw, bo1, bo2, bo3, mw1, mw2, ghosts)")

local gradientBG = Material("bo6/other/lobby_bg_simple.png")
local logoMat = Material("bo6/other/logo.png")
local markMat = Material("vgui/menu_lobby_ready.png", "mips")
local crossMat = Material("vgui/menu_lobby_not_ready.png", "mips")
local lightMat = Material("bo6/other/light.png", "mips")
local addBotMat = Material("bo6/other/bot_add.png", "")
local removeBotMat = Material("bo6/other/bot_remove.png", "")
local musicchannel = nil
local lobbypanel = nil
local animtab = {"nz_idles_f_crossedfront", "nz_idles_m_armsback", "nz_idles_m_armsfront", "nz_idles_m_hipleft", "nz_idles_m_hipright", "nz_idles_m_hips"}
local campostab1 = {Vector(100,0,60), Vector(120,-16,60), Vector(120,16,60), Vector(140,-32,60), Vector(140,32,60)}
local campostab2 = {Vector(0,0,60), Vector(0,-20,60), Vector(0,20,60), Vector(0,-40,60), Vector(0,40,60)}
local soundPack = GetConVar("nz_lobby_ui_sfx"):GetString()


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

----------------------------------------

local chatPanel = nil
local richPanel = nil
local messageSound = "buttons/lightswitch2.wav"

local function CreateChatPanel(link)
    if IsValid(chatPanel) then return end
    chatPanel = vgui.Create("DFrame", link)
    chatPanel:SetSize(We(480), He(240))
    chatPanel:SetTitle("")
    chatPanel:ShowCloseButton(false)
    chatPanel:SetDraggable(true)
    chatPanel:SetPos(ScrW() - chatPanel:GetWide() - We(10), ScrH() - chatPanel:GetTall() - He(10))
    chatPanel:MakePopup()
    chatPanel.Paint = function(self,w,h)
        surface.SetDrawColor(0,0,0,150)
        surface.DrawRect(0,0,w,h)
        surface.SetDrawColor(125,125,125)
        surface.DrawOutlinedRect(0,0,w,h,2)
        draw.SimpleText("LOBBY CHAT", "BO6_Exfil24", We(5), He(15), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText("[Press TAB to hide chat]", "BO6_Exfil18", w-We(5), He(15), Color(200,200,200,200), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end

    local richtext = vgui.Create("RichText", chatPanel)
    richtext:Dock(FILL)
    richPanel = richtext
    function richtext:PerformLayout()
        self:SetFontInternal("BO6_Lobby18")
        self:SetBGColor(Color(25, 25, 25, 150))
    end

    local TextEntry = vgui.Create("DTextEntry", chatPanel)
	TextEntry:Dock(BOTTOM)
    TextEntry:SetPaintBackground(false)
    TextEntry:SetTextColor(Color(255,255,255))
    TextEntry:SetCursorColor(Color(200,200,200))
	TextEntry.OnEnter = function(self)
		RunConsoleCommand("say", self:GetValue())
        self:SetText("")
	end
    TextEntry.PaintOver = function(self,w,h)
        surface.SetDrawColor(200,200,200)
        surface.DrawOutlinedRect(0,0,w,h,1)
	end
end

hook.Add("ChatText", "nzrLobbyChat", function(index, name, text, type)
	if type == "joinleave" and IsValid(richPanel) then
        richPanel:InsertColorChange(200, 200, 200, 255)
        richPanel:AppendText(text .. "\n")
        surface.PlaySound(messageSound)
	end
end)

hook.Add("OnPlayerChat", "nzrLobbyChat", function(player, strText, bTeamOnly, bPlayerIsDead)
    if IsValid(richPanel) then
        local col = player:GetPlayerColor():ToColor()
        richPanel:InsertColorChange(col.r, col.g, col.b, 255)
        richPanel:AppendText(player:Nick())
        richPanel:InsertColorChange(255, 255, 255, 255)
        richPanel:AppendText(": " .. strText .. "\n")
        surface.PlaySound(messageSound)
    end
end)

local buttondelay = 0
hook.Add("Think", "nzrLobbyChat", function()
    if !IsValid(chatPanel) or buttondelay > CurTime() then return end
    if input.IsKeyDown(KEY_TAB) then
        buttondelay = CurTime()+0.4
        chatPanel:ToggleVisible()
    end
end)

----------------------------------------

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

                    ent.GetPlayerColor = function() return IsValid(ply) and ply:GetPlayerColor() or Vector(1, 1, 1) end
                end

                self:RunAnimation()
                if ent:GetCycle() == 1 and string.match(ent:GetSequenceName(ent:GetSequence()), "_loop") then
                    ent:SetCycle(0)
                end
            end
        end

        frame.PaintOver = function(self)
            if #pmmodels ~= math.min(#player.GetAll(), 5) then
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

--CUSTOM KEYBINDS by reikoow    --

surface.CreateFont("NZ::ModernTitle", {
    font = "PierSans-Regular",
    size = 22,
    weight = 500,
    antialias = true,
})

surface.CreateFont("NZ::ModernSmallText", {
    font = "PierSans-Regular",
    size = 16,
    weight = 650,
    antialias = true,
})


local function DrawBlur(x, y, w, h, amount)
    local blur = Material("pp/blurscreen")
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 6 do
        blur:SetFloat("$blur", (i / 6) * amount)
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
    end
end

function nzLobby:CreateKeybindsMenu(parent)
    -- Mapping of input types to their display names


    local function GlobalKeyPressHandler(ply, key)
        if not IsValid(ply) or not ply:IsPlayer() then return end
        hook.Run("nZombiesKeyCapture", key)
    end
    hook.Add("PlayerButtonDown", "nZombiesGlobalKeyCapture", GlobalKeyPressHandler)

    local function GlobalMousePressHandler(mousecode)
        hook.Run("nZombiesKeyCapture", mousecode)
    end
    hook.Add("GUIMousePressed", "nZombiesGlobalMouseCapture", GlobalMousePressHandler)


    local frame = vgui.Create("DFrame", parent)
    frame:SetSize(400, 475)
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    frame:SetDraggable(true)
    frame.StartTime = SysTime()
    frame:MakePopup()

    -- Bouton de fermeture custom
    local closeButton = vgui.Create("DButton", frame)
    closeButton:SetSize(30, 30)
    closeButton:SetPos(frame:GetWide() - 40, 5)
    closeButton:SetText("X")
    closeButton:SetTextColor(Color(255, 255, 255))
    closeButton.Paint = function(self, w, h) end
    closeButton.DoClick = function()
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/main_click_fnt.mp3")
        frame:Close()
    end

    function frame:Paint(w, h)
        local x, y = self:LocalToScreen(0, 0)
        DrawBlur(x, y, w, h, 6)
        draw.RoundedBox(12, 0, 0, w, h, Color(20, 20, 20, 230))
        --draw.RoundedBoxEx(12, 0, 0, w, 40, Color(40, 40, 40, 210), true, true, false, false)
        draw.RoundedBox(0, 0, 40, w, 2, Color(130, 130, 130, 230))

        -- White Borders
        draw.RoundedBox(0, 0, 40, 2, h, Color(130, 130, 130, 230))
        draw.RoundedBox(0, w - 2, 40, 2, h, Color(130, 130, 130, 230))
        draw.RoundedBox(0, 0, h - 2, w, 2, Color(130, 130, 130, 230))
        draw.SimpleText("nZombies Keybinds", "NZ::ModernTitle", w / 2, 20, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)
    scroll:DockMargin(10, 30, 10, 10)

    local sbar = scroll:GetVBar()
    function sbar:Paint(w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 200))
    end
    function sbar.btnUp:Paint(w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(70, 70, 70, 220))
    end
    function sbar.btnDown:Paint(w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(70, 70, 70, 220))
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(90, 90, 90, 240))
    end

    local function PopulateKeybinds()
        scroll:Clear()
        
        -- Retrieve keybinds and sort them alphabetically
        local keybinds = {}
        for category, key in pairs(nzKeyConfig:getAllBinds()) do
            table.insert(keybinds, category)
        end
        table.sort(keybinds, function(a, b) return a:lower() < b:lower() end) -- Sort case-insensitively
        
        -- Create UI elements for each keybind
        for _, category in ipairs(keybinds) do
            local key = nzKeyConfig:getAllBinds()[category]

            local panel = scroll:Add("DPanel")
            panel:SetTall(40)
            panel:Dock(TOP)
            panel:DockMargin(0, 0, 0, 5)
            
            function panel:Paint(w, h)
                draw.RoundedBox(6, 0, 0, w, h, Color(40, 40, 40, 230))
                draw.RoundedBox(0, 0, h - 2, w, 2, Color(130, 130, 130, 230))
            end

            -- Category Label
            local categoryLabel = vgui.Create("DLabel", panel)
            if isstring(nzKeyConfig.customText[category]) then
                categoryLabel:SetText(string.upper(nzKeyConfig.customText[category]))
            else
                categoryLabel:SetText(string.upper(category))
            end
            categoryLabel:SetFont("NZ::ModernSmallText")
            categoryLabel:SetTextColor(Color(200, 200, 200))
            categoryLabel:Dock(LEFT)
            categoryLabel:DockMargin(10, 0, 0, 0)
            categoryLabel:SizeToContentsX()

            -- Key Button
            local keyButton = vgui.Create("DButton", panel)
            keyButton:Dock(RIGHT)
            keyButton:DockMargin(0, 5, 10, 5)
            keyButton:SetWide(80)

            local function GetKeyDisplayName(keyCode)
                return nzKeyConfig.keyDisplayNames[keyCode] or "NONE"
            end

            local currentKeyName = GetKeyDisplayName(GetConVar("nz_key_"..category):GetInt()) or "NULL"
            keyButton:SetText(string.upper(currentKeyName))
            keyButton:SetFont("NZ::ModernSmallText")
            keyButton:SetTextColor(Color(255, 255, 255))
            
            function keyButton:Paint(w, h)
                local col = self:IsHovered() and Color(70, 70, 70, 250) or Color(50, 50, 50, 230)
                draw.RoundedBox(4, 0, 0, w, h, col)
            end

            keyButton.OnCursorEntered = function()
                surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_fnt.mp3")
            end

            -- Key changing mechanism
            local isChangingKey = false
            keyButton.DoClick = function()
                surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/main_click_fnt.mp3")
                if isChangingKey then return end
                
                isChangingKey = true
                keyButton:SetText("PRESS KEY")
                
                -- Debug print
                print("[nZombies Keybinds] Waiting for key press for category: " .. category)
                
                -- Global key capture method
                local function CaptureKey(key)
                    if not isChangingKey then return end
                    
                    print("[nZombies Keybinds] Captured key: " .. tostring(key))
                    
                    -- Validate key
                    if nzKeyConfig.keyDisplayNames[key] then
                        -- play the funky menu sound
                        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")

                        -- Update key
                        local convarName = "nz_key_" .. string.lower(category)
                        RunConsoleCommand(convarName, key)
                        
                        -- Update visual representation
                        local newKeyName = GetKeyDisplayName(key)
                        keyButton:SetText(string.upper(newKeyName))
                        
                        -- Update local keys table
                        nzSpecialWeapons.Keys[category] = key
                        
                        -- Reset state
                        isChangingKey = false
                        
                        -- Remove hook
                        hook.Remove("nZombiesKeyCapture", "KeybindsCaptureHook")
                        
                        print("[nZombies Keybinds] Updated key for " .. category .. " to " .. newKeyName)
                        RunConsoleCommand("nz_save_key")
                    end
                end
                
                -- Alternative capture method using a global hook
                hook.Add("nZombiesKeyCapture", "KeybindsCaptureHook", CaptureKey)
                
                -- Add a custom key press listener
                frame.OnKeyCodePressed = function(_, key)
                    if isChangingKey then
                        hook.Run("nZombiesKeyCapture", key)
                        return true
                    end
                end
                
                -- Fallback mouse button listener
                frame.OnMousePressed = function(_, mousecode)
                    if isChangingKey then
                        hook.Run("nZombiesKeyCapture", mousecode)
                        return true
                    end
                end
            end
        end
    end

    -- but.OnCursorEntered = function()
    --     surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
    -- end

    PopulateKeybinds()
    frame:Center()
    return frame
end

concommand.Add("nz_open_keybinds", OpenKeybindsMenu)

-- Debug command to test key capture
concommand.Add("nz_debug_keys", function()
    PrintTable(nzSpecialWeapons.Keys)
end)


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

    local have_bots = GetConVar("nz_bot_max") and LocalPlayer():IsSuperAdmin()
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

        self:MoveToBack()
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
        local lobbyBG = Material(lobbyBG_name, "smooth noclamp")

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
        if have_bots then
            height = 50
        end
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
                surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/main_click_rear.mp3")
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
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
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
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
        nzLobby:PlayerModelEditor(frame)
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
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
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
        frame:Remove()
        LocalPlayer():ConCommand("nz_settings")
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
    end

    // New Keybinds button 

    local but = vgui.Create("DButton", frame)
    but:SetText("")
    but:SetSize(We(270), He(50))
    but:SetPos(We(570), He(965))
    but.Paint = function(self, w, h)
        local alignment = textAlignmentConVar:GetInt() == 0 and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER
        local xOffset = alignment == TEXT_ALIGN_LEFT and We(10) or w / 2
        local text = "CUSTOM KEYBINDS"

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
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
        nzLobby:CreateKeybindsMenu(frame)
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
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
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
        frame:Close()
        gui.ActivateGameUI()
    end
    but.OnCursorEntered = function()
        surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
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
            surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
            RunConsoleCommand("nz_chatcommand", "/load")
        end
        but.OnCursorEntered = function()
            surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
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
            surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
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
            surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
        end

        if have_bots then
            local but = vgui.Create("DButton", frame)
            but:SetText("")
            but:SetSize(We(180), He(30))
            but:SetPos(We(1710), He(110+(player.GetCount()*40)))
            but.Paint = function(self, w, h)
                but:SetPos(We(1710), He(110+(player.GetCount()*40)))
                local mat = addBotMat
                if player.GetCount() == game.MaxPlayers() or GetConVar("nz_bot_max") and nzGetBotCommand("nz_bot_max") == #player.GetBots() then
                    mat = removeBotMat
                end
                if self:IsHovered() then
                    surface.SetDrawColor(255,255,255)
                    surface.SetMaterial(mat)
                    surface.DrawTexturedRect(0,0,w,h)
                else
                    surface.SetDrawColor(200,200,200,200)
                    surface.SetMaterial(mat)
                    surface.DrawTexturedRect(0,0,w,h)
                end
            end

            but.DoClick = function()
                if nzLobby:CanStart() then return end
                surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/2nd_click_rear.mp3")
                nzLobby:BotEditor(frame)
            end
            but.OnCursorEntered = function()
                surface.PlaySound("nz_moo/effects/ui/" .. soundPack .. "/slider_rear.mp3")
            end
        end
    end

    CreateChatPanel(frame)

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
    local function PlayPreviewAnimation( panel )
        if ( !panel or !IsValid( panel.Entity ) ) then return end

        local anims = list.Get( "PlayerOptionsAnimations" )
        local anim = table.Random(animtab).."_loop"
        local iSeq = panel.Entity:LookupSequence( anim )
        if ( iSeq > 0 ) then panel.Entity:ResetSequence( iSeq ) end
    end

    local window = vgui.Create("DFrame", parent)
    window:SetWidth(960)
    window:SetHeight(700)
    window:SetTitle("")
    window.Paint = function(self,w,h)
        draw.RoundedBox(8, 0, 0, w, h, Color(25,25,25,240))
        draw.SimpleText("PLAYERMODEL SELECTOR", "BO6_Exfil26", 5, 2, color_white)
        
        surface.SetDrawColor(255,255,255)
        surface.DrawRect(0, 30, w, 2)
    end
    window.OnRemove = function()
        net.Start("nZR.LobbySkin")
        net.SendToServer()
    end

    local light = window:Add( "DPanel" )
    light:SetPos(0,0)
    light:SetSize(530,700)
    light.Paint = function(self,w,h)
        surface.SetDrawColor(255,255,255,100)
        surface.SetMaterial(lightMat)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    local mdl = window:Add( "DModelPanel" )
    mdl:Dock( LEFT )
    mdl:SetSize(530,0)
    mdl:SetFOV( 35 )
    mdl:SetCamPos( Vector( 0, 0, 0 ) )
    mdl:SetDirectionalLight( BOX_RIGHT, Color( 255, 160, 80, 255 ) )
    mdl:SetDirectionalLight( BOX_LEFT, Color( 80, 160, 255, 255 ) )
    mdl:SetAmbientLight( Vector( -64, -64, -64 ) )
    mdl:SetAnimated( true )
    mdl.Angles = Angle( 0, 0, 0 )
    mdl:SetLookAt( Vector( -100, 0, -22 ) )
    PlayPreviewAnimation( mdl )

    local sheet = window:Add( "DPropertySheet" )
    sheet:SetSize(430, 660)
    local ws, hs = sheet:GetSize()
    sheet:SetPos(960-ws, 700-hs)

    local PanelSelect = sheet:Add( "DPanelSelect" )
    PanelSelect.Paint = function(self,w,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(75,75,75))
    end

    for name, model in SortedPairs( player_manager.AllValidModels() ) do

        local icon = vgui.Create( "SpawnIcon" )
        icon:SetModel( model )
        icon:SetSize( 64, 64 )
        icon:SetTooltip( name )
        icon.playermodel = name
        icon.Paint = function(self,w,h)
            surface.SetDrawColor(255,255,255,240)
            surface.SetMaterial(lightMat)
            surface.DrawTexturedRect(0, 0, w, h)
        end
        icon.PaintOver = function(self,w,h)
            surface.SetDrawColor(255,255,255,50)
            surface.DrawOutlinedRect(0, 0, w, h, 1)
        end

        PanelSelect:AddPanel( icon, { cl_playermodel = name } )

    end

    sheet:AddSheet( "Model", PanelSelect, "icon16/user.png" )

    local controls = window:Add( "DPanel" )
    controls:DockPadding( 8, 8, 8, 8 )
    controls.Paint = function(self,w,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(75,75,75))
    end

    local lbl = controls:Add( "DLabel" )
    lbl:SetText( "PLAYER COLOR" )
    lbl:SetFont("BO6_Exfil18")
    lbl:SetTextColor( Color( 255, 255, 255) )
    lbl:Dock( TOP )

    local plycol = controls:Add( "DColorMixer" )
    plycol:SetAlphaBar( false )
    plycol:SetPalette( false )
    plycol:Dock( TOP )
    plycol:SetSize( 200, 260 )

    local lbl = controls:Add( "DLabel" )
    lbl:SetText( "PHYSGUN COLOR" )
    lbl:SetFont("BO6_Exfil18")
    lbl:SetTextColor( Color( 255, 255, 255) )
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
    bdcontrols.Paint = function(self,w,h)
        draw.RoundedBox(0, 0, 0, w, h, Color(75,75,75))
    end

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
            skins:SetText( "SKIN" )
            skins:SetDark(false)
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
            bgroup:SetText( string.upper(MakeNiceName( mdl.Entity:GetBodygroupName( k ) )) )
            bgroup:SetDark( false )
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

        PlayPreviewAnimation( mdl )
        RebuildBodygroupTab()

        if mdl.Created then
            window:Remove()
            nzLobby:PlayerModelEditor(parent)
        else
            mdl.Created = true
        end
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
        if Entity:GetCycle() == 1 then
            Entity:SetCycle(0)
        end
    end

    function sheet:Paint(w, h)
        -- Set a dark background for the entire sheet
        surface.SetDrawColor(50, 50, 50, 255) -- Dark gray
        surface.DrawRect(0, 0, w, h)
    end
    local items = sheet:GetItems()
    for k, tab in pairs(items) do
        local t = tab.Tab
        if IsValid(t) then
            t:SetTextColor(Color(0,0,0,0))
            function t:Paint(w, h)
                if self:IsActive() then
                    surface.SetDrawColor(75, 75, 75)
                else
                    surface.SetDrawColor(25, 25, 25)
                end
                surface.DrawRect(0, 0, w, 20)
                if k != #items then
                    surface.SetDrawColor(255, 255, 255)
                    surface.DrawRect(w-2, 0, 2, 20)
                end
                if k != 1 then
                    surface.SetDrawColor(255, 255, 255)
                    surface.DrawRect(0, 0, 2, 20)
                end
                
                draw.SimpleText(self:GetText(), "BO6_Exfil12", 28, 10, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end
    end
    
    window:MakePopup()
    window:Center()
    gui.EnableScreenClicker(true)  
end

local be_window = nil
function nzLobby:BotEditor(fr)
    if IsValid(be_window) then return end

    local selectedModel = ""

    local frame = vgui.Create("DFrame", fr)
    frame:SetTitle("Bot Editor")
    frame:SetSize(400, 650)
    frame:Center()
    frame:SetVisible(true)
    frame:SetDraggable(true)
    frame:ShowCloseButton(true)
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(20, 20, 20, 240))
        draw.RoundedBox(0, 0, 24, w, 2, Color(100, 100, 100, 255))
    end
    be_window = frame

    local nameEntry = vgui.Create("DTextEntry", frame)
    nameEntry:SetPos(20, 40)
    nameEntry:SetSize(360, 30)
    nameEntry:SetPlaceholderText("Leave it empty for random nick")
    nameEntry:SetText("")

    local label = vgui.Create("DLabel", frame)
    label:SetPos(20, 80)
    label:SetSize(360, 20)
    label:SetText("Selected Model: "..selectedModel)
    label.PaintOver = function(self,w,h)
        label:SetText("Selected Model: "..selectedModel)
    end

    local modelPanel = vgui.Create("DScrollPanel", frame)
    modelPanel:SetPos(20, 120)
    modelPanel:SetSize(360, 350)

    local iconLayout = vgui.Create("DIconLayout", modelPanel)
    iconLayout:SetSize(360, 350)
    iconLayout:SetSpaceY(5)
    iconLayout:SetSpaceX(5)

    local validModels = player_manager.AllValidModels()
    for name, modelPath in pairs(validModels) do
        local icon = iconLayout:Add("SpawnIcon")
        icon:SetModel(modelPath)
        icon:SetToolTip(name)
        icon.DoClick = function()
            selectedModel = modelPath
            chat.AddText(Color(0, 255, 0), "Selected Model: ", modelPath)
        end
    end

    local addBotButton = vgui.Create("DButton", frame)
    addBotButton:SetPos(20, 490)
    addBotButton:SetSize(360, 40)
    addBotButton:SetText("Add Bot with Settings")
    addBotButton.DoClick = function()
        local botName = nameEntry:GetValue()
        if selectedModel then
            RunConsoleCommand("nz_add_bot", botName, selectedModel, "true")
        end
    end

    local randomBotButton = vgui.Create("DButton", frame)
    randomBotButton:SetPos(20, 540)
    randomBotButton:SetSize(360, 40)
    randomBotButton:SetText("Add Random Bot")
    randomBotButton.DoClick = function()
        RunConsoleCommand("nz_add_bot")
    end

    local randomBotButton = vgui.Create("DButton", frame)
    randomBotButton:SetPos(20, 590)
    randomBotButton:SetSize(360, 40)
    randomBotButton:SetText("Kick Bots")
    randomBotButton.DoClick = function()
        RunConsoleCommand("leadbot_kick", "all")
    end
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