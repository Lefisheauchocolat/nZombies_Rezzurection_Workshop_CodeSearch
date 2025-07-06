if SERVER then
    util.AddNetworkString("PlayerBuildpartVManip")

    hook.Add("PlayerPickupBuildpart", "PlayPickupAnim", function(ply, ent)
        net.Start("PlayerBuildpartVManip")
        net.Send(ply)
    end)
    hook.Add("PlayerPickupLockerKey", "PlayPickupAnim", function(ply, ent)
        net.Start("PlayerBuildpartVManip")
        net.Send(ply)
    end)
end

if CLIENT then
    CreateClientConVar("nz_vmanip_pickup", "1", true, false, "Enable/Disable pickup VManip animation")

    local wasSliding = false

    hook.Add("Think", "NZR_CheckSlidingTrigger", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end

        local isSliding = ply:GetSliding()

        if isSliding and not wasSliding then
            NZR_TriggerVMOffset(0.6, 1, -2)
        end
        wasSliding = isSliding
    end)

    hook.Add("CalcViewModelView", "nzrArmorSystem_OffsetVMOnReplate", NZR_CalcVMOffset)

    net.Receive("PlayerBuildpartVManip", function()
        if GetConVar("nz_vmanip_pickup"):GetBool() and VManip then
            VManip:PlayAnim("vm_iw_pickup")
            NZR_TriggerVMOffset(0.9, 0.8, 0.5)
        end
    end)
end
