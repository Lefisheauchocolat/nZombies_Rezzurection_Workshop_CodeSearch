
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

function ENT:Draw()
	self:DrawModel()
	local wep = self:GetWeapon()
	local ply = self:GetOwner()
	if IsValid(wep) and IsValid(ply) and ply.GetActiveWeapon and wep.GetElectrified then
		if wep:GetElectrified() and ply:GetActiveWeapon() ~= wep and (ply ~= LocalPlayer() or LocalPlayer():ShouldDrawLocalPlayer()) then
			if !self.CL_3PDrawFX or !self.CL_3PDrawFX:IsValid() then
				self.CL_3PDrawFX = CreateParticleSystem(self, "bo3_shield_electrify", PATTACH_ABSORIGIN_FOLLOW, 0)
			end
		elseif self.CL_3PDrawFX and self.CL_3PDrawFX:IsValid() then
			self.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
		end
	end
end

function ENT:Think()
end

function ENT:IsTranslucent()
	return true
end