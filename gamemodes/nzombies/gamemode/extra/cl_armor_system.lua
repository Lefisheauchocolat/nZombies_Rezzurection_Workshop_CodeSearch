-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!
CreateClientConVar("nz_key_armor", KEY_H, true, true, "Sets the key for inserting an armorplate.")

local w, h = ScrW(), ScrH()
local scale = ((w / 1920) + 1) / 2

local armorIcon = Material("bo6/hud/armorplate.png", "mips")
local keyArmorTxt = GetConVar("nz_key_armor"):GetInt()
local keyArmorDisplay = nzKeyConfig.keyDisplayNames[keyArmorTxt] or "?"

hook.Add("HUDPaint", "DrawArmorPlateHUD", function()
    local ply = LocalPlayer()
    if !GetConVar("cl_drawhud"):GetBool() or !IsValid(ply) or !ply:Alive() or !nzSettings:GetSimpleSetting("BO6_Armor", false) or !nzSettings:GetSimpleSetting("BO6_ArmorHUD", true) then return end

    surface.SetMaterial(armorIcon)
    surface.SetDrawColor(255,255,255)
    surface.DrawTexturedRect(w - (2120 * scale), h - (74 * scale), 32 * scale, 32 * scale)

    surface.SetMaterial(armorIcon)
    surface.SetDrawColor(255,255,255)
    surface.DrawRect(w - (2120 * scale), h - (40 * scale), 32 * scale, 2 * scale)

    draw.RoundedBox(4, w - (2116 * scale), h - (32 * scale), 24 * scale, 24 * scale, color_white)
    draw.SimpleText(keyArmorDisplay, "BO6_Exfil26", w - (2104 * scale), h - (20 * scale), Color(25, 25, 25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    local pl = ply:GetNWInt('ArmorPlates')
    if pl < nzSettings:GetSimpleSetting("BO6_Armor_MaxPlates", 3) then
        draw.SimpleText(pl, "BO6_Exfil26", w - (2090 * scale), h - (76 * scale), Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    else
        draw.SimpleText(pl, "BO6_Exfil26", w - (2090 * scale), h - (76 * scale), Color(255,200,50), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end)