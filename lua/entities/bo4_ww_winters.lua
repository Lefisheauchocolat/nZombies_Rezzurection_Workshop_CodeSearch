
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

AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "WHATS COOLER THAN BEIN' COOL?"

--[Sounds]--
ENT.PropelSound = Sound("TFA_BO4_WINTERS.Wind")

--[Parameters]--
ENT.Delay = 0.24

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:EmitSoundNet(self.PropelSound)
	self:SetNoDraw(true)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	ParticleEffectAttach("bo4_freezegun_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	self.killtime = CurTime() + self.Delay
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight( self:EntIndex() )
		if ( dlight ) then
			dlight.pos = self:GetPos()
			dlight.dir = self:GetPos()
			dlight.r = 255
			dlight.g = 255
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 500
			dlight.Size = 220
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		if !util.IsInWorld(self:GetPos() + self:GetVelocity():GetNormalized()*(self:GetVelocity():Length()*engine.TickInterval()*2)) then
			self:Remove()
			return false
		end
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end
