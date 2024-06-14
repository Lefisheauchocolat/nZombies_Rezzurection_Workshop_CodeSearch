local function HandlePlayerDiving(ply, vel)
	if ply:GetDiving() then

		ply.CalcIdeal = ACT_HL2MP_SWIM_DUEL

		local len = vel:Length2D()
		if ( len <= 1 ) then
			ply.CalcIdeal = ACT_HL2MP_SWIM_PISTOL
		end

		return ply.CalcIdeal, ply.CalcSeqOverride
	end
end
hook.Add("CalcMainActivity", "dive_to_prone.anims", HandlePlayerDiving)

if CLIENT then
	local function RenderDivingPlayers(ply)
		if ply:GetDiving() then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) then wep:InvalidateBoneCache() end
		end
	end
	hook.Add("PrePlayerDraw", "dive_to_prone.clietnanims", RenderDivingPlayers)
end
