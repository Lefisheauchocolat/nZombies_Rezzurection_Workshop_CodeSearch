-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!
local showLobbyBG = GetConVar("nz_lobby_show_bg")

nzLobby = nzLobby or {}

function nzLobby:CountReadyPlayers(is_need)
    local count = 0
    for _, ply in pairs(player.GetAll()) do
        if ply:IsReady() then count = count + 1 end
    end
    if is_need then
        local required_ready_players = math.ceil(#player.GetAll() * (nzSettings:GetSimpleSetting("Lobby_Percent", 75)/100))
        local players_needed = math.max(0, required_ready_players - count)
        return players_needed
    end
    return count
end

function nzLobby:CanStart()
    local need_percent = nzSettings:GetSimpleSetting("Lobby_Percent", 75)/100
    local player_percent = nzLobby:CountReadyPlayers()/#player.GetAll()
    return player_percent >= need_percent and nzRound:GetState() == ROUND_WAITING
end
-- Yeah im cheating for real now
hook.Add("PostConfigLoad", "Beatmygrandma34000", function()
    RunConsoleCommand("nz_beatmygrandma3000")
end)
