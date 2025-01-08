AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "bo6_hellstorm_point"
ENT.Author			= "Hari"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.NZOnlyVisibleInCreative = true

function ENT:Initialize()
	self:SetModel( "models/hunter/blocks/cube05x05x05.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetNotSolid(true)
	self:DrawShadow( false )
	self:SetColor(Color(15,0,115))
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
			cam.Start3D2D(self:GetPos() + Vector(0,0,48), angle, size)
				draw.SimpleText("Hellstorm Spawnpoint", displayfont, 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("ID: "..(table.KeyFromValue(ents.FindByClass("bo6_hellstorm_point"), self) or "none"), displayfont, 0, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end
	end
end