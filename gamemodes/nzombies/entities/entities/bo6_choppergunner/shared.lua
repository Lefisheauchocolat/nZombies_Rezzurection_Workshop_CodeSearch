AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Chopper Gunner"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

local add_time = 8
local function GetChopperTime()
    return nzSettings:GetSimpleSetting("BO6_Killstreak_ChopperTime", 30)+add_time
end

if SERVER then
    ENT.Waypoints = {}

    function ENT:Initialize()
        self:SetModel("models/hari/props/heli.mdl")
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
        self.EquipTime = CurTime()+4.5

        local crew = ents.Create("bo6_animated")
        crew:SetPos(self:GetPos())
        crew:SetAngles(self:GetAngles())
        crew:Spawn()
        crew:SetModel("models/bo6zm_pilot.mdl")
        crew:SetParent(self)
        crew:ResetSequence("bo6_choppergunner_pilot1_idle")
        self:DeleteOnRemove(crew)
        self.Pilot = crew

        local crew2 = ents.Create("bo6_animated")
        crew2:SetPos(self:GetPos())
        crew2:SetAngles(self:GetAngles())
        crew2:Spawn()
        crew2:SetModel("models/bo6zm_pilot.mdl")
        crew2:SetParent(self)
        crew2:ResetSequence("bo6_choppergunner_pilot2_idle")
        self:DeleteOnRemove(crew2)

        for _, p in pairs(ents.FindByClass("bo6_choppergunner_point")) do
            table.insert(self.Waypoints, {pos = p:GetPos(), ang = Angle(0,p:GetAngles().y,0)})
        end
        if #self.Waypoints <= 1 then
            self.Stop = true
            self:Remove()
        end
        timer.Simple(GetChopperTime()-3.6, function()
            if IsValid(self) and IsValid(self.Player) then
                self.Player:SetEyeAngles(self:GetFAng())
                self.Player:Freeze(true)
            end
        end)
        timer.Simple(GetChopperTime()/2, function()
            if IsValid(self) then
                nzDialog:PlayCustomDialog("ChopperKillstreak_Fuel")
            end
        end)
        timer.Simple(GetChopperTime()-3.5, function()
            if IsValid(self) and IsValid(self.Player) then
                self.Player:SetSVAnim("bo6_choppergunner_end", true)
                self.EquipTime = CurTime()+10
            end
            if IsValid(self) and IsValid(self.Pilot) then
                self.Pilot:SetCycle(0)
                self.Pilot:ResetSequence("bo6_choppergunner_pilot1_end")
            end
        end)
        timer.Simple(GetChopperTime()-2, function()
            if IsValid(self) and IsValid(self.Pilot) then
                nzDialog:PlayCustomDialog("ChopperKillstreak_End")
            end
        end)
        timer.Simple(GetChopperTime()-0.7, function()
            if IsValid(self) and IsValid(self.Player) then
                self.Player:ScreenFade(SCREENFADE.OUT, color_black, 0.2, 1.5)
            end
        end)
        timer.Simple(GetChopperTime()+1, function()
            nzDialog:PlayCustomDialog("BaseKillstreak_AirEnd")
        end)
    end

    function ENT:GetFAng()
        return Angle(0,0,0)
    end

    function ENT:MoveAlongWaypoints()
        local elapsedTime = CurTime() - self.StartTime
        local progress = math.Clamp(elapsedTime / GetChopperTime(), 0, 1)
        
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
        ply.KS_VoiceOverDelay = CurTime()+5
        ply:SetNWBool('UsingChopperGunner', true)
        timer.Simple(0.8, function()
            if !IsValid(self) or !IsValid(ply) then return end
            ply:SetEyeAngles(self:GetFAng())
            ply:Freeze(true)
        end)
        timer.Simple(1, function()
            if !IsValid(self) or !IsValid(ply) then return end
            ply:SetSVAnim("bo6_choppergunner_start", true)
            nzDialog:PlayCustomDialog("ChopperKillstreak_Start")
            if IsValid(self.Pilot) then
                self.Pilot:SetCycle(0)
                self.Pilot:ResetSequence("bo6_choppergunner_pilot1_start")
            end
        end)
        timer.Simple(4.5, function()
            if !IsValid(self) or !IsValid(ply) then return end
            ply:Freeze(false)
            if IsValid(self.Pilot) then
                self.Pilot:ResetSequence("bo6_choppergunner_pilot1_idle")
            end
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
        ply:SetNWBool('UsingChopperGunner', false)
        ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
        if IsValid(ply:GetPreviousWeapon()) then
            ply:SelectWeapon(ply:GetPreviousWeapon():GetClass())
        end
        ply:GodDisable()
        ply:Freeze(false)
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
            local leftEdge = self:GetPos() + self:GetRight() * -47 + self:GetUp() * -46 + self:GetForward() * 34
            ply:SetPos(leftEdge)
            ply:SetMoveType(0)
            if self.EquipTime < CurTime() then
                ply:SelectWeapon("bo6_deathmachine")
            else
                ply:SetActiveWeapon(nil)
            end
        end
    end

    function ENT:Think()
        if not self.Stop then
            self:MoveAlongWaypoints()
            self:TeleportPlayer()
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
    function ENT:Draw()
        self:DrawModel()
        self:ManipulateBoneAngles(6, self:GetManipulateBoneAngles(6)+Angle(0,5,0))
        self:ManipulateBoneAngles(10, self:GetManipulateBoneAngles(10)+Angle(0,0,5))
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

    local enemyMat = Material("bo6/hud/enemy.png", "noclamp")
    local chopperIcon = Material("bo6/hud/chopper.png", "mips")
    local crosshairCircle1 = Material("bo6/hud/circle.png", "")
    local crosshairCircle2 = Material("bo6/hud/cleancircle.png", "")
    local ChopperDespawnTime = 0
    local MaxChopperDespawnTime = 0
    hook.Add("HUDPaint", "nzrKillstreaks_Chopper", function()
        local ply = LocalPlayer()
        if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "bo6_deathmachine" then
            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(crosshairCircle1)
            surface.DrawTexturedRectRotated(ScrW()/2, ScrH()/2, We(72), He(72), ply:KeyDown(IN_ATTACK) and math.fmod(CurTime() * -720, 360) or 0)

            surface.SetDrawColor(255,255,255)
            surface.SetMaterial(crosshairCircle2)
            surface.DrawTexturedRectRotated(ScrW()/2, ScrH()/2, We(24), He(24), 0)

            local percent = math.max((ChopperDespawnTime-CurTime())/MaxChopperDespawnTime, 0)

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
            ChopperDespawnTime = CurTime()+(GetChopperTime()-add_time)
            MaxChopperDespawnTime = GetChopperTime()-add_time
        end
    end)

    hook.Add("CalcView", "nzrKillstreaks_Chopper", function(ply, pos, angles, fov)
        if ply:GetNWBool('UsingChopperGunner') then
            local view = {
                origin = pos,
                angles = angles,
                fov = fov,
                drawviewer = false
            }
            if ply:GetSVAnim() != "" then
                local att = ply:GetAttachment(ply:LookupAttachment("eyes"))
                view = {
                    origin = att.Pos,
                    angles = att.Ang,
                    fov = fov,
                    drawviewer = true
                }
            end
        
            return view
        end
    end)
end