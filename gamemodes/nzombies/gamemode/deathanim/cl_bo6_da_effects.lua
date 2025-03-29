local bloodAlwaysMat = Material("bo6/da/screen.png", "noclamp smooth")

nzEffects = nzEffects or {}

function nzEffects:ApplyDamageEffect(damageLevel, duration)
    if !isnumber(duration) then
        duration = 8
    end
    local damageConfig = {
        [1] = {
            count = math.random(8, 12),
            size = 512,
            motionBlur = 0.3,
            bloodAlwaysAlpha = 40,
        },
        [2] = {
            count = math.random(12, 16),
            size = 700,
            motionBlur = 0.45,
            bloodAlwaysAlpha = 80,
        },
        [3] = {
            count = math.random(16, 24),
            size = 1024,
            motionBlur = 0.6,
            bloodAlwaysAlpha = 120,
        },
        [4] = {
            count = math.random(28, 32),
            size = 1200,
            motionBlur = 0.7,
            bloodAlwaysAlpha = 140,
            cornerbottomright = true,
        },
    }

    local config = damageConfig[damageLevel]
    if not config then return end

    local positions = {}
    for i = 1, config.count do
        table.insert(positions, {x = math.random(0, ScrW()), y = math.random(0, ScrH()), yaw = math.random(0,360), mat = Material("bo6/da/shot"..math.random(1,4)..".png")})
    end
    if config.cornerbottomright then
        table.insert(positions, {alpha = 250, x = math.random(ScrW()-We(750), ScrW()-We(800)), y = math.random(ScrW()-He(1000), ScrW()-He(1100)), yaw = math.random(-20,20), mat = Material("bo6/da/bigshot.png")})
    end
    local alpha = 0
    local mainalpha = 1
    local downalpha = false
    local downmainalpha = false

    timer.Simple(duration-1, function()
        downmainalpha = true
    end)

    hook.Add("HUDPaint", "DamageEffect", function()
        if downalpha then
            alpha = math.max(alpha-(FrameTime()*400), 0)
        else
            alpha = math.min(alpha+(FrameTime()*4000), config.bloodAlwaysAlpha)
            if alpha == config.bloodAlwaysAlpha then
                downalpha = true
            end
        end
        if downmainalpha then
            mainalpha = math.max(mainalpha-FrameTime(), 0)
        end

        surface.SetDrawColor(150, 150, 150, alpha*mainalpha)
        surface.SetMaterial(bloodAlwaysMat)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

        for _, pos in ipairs(positions) do
            local al = 230*mainalpha
            if pos.alpha then
                al = pos.alpha*mainalpha
            end
            surface.SetDrawColor(150, 150, 150, al)
            surface.SetMaterial(pos.mat)
            surface.DrawTexturedRectRotated(pos.x, pos.y, We(config.size), He(config.size), pos.yaw)
        end
    end)

    hook.Add("RenderScreenspaceEffects", "DamageBlur", function()
        DrawMotionBlur(0.1, config.motionBlur, 0.01)
    end)

    timer.Create("RemoveHooksDeathAnimsEffect", duration, 1, function()
        hook.Remove("HUDPaint", "DamageEffect")
        hook.Remove("RenderScreenspaceEffects", "DamageBlur")
    end)
end

function nzEffects:DrawDOF(dist, dur)
    RunConsoleCommand("pp_dof", "1")
    RunConsoleCommand("pp_dof_initlength", tostring(dist))
    RunConsoleCommand("pp_dof_spacing", "128")
    timer.Simple(dur, function()
        RunConsoleCommand("pp_dof", "0")
    end)
end