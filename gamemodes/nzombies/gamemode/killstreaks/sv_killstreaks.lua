-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

local function rndkillstreak(pos)
    local ent = ents.Create("bo6_killstreak")
    ent:SetPos(pos)
    ent:SetAngles(Angle(0,math.random(0,360),0))
    ent:Spawn()
    ent:GetPhysicsObject():SetVelocity(Vector(math.random(-128,128),math.random(-128,128),64))
    ent:RandomKillstreak()
end

local pl = FindMetaTable("Player")
local en = FindMetaTable("Entity")

function en:GivePoints() end

function pl:SetSVAnim(anim, autostop)
    self:SetNWString('SVAnim', anim)
    self:SetNWFloat('SVAnimDelay', select(2, self:LookupSequence(anim)))
    self:SetNWFloat('SVAnimStartTime', CurTime())
    self:SetCycle(0)

    if autostop and anim ~= "" then
        local delay = select(2, self:LookupSequence(anim))

        timer.Simple(delay, function()
            if not IsValid(self) then return end
            local anim2 = self:GetNWString('SVAnim')

            if anim == anim2 then
                self:SetSVAnim("")
            end
        end)
    end

    return select(2, self:LookupSequence(anim))
end

function pl:GiveKillstreak(class)
    if self:GetUsingSpecialWeapon() then return end
    if self:HaveKillstreak() then
        self:DropKillstreak(self:GetWeapon(self:HaveKillstreak()))
    end
    self:Give(class)
end

function pl:DropKillstreak(wep)
    if wep:Clip1() != wep:GetMaxClip1() then 
        wep:Remove()
        return 
    end
    local ent = ents.Create("bo6_killstreak")
    ent:SetPos(self:WorldSpaceCenter())
    ent:SetAngles(Angle(0,math.random(0,360),0))
    ent:Spawn()
    ent:SetNWString("Class", wep:GetClass())
    ent:GetPhysicsObject():SetVelocity(Vector(math.random(-128,128),math.random(-128,128),64))
    wep:Remove()
end

hook.Add("PlayerSwitchWeapon", "nzrKillstreaks", function(ply, ow, nw)
    if IsValid(ow) and string.match(ow:GetClass(), "bo6_killstreak_") and ow.CanChangeWeapon then
        ply:SetUsingSpecialWeapon(false)
        return false
    end
end)

hook.Add("PlayerButtonDown", "nzrKillstreaks", function(ply, but)
    if ply:HaveKillstreak() and ply:Alive() and but == KEY_5 then
        ply:SelectWeapon(ply:HaveKillstreak())
    end
end)

-------------------------SALVAGE--------------------------------------------------

function nzKillstreak:SpawnSalvage(pos)
    local ent = ents.Create("bo6_salvage")
    ent:SetPos(pos)
    ent:SetAngles(Angle(0,math.random(0,360,0),0))
    ent:Spawn()
    ent:GetPhysicsObject():SetVelocity(Vector(math.Rand(-128,128),math.Rand(-128,128),math.Rand(32,72)))
    SafeRemoveEntityDelayed(ent, 120)
end

hook.Add("OnGameBegin", "nzrSalvageSystem", function(ply)
    for _, ply in pairs(player.GetAll()) do
        ply:SetNWInt('Salvage', 0)
    end
end)

hook.Add("OnZombieKilled", "nzrSalvageSystem", function(ent)
    if !nzSettings:GetSimpleSetting("BO6_Salvage", false) then return end

    local is_special = string.match(ent:GetClass(), "_special")
    if is_special and nzSettings:GetSimpleSetting("BO6_Salvage_DropSpecial", 50) >= math.random(1,100) then
        local pos = ent:GetPos()+Vector(0,0,32)
        nzKillstreak:SpawnSalvage(pos)
    elseif nzSettings:GetSimpleSetting("BO6_Salvage_Drop", 20) >= math.random(1,100) then
        local pos = ent:GetPos()+Vector(0,0,32)
        nzKillstreak:SpawnSalvage(pos)
    end

    if nzSettings:GetSimpleSetting("BO6_Killstreak_Drops", true) and table.HasValue(nzKillstreak.Specials, ent:GetClass()) and 15 >= math.random(1,100) then
        rndkillstreak(ent:WorldSpaceCenter())
    end
end)

hook.Add("OnBossKilled", "nzrSalvageSystem", function(ent)
    if !nzSettings:GetSimpleSetting("BO6_Salvage", false) then return end

    if nzSettings:GetSimpleSetting("BO6_Salvage_DropBoss", 100) >= math.random(1,100) then
        local pos = ent:GetPos()+Vector(0,0,32)
        nzKillstreak:SpawnSalvage(pos)
    end

    if nzSettings:GetSimpleSetting("BO6_Killstreak_Drops", true) and 50 >= math.random(1,100) then
        rndkillstreak(ent:WorldSpaceCenter())
    end
end)

hook.Add("PlayerPostThink", "nzrSalvageSystem", function(ply)
    if !ply:Alive() or !nzSettings:GetSimpleSetting("BO6_Salvage", false) then return end

    for _, v in pairs(ents.FindInSphere(ply:GetPos(), 32)) do
        if v:GetClass() == "bo6_salvage" then
            v:Remove()
            ply:SetNWInt("Salvage", ply:GetNWInt("Salvage")+50)
            ply:EmitSound(")bo6/other/metal_collect.wav", 60)
            break
        end
    end
end)

-------------------------MANGLER--------------------------------------------------

local function manglerback(ply)
    if !ply:Alive() or ply:GetModel() != "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then return end
    ply:SetModel(ply.KS_LastModel)
    ply:SetWalkSpeed(ply.KS_LastSpeed[1])
    ply:SetRunSpeed(ply.KS_LastSpeed[2])
    ply:ScreenFade(SCREENFADE.IN, color_white, 0.5, 0)
    ply:GodDisable()
    ply:EmitSound("ambient/levels/labs/electric_explosion"..math.random(1,5)..".wav", 80)
    ParticleEffect("bo3_panzer_landing", ply:GetPos(), Angle(0,0,0), ply)
    ParticleEffect("bo3_panzer_explosion", ply:GetPos(), Angle(0,0,0), ply)
    local wep = ply:GetPreviousWeapon()
    if IsValid(wep) then
        ply:SelectWeapon(wep:GetClass())
    end
    for _, ent in pairs(ents.FindInSphere(ply:EyePos(), 256)) do
        if ent:Health() > 0 and !ent:IsPlayer() then
            ent:TakeDamage(math.max(1000*nzRound:GetNumber(), 1000), ply)
        end
    end
end

local function manglervoice(ply, type)
    local str = ""
    if type == "attack" then
        str = "nz_moo/zombies/vox/_raz/_t10/attack/attack_0"..math.random(0,8)..".mp3"
    elseif type == "spawn" then
        str = "nz_moo/zombies/vox/_raz/_t10/rage/rage_0"..math.random(0,3)..".mp3"
        ParticleEffect("bo3_panzer_landing", ply:GetPos(), Angle(0,0,0), ply)
        ParticleEffect("bo3_panzer_explosion", ply:GetPos(), Angle(0,0,0), ply)
        ply:EmitSound("ambient/levels/labs/electric_explosion"..math.random(1,5)..".wav", 80)
    elseif type == "despawn" then
        str = "nz_moo/zombies/vox/_raz/_t10/death/death_0"..math.random(0,4)..".mp3"
    elseif type == "swing" then
        str = "nz_moo/zombies/vox/_raz/swing_blade/swing_0"..math.random(0,5)..".mp3"
    elseif type == "charge" then
        str = "nz_moo/zombies/vox/_raz/_t10/cannon/prefire.mp3"
        ply:EmitSound("nz_moo/zombies/vox/_raz/_t10/cannon/charge.mp3", 70)
        ParticleEffectAttach("hcea_hunter_ab_charge", PATTACH_POINT_FOLLOW, ply, 13)
    elseif type == "shot" then
        str = "nz_moo/zombies/vox/_raz/_t10/cannon/fire.mp3"
        ParticleEffectAttach("hcea_hunter_ab_muzzle", PATTACH_POINT_FOLLOW, ply, 13)
        ply.ZapShot = ents.Create("nz_proj_mangler_friendlyshot_cw")
		ply.ZapShot:SetPos(ply:GetBonePosition(ply:LookupBone("j_weapon_spin"))+ply:GetForward()*8)
		ply.ZapShot:SetAngles(ply:EyeAngles())
        ply.ZapShot.Player = ply
		ply.ZapShot:Spawn()
    elseif type == "idle" then
        --str = "nz_moo/zombies/vox/_raz/_t10/rage/rage_0"..math.random(0,3)..".mp3"
    end
    ply:EmitSound(str, 70)
end

function nzKillstreak:ManglerInjection(ply)
    if !ply:Alive() or !ply:GetNotDowned() or ply:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then return end

    ply.KS_LastModel = ply:GetModel()
    ply.KS_LastSpeed = {ply:GetWalkSpeed(), ply:GetRunSpeed()}
    ply:SetModel("models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl")
    ply:SetWalkSpeed(80)
    ply:SetRunSpeed(200)
    ply:SetSVAnim("nz_base_zmb_raz_enrage", true)
    ply:GodEnable()
    ply:ScreenFade(SCREENFADE.IN, color_white, 0.5, 0)
    ply:SetHealth(ply:GetMaxHealth())
    ply:SetArmor(ply:GetMaxArmor())
    manglervoice(ply, "spawn")
    for _, ent in pairs(ents.FindInSphere(ply:EyePos(), 256)) do
        if ent:Health() > 0 and !ent:IsPlayer() then
            ent:TakeDamage(math.max(1000*nzRound:GetNumber(), 1000), ply)
        end
    end
    timer.Simple(nzSettings:GetSimpleSetting("BO6_Killstreak_ManglerTime", 45), function()
        if !IsValid(ply) or ply:GetModel() != "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then return end
        ply:SetSVAnim("nz_base_zmb_raz_stun_in", true)
        ply:ScreenFade(SCREENFADE.OUT, color_white, 2.9, 0.1)
        manglervoice(ply, "despawn")
        timer.Simple(3, function()
            if !IsValid(ply) or ply:GetModel() != "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then return end
            manglerback(ply)
        end)
    end)
end

local attackanimsTab = {
    ["nz_base_zmb_raz_attack_sickle_swing_down"] = 1,
    ["nz_base_zmb_raz_attack_sickle_swing_l_to_r"] = 1,
    ["nz_base_zmb_raz_attack_sickle_swing_r_to_l"] = 1,
    ["nz_base_zmb_raz_attack_sickle_swing_uppercut"] = 1,
    ["nz_base_zmb_raz_attack_swing_l_to_r"] = 1,
    ["nz_base_zmb_raz_attack_swing_r_to_l"] = 1,
    ["nz_base_zmb_raz_attack_sickle_double_swing_1"] = 2,
    ["nz_base_zmb_raz_attack_sickle_double_swing_2"] = 2,
    ["nz_base_zmb_raz_attack_sickle_double_swing_3"] = 2,
}
hook.Add("KeyPress", "nzrKillstreaks_Mangler", function(ply, key)
    if ply:GetSVAnim() == "" and ply:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then
        if key == IN_ATTACK then
            local times, anim = table.Random(attackanimsTab)
            ply:SetSVAnim(anim, true)
            manglervoice(ply, "attack")
            for i = 1, times do
                timer.Simple(-0.5+i, function()
                    if !IsValid(ply) then return end
                    manglervoice(ply, "swing")
                end)
                timer.Simple(0.8*i, function()
                    if !IsValid(ply) then return end
                    for _, ent in pairs(ents.FindInSphere(ply:EyePos(), 128)) do
                        if ent:Health() > 0 and !ent:IsPlayer() then
                            ent:EmitSound("physics/flesh/flesh_impact_hard"..math.random(1,6)..".wav", 70, math.random(80,110))
                            ent:EmitSound("physics/flesh/flesh_squishy_impact_hard"..math.random(1,4)..".wav", 70, math.random(80,110))
                            if string.match(ent:GetClass(), "_boss") then
                                ent:TakeDamage(5000, ply)
                            else
                                ent:TakeDamage(math.max(10000+(2500*nzRound:GetNumber()), 10000), ply)
                            end
                        end
                    end
                end)
            end
        elseif key == IN_ATTACK2 then
            ply:SetSVAnim("nz_base_zmb_raz_attack_shoot_02", true)
            manglervoice(ply, "charge")
            timer.Simple(1.8, function()
                if !IsValid(ply) then return end
                manglervoice(ply, "shot")
            end)
        end  
    end
end)

hook.Add("PlayerPostThink", "nzrKillstreaks_Mangler", function(ply)
    if ply:IsPlayer() and ply:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then
        ply:SetActiveWeapon(nil)
    end
end)

hook.Add("EntityTakeDamage", "!nzrKillstreaks_Mangler", function(ent, dmg)
    if ent:IsPlayer() and ent:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then
        dmg:SetDamage(0)
        return true
    end
end)

hook.Add("PlayerDowned", "nzrKillstreaks_Mangler", manglerback)
hook.Add("PlayerSilentDeath", "nzrKillstreaks_Mangler", manglerback)

-------------------------CANNON--------------------------------------------------

hook.Add("EntityTakeDamage", "!nzrKillstreaks_Cannon", function(ent, dmg)
    local at = dmg:GetAttacker()
    if at:IsPlayer() and IsValid(at:GetActiveWeapon()) and at:GetActiveWeapon():GetClass() == "bo6_killstreak_cannon" then
        dmg:SetDamage(25000+(2500*nzRound:GetNumber()))
        if string.match(ent:GetClass(), "_boss") then
            dmg:SetDamage(1000)
        end
    end
end)

-------------------------DEATH MACHINE-------------------------------------------

hook.Add("EntityTakeDamage", "!nzrKillstreaks_Death", function(ent, dmg)
    local at = dmg:GetAttacker()
    if at:IsPlayer() and IsValid(at:GetActiveWeapon()) and at:GetActiveWeapon():GetClass() == "bo6_killstreak_death" then
        dmg:SetDamage(1000+(200*nzRound:GetNumber()))
        if string.match(ent:GetClass(), "_boss") then
            dmg:SetDamage(100)
        end
    end
end)

-------------------------CHOPPER--------------------------------------------------

hook.Add("EntityTakeDamage", "!nzrKillstreaks_Chopper", function(ent, dmg)
    local at = dmg:GetAttacker()
    if at:IsPlayer() and IsValid(at:GetActiveWeapon()) and at:GetActiveWeapon():GetClass() == "bo6_deathmachine" then
        dmg:SetDamage(10000+(2000*nzRound:GetNumber()))
    end
end)

-------------------------SENTRY---------------------------------------------------

hook.Add("EntityTakeDamage", "!nzrKillstreaks_Sentry", function(ent, dmg)
    local at = dmg:GetAttacker()
    if IsValid(at.KS_SentryTurret) then
        dmg:SetAttacker(ent)
        dmg:SetDamage(ent:GetMaxHealth()/20)
        if string.match(ent:GetClass(), "_boss") then
            dmg:SetDamage(100)
        end
        if ent:Health() <= dmg:GetDamage() then
            dmg:SetAttacker(at.KS_SentryTurret)
        end
        if ent:IsPlayer() then
            dmg:SetDamage(0)
            return true
        end
    end
end)

-------------------------VTOL JET----------------------------------------------------

hook.Add("EntityTakeDamage", "!nzrKillstreaks_VTOL", function(ent, dmg)
    local at = dmg:GetAttacker()
    if at:GetClass() == "bo6_vtol" and IsValid(at.Player) then
        dmg:SetAttacker(ent)
        dmg:SetDamage(ent:GetMaxHealth()/10)
        if string.match(ent:GetClass(), "_boss") then
            dmg:SetDamage(250)
        end
        if ent:Health() <= dmg:GetDamage() then
            dmg:SetAttacker(at.Player)
        end
        if ent:IsPlayer() then
            dmg:SetDamage(0)
            return true
        end
    end
end)

-------------------------HELLSTORM-------------------------------------------------

hook.Add("EntityTakeDamage", "!nzrKillstreaks_Hellstorm", function(ent, dmg)
    local at = dmg:GetAttacker()
    if ent:IsPlayer() and at:IsPlayer() and IsValid(at.HellstormEnt) then
        dmg:SetDamage(0)
        return true
    elseif ent:IsNextBot() and at:IsPlayer() and IsValid(at.HellstormEnt) then
        dmg:SetDamage(100000+(10000*nzRound:GetNumber()))
    end
end)

-------------------------ARC-XD---------------------------------------------------

hook.Add("EntityTakeDamage", "!nzrKillstreaks_RCXD", function(ent, dmg)
    local at = dmg:GetAttacker()
    if ent:IsPlayer() and at:IsPlayer() and IsValid(at.RCXDEnt) then
        dmg:SetDamage(0)
        return true
    elseif ent:IsNextBot() and at:IsPlayer() and IsValid(at.RCXDEnt) then
        dmg:SetDamage(25000+(2500*nzRound:GetNumber()))
        if string.match(ent:GetClass(), "_boss") then
            dmg:SetDamage(1000)
        end
    end
end)

-------------------------DNA BOMB---------------------------------------------------

function nzKillstreak:DNABomb(ply)
    local finish_round = !isvector(nZr_Exfil_Position) 
    BroadcastLua([[surface.PlaySound("ambient/machines/aircraft_distant_flyby3.wav")]])
    timer.Simple(8, function()
        BroadcastLua([[nzKillstreak_DNAEffect()]])
        for _, z in pairs(ents.GetAll()) do
            if z:IsNextBot() and z:Health() > 0 then
                if string.match(z:GetClass(), "_boss") then
                    finish_round = false
                else
                    z:TakeDamage(math.huge, ply)
                end
            end
        end
        if finish_round then
            nzRound:SetZombiesMax(0)
            nzRound:SetZombiesToSpawn(0)
            nzRound:SetZombiesKilled(0)
        end
    end)
end

-------------------------------------------------------------------------------