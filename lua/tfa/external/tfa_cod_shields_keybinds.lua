-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
 
local nzombies = engine.ActiveGamemode() == "nzombies"

if CLIENT then
	hook.Add("TFA_PopulateKeyBindHints", "FOXBUILDS.TFA.Buildable.KeyHints", function(wep, keys)
		if wep.NZSpecialCategory == "shield" and wep.Primary.Attacks then
			table.insert(keys, 1, {
				label = "Melee Attack",
				keys = {wep:GetKeyBind({"+attack"})}
			})
			if wep.PlantShield then
				table.insert(keys, 2, {
					label = "Plant Shield",
					keys = {wep:GetKeyBind({"+attack2"})}
				})
			end

			if wep:GetClass() == "tfa_bo3_rocketshield" then
				table.insert(keys, 2, {
					label = "ZM_ZOD_ROCKET_HINT",
					keys = {wep:GetKeyBind({"+attack2"})}
				})
			end
			if wep:GetClass() == "tfa_bo3_dragonshield" then
				table.insert(keys, 2, {
					label = "Fire Attack",
					keys = {wep:GetKeyBind({"+attack2"})}
				})
			end
		end

		if wep.NZSpecialCategory == "trap" and not wep.Primary.Attacks then
			table.insert(keys, 1, {
				label = "Place",
				keys = {wep:GetKeyBind({"+attack"})}
			})

			if wep.GetFlipped then
				table.insert(keys, 2, {
					label = "Rotate (Only on Walls)",
					keys = {wep:GetKeyBind({"+attack2"})}
				})
			end
		end

		if wep:GetClass() == "tfa_bo2_raketrap" then
			table.insert(keys, 1, {
				label = "Melee Attack",
				keys = {wep:GetKeyBind({"+attack"})}
			})
			table.insert(keys, 2, {
				label = "Place",
				keys = {wep:GetKeyBind({"+attack2"})}
			})
		end
	end)
end
