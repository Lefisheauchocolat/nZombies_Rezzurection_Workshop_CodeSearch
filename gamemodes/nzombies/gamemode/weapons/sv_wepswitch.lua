local interruptedPlayers = {}

util.AddNetworkString("TFA_HolsterCancle")

net.Receive("TFA_HolsterCancle", function(_, ply)

    local wep = ply:GetActiveWeapon()
    if not (IsValid(wep) and wep.Base and string.find(wep.Base, "tfa") and wep.GetStatus) then return end

    local status = wep:GetStatus()

    if TFA.Enum and TFA.Enum.HolsterStatus and TFA.Enum.HolsterStatus[status] then
        interruptedPlayers[ply] = true
        if wep.Holster_Cancel then
            wep:Holster_Cancel()
        elseif wep.SetStatus and TFA.GetStatus then
            wep:SetStatus(TFA.GetStatus("idle"))
        end
    end
end)

hook.Add("Think", "TFA_ForceVMIdleOnInterrupt", function()

    for _, ply in ipairs(player.GetAll()) do
        if not interruptedPlayers[ply] then continue end

        local wep = ply:GetActiveWeapon()
        if not (IsValid(wep) and wep.Base and string.find(wep.Base, "tfa") and wep.GetStatus) then
            interruptedPlayers[ply] = nil
            continue
        end

        local status = wep:GetStatus()

        if TFA.GetStatus and status == TFA.GetStatus("idle") then
            local vm = ply:GetViewModel()
            if not IsValid(vm) then
                interruptedPlayers[ply] = nil
                continue
            end

            local act = ACT_VM_IDLE

            if wep:Clip1() == 0 then
                act = ACT_VM_IDLE_EMPTY
            elseif wep.Silenced then
                act = ACT_VM_IDLE_SILENCED
            end

            local idleSeq = vm:SelectWeightedSequence(act)
            if idleSeq and idleSeq >= 0 and vm:GetSequence() ~= idleSeq then
                vm:SendViewModelMatchingSequence(idleSeq)
            end

            interruptedPlayers[ply] = nil
        end
    end
end)