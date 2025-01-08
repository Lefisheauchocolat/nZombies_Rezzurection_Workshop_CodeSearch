AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Hellstorm Rocket"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    RunConsoleCommand("sv_maxvelocity", "5000")

    function ENT:Initialize()
        self:SetModel("models/bo6/ks/cruisemissile.mdl")
        self:SetBodygroup(2, 1)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(true)
        self:SetUseType(SIMPLE_USE)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    end
    function ENT:PhysicsCollide(data)
        self:Detonate()
    end

    function ENT:Detonate()
        if self.Detonated then return end
        self.Detonated = true 

        self:EmitSound(")ambient/explosions/explode_1.wav", 120)
        ParticleEffect("doi_splinter_explosion", self:GetPos(), Angle(-90,0,0))
        ParticleEffect("doi_ceilingDust_large", self:GetPos(), Angle(-90,0,0))
        util.BlastDamage(self, self.Player or self, self:GetPos(), 1024, 5000)
        util.Decal("Scorch", self:GetPos()+Vector(0,0,32), self:GetPos()-Vector(0,0,128), self)

        self:Remove()
    end

    function ENT:Think()
        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            local dir = self:GetForward()
            self.Speed = 5000
            phys:SetVelocity(dir * self.Speed)
            phys:SetMass(10000)
        end

        self:NextThink(CurTime())
        return true
    end

    local tab = {
        [ "$pp_colour_addr" ] = 0,
        [ "$pp_colour_addg" ] = 0,
        [ "$pp_colour_addb" ] = 0,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 0.9,
        [ "$pp_colour_colour" ] = 0.1,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0,
        [ "$pp_colour_mulb" ] = 0
    }
    hook.Add("RenderScreenspaceEffects", "nzrKillstreaks_Hellstorm", function()
        if IsValid(controlledEntity) then
            DrawColorModify(tab)
        end
    end)
end