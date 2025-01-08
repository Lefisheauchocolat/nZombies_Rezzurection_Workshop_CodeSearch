-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local function playRandomSound(path)
    local files, _ = file.Find("sound/" .. path .. "/*", "GAME")
    if not files or #files == 0 then return end

    local randomSound = path .. "/" .. files[math.random(#files)]
    surface.PlaySound(randomSound)
end

local function decalBlood(pos, chance)
    if not chance or chance < math.random(1,100) then return end
    util.Decal("Blood", pos+Vector(0,0,32), pos-Vector(math.random(-20,20),math.random(-20,20),100))
end

local spawnedModels = {}
local function CreateTimedScene(modelsTable, effectsTable, sceneDuration, onFinish)
    RunConsoleCommand("cl_drawhud", "0")
    local modelAnimations = {}

    for _, modelData in ipairs(modelsTable) do
        local model = ClientsideModel(modelData.model, RENDERGROUP_OPAQUE)
        if IsValid(model) then
            model:SetPos(modelData.position or Vector(0, 0, 0))
            model:SetAngles(modelData.angle or Angle(0, 0, 0))

            local sequence = model:LookupSequence(modelData.animation or "idle")
            model:ResetSequence(sequence)

            local animDuration = model:SequenceDuration(sequence)
            local startCycle = modelData.cycle or 0
            model:SetCycle(startCycle)

            if modelData.name then
                spawnedModels[modelData.name] = model
            else
                table.insert(spawnedModels, model)
            end
            table.insert(modelAnimations, {
                model = model,
                duration = animDuration,
                startTime = CurTime(),
                cycle = startCycle
            })
        end
    end

    hook.Add("CalcView", "TimedSceneCameraView", function(player, origin, angles, fov)
        local view = {}
        local cfov = 90
        local ent = spawnedModels["player"]
        if IsValid(ent) then
            local an = ent:GetSequenceName(ent:GetSequence())
            if an == "mwz_da_human_mangler_t10" then
                cfov = 70
            end
            local att = ent:GetAttachment(ent:LookupAttachment("eyes"))
            view.origin = att.Pos
            view.angles = att.Ang
            view.fov = cfov
            view.znear = 1
            return view
        end
    end)    

    hook.Add("Think", "TimedSceneAnimationUpdate", function()
        for _, animData in ipairs(modelAnimations) do
            local model = animData.model
            if IsValid(model) then
                local timeElapsed = (CurTime() - animData.startTime) % animData.duration
                local cycle = (timeElapsed / animData.duration) + animData.cycle
                model:SetCycle(cycle % 1)
            end
        end
    end)

    for delay, type in pairs(effectsTable) do
        timer.Simple(delay, function()
            local ent = spawnedModels["player"]
            local zent = spawnedModels["zombie"]
            if IsValid(ent) then
                if type == "sound" then
                    local anim = zent:GetSequenceName(zent:GetSequence())
                    if anim == "death_zombie_solo_1" then
                        surface.PlaySound("bo6/da/solo/solo_1.mp3")
                    elseif anim == "death_zombie_solo_2" then
                        surface.PlaySound("bo6/da/solo/solo_2.mp3")
                    elseif anim == "death_zombie_solo_3" then
                        surface.PlaySound("bo6/da/solo/solo_3.mp3")
                    elseif anim == "death_zombie_solo_4" then
                        surface.PlaySound("bo6/da/solo/solo_4.mp3")
                    elseif anim == "death_zombie_duo_11" then
                        surface.PlaySound("bo6/da/duo/duo_1.mp3")
                    elseif anim == "death_zombie_duo_21" then
                        surface.PlaySound("bo6/da/duo/duo_2.mp3")
                    elseif anim == "death_zombie_duo_41" then
                        surface.PlaySound("bo6/da/duo/duo_4.mp3")
                    elseif anim == "death_zombie_duo_51" then
                        surface.PlaySound("bo6/da/duo/duo_5.mp3")
                    elseif anim == "mwz_da_zombie_mangler_t10" then
                        surface.PlaySound("bo6/da/other/mangler.mp3")
                    end
                elseif type == "new_rforearm_gib" then
                    ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 6)
                    for i=1,30 do
                        if math.random(1,5) == 1 then
                            timer.Simple(i/10, function()
                                if !IsValid(ent) then return end
                                ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 3)
                            end)
                        end
                        timer.Simple(i/10, function()
                            if !IsValid(ent) then return end
                            decalBlood(ent:GetAttachment(6).Pos, 100)
                        end)
                    end
                elseif type == "new_rforearm" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 7)
                    timer.Simple(2, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 7)
                    end)
                elseif type == "new_rhand" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 8)
                    timer.Simple(2, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 8)
                    end)
                elseif type == "new_lhand" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 12)
                    timer.Simple(1, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 12)
                    end)
                elseif type == "new_rfoot" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 5)
                    timer.Simple(1, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 5)
                    end)
                elseif type == "pistol_solo_1" then
                    local prop = ClientsideModel("models/weapons/w_pist_p228.mdl")
                    prop:SetPos(ent:GetPos()-ent:GetRight()*16+ent:GetForward()*36+Vector(0,0,2))
                    prop:SetAngles(ent:GetAngles()+Angle(0,math.random(0,360),90))
                    SafeRemoveEntityDelayed(prop, 5)
                elseif type == "new_neck_bite" then
                    for i=1,30 do
                        timer.Simple(i/10, function()
                            if !IsValid(ent) then return end
                            ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 4)
                        end)
                    end
                elseif type == "neck_bite" then
                    for i=1,50 do
                        timer.Simple(i/20, function()
                            if !IsValid(ent) then return end
                            local ef = EffectData()
                            local att = ent:GetAttachment(ent:LookupAttachment("eyes"))
                            if not att then return end
                            local pos = att.Pos+att.Ang:Forward()*math.random(4,12)+att.Ang:Up()*math.random(-8,-4)+att.Ang:Right()*math.random(-8,8)
                            ef:SetOrigin(pos)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 10)
                        end)
                    end
                    LocalPlayer():ScreenFade(SCREENFADE.IN, Color(150,0,0,100), 0.5, 0) 
                    playRandomSound("bo6/da/bite")
                elseif type == "headblow" then
                    for i=1,50 do
                        timer.Simple(i/20, function()
                            if !IsValid(ent) then return end
                            local ef = EffectData()
                            local att = ent:GetAttachment(ent:LookupAttachment("eyes"))
                            if not att then return end
                            local pos = att.Pos+att.Ang:Forward()*math.random(4,6)+att.Ang:Up()*math.random(-8,-4)+att.Ang:Right()*math.random(-8,8)
                            ef:SetOrigin(pos)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 10)
                        end)
                    end
                    LocalPlayer():ScreenFade(SCREENFADE.IN, Color(120,0,0,100), 0.8, 0)
                    playRandomSound("bo6/da/blow")
                elseif type == "legblow" then
                    for i=1,20 do
                        timer.Simple(i/20, function()
                            if !IsValid(ent) then return end
                            local ef = EffectData()
                            local pos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_R_Thigh"))
                            ef:SetOrigin(pos)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 10)
                            local ef = EffectData()
                            local pos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_L_Thigh"))
                            ef:SetOrigin(pos)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 10)
                        end)
                    end
                    LocalPlayer():ScreenFade(SCREENFADE.IN, Color(120,0,0,100), 0.8, 0)
                    playRandomSound("bo6/da/blow")
                    
                    local pos, ang = zent:GetBonePosition(zent:LookupBone("j_wrist_ri"))
                    local prop = ClientsideRagdoll("models/Zombie/Classic_legs.mdl")
                    prop:SetNoDraw(false)
                    prop:DrawShadow(true)
                    prop:SetPos(zent:GetPos())
                    prop:SetAngles(zent:GetAngles())
                    for i = 0, prop:GetPhysicsObjectCount() - 1 do
                        local phys = prop:GetPhysicsObjectNum(i)
                        phys:SetPos(pos)
                    end

                    local zoment = zent
                    hook.Add("Think", prop, function()
                        if !IsValid(zoment) then
                            prop:Remove() 
                            return 
                        end
                        local pos, ang = zoment:GetBonePosition(zoment:LookupBone("j_wrist_ri"))
                        local lbone = prop:GetPhysicsObjectNum(prop:TranslateBoneToPhysBone(prop:LookupBone("ValveBiped.Bip01_L_Foot")))
                        lbone:SetPos(pos)
                        lbone:SetAngles(ang)
                    end)
                elseif type == "rhand_bite" then
                    for i=1,20 do
                        timer.Simple(i/20, function()
                            if !IsValid(ent) then return end
                            local ef = EffectData()
                            local pos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_R_Hand"))
                            ef:SetOrigin(pos)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 20)
                        end)
                    end
                    LocalPlayer():ScreenFade(SCREENFADE.IN, Color(150,0,0,100), 0.5, 0) 
                    playRandomSound("bo6/da/bite")
                elseif type == "rleg_bite" then
                    for i=1,20 do
                        timer.Simple(i/20, function()
                            if !IsValid(ent) then return end
                            local ef = EffectData()
                            local pos = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_R_Foot"))
                            ef:SetOrigin(pos)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 20)
                        end)
                    end
                    LocalPlayer():ScreenFade(SCREENFADE.IN, Color(150,0,0,100), 0.5, 0) 
                    playRandomSound("bo6/da/bite")
                elseif type == "slash_spine_blood" then
                    for i=1,100 do
                        timer.Simple(i/20, function()
                            if !IsValid(ent) then return end
                            local ef = EffectData()
                            local pos, ang = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Spine2"))
                            ef:SetOrigin(pos-ang:Right()*8)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 20)
                        end)
                    end
                    LocalPlayer():ScreenFade(SCREENFADE.IN, Color(150,0,0,100), 0.5, 0)
                    playRandomSound("bo6/da/slash") 
                elseif type == "fear" then
                    playRandomSound("bo6/da/fear")
                elseif type == "pain" then
                    playRandomSound("bo6/da/pain")
                elseif type == "touch" then
                    playRandomSound("bo6/da/touch")
                elseif type == "drop" then
                    playRandomSound("bo6/da/drop")
                elseif type == "bonebreak" then
                    playRandomSound("bo6/da/bonebreak")
                    LocalPlayer():ScreenFade(SCREENFADE.IN, Color(150,0,0,100), 0.5, 0)
                elseif type == "disciple_blast" then
                    ParticleEffectAttach("zmb_disciple_hand_blast", PATTACH_POINT_FOLLOW, zent, 11)
                    surface.PlaySound("nz_moo/zombies/vox/_sonoforda/buff/buff_wisp_00.mp3")
                elseif type == "mangler_ready" then
                    ParticleEffectAttach("hcea_hunter_ab_charge", PATTACH_POINT_FOLLOW, zent, 13)
                elseif type == "mangler_shot" then
                    zent:StopParticles()
                    ParticleEffectAttach("hcea_hunter_ab_muzzle", PATTACH_POINT_FOLLOW, zent, 13)
                elseif type == "dog_bark" then
                    playRandomSound("nz_moo/zombies/vox/_devildog/_t9/bark_v2")
                elseif type == "dog_attack" then
                    playRandomSound("nz_moo/zombies/vox/_devildog/_t9/attack")
                end
            end
        end)
    end

    timer.Simple(sceneDuration, function()
        for _, model in pairs(spawnedModels) do
            if IsValid(model) then
                model:Remove()
            end
        end

        hook.Remove("CalcView", "TimedSceneCameraView")
        hook.Remove("Think", "TimedSceneAnimationUpdate")
        game.GetWorld():RemoveAllDecals()

        if onFinish and type(onFinish) == "function" then
            onFinish()
        end
    end)
end

local function DeathCutscene(anim, data, tabpos, zmodels)
    local zmodel = zmodels[1]
    local zanimmodel = "models/bo6/hari/da_anims.mdl"
    local panimmodel = "models/bo6/hari/da_anims_human.mdl"
    if string.match(anim, "death_") then
        panimmodel = "models/bo6/exfil/human_anims.mdl"
    end
    if data.model then
        zanimmodel = data.model
    end
    if zmodel == "models/moo/_codz_ports/t5/hellhound/moo_codz_t5_devildoggo.mdl" or zmodel == "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_dog.mdl" or zmodel == "models/moo/_codz_ports/t8/escape/moo_codz_t8_devildoggo.mdl" then
        zmodel = "models/moo/_codz_ports/t9/gold/moo_codz_t9_firehazarddog.mdl"
    end
    local main_pos, main_ang = nil, Angle(0,math.random(0,360),0)
    local closestDistance = math.huge
    for _, pos in ipairs(tabpos) do
        local distance = LocalPlayer():GetPos():DistToSqr(pos)
        if distance < closestDistance then
            closestDistance = distance
            main_pos = pos
        end
    end
    if !isvector(main_pos) then return end
    local add1, add2 = "", ""
    local atab = {
        {name = "player", model = panimmodel, position = main_pos, angle = main_ang, animation = string.format(anim, "human")},
    }
    if string.match(anim, "_duo") then
        add1 = "1"
        add2 = "2"
        table.insert(atab, {name = "zombie2", model = zanimmodel, position = main_pos, angle = main_ang, animation = string.format(anim, "zombie")..add2})
    end
    table.insert(atab, {name = "zombie", model = zanimmodel, position = main_pos, angle = main_ang, animation = string.format(anim, "zombie")..add1})
    CreateTimedScene(
        atab,
        data.eff,
        data.time,
        function()
            print("Scene finished!")
        end
    )
    timer.Simple(0.1, function()
        surface.PlaySound("nz_moo/mysterybox/coldwar/zmb_magic_box_land.mp3")
        local ent = spawnedModels["player"]
        if IsValid(ent) then
            ent:SetNoDraw(true)
            local model = ClientsideModel(LocalPlayer():GetModel())
            model:SetPos(ent:GetPos())
            model:AddEffects(1)
            model:SetParent(ent)
            nzFuncs:TransformModelData(LocalPlayer(), model)
            model:ManipulateBoneScale(model:LookupBone("ValveBiped.Bip01_Head1"), Vector(0,0,0))
            table.insert(spawnedModels, model)
        end

        local ent = spawnedModels["zombie"]
        if IsValid(ent) and zmodel != "" then
            ent:SetNoDraw(true)
            local model = ClientsideModel(zmodel)
            model:SetPos(ent:GetPos())
            model:AddEffects(1)
            model:SetParent(ent)
            table.insert(spawnedModels, model)
        end

        local ent = spawnedModels["zombie2"]
        if IsValid(ent) and zmodels[2] != "" then
            ent:SetNoDraw(true)
            local model = ClientsideModel(zmodels[2])
            model:SetPos(ent:GetPos())
            model:AddEffects(1)
            model:SetParent(ent)
            table.insert(spawnedModels, model)
        end
    end)
    timer.Simple(data.time-0.05, function()
        LocalPlayer():ScreenFade(SCREENFADE.OUT, color_black, 0.05, 5)
        surface.PlaySound("bo6/da/death.mp3")
    end)
    timer.Simple(data.time+5, function()
        RunConsoleCommand("cl_drawhud", "1")
    end)
end

net.Receive("nZr.DACutscene", function()
    local str = net.ReadString()
    local data = net.ReadTable()
    local vecs = net.ReadTable()
    local models = net.ReadTable()
    DeathCutscene(str, data, vecs, models)
end)