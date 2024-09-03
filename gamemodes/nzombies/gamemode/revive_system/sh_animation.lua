-- bo3 down animations ported by Wavy
-- coded by wavy & latte w/ help from ghostlymoo

local downed = {}
local ihavebeendowned = {}
local revived = {}
local ihavebeenrevived = {}

hook.Add("CalcMainActivity", "nzDownedAnimation", function(ply, vel)
	
    if downed[ply] == nil then downed[ply] = false end
    if ihavebeendowned[ply] == nil then ihavebeendowned[ply] = false end
    if revived[ply] == nil then revived[ply] = true end
    if ihavebeenrevived[ply] == nil then ihavebeenrevived[ply] = true end

    if ply:GetNotDowned() and not revived[ply] and not ihavebeenrevived[ply] then
        local seq, dur = ply:LookupSequence("bo3_revived")
        ply:SetPlaybackRate(1)
        revived[ply] = true
        timer.Simple(dur, function()
            if IsValid(ply) then
                ihavebeenrevived[ply] = true
            end
        end)
        ply:SetCycle(0)
        ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)
    end

    if ply:GetNotDowned() and downed[ply] and ihavebeendowned[ply] then
        downed[ply] = false
        ihavebeendowned[ply] = false
    end
    
    if not ply:GetNotDowned() then
        if not downed[ply] then
            downed[ply] = true
            revived[ply] = false
            ihavebeenrevived[ply] = false
            local seq, dur = ply:LookupSequence("bo3_downed")
            ply:SetPlaybackRate(1)
            timer.Simple(dur - 1, function()
                if IsValid(ply) then
                    ihavebeendowned[ply] = true
                end
            end)
            ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)
        end    
    end
        
    if ihavebeendowned[ply] then
        local angle, angle2 = vel:Angle(), ply:GetAngles()
        local ydif = math.abs(math.NormalizeAngle(angle.y - angle2.y))

        local seq1 = ply:LookupSequence("bo3_crawl_idle")
        local seq2 = ply:LookupSequence("bo3_crawl_back")
        local seq3 = ply:LookupSequence("bo3_crawl_forward")

        ply:SetPlaybackRate(1)

        if vel:Length2D() < 1 then
            return ACT_IDLE, seq1
        elseif ydif < 90 then
            return ACT_IDLE, seq3
        else
            return ACT_IDLE, seq2
        end
    end
end)

local cyclex, cycley = 0.6, 0.65
hook.Add("UpdateAnimation", "nzDownedAnimation", function(ply, vel, seqspeed)
    if not ply:GetNotDowned() then
        local movement = 0

        local len = vel:Length2D()
        if len > 1 then
            movement = len / seqspeed
        else
            local cycle = ply:GetCycle()
            if cycle < cyclex or cycle > cycley then
                movement = 5
            end
        end

        ply:SetPlaybackRate(1)
        return true
    end
end)
