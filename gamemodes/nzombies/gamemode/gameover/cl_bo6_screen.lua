-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local gameoverBg = Material("bo6/other/game_over.png")
local exfilBg = Material("bo6/other/exfil.png")
local roundBasedIcon = Material("bo6/other/round_based.png")
local salvageIcon = Material("bo6/other/salvage.png", "mips")
local essenceIcon = Material("bo6/other/essence.png", "mips")

local function We(x)
    return x/1920*ScrW()
end

local function He(y)
    return y/1080*ScrH()
end

surface.CreateFont("BO6_Exfil48", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(48),
})

surface.CreateFont("BO6_Exfil72", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(72),
})

surface.CreateFont("BO6_Exfil20", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(20),
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
    title:SetPos(We(150), He(50))
    title:SetText(string.upper(game.GetMap()).." | "..gametype.." | ROUND "..round)
    title:SetFont("BO6_Exfil24")
    title:SetContentAlignment(7)
    title:SetTextColor(Color(255, 165, 0))
    title:SizeToContents()

    local title = vgui.Create("DLabel", frame)
    title:SetPos(We(150), He(70))
    title:SetText("ROUND-BASED ZOMBIES")
    title:SetFont("BO6_Exfil48")
    title:SetContentAlignment(7)
    title:SetTextColor(Color(255, 255, 255))
    title:SizeToContents()

    local icon = vgui.Create("DImage", frame)
    icon:SetPos(We(10), He(25))
    icon:SetSize(We(564/4), He(468/4))
    icon:SetMaterial(roundBasedIcon)

    local eliminated = vgui.Create("DLabel", frame)
    eliminated:SetSize(ScrW(), He(100))
    eliminated:SetPos(0, He(150))
    eliminated:SetText(text)
    eliminated:SetFont("BO6_Exfil96")
    eliminated:SetContentAlignment(5)
    eliminated:SetTextColor(Color(200, 200, 200))

    local roundsSurvived = vgui.Create("DLabel", frame)
    roundsSurvived:SetSize(ScrW(), He(30))
    roundsSurvived:SetPos(0, He(230))
    roundsSurvived:SetText(string.format(nzSettings:GetSimpleSetting("BO6_GO_RoundText", "You Survived %s Rounds"), tostring(round)))
    roundsSurvived:SetFont("BO6_Exfil26")
    roundsSurvived:SetContentAlignment(5)
    roundsSurvived:SetTextColor(Color(255, 255, 255))

    local columns = { "№", "NAME", "ESSENCE", "ELIMINATIONS", "DOWNS", "REVIVES", "PING" }
    local headerPanel = vgui.Create("DPanel", frame)
    headerPanel:SetSize(ScrW() * (#columns/10), He(40))
    headerPanel:SetPos(ScrW()/2 - headerPanel:GetSize()/2, ScrH() * 0.4)
    headerPanel.Paint = function(self, w, h)
        surface.SetDrawColor(55, 55, 55, 200)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255, 10)
        surface.DrawRect(We(190), 0, We(2), h)
    end

    for i, col in ipairs(columns) do
        local label = vgui.Create("DLabel", headerPanel)
        label:SetPos((i - 1) * (ScrW() * 0.1), He(10))
        label:SetSize(ScrW() * 0.1, He(20))
        label:SetText(col)
        label:SetContentAlignment(5)
        label:SetFont("BO6_Exfil24")
        label:SetTextColor(Color(255, 255, 255))
    end

    local playersTab = player.GetAll()
    for k, v in pairs(playersTab) do
        local rowPanel = vgui.Create("DPanel", frame)
        rowPanel:SetPos(ScrW()/2 - headerPanel:GetSize()/2, ScrH() * 0.4+(k*He(40)))
        rowPanel:SetSize(ScrW() * (#columns/10), He(40))
        rowPanel.Paint = function(self, w, h)
            surface.SetDrawColor(125, 125, 125, 50)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(255, 255, 255, 10)
            surface.DrawRect(We(190), 0, We(2), h)
        end

        local rowValues = { k, v:Nick(), v:GetPoints(), v:GetTotalKills(), v:GetTotalDowns(), v:GetTotalRevives(), v:Ping() }
        for i, value in ipairs(rowValues) do
            local label = vgui.Create("DLabel", rowPanel)
            label:SetPos((i - 1) * (ScrW() * 0.1), He(10))
            label:SetSize(ScrW() * 0.1, He(20))
            label:SetText(value)
            label:SetContentAlignment(5)
            if i == 2 then
                label:SetTextColor(Color(255, 220, 0))
            else
                label:SetTextColor(Color(255, 255, 255))
            end
            label:SetFont("BO6_Exfil20")
        end
    end

    local downPanel = vgui.Create("DPanel", frame)
    downPanel:SetSize(ScrW() * (#columns/10) + We(50), He(90))
    downPanel:SetPos(ScrW()/2 - downPanel:GetSize()/2, ScrH() * 0.4+((1+#playersTab)*He(40))+He(10))
    downPanel.Paint = function(self, w, h)
        surface.SetDrawColor(150, 150, 150, 50)
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(50, 50, 50, 180)
        surface.DrawRect(We(75), 0, He(250), h)
        draw.SimpleText(LocalPlayer():Nick(), "BO6_Exfil24", We(200), He(2), color_white, TEXT_ALIGN_CENTER)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(essenceIcon)
        surface.DrawTexturedRect(We(445), He(4), We(28), He(28))
        draw.SimpleText("ESSENCE", "BO6_Exfil24", We(500), He(5), color_white, TEXT_ALIGN_CENTER)
        draw.SimpleText(LocalPlayer():GetPoints(), "BO6_Exfil72", We(500), He(55), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(salvageIcon)
        surface.DrawTexturedRect(We(625), He(4), We(28), He(28))
        draw.SimpleText("SALVAGE", "BO6_Exfil24", We(680), He(5), color_white, TEXT_ALIGN_CENTER)
        draw.SimpleText(LocalPlayer():GetNWInt('Salvage', 0), "BO6_Exfil72", We(680), He(55), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    local Avatar = vgui.Create("AvatarImage", downPanel)
	Avatar:SetSize(We(56), He(56))
	Avatar:SetPos(We(172.5), He(30))
	Avatar:SetPlayer(LocalPlayer(), We(56))

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