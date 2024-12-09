hook.Add("InitLoadAnimations", "wOS.DynaBase.nZr", function()
    wOS.DynaBase:RegisterSource({
        Name = "nZombies Rezzurection - Player Anims",
        Type = WOS_DYNABASE.EXTENSION,
        Male = "models/nzr/player_anims.mdl",
        Female = "models/nzr/player_anims.mdl",
        Zombie = "models/nzr/player_anims.mdl",
    })

    hook.Add("PreLoadAnimations", "wOS.DynaBase.nZr", function(gender)
        if gender == WOS_DYNABASE.SHARED then
            IncludeModel("models/nzr/player_anims.mdl")
        end
    end)
end)