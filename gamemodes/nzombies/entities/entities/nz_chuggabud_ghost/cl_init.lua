include("shared.lua")

local zmhud_icon_chuggaghost = Material("nz_moo/icons/minimap_icon_chugabud.png", "unlitgeneric smooth")
local name_drawdist = GetConVar("nz_hud_player_name_distance")

function ENT:Draw()
	self:DrawModel()

	local text = self.PrintName
	local pos = self:WorldSpaceCenter() + self:GetUp()*42

	local ply = LocalPlayer()
	local ang = ply:EyeAngles()
	ang = Angle(ang.x, ang.y, 0)
	ang:RotateAroundAxis(ang:Up(), -90)
	ang:RotateAroundAxis(ang:Forward(), 90)

	local range = name_drawdist:GetInt()
	local dist = ply:EyePos():Distance(pos)
	local fade = range*0.6

	local ratio = 1 - math.Clamp((dist - range + fade) / fade, 0, 1)

	cam.Start3D2D(pos, ang, 0.24)
		surface.SetMaterial(zmhud_icon_chuggaghost)
		surface.SetDrawColor(ColorAlpha(color_white, 255*ratio))
		surface.DrawTexturedRect(-16, -16, 32, 32)
	cam.End3D2D()
end

function ENT:GetNZTargetText()
	local ply = self:GetOwner()
	return ply:Nick().."'s - Chugga Bud"
end

function ENT:IsTranslucent()
	return true
end