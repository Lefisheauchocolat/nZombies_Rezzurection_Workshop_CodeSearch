
local function RegisterDefaultSpecialWeps()
	// stuff
	nzSpecialWeapons:AddKnife("tfa_bo1_knife", false, 0.7)
	nzSpecialWeapons:AddGrenade("tfa_bo1_m67", 4, false, 0.6, false, 0.4)
	nzSpecialWeapons:AddGrenade("tfa_bo2_grenade", 4, false, 0.6, false, 0.4)
	nzSpecialWeapons:AddGrenade("tfa_xm31_grenade", 4, false, 0.6, false, 0.4)
	nzSpecialWeapons:AddGrenade("nz_mmod_grenade", 4, false, 0.6, false, 0.4)

	-- Specials
	nzSpecialWeapons:AddDisplay( "nz_revive_morphine", false, function(wep)
		return !IsValid(wep.Owner:GetPlayerReviving()) or (SERVER and CurTime() > wep.nzDeployTime + 5)
	end)

	nzSpecialWeapons:AddDisplay( "nz_perk_bottle", false, function(wep)
		return SERVER and CurTime() > wep.nzDeployTime + 3.1
	end)
	
	nzSpecialWeapons:AddDisplay( "nz_packapunch_arms", false, function(wep)
		return SERVER and CurTime() > wep.nzDeployTime + 2.5
	end)

	nzSpecialWeapons:AddDisplay("tfa_perk_bottle", false, function(wep)
		return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasUpgrade("speed") and 0.9 or 2.2)) < CurTime()
	end)

	nzSpecialWeapons:AddDisplay("tfa_paparms", false, function(wep)
		return SERVER and (wep.nzDeployTime + (wep:GetOwner():HasPerk("time") and 1.5 or 2)) < CurTime() and !wep:GetOwner().TimedUseEntity
	end)

	nzSpecialWeapons:AddDisplay("tfa_zomdeath", false, function(wep)
		return SERVER and IsValid(wep:GetOwner()) and wep:GetOwner():GetNotDowned()
	end)

	nzSpecialWeapons:AddDisplay("tfa_dive_to_prone", false, function(wep)
		local ply = wep:GetOwner()
		return SERVER and (not ply:GetDiving() and ply:OnGround() and ply:GetLandingTime() < CurTime())
	end)

	nzSpecialWeapons:AddDisplay( "tfa_nz_gum", false, function(wep)
		return SERVER and CurTime() > wep.nzDeployTime + 3
	end)

	nzSpecialWeapons:AddDisplay( "tfa_nz_bubble", false, function(wep)
		return SERVER and CurTime() > wep.nzDeployTime + 3
	end)

	nzSpecialWeapons:AddDisplay("tfa_bo3_syrette", false, function(wep)
		if SERVER then
			local ply = wep:GetOwner()
			local revive = ply:GetPlayerReviving()
			local reviving = true
			if ply.IsRevivingPlayer then //dont take away if reviving someone else
				reviving = not ply:IsRevivingPlayer()
			end

			return reviving and (not IsValid(revive) or not revive:Alive() or revive:GetNotDowned()) or not wep:GetOwner():KeyDown(IN_USE)
		end
	end)

	nzSpecialWeapons:AddDisplay("tfa_bo2_syrette", false, function(wep)
		if SERVER then
			local ply = wep:GetOwner()
			local revive = ply:GetPlayerReviving()
			local reviving = true
			if ply.IsRevivingPlayer then //dont take away if reviving someone else
				reviving = not ply:IsRevivingPlayer()
			end

			return reviving and (not IsValid(revive) or not revive:Alive() or revive:GetNotDowned()) or not wep:GetOwner():KeyDown(IN_USE)
		end
	end)

	nzSpecialWeapons:AddDisplay("tfa_bo4_syrette", false, function(wep)
		if SERVER then
			local ply = wep:GetOwner()
			local revive = ply:GetPlayerReviving()
			local reviving = true
			if ply.IsRevivingPlayer then //dont take away if reviving someone else
				reviving = not ply:IsRevivingPlayer()
			end

			return reviving and (not IsValid(revive) or not revive:Alive() or revive:GetNotDowned()) or not wep:GetOwner():KeyDown(IN_USE)
		end
	end)
	
	nzSpecialWeapons:AddDisplay("nz_iw7_revive", false, function(wep)
		if SERVER then
			local ply = wep:GetOwner()
			local revive = ply:GetPlayerReviving()
			local reviving = true
			if ply.IsRevivingPlayer then //dont take away if reviving someone else
				reviving = not ply:IsRevivingPlayer()
			end

			return reviving and (not IsValid(revive) or not revive:Alive() or revive:GetNotDowned()) or not wep:GetOwner():KeyDown(IN_USE)
		end
	end)
end

hook.Add("InitPostEntity", "nzRegisterSpecialWeps", RegisterDefaultSpecialWeps)
--hook.Add("OnReloaded", "nzRegisterSpecialWeps", RegisterDefaultSpecialWeps)