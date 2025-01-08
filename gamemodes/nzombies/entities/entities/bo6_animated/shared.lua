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
else
    function ENT:Draw()
        self:DrawModel()
        if self:GetModel() == "models/bo6/exfil/veh/heli.mdl" then
            self:ManipulateBoneAngles(4, self:GetManipulateBoneAngles(4)+Angle(0,5,0))
            self:ManipulateBoneAngles(28, self:GetManipulateBoneAngles(28)+Angle(5,0,0))
        end
    end
end
