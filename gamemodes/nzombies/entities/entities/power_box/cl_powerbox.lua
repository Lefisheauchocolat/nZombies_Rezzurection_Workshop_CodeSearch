AddCSLuaFile()

CreateClientConVar("nz_vmanip_poweron", "1", true, false, "Enable or disable VManip power-on animation")

net.Receive("PowerBox_UseAnim", function()
    if VManip and GetConVar("nz_vmanip_poweron"):GetInt() == 1 then
        VManip:PlayAnim("vm_iw_poweron")
    end
end)