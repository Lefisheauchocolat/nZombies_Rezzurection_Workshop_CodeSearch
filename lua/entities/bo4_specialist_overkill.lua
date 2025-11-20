
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
ENT.PrintName = "Impact Grenade"

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

function ENT:SetupDataTables()
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self:SetHitPos(data.HitPos)
	self:Explode(data.HitPos)

	util.Decal("Scorch", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)

	self.Impacted = true
	self:Remove()
end

function ENT:StartTouch(ent)
	if ent == self:GetOwner() then return true end
	if nzombies and ent:IsPlayer() then return true end
	if self.Impacted then return end

	if not ent:IsWorld() and ent:IsSolid() then
		self:SetHitPos(self:GetPos())
		self:Explode(self:GetPos())
		
		self.Impacted = true
		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self.killtime = CurTime() + self.Delay

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 0, Color(100, 100, 100), true, 8, 0, 0.5, 0.01, "cable/smoke.vmt")
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

function ENT:Explode(pos)
	if self.Impacted then return end

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if nzombies and v:IsPlayer() then continue end
			if v:Health() <= 0 then continue end
			if v == ply then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			if IsValid(ply) and ply:IsNPC() and ply:Disposition(v) == D_LI then continue end

			self:InflictDamage(v)
		end
	end

	util.ScreenShake(self:GetPos(), 8, 255, 1, self.Range*1.5)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamageForce(ent:GetUp()*14000 + (ent:GetPos() - self:GetPos()):GetNormalized() * 12000)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(600, ent:GetMaxHealth() / 14))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
	end

	ent:TakeDamageInfo(damage)
end
