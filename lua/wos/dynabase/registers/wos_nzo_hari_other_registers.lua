hook.Add("InitLoadAnimations", "wOS.DynaBase.nZo_Hari_Other", function()
    wOS.DynaBase:RegisterSource({
        Name = "nZombies Onslaught - Hari Other Anims",
        Type = WOS_DYNABASE.EXTENSION,
        Male = "models/bo6/hari/other_anims.mdl",
        Female = "models/bo6/hari/other_anims.mdl",
        Zombie = "models/bo6/hari/other_anims.mdl",
    })

    hook.Add("PreLoadAnimations", "wOS.DynaBase.nZo_Hari_Other", function(gender)
        if gender == WOS_DYNABASE.SHARED then
            IncludeModel("models/bo6/hari/other_anims.mdl")
        end
    end)
end)