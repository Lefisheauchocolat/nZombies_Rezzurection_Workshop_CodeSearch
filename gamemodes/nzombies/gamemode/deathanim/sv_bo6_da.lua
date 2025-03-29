-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

util.AddNetworkString("nZr.DACutscene")

nZr_Death_Animations_LastPosition = Vector(0,0,0)
nZr_Death_Animations_Positions = nZr_Death_Animations_Positions or {}
nZr_Death_Animations_Allow = false
nZr_Death_Animations_Active = false

local function nZr_UpdatePositions()
    local datab = ents.FindByClass("bo6_deathanim_point")
    local ptab = {}
    for _, ent in pairs(datab) do
        table.insert(ptab, {ent:GetPos(), ent:GetAngles()})
    end
    nZr_Death_Animations_Positions = ptab
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

net.Receive("nzPreviewDeathAnim", function(len, ply)
    local str = net.ReadString()
    nZr_DeathAnimation_PreviewCutscene(str, ply)
end)
function nZr_DeathAnimation_PreviewCutscene(type, ply)
    nZr_UpdatePositions()

    if #nZr_Death_Animations_Positions == 0 then
        ply:ChatPrint("[ERROR] No Death Animation positions on map!") 
        return
    end

    if type == nil or type == "" then
        type = "Zombies | death_%s_solo_1" 
    end
    local stab = string.Split(type, " | ")
    local type, sel = stab[1], stab[2]
    local tab = nZr_Death_Animations_Effects[type]
    local zmodel = tab[sel].model
    if type == "Humans" then
        zmodel = "models/player/arctic.mdl"
    end

    ply:SendLua([[
        RunConsoleCommand("cl_drawhud", 0)
        RunConsoleCommand("stopsound")
        LocalPlayer():ScreenFade(SCREENFADE.IN, color_black, 1, 0.1)
    ]])
    
    local data, anim = tab[sel], stab[2]
    net.Start("nZr.DACutscene")
    net.WriteString(anim)
    net.WriteTable(data)
    net.WriteTable(nZr_Death_Animations_Positions)
    net.WriteTable({zmodel, nzFuncs:GetZombieMapModel(false)})
    net.WriteTable(nzFuncs:GetZombieMapModel(true))
    net.Send(ply)
end

function nZr_DeathAnimation_Cutscene(type)
    nZr_UpdatePositions()

    if #nZr_Death_Animations_Positions == 0 then
        print("[ERROR] No Death Animation positions on map!") 
        return 0
    end

    local tab = nZr_Death_Animations_Effects["Zombies"]
    if type != "" then
        tab = nZr_Death_Animations_Effects[type]
    end
    
    local data, anim = table.Random(tab)
    for _, ply in pairs(player.GetAll()) do
        net.Start("nZr.DACutscene")
        net.WriteString(anim)
        net.WriteTable(data)
        net.WriteTable(nZr_Death_Animations_Positions)
        net.WriteTable({nzFuncs:GetZombieMapModel(false, ply), nzFuncs:GetZombieMapModel(false)})
        net.WriteTable(nzFuncs:GetZombieMapModel(true))
        net.Send(ply)
    end

    return data.time
end

local function nZr_DA_Try()
    if nZr_Death_Animations_Active then return end
    nZr_Death_Animations_Allow = false
    nZr_Death_Animations_Active = true
    local type = ""
    if isvector(nZr_Death_Animations_LastPosition) then
        local tab = ents.FindInSphere(nZr_Death_Animations_LastPosition, 400)
        table.Shuffle(tab)
        for _, ent in pairs(tab) do
            if nZr_Death_Animations_Classes[ent:GetClass()] then
                type = nZr_Death_Animations_Classes[ent:GetClass()]
                for _, ply in pairs(player.GetAll()) do
                    ply.LastDamageZombieModel = ent:GetModel()
                end
                break
            end
        end
        for _, ent in pairs(tab) do
            if ent:IsNPC() and IsValid(ent:GetActiveWeapon()) and ent:Disposition(player.GetAll()[1]) == D_HT then
                type = "Humans"
                for _, ply in pairs(player.GetAll()) do
                    ply.LastDamageZombieModel = ent:GetModel()
                end
                break
            end
        end
    end
    timer.Simple(1, function()
        local time = nZr_DeathAnimation_Cutscene(type)
        timer.Simple(time, function()
            nZr_ChangeGameOverDelay()
            nzRound:Lose()
            timer.Remove("NZRoundThink")
            nzRound:Freeze(false)
            nZr_Death_Animations_Active = false
            nZr_Death_Animations_Allow = false
        end)
        timer.Simple(0.01, function()
            nzRound:SetZombiesMax(0)
            nzRound:SetZombiesToSpawn(0)
            nzRound:SetZombiesKilled(0)
            for k, v in pairs(ents.GetAll()) do
                if v:IsNextBot() or v:IsNPC() then
                    v:Remove()
                end
            end
        end)
    end)
end

local think_delay = 0
hook.Add("PlayerDowned", "nZr_DA_Logic", function(ply)
    local allowed = #nZr_Death_Animations_Positions > 0 and nzSettings:GetSimpleSetting("DeathAnim_Enable", true) and !isvector(nZr_Exfil_Position) and #player.GetAllPlayingAndAlive() == 0 and nzRound:GetState() == ROUND_PROG and !nZr_Death_Animations_Allow
    if allowed then
        think_delay = CurTime()+2
        nZr_Death_Animations_Allow = true
        nzRound:Freeze(true)
        nZr_Death_Animations_LastPosition = ply:GetPos()
        timer.Simple(2, function()
            BroadcastLua([[
                RunConsoleCommand("cl_drawhud", 0)
                RunConsoleCommand("stopsound")
                LocalPlayer():ScreenFade(SCREENFADE.IN, color_black, 1, 1)
            ]])
            for _, ply in pairs(player.GetAll()) do
                if ply:GetNotDowned() then
                    ply:KillSilent()
                else
                    ply:KillDownedPlayer(true)
                end
            end
        end)
    end
end)

local function isAlivePlayers()
	for _, ply in pairs(player.GetAll()) do
		if ply:Alive() then
            return true
		end
	end
	return false
end

hook.Add("OnGameBegin", "nZr_DA_LoadPos", nZr_UpdatePositions)
hook.Add("Think", "nZr_DA_Logic", function()
    if !nZr_Death_Animations_Allow or think_delay > CurTime() or !isAlivePlayers() then return end
    nZr_DA_Try()
end)