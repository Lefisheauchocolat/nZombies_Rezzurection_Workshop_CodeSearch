AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Armor Plate"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/hunter/plates/plate025x025.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(true)
        self:SetUseType(SIMPLE_USE)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

        local prop = ents.Create("base_anim")
        prop:SetModel("models/nzr/2024/plate/world/wm_iw9_plate.mdl")
        prop:SetPos(self:GetPos())
        prop:SetAngles(self:GetAngles())
        prop:SetParent(self)
        prop:SetLocalPos(Vector(0,0,-7))
        prop:SetLocalAngles(Angle(0,90,0))
        prop:SetNWString("OutlineType", "armorplate")
        self:SetNoDraw(true)
        self:DeleteOnRemove(prop)
    end
end