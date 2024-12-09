AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "bo6_exfil_point"
ENT.Author			= "Hari"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.NZOnlyVisibleInCreative = true

function ENT:Initialize()
	self:SetModel( "models/player/odessa.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:SetColor(Color(0,255,235))
	self:DrawShadow( false )

    if CLIENT then
        self:SetLOD(8)
    end
end

if CLIENT then
	local nz_preview = GetConVar("nz_creative_preview")
	local displayfont = "ChatFont"
	local drawdistance = 800^2
	local size = 0.25

	function ENT:Draw()
		if not nzRound:InState( ROUND_CREATE ) then return end
		if nz_preview:GetBool() then return end

		--self:DrawModel()

		local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
		if oh_god_what_the_fuck then
			local angle = EyeAngles()
			angle:RotateAroundAxis( angle:Up(), -90 )
			angle:RotateAroundAxis( angle:Forward(), 90 )
			cam.Start3D2D(self:GetPos() + Vector(0,0,16), self:GetAngles()+Angle(0,180,0), 0.5)
				draw.SimpleText("Landing Direction ->", "DermaLarge", 10, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			cam.End3D2D()
			cam.Start3D2D(self:GetPos() + Vector(0,0,16), self:GetAngles()+Angle(0,270,0), 0.5)
				draw.SimpleText("Takeoff Direction ->", "DermaLarge", 10, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			cam.End3D2D()
			cam.Start3D2D(self:GetPos() + Vector(0,0,48), angle, size)
				draw.SimpleText("Exfil Position", displayfont, 0, 0, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end
	end
end