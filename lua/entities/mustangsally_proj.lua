
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

ENT.Base = "tfa_exp_base"
ENT.PrintName = "40mm Explosive"

ENT.Delay = 8
ENT.Impacted = false
ENT.Range = 250

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Draw()
	self:DrawModel()

	icon = Material("sprites/orangeflare1")
	render.SetMaterial(icon)
	render.DrawSprite(self:GetPos(), 20, 20, Color(255,255,255,255))
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:Explode(self:GetPos())
	util.Decal("Scorch", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)
	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	if ent == self:GetOwner() then return end
	if ent:Health() <= 0 then return end
	if not ent:IsSolid() then return end
	if nzombies and ent:IsPlayer() then return end

	self.Impacted = true
	self:Explode(self:GetPos())
	self:Remove()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self.killtime = CurTime() + self.Delay
	self.RangeSqr = self.Range * self.Range
	self:SetMaterial("null")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 0, Color(168, 168, 168), true, 5, 0, 0.35, 0.01, "cable/smoke.vmt")
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:Explode(self:GetPos())
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode(pos)
	self.Damage = self.mydamage or self.Damage

	local tr = {
		start = pos,
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == self then continue end
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			self:InflictDamage(v, pos)
		end
	end

	util.ScreenShake(pos, 100, 255, 1, 340)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:InflictDamage(ent, pos)
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(ent:GetUp()*15000 + (ent:GetPos() - pos):GetNormalized() * 10000)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if ent == self:GetOwner() then
		damage:SetDamage(100)
	end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		local distfac = pos:DistToSqr(ent:WorldSpaceCenter())
		distfac = 1 - math.Clamp(distfac/(self.RangeSqr), 0, 0.8)
		damage:ScaleDamage(distfac)

		if nzombies and ent.NZBossType then
			damage:ScaleDamage(math.Round(nzRound:GetNumber()/8))
		end
	end

	if nzombies and (ent:IsPlayer() and ent ~= self:GetOwner()) then return end
	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end
