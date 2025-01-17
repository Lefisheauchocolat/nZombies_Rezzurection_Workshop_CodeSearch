hook.Add("InitLoadAnimations", "wOS.DynaBase.nZr_Hari_Other", function()
    wOS.DynaBase:RegisterSource({
        Name = "nZombies Rezzurection - BO6 Other Anims",
        Type = WOS_DYNABASE.EXTENSION,
        Male = "models/bo6/hari/other_anims.mdl",
        Female = "models/bo6/hari/other_anims.mdl",
        Zombie = "models/bo6/hari/other_anims.mdl",
    })

    hook.Add("PreLoadAnimations", "wOS.DynaBase.nZr_Hari_Other", function(gender)
        if gender == WOS_DYNABASE.SHARED then
            IncludeModel("models/bo6/hari/other_anims.mdl")
        end
    end)
end)

hook.Add("InitLoadAnimations", "wOS.DynaBase.nZr_Hari_BO6", function()
    wOS.DynaBase:RegisterSource({
        Name = "nZombies Rezzurection - BO6 Other Anims 2",
        Type = WOS_DYNABASE.EXTENSION,
        Male = "models/bo6/hari/bo6_anims.mdl",
        Female = "models/bo6/hari/bo6_anims.mdl",
        Zombie = "models/bo6/hari/bo6_anims.mdl",
    })

    hook.Add("PreLoadAnimations", "wOS.DynaBase.nZr_Hari_BO6", function(gender)
        if gender == WOS_DYNABASE.SHARED then
            IncludeModel("models/bo6/hari/bo6_anims.mdl")
        end
    end)
end)