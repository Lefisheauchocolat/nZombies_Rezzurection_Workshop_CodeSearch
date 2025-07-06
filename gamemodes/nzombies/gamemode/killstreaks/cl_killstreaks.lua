-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local w, h = ScrW(), ScrH()
local scale = ((w / 1920) + 1) / 2

local salvageIcon = Material("bo6/other/salvage.png", "mips")
hook.Add("HUDPaint", "DrawSalvageHUD", function()
    local ply = LocalPlayer()
    if not GetConVar("cl_drawhud"):GetBool() or not IsValid(ply) or not ply:Alive()
    or not nzSettings:GetSimpleSetting("BO6_Salvage", false)
    or not nzSettings:GetSimpleSetting("BO6_SalvageHUD", true) then return end

    surface.SetMaterial(salvageIcon)
    surface.SetDrawColor(255, 255, 255)
    surface.DrawTexturedRect(250 * scale, h - (38 * scale), 32 * scale, 32 * scale)

    draw.SimpleText(ply:GetNWInt('Salvage', 0), "BO6_Exfil26", 285 * scale, h - (20 * scale), Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end)

hook.Add("HUDPaint", "DrawKillstreakIconHUD", function()
    local ply = LocalPlayer()
    if not GetConVar("cl_drawhud"):GetBool() or not IsValid(ply) or not ply:Alive()
    or not ply:HaveKillstreak()
    or not nzSettings:GetSimpleSetting("BO6_KillstreakHUD", true) then return end

    draw.RoundedBox(4, 1250 * scale, h - (72 * scale), 64 * scale, 64 * scale, Color(125, 125, 125, 200))

    local ksIcon = nzKillstreak.ClassToIcon[ply:HaveKillstreak()]
    if ksIcon then
        surface.SetMaterial(ksIcon)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRect(1252 * scale, h - (72 * scale), 60 * scale, 60 * scale)
    end

    draw.RoundedBox(4, 1330 * scale, h - (50 * scale), 24 * scale, 24 * scale, color_white)
    draw.SimpleText("5", "BO6_Exfil26", 1342 * scale, h - (37 * scale), Color(25, 25, 25), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
        local percent = math.max((ManglerDespawnTime - CurTime()) / nzSettings:GetSimpleSetting("BO6_Killstreak_ManglerTime", 45), 0)

        surface.SetDrawColor(20, 20, 20, 180)
        surface.DrawRect(w / 2 - (200 * scale), h - (130 * scale), 400 * scale, 80 * scale)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(manglerIcon)
        surface.DrawTexturedRect(w / 2 - (194 * scale), h - (126 * scale), 72 * scale, 72 * scale)

        surface.SetDrawColor(20, 20, 20, 240)
        surface.DrawRect(w / 2 - (120 * scale), h - (90 * scale), 300 * scale, 20 * scale)

        surface.SetDrawColor(120, 0, 150)
        surface.DrawRect(w / 2 - (120 * scale), h - (90 * scale), (300 * scale) * percent, 20 * scale)

        surface.SetDrawColor(100, 100, 100, 200)
        surface.DrawOutlinedRect(w / 2 - (120 * scale), h - (90 * scale), 300 * scale, 20 * scale, 2)

        draw.SimpleText("MANGLER INJECTION", "BO6_Exfil26", w / 2 - (120 * scale), h - (95 * scale), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    else
        ManglerDespawnTime = CurTime() + nzSettings:GetSimpleSetting("BO6_Killstreak_ManglerTime", 45)
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