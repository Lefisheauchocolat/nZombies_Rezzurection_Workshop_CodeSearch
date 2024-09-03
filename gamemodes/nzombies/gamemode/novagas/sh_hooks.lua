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

hook.Add("RenderScreenspaceEffects", "nz.NovaGas.Overlay", function()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if ply:NZIsNovaGassed() then
		local gaz = ply:GetNW2Entity("NZ.NovaGas")
		if IsValid(gaz) then
			local ModAmount = gaz:GetStatusProgress()

			tab["$pp_colour_contrast"] = 1 - math.Clamp(ModAmount * 0.2, 0, 0.2)
			tab["$pp_colour_colour"] = math.Clamp(ModAmount, 0.9, 1)
			DrawColorModify(tab)
			DrawMotionBlur(0.4, ModAmount * 0.5, 0.1)
		end
	end
	
	if ply:NZIsDecayGassed() then
		local gaz = ply:GetNW2Entity("NZ.DecayGas")
		if IsValid(gaz) then
			local ModAmount = gaz:GetStatusProgress()

			tab["$pp_colour_contrast"] = 1 - math.Clamp(ModAmount * 0.2, 0, 0.2)
			tab["$pp_colour_colour"] = math.Clamp(ModAmount, 0.9, 1)
			DrawColorModify(tab)
			DrawMotionBlur(0.4, ModAmount * 0.5, 0.1)
		end
	end

	if ply:NZIsElecBlinded() then
		local gaz = ply:GetNW2Entity("NZ.ElecBlind")
		if IsValid(gaz) then
			local ModAmount = gaz:GetStatusProgress()

			tab["$pp_colour_contrast"] = 1 - math.Clamp(ModAmount * 0.2, 0, 0.2)
			tab["$pp_colour_colour"] = math.Clamp(ModAmount, 0.9, 1)
			DrawColorModify(tab)
			DrawMotionBlur(0.4, ModAmount * 0.5, 0.1)
			ply:ScreenFade(SCREENFADE.IN, color_white, 0.5, 0.5)
		end
	end

	if ply:NZIsSonicBlinded() then
		local gaz = ply:GetNW2Entity("NZ.SonicBlind")
		if IsValid(gaz) then
			local ModAmount = gaz:GetStatusProgress()

			tab["$pp_colour_contrast"] = 1 - math.Clamp(ModAmount * 0.2, 0, 0.2)
			tab["$pp_colour_colour"] = math.Clamp(ModAmount, 0.9, 1)
			DrawColorModify(tab)
			DrawMotionBlur(0.4, 0.5, 0.1)
		end
	end
end)

hook.Add("SetupMove", "nz.NovaGas.SetupMove", function(ply, mv, cmd)
	if ply:NZIsNovaGassed() and ply:GetNotDowned() then
		mv:SetMaxClientSpeed(150)
	end
end)

hook.Add("SetupMove", "nz.AstroSlow.SetupMove", function(ply, mv, cmd)
	if ply:NZIsAstroSlowed() and ply:GetNotDowned() then
		mv:SetMaxClientSpeed(30) -- Crippled the safe way
	end
end)

hook.Add("SetupMove", "nz.SonicBlind.SetupMove", function(ply, mv, cmd)
	if ply:NZIsSonicBlinded() and ply:GetNotDowned() then
		ply:SetDSP(32, false)
		mv:SetMaxClientSpeed(100)
	end
end)
