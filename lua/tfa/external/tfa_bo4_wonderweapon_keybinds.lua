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

if CLIENT then
	hook.Add("TFA_PopulateKeyBindHints", "FOXBO4.TFA.WW.KeyHints", function(wep, keys)
		if wep:GetClass() == "tfa_bo4_dg5" then
			table.insert(keys, 1, {
				label = "Shock Slam",
				keys = {wep:GetKeyBind({"+attack"})},
			})
			table.insert(keys, 2, {
				label = "Electrocute",
				keys = {wep:GetKeyBind({"+attack2"})},
			})
			table.insert(keys, 3, {
				label = "Power Plant",
				keys = {wep:GetKeyBind({"+zoom"}, "bash")},
			})

			table.remove(keys, 4) //fake secondary
			table.remove(keys, 5)
		end

		if wep:GetClass() == "tfa_bo4_hellfire" then
			table.insert(keys, 1, {
				label = "Flamethrower",
				keys = {wep:GetKeyBind({"+attack"})}
			})
			table.insert(keys, 2, {
				label = "Blast Vent",
				keys = {wep:GetKeyBind({"+attack2"})}
			})
			table.insert(keys, 3, {
				label = "Infernal Tempest",
				keys = {wep:GetKeyBind({"+zoom"}, "bash")},
			})

			table.remove(keys, 4) //fake secondary
		end

		if wep:GetClass() == "tfa_bo4_overkill" then
			table.insert(keys, 1, {
				label = "Onslaught",
				keys = {wep:GetKeyBind({"+attack"})}
			})
			table.insert(keys, 2, {
				label = "Grenade Launcher",
				keys = {wep:GetKeyBind({"+attack2"})}
			})
			table.insert(keys, 3, {
				label = "Nuke",
				keys = {wep:GetKeyBind({"+zoom"}, "bash")},
			})

			table.remove(keys, 4) //fake secondary
		end

		if wep:GetClass() == "tfa_bo4_pathofsorrow" then
			table.insert(keys, 1, {
				label = "Kaze Slash",
				keys = {wep:GetKeyBind({"+attack"})}
			})
			table.insert(keys, 2, {
				label = "Merciless Dash",
				keys = {wep:GetKeyBind({"+attack2"})}
			})
			table.insert(keys, 3, {
				label = "Shadow of Death",
				keys = {wep:GetKeyBind({"+zoom"}, "bash")},
			})

			table.remove(keys, 4) //fake secondary
		end
	end)
end