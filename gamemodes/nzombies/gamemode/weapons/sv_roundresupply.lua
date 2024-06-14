nzWeps.RoundResupply = {}

function nzWeps:AddAmmoToRoundResupply(ammo, count, max)
	nzWeps.RoundResupply[ammo] = {count = count, max = max}
end

function nzWeps:DoRoundResupply()
	for _, ply in pairs(player.GetAllPlaying()) do
		for id, data in pairs(nzWeps.RoundResupply) do
			local give = math.Clamp(data.max - ply:GetAmmoCount(id), 0, data.count)
			ply:GiveAmmo(give, id, true)
		end

		local special = ply:GetSpecialWeaponFromCategory("specialgrenade")
		if IsValid(special) and (special.NZTacticalRegen or ply:HasUpgrade("mulekick")) then
			local max = 3
			local data = special.NZSpecialWeaponData
			if data and data.MaxAmmo then
				max = data.MaxAmmo
			end

			local ammo = GetNZAmmoID("specialgrenade")
			local count = ply:GetAmmoCount(ammo)
			local amount = special.NZTacticalRegenAmount or 1
			if ply:HasUpgrade("mulekick") then
				amount = math.Max(amount, 2)
			end

			ply:SetAmmo(math.Min(count + amount, max), ammo)
		end

		local trap = ply:GetSpecialWeaponFromCategory("trap")
		if IsValid(trap) and trap.NZTrapRegen then
			local max = 1
			local data = trap.NZSpecialWeaponData
			if not data then
				if GetConVar("developer"):GetBool() then print("Trap weapon "..trap.PrintName.." is missing its SWEP.NZSpecialWeaponData table!") end
				continue
			end

			if data.MaxAmmo then
				max = data.MaxAmmo
				if trap.NZRegenTakeClip then
					max = max - trap:Clip1()
				end
			end
			if data.AmmoType then
				ammo = data.AmmoType
			end

			local count = ply:GetAmmoCount(ammo)
			ply:SetAmmo(math.Min(count + (trap.NZTrapRegenAmount or 1), max), ammo)
		end

		if ply:HasUpgrade("tortoise") and not IsValid(ply:GetSpecialWeaponFromCategory("shield")) and not IsValid(ply:GetShield()) then
			local gun = nzMapping.Settings.shield or "tfa_bo2_tranzitshield"
			ply:Give(gun)
		end

		if ply:HasUpgrade("speed") and ply:GetNW2Int("nz.SpeedRefund", 0) > 0 then
			local total = ply:GetNW2Int("nz.SpeedRefund", 0)
			local totalog = total

			local count = 0
			local weps = ply:GetWeapons()
			for k, wep in pairs(weps) do
				if wep:IsSpecial() then continue end
				count = count + 1
			end

			local refund = math.Round(total/count)

			for k, wep in RandomPairs(weps) do
				if wep:IsSpecial() then continue end
				local ammo1 = wep:GetPrimaryAmmoType()
				if ammo1 > 0 and wep.Primary and total > 0 then
					local ammocount = ply:GetAmmoCount(ammo1)
					local maxammo = wep.Primary.MaxAmmo or nzWeps:CalculateMaxAmmo(wep:GetClass(), wep:HasNZModifier("pap"))
					local amount = math.min(maxammo - ammocount, refund)
					total = total - amount

					if total < 0 and amount > 1 then
						amount = amount - math.abs(total)
					end

					if refund > math.Round(totalog/count) then
						refund = math.Round(totalog/count)
					end

					if amount == 0 then
						refund = refund*2
					end

					ply:GiveAmmo(math.Max(amount, 0), ammo1)

					if total <= 0 then
						break
					end
				end
			end

			ply:SetNW2Int("nz.SpeedRefund", 0)
		end
	end
end

-- Standard grenades
nzWeps:AddAmmoToRoundResupply(GetNZAmmoID( "grenade" ) or "nz_grenade", 2, 4)