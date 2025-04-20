
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

local c_color =  Color(255, 165, 0, 255)
local glowmat = Material("sprites/physg_glow1.vmt")

function ENT:Draw()
	self:DrawModel()

	local wep = self:GetWeapon()
	local ply = self:GetOwner()
	if IsValid(wep) and IsValid(ply) and ply.GetActiveWeapon and ply:GetActiveWeapon() ~= wep and (ply ~= LocalPlayer() or LocalPlayer():ShouldDrawLocalPlayer()) then
		local size = math.Rand(24,28)
		render.SetMaterial(glowmat)
		render.DrawSprite(self:GetPos() - self:GetUp(), size, size, c_color)
	end
end

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:Initialize()
	local ply = self:GetOwner()
	if IsValid(ply) then
		ply.CarryLantern = self
	end
end

function ENT:Think()
	if DynamicLight and dlight_cvar:GetBool() and !self:GetNoDraw() then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

		if self.DLight then
			self.DLight.pos = self:GetPos()
			self.DLight.r = 235
			self.DLight.g = 125
			self.DLight.b = 35
			self.DLight.decay = 2000
			self.DLight.brightness = 0.5
			self.DLight.size = 200
			self.DLight.dietime = CurTime() + 0.5
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end

	self:SetNextClientThink(CurTime())
	return true
end

function ENT:IsTranslucent()
	return true
end