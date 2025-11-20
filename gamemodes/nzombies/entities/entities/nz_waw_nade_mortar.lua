
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
ENT.PrintName = "Mortar Round"

--[Sounds]--
ENT.ExplosionSound = "TFA_WAW_EXPLOSION.Main"
ENT.ExplosionSoundCl = "TFA_WAW_EXPLOSION.Dist"

--[Parameters]--
ENT.Delay = 10
ENT.Range = 200
ENT.Impacted = false
ENT.NZThrowIcon = Material("vgui/icon/hud_mortar_shell.png", "smooth unlitgeneric")

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	util.Decal("Scorch", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)
	if self.ExplosionEffect then
		local ang = data.HitNormal:Angle()
		ang:RotateAroundAxis(Vector(1,0,0), -180)
		ParticleEffect(self.ExplosionEffect, data.HitPos - data.HitNormal, ang)
	end

	self:EmitSound("TFA_WAW_MORTAR.Prime")
	self:Explode(data.HitPos)
	self:SetHitPos(data.HitPos)

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if not pvp_bool:GetBool() and ent:IsPlayer() then return end
	if nzombies and ent:IsPlayer() then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self:EmitSound("TFA_WAW_MORTAR.Prime")

		if self.ExplosionEffect then
			ParticleEffect(self.ExplosionEffect, self:GetPos(), Angle(-90,0,0))
		end

		self:InflictDamage(ent, self:GetPos())
		self:Explode(self:GetPos())
		self:SetHitPos(self:GetPos())

		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:DrawShadow(true)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)

	self.killtime = CurTime() + self.Delay
	self.Damage = self.mydamage or self.Damage

	self.RangeSqr = self.Range*self.Range
	self.KillRangeSqr = (self.Range/3)^2

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 0, Color(120, 120, 120), true, 4, 0, 0.4, 0.005, "cable/smoke.vmt")
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

function ENT:DoExplosionEffect()
	self:EmitSound(self.ExplosionSound)
	self:EmitSound(self.ExplosionSoundCl)
	if self.FluxSound then
		self:EmitSound(self.FluxSound)
	end

	if !self.ExplosionEffect then
		local fx = EffectData()
		fx:SetOrigin(self:GetPos())

		util.Effect("HelicopterMegaBomb", fx)
		util.Effect("Explosion", fx)
	end
end

function ENT:Explode(pos)
	if not pos then pos = self:GetPos() end

	local ply = self:GetOwner()
	self.Damage = self.mydamage or self.Damage

	local tr = {
		start = pos,
		filter = self,
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == self then continue end
			if nzombies and (v:IsPlayer() and v ~= ply) then continue end
			if v:IsPlayer() and IsValid(ply) and v ~= ply and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end
			local hitpos = tr1.Entity == v and tr1.HitPos or tr.endpos

			self:InflictDamage(v, hitpos)
		end
	end

	self:DoExplosionEffect()
	util.ScreenShake(pos, 5, 5, 2, self.Range*2)
	
	self:Remove()
end

function ENT:InflictDamage(ent, hitpos)
	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(ent:GetUp()*10000 + (ent:GetPos() - self:GetPos()):GetNormalized()*8000)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamagePosition(hitpos or ent:WorldSpaceCenter())

	local dist = self:GetPos():DistToSqr(hitpos or ent:WorldSpaceCenter())
	local distfac = 1 - math.Clamp(dist/self.RangeSqr, 0, 0.5)
	local fuck = dist <= self.KillRangeSqr

	damage:SetDamage(self.Damage*distfac)
	if (fuck or self.Overpowered) and ent:IsValidZombie() and !ent.NZBossType and !ent.IsMooBossZombie then
		damage:SetDamage((ent:Health() + 666)*distfac)
	end

	if ent == self:GetOwner() then
		damage:SetDamage(50*distfac)
	end

	if nzombies and (ent:IsPlayer() and ent ~= self:GetOwner()) then return end
	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = 255
			dlight.g = 160
			dlight.b = 40
			dlight.brightness = 3
			dlight.Decay = 2000
			dlight.Size = 300
			dlight.DieTime = CurTime() + 0.2
		end
	end
end