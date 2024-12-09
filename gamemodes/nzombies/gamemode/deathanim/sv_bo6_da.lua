-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

util.AddNetworkString("nZr.DACutscene")

nZr_Death_Animations_LastPosition = Vector(0,0,0)
nZr_Death_Animations_Positions = nZr_Death_Animations_Positions or {}
nZr_Death_Animations_Allow = false
nZr_Death_Animations_Effects = {
    ["Zombies"] = {
        ["death_%s_solo_1"] = {time = 5.43, model = "models/bo6/exfil/zombie_anims.mdl", eff = {[0] = "pistol_solo_1", [0.8] = "sound", [2.8] = "new_rhand"}},
        ["death_%s_solo_2"] = {time = 4.76, model = "models/bo6/exfil/zombie_anims.mdl", eff = {[0.4] = "sound", [4] = "new_neck_bite"}},
        ["death_%s_solo_3"] = {time = 4.13, model = "models/bo6/exfil/zombie_anims.mdl", eff = {[0.4] = "sound", [3.4] = "new_neck_bite"}},
        ["death_%s_solo_4"] = {time = 5.63, model = "models/bo6/exfil/zombie_anims.mdl", eff = {[0.6] = "sound", [1.4] = "new_rfoot", [2.2] = "new_lhand", [3.2] = "new_neck_bite"}},
        ["death_%s_duo_1"] = {time = 4.8, model = "models/bo6/exfil/zombie_anims.mdl", eff = {[0.4] = "sound", [3.6] = "new_neck_bite"}},
        ["death_%s_duo_2"] = {time = 4.73, model = "models/bo6/exfil/zombie_anims.mdl", eff = {[0.4] = "sound"}},
        ["death_%s_duo_4"] = {time = 5.86, model = "models/bo6/exfil/zombie_anims.mdl", eff = {[0.2] = "sound", [0.4] = "new_rforearm", [0.5] = "fear", [3.8] = "new_rforearm_gib", [3.9] = "pain"}},
        ["death_%s_duo_5"] = {time = 9, model = "models/bo6/exfil/zombie_anims.mdl", eff = {[0.4] = "sound", [1.7] = "new_rforearm", [1.8] = "fear", [5.4] = "new_rforearm_gib", [5.5] = "pain"}},
    },
    ["Disciple"] = {
        ["mwz_da_%s_disciple"] = {time = 3.7, model = "models/bo6/hari/da/disciple.mdl", eff = {[0.2] = "touch", [0.4] = "disciple_blast", [0.6] = "fear", [1.8] = "fear", [3.2] = "bonebreak", [3.7] = "drop"}},
    },
    ["NovaCrawler"] = {
        ["mwz_da_%s_novacrawler"] = {time = 6.6, model = "models/bo6/hari/da/novacrawler.mdl", eff = {[0.5] = "fear", [1.5] = "touch", [2.1] = "rleg_bite", [2.2] = "fear", [2.8] = "drop", [4.1] = "touch", [4.5] = "rhand_bite", [4.6] = "pain", [5.5] = "neck_bite", [6] = "drop"}},
    },
    ["Mangler"] = {
        ["mwz_da_%s_mangler"] = {time = 6.15, model = "models/bo6/hari/da/mangler.mdl", eff = {[0.7] = "touch", [0.8] = "fear", [2] = "slash_spine_blood", [2.1] = "pain", [3.6] = "mangler_ready", [4.8] = "mangler_shot", [5] = "headblow", [6] = "drop"}},
    },
    ["Mangler_jup"] = {
        ["mwz_da_%s_mangler"] = {time = 6.15, model = "models/bo6/hari/da/mangler_jup.mdl", eff = {[0.7] = "touch", [0.8] = "fear", [2] = "slash_spine_blood", [2.1] = "pain", [3.6] = "mangler_ready", [4.8] = "mangler_shot", [5] = "headblow", [6] = "drop"}},
    },
    ["Mangler_t10"] = {
        ["mwz_da_%s_mangler"] = {time = 6.15, model = "models/bo6/hari/da/mangler_t10.mdl", eff = {[0.7] = "touch", [0.8] = "fear", [2] = "slash_spine_blood", [2.1] = "pain", [3.6] = "mangler_ready", [4.8] = "mangler_shot", [5] = "headblow", [6] = "drop"}},
    },
    ["Hellhound"] = {
        ["mwz_da_%s_dog"] = {time = 8.6, model = "models/bo6/hari/da/dog.mdl", eff = {[0.2] = "dog_bark", [0.8] = "drop", [1] = "fear", [1.6] = "touch", [2.2] = "dog_attack", [2.8] = "neck_bite", [2.9] = "pain", [5.1] = "touch", [6.8] = "dog_attack", [7.4] = "headblow", [7.9] = "drop"}},
    },
    ["Mimic"] = {
        ["mwz_da_%s_mimic"] = {time = 6, model = "models/bo6/hari/da/mimic.mdl", eff = {[0.6] = "drop", [1] = "fear", [1.8] = "touch", [2.5] = "touch", [3] = "fear", [4.5] = "legblow", [4.6] = "pain", [5.5] = "drop"}},
    },
}
nZr_Death_Animations_Classes = {
    ["nz_zombie_special_disciple"] = "Disciple",
    ["nz_zombie_special_nova"] = "NovaCrawler",
    ["nz_zombie_special_nova_bomber"] = "NovaCrawler",
    ["nz_zombie_special_nova_electric"] = "NovaCrawler",
    ["nz_zombie_special_nova_moon"] = "NovaCrawler",
    ["nz_zombie_special_raz"] = "Mangler",
    ["nz_zombie_special_raz_jup"] = "Mangler_jup",
    ["nz_zombie_special_raz_t10"] = "Mangler_t10",
    ["nz_zombie_boss_raz"] = "Mangler",
    ["nz_zombie_boss_raz_jup"] = "Mangler_jup",
    ["nz_zombie_boss_raz_t10"] = "Mangler_t10",
    ["nz_zombie_special_dog"] = "Hellhound",
    ["nz_zombie_special_dog_zhd"] = "Hellhound",
    ["nz_zombie_special_dog_gas"] = "Hellhound",
    ["nz_zombie_special_dog_fire"] = "Hellhound",
    ["nz_zombie_special_dog_jup"] = "Hellhound",
    ["nz_zombie_special_mimic"] = "Mimic",
}

local function nZr_UpdatePositions()
    local datab = ents.FindByClass("bo6_deathanim_point")
    local ptab = {}
    for _, ent in pairs(datab) do
        table.insert(ptab, ent:GetPos())
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

function nZr_DeathAnimation_Cutscene(type)
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
        net.Send(ply)
    end

    return data.time
end

local function nZr_DA_Try()
    nZr_Death_Animations_Allow = false
    local type = ""
    if isvector(nZr_Death_Animations_LastPosition) then
        for _, ent in pairs(ents.FindInSphere(nZr_Death_Animations_LastPosition, 400)) do
            if nZr_Death_Animations_Classes[ent:GetClass()] then
                type = nZr_Death_Animations_Classes[ent:GetClass()]
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
            if nzSettings:GetSimpleSetting("DeathAnim_Laugh", false) then
                nzSounds:Play("Laugh")
            end
        end)
        timer.Simple(0.01, function()
            nzRound:SetZombiesMax(0)
            nzRound:SetZombiesToSpawn(0)
            nzRound:SetZombiesKilled(0)
            for k, v in pairs(ents.GetAll()) do
                if v:IsNextBot() then
                    v:Remove()
                end
            end
        end)
    end)
end

local think_delay = 0
hook.Add("PlayerDowned", "nZr_DA_Logic", function(ply)
    local allowed = #nZr_Death_Animations_Positions > 0 and nzSettings:GetSimpleSetting("DeathAnim_Enable", true) and !isvector(nZr_Exfil_Position) and #player.GetAllPlayingAndAlive() == 0 and nzRound:GetState() == ROUND_PROG
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

hook.Add("OnGameBegin", "nZr_DA_LoadPos", nZr_UpdatePositions)
hook.Add("Think", "nZr_DA_Logic", function()
    if !nZr_Death_Animations_Allow or think_delay > CurTime() then return end
    nZr_DA_Try()
end)