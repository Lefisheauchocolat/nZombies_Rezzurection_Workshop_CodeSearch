
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
ENT.PrintName = "Incenerator"

ENT.LoopSound = "TFA_BO4_ALISTAIR.Charged.FireLoop"

--[Parameters]--
ENT.Delay = 10
ENT.Life = 8
ENT.Range = 140
ENT.Upgraded = false

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	self:StopParticles()
	self:EmitSound("TFA_BO4_ALISTAIR.Charged.FireStart")
	self:EmitSound(self.LoopSound)
	//self:SetModel("models/hunter/misc/sphere025x025.mdl")
	//self:SetMaterial("models/weapons/tfa_bo4/alistairs/red_orb_glow")

	ParticleEffect("bo4_alistairs_impact_fireball", data.HitPos, Angle(0,0,0))

	local ent = data.HitEntity
	if ent:IsWorld() and ent:IsSolid() then
		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetPos(data.HitPos - data.HitNormal)

			ParticleEffectAttach("bo4_alistairs_fireball", PATTACH_ABSORIGIN_FOLLOW, self, 1)
		end)
	end

	self.KillTime = CurTime() + self.Life
	self.DesiredPos = data.HitPos - data.HitNormal*50
	
	phys:EnableMotion(false)
	phys:Sleep()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	ParticleEffectAttach("bo4_alistairs_trail_fire", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self.KillTime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if self:GetActivated() and dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 60
			dlight.b = 10
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 200
			dlight.dietime = CurTime() + 0.1
		end
	end

	if SERVER then
		if self.KillTime < CurTime() then
			self:StopSound(self.LoopSound)

			self:EmitSound("TFA_BO4_ALISTAIR.Charged.FireEnd")
			ParticleEffect("bo4_alistairs_explode_fireball", self:GetPos(), Angle(0,0,0))

			self:Remove()
			return false
		end

		if self:GetActivated() then
			if self:GetPos() ~= self.DesiredPos then
				self:SetPos(LerpVector(0.05, self:GetPos(), self.DesiredPos))
			end

			for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
				if v:IsNPC() or v:IsNextBot() then
					if v == self:GetOwner() then continue end
					//if nzombies and v.NZBossType then continue end
					if v:Health() <= 0 then continue end
					if v:BO4IsMagmaIgnited() then continue end

					ParticleEffectAttach("bo4_alistairs_fireball_kill", PATTACH_POINT_FOLLOW, v, 1)
					v:BO4Magma(math.random(3,6)*0.5, self:GetOwner(), self.Inflictor)
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopSound(self.LoopSound)
end
