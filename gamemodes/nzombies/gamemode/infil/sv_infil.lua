-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local function StartInfil()
    local tab = ents.FindByClass("bo6_infil_point")
    if !nzSettings:GetSimpleSetting("InfilEnabled", false) or #tab == 0 then return end

    table.Shuffle(tab)
    for k, v in pairs(tab) do
        local infil = ents.Create("bo6_infil_start")
        infil:SetPos(v:GetPos())
        infil:SetAngles(v:GetAngles())
        infil.Infil = v.type
        infil.InfilChief = v.chief
        infil.TeamChoose = 2
        infil:Spawn()
    end
    nzFuncs:FadeIn(1, 3)
end

hook.Add("OnGameBegin", "nZR.StartInfil", function()
    timer.Simple(0, StartInfil)
end)