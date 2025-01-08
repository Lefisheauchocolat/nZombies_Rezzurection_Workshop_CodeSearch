-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local function We(x)
    return (x / 1920) * ScrW()
end

local function He(y)
    return (y / 1080) * ScrH()
end

local salvageIcon = Material("bo6/other/salvage.png", "mips")
hook.Add("HUDPaint", "DrawSalvageHUD", function()
    local ply = LocalPlayer()
    if !GetConVar("cl_drawhud"):GetBool() or !IsValid(ply) or !ply:Alive() or !nzSettings:GetSimpleSetting("BO6_Salvage", false) or !nzSettings:GetSimpleSetting("BO6_SalvageHUD", true) then return end

    surface.SetMaterial(salvageIcon)
    surface.SetDrawColor(255,255,255)
    surface.DrawTexturedRect(We(250), ScrH()-He(38), We(32), He(32))

    draw.SimpleText(ply:GetNWInt('Salvage', 0), "BO6_Exfil26", We(285), ScrH()-He(20), Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end)

hook.Add("HUDPaint", "DrawKillstreakIconHUD", function()
    local ply = LocalPlayer()
    if !GetConVar("cl_drawhud"):GetBool() or !IsValid(ply) or !ply:Alive() or !ply:HaveKillstreak() or !nzSettings:GetSimpleSetting("BO6_KillstreakHUD", true) then return end

    draw.RoundedBox(4, We(1250), ScrH()-He(72), We(64), He(64), Color(125,125,125,200))
    surface.SetMaterial(nzKillstreak.ClassToIcon[ply:HaveKillstreak()])
    surface.SetDrawColor(255,255,255)
    surface.DrawTexturedRect(We(1252), ScrH()-He(72), We(60), He(60))

    draw.RoundedBox(4, We(1330), ScrH()-He(50), We(24), He(24), color_white)
    draw.SimpleText("5", "BO6_Exfil26", We(1342), ScrH()-He(37), Color(25,25,25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

-------------------------MANGLER--------------------------------------------------

hook.Add("EntityEmitSound", "nzrKillstreaks_Mangler", function(t)
    if IsValid(t.Entity) and t.Entity:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" and string.match(t.SoundName, "/footsteps") then
        t.SoundName = "nz_moo/zombies/vox/_raz/gear/gear_0"..math.random(0,9)..".mp3"
        return true
    end
end)

hook.Add("CalcMainActivity", "nzrKillstreaks_Mangler", function(ply, vel)
    local s = vel:Length()
    if ply:GetSVAnim() == "" and ply:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then
        if !ply:OnGround() then
            return ACT_JUMP, ply:LookupSequence("nz_base_zmb_raz_jump")
        elseif s > 150 then
            return ACT_SPRINT, ply:LookupSequence("nz_base_zmb_raz_sprint")
        elseif s > 10 then
            return ACT_WALK, ply:LookupSequence("nz_base_zmb_raz_walk")
        else
            return ACT_IDLE, ply:LookupSequence("nz_base_zmb_raz_idle")
        end
    end
end)

hook.Add("CalcView", "nzrKillstreaks_Mangler", function( ply, pos, angles, fov )
    if ply:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then
        local view = {
            origin = pos - angles:Forward()*40 + angles:Right()*30 + Vector(0,0,10),
            angles = angles,
            fov = fov,
            drawviewer = true
        }
    
        return view
    end
end)

local manglerIcon = Material("bo6/hud/mangler.png")
local ManglerDespawnTime = 0
hook.Add("HUDPaint", "nzrKillstreaks_Mangler", function()
    local ply = LocalPlayer()
    if ply:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then
        local percent = math.max((ManglerDespawnTime-CurTime())/nzSettings:GetSimpleSetting("BO6_Killstreak_ManglerTime", 45), 0)

        surface.SetDrawColor(20,20,20,180)
        surface.DrawRect(ScrW()/2-We(200), ScrH()-He(130), We(400), He(80))

        surface.SetDrawColor(255,255,255)
        surface.SetMaterial(manglerIcon)
        surface.DrawTexturedRect(ScrW()/2-We(194), ScrH()-He(126), We(72), He(72))

        surface.SetDrawColor(20,20,20,240)
        surface.DrawRect(ScrW()/2-We(120), ScrH()-He(90), We(300), He(20))
        surface.SetDrawColor(120,0,150)
        surface.DrawRect(ScrW()/2-We(120), ScrH()-He(90), We(300)*percent, He(20))
        surface.SetDrawColor(100,100,100,200)
        surface.DrawOutlinedRect(ScrW()/2-We(120), ScrH()-He(90), We(300), He(20), 2)

        draw.SimpleText("MANGLER INJECTION", "BO6_Exfil26", ScrW()/2-We(120), ScrH()-He(95), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    else
        ManglerDespawnTime = CurTime()+nzSettings:GetSimpleSetting("BO6_Killstreak_ManglerTime", 45)
    end
end)


local greenEffectDuration = 6
local fadeOutDuration = 4
local startTime = 0
local function ApplyGreenEffect()
    local curTime = CurTime()
    local elapsed = curTime - startTime

    if elapsed > greenEffectDuration + fadeOutDuration then
        hook.Remove("RenderScreenspaceEffects", "GreenEffectHook")
        return
    end

    local fadeMultiplier = 1
    if elapsed > greenEffectDuration then
        fadeMultiplier = math.Clamp(1 - (elapsed - greenEffectDuration) / fadeOutDuration, 0, 1)
    end

    local tab = {
        ["$pp_colour_addr"] = 0,
        ["$pp_colour_addg"] = 0.2 * fadeMultiplier,
        ["$pp_colour_addb"] = 0,
        ["$pp_colour_brightness"] = 0-(0.3 * fadeMultiplier),
        ["$pp_colour_contrast"] = 1-(0.3 * fadeMultiplier),
        ["$pp_colour_colour"] = 1+(0.3 * fadeMultiplier),
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0.2 * fadeMultiplier,
        ["$pp_colour_mulb"] = 0
    }

    DrawColorModify(tab)
end

function nzKillstreak_DNAEffect()
    startTime = CurTime()
    hook.Add("RenderScreenspaceEffects", "nzrGreenEffectHook", ApplyGreenEffect)
    surface.PlaySound("ambient/explosions/citadel_end_explosion1.wav")
    LocalPlayer():ScreenFade(SCREENFADE.IN, Color(50,150,50,100), 1, 1)
    util.ScreenShake(LocalPlayer():GetPos(), 50, 50, 10, 0, true)
end

---------------------------------------------------------------------------------