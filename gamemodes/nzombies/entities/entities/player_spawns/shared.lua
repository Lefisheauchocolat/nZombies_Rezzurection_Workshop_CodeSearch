AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "player_spawns"
ENT.Author			= "Alig96"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.NZOnlyVisibleInCreative = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "DoorActivated")
	self:NetworkVar("Int", 0, "DoorActivateType")

	self:NetworkVar("String", 0, "DoorFlag")
	self:NetworkVar("String", 1, "DoorFlag2")
	self:NetworkVar("String", 2, "DoorFlag3")
end

function ENT:Initialize()
	self:SetModel( "models/player/odessa.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:SetColor(Color(0,0,255))
	self:DrawShadow( false )

    if CLIENT then
        self:SetLOD(8)
    end
end

if CLIENT then
	local nz_preview = GetConVar("nz_creative_preview")
	local displayfont = "ChatFont"
	local outline = Color(0,0,0,59)
	local drawdistance = 800^2
	local size = 0.25

	local types_table = {
		[0] = "Deactivate on Door",
		[1] = "Activate on Door"
	}

	function ENT:Draw()
		if not nzRound:InState( ROUND_CREATE ) then return end
		if nz_preview:GetBool() then return end

		self:DrawModel()

		if self.GetDoorActivated and self:GetDoorActivated() then
			local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
			if oh_god_what_the_fuck then
				local angle = EyeAngles()
				angle:RotateAroundAxis( angle:Up(), -90 )
				angle:RotateAroundAxis( angle:Forward(), 90 )
				cam.Start3D2D(self:GetPos() + Vector(0,0,80), angle, size)
					if self.GetDoorActivateType then
						draw.SimpleText(types_table[self:GetDoorActivateType()], displayfont, 0, 0, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
					if self.GetDoorFlag and self:GetDoorFlag() ~= "" then
						draw.SimpleText("Link1: "..self:GetDoorFlag(), displayfont, 0, -15, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
					if self.GetDoorFlag and self:GetDoorFlag2() ~= "" then
						draw.SimpleText("Link2: "..self:GetDoorFlag2(), displayfont, 0, -30, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
					if self.GetDoorFlag and self:GetDoorFlag3() ~= "" then
						draw.SimpleText("Link3: "..self:GetDoorFlag3(), displayfont, 0, -45, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end
				cam.End3D2D()
			end
		end
	end
end
