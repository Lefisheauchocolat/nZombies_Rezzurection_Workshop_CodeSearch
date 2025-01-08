-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local function We(x)
    return (x / 1920) * ScrW()
end

local function He(y)
    return (y / 1080) * ScrH()
end

local armorIcon = Material("bo6/hud/armorplate.png", "mips")

hook.Add("HUDPaint", "DrawArmorPlateHUD", function()
    local ply = LocalPlayer()
    if !GetConVar("cl_drawhud"):GetBool() or !IsValid(ply) or !ply:Alive() or !nzSettings:GetSimpleSetting("BO6_Armor", false) or !nzSettings:GetSimpleSetting("BO6_ArmorHUD", true) then return end

    surface.SetMaterial(armorIcon)
    surface.SetDrawColor(255,255,255)
    surface.DrawTexturedRect(We(200), ScrH()-He(74), We(32), He(32))

    surface.SetMaterial(armorIcon)
    surface.SetDrawColor(255,255,255)
    surface.DrawRect(We(200), ScrH()-He(40), We(32), He(2))

    draw.RoundedBox(4, We(204), ScrH()-He(32), We(24), He(24), color_white)
    draw.SimpleText("H", "BO6_Exfil26", We(216), ScrH()-He(20), Color(25,25,25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    local pl = ply:GetNWInt('ArmorPlates')
    if pl < nzSettings:GetSimpleSetting("BO6_Armor_MaxPlates", 3) then
        draw.SimpleText(pl, "BO6_Exfil26", We(230), ScrH()-He(76), Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    else
        draw.SimpleText(pl, "BO6_Exfil26", We(230), ScrH()-He(76), Color(255,200,50), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end)