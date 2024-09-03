-- third person perk drinking animations

local playerDrinkingStates = {}

hook.Add("CalcMainActivity", "nzPerkDrink3rdPerson", function(ply)

    local wep = ply:GetActiveWeapon()

    if not (IsValid(wep) and wep.IsTFAWeapon and wep.Category == "nZombies Bottles") then
        return
    end

    if not playerDrinkingStates[ply] then
        playerDrinkingStates[ply] = {drinking = false, notdrinking = true}
    end

    if not playerDrinkingStates[ply].drinking then
        playerDrinkingStates[ply].drinking = true
        playerDrinkingStates[ply].notdrinking = false
        
        local seq, dur = ply:LookupSequence("drink_perk")
        ply:SetPlaybackRate(1)
        ply:AddVCDSequenceToGestureSlot(6, seq, 0, true)

        timer.Simple(dur, function()
            if IsValid(ply) and playerDrinkingStates[ply].drinking then
                playerDrinkingStates[ply].drinking = false
                playerDrinkingStates[ply].notdrinking = true
            end
        end)
    end
end)
