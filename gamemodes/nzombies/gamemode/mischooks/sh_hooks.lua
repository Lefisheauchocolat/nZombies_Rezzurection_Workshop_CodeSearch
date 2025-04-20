local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0.0,
	["$pp_colour_contrast"] = 1.0,
	["$pp_colour_colour"] = 1.0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
}

hook.Add("RenderScreenspaceEffects", "nz.SonicBlind.Overlay", function()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end
	--[[if ply:NZIsSonicBlinded() then
		local gaz = ply:GetNW2Entity("NZ.SonicBlind")
		if IsValid(gaz) then
			local ModAmount = gaz:GetStatusProgress()

			tab["$pp_colour_contrast"] = 1 - math.Clamp(ModAmount * 0.2, 0, 0.2)
			tab["$pp_colour_colour"] = math.Clamp(ModAmount, 0.9, 1)
			DrawColorModify(tab)
			DrawMotionBlur(0.4, 0.5, 0.1)
		end
	end]]
end)
