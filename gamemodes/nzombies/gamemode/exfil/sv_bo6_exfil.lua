-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

util.AddNetworkString("nZr.ExfilTimer")
util.AddNetworkString("nZr.ExfilCutscene")
util.AddNetworkString("nZr.ExfilPosition")
util.AddNetworkString("nZr.ExfilMessage")
util.AddNetworkString("nzPreviewExfilAnim")

nZr_Exfil_Map_Positions = nZr_Exfil_Map_Positions or {}
nZr_Exfil_Map_Angles = nZr_Exfil_Map_Angles or {}

local function nZr_UpdatePositions()
    local datab = ents.FindByClass("bo6_exfil_point")
    local pos_tab = {}
    local ang_tab = {}
    for _, ent in pairs(datab) do
        table.insert(pos_tab, ent:GetPos())
        table.insert(ang_tab, ent:GetAngles())
    end
    nZr_Exfil_Map_Positions = pos_tab
    nZr_Exfil_Map_Angles = ang_tab
end

nZr_Exfil_Heli = nil
nZr_Exfil_Position = nil
nZr_Exfil_Angles = nil
nZr_Exfil_Enemies = 1
nZr_Exfil_Landing = false
nZr_Exfil_RadioActive = true

nZr_Exfil_Setting_ClearRadius = 800
nZr_Exfil_Setting_LoadRadius = 160

local function nZr_CalculateZombies()
    local MIN_ZOMBIES = 16
    local MAX_ZOMBIES = math.max(16, nzSettings:GetSimpleSetting("ExfilMaxZombies", 84))
    local BASE_MULTIPLIER = 1 
    local WAVE_SCALING = 1.1
    local PLAYER_SCALING_BASE = 4
    local PLAYER_SCALING_EXTRA = 0.2

    local wave = nzRound:GetNumber()
    local playerCount = #player.GetAllPlayingAndAlive()
    local baseZombies = wave * BASE_MULTIPLIER
    local waveFactor = math.pow(wave, WAVE_SCALING)
    local playerFactor = playerCount * (PLAYER_SCALING_BASE + (wave * PLAYER_SCALING_EXTRA))
    local zombieCount = math.floor(baseZombies + waveFactor + playerFactor)
    
    zombieCount = math.max(zombieCount, MIN_ZOMBIES)
    zombieCount = math.min(zombieCount, MAX_ZOMBIES)
    
    return zombieCount
end

local function nZr_ChangeGameOverDelay()
    local def = nzMapping.Settings.gocamerawait
    nzMapping.Settings.gocamerawait = 5
    BroadcastLua([[nzMapping.Settings.gocamerawait = ]]..5)
    timer.Simple(1, function()
        nzMapping.Settings.gocamerawait = def
        BroadcastLua([[nzMapping.Settings.gocamerawait = ]]..def)
    end)
end

local ktab = {"bo6_choppergunner", "bo6_rcxd", "bo6_hellstorm", "bo6_sentry"}
function nZr_Exfil_RemoveKillstreaks()
    for _, ent in pairs(ents.FindByClass("bo6_*")) do
        if table.HasValue(ktab, ent:GetClass()) then
            ent:Remove()
        end
    end
end

function nZr_Exfil_Message(type)
    net.Start("nZr.ExfilMessage")
    net.WriteInt(type, 32)
    net.Broadcast()
end

function nZr_Exfil_PreviewCutscene(is_success, ply)
    local npos, nang, ndist = nil, nil, math.huge
    for _, ent in pairs(ents.FindByClass("bo6_exfil_point")) do
        if ply:GetPos():DistToSqr(ent:GetPos()) < ndist then
            ndist = ply:GetPos():DistToSqr(ent:GetPos())
            nang = ent:GetAngles()
            npos = ent:GetPos()
        end
    end
    if !isvector(npos) then return end

    net.Start("nZr.ExfilCutscene")
    net.WriteBool(is_success)
    net.WriteVector(npos)
    net.WriteAngle(nang)
    net.WriteTable(nzFuncs:GetZombieMapModel(true))
    net.Send(ply)
end

net.Receive("nzPreviewExfilAnim", function(len, ply)
    local bool = net.ReadBool()
    nZr_Exfil_PreviewCutscene(bool, ply)
end)

function nZr_Exfil_Cutscene(is_success, pos, ang)
    net.Start("nZr.ExfilCutscene")
    net.WriteBool(is_success)
    net.WriteVector(pos)
    net.WriteAngle(ang)
    net.WriteTable(nzFuncs:GetZombieMapModel(true))
    net.Broadcast()
end

function nZr_Exfil_CreateCountdown(time)
    time = time or nzSettings:GetSimpleSetting("ExfilTime", 90)
    timer.Create("BO6_Exfil_Timer", time, 1, function()
        nZr_Exfil_Cutscene(false, nZr_Exfil_Position, nZr_Exfil_Angles)
        nZr_Exfil_Stop()
    end)
end

function nZr_Exfil_StartRandom()
    if #nZr_Exfil_Map_Positions == 0 then 
        print("[ERROR] No Exfil positions on map!") 
        return 
    end

    local id = math.random(1,#nZr_Exfil_Map_Positions)
    local pos = nZr_Exfil_Map_Positions[id]
    local ang = nZr_Exfil_Map_Angles[id]
    nZr_Exfil_RadioActive = false
    nzPowerUps:Nuke(nil, nil, nil, true)
    nzFuncs:PlayClientSound("bo6/exfil/nuke_sound.mp3")
    nzRound:Freeze(true)
    nzRound:SetZombiesMax(0)
    timer.Simple(4, function()
        if #player.GetAllPlayingAndAlive() == 0 then return end
        for k,v in pairs(ents.GetAll()) do
            if v:IsNextBot() and isfunction(v.TakeDamage) then
                v:TakeDamage(math.huge)
            end
        end
        local zmax = nZr_CalculateZombies()
        nzRound:SetZombiesMax(zmax)
        nzRound:SetZombiesToSpawn(nzRound:GetZombiesMax())
        nzRound:SetZombiesKilled(0)
        nzRound.NumberZombies = nzRound:GetZombiesMax()
        nZr_Exfil_Start(pos, ang)
    end)
end

function nZr_Exfil_Start(pos, ang)
    if !isvector(pos) and !isangle(ang) then return end
    nZr_Exfil_Landing = false
    nZr_Exfil_Position = pos
    nZr_Exfil_Angles = ang
    nZr_Exfil_Enemies = nzRound:GetZombiesMax()
    if nzSettings:GetSimpleSetting("ExfilBossEnabled", true) and nzRound:GetNumber() >= nzSettings:GetSimpleSetting("ExfilBossRound", 21) then
        timer.Simple(nzSettings:GetSimpleSetting("ExfilBossDelay", 10), function()
            if nzRound:GetState() != ROUND_PROG then return end
            local boss = nzRound:SpawnBoss()
            if IsValid(boss) then
                nZr_Exfil_Enemies = nZr_Exfil_Enemies + 1
            end
        end)
    end

    hook.Call("OnExfilStart", nil)
    nZr_Exfil_ShowPosition(true, pos, 2)
    nZr_Exfil_ShowTimer(nzSettings:GetSimpleSetting("ExfilTime", 90), 1, nZr_Exfil_Enemies)
    nZr_Exfil_CreateCountdown()

    local lp = pos+Vector(0,0,128)
    BroadcastLua([[
        local ef = EffectData()
        ef:SetOrigin(Vector(]]..lp.x..","..lp.y..","..lp.z..[[))
        ef:SetNormal(Vector(0, 0, 1))
        util.Effect("bo6_exfil_flare", ef)
    ]])

    local time = nzSettings:GetSimpleSetting("ExfilTime", 90) < 75 and nzSettings:GetSimpleSetting("ExfilTime", 90)/3 or 25
    timer.Create("BO6_Exfil_HeliSpawn", time, 1, function()
        local heli = ents.Create("bo6_animated")
        heli:SetPos(pos+Vector(0,0,400))
        heli:SetAngles(ang)
        heli:Spawn()
        heli:SetBodygroup(3,1)
        heli:ResetSequence("spawn")
        nZr_Exfil_Heli = heli
        nzDialog:PlayCustomDialog(nzSettings:GetSimpleSetting("ExfilPilotType", "raptor").."Exfil_Arrive")
        timer.Simple(7, function()
            if IsValid(nZr_Exfil_Heli) and nZr_Exfil_Enemies > 0 then
                nzDialog:PlayCustomDialog(nzSettings:GetSimpleSetting("ExfilPilotType", "raptor").."Exfil_Clear")
            end
        end)
    end)
    timer.Create("BO6_Exfil_Faster", nzSettings:GetSimpleSetting("ExfilTime", 90)-30, 1, function()
        nzDialog:PlayCustomDialog(nzSettings:GetSimpleSetting("ExfilPilotType", "raptor").."Exfil_30sec")
        timer.Create("BO6_Exfil_Faster", 15, 1, function()
            nzDialog:PlayCustomDialog(nzSettings:GetSimpleSetting("ExfilPilotType", "raptor").."Exfil_15sec")
            timer.Simple(5, function()
                if IsValid(nZr_Exfil_Heli) and (nZr_Exfil_Enemies < 5 and nZr_Exfil_Enemies > 0) and !IsValid(ents.FindByClass("*_boss_*")[1]) then
                    nZr_Exfil_Enemies = 0
                    nzPowerUps:Nuke(nil, nil, nil, true)
                end
            end)
        end)
    end)
    timer.Simple(4, function()
        nzDialog:PlayCustomDialog(nzSettings:GetSimpleSetting("ExfilPilotType", "raptor").."Exfil_Start")
    end)
end

function nZr_Exfil_Stop(is_success)
    hook.Call("OnExfilScene", nil, is_success)
    if is_success then
        nZr_Exfil_Cutscene(true, nZr_Exfil_Position, nZr_Exfil_Angles)
        timer.Simple(13, function()
            nZr_Exfil_RadioActive = true
            nZr_ChangeGameOverDelay()
            nzRound:Win(nil, nil, nzMapping.Settings.gameovertime+5)
            timer.Remove("NZRoundThink")
            nzRound:Freeze(false)
        end)
    else
        timer.Simple(13, function()
            nZr_Exfil_RadioActive = true
            nZr_ChangeGameOverDelay()
            nzRound:Lose(nil, nzMapping.Settings.gameovertime+5)
            timer.Remove("NZRoundThink")
            nzRound:Freeze(false)
        end)
    end
    timer.Remove("BO6_Exfil_Timer")
    timer.Remove("BO6_Exfil_HeliSpawn")
    timer.Remove("BO6_Exfil_Faster")
    nZr_Exfil_ShowPosition(false)
    nZr_Exfil_ShowTimer(0, 1, 0, nil, true)
    nZr_Exfil_Position = nil
    nZr_Exfil_Angles = nil
    nZr_Exfil_Landing = false
    nZr_Exfil_Enemies = 1
    if IsValid(nZr_Exfil_Heli) then
        nZr_Exfil_Heli:Remove()
        nZr_Exfil_Heli = nil
    end
    for _, ply in pairs(player.GetAll()) do
        if ply:GetNotDowned() then
            ply:KillSilent()
        else
            ply:KillDownedPlayer(true)
        end
    end
    nzRound:SetZombiesMax(0)
    nzRound:SetZombiesToSpawn(0)
    nzRound:SetZombiesKilled(0)
    for k,v in pairs(ents.GetAll()) do
        if v:IsNextBot() then
            v:Remove()
        end
    end
end

function nZr_Exfil_ShowPosition(state, pos, type)
    type = type or 0
    pos = pos or Vector(0,0,0)
    net.Start("nZr.ExfilPosition")
    net.WriteBool(state)
    net.WriteVector(pos+Vector(0,0,64))
    net.WriteInt(type, 32)
    net.Broadcast()
end

function nZr_Exfil_ShowTimer(time, state, enemies, ply, disable)
    disable = disable or false
    net.Start("nZr.ExfilTimer")
    net.WriteInt(time, 32)
    net.WriteInt(state, 32)
    net.WriteInt(enemies, 32)
    net.WriteBool(disable)
    if ply then
        net.Send(ply)
    else
        net.Broadcast()
    end
end

hook.Add("OnZombieKilled", "nZr_Exfil_Think", function(ent)
    if nZr_Exfil_Position != nil then
        nZr_Exfil_Enemies = math.max(nZr_Exfil_Enemies - 1, 0)
    end
end)

hook.Add("OnBossKilled", "nZr_Exfil_Think", function()
    if nZr_Exfil_Position != nil then
        nZr_Exfil_Enemies = math.max(nZr_Exfil_Enemies - 1, 0)
    end
end)

local alive_count_delay = 0
hook.Add("Think", "nZr_Exfil_Think", function()
    if !timer.Exists("BO6_Exfil_Timer") or nZr_Exfil_Position == nil then return end
    
    local alivecount = 0
    local tab = player.GetAll()
    for i=1,#tab do
        ply = tab[i]
        if nZr_Exfil_Landing then
            if IsValid(nZr_Exfil_Heli) and nZr_Exfil_Heli.loading and ply:Alive() and ply:GetPos():DistToSqr(nZr_Exfil_Position) < nZr_Exfil_Setting_LoadRadius^2 then
                nZr_Exfil_Stop(true)
            else
                nZr_Exfil_ShowTimer(timer.TimeLeft("BO6_Exfil_Timer"), 3, nZr_Exfil_Enemies, ply)
            end
        else
            if ply:Alive() and ply:GetPos():DistToSqr(nZr_Exfil_Position) < nZr_Exfil_Setting_ClearRadius^2 then
                nZr_Exfil_ShowTimer(timer.TimeLeft("BO6_Exfil_Timer"), 2, nZr_Exfil_Enemies, ply)
            else
                nZr_Exfil_ShowTimer(timer.TimeLeft("BO6_Exfil_Timer"), 1, nZr_Exfil_Enemies, ply)
            end
        end
        if ply:Alive() then
            alivecount = alivecount + 1
        end
    end
    alivecount = #player.GetAllPlayingAndAlive()
    if alivecount > 0 then
        alive_count_delay = CurTime() + 2
    end

    if alivecount == 0 and alive_count_delay < CurTime() then
        alive_count_delay = CurTime() + 2
        nZr_Exfil_CreateCountdown(0)
    end

    if IsValid(nZr_Exfil_Heli) then
        if nZr_Exfil_Heli:GetCycle() > 0.2 and not nZr_Exfil_Heli.downing then
            nZr_Exfil_Heli:SetCycle(0.2)
        end
        if nZr_Exfil_Landing and nZr_Exfil_Heli:GetCycle() >= 0.2 and not nZr_Exfil_Heli.downing then
            nZr_Exfil_Heli.downing = true
            nZr_Exfil_Heli:ResetSequence("landing")
            nZr_Exfil_Heli:SetCycle(0)
            nzDialog:PlayCustomDialog(nzSettings:GetSimpleSetting("ExfilPilotType", "raptor").."Exfil_GetIn")
            timer.Remove("BO6_Exfil_Faster")
            for i=1,150 do
                timer.Simple(0.05*i, function()
                    if !IsValid(nZr_Exfil_Heli) then return end

                    nZr_Exfil_Heli:SetPos(nZr_Exfil_Heli:GetPos()-Vector(0,0,2.6))
                    if i == 120 then
                        nZr_Exfil_Heli.loading = true
                    end
                end)
            end
        end
    end

    if IsValid(nZr_Exfil_Heli) and not nZr_Exfil_Landing and nZr_Exfil_Enemies <= 0 then
        nZr_Exfil_CreateCountdown(timer.TimeLeft("BO6_Exfil_Timer")+10)
        nZr_Exfil_Landing = true
    end
end)

hook.Add("OnGameBegin", "nZr_Exfil_LoadPos", nZr_UpdatePositions)

hook.Add("OnRoundStart", "nZr_ExfilRadio", function(rnd)
    local rad = ents.FindByClass("bo6_exfil_radio")[1]
    if nzSettings:GetSimpleSetting("ExfilEnabled", true) and (nzRound:GetNumber() >= nzSettings:GetSimpleSetting("ExfilFirstRound", 11) and (nzRound:GetNumber()-nzSettings:GetSimpleSetting("ExfilFirstRound", 11)) % nzSettings:GetSimpleSetting("ExfilEveryRound", 5) == 0) and IsValid(rad) then
        nzDialog:PlayCustomDialog(nzSettings:GetSimpleSetting("ExfilPilotType", "raptor").."Exfil_Available")
    end
end)

hook.Add("OnRoundPreparation", "nZr_ExfilRadio", function(rnd)
    local rad = ents.FindByClass("bo6_exfil_radio")[1]
    if nzSettings:GetSimpleSetting("ExfilEnabled", true) and (nzRound:GetNumber() >= nzSettings:GetSimpleSetting("ExfilFirstRound", 11) and (nzRound:GetNumber()-nzSettings:GetSimpleSetting("ExfilFirstRound", 11)) % nzSettings:GetSimpleSetting("ExfilEveryRound", 5) == 1) and IsValid(rad) then
        nzDialog:PlayCustomDialog(nzSettings:GetSimpleSetting("ExfilPilotType", "raptor").."Exfil_Unavailable")
    end
end)