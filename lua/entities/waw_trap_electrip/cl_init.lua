
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

include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local col_yellow = Color(255, 255, 20, 255)

local ourMat = Material("effects/fake_cicrlce_ujadikf")
local nadestatus = {
	[TFA.Enum.STATUS_GRENADE_READY] = true,
	[TFA.Enum.STATUS_GRENADE_PULL] = true,
}

function ENT:Draw()
	self:DrawModel()

	if not self.GetActivated then return end
	if self:GetActivated() and self:GetActivateTime() < CurTime() then
		if !self.clloopsounds then
			self.clloopsounds = "TFA_WAW_ELECTRIP.Loop"
			self:EmitSound(self.clloopsounds)
		end
		if !self.pvslight2 or !IsValid(self.pvslight2) then
			self.pvslight2 = CreateParticleSystem(self, "bo2_etrap_orb", PATTACH_POINT_FOLLOW, 1)
		end
	else
		local ply = self:GetOwner()
		if ply == LocalPlayer() and ply:IsPlayer() then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep:GetClass() == "tfa_waw_electrip" and nadestatus[wep:GetStatus()] then
				local alpha = math.sin(CurTime())*30
				render.SetMaterial(ourMat)
				render.DrawQuadEasy(self:GetPos(), vector_up, self.Range*2, self.Range*2, ColorAlpha(col_yellow, 10 + math.abs(alpha)), 0)
			end
		end

		if self.clloopsounds then
			self:StopSound(self.clloopsounds)
			self.clloopsounds = nil
		end
		if self.pvslight2 and IsValid(self.pvslight2) then
			self.pvslight2:StopEmission()
		end
	end
end

function ENT:Initialize()
	self:OverflowCheck()
end

function ENT:GetNZTargetText()
	local ply = self:GetOwner()
	if LocalPlayer() == ply then
		local wep = ply:GetWeapon("tfa_waw_electrip")
		if !self:GetActivated() or (self:GetActivated() and !IsValid(wep)) then
			if IsValid(wep) then
				local ammo = wep:GetPrimaryAmmoType()
				if (wep:Clip1() > 0 and ply:GetAmmoCount(ammo) >= 1) or ply:GetAmmoCount(ammo) >= 2 then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - remove Electrip Wire"
				else
					return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup Electrip Wire"
				end
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup Electrip Wire"
			end
		else
			return ply:Nick().."'s - Electrip Wire"
		end
	end

	return ply:Nick().."'s - Electrip Wire"
end

function ENT:IsTranslucent()
	return true
end