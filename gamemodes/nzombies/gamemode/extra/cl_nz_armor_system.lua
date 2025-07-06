-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!
CreateClientConVar("nz_key_armor", KEY_H, true, true, "Sets the key for inserting an armorplate.")

local armorBreakAlpha = 0
local armorBreakFadeTime = 0.2

local w, h = ScrW(), ScrH()
local scale = ((w / 1920) + 1) / 2

local armorIcon = Material("bo6/hud/armorplate.png", "mips")
local keyArmorTxt = GetConVar("nz_key_armor"):GetInt()
local keyArmorDisplay = nzKeyConfig.keyDisplayNames[keyArmorTxt] or "?"

local vmOffsetLerp = 0
local offsetSpeed = 7
local maxRightOffset = 1
local maxDownOffset = 0.7
local offsetActiveUntil = 0

local function TriggerArmorOffset()
    offsetActiveUntil = CurTime() + 0.9
end

local function TriggerArmorOffsetFast()
    offsetActiveUntil = CurTime() + 0.6
end

hook.Add("HUDPaint", "DrawArmorPlateHUD", function()
    local ply = LocalPlayer()
    if !GetConVar("cl_drawhud"):GetBool() or !IsValid(ply) or !ply:Alive() or !nzSettings:GetSimpleSetting("BO6_Armor", false) or !nzSettings:GetSimpleSetting("BO6_ArmorHUD", true) then return end

    local pl = ply:GetNWInt('ArmorPlates')
    local maxPlates = nzSettings:GetSimpleSetting("BO6_Armor_MaxPlates", 3)

    local iconX = 325 * scale
    local iconY = h - (70 * scale)

    surface.SetMaterial(armorIcon)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(iconX, iconY, 32 * scale, 32 * scale)

    surface.SetDrawColor(255, 255, 255)
    surface.DrawRect(iconX, iconY + (34 * scale), 32 * scale, 2 * scale)

    draw.RoundedBox(4, iconX + (4 * scale), iconY + (40 * scale), 24 * scale, 24 * scale, color_white)
    draw.SimpleText(keyArmorDisplay, "BO6_Exfil26", iconX + (16 * scale), iconY + (52 * scale), Color(25, 25, 25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    local plateColor = pl < maxPlates and Color(255, 255, 255) or Color(255, 200, 50)
    draw.SimpleText(pl, "BO6_Exfil26", iconX + (40 * scale), iconY + (16 * scale), plateColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end)

hook.Add("Think", "nzrArmorSystem_ClientVManipStatus", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local isDoing = VManip and VManip:GetCurrentAnim() ~= nil

    if ply._lastVManipStatus ~= isDoing then
        ply._lastVManipStatus = isDoing
        net.Start("nzrArmorSystem_VManipStatus")
        net.WriteBool(isDoing)
        net.SendToServer()
    end
end)

hook.Add("CalcViewModelView", "nzrArmorSystem_OffsetVMOnReplate", NZR_CalcVMOffset)

net.Receive("ButtDigger9000", function()
    if VManip then VManip:PlayAnim("replate_t10") end
    NZR_TriggerVMOffset(0.9, 1, 0.7)
end)

net.Receive("ButtDigger9001", function()
    if VManip then VManip:PlayAnim("replate_fast_t10") end
    NZR_TriggerVMOffset(0.6, 1, 0.7)
end)

net.Receive("nzrArmorSystem_ArmorBreak", function()
    armorBreakAlpha = 100
end)
