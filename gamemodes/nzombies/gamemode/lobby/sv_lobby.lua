-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzLobby = nzLobby or {}

util.AddNetworkString("nZR.LobbyChangeReady")
util.AddNetworkString("nZR.LobbySkin")

net.Receive("nZR.LobbyChangeReady", function(len, ply)
    ply:SetNWBool('LobbyReady', !ply:GetNWBool('LobbyReady'))
end)

function nzLobby:MakeUnreadyPlayers(close)
    for _, ply in pairs(player.GetAll()) do
        ply:SetNWBool('LobbyReady', false)
        if close then
            ply:ConCommand("hari_lobby_close")
        end
    end
end

function nzLobby:ChangeSkin(ply)
    local mdl = ply:GetInfo( "cl_playermodel" )
    mdl = player_manager.TranslatePlayerModel(mdl) or models/player/combine_soldier.mdl
	ply:SetModel(mdl)
	
	local col = ply:GetInfo( "cl_playercolor" )
	ply:SetPlayerColor( Vector( col ) )

	local col = Vector( ply:GetInfo( "cl_weaponcolor" ) )
	if col:Length() == 0 then
		col = Vector( 0.001, 0.001, 0.001 )
	end
	ply:SetWeaponColor( col )
	
	local skin = ply:GetInfoNum( "cl_playerskin", 0 )
	ply:SetSkin( skin )

	local groups = ply:GetInfo( "cl_playerbodygroups" )
	if ( groups == nil ) then groups = "" end
	local groups = string.Explode( " ", groups )
	for k = 0, ply:GetNumBodyGroups() - 1 do
		ply:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
	end
end

hook.Add("OnGameBegin", "nZR.LobbyReset", function()
    timer.Simple(0.1, function()
        nzLobby:MakeUnreadyPlayers(true)
    end)
end)

hook.Add("OnRoundEnd", "nZR.LobbyReset", function()
    timer.Simple(0.1, function()
        nzLobby:MakeUnreadyPlayers()
    end)
end)

hook.Add("PlayerInitialSpawn", "nZR.LobbySetSkin", function(ply)
    nzLobby:ChangeSkin(ply)
end)

local startdelay = 0
hook.Add("Think", "nZR.LobbyThink", function()
    if nzLobby:CanStart() then
        if startdelay < CurTime() then
            startdelay = CurTime()+nzSettings:GetSimpleSetting("Lobby_TimeBeforeStart", 10)
            nzRound:Init()
        end
    else
        startdelay = CurTime()+nzSettings:GetSimpleSetting("Lobby_TimeBeforeStart", 10)-0.1
    end
end)

net.Receive("nZR.LobbySkin", function(len, ply)
    if ply:Alive() then return end
    nzLobby:ChangeSkin(ply)
end)

--REWRITING DEFAULT FUNCTIONS--

timer.Simple(1, function()
    function nzRound:OnPlayerReady( ply )
        self:SendReadyState( ply, true )
        if !nzSettings:GetSimpleSetting("Lobby_Enabled", true) then
            if self:InState( ROUND_WAITING ) and #player.GetAllReady() > #player.GetAllNonSpecs() / 3 then
                self:Init()
            end
        end
    end

    function nzRound:Init()
        if nzSettings:GetSimpleSetting("Lobby_Enabled", true) then
            timer.Simple( 0.1, function() self:SetupGame() self:Prepare() end )
        else
            timer.Simple( 5, function() self:SetupGame() self:Prepare() end )
        end
        self:SetVictory( false )
        self:SetState( ROUND_INIT )
        self:SetEndTime( CurTime() + 5 )
        hook.Call( "OnRoundInit", nzRound )
    end
end)