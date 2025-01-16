AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "ARC-XD"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    function ENT:Setup(ply)
        self.PlayerInit = true
        ply:ConCommand("cl_drawhud 0")
        ply:SetTargetPriority(0)
        ply:GodEnable()
    end

    function ENT:Desetup(ply)
        ply:SetActiveWeapon(nil)
        ply:ConCommand("cl_drawhud 1")
        ply:SetUsingSpecialWeapon(false)
        ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
        if IsValid(ply:GetPreviousWeapon()) then
            ply:SelectWeapon(ply:GetPreviousWeapon():GetClass())
        end
        ply:GodDisable()
        ply:ScreenFade(SCREENFADE.IN, color_black, 0.5, 1)
        ply:SetEyeAngles(Angle(0,ply:EyeAngles().y,0))
    end

    function ENT:Initialize()
        self:SetModel("models/hari/props/rcxd.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(true)
        self:SetUseType(SIMPLE_USE)
        self:SetTargetPriority(TARGET_PRIORITY_ALWAYS)
        self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
        self:SetModelScale(1.5)

        timer.Simple(45, function()
            if !IsValid(self) then return end
            self:Detonate()
        end)
        
        if not self.Player then
            self.Player = Entity(1)
        end
        self.MaxSpeed = 0
        self.Speed = 0
        self.TargetDirection = Vector(0, 0, 0)  
        self.LastAngles = self:GetAngles()
        self.EngineSound = CreateSound(self, "ambient/machines/diesel_engine_idle1.wav")
        self.EngineSound:Play()
        self.EngineSound:ChangePitch(150)
        self.EngineSound:SetSoundLevel(70)
        self.AetherDelay = CurTime()+2

        local ply = self.Player
        if IsValid(ply) then
            ply:ScreenFade(SCREENFADE.IN, color_black, 0.5, 0.5)
            ply:SetEyeAngles(Angle(0,ply:EyeAngles().y,0))
            ply.RCXDEnt = self
            timer.Simple(0.4, function()
                if !IsValid(ply) or !IsValid(self) then return end
                net.Start("nzrRCXDControl")
                net.WriteEntity(self)
                net.Send(ply)
                self.CanRotate = true
            end)
        end
    end

    function ENT:CalculateSmoothedAngles()
        local ply = self.Player
        if !IsValid(ply) or (self.Speed < 10 and self.Speed > -10) or !self:Ground() then return end

        if not self.LastAngles then
            self.LastAngles = self:GetAngles()
        end
    
        local currentAngles = self:GetAngles()
        local targetAngles = Angle(0,ply:EyeAngles().y,0)
    
        self.LastAngles = LerpAngle(0.1, self.LastAngles, targetAngles)
    
        self:SetAngles(self.LastAngles)
    end

    function ENT:Controls()
        local ply = self.Player
        if !IsValid(ply) then return end

        if not self.PlayerInit then
            self:Setup(ply)
        end

        ply:SetActiveWeapon(nil)

        if ply:KeyDown(IN_ATTACK) and not self.Detonated or !util.IsInWorld(self:GetPos()) then
            self:Detonate()
        elseif ply:KeyDown(IN_JUMP) and not self.DisableVel and self:Ground() then
            self:EmitSound("vehicles/v8/vehicle_impact_medium1.wav", 60, 120)
            self.DisableVel = true
            timer.Simple(1, function()
                if !IsValid(self) then return end
                self.DisableVel = false
            end)
            local phys = self:GetPhysicsObject()
            if IsValid(phys) then
                phys:SetVelocity(self.TargetDirection * self.Speed + Vector(0,0,280))
            end
        end
        if ply:KeyDown(IN_FORWARD) then
            self.TargetDirection = self:GetForward()
            self.MaxSpeed = 250
            local tr = util.TraceLine({
                start = self:WorldSpaceCenter(),
                endpos = self:WorldSpaceCenter()+self:GetForward()*32,
                filter = self
            })
            if tr.Hit then
                self.MaxSpeed = 0
            end
        elseif ply:KeyDown(IN_BACK) then
            self.TargetDirection = self:GetForward()
            self.MaxSpeed = -100
            local tr = util.TraceLine({
                start = self:WorldSpaceCenter(),
                endpos = self:WorldSpaceCenter()-self:GetForward()*32,
                filter = self
            })
            if tr.Hit then
                self.MaxSpeed = 0
            end
        else
            self.MaxSpeed = 0
        end
    end

    function ENT:Detonate()
        if self.Detonated then return end
        self.Detonated = true 
        local ply = self.Player

        self:EmitSound(")ambient/explosions/explode_4.wav", 100)
        ParticleEffect("doi_frag_explosion", self:GetPos(), Angle(-90,0,0))
        util.BlastDamage(self, ply or self, self:GetPos(), 256, 10000)
        util.Decal("Scorch", self:GetPos()+Vector(0,0,32), self:GetPos()-Vector(0,0,128), self)

        self:Remove()
    end

    function ENT:OnRemove()
        self:StopSound("ambient/machines/diesel_engine_idle1.wav")
        if IsValid(self.Player) then 
            self:Desetup(self.Player)
        end
    end

    function ENT:Ground()
        local tr = util.TraceLine({
            start = self:GetPos(),
            endpos = self:GetPos()-Vector(0,0,4),
            filter = self
        })
        return tr.Hit
    end

    function ENT:Think()
        local phys = self:GetPhysicsObject()
        if IsValid(phys) and not self.DisableVel then
            if self:Ground() then
                local dir = self.TargetDirection
                self.Speed = Lerp(self.MaxSpeed > 0 and 0.01 or 0.1, self.Speed, self.MaxSpeed)
                if self.Speed > 10 or self.Speed < -10 then
                    phys:SetVelocity(dir * self.Speed - Vector(0,0,2))
                end
                phys:SetMass(10000)
            end
        end

        for _, ent in pairs(ents.FindInSphere(self:GetPos(), 24)) do
            if ent:IsNextBot() and ent:Health() > 0 then
                self:Detonate()
                break
            end
        end

        local ply = self.Player
        if self.CanRotate and IsValid(ply) then
            self:CalculateSmoothedAngles()
            self:Controls()
        end
        if self.AetherDelay < CurTime() and IsValid(ply) then
            self.AetherDelay = CurTime()+2
            ParticleEffect("bo3_mangler_blast", self:GetPos(), Angle(0,0,0), self)
            self:EmitSound("ambient/levels/citadel/weapon_disintegrate2.wav", 70, math.random(90,120))
            for _, ent in pairs(ents.FindInSphere(self:GetPos(), 180)) do
                if ent:IsNextBot() then
                    ent:TakeDamage(ent:Health(), self.Player or self)
                end
            end
        end

        self.EngineSound:ChangeVolume(0.4*math.abs(0.2+self.Speed/250))
        self.EngineSound:ChangePitch(120+math.abs(30*(self.Speed/250)))

        self:NextThink(CurTime())
        return true
    end

    util.AddNetworkString("nzrRCXDControl")

    hook.Add("SetupPlayerVisibility", "nzrRCXDControl", function(ply)
        if IsValid(ply.RCXDEnt) then
            AddOriginToPVS(ply.RCXDEnt:GetPos())
        end
    end)
    
    local CMoveData = FindMetaTable("CMoveData")
    function CMoveData:RemoveKeys(keys)
        local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
        self:SetButtons(newbuttons)
    end
    hook.Add("SetupMove", "nzrRCXDControl", function(ply, mv, cmd)
        if IsValid(ply.RCXDEnt) then
            mv:SetForwardSpeed(0)
            mv:SetSideSpeed(0)
            mv:SetUpSpeed(0)
            if mv:KeyDown(IN_JUMP) then
                mv:RemoveKeys(IN_JUMP)
            end
        end
    end)
else
    function ENT:Initialize()
        self.projectedTexture = ProjectedTexture()
        self.projectedTexture:SetTexture("effects/flashlight001")
        self.projectedTexture:SetFOV(60)
        self.projectedTexture:SetFarZ(512)
    end

    function ENT:OnRemove()
        if IsValid(self.projectedTexture) then
            self.projectedTexture:Remove()
        end
    end

    function ENT:Draw()
        self:DrawModel()

        local dlight = DynamicLight(self:EntIndex())
        if dlight then
            dlight.pos = self:WorldSpaceCenter()
            dlight.r = 255
            dlight.g = 255
            dlight.b = 255
            dlight.brightness = 2
            dlight.decay = 1000
            dlight.size = 256
            dlight.dietime = CurTime() + 0.1
        end

        if IsValid(self.projectedTexture) then
            local pos = self:GetPos() + self:GetUp() * 10
            local ang = self:GetAngles()
    
            self.projectedTexture:SetPos(pos)
            self.projectedTexture:SetAngles(ang)
            self.projectedTexture:Update()
        end
    end

    local function We(x)
        return (x / 1920) * ScrW()
    end
    
    local function He(y)
        return (y / 1080) * ScrH()
    end

    local function CanSee(pos1, pos2)
        local tr = util.TraceLine( {
            start = pos1,
            endpos = pos2,
            filter = function(ent) if ent:IsWorld() then return true end end,
        })
        return !tr.Hit
    end

    local controlledEntity = nil

    net.Receive("nzrRCXDControl", function()
        controlledEntity = net.ReadEntity()
    end)

    local CMoveData = FindMetaTable("CMoveData")
    function CMoveData:RemoveKeys(keys)
        local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
        self:SetButtons(newbuttons)
    end
    hook.Add("SetupMove", "nzrKillstreaks_RCXD", function(ply, mv, cmd)
        if IsValid(controlledEntity) then
            mv:SetForwardSpeed(0)
            mv:SetSideSpeed(0)
            mv:SetUpSpeed(0)
            if mv:KeyDown(IN_JUMP) then
                mv:RemoveKeys(IN_JUMP)
            end
        end
    end)

    hook.Add("CalcView", "nzrKillstreaks_RCXD", function(ply, pos, angles, fov)
        if IsValid(controlledEntity) then
            local view = {}
            view.origin = controlledEntity:GetPos() + angles:Forward() * -64 + Vector(0,0,24)
            view.angles = angles
            view.fov = fov
            view.drawviewer = true
            return view
        end
    end)

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
    hook.Add("RenderScreenspaceEffects", "nzrKillstreaks_RCXD", function()
        if IsValid(controlledEntity) then
            DrawColorModify(tab)
        end
    end)

    local screenMat = Material("bo6/hud/screenglitch.jpg", "noclamp")
    local enemyMat = Material("bo6/hud/enemy.png", "noclamp")
    local RCXDDespawnTime = CurTime()+44
    hook.Add("HUDPaint", "nzrKillstreaks_RCXD", function()
        local ply = LocalPlayer()
        if IsValid(controlledEntity) then
            surface.SetMaterial(screenMat)
            surface.SetDrawColor(125,125,125,125)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

            surface.SetDrawColor(255,255,255)
            surface.DrawOutlinedRect(We(50), He(50), ScrW()-We(100), ScrH()-He(100), 2)

            draw.SimpleText("✷ ARC-XD", "BO6_Exfil48", We(100), He(100), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText("ACTIVE", "BO6_Exfil48", We(100), He(130), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

            draw.SimpleText("EXPLODE [LMB]", "BO6_Exfil48", ScrW()-We(100), ScrH()-He(190), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
            draw.SimpleText("JUMP [SPACE]", "BO6_Exfil48", ScrW()-We(100), ScrH()-He(160), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)

            local percent = math.max((RCXDDespawnTime-CurTime())/45, 0)

            surface.SetDrawColor(75,150,200)
            surface.DrawRect(We(120), ScrH()-He(180), We(300)*percent, He(20))
            surface.SetDrawColor(100,100,100,200)
            surface.DrawOutlinedRect(We(120), ScrH()-He(180), We(300), He(20), 2)

            draw.SimpleText("BATTERY", "BO6_Exfil48", We(120), ScrH()-He(190), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

            for _, ent in ipairs(ents.GetAll()) do
                if (ent:IsNPC() or ent:IsNextBot()) and ent:Health() > 0 then
                    local pos = ent:WorldSpaceCenter():ToScreen()
    
                    if CanSee(EyePos(), ent:WorldSpaceCenter()) then
                        surface.SetDrawColor(200,0,0,255)
                    elseif ent:WorldSpaceCenter():DistToSqr(EyePos()) < 1500000 then
                        surface.SetDrawColor(255,255,255,100)
                        surface.DrawRect(pos.x-1, pos.y-5, 1, 10)
                        surface.SetDrawColor(255,255,255,100)
                        surface.DrawRect(pos.x-5, pos.y-1, 10, 1)
    
                        surface.SetDrawColor(200,200,200,50)
                    else
                        surface.SetDrawColor(0,0,0,0)
                    end
                    surface.SetMaterial(enemyMat)
                    surface.DrawTexturedRect(pos.x-20, pos.y-20, 40, 40)
                end
            end
        else
            RCXDDespawnTime = CurTime()+45
        end
    end)
end