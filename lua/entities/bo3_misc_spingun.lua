
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
ENT.Type = "anim"
ENT.PrintName = "Spinning Weapon"
ENT.Spawnable = false
ENT.DefaultModel = Model("models/weapons/tfa_bo3/qed/w_kn44.mdl")
ENT.Delay = 3

--[Sounds]--
ENT.ShootSound = "TFA_BO3_QED.KN44.Fire"

--[Parameters]--
ENT.Shots = 0
ENT.NumShots = 1
ENT.Damage = 35
ENT.RPM = 500
ENT.ClipSize = 30
ENT.Spread = Vector(0,0,0)
ENT.Distance = 1024

ENT.MuzzleType = 1
ENT.MuzzleAttach = 1
ENT.MuzzleFlashEffect = "MuzzleFlash"

ENT.Projectile = nil
ENT.ProjectileVelocity = 3500
ENT.ProjectileModel = Model("models/dav0r/hoverball.mdl")

function ENT:Initialize()
	local mdl = self:GetModel()

	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel(self.DefaultModel)
	end

	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self:SetFriction(0)
	self:DrawShadow(true)

	local tickrate = 1/engine.TickInterval()
	self.killtime = CurTime() + ((tickrate/self.RPM)*self.ClipSize)
end

function ENT:Think()
	if SERVER then
		if self.Shots < self.ClipSize then
			self:SetAngles(self:GetAngles() + Angle(0,360/self.ClipSize,0))
			if self.Projectile then
				self:ShootEntity()
			else
				self:ShootGun()
			end
			self.Shots = self.Shots + 1
		end
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime() + (60 / self.RPM))
	return true
end

function ENT:ShootGun()
	self:EmitSound(self.ShootSound)

	local fx = EffectData()
	fx:SetOrigin(self:GetPos())
	fx:SetNormal(self:GetAngles():Forward())
	fx:SetEntity(self)
	fx:SetFlags(self.MuzzleType)
	fx:SetAttachment(self.MuzzleAttach)
	util.Effect(self.MuzzleFlashEffect, fx)

	if SERVER then
		local ang = self:GetAngles()
		local dir = ang:Forward() 

		local bul = {
			Attacker = self:GetOwner(),
			Damage = self.Damage,
			Force = 1,
			Distance = self.Distance,
			Num = self.NumShots,
			Tracer = 1,
			Dir = dir,
			Spread = self.Spread,
			Src = self:GetPos(),
			IgnoreEntity = self
		}

		self:FireBullets(bul, false)
	end
end

function ENT:ShootEntity()
	self:EmitSound(self.ShootSound)

	local fx = EffectData()
	fx:SetOrigin(self:GetPos())
	fx:SetNormal(self:GetAngles():Forward())
	fx:SetEntity(self)
	fx:SetFlags(self.MuzzleType)
	fx:SetAttachment(self.MuzzleAttach)
	util.Effect(self.MuzzleFlashEffect, fx)

	if SERVER then
		for _ = 1, self.NumShots do
			local ent = ents.Create(self.Projectile)
			local ang = self:GetAngles()
			ent:SetModel(self.ProjectileModel)
			ent:SetPos(self:GetPos())
			ent:SetAngles(ang)
			ent:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

			ent.Damage = self.Damage
			ent.mydamage = self.Damage

			ent:Spawn()

			local dir = ang:Forward() 
			dir:Mul(self.ProjectileVelocity)

			ent:SetVelocity(dir)
			local phys = ent:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetVelocity(dir)
			end

			ent:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
			ent.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self
		end
	end
end

function ENT:OnRemove()
end
