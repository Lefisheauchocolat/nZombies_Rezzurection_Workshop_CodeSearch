AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Napalm Strike"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    function ENT:AddNapalmFire()
        local pos = self:GetPos()
        local tr = util.TraceLine({
            start = pos+Vector(0,0,500),
            endpos = pos+Vector(math.random(-512,512),math.random(-512,512),-64),
            filter = self
        })
        if tr.HitPos and !tr.HitSky then
            pos = tr.HitPos+Vector(0,0,2)
            ParticleEffect("bo3_napalm_explosion", pos, Angle(0,0,0))
            table.insert(self.NapalmPositions, pos)
            EmitSound("ambient/fire/gascan_ignite1.wav", pos, 0, CHAN_AUTO, 1, 80, SND_NOFLAGS, math.random(80,110))
            util.Decal("Scorch", pos+Vector(0,0,32), pos-Vector(0,0,128), self)
            timer.Simple(7, function()
                if !IsValid(self) then return end
                table.RemoveByValue(self.NapalmPositions, pos)
            end)
        end
    end

    function ENT:Detonate()
        if self.Detonated then return end
        self.Detonated = true 
        self:EmitSound(")ambient/explosions/explode_9.wav", 110)
        util.ScreenShake(self:GetPos(), 10, 10, 5, 2048)
        SafeRemoveEntityDelayed(self, 15)
        ParticleEffect("doi_mortar_explosion", self:GetPos(), Angle(-90,0,0))

        for i = 1, 25 do
            timer.Simple((i-1)/25, function()
                if !IsValid(self) then return end
                self:AddNapalmFire()
            end)
            timer.Simple(7+(i-1)/25, function()
                if !IsValid(self) then return end
                self:AddNapalmFire()
            end)
        end
    end

    function ENT:Think()
        for _, pos in pairs(self.NapalmPositions) do
            for _, ent in pairs(ents.FindInSphere(pos, 200)) do
                if ent:IsNextBot() then
                    ent:Ignite(10)
                    if string.match(ent:GetClass(), "_boss") then
                        ent:TakeDamage(ent:Health(), self.Player or self)
                    else
                        ent:TakeDamage(ent:Health()/4, self.Player or self)
                    end
                end
            end
        end
        self:NextThink(CurTime()+1)
        return true
    end

    function ENT:Initialize()
        self:SetModel("models/hunter/plates/plate025x025.mdl")
        self:EmitSound("bo6/other/napalm.wav", 110)
        self:DrawShadow(false)
        self:SetNotSolid(true)
        self:SetNoDraw(true)
        self.NapalmPositions = {}
        timer.Simple(1.5, function()
            if !IsValid(self) then return end
            local p = ents.Create("prop_dynamic")
            p:SetModel("models/bo6/ks/f4.mdl")
            p:SetMaterial("phoenix_storms/dome")
            p:SetPos(self:GetPos())
            p:SetAngles(Angle(0,math.random(0,360),0))
            p:Spawn()
            p:ResetSequence("action")
            SafeRemoveEntityDelayed(p, 6)
        end)
        timer.Simple(4, function()
            if !IsValid(self) then return end
            self:EmitSound("bo6/other/mortar.wav", 90)
        end)
        timer.Simple(4.5, function()
            if !IsValid(self) then return end
            local p = ents.Create("prop_physics")
            p:SetModel("models/bo6/ks/cruisemissile.mdl")
            p:SetMaterial("phoenix_storms/dome")
            p:SetPos(self:GetPos()+Vector(0,0,1500))
            p:SetAngles(Angle(90,math.random(0,360),0))
            p:Spawn()
            p:SetBodygroup(2, 1)
            p:PhysicsInit(SOLID_VPHYSICS)
            p:SetNotSolid(true)
            p:GetPhysicsObject():SetVelocity(Vector(0,0,-2500))
            SafeRemoveEntityDelayed(p, 1)
        end)
        timer.Simple(5, function()
            if !IsValid(self) then return end
            self:Detonate()
        end)
    end
end