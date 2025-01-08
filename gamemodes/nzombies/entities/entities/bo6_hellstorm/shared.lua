AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Hellstorm"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    function ENT:Setup(ply)
        self.PlayerInit = true
        ply:SendLua([[LocalPlayer():EmitSound('weapons/rpg/rocket1.wav', 0, 90)]])
        ply:ConCommand("cl_drawhud 0")
        ply:SetTargetPriority(0)
        ply:GodEnable()
    end

    function ENT:Desetup(ply)
        ply:SetActiveWeapon(nil)
        ply:ConCommand("cl_drawhud 1")
        ply:SendLua([[LocalPlayer():StopSound('weapons/rpg/rocket1.wav', 0, 90)]])
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
        self:SetModel("models/bo6/ks/cruisemissile.mdl")
        self:SetBodygroup(2, 1)
        self:SetModelScale(3)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(true)
        self:SetUseType(SIMPLE_USE)
        self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self.StartYaw = math.random(0,360)
        self:SetAngles(Angle(90,self.StartYaw,0))
        
        if not self.Player then
            self.Player = Entity(1)
        end
        self.Acceleration = 0
        self.MaxSpeed = 4500
        self.Speed = nzSettings:GetSimpleSetting("BO6_Killstreak_HellstormSpeed", 1000)
        self.TargetDirection = Vector(0, 0, -1)  
        self.LastAngles = self:GetAngles()
        self.MissleTime = 0
        self.Missles = 3

        local tab = ents.FindByClass("bo6_hellstorm_point")
        if #tab <= 0 then
            self:Remove()
            return
        else
            local ne = nil
            local nd = math.huge
            for _, ent in pairs(tab) do
                local dist = self:GetPos():DistToSqr(ent:GetPos())
                if dist < nd then
                    nd = dist
                    ne = ent
                end
            end
            if ne then
                self:SetPos(ne:GetPos())
            end
        end

        local ply = self.Player
        if IsValid(ply) then
            ply:ScreenFade(SCREENFADE.IN, color_black, 0.5, 0.5)
            ply:SetEyeAngles(Angle(0,self.StartYaw,0))
            ply.HellstormEnt = self
            timer.Simple(0.4, function()
                if !IsValid(ply) or !IsValid(self) then return end
                net.Start("nzrHellstormControl")
                net.WriteEntity(self)
                net.Send(ply)
                self.CanRotate = true
            end)
        end
    end

    function ENT:CalculateSmoothedAngles()
        local ply = self.Player
        if !IsValid(ply) then return end

        if not self.LastAngles then
            self.LastAngles = self:GetAngles()
        end
    
        local currentAngles = self:GetAngles()
        local targetAngles = ply:EyeAngles()+Angle(90,0,0)
    
        self.LastAngles = LerpAngle(0.01, self.LastAngles, targetAngles)
    
        self:SetAngles(self.LastAngles)
    end

    function ENT:Controls()
        local ply = self.Player
        if !IsValid(ply) then return end

        if not self.PlayerInit then
            self:Setup(ply)
        end

        ply:SetActiveWeapon(nil)

        if ply:KeyDown(IN_ATTACK) and not self.SpeedUp then
            self.SpeedUp = true
            ply:SendLua([[LocalPlayer():EmitSound('weapons/rpg/rocketfire1.wav', 0, 90)]])
        elseif ply:KeyDown(IN_ATTACK2) and self.Missles > 0 and self.MissleTime < CurTime() then
            self.Missles = self.Missles - 1
            self.MissleTime = CurTime()+0.5
            ply:SendLua([[LocalPlayer():EmitSound('weapons/rpg/rocketfire1.wav', 0, 110)]])

            local ent = ents.Create("bo6_hellstorm_rocket")
            local pos = self:GetPos() + self:GetUp() * -96 + self:GetRight()* -96
            if self.Missles == 1 then
                pos = self:GetPos() + self:GetUp() * -96 + self:GetRight()* 0
            elseif self.Missles == 0 then
                pos = self:GetPos() + self:GetUp() * -96 + self:GetRight()* 96
            end
            ent:SetPos(pos)
            ent:SetAngles(self:GetAngles())
            ent.Player = ply
            ent:Spawn()
        end
    end

    function ENT:PhysicsCollide(data)
        self:Detonate()
    end

    function ENT:Detonate()
        if self.Detonated then return end
        self.Detonated = true 
        local ply = self.Player

        self:EmitSound(")ambient/explosions/explode_2.wav", 120)
        ParticleEffect("doi_artillery_explosion", self:GetPos(), Angle(-90,0,0))
        ParticleEffect("doi_ceilingDust_large", self:GetPos(), Angle(-90,0,0))
        util.BlastDamage(self, ply or self, self:GetPos(), 2048, 10000)
        util.Decal("Scorch", self:GetPos()+Vector(0,0,32), self:GetPos()-Vector(0,0,128), self)

        self:Remove()
    end

    function ENT:OnRemove()
        if IsValid(self.Player) then 
            self:Desetup(self.Player)
        end
    end

    function ENT:Think()
        local phys = self:GetPhysicsObject()
        if IsValid(phys) then
            local dir = self:GetForward()
            self.Speed = math.min(self.Speed + self.Acceleration, self.MaxSpeed)
            phys:SetVelocity(dir * self.Speed)
            phys:SetMass(10000)
            if self.SpeedUp then
                self.Acceleration = self.Acceleration + FrameTime()/0.01
            end
        end

        local ply = self.Player
        if self.CanRotate and IsValid(ply) then
            self:CalculateSmoothedAngles()
            self:Controls()
        end

        self:NextThink(CurTime())
        return true
    end

    util.AddNetworkString("nzrHellstormControl")

    hook.Add("SetupPlayerVisibility", "nzrHellstormControl", function(ply)
        if IsValid(ply.HellstormEnt) then
            AddOriginToPVS(ply.HellstormEnt:GetPos())
        end
    end)
else
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

    net.Receive("nzrHellstormControl", function()
        controlledEntity = net.ReadEntity()
    end)

    hook.Add("CalcView", "HellstormThirdPersonView", function(ply, pos, angles, fov)
        if IsValid(controlledEntity) then
            local ang = controlledEntity:GetAngles()
            local view = {}
            view.origin = controlledEntity:GetPos() + controlledEntity:GetForward() * -72 + controlledEntity:GetUp() * 64 + VectorRand(-1,1)
            view.angles = controlledEntity:GetAngles()
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
    hook.Add("RenderScreenspaceEffects", "nzrKillstreaks_Hellstorm", function()
        if IsValid(controlledEntity) then
            DrawColorModify(tab)
        end
    end)

    local blocktab = {"+forward", "+back", "+moveleft", "+moveright", "+jump", "+duck"}
    hook.Add("PlayerBindPress", "nzrKillstreaks_Hellstorm", function(ply, bind, pressed)
        if IsValid(controlledEntity) and table.HasValue(blocktab, bind) then
            return true
        end
    end)

    local screenMat = Material("bo6/hud/screenglitch.jpg", "noclamp")
    local enemyMat = Material("bo6/hud/enemy.png", "noclamp")
    local ChopperDespawnTime = 0
    hook.Add("HUDPaint", "nzrKillstreaks_Hellstorm", function()
        local ply = LocalPlayer()
        if IsValid(controlledEntity) then
            surface.SetMaterial(screenMat)
            surface.SetDrawColor(125,125,125,125)
            surface.DrawTexturedRect(0, 0, ScrW(), ScrH())

            surface.SetDrawColor(255,255,255)
            surface.DrawOutlinedRect(We(50), He(50), ScrW()-We(100), ScrH()-He(100), 2)

            draw.SimpleText("✷ HELLSTORM", "BO6_Exfil48", We(100), He(100), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText("ACTIVE", "BO6_Exfil48", We(100), He(130), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

            draw.SimpleText("BOOST [LMB]", "BO6_Exfil48", ScrW()-We(100), ScrH()-He(190), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
            draw.SimpleText("SHOT ROCKET [RMB]", "BO6_Exfil48", ScrW()-We(100), ScrH()-He(160), color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)


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
        end
    end)
end