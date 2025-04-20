-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local darkScreenMat = Material("bo6/da/dark.png")

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

local function takeThisIntoPhys(ent, name)
    local wep = ents.CreateClientProp(ent:GetModel())
    wep:SetAngles(ent:GetAngles())
    wep:SetPos(ent:GetPos())
    wep:Spawn()
    wep:GetPhysicsObject():Wake()

    spawnedModels[name] = wep
    ent:Remove()
    SafeRemoveEntityDelayed(wep, 15)

    return wep
end

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

    local fovTab = {
        ["mwz_da_human_amalgam"] = 80,
        ["mwz_da_human_ghoul"] = 70,
        ["mwz_da_human_mangler_t10"] = 70,
        ["mwz_da_human_vermin_1"] = 60,
    }
    local animName = spawnedModels["player"]:GetSequenceName(spawnedModels["player"]:GetSequence())
    hook.Add("CalcView", "TimedSceneCameraView", function(player, origin, angles, fov)
        local view = {}
        local cfov = 90
        local ent = spawnedModels["player"]
        if IsValid(ent) then
            local att = ent:GetAttachment(ent:LookupAttachment("eyes"))
            local an = ent:GetSequenceName(ent:GetSequence())
            animName = an
            
            if fovTab[an] then
                cfov = fovTab[an]
            end

            local bool = render.GetLightColor(att.Pos):Length() < 0.005
            if bool then
                local dlight = DynamicLight( LocalPlayer():EntIndex() )
                if dlight then
                    dlight.pos = att.Pos
                    dlight.r = 220
                    dlight.g = 40
                    dlight.b = 40
                    dlight.brightness = 0.1
                    dlight.decay = 1000
                    dlight.size = 256
                    dlight.dietime = CurTime() + 1
                end
            end

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
                    elseif anim == "death_zombie_duo_31" then
                        surface.PlaySound("bo6/da/duo/duo_3.mp3")
                    elseif anim == "death_zombie_duo_41" then
                        surface.PlaySound("bo6/da/duo/duo_4.mp3")
                    elseif anim == "death_zombie_duo_51" then
                        surface.PlaySound("bo6/da/duo/duo_5.mp3")
                    elseif anim == "mwz_da_zombie_mangler_t10" then
                        surface.PlaySound("bo6/da/other/mangler.mp3")
                    elseif anim == "mwz_da_zombie_abom" then
                        surface.PlaySound("bo6/da/other/abom.mp3")
                    elseif anim == "mwz_da_zombie_amalgam" then
                        surface.PlaySound("bo6/da/other/amalgam.mp3")
                    elseif anim == "mwz_da_zombie_ghoul" then
                        surface.PlaySound("bo6/da/other/ghoul.mp3")
                    elseif anim == "mwz_da_zombie_mimic" then
                        surface.PlaySound("bo6/da/other/mimic.mp3")
                    elseif anim == "mwz_da_zombie_parasite1" then
                        surface.PlaySound("bo6/da/other/parasite.mp3")
                    elseif anim == "mwz_da_zombie_vermin_1" then
                        surface.PlaySound("bo6/da/other/vermin1.mp3")
                    elseif anim == "mwz_da_zombie_vermin_21" then
                        surface.PlaySound("bo6/da/other/vermin2.mp3")
                    end
                elseif type == "abom_eff" then
                    local color = Color(95,10,255)
                    zent.Mouth1 = CreateParticleSystem(zent, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 11)
                    zent.Mouth2 = CreateParticleSystem(zent, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 12)
                    zent.Mouth3 = CreateParticleSystem(zent, "zmb_mimic_mouth", PATTACH_POINT_FOLLOW, 13)
                    zent.Mouth1:SetControlPoint(2, Vector(color.r/255, color.g/255, color.b/255))
                    zent.Mouth2:SetControlPoint(2, Vector(color.r/255, color.g/255, color.b/255))
                    zent.Mouth3:SetControlPoint(2, Vector(color.r/255, color.g/255, color.b/255))
                elseif type == "pistol_in_hand" then
                    local model = "models/bo6/wep/w_pist_p228.mdl"
                    local lpos = Vector(0.75,0.75,-2.2)
                    local wep = ents.CreateClientside("base_anim")
                    local attach = ent:GetAttachment(ent:LookupAttachment("anim_attachment_RH"))
                    if attach then
                        wep:SetModel(model)
                        wep:Spawn()
                        wep:SetModelScale(0.9)
                        wep:SetPos(Vector(0,0,-9999))
                        wep:SetAngles(attach.Ang)
                        wep:SetParent(ent, ent:LookupAttachment("anim_attachment_RH"))
                        wep:SetLocalAngles(Angle(0,20,0))
                        wep:SetLocalPos(lpos)
                        spawnedModels["pistol"] = wep
                    else
                        wep:Remove()
                    end
                elseif type == "human_rifle_hand" then
                    SafeRemoveEntity(spawnedModels["rifle_human"])
                    local lpos = Vector(10,2,-4)
                    local wep = ents.CreateClientside("base_anim")
                    local attach = zent:GetAttachment(zent:LookupAttachment("anim_attachment_RH"))
                    wep:SetModel("models/bo6/wep/w_rif_m4a1.mdl")
                    wep:Spawn()
                    wep:SetPos(Vector(0,0,-9999))
                    wep:SetAngles(attach.Ang)
                    wep:SetParent(zent, zent:LookupAttachment("anim_attachment_RH"))
                    wep:SetLocalAngles(Angle(0,15,0))
                    wep:SetLocalPos(lpos)
                    spawnedModels["rifle_human"] = wep
                elseif type == "human_rifle_chest" then
                    SafeRemoveEntity(spawnedModels["rifle_human"])
                    local lpos = Vector(8,0,-14)
                    local wep = ents.CreateClientside("base_anim")
                    local attach = zent:GetAttachment(zent:LookupAttachment("chest"))
                    wep:SetModel("models/bo6/wep/w_rif_m4a1.mdl")
                    wep:Spawn()
                    wep:SetPos(Vector(0,0,-9999))
                    wep:SetAngles(attach.Ang)
                    wep:SetParent(zent, zent:LookupAttachment("chest"))
                    wep:SetLocalAngles(Angle(0,70,0))
                    wep:SetLocalPos(lpos)
                    spawnedModels["rifle_human"] = wep
                elseif type == "human_rifle_fire" then
                    local p = spawnedModels["rifle_human"]
                    for i=1,3 do
                        timer.Simple(i/9, function()
                            if !IsValid(p) then return end
                            local attach = p:GetAttachment(p:LookupAttachment("muzzle"))
                            if attach then
                                ParticleEffectAttach("ins_muzzleflash_makarov_3rd", PATTACH_POINT_FOLLOW, p, p:LookupAttachment("muzzle"))
                            end
                            nzEffects:ApplyDamageEffect(3)
                            LocalPlayer():EmitSound("bo6/da/other/rifle.wav", 0, math.random(80,110))
                            local ef = EffectData()
                            local pos, ang = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Head1"))
                            ef:SetOrigin(pos-ang:Right()*1)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 20)
                        end)
                    end
                elseif type == "pistol_muzzle" then
                    local p = spawnedModels["pistol"]
                    if IsValid(p) then
                        local attach = p:GetAttachment(p:LookupAttachment("muzzle"))
                        if attach then
                            ParticleEffectAttach("ins_muzzleflash_makarov_3rd", PATTACH_POINT_FOLLOW, p, p:LookupAttachment("muzzle"))
                        end
                    end
                elseif type == "pistol_vermin_throw" then
                    local p = spawnedModels["pistol"]
                    if IsValid(p) then
                        local ent = spawnedModels["player"]
                        local wep = takeThisIntoPhys(p, "pistol")
                        if IsValid(wep) then
                            local phys = wep:GetPhysicsObject()
                            if IsValid(phys) then
                                phys:SetVelocity(ent:GetForward()*-256+ent:GetRight()*256)
                                phys:SetAngleVelocity(ent:GetRight()*1000+ent:GetForward()*-400)
                            end
                            timer.Simple(0.1, function()
                                if !IsValid(phys) then return end
                                phys:SetVelocity(ent:GetForward()*48+Vector(0,0,200))
                                phys:SetAngleVelocity(ent:GetRight()*-800)
                            end)
                        end
                    end
                elseif type == "pistol_vermin_1" then
                    local prop = ClientsideModel("models/bo6/wep/w_pist_p228.mdl")
                    prop:SetPos(ent:GetPos()-ent:GetRight()*140+ent:GetForward()*10+Vector(0,0,0.5))
                    prop:SetAngles(ent:GetAngles()+Angle(0,math.random(0,360),90))
                    SafeRemoveEntityDelayed(prop, 5)
                elseif type == "amalgam_hands" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 11)
                    nzEffects:ApplyDamageEffect(2)
                    timer.Simple(1.05, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 10)
                        nzEffects:ApplyDamageEffect(2)
                    end)
                elseif type == "new_lhand2" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 7)
                    timer.Simple(0.5, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 7)
                    end)
                    nzEffects:ApplyDamageEffect(1)
                elseif type == "new_spine4" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, math.random(2,3))
                    nzEffects:ApplyDamageEffect(1)
                elseif type == "new_mimic_spine4" then
                    ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, zent, 1)
                    for i=1,4 do
                        timer.Simple(i/1, function()
                            if !IsValid(zent) then return end
                            ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, zent, 1)
                            ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, zent, 1)
                        end)
                        timer.Simple(i-1, function()
                            if !IsValid(zent) then return end
                            for i=1,5 do
                                decalBlood(zent:GetAttachment(1).Pos, 100)
                            end
                            if i == 4 then
                                nzEffects:ApplyDamageEffect(4)
                            else
                                nzEffects:ApplyDamageEffect(3)
                            end
                        end)
                    end
                elseif type == "lhand_gib" then
                    ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, zent, 12)
                    for i=1,10 do
                        if math.random(1,5) == 1 then
                            timer.Simple(i/10, function()
                                if !IsValid(zent) then return end
                                ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, zent, 12)
                            end)
                        end
                        timer.Simple(i/10, function()
                            if !IsValid(zent) then return end
                            decalBlood(zent:GetAttachment(12).Pos, 100)
                            if i == 10 then
                                nzEffects:ApplyDamageEffect(3)
                            end
                        end)
                    end
                elseif type == "new_rforearm_gib" then
                    for i=1,30 do
                        timer.Simple(i/10, function()
                            if !IsValid(ent) then return end
                            local att = ent:GetAttachment(4)
                            local pos = att.Pos
                            local e = EffectData()
                            e:SetOrigin(pos)
                            util.Effect("bo6_da_pool", e)
                            ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 6)
                        end)
                    end
                    nzEffects:ApplyDamageEffect(3)
                elseif type == "new_rforearm" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 7)
                    timer.Simple(2, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 7)
                    end)
                    nzEffects:ApplyDamageEffect(1)
                elseif type == "new_rhand" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 8)
                    timer.Simple(2, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 8)
                    end)
                    nzEffects:ApplyDamageEffect(1)
                elseif type == "new_rhand_simple" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 8)
                    nzEffects:ApplyDamageEffect(1)
                elseif type == "new_lhand" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 12)
                    timer.Simple(1, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 12)
                    end)
                    nzEffects:ApplyDamageEffect(1)
                elseif type == "new_rfoot" then
                    ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, ent, 5)
                    timer.Simple(1, function()
                        if !IsValid(ent) then return end
                        ParticleEffectAttach("ins_blood_dismember_limb", PATTACH_POINT_FOLLOW, ent, 5)
                    end)
                    nzEffects:ApplyDamageEffect(1)
                elseif type == "pistol_solo_1" then
                    local prop = ClientsideModel("models/bo6/wep/w_pist_p228.mdl")
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
                    nzEffects:ApplyDamageEffect(3)
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
                    nzEffects:ApplyDamageEffect(3)
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
                    nzEffects:ApplyDamageEffect(3)
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
                    nzEffects:ApplyDamageEffect(3)
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
                    nzEffects:ApplyDamageEffect(1)
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
                    nzEffects:ApplyDamageEffect(1)
                    playRandomSound("bo6/da/bite")
                elseif type == "slash_spine_blood" then
                    for i=1,25 do
                        timer.Simple(i/5, function()
                            if !IsValid(ent) then return end
                            local pos, ang = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Spine"))
                            ang.x = ang.x + 90
                            ParticleEffect("ins_blood_impact_headshot", pos, ang, ent)
                            decalBlood(pos, 20)
                        end)
                    end
                    nzEffects:ApplyDamageEffect(3)
                    playRandomSound("bo6/da/slash") 
                elseif type == "headbeat" then
                    for i=1,4 do
                        timer.Simple(i/20, function()
                            if !IsValid(ent) then return end
                            local ef = EffectData()
                            local pos, ang = ent:GetBonePosition(ent:LookupBone("ValveBiped.Bip01_Head1"))
                            ef:SetOrigin(pos-ang:Right()*1)
                            util.Effect("BloodImpact", ef)
                            decalBlood(pos, 20)
                        end)
                    end
                    nzEffects:ApplyDamageEffect(1)
                    playRandomSound("bo6/da/beat") 
                elseif type == "brutus_gear" then
                    playRandomSound("nz_moo/zombies/vox/_bruiser/gear") 
                elseif type == "brutus_swing" then
                    playRandomSound("nz_moo/zombies/vox/_bruiser/swing") 
                elseif type == "brutus_over" then
                    surface.PlaySound("nz_moo/zombies/vox/_bruiser/voicelines/vox_brutus_brutus_attacks_d_"..math.random(1,15)..".mp3")
                --[[elseif type == "fear" then
                    playRandomSound("bo6/da/fear")
                elseif type == "pain" then
                    playRandomSound("bo6/da/pain")]]
                elseif type == "touch" then
                    playRandomSound("bo6/da/touch")
                elseif type == "drop" then
                    playRandomSound("bo6/da/drop")
                elseif type == "bonebreak" then
                    playRandomSound("bo6/da/bonebreak")
                    nzEffects:ApplyDamageEffect(1)
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

    hook.Add("HUDPaint", "TimedSceneCameraHUD", function()
        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(darkScreenMat)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
    end)

    timer.Simple(sceneDuration, function()
        for _, model in pairs(spawnedModels) do
            if IsValid(model) then
                model:Remove()
            end
        end

        hook.Remove("HUDPaint", "TimedSceneCameraHUD")
        hook.Remove("CalcView", "TimedSceneCameraView")
        hook.Remove("Think", "TimedSceneAnimationUpdate")
        game.GetWorld():RemoveAllDecals()

        if onFinish and type(onFinish) == "function" then
            onFinish()
        end
    end)
end

local function DeathCutscene(anim, data, tabpos, zmodels, mapmodels)
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
    elseif anim == "mwz_da_%s_abom" then
        zmodel = "models/bo6/hari/da/abom.mdl"
    elseif anim == "mwz_da_%s_mimic" then
        zmodel = "models/bo6/hari/da/mimic.mdl"
    elseif anim == "mwz_da_%s_ghoul" then
        zmodel = "models/bo6/hari/da/ghoul.mdl"
    end
    local main_pos, main_ang = nil, Angle(0,math.random(0,360),0)
    local closestDistance = math.huge
    for _, tb in ipairs(tabpos) do
        local distance = LocalPlayer():GetPos():DistToSqr(tb[1])
        if distance < closestDistance then
            closestDistance = distance
            main_pos = tb[1]
            main_ang = tb[2]
        end
    end
    if !isvector(main_pos) then return end
    local add1 = ""
    main_ang = main_ang+Angle(0,data.yaw,0)
    local atab = {
        {name = "player", model = panimmodel, position = main_pos, angle = main_ang, animation = string.format(anim, "human")},
    }
    if string.match(anim, "_duo") or anim == "mwz_da_%s_vermin_2" then
        add1 = "1"
        table.insert(atab, {name = "zombie2", model = zanimmodel, position = main_pos, angle = main_ang, animation = string.format(anim, "zombie").."2"})
    end
    if anim == "mwz_da_%s_parasite" then
        add1 = "1"
        table.insert(atab, {name = "zombie2", model = zanimmodel, position = main_pos, angle = main_ang, animation = string.format(anim, "zombie").."2"})
        table.insert(atab, {name = "zombie3", model = zanimmodel, position = main_pos, angle = main_ang, animation = string.format(anim, "zombie").."3"})
    end
    if anim == "mwz_da_%s_mimic" then
        table.insert(atab, {name = "zombie_mimic1", model = "models/bo6/exfil/zombie_anims.mdl", position = main_pos, angle = main_ang, animation = "death_zombie_mimic_1"})
        table.insert(atab, {name = "zombie_mimic2", model = "models/bo6/exfil/zombie_anims.mdl", position = main_pos, angle = main_ang, animation = "death_zombie_mimic_2"})
        table.insert(atab, {name = "zombie_mimic3", model = "models/bo6/exfil/zombie_anims.mdl", position = main_pos, angle = main_ang, animation = "death_zombie_mimic_3"})
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
    timer.Simple(0.01, function()
        surface.PlaySound("bo6/da/start.mp3")
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
        if IsValid(ent) and zmodels[2] != "" and (anim != "mwz_da_%s_vermin_2" and anim != "mwz_da_%s_parasite") then
            ent:SetNoDraw(true)
            local model = ClientsideModel(zmodels[2])
            model:SetPos(ent:GetPos())
            model:AddEffects(1)
            model:SetParent(ent)
            table.insert(spawnedModels, model)
        end

        for i=1,3 do
            local ent = spawnedModels["zombie_mimic"..i]
            local tab = table.Random(mapmodels)
            if IsValid(ent) and tab.Model then
                ent:SetNoDraw(true)
                local model = ClientsideModel(tab.Model)
                model:SetPos(ent:GetPos())
                model:AddEffects(1)
                model:SetParent(ent)
                table.insert(spawnedModels, model)
            end
        end
    end)
    timer.Simple(data.time-0.1, function()
        LocalPlayer():ScreenFade(SCREENFADE.OUT, color_black, 0.05, 5)
        surface.PlaySound("bo6/da/death.mp3")
        if nzSettings:GetSimpleSetting("DeathAnim_Laugh", false) then
            surface.PlaySound(")"..nzSounds:GetSound("Laugh"))
        end
        nzEffects:ApplyDamageEffect(1, 0)
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
    local mmodels = net.ReadTable()
    DeathCutscene(str, data, vecs, models, mmodels)
end)