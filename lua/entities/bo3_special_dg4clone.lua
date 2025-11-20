
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
ENT.PrintName = "Ragnarok DG4"

--[Sounds]--
ENT.VortexStartSound = "TFA_BO3_DG4.Vortex.Start"
ENT.VortexLoopSound = "TFA_BO3_DG4.Vortex.Loop"
ENT.VortexEndSound = "TFA_BO3_DG4.Vortex.End"

--[Parameters]--
ENT.Range = 256
ENT.Consumption = 1

DEFINE_BASECLASS(ENT.Base)

function ENT:PhysicsCollide(data, phys)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:PhysicsInit(SOLID_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetMoveType(MOVETYPE_NONE)

	self.AutomaticFrameAdvance = true
	local sequence = self:LookupSequence("idle_open")
	self:SetSequence(sequence)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:Think()
	local p = self:GetParent()
	if SERVER then
		if not p:GetActivated() and not self.HasEmitParticle then
			self.HasEmitParticle = true
			ParticleEffectAttach( "bo3_dg4_dead", PATTACH_ABSORIGIN_FOLLOW, self, 1 )
		end
		if not IsValid(p) then
			SafeRemoveEntity(self)
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopParticles()
end
