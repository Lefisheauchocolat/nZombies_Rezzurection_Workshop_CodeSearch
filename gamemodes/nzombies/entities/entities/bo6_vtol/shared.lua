AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "VTOL Jet"
ENT.AutomaticFrameAdvance = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/bo6/ks/harrier.mdl")
        self:SetHealth(3500)
        self.Velo = {x = 0, y = 0}
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysicsInit(SOLID_VPHYSICS)
        self.Height = self:GetPos().z+nzSettings:GetSimpleSetting("BO6_Killstreak_VTOLHeight", 1500)
        self.DisableThinkPart = false
        self.CantBeDamaged = true
        self.FireDelay = CurTime() + 1
        self.SeekDelay = CurTime() + 2
        self:SetNWFloat('RemoveTime', CurTime() + 45)
        self.Removing = false
        self.Target = nil
        self.Team = 1
        self.Actions = {
            ["MoveForward"] = false,
            ["MoveBack"] = false,
            ["MoveLeft"] = false,
            ["MoveRight"] = false,
        }
        self:SetBodygroup(3, 1)
        self:SetBodygroup(4, 1)
        self:ManipulateBoneScale(10, Vector(0,0,0))
        self:ManipulateBoneScale(11, Vector(0,0,0))
        self:ManipulateBoneScale(7, Vector(0,0,0))
        timer.Simple(1, function()
            if !IsValid(self) then return end
            self:EmitSound("ambient/machines/aircraft_distant_flyby3.wav", 90, 90, 1)
        end)
        timer.Simple(2, function()
            if !IsValid(self) then return end
            self:Bombs()
        end)
        self:PlaySeq("arrive", 10, function()
            self:EmitSound(")ambient/energy/force_field_loop1.wav", 90, 70, 1)
        end)
    end

    function ENT:PlaySeq(name, long, onfinish)
        self:SetCycle(0)
        self:ResetSequence(name)
        self.CantBeDamaged = true
        self:SetNotSolid(true)

        if !isfunction(onfinish) then
            onfinish = function() end
        end

        timer.Create("VTOLAnim"..self:EntIndex(), long, 1, function()
            if !IsValid(self) then return end

            self:ResetSequence("idle")
            self:SetNotSolid(false)
            self.CantBeDamaged = false
            onfinish()
        end)
    end

    function ENT:Bombs()
        local pos1 = self:GetPos()+self:GetForward()*200-Vector(0,0,nzSettings:GetSimpleSetting("BO6_Killstreak_VTOLHeight", 1500))
        local pos2 = self:GetPos()-self:GetForward()*200-Vector(0,0,nzSettings:GetSimpleSetting("BO6_Killstreak_VTOLHeight", 1500))

        local p = ents.Create("prop_physics")
        p:SetModel("models/bo6/ks/cruisemissile.mdl")
        p:SetMaterial("phoenix_storms/dome")
        p:SetPos(pos1+Vector(0,0,nzSettings:GetSimpleSetting("BO6_Killstreak_VTOLHeight", 1500)))
        p:SetAngles(Angle(90,math.random(0,360),0))
        p:Spawn()
        p:SetBodygroup(2, 1)
        p:PhysicsInit(SOLID_VPHYSICS)
        p:SetNotSolid(true)
        p:GetPhysicsObject():SetVelocity(Vector(0,0,-1500))
        SafeRemoveEntityDelayed(p, 1)
        self:EmitSound("bo6/other/mortar.wav", 90)
        
        timer.Simple(0.3, function()
            if !IsValid(self) then return end

            local p = ents.Create("prop_physics")
            p:SetModel("models/bo6/ks/cruisemissile.mdl")
            p:SetMaterial("phoenix_storms/dome")
            p:SetPos(pos2+Vector(0,0,nzSettings:GetSimpleSetting("BO6_Killstreak_VTOLHeight", 1500)))
            p:SetAngles(Angle(90,math.random(0,360),0))
            p:Spawn()
            p:SetBodygroup(2, 1)
            p:PhysicsInit(SOLID_VPHYSICS)
            p:SetNotSolid(true)
            p:GetPhysicsObject():SetVelocity(Vector(0,0,-1500))
            SafeRemoveEntityDelayed(p, 1)
            self:EmitSound("bo6/other/mortar.wav", 90)
        end)
        timer.Simple(1, function()
            if !IsValid(self) then return end

            EmitSound(")ambient/explosions/explode_9.wav", pos1, 0, CHAN_AUTO, 1, 110)
            util.ScreenShake(pos1, 10, 10, 5, 2048)
            ParticleEffect("doi_mortar_explosion", pos1, Angle(-90,0,0))
            util.Decal("Scorch", pos1+Vector(0,0,32), pos1-Vector(0,0,128), self)
            for _, ent in pairs(ents.FindInSphere(pos1, 512)) do
                if ent:IsNextBot() then
                    if string.match(ent:GetClass(), "_boss") then
                        ent:TakeDamage(ent:Health()*12, self.Player or self)
                    else
                        ent:TakeDamage(ent:Health()*4, self.Player or self)
                    end
                end
            end
        end)
        timer.Simple(1.3, function()
            if !IsValid(self) then return end

            EmitSound(")ambient/explosions/explode_9.wav", pos2, 0, CHAN_AUTO, 1, 110)
            util.ScreenShake(pos2, 10, 10, 5, 2048)
            ParticleEffect("doi_mortar_explosion", pos2, Angle(-90,0,0))
            util.Decal("Scorch", pos2+Vector(0,0,32), pos2-Vector(0,0,128), self)
            for _, ent in pairs(ents.FindInSphere(pos2, 512)) do
                if ent:IsNextBot() then
                    if string.match(ent:GetClass(), "_boss") then
                        ent:TakeDamage(ent:Health()*12, self.Player or self)
                    else
                        ent:TakeDamage(ent:Health()*4, self.Player or self)
                    end
                end
            end
        end)
    end 

    function ENT:OnRemove()
        self:StopSound(")ambient/energy/force_field_loop1.wav")
    end

    function ENT:GetTurretPos()
        local bone = self:GetPos()+self:GetForward()*96
        return bone
    end
    
    function ENT:Attack()
        local tar = self.Target

        if !IsValid(tar) then
            local tab = ents.FindInSphere(self:GetPos(), 4096)
            table.Shuffle(tab)
            for _, ent in ipairs(tab) do
                if self:VisibleVec(ent:GetPos()) then
                    if ent:IsNextBot() and ent:Health() > 0 then
                        self.Target = ent
                        break
                    end
                end
            end
        end

        if IsValid(tar) and self.FireDelay < CurTime() then
            self.FireDelay = CurTime() + 0.05

            if self:AngleToEnemy(tar) < 45 and self.SeekDelay < CurTime() then
                local dir = (tar:WorldSpaceCenter()-self:GetTurretPos()):GetNormalized()

                self:EmitSound(")weapons/ar2/fire1.wav", 90, 85, 1, CHAN_WEAPON)
                self:FireBullets({
                    IgnoreEntity = self,
                    Spread = VectorRand(-0.02, 0.02),
                    Damage = 25,
                    Dir = dir,
                    Src = self:GetTurretPos(),
                })
            end

            if not self:VisibleVec(tar:GetPos()) or tar:Health() <= 0 then
                self.SeekDelay = CurTime() + 0.4
                self.Target = nil
            end
        end
    end

    function ENT:AngleToEnemy(enemy)
        local selfAngles = self:GetAngles()
        local enemyPos = enemy:GetPos()
        local angleToEnemy = (enemyPos - self:GetPos()):Angle()
        angleToEnemy.x = 0
        angleToEnemy.z = 0
        local diff = math.AngleDifference(angleToEnemy.y, selfAngles.y)
        return math.abs(diff)
    end

    function ENT:RotateToEntity(ent2, divisor)
        local ent1Angles = self:GetAngles()
        local targetAngles = (ent2:GetPos() - self:GetPos()):Angle()
        local yawDiff = math.NormalizeAngle(targetAngles.y - ent1Angles.y)
        
        self:SetAngles(Angle(0, ent1Angles.y + yawDiff / divisor, 0))
    end

    function ENT:Controls()
        local tar = self.Target
        if IsValid(tar) then
            self:RotateToEntity(tar, 45)
        end
    end

    function ENT:Think()
        local mu = self.MultSpeed
        local ms = self.MaxSpeed
        local vel = self:GetPhysicsObject():GetVelocity()
        vel.z = 0

        if not self.DisableThinkPart then
            if not self.CantBeDamaged then
                self:Attack()
                self:Controls()
            end

            local pos = self:GetPos()
            self:SetPos(Vector(pos.x, pos.y, self.Height))
            local ang = self:GetAngles().y
            self:SetAngles(Angle(0,ang,0))

            if self:GetNWFloat('RemoveTime') < CurTime() and not self.Removing and not self.DisableThinkPart then
                self.Removing = true
                self:EmitSound("ambient/machines/aircraft_distant_flyby1.wav", 90, 90, 1)
                self:StopSound("ambient/energy/force_field_loop1.wav")
                self:PlaySeq("finish", 4, function()
                    self:Remove()
                end)
            end
        end

        self:ManipulateBoneAngles(0, Angle(0,(math.sin(CurTime())*4),(math.sin(CurTime()*2)*4)))
        self:ManipulateBonePosition(0, Vector(0,0,(math.sin(CurTime())*10)))

        self:NextThink(CurTime())
        return true
    end
end
