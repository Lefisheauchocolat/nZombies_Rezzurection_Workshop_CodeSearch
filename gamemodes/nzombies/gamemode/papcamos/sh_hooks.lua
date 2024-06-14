if CLIENT then
	local cvar_papcamo = GetConVar("nz_papcamo")
	local cvar_papcamo3p = GetConVar("nz_papcamo_3p")

	hook.Add("PrePlayerDraw", "nzCamos.Draw", function(ply, flags)
		if not IsValid(ply) then return end
		if not cvar_papcamo3p:GetBool() then return end

		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end

		if wep.NZCamoBlacklist then return end
		//if wep.NZSpecialCategory then return end
		//if not wep.IsTFAWeapon then return end
		if not wep:HasNZModifier("pap") then
			if wep.TPaPOverrideMat then
				wep:SetSubMaterial()
			end
			return
		end

		if !wep.nzPaPCamo and wep:GetNW2String("nzPaPCamo", "") == "" then return end

		if !wep.nzPaPCamo or wep.nzPaPCamo ~= wep:GetNW2String("nzPaPCamo") then
			wep.nzPaPCamo = wep:GetNW2String("nzPaPCamo")
		end

		if wep.TPaPOverrideMat then
			for k, v in pairs(wep.TPaPOverrideMat) do
				if wep:GetSubMaterial(k) == "" then
					wep:SetSubMaterial(k, wep.nzPaPCamo)
				end
			end
		end

		if wep.WElements and wep.WPaPOverrideMat then
			for _, element in pairs(wep.WElements) do
				local model = element.curmodel
				if IsValid(model) and wep.WPaPOverrideMat[model] then
					for k, v in pairs(wep.WPaPOverrideMat[model]) do
						if model:GetSubMaterial(k) == "" then
							model:SetSubMaterial(k, wep.nzPaPCamo)
						end
					end
				end
			end
		end
	end)

	hook.Add("PreDrawViewModel", "nzCamos.Draw", function(vm, ply, wep)
		if not IsValid(vm) or not IsValid(wep) or not IsValid(ply) then return end
		if not cvar_papcamo:GetBool() then return end

		if wep.NZCamoBlacklist then return end
		if wep.NZSpecialCategory then
			vm:SetSubMaterial()
			return
		end
		/*if not wep.IsTFAWeapon then
			vm:SetSubMaterial()
			return
		end*/
		if not wep:HasNZModifier("pap") then
			if wep.PaPOverrideMat then
				vm:SetSubMaterial()
			end
			return
		end

		if !wep.nzPaPCamo and wep:GetNW2String("nzPaPCamo", "") == "" then return end

		if !wep.nzPaPCamo or wep.nzPaPCamo ~= wep:GetNW2String("nzPaPCamo") then
			wep.nzPaPCamo = wep:GetNW2String("nzPaPCamo")
		end

		if wep.PaPOverrideMat then
			for k, v in pairs(wep.PaPOverrideMat) do
				vm:SetSubMaterial(k, wep.nzPaPCamo)
			end
		end

		if wep.VElements and wep.VPaPOverrideMat then
			for _, element in pairs(wep.VElements) do
				local model = element.curmodel
				if IsValid(model) and wep.VPaPOverrideMat[model] then
					for k, v in pairs(wep.VPaPOverrideMat[model]) do
						model:SetSubMaterial(k, wep.nzPaPCamo)
					end
				end
			end
		end
	end)
end