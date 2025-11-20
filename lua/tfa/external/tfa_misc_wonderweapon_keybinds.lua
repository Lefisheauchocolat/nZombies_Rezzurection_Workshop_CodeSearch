if CLIENT then
	hook.Add("TFA_PopulateKeyBindHints", "FOXMISC.TFA.WW.KeyHints", function(wep, keys)
		if wep:GetClass() == "tfa_bo2_jetgun" then
			table.insert(keys, 1, {
				label = "Shread",
				keys = {wep:GetKeyBind({"+attack"})}
			})
			table.insert(keys, 2, {
				label = "Rev Engine",
				keys = {wep:GetKeyBind({"+attack2"})}
			})
		end
		if wep:GetClass() == "tfa_bo1_icelazer" then
			table.insert(keys, 1, {
				label = "Charge Lazer",
				keys = {wep:GetKeyBind({"+attack"})}
			})
		end
		if wep:GetClass() == "tfa_bo3_sungod" then
			table.insert(keys, 3, {
				label = "Charge Sun-Shot",
				keys = {wep:GetKeyBind({"+zoom"}, "bash")},
			})
			table.remove(keys, 2) //fake secondary
		end
		if wep:GetClass() == "tfa_bo3_cng" then
			table.insert(keys, 3, {
				label = "Charge Weapon",
				keys = {wep:GetKeyBind({"+zoom"}, "bash")},
			})
			table.remove(keys, 2) //fake secondary
		end
		if wep:GetClass() == "tfa_waw_rayzorback" then
			table.insert(keys, 3, {
				label = "Change Mode",
				keys = {wep:GetKeyBind({"+use", "+attack"}, "silencer")},
			})
		end
		if wep:GetClass() == "tfa_waw_xray" then
			table.insert(keys, 3, {
				label = "Change Mode",
				keys = {wep:GetKeyBind({"+use", "+attack"}, "silencer")},
			})
		end
		if wep:GetClass() == "tfa_waw_hl2crossbow" then
			table.insert(keys, 3, {
				label = "Toggle Shock Mine",
				keys = {wep:GetKeyBind({"+zoom"}, "bash")},
			})
			table.insert(keys, 4, {
				label = "Change Bolt Mode",
				keys = {wep:GetKeyBind({"+use", "+reload"}, "firemode")},
			})
			table.remove(keys, 2) //fake secondary
			table.remove(keys, 5) //fake secondary
		end
		if wep:GetClass() == "tfa_waw_grav_spike" then
			table.insert(keys, 1, {
				label = "Gravity Slam",
				keys = {wep:GetKeyBind({"+attack"})},
			})
			table.insert(keys, 2, {
				label = "Power Plant",
				keys = {wep:GetKeyBind({"+attack2"})},
			})
			table.insert(keys, 3, {
				label = "Melee Attack",
				keys = {wep:GetKeyBind({"+zoom"}, "bash")},
			})

			table.remove(keys, 4) //fake secondary
			table.remove(keys, 5)
		end
	end)
end