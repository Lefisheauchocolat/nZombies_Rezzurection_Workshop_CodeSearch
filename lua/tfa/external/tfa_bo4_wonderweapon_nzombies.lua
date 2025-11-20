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

if nzombies then
	if SERVER then
		hook.Add("EntityTakeDamage", "FOXBO4.TFA.WW.DMGRESIST", function(ply, dmginfo)
			if not IsValid(ply) then return end
			if not ply:IsPlayer() then return end
			local wep = ply:GetActiveWeapon()
			if not IsValid(wep) then return end

			if wep:GetClass() == "tfa_bo4_pathofsorrow" then //melee resist
				if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_SLASH, DMG_CRUSH, DMG_CLUB, DMG_VEHICLE)) ~= 0 then
					dmginfo:SetDamage(dmginfo:GetDamage()*0.1)
				end
			end

			if wep:GetClass() == "tfa_bo4_overkill" then //bullet/blast resist
				if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_BULLET, DMG_AIRBOAT, DMG_BUCKSHOT, DMG_BLAST, DMG_BLAST_SURFACE, DMG_SONIC, DMG_VEHICLE)) ~= 0 then
					dmginfo:SetDamage(dmginfo:GetDamage()*0.1)
				end
			end

			if wep:GetClass() == "tfa_bo4_dg5" then //shock/energy resist
				if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_SHOCK, DMG_SONIC, DMG_PLASMA, DMG_ENERGYBEAM, DMG_DISSOLVE, DMG_PARALYZE, DMG_VEHICLE)) ~= 0 then
					dmginfo:SetDamage(dmginfo:GetDamage()*0.1)
				end
			end

			if wep:GetClass() == "tfa_bo4_hellfire" then //fire/burning resist
				if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_BURN, DMG_SLOWBURN, DMG_VEHICLE)) ~= 0 then
					if ply:IsOnFire() then ply:Extinguish() end
					dmginfo:SetDamage(dmginfo:GetDamage()*0.1)
				end
			end
		end)
	end
	hook.Add("InitPostEntity", "BO4.NZ.WW.RegisterSpecials", function()
		nzSpecialWeapons:AddSpecialGrenade( "tfa_bo4_monkeybomb", 3, false, 2.8, false, 0.4 )
		nzSpecialWeapons:AddSpecialGrenade( "tfa_bo4_matryoshka", 3, false, 2.6, false, 0.4 )
	end)
end