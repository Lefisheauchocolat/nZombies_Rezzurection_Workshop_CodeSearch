local cvar_hud = GetConVar("cl_drawhud")

local ColorAlpha = ColorAlpha
local surface = surface

hook.Add("HUDPaint", "NZ.AAT.HUD", function()
	if not cvar_hud:GetBool() then return end
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return end

	if wep:GetNW2String("nzAATType", "") ~= "" then
		local fadefac = 0
		local delay = ply:GetNW2Float("nzAATDecay", 0)
		local aat = wep:GetNW2String("nzAATType", "")

		if delay > CurTime() then
			fadefac = delay - CurTime()
			fadefac = math.Clamp(fadefac / 2, 0, 1)
		end

		if fadefac > 0 then
			surface.SetMaterial(nzAATs:Get(aat).flash)
			surface.SetDrawColor(ColorAlpha(color_white, 300*fadefac))
			surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 128)
		end
	end
end)