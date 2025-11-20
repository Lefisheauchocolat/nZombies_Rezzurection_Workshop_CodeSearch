if SERVER then
	hook.Add("OnPlayerPickupPowerUp", "BO3.NZ.SPECIALIST_REFILL", function( _, id, ent)
		if id == "maxammo" then
			for _, ply in ipairs(player.GetAll()) do
				for _, wep in pairs(ply:GetWeapons()) do
					if wep.IsTFAWeapon and wep.NZSpecialCategory == "specialist" then
						wep:SetClip1(wep.Primary.ClipSize)

						if wep.OnSpecialistRecharged then
							wep:OnSpecialistRecharged()
							wep:CallOnClient("OnSpecialistRecharged", "")
						end
						hook.Run("OnSpecialistRecharged", wep)

						if ply:GetActiveWeapon() ~= wep then
							wep:ResetFirstDeploy()
							wep:CallOnClient("ResetFirstDeploy", "")
						end

						net.Start("TFA.BO3.QED_SND")
							net.WriteString("Specialist")
						net.Send(ply)
					end
				end
			end
		end
	end)

	hook.Add("OnZombieKilled", "BO3.NZ.SPECIALIST_KILL", function(npc, dmginfo)
		local attacker = dmginfo:GetAttacker()
		local inflictor = dmginfo:GetInflictor()
		if not IsValid(attacker) or not IsValid(inflictor) then return end
		if not attacker:IsPlayer() then return end

		for _, wep in pairs(attacker:GetWeapons()) do
			if wep.IsTFAWeapon and wep.NZSpecialCategory == "specialist" and inflictor:GetClass() ~= wep:GetClass() then
				if wep:Clip1() < wep:GetStatL("Primary.ClipSize") then
					local clipsize = wep:GetStatL("Primary.ClipSize")

					if wep:Clip1() == clipsize then return end
					local amount = wep.AmmoRegen or 1
					if attacker:HasPerk("time") then
						amount = math.Round(amount * 2)
					end

					wep:SetClip1(math.Min(wep:Clip1() + amount, clipsize))

					if wep:Clip1() >= clipsize then
						if wep.OnSpecialistRecharged then
							wep:OnSpecialistRecharged()
							wep:CallOnClient("OnSpecialistRecharged", "")
						end
						hook.Run("OnSpecialistRecharged", wep, attacker, inflictor)

						if attacker:GetActiveWeapon() ~= wep and wep.IsTFAWeapon then
							wep:ResetFirstDeploy()
							wep:CallOnClient("ResetFirstDeploy", "")
						end

						net.Start("TFA.BO3.QED_SND")
							net.WriteString("Specialist")
						net.Send(attacker)
					end
				end
			end
		end
	end)
end

hook.Add("InitPostEntity", "BO3.NZ.SPECIALIST_KEY", function()
	nzSpecialWeapons:RegisterSpecialWeaponCategory("specialist", KEY_X)
end)

hook.Add("PlayerSwitchWeapon", "BO3.NZ.SWITCH_WEP", function(ply, oldWep, newWep)
	if not IsValid(ply) or not IsValid(oldWep) then return end

	if oldWep.IsTFAWeapon and oldWep.NZSpecialCategory == "specialist" then
		if oldWep:Clip1() ~= oldWep.Primary.ClipSize then
			oldWep:SetClip1(math.min(oldWep:Clip1(), oldWep:GetStatL("Primary.ClipSize")/2))
		end
	end

	if newWep.IsTFAWeapon and newWep.NZSpecialCategory == "specialist" then
		if newWep:Clip1() < newWep:GetStatL("Primary.ClipSize") then
			return true
		end
	end
end)
