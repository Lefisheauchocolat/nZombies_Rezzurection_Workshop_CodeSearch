
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

function ENT:Draw()
	self:DrawModel()

	if not self.GetActivated then return end
	if self:GetActivated() then
		if !self.pvslight1 or !IsValid(self.pvslight1)then
			self.pvslight1 = CreateParticleSystem(self, "bo2_etrap_arcs", PATTACH_ABSORIGIN_FOLLOW)
		end
		if !self.pvslight2 or !IsValid(self.pvslight2)then
			self.pvslight2 = CreateParticleSystem(self, "bo2_etrap_tv", PATTACH_POINT_FOLLOW, 1)
		end
		if !self.pvslight3 or !IsValid(self.pvslight3)then
			self.pvslight3 = CreateParticleSystem(self, "bo2_etrap_orb", PATTACH_POINT_FOLLOW, 2)
		end
		if !self.pvslight4 or !IsValid(self.pvslight4)then
			self.pvslight4 = CreateParticleSystem(self, "bo2_etrap_orb", PATTACH_POINT_FOLLOW, 3)
		end
	else
		if self.pvslight1 and IsValid(self.pvslight1)then
			self.pvslight1:StopEmission()
		end
		if self.pvslight2 and IsValid(self.pvslight2)then
			self.pvslight2:StopEmission()
		end
		if self.pvslight3 and IsValid(self.pvslight3)then
			self.pvslight3:StopEmission()
		end
		if self.pvslight4 and IsValid(self.pvslight4)then
			self.pvslight4:StopEmission()
		end
	end
end

function ENT:GetNZTargetText()
	local ply = self:GetOwner()
	if LocalPlayer() == ply then
		return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup Electric Trap"
	else
		return ply:Nick().."'s - Electric Trap"
	end
end

function ENT:IsTranslucent()
	return true
end