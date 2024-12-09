AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "bo6_infil_point"
ENT.Author			= "Hari"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.NZOnlyVisibleInCreative = true

function ENT:Initialize()
	self:SetModel( "models/props_phx/oildrum001.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:SetColor(Color(0,0,0))
	self:DrawShadow( false )
	self.type = self.type or "Heli"
	self.chief = self.chief or "models/player/urban.mdl"
	self:SetNWString('infiltype', self.type)
	self:SetNWString('infilchief', self.chief)

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

		self:DrawModel()

		local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
		if oh_god_what_the_fuck then
			local angle = EyeAngles()
			angle:RotateAroundAxis( angle:Up(), -90 )
			angle:RotateAroundAxis( angle:Forward(), 90 )
			cam.Start3D2D(self:GetPos() + Vector(0,0,68), angle, size)
				draw.SimpleText("Infil Position", displayfont, 0, 0, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Type: "..self:GetNWString('infiltype', 'Heli'), displayfont, 0, 20, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Chief Model: "..self:GetNWString('infilchief', 'models/player/urban.mdl'), displayfont, 0, 40, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.End3D2D()
			cam.Start3D2D(self:GetPos() + Vector(0,0,44), self:GetAngles(), 0.18)
				draw.SimpleText("Direction ->", "DermaLarge", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end
	end
end