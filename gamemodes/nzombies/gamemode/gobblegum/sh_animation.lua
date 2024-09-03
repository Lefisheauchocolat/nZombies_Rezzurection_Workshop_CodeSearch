-- third person gum eating animations

local playerEatingStates = {}

hook.Add("CalcMainActivity", "nzEatGum3rdPerson", function(ply)

    local wep = ply:GetActiveWeapon()

    if not (IsValid(wep) and wep:GetClass() == "tfa_nz_gum") then
        return
    end

    if not playerEatingStates[ply] then
        playerEatingStates[ply] = {eating = false, noteating = true}
    end

    if not playerEatingStates[ply].eating then
        playerEatingStates[ply].eating = true
        playerEatingStates[ply].noteating = false
        
        local seq, dur = ply:LookupSequence("eat_gum")
        ply:SetPlaybackRate(1)
        ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)

        timer.Simple(dur, function()
            if IsValid(ply) and playerEatingStates[ply].eating then
                playerEatingStates[ply].eating = false
                playerEatingStates[ply].noteating = true
            end
        end)
    end
end)
