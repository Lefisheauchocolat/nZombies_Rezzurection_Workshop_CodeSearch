AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Exo Station"
ENT.Category = "Advanced Warfare"
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/moo/_codz_ports_props/s1/dlc_exo_upgrade_station/moo_cod_s1_exo_upgrade_station.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(false)
        self:SetUseType(SIMPLE_USE)
        self:SetAngles(self:GetAngles() + Angle(0,90,0))
    end

    function ENT:Use(ply)
        nzExoSuit(ply, true)
    end
end