-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!
nzArmor = nzArmor or {}

util.AddNetworkString("ButtDigger9000")
util.AddNetworkString("ButtDigger9001")

util.AddNetworkString("nzrArmorSystem_VManipStatus")
util.AddNetworkString("nzrArmorSystem_ArmorBreak")

function nzArmor:SpawnPlate(pos)
    local ent = ents.Create("bo6_armorplate")
    ent:SetPos(pos)
    ent:SetAngles(AngleRand())
    ent:Spawn()
    ent:GetPhysicsObject():SetVelocity(Vector(math.Rand(-128,128),math.Rand(-128,128),math.Rand(32,72)))
    SafeRemoveEntityDelayed(ent, 60)
end

local nextUseTime = {}

function nzArmor:UsePlate(ply)
    if not IsValid(ply) then return end

    local currentTime = CurTime()
    local cooldown = ply:HasPerk("speed") and 1.05 or 1.45

    if nextUseTime[ply] and currentTime < nextUseTime[ply] then return end
    nextUseTime[ply] = currentTime + cooldown

    if not nzSettings:GetSimpleSetting("BO6_Armor", false) then return end
    if ply:GetUsingSpecialWeapon() then return end
    if ply:GetNWInt("ArmorPlates") <= 0 then return end

    local armorType = ply.ArmorType or 1
    local maxArmor = nzSettings:GetSimpleSetting("BO6_Armor_Tier" .. armorType .. "HP", 150 * armorType)
    if ply:Armor() >= maxArmor then return end

    net.Start(ply:HasPerk("speed") and "ButtDigger9001" or "ButtDigger9000")
    net.Send(ply)

    ply:SetNWInt("ArmorPlates", ply:GetNWInt("ArmorPlates") - 1)
    nzArmor:AddHealth(ply)
end

function nzArmor:AddHealth(ply)
    local armor_type = math.min(ply.ArmorType or 1, 3)
    local armor_limit = nzSettings:GetSimpleSetting("BO6_Armor_Tier"..armor_type.."HP", 150*armor_type)
    local canadd = nzSettings:GetSimpleSetting("BO6_Armor_PerPlate", 150)
    local add = math.Clamp(ply:Armor()+canadd, 1, armor_limit)
    ply:SetArmor(add)
end

net.Receive("nzrArmorSystem_VManipStatus", function(len, ply)
    if not IsValid(ply) then return end
    ply._IsDoingVManip = net.ReadBool()
end)

hook.Add("PlayerSpawn", "nzrArmorSystem", function(ply)
    timer.Simple(0.1, function()
        if !IsValid(ply) or !nzSettings:GetSimpleSetting("BO6_Armor", false) then return end
        ply:SetMaxArmor(nzSettings:GetSimpleSetting("BO6_Armor_Tier3HP", 450))
        ply:SetArmor(nzSettings:GetSimpleSetting("BO6_Armor_Tier1HP", 150))
        ply:SetNWInt("ArmorPlates", nzSettings:GetSimpleSetting("BO6_Armor_MaxPlates", 3))
        ply.ArmorType = 1
    end)
end)

hook.Add("PlayerPostThink", "nzrArmorSystem", function(ply)
    if !ply:Alive() or !nzSettings:GetSimpleSetting("BO6_Armor", false) then return end
    local type = ply.ArmorType or 1
    ply:SetNWInt("ArmorType", ply.ArmorType)
    local max = nzSettings:GetSimpleSetting("BO6_Armor_Tier"..type.."HP", 150*type)
    if ply:Armor() > max then
        ply:SetArmor(max)
    elseif ply:Armor() < 1 then
        ply:SetArmor(1)
    end

    for _, v in pairs(ents.FindInSphere(ply:GetPos(), 50)) do
        if v:GetClass() == "bo6_armorplate" and ply:GetNWInt("ArmorPlates") < nzSettings:GetSimpleSetting("BO6_Armor_MaxPlates", 3) then
            v:Remove()
            ply:SetNWInt("ArmorPlates", ply:GetNWInt("ArmorPlates")+1)
            ply:EmitSound("bo6/other/armorplate_pickup.wav", 60)
            break
        end
    end
end)

hook.Add("EntityTakeDamage", "!!!nzrArmorSystem", function(ply, dmg)
    if ply:IsPlayer() and nzSettings:GetSimpleSetting("BO6_Armor", false) and ply:Armor() > 1 and bit.band(dmg:GetDamageType(), DMG_FALL + DMG_DROWN + DMG_POISON + DMG_RADIATION) == 0 then
        if ply:HasPerk("phd") and dmg:GetDamageType() == DMG_BLAST then
            dmg:ScaleDamage(0)
            return true
        end

        local oldArmor = ply:Armor()
        local newArmor = oldArmor - dmg:GetDamage()

        if newArmor <= 1 then
            ply:EmitSound("Latte_Armor.Break")
            newArmor = 1
            net.Start("nzrArmorSystem_ArmorBreak")
            net.Send(ply)
        end

        ply:SetArmor(ply:Armor()-dmg:GetDamage())
        dmg:ScaleDamage(nzSettings:GetSimpleSetting("BO6_Armor_Percent", 30)/100)
    end
end)

hook.Add("OnZombieKilled", "nzrArmorSystem", function(ent)
    if !nzSettings:GetSimpleSetting("BO6_Armor", false) then return end

    local is_special = string.match(ent:GetClass(), "_special")
    if is_special and nzSettings:GetSimpleSetting("BO6_Armor_DropSpecial", 25) >= math.random(1,100) then
        local pos = ent:GetPos()+Vector(0,0,32)
        nzArmor:SpawnPlate(pos)
    elseif nzSettings:GetSimpleSetting("BO6_Armor_Drop", 5) >= math.random(1,100) then
        local pos = ent:GetPos()+Vector(0,0,32)
        nzArmor:SpawnPlate(pos)
    end
end)

hook.Add("OnBossKilled", "nzrArmorSystem", function(ent)
    if !nzSettings:GetSimpleSetting("BO6_Armor", false) then return end

    if nzSettings:GetSimpleSetting("BO6_Armor_DropBoss", 100) >= math.random(1,100) then
        local pos = ent:GetPos()+Vector(0,0,32)
        nzArmor:SpawnPlate(pos)
    end
end)

local heldArmorKeys = {}

hook.Add("PlayerButtonDown", "nzrArmorSystem_Start", function(ply, but)
    if not IsValid(ply) or not ply:Alive() then return end

    local armorKey = ply:GetInfoNum("nz_key_armor", KEY_H)
    if but == armorKey then
        heldArmorKeys[ply] = true
    end
end)

hook.Add("PlayerButtonUp", "nzrArmorSystem_Stop", function(ply, but)
    if not IsValid(ply) then return end

    local armorKey = ply:GetInfoNum("nz_key_armor", KEY_H)
    if but == armorKey then
        heldArmorKeys[ply] = nil
    end
end)

hook.Add("Think", "nzrArmorSystem_Think", function()
    for ply, _ in pairs(heldArmorKeys) do
        if not IsValid(ply) or not ply:Alive() then
            heldArmorKeys[ply] = nil
            continue
        end

        if ply:IsSprinting() and not ply:HasPerk("staminup") then continue end

        local wep = ply:GetActiveWeapon()
        if IsValid(wep) then
            if type(wep.GetStatus) == "function" and wep:GetStatus() == 5 then continue end

            local vm = ply:GetViewModel()
            if IsValid(vm) and vm:GetSequenceActivity(vm:GetSequence()) == ACT_VM_RELOAD then continue end
        end

        if ply._IsDoingVManip then continue end

        nzArmor:UsePlate(ply)
    end
end)

function GM:HandlePlayerArmorReduction(ply, dmginfo)
    if nzSettings:GetSimpleSetting("BO6_Armor", false) then return end
    if ( ply:Armor() <= 0 || bit.band( dmginfo:GetDamageType(), DMG_FALL + DMG_DROWN + DMG_POISON + DMG_RADIATION ) != 0 ) then return end

    local flBonus = 1.0
    local flRatio = 0.2
    if ( GetConVar( "player_old_armor" ):GetBool() ) then
        flBonus = 0.5
    end

    local flNew = dmginfo:GetDamage() * flRatio
    local flArmor = (dmginfo:GetDamage() - flNew) * flBonus

    if ( !GetConVar( "player_old_armor" ):GetBool() ) then
        if ( flArmor < 1.0 ) then flArmor = 1.0 end
    end

    if ( flArmor > ply:Armor() ) then

        flArmor = ply:Armor() * ( 1 / flBonus )
        flNew = dmginfo:GetDamage() - flArmor
        ply:SetArmor( 0 )

    else
        ply:SetArmor( ply:Armor() - flArmor )
    end

    dmginfo:SetDamage( flNew )
end