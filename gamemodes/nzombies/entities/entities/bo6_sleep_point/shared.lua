AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "bo6_sleep_point"
ENT.Author			= "Hari"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.NZOnlyVisibleInCreative = true

nzSleepingZ = nzSleepingZ or {}

nzSleepingZ.Anims = {
	["bo2_standing"] = {
		idle = {
			"nz_base_zombie_inert_01",
			"nz_base_zombie_inert_02",
		},
		awake = {
			"nz_base_zombie_inert_2_awake_v1",
			"nz_base_zombie_inert_2_awake_v2",
			"nz_base_zombie_inert_2_awake_v3",
			"nz_base_zombie_inert_2_awake_v4",
			"nz_base_zombie_inert_2_awake_v5",
			"nz_base_zombie_inert_2_awake_v6",
			"nz_base_zombie_inert_2_awake_v7",
			"nz_base_zombie_inert_2_awake_v8",
		},
	},
}

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
	self:SetModel("models/moo/_codz_ports/t10/jup/moo_codz_jup_base_male_merc_2.mdl")
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
    self:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
	self:SetColor(Color(0,0,0))
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

		local data = self:GetData()
		local tab = nzSleepingZ.Anims[data.type]
		if istable(tab) and self:GetSequence() == 0 then
			self:ResetSequence(table.Random(tab.idle))
		end

		local oh_god_what_the_fuck = self:GetPos():DistToSqr(LocalPlayer():EyePos()) < drawdistance
		if oh_god_what_the_fuck then
			local angle = EyeAngles()
			angle:RotateAroundAxis( angle:Up(), -90 )
			angle:RotateAroundAxis( angle:Forward(), 90 )
			cam.Start3D2D(self:GetPos() + Vector(0,0,80), angle, size)
				draw.SimpleText("Sleeping Zombie Point", displayfont, 0, -120, Color(175,175,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Anim Type: "..data.type, displayfont, 0, -100, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Awaked: "..(tobool(data.awaked) and "True" or "False"), displayfont, 0, -80, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Radius: "..data.radius, displayfont, 0, -60, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Flag: "..data.flag, displayfont, 0, -40, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Flag2: "..data.flag2, displayfont, 0, -20, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Flag3: "..data.flag3, displayfont, 0, -0, Color(200,200,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			cam.End3D2D()
		end
	end
end
