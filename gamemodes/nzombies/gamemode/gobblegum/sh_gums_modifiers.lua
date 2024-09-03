function nzGum:ApplyToAllWeaponsGumModifier(ply)
	for _, wep in pairs(ply:GetWeapons()) do
		if wep:IsSpecial() then continue end

		nzGum:ApplyGumModifier(ply, wep)
	end
end

function nzGum:ApplyGumModifier(ply, wep)
	local gum = nzGum:GetActiveGumData(ply)
	if !gum or !gum.modifier then
		return
	end

	wep:ApplyNZModifier(gum.modifier)
end

function nzGum:RevertToAllWeaponsGumModifier(ply)
	for _, wep in pairs(ply:GetWeapons()) do
		if wep:IsSpecial() then continue end

		nzGum:RevertGumModifier(ply, wep)
	end
end

function nzGum:RevertGumModifier(ply, wep)
	local gum = nzGum:GetActiveGumData(ply)
	if !gum or !gum.modifier then
		return
	end

	wep:RevertNZModifier(gum.modifier)
end