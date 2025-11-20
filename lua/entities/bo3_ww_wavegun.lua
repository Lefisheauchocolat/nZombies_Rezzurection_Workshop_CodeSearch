
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
ENT.PrintName = "Microwave"

--[Sounds]--

--[Parameters]--
ENT.Delay = 6
ENT.Range = 240

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	local ent = data.HitEntity
	if ent:GetClass() == "func_button" then
		local damage = DamageInfo()
		damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
		damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
		damage:SetDamage(ent:Health())
		damage:SetDamageType(DMG_ENERGYBEAM)

		ent:TakeDamageInfo(damage)
	end

	self:StopParticles()
	self:EmitSound("TFA_BO3_ZAPGUN.Flux")
	self:SetHitPos(data.HitPos)

	if self:GetUpgraded() then
		ParticleEffect("bo3_zapgun_impact_right", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	else
		ParticleEffect("bo3_zapgun_impact_pap", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	end

	util.ScreenShake(data.HitPos, 6, 255, 0.5, 400)

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	if ent == self:GetOwner() then return end

	if ent:IsNPC() or ent:IsNextBot() then
		if self:GetUpgraded() then
			ParticleEffect("bo3_zapgun_impact_right", self:GetPos(), Angle(90,0,0))
		else
			ParticleEffect("bo3_zapgun_impact_pap", self:GetPos(), Angle(90,0,0))
		end
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_zapgun_right_beam",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self.color = Color(255, 90, 100)
	else
		ParticleEffectAttach("bo3_zapgun_pap_beam",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self.color = Color(140, 40, 255)
	end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:SetBuoyancyRatio(0)
	end

	self.killtime = CurTime() + self.Delay
	
	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 3
			dlight.Decay = 2000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.2
		end
	end
end