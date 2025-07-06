-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local gameoverBg = Material("bo6/other/game_over.png")
local exfilBg = Material("bo6/other/exfil.png")
local roundBasedIcon = Material("bo6/other/round_based.png")
local salvageIcon = Material("bo6/other/salvage.png", "mips")
local essenceIcon = Material("bo6/other/essence.png", "mips")

local w, h = ScrW(), ScrH()
local scale = ((w / 1920) + 1) / 2

surface.CreateFont("BO6_Exfil48", {
    font = "KairosSansW06-CondMedium",
    extended = true,
    size = 48 * scale,
})

surface.CreateFont("BO6_Exfil72", {
    font = "KairosSansW06-CondMedium",
    extended = true,
    size = 72 * scale,
})

surface.CreateFont("BO6_Exfil20", {
    font = "KairosSansW06-CondMedium",
    extended = true,
    size = 20 * scale,
})


local function FindAndHidePanelWithFont()
    local fontName = "nz.small.classic"
    local panels = vgui.GetWorldPanel():GetChildren()

    local function SearchPanels(panelList)
        for _, panel in pairs(panelList) do
            local xx, yy = panel:GetSize()
            if panel.GetSize and xx == ScrW()/2 and yy == ScrH() - 200 then
                panel:Remove()
                return true
            end

            local children = panel:GetChildren()
            if children and SearchPanels(children) then
                return true
            end
        end
        return false
    end

    SearchPanels(panels)
end
timer.Simple(2, function()
    FindAndHidePanelWithFont()
end)

local function open_game_over(endtype)
    local round = nzRound:GetNumber()
    local gametype = "STANDARD"
    if nzMapping.Settings.timedgame == 1 then
        gametype = "TIMED"
    elseif nzSettings:GetSimpleSetting("nzee_mode", 0) == 1 then
        gametype = "DIRECTED"
    elseif nzSettings:GetSimpleSetting("nzee_mode", 0) == 2 then
        gametype = "SURVIVAL"
    elseif nzSettings:GetSimpleSetting("nzee_mode", 0) == 3 then
        gametype = "HARDCORE"
    end
    local text = nzSettings:GetSimpleSetting("BO6_GO_LoseTitle", "ELIMINATED")
    local bg = gameoverBg
    if endtype == "win" then
        text = nzSettings:GetSimpleSetting("BO6_GO_WinTitle", "SUCCESSFUL EXFIL")
        bg = exfilBg
    elseif endtype == "quest" then
        text = "MAIN QUEST COMPLETED"
        bg = exfilBg
    end

    local frame = vgui.Create("DFrame")
    frame:SetSize(ScrW(), ScrH())
    frame:SetPos(0, 0)
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame.Paint = function(self, w, h)
        if nzSettings:GetSimpleSetting("BO6_GO_Alpha", false) then
            surface.SetDrawColor(0, 0, 0, 175)
            surface.DrawRect(0, 0, w, h)
        else
            surface.SetDrawColor(150, 150, 150, 255)
            surface.SetMaterial(bg)
            surface.DrawTexturedRect(0, 0, w, h)
        end
        FindAndHidePanelWithFont()
    end

    local title = vgui.Create("DLabel", frame)
    title:SetPos(150 * scale, 50 * scale)
    title:SetText(string.upper(game.GetMap()).." | "..gametype.." | ROUND "..round)
    title:SetFont("BO6_Exfil24")
    title:SetContentAlignment(7)
    title:SetTextColor(Color(255, 165, 0))
    title:SizeToContents()

    title = vgui.Create("DLabel", frame)
    title:SetPos(150 * scale, 70 * scale)
    title:SetText("ROUND-BASED ZOMBIES")
    title:SetFont("BO6_Exfil48")
    title:SetContentAlignment(7)
    title:SetTextColor(Color(255, 255, 255))
    title:SizeToContents()

    local icon = vgui.Create("DImage", frame)
    icon:SetPos(10 * scale, 25 * scale)
    icon:SetSize((564/4) * scale, (468/4) * scale)
    icon:SetMaterial(roundBasedIcon)

    local eliminated = vgui.Create("DLabel", frame)
    eliminated:SetSize(w, 100 * scale)
    eliminated:SetPos(0, 150 * scale)
    eliminated:SetText(text)
    eliminated:SetFont("BO6_Exfil96")
    eliminated:SetContentAlignment(5)
    eliminated:SetTextColor(Color(200, 200, 200))

    local roundsSurvived = vgui.Create("DLabel", frame)
    roundsSurvived:SetSize(w, 30 * scale)
    roundsSurvived:SetPos(0, 230 * scale)
    roundsSurvived:SetText(string.format(nzSettings:GetSimpleSetting("BO6_GO_RoundText", "You Survived %s Rounds"), tostring(round)))
    roundsSurvived:SetFont("BO6_Exfil26")
    roundsSurvived:SetContentAlignment(5)
    roundsSurvived:SetTextColor(Color(255, 255, 255))

    local columns = { "№", "NAME", "ESSENCE", "ELIMINATIONS", "DOWNS", "REVIVES", "PING" }
    local headerPanel = vgui.Create("DPanel", frame)
    headerPanel:SetSize(w * (#columns / 10), 40 * scale)
    headerPanel:SetPos(w / 2 - headerPanel:GetWide() / 2, h * 0.4)
    headerPanel.Paint = function(self, w, h)
        surface.SetDrawColor(55, 55, 55, 200)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255, 10)
        surface.DrawRect(190 * scale, 0, 2 * scale, h)
    end

    for i, col in ipairs(columns) do
        local label = vgui.Create("DLabel", headerPanel)
        label:SetPos((i - 1) * (w * 0.1), 10 * scale)
        label:SetSize(w * 0.1, 20 * scale)
        label:SetText(col)
        label:SetContentAlignment(5)
        label:SetFont("BO6_Exfil24")
        label:SetTextColor(Color(255, 255, 255))
    end

    local playersTab = player.GetAll()
    for k, v in pairs(playersTab) do
        local rowPanel = vgui.Create("DPanel", frame)
        rowPanel:SetPos(w / 2 - headerPanel:GetWide() / 2, h * 0.4 + (k * 40 * scale))
        rowPanel:SetSize(w * (#columns / 10), 40 * scale)
        rowPanel.Paint = function(self, w, h)
            surface.SetDrawColor(125, 125, 125, 50)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(255, 255, 255, 10)
            surface.DrawRect(190 * scale, 0, 2 * scale, h)
        end

        local rowValues = { k, v:Nick(), v:GetPoints(), v:GetTotalKills(), v:GetTotalDowns(), v:GetTotalRevives(), v:Ping() }
        for i, value in ipairs(rowValues) do
            local label = vgui.Create("DLabel", rowPanel)
            label:SetPos((i - 1) * (w * 0.1), 10 * scale)
            label:SetSize(w * 0.1, 20 * scale)
            label:SetText(value)
            label:SetContentAlignment(5)
            label:SetTextColor(i == 2 and Color(255, 220, 0) or Color(255, 255, 255))
            label:SetFont("BO6_Exfil20")
        end
    end

    local downPanel = vgui.Create("DPanel", frame)
    downPanel:SetSize(w * (#columns / 10) + 50 * scale, 90 * scale)
    downPanel:SetPos(w / 2 - downPanel:GetWide() / 2, h * 0.4 + ((1 + #playersTab) * 40 * scale) + 10 * scale)
    downPanel.Paint = function(self, w, h)
        surface.SetDrawColor(150, 150, 150, 50)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(50, 50, 50, 180)
        surface.DrawRect(75 * scale, 0, 250 * scale, h)
        draw.SimpleText(LocalPlayer():Nick(), "BO6_Exfil24", 200 * scale, 2 * scale, color_white, TEXT_ALIGN_CENTER)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(essenceIcon)
        surface.DrawTexturedRect(445 * scale, 4 * scale, 28 * scale, 28 * scale)
        draw.SimpleText("ESSENCE", "BO6_Exfil24", 500 * scale, 5 * scale, color_white, TEXT_ALIGN_CENTER)
        draw.SimpleText(LocalPlayer():GetPoints(), "BO6_Exfil72", 500 * scale, 55 * scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(salvageIcon)
        surface.DrawTexturedRect(625 * scale, 4 * scale, 28 * scale, 28 * scale)
        draw.SimpleText("SALVAGE", "BO6_Exfil24", 680 * scale, 5 * scale, color_white, TEXT_ALIGN_CENTER)
        draw.SimpleText(LocalPlayer():GetNWInt('Salvage', 0), "BO6_Exfil72", 680 * scale, 55 * scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local Avatar = vgui.Create("AvatarImage", downPanel)
    Avatar:SetSize(56 * scale, 56 * scale)
    Avatar:SetPos(172.5 * scale, 30 * scale)
    Avatar:SetPlayer(LocalPlayer(), 56)

    local time = nzMapping["Settings"]["gameovertime"]+2
    local black = vgui.Create("DPanel", frame)
    black:SetSize(ScrW(), ScrH())
    black:SetPos(0, 0)
    black.Paint = function(self, w, h)
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, w, h)
    end
    black:AlphaTo(0, 2, 1)

    timer.Simple(time-3, function()
        if IsValid(black) then black:AlphaTo(255, 2) end
    end)
    timer.Simple(time, function()
        if IsValid(frame) then frame:Remove() end
        LocalPlayer():ScreenFade(SCREENFADE.IN, color_black, 2, 0)
    end)
end

net.Receive("nZr.ShowBO6GameOver", function()
    local str = net.ReadString()

    local storedFunction = hook.GetTable()["OnRoundEnd"]["nzu_Scoreboard_ShowOnGameOver"]
    hook.Remove("OnRoundEnd", "nzu_Scoreboard_ShowOnGameOver")
    hook.Remove("HUDPaint", "game_over_notif")

    timer.Simple(nzMapping.Settings.gocamerawait-2, function()
        LocalPlayer():ScreenFade(SCREENFADE.OUT, color_black, 1, 1)
    end)
    timer.Simple(nzMapping.Settings.gocamerawait-1, function()
        open_game_over(str)
    end)
    timer.Simple(nzMapping.Settings.gocamerawait+0.01, function()
        FindAndHidePanelWithFont()
    end)
end)