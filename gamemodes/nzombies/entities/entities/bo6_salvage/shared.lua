AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Salvage"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/bo6/killstreak/loot_salvage.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(true)
        self:SetUseType(SIMPLE_USE)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self:SetNWString("OutlineType", "salvage")
    end

    function ENT:Think()
        local ang = self:GetAngles()
        self:SetAngles(Angle(0,ang.y,0))
    end
end