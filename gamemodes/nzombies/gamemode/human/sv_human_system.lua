-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzHuman = nzHuman or {}

function nzHuman:CreateNPC(pos, ang, data) --baseClass, baseModel, hp, weaponClass, hostileToPlayer, noTargetToZombies, followNearestPlayer, flag, flag2, flag3, chance, isDeathAnim
    if !istable(data) then return end
    if !isvector(pos) then return end
    if isnumber(tonumber(data.chance)) and math.random(1,100) > tonumber(data.chance) then return end

    local npc = ents.Create(data.baseClass != "" and data.baseClass or "npc_combine_s")
    if !IsValid(npc) then return end
    npc:SetPos(pos)
    npc:SetAngles(ang or Angle(0,math.random(0,360),0))
    if data.noTargetToZombies then
        npc:SetTargetPriority(TARGET_PRIORITY_NONE)
    else
        npc:SetTargetPriority(TARGET_PRIORITY_PLAYER)
    end
    npc.IsNZ = true
    if npc:GetClass() == "npc_combine_s" then
        npc:AddSpawnFlags(131072)
    end
    npc:Spawn()
    local mins, maxs = npc:GetCollisionBounds()
    if data.baseModel and data.baseModel != "" then
        npc:SetModel(data.baseModel)
        npc:SetCollisionBounds(mins, maxs)
    end
    npc:SetMaxHealth(tonumber(data.hp) or 100)
    npc:SetHealth(npc:GetMaxHealth())
    npc:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD)
    if tobool(data.followNearestPlayer) then
        npc.followNearestPlayer = tobool(data.followNearestPlayer)
        npc:SetSquad("")
        npc:Fire("StopPatrolling")
    end
    npc:Fire("GagEnable")

    if data.weaponClass and data.weaponClass != "" then
        npc:Give(data.weaponClass)
    end
    if tobool(data.hostileToPlayer) then
        npc:AddRelationship("player D_HT 99")
    else
        npc:AddRelationship("player D_LI 99")
    end
    npc.hostileToPlayer = tobool(data.hostileToPlayer)
    npc:Activate()

    if tobool(data.isDeathAnim) then
        local ent = ents.Create(nzRound:GetZombieType(nzMapping.Settings.zombietype))
        if !IsValid(ent) then return end
        ent:SetPos(npc:GetPos())
        local oldinit = ent.StatsInitialize
		ent.StatsInitialize = function(self)
			oldinit(ent)
			self:SetRunSpeed(1)
		end
        ent:Spawn()
        ent:SetRunSpeed(1)
        nzHuman:MakeDeathAnim(ent, npc, false)
    end

    return npc
end

hook.Add("EntityTakeDamage", "nzr_humanSystem", function(ent, dmg)
    local att = dmg:GetAttacker()
    if (att:IsPlayer() and ent:IsNPC() and ent.IsNZ and not ent.hostileToPlayer) or (ent:IsPlayer() and att:IsNPC() and att.IsNZ and not att.hostileToPlayer) then
        dmg:SetDamage(0)
        return true
    end
    if att:IsNPC() and ent:IsNPC() and att:Disposition(ent) == D_LI and ent:Disposition(att) == D_LI then
        dmg:SetDamage(0)
        return true
    end
end)

hook.Add("OnNPCKilled", "nzr_humanSystem", function(npc, attacker, inflictor)
    if IsValid(npc) and npc.IsNZ then
        for _, weapon in pairs(npc:GetWeapons()) do
            weapon:Remove()
        end
    end
end)

hook.Add("OnEntityCreated", "nzr_humanSystem", function(ent, dmg) --nzLevel.TargetCache
    if ent:GetClass() == "weapon_frag" then
        SafeRemoveEntity(ent)
    end
    if ent:IsNextBot() then
        ent:AddFlags(FL_OBJECT)
    end
    timer.Simple(0.1, function()
        if IsValid(ent) and ent:IsNPC() then
            for _, target in ipairs(ents.GetAll()) do
                if target:IsNextBot() then
                    ent:AddEntityRelationship(target, D_HT, 99)
                end
            end
        elseif IsValid(ent) and ent:IsNextBot() then
            for _, npc in ipairs(ents.GetAll()) do
                if npc:IsNPC() then
                    npc:AddEntityRelationship(ent, D_HT, 99)
                end
            end
        end
    end)
end)

----------

local function GetNearestPlayer(npc)
    local nearestPlayer = nil
    local shortestDistance = math.huge

    for _, ply in ipairs(player.GetHumans()) do
        if IsValid(ply) then
            local distance = npc:GetPos():DistToSqr(ply:GetPos())
            if distance < shortestDistance then
                shortestDistance = distance
                nearestPlayer = ply
            end
        end
    end

    return nearestPlayer
end

local delay = 0
hook.Add("Think", "nzr_humanSystem", function()
    if delay > CurTime() then return end

    delay = CurTime()+2
    for _, npc in ipairs(ents.GetAll()) do
        if IsValid(npc) and npc:IsNPC() and npc.followNearestPlayer then
            local nearestPlayer = GetNearestPlayer(npc)
            if nearestPlayer and npc:GetPos():DistToSqr(nearestPlayer:GetPos()) > 40000 then
                local radius = math.random(48, 72)
                local angle = math.rad(math.random(0, 360))
                local offset = Vector(math.cos(angle) * radius, math.sin(angle) * radius, 24)
                local targetPos = nearestPlayer:GetPos() + offset

                npc:SetLastPosition(targetPos)
                npc:SetSchedule(SCHED_FORCED_GO_RUN)
            end
        end
    end
end)

----------

local function useSpawners(flag)
    for _, ent in pairs(ents.FindByClass("bo6_human_point")) do
        local tab = ent:GetData()
        local bool = tab.flag == flag or flag != "" and (tab.flag2 and tab.flag2 == flag or tab.flag3 and tab.flag3 == flag)
        if bool and not ent.Activated then
            ent.Activated = true
            nzHuman:CreateNPC(ent:GetPos(), ent:GetAngles(), ent:GetData())
        end
    end
end

hook.Add("OnGameBegin", "nzr_humanSystem", function()
    for _, ent in pairs(ents.FindByClass("bo6_human_point")) do
        ent.Activated = false
    end
    useSpawners("")
end)

hook.Add("OnDoorUnlocked", "nzr_humanSystem", function(ent)
    local data = ent:GetDoorData()
    if data["link"] and data["link"] != "" and data["link"] != "1" then
        useSpawners(data["link"])
    end
end)

----------

local animsTab = {
    ["mwz_da_%s_b1"] = {dur = 8, eff = {[0.8] = "fear", [1] = "drop", [2] = "touch", [2.6] = "drop", [3] = "fear", [4.5] = "bite", [4.6] = "pain"}},
    ["mwz_da_%s_b2"] = {dur = 3, eff = {[0.6] = "touch", [1.3] = "bite", [1.4] = "pain", [3.6] = "drop"}},
    ["mwz_da_%s_b3"] = {dur = 8, eff = {[1.1] = "touch", [1.7] = "fear", [2.7] = "touch", [3.1] = "bite", [3.2] = "pain", [7] = "drop"}},
    ["mwz_da_%s_f1"] = {dur = 7, eff = {[0.7] = "touch", [1.4] = "touch", [2] = "drop", [3] = "fear", [4.5] = "bite", [4.6] = "pain"}},
    ["mwz_da_%s_f2"] = {dur = 3.5, eff = {[0.6] = "touch", [0.8] = "bite", [0.9] = "pain", [2.5] = "drop"}},
    ["mwz_da_%s_f3"] = {dur = 6, eff = {[0.6] = "touch", [1.6] = "fear", [2.5] = "bite", [2.6] = "pain", [4.4] = "drop"}},
    ["mwz_da_%s_l1"] = {dur = 7, eff = {[0.5] = "touch", [1.1] = "drop", [1.8] = "fear", [3] = "bite", [3.1] = "pain"}},
    ["mwz_da_%s_l2"] = {dur = 4, eff = {[0.7] = "touch", [1] = "bite", [1.1] = "pain", [4.7] = "drop"}},
    ["mwz_da_%s_l3"] = {dur = 5, eff = {[1] = "touch", [1.8] = "fear", [2.6] = "bite", [2.7] = "pain", [6.8] = "drop"}},
    ["mwz_da_%s_r1"] = {dur = 7.5, eff = {[0.6] = "touch", [1.3] = "drop", [2] = "fear", [3.2] = "bite", [3.3] = "pain"}},
    ["mwz_da_%s_r2"] = {dur = 3, eff = {[0.4] = "touch", [0.7] = "bite", [0.8] = "pain", [2.4] = "drop"}},
    ["mwz_da_%s_r3"] = {dur = 7, eff = {[0.8] = "touch", [1.7] = "fear", [2.5] = "bite", [2.6] = "fear", [4.2] = "touch", [4.3] = "bite", [4.4] = "pain", [7.5] = "drop"}},
}

local function getAnimDirection(z, h)
    local id = math.random(1,3)
    local tab, anim = animsTab["mwz_da_%s_f"..id], "mwz_da_%s_f"..id
    local humanPos = h:GetPos()
    local zombiePos = z:GetPos()
    local direction = (humanPos - zombiePos):GetNormalized()
    local zombieForward = h:GetForward()
    local dot = zombieForward:Dot(direction)

    if dot > 0.5 then
        tab, anim = animsTab["mwz_da_%s_b"..id], "mwz_da_%s_b"..id
    elseif dot < -0.5 then
        tab, anim = animsTab["mwz_da_%s_f"..id], "mwz_da_%s_f"..id
    else
        local rightDot = h:GetRight():Dot(direction)
        if rightDot > 0 then
            tab, anim = animsTab["mwz_da_%s_l"..id], "mwz_da_%s_l"..id
        else
            tab, anim = animsTab["mwz_da_%s_r"..id], "mwz_da_%s_r"..id
        end
    end

    return tab, anim
end

function nzHuman:MakeDeathAnim(zombie, human, direction)
    local pos = human:GetPos()
    local ang = human:GetAngles()
    local tab, anim = table.Random(animsTab)

    if direction then
        tab, anim = getAnimDirection(zombie, human)
    end

    local z = ents.Create("bo6_da_npc")
    z:SetPos(pos)
    z:SetAngles(ang)
    z:Spawn()
    z:SetModel("models/bo6/hari/da_anims.mdl")
    z:SetBonemerge(zombie)
    z.IsZombie = true
    z:PlayDeathAnim(anim, tab, zombie)

    local h = ents.Create("bo6_da_npc")
    h:SetPos(pos)
    h:SetAngles(ang)
    h:Spawn()
    h:SetModel("models/bo6/hari/da_anims_human.mdl")
    h:SetBonemerge(human)
    h:PlayDeathAnim(anim, tab)

    human:Remove()
    zombie:SetNoDraw(true)
    zombie:SetNotSolid(true)
    zombie:DrawShadow(false)
    zombie:SetStop(true)
    zombie.inDeathAnimSequence = true
    timer.Simple(tab.dur, function()
        if !IsValid(zombie) then return end
        zombie:SetNoDraw(false)
        zombie:SetNotSolid(false)
        zombie:DrawShadow(true)
        zombie:SetStop(false)
        zombie.inDeathAnimSequence = false
    end)
end

hook.Add("EntityTakeDamage", "nzr_humanSystemDeathAnims", function(ent, dmg)
    local att = dmg:GetAttacker()
    if (ent:IsNPC() and ent.IsNZ and att:IsNextBot() and att:LookupBone("j_spineupper") and att:LookupBone("j_ankle_ri") and !string.match(att:GetClass(), "_boss")) and dmg:GetDamage() >= ent:Health() then
        dmg:SetDamage(0)
        nzHuman:MakeDeathAnim(att, ent, true)
        return true
    end
    if ent:IsNextBot() and ent.inDeathAnimSequence == true then
        dmg:SetDamage(0)
        return true
    end
end)