-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzDialog = nzDialog or {}

local subtitlesTab = {}
local voiceOvers = {}
local activeDialog = {
    name = "",
    text = "",
    icon = nil,
    sound = nil,
    color = Color(255,255,255),
    endTime = 0
}

local function DisplayCharacterDialog(name, iconPath, soundPath, color)
    local ply = LocalPlayer()
    color = color or Color(60,165,255)
    soundPath = soundPath or ""
    local text = subtitlesTab[soundPath] or "???"
    activeDialog.name = name
    activeDialog.text = text
    if iconPath then
        activeDialog.icon = Material(iconPath, "noclamp smooth")
    else
        activeDialog.icon = nil
    end
    activeDialog.endTime = CurTime() + math.max(#text/12, 2)
    activeDialog.color = color
    if soundPath then
        if isstring(ply.LastDialogPath) then
            ply:StopSound(ply.LastDialogPath)
        end
        ply.LastDialogPath = soundPath
        ply:EmitSound(soundPath)
    end
end

function nzDialog:AddCustomDialog(name, path, dialog, char, icon, clr)
    if voiceOvers[name] then
        table.insert(voiceOvers[name], {path, char, icon, clr})
    else
        voiceOvers[name] = {}
        table.insert(voiceOvers[name], {path, char, icon, clr})
    end
    subtitlesTab[path] = dialog
end

function nzDialog:PlayCustomDialog(voiceover)
    local tab = voiceOvers[voiceover]
    if istable(tab) then
        local tab2 = table.Random(tab)
        if istable(tab2) then
            DisplayCharacterDialog(tab2[2], tab2[3], tab2[1], tab2[4] or Color(60,165,255))
        end
    end
end

hook.Add("HUDPaint", "BO6DrawCharacterDialog", function()
    if CurTime() > activeDialog.endTime then return end
    local screenW, screenH = ScrW(), ScrH()
    local nameColor = Color(255, 255, 255)
    local dialogX = screenW / 2
    local dialogY = screenH / 1.3
    local maxTextWidth = We(1000)

    local iconMaxWidth, iconMaxHeight = We(426 * 0.38), He(654 * 0.38)
    local iconWidth, iconHeight = ScaleToAspect(700, 1076, iconMaxWidth, iconMaxHeight)
    local iconX = screenW - iconWidth - We(50)
    local iconY = screenH / 2 - iconHeight / 2 - He(25)

    if activeDialog.icon and GetConVar("cl_drawhud"):GetBool() then
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(activeDialog.icon)
        surface.DrawTexturedRect(iconX, iconY, iconWidth, iconHeight)
        draw.SimpleText(string.upper(activeDialog.name), "BO6_Exfil32_2", iconX + iconWidth / 2, iconY + iconHeight, nameColor, TEXT_ALIGN_CENTER)
    end

    local function WrapTextWithIndent(text, font, maxWidth, indentWidth)
        surface.SetFont(font)
        local lines, currentLine = {}, ""
        for word in string.gmatch(text, "%S+") do
            local testLine = currentLine .. (currentLine ~= "" and " " or "") .. word
            local textWidth = surface.GetTextSize(testLine)
            if textWidth > maxWidth then
                table.insert(lines, currentLine)
                currentLine = word
            else
                currentLine = testLine
            end
        end
        if currentLine ~= "" then
            table.insert(lines, currentLine)
        end

        for i = 2, #lines do
            lines[i] = string.rep(" ", math.ceil(indentWidth / surface.GetTextSize(" "))) .. lines[i]
        end
        return lines
    end

    surface.SetFont("BO6_Exfil32_2")
    local nameWidth = surface.GetTextSize(activeDialog.name .. ": ")

    local wrappedText = WrapTextWithIndent(activeDialog.text, "BO6_Exfil32_2", maxTextWidth - nameWidth, nameWidth - 2)

    local formattedText = "<font=BO6_Exfil32_2><color="..activeDialog.color.r..","..activeDialog.color.g..","..activeDialog.color.b..">" .. activeDialog.name .. ": </color></font>"
    formattedText = formattedText .. "<font=BO6_Exfil32_2>" .. wrappedText[1] .. "</font>\n"
    for i = 2, #wrappedText do
        formattedText = formattedText .. "<font=BO6_Exfil32_2>" .. wrappedText[i] .. "</font>\n"
    end

    local markupText = markup.Parse(formattedText, maxTextWidth)
    markupText:Draw(dialogX, dialogY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

net.Receive("nZr.DialogVoice", function()
    local voiceover = net.ReadString()
    nzDialog:PlayCustomDialog(voiceover)
end)