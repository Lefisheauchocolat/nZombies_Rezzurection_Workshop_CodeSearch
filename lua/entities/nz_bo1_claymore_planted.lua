
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
ENT.PrintName = "Placed Explosive"
ENT.NZThrowIcon = Material("vgui/hud/hud_claymore.png", "unlitgeneric smooth")

--[Sounds]--
ENT.BounceSound = Sound("TFA_BO1.CLAYMORE.PLANT")
ENT.TriggerSound = Sound("TFA_BO1.CLAYMORE.DETONATE")

--[Parameters]--
ENT.Exploded = false
ENT.Impacted = false
ENT.Triggered = false
ENT.HP = 100

DEFINE_BASECLASS(ENT.Base)

function ENT:Draw()
	self:DrawModel()

	local vec1 = self:GetPos() + self:GetForward() * 2 + Vector(0,0,10)
	local vec2 = self:GetPos() + self:GetRight() * -25 + self:GetForward() * 10 + Vector(0,0,10)
	render.SetMaterial(Material("cable/redlaser"))
	render.DrawBeam(vec1, vec2, 1, 1, 1, Color(255, 255, 255, 255))
	 
	local vec3 = self:GetPos() + self:GetForward() * -2 + Vector(0,0,10)
	local vec4 = self:GetPos() + self:GetRight() * -25 + self:GetForward() * -10 + Vector(0,0,10)
	render.SetMaterial(Material("cable/redlaser"))
	render.DrawBeam(vec3, vec4, 1, 1, 1, Color(255, 255, 255, 255))
end

function ENT:PhysicsCollide(data, phys)
	local ent = data.HitEntity
	if !ent:IsWorld() and !ent:IsPlayer() and !ent:IsNPC() and ent:IsSolid() then
		self:SetParent(ent)
	end
	self:EmitSound(self.BounceSound)
	phys:EnableMotion(false)
	phys:Sleep()
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self.Impacted = true
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)
	
	self.myowner = self:GetOwner()
	if not IsValid(self.myowner) then
		self.myowner = self
	end
	self.myclass = self:GetClass()
end

function ENT:Think()
	if SERVER and self.Impacted and !self.Triggered then
		local tr1 = util.TraceHull({
		start =  self:GetPos() + Vector(0,0,10),
		endpos = self:GetPos() + self:GetRight() * -50 + self:GetForward() * -15 + Vector(0,0,10),
		maxs = Vector(5,5,5),
		mins = Vector(-5,-5,-5),
		filter = {self.myowner, self:GetOwner(), self},
		collisiongroup = COLLISION_GROUP_PASSABLE_DOOR,
		})

		local tr2 = util.TraceHull({
		start =  self:GetPos() + Vector(0,0,10),
		endpos = self:GetPos() + self:GetRight() * -50 + self:GetForward() * 15 + Vector(0,0,10),
		maxs = Vector(5,5,5),
		mins = Vector(-5,-5,-5),
		filter = {self.myowner, self:GetOwner(), self},
		collisiongroup = COLLISION_GROUP_PASSABLE_DOOR,
		})

		if tr1.HitNonWorld or tr2.HitNonWorld then
			if tr1.Entity:IsValid() then
				if not (tr1.Entity:IsNextBot() or tr1.Entity:IsNPC()) then return end
			end
			if tr2.Entity:IsValid() then
				if not (tr2.Entity:IsNextBot() or tr2.Entity:IsNPC()) then return end
			end
			self.Triggered = true
			self:EmitSound(self.TriggerSound)
			timer.Simple(0.5, function() --im stupid so im using a timer
				if not self:IsValid() then return end
				self:Explode()
			end)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Use(ply, caller)
	if CLIENT then return end
	if IsValid(ply) and ply == self:GetOwner() and ply:HasWeapon('nz_bo1_claymore') then
		if ply:GetAmmoCount(GetNZAmmoID("specialgrenade")) < 3 then
			ply:GiveAmmo(1, GetNZAmmoID("specialgrenade"), false)
		else
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetOrigin(self:GetAttachment(1).Pos)
			fx:SetNormal(vector_up*-1)
			fx:SetScale(2)
			fx:SetMagnitude(2)
			fx:SetRadius(2)

			util.Effect("ElectricSpark", fx)
			util.Effect("Sparks", fx)
			self:EmitSound("nz_wavy/effects/jake_fart_03.wav")
		end
		self:Remove()
	end
end

--[[function ENT:FriendCheck(ent)
	if !ent:IsNextBot() or !ent:IsNPC() then
		return true 
	end
	return false
end]]

--[[function ENT:OnTakeDamage(dmg)
	if dmg:GetInflictor() == self or dmg:GetAttacker() == self then return end
	if self.Exploded then return end
	if self.HP > 0 and self.HP - dmg:GetDamage() <= 0 then
		self.Exploded = true
		self:Explode()
	end
	self.HP = self.HP - dmg:GetDamage()
	dmg:SetAttacker(self)
	dmg:SetInflictor(self)
end]]

function ENT:DoExplosionEffect()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())

	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)

	self:EmitSound("TFA.BO1.EXP.Explode")
	self:EmitSound("TFA.BO1.EXP.Flux")
	self:EmitSound("TFA.BO1.EXP.Lfe")
	self:EmitSound("TFA.BO1.EXP.Dirt")
end

function ENT:Explode()
	if not IsValid(self.Inflictor) then
		self.Inflictor = self
	end

	local tr = {
		start = self:GetPos(),
		filter = {self, self:GetOwner()},
		mask = MASK_SOLID_BRUSHONLY
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 250)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == self:GetOwner() then continue end
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			self:InflictDamage(v)
		end
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, 500)
	self:DoExplosionEffect()
	self:Remove()
end

function ENT:InflictDamage(ent, override)
	if CLIENT then return end

	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(self)
	damage:SetDamageForce(ent:GetUp()*20000 + (ent:GetPos() - self:GetPos()):GetNormalized() * 15000)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))

	ent:TakeDamageInfo(damage)
end