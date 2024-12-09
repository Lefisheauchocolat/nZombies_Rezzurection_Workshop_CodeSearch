AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.AutomaticFrameAdvance = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/bo6/exfil/veh/heli.mdl")
    end

    function ENT:Think()
        self:NextThink(CurTime())
        return true
    end 
end
