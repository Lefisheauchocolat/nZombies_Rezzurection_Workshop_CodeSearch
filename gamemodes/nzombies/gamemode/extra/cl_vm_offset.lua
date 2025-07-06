local vmOffsetLerp = 0
local offsetSpeed = 7
local offsetActiveUntil = 0

local currentOffsetX = 1
local currentOffsetY = 0.7

function NZR_TriggerVMOffset(duration, x, y)
    offsetActiveUntil = CurTime() + (duration or 0.9)
    currentOffsetX = x or 1
    currentOffsetY = y or 0.7
end

function NZR_CalcVMOffset(wep, vm, oldPos, oldAng, pos, ang)
    if not IsValid(wep) or not wep:IsWeapon() then return end

    if wep.GetIronSights and wep:GetIronSights() then
        vmOffsetLerp = Lerp(FrameTime() * offsetSpeed, vmOffsetLerp, 0)
        return
    end

    local shouldOffset = CurTime() < offsetActiveUntil
    vmOffsetLerp = Lerp(FrameTime() * offsetSpeed, vmOffsetLerp, shouldOffset and 1 or 0)

    if vmOffsetLerp > 0.001 then
        local offset = ang:Right() * (currentOffsetX * vmOffsetLerp)
                    - ang:Up() * (currentOffsetY * vmOffsetLerp)
        pos:Add(offset)
    end
end
