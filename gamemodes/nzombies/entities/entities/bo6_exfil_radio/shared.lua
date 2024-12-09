AddCSLuaFile()

ENT.Base = "base_gmodentity"
ENT.Type = "anim"
ENT.PrintName = "Exfil Radio"
ENT.Category = "Black Ops 6"
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        local r = ents.FindByClass("bo6_exfil_radio")[1]
        if IsValid(r) and r != self then
            r:Remove()
        end
        self:SetModel("models/bo6/exfil/intel_radiopack.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:GetPhysicsObject():EnableMotion(false)
        self:SetUseType(SIMPLE_USE)
        self.ShowedIcon = false
    end

    function ENT:Use()
        if self.CanBeCalled then
            nzVotes:StartVote("Exfil calls in a helicopter for you and your squad to escape.", 0.75, nZr_Exfil_StartRandom)
        end
    end

    function ENT:OnRemove()
        nZr_Exfil_ShowPosition(false)
    end

    function ENT:Think()
        self.CanBeCalled = nzSettings:GetSimpleSetting("ExfilEnabled", true) and !isvector(nZr_Exfil_Position) and (nzRound:GetNumber() >= nzSettings:GetSimpleSetting("ExfilFirstRound", 11) and (nzRound:GetNumber()-nzSettings:GetSimpleSetting("ExfilFirstRound", 11)) % nzSettings:GetSimpleSetting("ExfilEveryRound", 5) == 0) and nZr_Exfil_RadioActive and nzRound:GetState() == ROUND_PROG
        if self.CanBeCalled then
            nZr_Exfil_ShowPosition(true, self:WorldSpaceCenter()-Vector(0,0,64), 1)
        elseif !isvector(nZr_Exfil_Position) then
            nZr_Exfil_ShowPosition(false)
        end
        if not self.ShowedIcon and self.CanBeCalled then
            self.ShowedIcon = true
            nZr_Exfil_Message(1)
        elseif not self.CanBeCalled and self.ShowedIcon then
            self.ShowedIcon = false
        end
        self:NextThink(CurTime())
        return true
    end
else
    local nz_preview = GetConVar("nz_creative_preview")
    local displayfont = "ChatFont"
    local drawdistance = 800^2
    local size = 0.25

    function ENT:Draw()
        self:DrawModel()
        self:ManipulateBonePosition(0, Vector(0,0,4.5))

        if not nzRound:InState( ROUND_CREATE ) then return end
        if nz_preview:GetBool() then return end

        local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
        if oh_god_what_the_fuck then
            local angle = EyeAngles()
            angle:RotateAroundAxis( angle:Up(), -90 )
            angle:RotateAroundAxis( angle:Forward(), 90 )
            cam.Start3D2D(self:GetPos() + Vector(0,0,32), angle, size)
                draw.SimpleText("Exfil Radio", displayfont, 0, 0, Color(50,200,50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.End3D2D()
        end
    end
end