local DOUBLE_JUMP_FORCE = 400
local DODGE_FORCE = 500
local DODGE_DELAY = 3
local SLAM_FORCE = -500
local SLAM_DAMAGE_RADIUS = 180
local SLAM_DELAY = 5
local SOUND_DOUBLE_JUMP = "aw/exo/exo_jump%s.mp3"
local SOUND_DODGE = "aw/exo/exo_jump%s.mp3"
local SOUND_SLAM = "aw/exo/exo_punch_deep_0%s.mp3"
local SOUND_LAND = "aw/exo/tac_boost_land_exo_0%s.mp3"
local SOUND_EQUIP = "aw/exo/exo_equip.mp3"
local DOUBLE_PRESS_INTERVAL = 0.3

local playerKeyPressTimes = {}
local function IsDoublePress(ply, key)
    local currentTime = CurTime()
    playerKeyPressTimes[ply] = playerKeyPressTimes[ply] or {}

    if playerKeyPressTimes[ply][key] and currentTime - playerKeyPressTimes[ply][key] <= DOUBLE_PRESS_INTERVAL then
        playerKeyPressTimes[ply][key] = nil
        return true
    else
        playerKeyPressTimes[ply][key] = currentTime
        return false
    end
end

local function nocooldown(name, add, ent)
    if not ent.ExoCooldowns then
        ent.ExoCooldowns = {}
    end
    local tab = ent.ExoCooldowns[name]
    if !isnumber(tab) or tab < CurTime() then
        ent.ExoCooldowns[name] = CurTime()+add
        return true
    else
        return false
    end
end

local function playsnd(snd, max, ent)
    local str = string.format(snd, math.random(1,max))
    ent:EmitSound(str, 85, math.random(90,110))
end

if SERVER then
    function nzExoSuit(ply, bool)
        if bool then
            if ply:GetNWBool("HaveExoSuit") then return end
            ply:SetNWBool("HaveExoSuit", true)
            ply:EmitSound(SOUND_EQUIP, 70, math.random(90,110))
            ply:Give(nzMapping.Settings.paparms or "")
        else
            ply:SetNWBool("HaveExoSuit", false)
            ply.ExoHasSlammed = false
        end
    end

    hook.Add("PlayerSpawn", "nzrExoSuit", function(ply)
        nzExoSuit(ply, false)
    end)
    hook.Add("PlayerDeath", "nzrExoSuit", function(ply)
        nzExoSuit(ply, false)
    end)

    hook.Add("PlayerButtonDown", "nzrExoSuitDodge", function(ply, button)
        local vel = ply:GetVelocity():Length()
        if not ply:GetNWBool("HaveExoSuit", false) or not ply:Alive() or ply:GetSliding() then return end

        if vel > 50 and button == KEY_LCONTROL and not ply:OnGround() and IsDoublePress(ply, KEY_LCONTROL) and not ply.ExoHasSlammed and nocooldown("slam", 8, ply) then
            local vel = ply:GetEyeTrace().Normal*math.abs(SLAM_FORCE)
            vel.z = SLAM_FORCE
            ply:SetVelocity(vel)
            ply.ExoHasSlammed = true
            ply:ViewPunch(Angle(5,0,0))
            ply:SetSVAnim("nz_exo_slam_air")
            playsnd(SOUND_DODGE, 3, ply)
        end
        if vel > 50 and button == KEY_LSHIFT and IsDoublePress(ply, KEY_LSHIFT) and nocooldown("dodge", 2, ply) then
            local forward = ply:GetForward()
            local right = ply:GetRight()
            local dodgeDirection = Vector(0, 0, 0)

            if ply:KeyDown(IN_FORWARD) then
                dodgeDirection = dodgeDirection + forward
                ply:ViewPunch(Angle(10,0,0))
            end
            if ply:KeyDown(IN_BACK) then
                dodgeDirection = dodgeDirection - forward
                ply:ViewPunch(Angle(-10,0,0))
            end
            if ply:KeyDown(IN_MOVELEFT) then
                dodgeDirection = dodgeDirection - right
                ply:ViewPunch(Angle(0,0,-10))
            end
            if ply:KeyDown(IN_MOVERIGHT) then
                dodgeDirection = dodgeDirection + right
                ply:ViewPunch(Angle(0,0,10))
            end

            if dodgeDirection:Length() > 0 then
                dodgeDirection:Normalize()
                if ply:OnGround() then
                    local tr = util.TraceLine( {
                        start = ply:EyePos(),
                        endpos = ply:EyePos() + Vector(0,0,32),
                        filter = ply
                    })
                    if !tr.Hit then
                        ply:SetPos(ply:GetPos()+Vector(0,0,32))
                    end
                    timer.Simple(0.01, function()
                        if !IsValid(ply) then return end
                        ply:SetVelocity(dodgeDirection * DODGE_FORCE + Vector(0,0,200))
                    end)
                else
                    ply:SetVelocity(dodgeDirection * DODGE_FORCE + Vector(0,0,200))
                end
                playsnd(SOUND_DODGE, 3, ply)
            end
        end
        if button == KEY_SPACE then
            if not ply:OnGround() and not ply.ExoHasDoubleJumped then
                local velocity = ply:GetVelocity()
                ply:SetVelocity(Vector(0, 0, DOUBLE_JUMP_FORCE) - Vector(0, 0, velocity.z))
                playsnd(SOUND_DOUBLE_JUMP, 3, ply)
                ply.ExoHasDoubleJumped = true
                ply:ViewPunch(Angle(15,0,0))
            elseif ply:OnGround() then
                ply.ExoHasDoubleJumped = false
            end
        end
    end)

    hook.Add("PlayerPostThink", "nzrExoSuitSlamAttack", function(ply)
        if not ply:GetNWBool("HaveExoSuit", false) then return end

        if ply:OnGround() and ply.ExoHasSlammed then
            ply.ExoHasSlammed = false

            local explosionOrigin = ply:GetPos()
            local entities = ents.FindInSphere(explosionOrigin, SLAM_DAMAGE_RADIUS)

            for _, ent in pairs(entities) do
                if (ent:IsNextBot() or ent:IsNPC()) and ply:IsLineOfSightClear(ent:WorldSpaceCenter()) then
                    local damageInfo = DamageInfo()
                    local dmg = ent:Health()
                    if string.match(ent:GetClass(), "special") or string.match(ent:GetClass(), "boss") then
                        dmg = 500
                    end
                    damageInfo:SetDamage(dmg)
                    damageInfo:SetDamageType(DMG_BLAST)
                    damageInfo:SetAttacker(ply)
                    damageInfo:SetInflictor(ply)
                    ent:TakeDamageInfo(damageInfo)
                end
            end

            playsnd(SOUND_SLAM, 3, ply)
            ply:ViewPunch(Angle(25,0,0))
            ply:SetSVAnim("nz_exo_slam", true)
            ply:Freeze(true)
            ply:SetEyeAngles(Angle(0,ply:EyeAngles().y,0))
            ply:SetVelocity(-ply:GetVelocity())
            timer.Simple(0.83, function()
                if !IsValid(ply) then return end
                ply:Freeze(false)
            end)
            util.ScreenShake(ply:GetPos(), 4, 40, 2, 400)
            ParticleEffect("bo3_margwa_slam", ply:GetPos(), Angle(270,0,0), game.GetWorld())
            ParticleEffect("doi_ceilingDust_small", ply:GetPos(), Angle(0,0,0), game.GetWorld())
            local spos = ply:WorldSpaceCenter()+ply:GetForward()*21-ply:GetRight()*5
            util.Decal("Scorch", spos, spos-Vector(0,0,40), ply)
        end
    end)

    hook.Add("EntityTakeDamage", "nzrExoSuitNoFallDamage", function(target, dmginfo)
        if target:IsPlayer() and target:GetNWBool("HaveExoSuit", false) and dmginfo:IsFallDamage() then
            dmginfo:SetDamage(0)
            playsnd(SOUND_LAND, 8, target)
        end
    end)
else
    hook.Add("EntityRemoved", "nzrExoSuit", function(ent)
        if IsValid(ent.ExoSuitModel) then
            ent.ExoSuitModel:Remove()
            ent.ExoSuitModel = nil
        end
    end)

    hook.Add("Think", "nzrExoSuitBoneMerge", function()
        for _, ply in pairs(player.GetAll()) do
            if ply:LookupBone("ValveBiped.Bip01_Spine4") and ply:GetNWBool("HaveExoSuit") and ply:Alive() and !ply:IsDormant() then
                if not IsValid(ply.ExoSuitModel) then
                    ply.ExoSuitModel = ClientsideModel("models/moo/_cod_ports/s1/player/moo_exosuit_bonemerge.mdl")
                    if IsValid(ply.ExoSuitModel) then
                        ply.ExoSuitModel:SetParent(ply)
                        ply.ExoSuitModel:AddEffects(EF_BONEMERGE)
                    end
                end
            else
                if IsValid(ply.ExoSuitModel) then
                    ply.ExoSuitModel:Remove()
                    ply.ExoSuitModel = nil
                end
            end
        end
    end)

    hook.Add("CalcView", "nzrExoSuit", function(ply, pos, angles, fov)
        if string.match(ply:GetSVAnim(), "nz_exo_") and ply:GetNWBool("HaveExoSuit") then
            local view = {
                origin = pos,
                angles = angles,
                fov = fov,
                drawviewer = false
            }
            if ply:GetSVAnim() != "" and ply:GetCycle() < 1 then
                local att = ply:GetAttachment(ply:LookupAttachment("eyes"))
                view = {
                    origin = att.Pos+att.Ang:Forward()*2,
                    angles = att.Ang,
                    fov = fov,
                    drawviewer = true
                }
            end
        
            return view
        end
    end)
end