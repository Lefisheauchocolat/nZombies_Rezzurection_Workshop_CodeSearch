AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "bo6_human_point"
ENT.Author			= "Hari"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.NZOnlyVisibleInCreative = true

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "StringData")
end

function ENT:SetData(data)
	local cdata = util.TableToJSON(data)
	self:SetStringData(cdata)
end

function ENT:GetData()
	local data = util.JSONToTable(self:GetStringData())
	return data
end

function ENT:Initialize()
	self:SetModel( "models/player/breen.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:SetColor(Color(255,185,0))
	self:DrawShadow( false )

    if CLIENT then
        self:SetLOD(8)
    end
end

function ENT:GetSpawnerData()
	return self:GetData()
end

function ENT:SetSpawnerData(data)
	self.Data = data
	self:SetData(data)
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
		local data = self:GetData()
		if oh_god_what_the_fuck then
			local angle = EyeAngles()
			angle:RotateAroundAxis( angle:Up(), -90 )
			angle:RotateAroundAxis( angle:Forward(), 90 )
			cam.Start3D2D(self:GetPos() + Vector(0,0,80), angle, size)
				draw.SimpleText("Human Spawner", displayfont, 0, -120, self:GetColor(), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Class: "..data.baseClass, displayfont, 0, -100, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Model: "..data.baseModel, displayfont, 0, -85, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Health: "..data.hp, displayfont, 0, -70, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Weapon: "..data.weaponClass, displayfont, 0, -55, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Is Enemy: "..(data.hostileToPlayer == 1 and "True" or "False"), displayfont, 0, -40, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Invisible for Zombies: "..(data.noTargetToZombies == 1 and "True" or "False"), displayfont, 0, -25, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Follow Nearest Player: "..(data.followNearestPlayer == 1 and "True" or "False"), displayfont, 0, -10, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Flag: "..data.flag, displayfont, 0, 5, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Is Death Animation: "..(data.isDeathAnim == 1 and "True" or "False"), displayfont, 0, 20, Color(220,220,220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end
	end
end
