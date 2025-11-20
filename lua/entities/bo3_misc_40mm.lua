
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
ENT.PrintName = "M203"

--[Sounds]--
ENT.ExplosionSound1 = "TFA_BO3_GRENADE.Dist"
ENT.ExplosionSound2 = "TFA_BO3_GRENADE.Exp"
ENT.ExplosionSound3 = "TFA_BO3_GRENADE.ExpClose"
ENT.ExplosionSound4 = "TFA_BO3_GRENADE.Flux"

--[Parameters]--
ENT.Delay = 3
ENT.Range = 200

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	local ent = data.HitEntity
	if ent:IsWorld() and ent:IsSolid() then
		self:Explode()
		self.Impacted = true
		self:Remove()
	end
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self:Explode()
		self.Impacted = true
		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	if SERVER then
		util.SpriteTrail(self, 1, Color(200,200,200,200), true, 5, 1, 0.5, 0.1, "trails/smoke")
		self:SetTrigger(true)
	end
end

function ENT:DoExplosionEffect()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())

	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)

	self:EmitSound(self.ExplosionSound1)
	self:EmitSound(self.ExplosionSound2)
	self:EmitSound(self.ExplosionSound3)
	self:EmitSound(self.ExplosionSound4)
end

function ENT:Explode()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	self.Damage = self.mydamage or self.Damage

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end
			
			local damage = DamageInfo()
			damage:SetDamage(self.Damage)
			damage:SetAttacker(IsValid(ply) and ply or self)
			damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
			damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
			damage:SetDamagePosition(v:WorldSpaceCenter())
	
			if (nzombies and v == ply) or (not nzombies and v:IsPlayer()) then
				local distfac = self:GetPos():Distance(v:GetPos())
				distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
				damage:SetDamage(200*distfac)
			end
			if nzombies and v:IsPlayer() then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

			v:TakeDamageInfo(damage)
		end
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, 512)

	self:DoExplosionEffect()
	self:Remove()
end
