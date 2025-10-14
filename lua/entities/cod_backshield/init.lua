
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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	if SERVER then
		self:SetHealth(500)
		self:SetMaxHealth(500)
	end

	self:SetParent(self:GetOwner())
	self:AddEffects(EF_BONEMERGE)
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) then return end
	if nzombies and not attacker:IsValidZombie() then return end

	local ply = self:GetOwner()
	local wep = self:GetWeapon()
	local damage = dmginfo:GetDamage()
	if nzombies and IsValid(ply) and ply:HasPerk("amish") then
		damage = damage * 0.5
	end

	self:SetHealth(self:Health() - damage)

	if not IsValid(ply) or not IsValid(wep) then return end

	if self:Health() <= 0 then
		ply:EmitSound("TFA_BO3_SHIELD.Break")
		if ply:GetActiveWeapon() == wep then
			wep:CallWeaponSwap()
		end

		timer.Simple(0, function()
			if not IsValid(ply) or not IsValid(wep) then return end
			ply:StripWeapon(wep:GetClass())
		end)
	else
		wep:EmitSound(wep.ShieldHitSound or "TFA_BO3_SHIELD.Hit")

		local pct = self:Health()/self:GetMaxHealth()
		if pct < 0.3 then
			self:SetBodygroup(0,2)
			wep:SetDamage(2)
		elseif pct < 0.6 then
			self:SetBodygroup(0,1)
			wep:SetDamage(1)
		else
			self:SetBodygroup(0,0)
			wep:SetDamage(0)
		end

		wep:SetClip1(math.Round(math.Clamp(pct, 0, 1) * wep.Primary_TFA.ClipSize))
	end
end
