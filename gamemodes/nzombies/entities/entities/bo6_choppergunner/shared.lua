AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Chopper Gunner"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    ENT.Waypoints = {}

    function ENT:Initialize()
        self:SetModel("models/bo6/chopper/mwlittlebird.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(false)
        self:SetUseType(SIMPLE_USE)
        self:SetNotSolid(true)

        self.CurrentWaypoint = 1
        self.StartTime = CurTime()
        if not self.Player then
            self.Player = Entity(1)
        end
        self.EquipTime = CurTime()+1.5

        local crew = ents.Create("base_anim")
        crew:SetModel("models/bo6zm_pilot.mdl")
        crew:SetPos(self:GetPos()+self:GetForward()*32-self:GetRight()*16+self:GetUp()*-64)
        crew:SetAngles(self:GetAngles())
        crew:Spawn()
        crew:SetParent(self)
        crew:ResetSequence("sit")
        crew:ManipulateBoneAngles(crew:LookupBone("ValveBiped.Bip01_R_Upperarm"), Angle(20, -60, 0), true)
        crew:ManipulateBoneAngles(crew:LookupBone("ValveBiped.Bip01_R_Forearm"), Angle(-45, 30, 0), true)
        crew:ManipulateBoneAngles(crew:LookupBone("ValveBiped.Bip01_R_Hand"), Angle(-140, 90, -30), true)
        crew:ManipulateBoneAngles(crew:LookupBone("ValveBiped.Bip01_R_Calf"), Angle(0, -55, 0), true)
        crew:ManipulateBoneAngles(crew:LookupBone("ValveBiped.Bip01_L_Calf"), Angle(22, -55, 0), true)
        crew:ManipulateBoneAngles(crew:LookupBone("ValveBiped.Bip01_R_Foot"), Angle(0, 20, 0), true)
        crew:ManipulateBoneAngles(crew:LookupBone("ValveBiped.Bip01_L_Foot"), Angle(0, 20, 0), true)
        self:DeleteOnRemove(crew)

        for _, p in pairs(ents.FindByClass("bo6_choppergunner_point")) do
            table.insert(self.Waypoints, {pos = p:GetPos(), ang = Angle(0,p:GetAngles().y,0)})
        end
        if #self.Waypoints <= 1 then
            self.Stop = true
            self:Remove()
        end
    end

    function ENT:MoveAlongWaypoints()
        local elapsedTime = CurTime() - self.StartTime
        local progress = math.Clamp(elapsedTime / nzSettings:GetSimpleSetting("BO6_Killstreak_ChopperTime", 30), 0, 1)
        
        if self.CurrentWaypoint < #self.Waypoints then
            local startPos = self.Waypoints[self.CurrentWaypoint].pos
            local startAng = self.Waypoints[self.CurrentWaypoint].ang
            local endPos = self.Waypoints[self.CurrentWaypoint + 1].pos
            local endAng = self.Waypoints[self.CurrentWaypoint + 1].ang
            
            local segmentProgress = (progress * (#self.Waypoints - 1)) - (self.CurrentWaypoint - 1)
            if segmentProgress >= 1 then
                self.CurrentWaypoint = self.CurrentWaypoint + 1
                if self.CurrentWaypoint >= #self.Waypoints then
                    self:SetPos(self.Waypoints[#self.Waypoints].pos)
                    self:SetAngles(self.Waypoints[#self.Waypoints].ang)
                    return
                end
            else
                local currentPos = LerpVector(segmentProgress, startPos, endPos)
                local currentAng = LerpAngle(segmentProgress, startAng, endAng)
                self:SetPos(currentPos)
                self:SetAngles(currentAng)
            end
        else
            self:Finish()
        end
    end

    function ENT:Setup(ply)
        ply.KS_LastPosition = ply:GetPos()
        ply:SetActiveWeapon(nil)
        local wep = ply:Give("bo6_deathmachine")
        ply:GodEnable()
        ply:ScreenFade(SCREENFADE.IN, color_black, 0.5, 1)
        ply:SetMoveParent(self)
        ply:ConCommand("cl_drawhud 0")
        ply:SetTargetPriority(0)
        timer.Simple(0.5, function()
            if !IsValid(self) or !IsValid(ply) then return end
            ply:SetEyeAngles(Angle(20,self:GetAngles().y+140,0))
        end)
        ply:SendLua([[LocalPlayer():EmitSound("bo6/heli/chopper_theme.mp3")]])
    end

    function ENT:Desetup(ply)
        if !IsValid(ply) then return end
        ply:SetActiveWeapon(nil)
        ply:StripWeapon("bo6_deathmachine")
        ply:ConCommand("cl_drawhud 1")
        ply:ConCommand("stopsound")
        ply:SetUsingSpecialWeapon(false)
        ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
        if IsValid(ply:GetPreviousWeapon()) then
            ply:SelectWeapon(ply:GetPreviousWeapon():GetClass())
        end
        ply:GodDisable()
        ply:SetMoveType(2)
        ply:ScreenFade(SCREENFADE.IN, color_black, 0.5, 1)
        ply:SendLua([[LocalPlayer():StopSound("bo6/heli/chopper_theme.mp3")]])
        if isvector(ply.KS_LastPosition) then
            timer.Simple(0.1, function()
                if !IsValid(ply) then return end
                ply:SetPos(ply.KS_LastPosition)
                ply:SetVelocity(Vector(0,0,0))
                ply.KS_LastPosition = nil
            end)
        end
    end

    function ENT:TeleportPlayer()
        local ply = self.Player
        if IsValid(ply) and !isvector(ply.KS_LastPosition) then
            self:Setup(ply)
        elseif IsValid(ply) then
            local leftEdge = self:GetPos() + self:GetRight() * -48 + self:GetUp() * -102 + self:GetForward() * 8
            ply:SetPos(leftEdge)
            ply:SetMoveType(0)
            if self.EquipTime < CurTime() then
                ply:SelectWeapon("bo6_deathmachine")
            else
                ply:SetActiveWeapon(nil)
            end
        end
    end

    function ENT:Rotors()
        self:ManipulateBoneAngles(0, Angle(0,270,0))
        self:ManipulateBoneAngles(22, self:GetManipulateBoneAngles(22)+Angle(0,30,0))
        self:ManipulateBoneAngles(3, self:GetManipulateBoneAngles(3)+Angle(0,30,0))
        self:SetBodygroup(5, 1)
        self:SetBodygroup(6, 1)
    end

    function ENT:Think()
        if not self.Stop then
            self:MoveAlongWaypoints()
            self:TeleportPlayer()
            self:Rotors()
        end
        self:NextThink(CurTime())
        return true
    end

    function ENT:Finish()
        local ply = self.Player
        self.Stop = true
        if IsValid(ply) then
            timer.Simple(0.1, function()
                if !IsValid(self) then return end
                self:Remove()
            end)
        else
            self:Remove()
        end
    end

    function ENT:OnRemove()
        self:Desetup(self.Player)
    end
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

    local enemyMat = Material("bo6/hud/enemy.png", "noclamp")
    local chopperIcon = Material("bo6/hud/chopper.png", "mips")
    local ChopperDespawnTime = 0
    hook.Add("HUDPaint", "nzrKillstreaks_Chopper", function()
        local ply = LocalPlayer()
        if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "bo6_deathmachine" then
            local percent = math.max((ChopperDespawnTime-CurTime())/nzSettings:GetSimpleSetting("BO6_Killstreak_ChopperTime", 30), 0)

            surface.SetDrawColor(20,20,20,180)
            surface.DrawRect(We(40), ScrH()-He(130), We(400), He(80))

            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(chopperIcon)
            surface.DrawTexturedRect(We(44), ScrH()-He(126), We(68), He(72))

            surface.SetDrawColor(20,20,20,240)
            surface.DrawRect(We(120), ScrH()-He(90), We(300), He(20))
            surface.SetDrawColor(75,200,0)
            surface.DrawRect(We(120), ScrH()-He(90), We(300)*percent, He(20))
            surface.SetDrawColor(100,100,100,200)
            surface.DrawOutlinedRect(We(120), ScrH()-He(90), We(300), He(20), 2)

            draw.SimpleText("CHOPPER GUNNER", "BO6_Exfil26", We(120), ScrH()-He(95), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

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
            ChopperDespawnTime = CurTime()+(nzSettings:GetSimpleSetting("BO6_Killstreak_ChopperTime", 30)-1)
        end
    end)
end