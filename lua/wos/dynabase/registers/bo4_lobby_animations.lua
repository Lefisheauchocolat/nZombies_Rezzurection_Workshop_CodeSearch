 wOS.DynaBase:RegisterSource({
        Name = "BO4 Lobby Animations For nZ",
        Type =  WOS_DYNABASE.EXTENSION,
        Shared = "models/wavy_ports/bo4/bo4lobbyanims.mdl"
    })

    hook.Add( "PreLoadAnimations", "wOS.DynaBase.MountBO4LobbyAnims", function( gender )
        if gender != WOS_DYNABASE.SHARED then return end
        IncludeModel( "models/wavy_ports/bo4/bo4lobbyanims.mdl" )
    end )