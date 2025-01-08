-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzFuncs = nzFuncs or {}

hook.Add("EntityTakeDamage", "nZr.CheckZombieModel", function(ply, dmg)
    local att = dmg:GetAttacker()
    if att:LookupBone("j_spineupper") and att:LookupBone("j_ankle_ri") and !nZr_Death_Animations_Classes[att:GetClass()] and !string.match(att:GetClass(), "_boss") then
        ply.LastDamageZombieModel = att:GetModel()
    elseif dmg:GetDamage() > 10 then
        ply.LastDamageZombieModel = nil
    end
end)

hook.Add("PlayerSpawn", "nZr.CheckZombieModel", function(ply)
    ply.LastDamageZombieModel = nil
end)

function nzFuncs:GetZombieMapModel(is_table, ply)
    local def = is_table and {{Model = "models/bo6/hari/da_anims.mdl"}} or "models/bo6/hari/da_anims.mdl"
    if IsValid(ply) then
        local model = ply.LastDamageZombieModel
        if is_table and isstring(model) then
            return {{Model = model}}
        elseif !is_table and isstring(model) then
            return model
        end
        return nzFuncs:GetZombieMapModel(is_table)
    else
        local class = nzRound and nzRound:GetZombieType(nzMapping.Settings.zombietype) or ""
        local ent = ents.Create(class)
        local tab = ent.Models
        SafeRemoveEntity(ent)
        if istable(tab) and #tab > 0 then
            if is_table then
                return tab or def
            else
                return tab[math.random(1,#tab)].Model or def
            end
        end
    end
    return def
end

function nzFuncs:PlayClientSound(path)
    BroadcastLua([[
        surface.PlaySound("]]..path..[[")
    ]])
end

function nzFuncs:FadeIn(timefade, timehold)
    local str = [[
    local p = vgui.Create("DPanel")
    p:SetSize(ScrW(), ScrH())
    p:SetBackgroundColor(Color(0, 0, 0, 255))

    p:AlphaTo(0, ]]..timefade..[[, ]]..timehold..[[, function()
        p:Remove()
    end)
    ]]
    if SERVER then
        BroadcastLua(str)
    else
        RunString(str)
    end
end

function nzFuncs:ShowTeleportGif(ply)
    ply:SendLua([[
        hook.Add("RenderScreenspaceEffects","nzo",function()
            DrawMaterialOverlay("coldwartp",0.03)
        end)
        RunConsoleCommand("cl_drawhud", "0")
    ]])
    timer.Simple(3, function()
        if !IsValid(ply) then return end
        ply:SendLua([[
            surface.PlaySound("teleport.mp3")
        ]])
    end)
    timer.Simple(8, function()
        if !IsValid(ply) then return end
        ply:SendLua([[
            hook.Remove("RenderScreenspaceEffects","nzo")
            RunConsoleCommand("cl_drawhud", "1")
            surface.PlaySound("weapons/tfa_waw/teslanade/teleport_out.wav")
        ]])
    end)
end

function nzFuncs:TransformModelData(base, to)
    if !IsValid(base) or !IsValid(to) then return end
    to:SetModel(base:GetModel())
    to:SetColor(base:GetColor())
    to:SetSkin(base:GetSkin())
    for i = 0, base:GetNumBodyGroups() - 1 do
        to:SetBodygroup(i, base:GetBodygroup(i))
    end
end