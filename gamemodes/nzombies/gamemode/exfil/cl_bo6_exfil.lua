-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!
-- hud scaling fix done by latte, i hate working with the hud i think

local screenAspect = ScrW() / ScrH()

local function We(x)
    return (x / 1920) * ScrW()
end

local function He(y)
    return (y / 1080) * ScrH()
end

function ScaleToAspect(origWidth, origHeight, maxWidth, maxHeight) 
    local aspectRatio = origWidth / origHeight
    local scaleWidth, scaleHeight

    if maxWidth / maxHeight > aspectRatio then
        scaleWidth = maxHeight * aspectRatio
        scaleHeight = maxHeight
    else
        scaleWidth = maxWidth
        scaleHeight = maxWidth / aspectRatio
    end

    return scaleWidth, scaleHeight
end

local timeRemaining = 90
local zombiesRemaining = 0
local hudActive = false
local currentStage = 1

local taskIcon = Material("bo6/other/task.png")
local exfilIcon1 = Material("bo6/exfil/icon_call.png", "mips")
local exfilIcon2 = Material("bo6/exfil/icon_heli.png", "mips")
local exfilIconAv = Material("bo6/exfil/icon_radio.png", "mips")
local exfilBg = Material("bo6/exfil/exfil_bg.png")
local exfilBg2 = Material("bo6/exfil/exfil_bg2.png")
local exfilBg_mes = Material("bo6/exfil/exfil_bg_message.png")

surface.CreateFont("BO6_Exfil96", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(96),
})

surface.CreateFont("BO6_Exfil40", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(40),
})

surface.CreateFont("BO6_Exfil32", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(32),
})

surface.CreateFont("BO6_Exfil32_2", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(32),
    shadow = true,
})

surface.CreateFont("BO6_Exfil26", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(26),
})

surface.CreateFont("BO6_Exfil24", {
    font = "KairosSansW06-CondMedium",
	extended = true,
	size = He(24),
})

surface.CreateFont("BO6_Exfil18", {
    font = "Core Sans D 35 Regular",
	extended = true,
	size = He(18),
})

local function RemoveExfilHUD()
    hudActive = false
    timer.Remove("BO6HUDTimer")
end

local function StartExfilHUD(duration, stage)
    timeRemaining = duration or 65
    currentStage = stage or 1
    hudActive = true
    timer.Create("BO6HUDTimer", 1, timeRemaining, function()
        timeRemaining = timeRemaining - 1
        if timeRemaining <= 0 then
            RemoveExfilHUD()
        end
    end)
end

hook.Add("HUDPaint", "DrawCustomHUD", function()
    if not hudActive then return end

    local x, y, width, height = We(50), He(200), We(300), He(150)

    local x, y = We(50), He(200)
    local maxWidth, maxHeight = We(300), He(150)
    local bgWidth, bgHeight = ScaleToAspect(1920, 1080, maxWidth, maxHeight)

    surface.SetDrawColor(200, 190, 0, 175)
    surface.SetMaterial(exfilBg)
    surface.DrawTexturedRect(x, y, bgWidth, bgHeight)

    local iconMaxWidth, iconMaxHeight = We(40), He(40)
    local iconWidth, iconHeight = ScaleToAspect(64, 64, iconMaxWidth, iconMaxHeight)

    surface.SetDrawColor(255, 125, 0, 255)
    surface.SetMaterial(taskIcon)
    surface.DrawTexturedRect(x - iconWidth / 2, y - iconHeight / 2, iconWidth, iconHeight)

    local objectiveText = ""
    if currentStage == 1 then
        objectiveText = "Reach the exfil site."
    elseif currentStage == 2 then
        objectiveText = "Clear the exfil site."
    elseif currentStage == 3 then
        objectiveText = "Enter Heli and Escape."
    end

    draw.SimpleText(objectiveText, "BO6_Exfil24", x + We(10), y + He(10), Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)

    if currentStage != 3 then
        draw.SimpleText("Zombies Remaining:", "BO6_Exfil24", x + We(10), y + He(55), Color(255, 255, 255, 255), TEXT_ALIGN_LEFT)
        draw.SimpleText(tostring(zombiesRemaining), "BO6_Exfil24", x + width - We(40), y + He(55), Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT)
    end

    local timeBarX, timeBarY, timeBarW, timeBarH = We(55), He(310), We(290), He(30)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.SetMaterial(exfilBg2)
    surface.DrawTexturedRect(timeBarX, timeBarY, timeBarW, timeBarH)

    draw.SimpleText("Time Remaining", "BO6_Exfil24", timeBarX + We(10), timeBarY + He(5), Color(255, 200, 0, 255), TEXT_ALIGN_LEFT)
    draw.SimpleText(string.ToMinutesSeconds(timeRemaining), "BO6_Exfil24", timeBarX + timeBarW - We(10), timeBarY + He(5), Color(255, 200, 0, 255), TEXT_ALIGN_RIGHT)
end)

net.Receive("nZr.ExfilTimer", function()
    local time = net.ReadInt(32)
    local state = net.ReadInt(32)
    zombiesRemaining = net.ReadInt(32)
    local disable = net.ReadBool()
    if disable then
        RemoveExfilHUD()
    else
        StartExfilHUD(time, state)
    end
end)

local currentSound

local function playRandomMusic()
    if currentSound then
        currentSound:Stop()
        currentSound = nil
    end

    local song = "sound/"..nzSettings:GetSimpleSetting("ExfilMusic", "bo6/exfil/music.mp3")
    sound.PlayFile(song, "noblock", function(soundChannel, errID, errName)
        if IsValid(soundChannel) then
            currentSound = soundChannel
            currentSound:SetVolume(1)
        end
    end)
end

local delay = 0
hook.Add("Think", "BO6CheckPlayMusic", function()
    if delay-CurTime() > 0 then return end
    delay = CurTime()+1
    if hudActive and not IsValid(currentSound) then
        playRandomMusic()
    elseif not hudActive and IsValid(currentSound) then
        currentSound:Stop()
        currentSound = nil
    end
end)

----------------------------------------------------
-------------BO6 Character Replics Part------------
----------------------------------------------------

local subtitlesTab = {
    ["missed1.mp3"] = "Hey, something came up, we can't come anymore. You'll have to wait a few.",
    ["missed2.mp3"] = "Sorry guys, you missed your chance this time, you'll have to hold out for a lot longer.",
    ["missed3.mp3"] = "You guts missed your window we're gonna have to wait for another one.",
    ["missed4.mp3"] = "Looks like you missed your stop, we'll try to come around back as soon as we can.",

    ["ready1.mp3"] = "We're ready to come pick you up, just tell us when.",
    ["ready2.mp3"] = "We're ready on our end, let us know when.",
    ["ready3.mp3"] = "Call us when you're ready, we're available to pick you up.",
    ["ready4.mp3"] = "We're ready to come get you when you are.",

    ["Arriving1.mp3"] = "I'll be there in about some minutes.",
    ["Arriving2.mp3"] = "Hold tight, we'll be there shortly.",
    ["Arriving3.mp3"] = "We're almost there, keep the area clear!",
    ["Arriving4.mp3"] = "Eyes to the skies gentlemen, we'll be there soon.",
    
    ["Clear1.mp3"] = "Clear the extraction point, we can't get a clear landing!",
    ["Clear2.mp3"] = "There's too many of them, we can't land like this.",
    ["Clear3.mp3"] = "Clear the area! We can't get down!",
    ["Clear4.mp3"] = "Clear the area out! We can't land like this.",
    
    ["Land1.mp3"] = "We're down, come on! Hurry up!",
    ["Land2.mp3"] = "Hurry up, make it fast!",
    ["Land3.mp3"] = "We can't hold on for long down here, hurry up!",
    ["Land4.mp3"] = "Faster, come on hurry up we have to get out of here!",

    ["hurry1.mp3"] = "Hurry up, we can't stay here long!",
    ["hurry2.mp3"] = "Come on, there's no time to waste we cant stick around!",
    ["hurry3.mp3"] = "Stop screwing around, hurry up!",
    ["hurry4.mp3"] = "We don't have much time guys, come on!",
    
    ["Leave1.mp3"] = "Okay, looks like we've got everyone. Come on, we're getting out of here.",
    ["Leave2.mp3"] = "Everyone on board and we're heading out.",
    ["Leave3.mp3"] = "Looks like everyone's here, let's go.",
    ["Leave4.mp3"] = "Ugh, that was close, don't ya'll think?",
    
    ["Loss1.mp3"] = "Shit! We didn't get anyone! Fucking hell...",
    ["Loss2.mp3"] = "Dammit! We couldn't help them...",
    ["Loss3.mp3"] = "Extraction failed, we couldn't get 'em.",
    ["Loss4.mp3"] = "May your deaths not be in vain... Let's go...",

    ["damage1.mp3"] = "Gah! These sons a bitches are tearin' right through this thing!",
    ["damage2.mp3"] = "Get these dead sons a bitches off the helicopter!",
    ["damage3.mp3"] = "They're tearin right through this thing!",
    ["damage4.mp3"] = "Keep them off of me, they destroy this thing, we're all screwed!",

    ["destruction1.mp3"] = "Augh, son of a bitch!",
    ["destruction2.mp3"] = "Oh, God dammit!",
    ["destruction3.mp3"] = "Agh! Shit they destroyed this thing!",
    ["destruction4.mp3"] = "No! Grgaa-",
}

local activeDialog = {
    name = "",
    text = "",
    icon = nil,
    sound = nil,
    endTime = 0
}

local voiceOvers = {
    ["Exfil_Unavailable"] = {"missed1.mp3", "missed2.mp3", "missed3.mp3", "missed4.mp3"},
    ["Exfil_Available"] = {"ready1.mp3", "ready2.mp3", "ready3.mp3", "ready4.mp3"},
    ["Exfil_Arriving"] = {"Arriving1.mp3","Arriving2.mp3","Arriving3.mp3","Arriving4.mp3"},
    ["Exfil_Clearing"] = {"Clear1.mp3","Clear2.mp3","Clear3.mp3","Clear4.mp3"},
    ["Exfil_GetIn"] = {"Land1.mp3","Land2.mp3","Land3.mp3","Land4.mp3"},
    ["Exfil_Faster"] = {"hurry1.mp3", "hurry2.mp3", "hurry3.mp3", "hurry4.mp3"},
    ["Exfil_Success"] = {"Leave1.mp3","Leave2.mp3","Leave3.mp3","Leave4.mp3"},
    ["Exfil_Fail"] = {"Loss1.mp3","Loss2.mp3","Loss3.mp3","Loss4.mp3"},
    ["Exfil_Damage"] = {"damage1.mp3", "damage2.mp3", "damage3.mp3", "damage4.mp3"},
    ["Exfil_Destroyed"] = {"destruction1.mp3", "destruction2.mp3", "destruction3.mp3", "destruction4.mp3"},
}

local function DisplayCharacterDialog(name, iconPath, soundPath)
    local text = subtitlesTab[soundPath] or "???"
    activeDialog.name = name
    activeDialog.text = text
    activeDialog.icon = Material(iconPath)
    activeDialog.endTime = CurTime() + #text/12
    if soundPath then
        surface.PlaySound("bo6/exfil/vox/pilot/"..soundPath)
    end
end

local function PlayDialog(voiceover)
    local tab = voiceOvers[voiceover]
    if istable(tab) and string.match(voiceover, "Exfil_") then
        DisplayCharacterDialog("Raptor One", "bo6/exfil/pilot.png", table.Random(tab))
    end
end

function nz_AddCustomDialog(name, path, dialog)
    if voiceOvers[name] then
        table.insert(voiceOvers[name], path)
    else
        voiceOvers[name] = {}
        table.insert(voiceOvers[name], path)
    end
    subtitlesTab[path] = dialog
end

function nz_PlayCustomDialog(name, icon, voiceover)
    local tab = voiceOvers[voiceover]
    if istable(tab) then
        DisplayCharacterDialog(name, icon, table.Random(tab))
    end
end

hook.Add("HUDPaint", "BO6DrawCharacterDialog", function()
    if CurTime() > activeDialog.endTime then return end
    local screenW, screenH = ScrW(), ScrH()
    local nameColor = Color(255, 255, 255)
    local dialogX = screenW / 2
    local dialogY = screenH / 1.3
    local iconMaxWidth, iconMaxHeight = We(700 / 4), He(1076 / 4)
    local iconWidth, iconHeight = ScaleToAspect(700, 1076, iconMaxWidth, iconMaxHeight)
    local iconX = screenW - iconWidth - We(50)
    local iconY = screenH / 2 - iconHeight / 2 - He(25)
    if activeDialog.icon then
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(activeDialog.icon)
        surface.DrawTexturedRect(iconX, iconY, iconWidth, iconHeight)
    end
    draw.SimpleText(string.upper(activeDialog.name), "BO6_Exfil32", iconX + iconWidth / 2, iconY + iconHeight + He(10), nameColor, TEXT_ALIGN_CENTER)
    local markupText = markup.Parse("<font=BO6_Exfil32_2><color=60,165,255>" .. activeDialog.name..": " .. "</color> " .. activeDialog.text .. "</font>")
    markupText:Draw(dialogX, dialogY, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

net.Receive("nZr.ExfilVoice", function()
    local voiceover = net.ReadString()
    PlayDialog(voiceover)
end)
----------------------------------------------------
-----------------BO6 Exfil Point Part---------------
----------------------------------------------------
local exfilMat = exfilIcon2
local exfilText = ""

local function DrawExfilIcon(pos, isActive)
    if not isActive then return end

    local screenPos = pos:ToScreen()

    if screenPos.visible then
        local playerPos = LocalPlayer():GetPos()
        local distance = math.Round(playerPos:Distance(pos)/75)

        cam.Start2D()
            draw.SimpleText(exfilText, "BO6_Exfil26", screenPos.x, screenPos.y - 32, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
            draw.SimpleText(tostring(distance) .. "m", "BO6_Exfil18", screenPos.x, screenPos.y + 36, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(exfilMat)
            surface.DrawTexturedRect(screenPos.x - 32, screenPos.y - 32, 64, 64)
        cam.End2D()
    end
end

local exfilPosition = Vector(0, 0, 0)
local exfilActive = false
hook.Add("HUDPaint", "DrawExfilIconHook", function()
    if !GetConVar("cl_drawhud"):GetBool() then return end
    DrawExfilIcon(exfilPosition, exfilActive)
end)

net.Receive("nZr.ExfilPosition", function()
    exfilActive = net.ReadBool()
    exfilPosition = net.ReadVector()
    exfilType = net.ReadInt(32)
    if exfilType == 1 then
        exfilMat = exfilIcon1
        exfilText = "EXFIL"
    elseif exfilType == 2 then
        exfilMat = exfilIcon2
        exfilText = ""
    end
end)

----------------------------------------------------
-----------------BO6 Message Part-------------------
----------------------------------------------------

local function callDrawingMessage(type)
    local text = "NEW EXFIL AVAILABLE"
    local icon = exfilIconAv
    local delay = 4

    local alpha = 0
    local state = true
    timer.Simple(delay, function()
        state = false
    end)

    hook.Add("HUDPaint", "ExfilDrawMessage", function()
        if GetConVar("cl_drawhud"):GetBool() then

            surface.SetDrawColor(255,255,255,alpha)
            surface.SetMaterial(exfilBg_mes)
            surface.DrawTexturedRect(ScrW()/2-We(300), He(200), We(600), He(50))

            draw.SimpleText(text, "BO6_Exfil40", ScrW()/2, He(225), Color(225,175,0,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            local iconMaxSize = We(128)
            local iconWidth, iconHeight = ScaleToAspect(64, 64, iconMaxSize, iconMaxSize)

            surface.SetDrawColor(255, 255, 255, alpha)
            surface.SetMaterial(icon)
            surface.DrawTexturedRect(ScrW() / 2 - iconWidth / 2, He(70), iconWidth, iconHeight)
        end

        if not state and alpha <= 0 then
            hook.Remove("HUDPaint", "ExfilDrawMessage")
        elseif not state then
            alpha = alpha - FrameTime() * 256
        else
            alpha = alpha + FrameTime() * 256
        end
    end)
end

net.Receive("nZr.ExfilMessage", function()
    local type = net.ReadInt(32)
    callDrawingMessage(type)
end)

----------------------------------------------------
-----------------BO6 Cutscene Part------------------
----------------------------------------------------

local modelAnimations = {}
local spawnedModels = {}
local function CreateTimedScene(modelsTable, soundTable, sceneDuration, onFinish)
    for _, modelData in ipairs(modelsTable) do
        local model = ClientsideModel(modelData.model)
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
                modelAnimations[modelData.name] = {
                    model = model,
                    duration = animDuration,
                    startTime = CurTime(),
                    cycle = startCycle
                }
            else
                table.insert(spawnedModels, model)
                table.insert(modelAnimations, {
                    model = model,
                    duration = animDuration,
                    startTime = CurTime(),
                    cycle = startCycle
                })
            end
        end
    end

    hook.Add("CalcView", "TimedSceneCameraView", function(player, origin, angles, fov)
        local view = {}
        local cam = spawnedModels["Camera"]
        if IsValid(cam) then
            local num = 1
            local addang = Angle(0,0,0)
            if cam:GetSequenceName(cam:GetSequence()) == "exfil_cam_fail_2" then
                num = 2
            elseif cam:GetSequenceName(cam:GetSequence()) == "exfil_cam_fail_3" then
                num = 2
            elseif cam:GetSequenceName(cam:GetSequence()) == "exfil_cam_success_1" then
                num = 2
            elseif cam:GetSequenceName(cam:GetSequence()) == "exfil_cam_success_2" then
                num = 2
                addang = Angle(-10,0,0)
            elseif cam:GetSequenceName(cam:GetSequence()) == "exfil_cam_success_3" then
                num = 2
            end
            local att = cam:GetAttachment(num)
            view.origin = att.Pos
            view.angles = att.Ang+addang
            view.fov = 50
        
            return view
        end
    end)    

    hook.Add("Think", "TimedSceneAnimationUpdate", function()
        for name, animData in pairs(modelAnimations) do
            local model = animData.model
            if IsValid(model) then
                local timeElapsed = (CurTime() - animData.startTime) % animData.duration
                local cycle = (timeElapsed / animData.duration) + animData.cycle
                model:SetCycle(cycle % 1)
                if name == "Heli" then
                    model:ManipulateBoneAngles(25, model:GetManipulateBoneAngles(25)+Angle(0,2,0))
                    model:ManipulateBoneAngles(40, model:GetManipulateBoneAngles(40)+Angle(0,0,-2))
                end
            else
                table.RemoveByValue(modelAnimations, animData)
                break
            end
        end
    end)

    for delay, soundPath in pairs(soundTable) do
        timer.Simple(delay, function()
            if soundPath then
                surface.PlaySound(soundPath)
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

        if onFinish and type(onFinish) == "function" then
            onFinish()
        end
    end)
end

main_heli_pos = Vector(-1452, 259, -83)
main_heli_ang = Angle(0,270,0)

local function GetPlayerTable(limit)
    local players = {}
    local allPlayers = table.Copy(player.GetAll())

    for k, ply in pairs(allPlayers) do
        if k > limit then break end
        table.insert(players, ply)
    end
    table.Shuffle(players)

    return players
end

local function newanim(ent, tab, dur, anim)
    if !IsValid(ent) or !istable(tab) then return end
    ent:ResetSequence(anim)
    tab.duration = dur
    tab.startTime = CurTime()
    tab.cycle = 0
end

local function connectweapon(ent, type)
    local model = "models/weapons/w_pist_p228.mdl"
    local lpos = Vector(2,0,-3)
    if type == "rifle" then
        model = "models/weapons/w_rif_m4a1.mdl"
        lpos = Vector(8,0,-3.5)
    end
    local wep = ents.CreateClientside("base_anim")
    local attach = ent:GetAttachment(ent:LookupAttachment("anim_attachment_RH"))
    if attach then
        wep:SetModel(model)
        wep:Spawn()
        wep:SetPos(Vector(0,0,-9999))
        wep:SetAngles(attach.Ang)
        wep:SetParent(ent, ent:LookupAttachment("anim_attachment_RH"))
        wep:SetLocalAngles(Angle(0,0,0))
        wep:SetLocalPos(lpos)
        table.insert(spawnedModels, wep)
    else
        wep:Remove()
    end
    return wep
end

local function bonemerge(model, ent)
    if !IsValid(ent) then return end
    local bm = ents.CreateClientside("base_anim")
    bm:SetModel(model)
    bm:Spawn()
    bm:SetParent(ent)
    bm:AddEffects(1)
    ent:SetNoDraw(true)
    table.insert(spawnedModels, bm)
    return bm
end

local function muzzleflash(wep)
    if !IsValid(wep) or wep:GetNoDraw() then return end
    local attach = wep:GetAttachment(wep:LookupAttachment("muzzle"))
    if attach then
        ParticleEffectAttach("ins_muzzleflash_makarov_3rd", PATTACH_POINT_FOLLOW, wep, wep:LookupAttachment("muzzle"))
    end
end

local zombieModels = {{Model = "models/moo/_codz_ports/t10/jup/moo_codz_jup_base_charred_male.mdl"}}
local function NewCallFailScene(main_heli_pos, main_heli_ang)
    CreateTimedScene(
        {
            {name = "Heli", model = "models/bo6/exfil/veh/new/heli.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_fail_1"},
            {name = "Zombie1", model = "models/bo6/exfil/zombie_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_fail_zombie1_1"},
            {name = "Zombie2", model = "models/bo6/exfil/zombie_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_fail_zombie1_2"},
            {name = "Zombie3", model = "models/bo6/exfil/zombie_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_fail_zombie1_3"},
            {name = "Pilot", model = "models/bo6/exfil/human_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_fail_pilot_1"},
            {name = "Camera", model = "models/bo6/exfil/cutscene_camera.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_cam_fail_1"},
        },
        {
            [0] = "bo6/exfil/effects/exfil_fail.mp3",
        },
        8.62,--2.96 --3.26 --2.4
        function()
            print("Scene finished!")
        end
    )
    local h, ha = spawnedModels["Heli"], modelAnimations["Heli"]
    local z1, z1a = spawnedModels["Zombie1"], modelAnimations["Zombie1"]
    local z2, z2a = spawnedModels["Zombie2"], modelAnimations["Zombie2"]
    local z3, z3a = spawnedModels["Zombie3"], modelAnimations["Zombie3"]
    local p, pa = spawnedModels["Pilot"], modelAnimations["Pilot"]
    local c, ca = spawnedModels["Camera"], modelAnimations["Camera"]

    bonemerge("models/bo6/exfil/veh/new/heli.mdl", h)
    bonemerge(table.Random(zombieModels).Model, z1)
    bonemerge(table.Random(zombieModels).Model, z2)
    bonemerge(table.Random(zombieModels).Model, z3)
    local bm = bonemerge("models/player/leet.mdl", p)
    bm:SetNoDraw(true)

    local wep = nil
    timer.Simple(1, function()
        surface.PlaySound("bo6/exfil/vox/pilot/damage"..math.random(1,4)..".mp3")
    end)
    timer.Simple(3.85, function()
        muzzleflash(wep)
    end)
    timer.Simple(4.15, function()
        muzzleflash(wep)
    end)
    timer.Simple(4.85, function()
        muzzleflash(wep)
    end)
    for i=1,10 do
        timer.Simple(5.6+(i/25), function()
            ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, p, p:LookupAttachment("right_neck"))
            if i == 10 then
                surface.PlaySound("bo6/exfil/vox/pilot/destruction"..math.random(1,4)..".mp3")
            end
        end)
    end
    hook.Add("Think", h, function()
        local dlight = DynamicLight(LocalPlayer():EntIndex())
        if dlight and IsValid(h) then
            dlight.pos = h:GetAttachment(1).Pos+h:GetAttachment(1).Ang:Up()*64+h:GetAttachment(1).Ang:Forward()*16
            dlight.r = 200
            dlight.g = 20
            dlight.b = 20
            dlight.brightness = 2
            dlight.decay = 1000
            dlight.size = 256
            dlight.dietime = CurTime() + 1
        end
    end)
    timer.Simple(8.3, function()
        ParticleEffectAttach("doi_splinter_explosion", PATTACH_POINT_FOLLOW, h, 1)
    end)
    for i=1,15 do
        timer.Simple((i/5), function()
            local effectdata = EffectData()
            effectdata:SetOrigin(main_heli_pos)
            util.Effect("bo6_heli_dust", effectdata)
        end)
    end

    timer.Simple(2.96, function()
        wep = connectweapon(p, "pistol")
        bm:SetNoDraw(false)
        z3:Remove()

        newanim(h, ha, 3.26, "exfil_fail_2")
        newanim(c, ca, 3.26, "exfil_cam_fail_2")
        newanim(z1, z1a, 3.26, "exfil_fail_zombie2_1")
        newanim(z2, z2a, 3.26, "exfil_fail_zombie2_2")
        newanim(p, pa, 3.26, "exfil_fail_pilot_2")

        timer.Simple(3.26, function()
            z2:Remove()

            newanim(h, ha, 2.4, "exfil_fail_3")
            newanim(c, ca, 2.4, "exfil_cam_fail_3")
            newanim(z1, z1a, 2.4, "exfil_fail_zombie3_1")
            newanim(p, pa, 2.4, "exfil_fail_pilot_3")
        end)
    end)
    timer.Simple(8.5, function()
        LocalPlayer():ScreenFade(SCREENFADE.OUT, color_black, 0.1, 3)
    end)
    timer.Simple(11, function()
        RunConsoleCommand("cl_drawhud", "1")
    end)
end

local function NewCallSuccessScene(main_heli_pos, main_heli_ang)
    CreateTimedScene(
        {
            {name = "Heli", model = "models/bo6/exfil/veh/new/heli.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_success_1"},
            {name = "Zombie1", model = "models/bo6/exfil/zombie_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_success_zombie1_1"},
            {name = "Zombie2", model = "models/bo6/exfil/zombie_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_success_zombie1_2"},
            {name = "Player1", model = "models/bo6/exfil/human_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_success_player1_1"},
            {name = "Player2", model = "models/bo6/exfil/human_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_success_player1_2"},
            {name = "Player3", model = "models/bo6/exfil/human_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_success_player1_3"},
            {name = "Player4", model = "models/bo6/exfil/human_anims.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_success_player1_4"},
            {name = "Camera", model = "models/bo6/exfil/cutscene_camera.mdl", position = main_heli_pos, angle = main_heli_ang, animation = "exfil_cam_success_1"},
        },
        {
            [0] = "bo6/exfil/effects/exfil_success.mp3",
        },
        11.83,--2.93 --3.2 --5.7
        function()
            print("Scene finished!")
        end
    )
    local h, ha = spawnedModels["Heli"], modelAnimations["Heli"]
    local z1, z1a = spawnedModels["Zombie1"], modelAnimations["Zombie1"]
    local z2, z2a = spawnedModels["Zombie2"], modelAnimations["Zombie2"]
    local p1, pa1 = spawnedModels["Player1"], modelAnimations["Player1"]
    local p2, pa2 = spawnedModels["Player2"], modelAnimations["Player2"]
    local p3, pa3 = spawnedModels["Player3"], modelAnimations["Player3"]
    local p4, pa4 = spawnedModels["Player4"], modelAnimations["Player4"]
    local c, ca = spawnedModels["Camera"], modelAnimations["Camera"]

    local wep = connectweapon(p1, "rifle")
    local wep2 = connectweapon(p2, "rifle")
    local wep3 = connectweapon(p3, "rifle")
    local wep4 = connectweapon(p4, "rifle")

    local tab = GetPlayerTable(4)
    if IsValid(tab[1]) then
        bonemerge(tab[1]:GetModel(), p1)
    else
        p1:SetNoDraw(true)
        wep:SetNoDraw(true)
    end
    if IsValid(tab[2]) then
        bonemerge(tab[2]:GetModel(), p2)
    else
        p2:SetNoDraw(true)
        wep2:SetNoDraw(true)
    end
    if IsValid(tab[3]) then
        bonemerge(tab[3]:GetModel(), p3)
    else
        p3:SetNoDraw(true)
        wep3:SetNoDraw(true)
    end
    if IsValid(tab[4]) then
        bonemerge(tab[4]:GetModel(), p4)
    else
        p4:SetNoDraw(true)
        wep4:SetNoDraw(true)
    end
    bonemerge("models/bo6/exfil/veh/new/heli.mdl", h)
    bonemerge(table.Random(zombieModels).Model, z1)
    bonemerge(table.Random(zombieModels).Model, z2)

    for i=1,15 do
        timer.Simple((i/5), function()
            local effectdata = EffectData()
            effectdata:SetOrigin(main_heli_pos)
            util.Effect("bo6_heli_dust", effectdata)
        end)
    end
    for i=1,2 do
        timer.Simple(4+(i*0.8), function()
            ParticleEffectAttach("ins_blood_impact_headshot", PATTACH_POINT_FOLLOW, z2, z2:LookupAttachment("eyes"))
        end)
    end

    for i=1,4 do
        timer.Simple(0.9+(i/10), function()
            muzzleflash(wep)
        end)
    end
    for i=1,4 do
        timer.Simple(1.6+(i/10), function()
            muzzleflash(wep)
        end)
    end
    for i=1,4 do
        timer.Simple(2.4+(i/10), function()
            muzzleflash(wep2)
        end)
    end
    hook.Add("Think", h, function()
        local dlight = DynamicLight(LocalPlayer():EntIndex())
        if dlight and IsValid(h) then
            dlight.pos = h:GetAttachment(1).Pos+h:GetAttachment(1).Ang:Up()*64+h:GetAttachment(1).Ang:Forward()*16
            dlight.r = 200
            dlight.g = 20
            dlight.b = 20
            dlight.brightness = 2
            dlight.decay = 1000
            dlight.size = 256
            dlight.dietime = CurTime() + 1
        end
    end)

    timer.Simple(2.93, function()
        z1:Remove()

        newanim(h, ha, 3.2, "exfil_success_2")
        newanim(c, ca, 3.2, "exfil_cam_success_2")
        newanim(z2, z2a, 3.2, "exfil_success_zombie2_2")
        newanim(p1, pa1, 3.2, "exfil_success_player2_1")
        newanim(p2, pa2, 3.2, "exfil_success_player2_2")
        newanim(p3, pa3, 3.2, "exfil_success_player2_3")
        newanim(p4, pa4, 3.2, "exfil_success_player2_4")
        timer.Simple(3.2, function()
            surface.PlaySound("bo6/exfil/vox/pilot/Leave"..math.random(1,4)..".mp3")
            newanim(h, ha, 5.7, "exfil_success_3")
            newanim(c, ca, 5.7, "exfil_cam_success_3")
            newanim(z2, z2a, 5.7, "exfil_success_zombie3_2")
            newanim(p1, pa1, 5.7, "exfil_success_player3_1")
            newanim(p2, pa2, 5.7, "exfil_success_player3_2")
            newanim(p3, pa3, 5.7, "exfil_success_player3_3")
            newanim(p4, pa4, 5.7, "exfil_success_player3_4")
            timer.Simple(2, function()
                z2:Remove()
            end)
        end)
    end)
    timer.Simple(11, function()
        LocalPlayer():ScreenFade(SCREENFADE.OUT, color_black, 0.1, 3)
    end)
    timer.Simple(14, function()
        RunConsoleCommand("cl_drawhud", "1")
    end)
end

net.Receive("nZr.ExfilCutscene", function()
    local bool = net.ReadBool()
    main_heli_pos = net.ReadVector()
    main_heli_ang = net.ReadAngle()
    zombieModels = net.ReadTable()

    LocalPlayer():ScreenFade(SCREENFADE.IN, color_black, 1, 2)
    RunConsoleCommand("cl_drawhud", "0")
    timer.Simple(2, function()
        if bool then
            NewCallSuccessScene(main_heli_pos, main_heli_ang)
        else
            main_heli_ang = main_heli_ang+Angle(0,180,0)
            NewCallFailScene(main_heli_pos, main_heli_ang)
        end
    end)
end)