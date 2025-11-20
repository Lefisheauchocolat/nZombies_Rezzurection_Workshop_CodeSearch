
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
ENT.PrintName = "Nuke"

--[Sounds]--
ENT.ExplosionSound1 = "TFA_BO4_GRENADE.Dist"
ENT.ExplosionSound2 = "TFA_BO4_GRENADE.Exp"
ENT.ExplosionSound3 = "TFA_BO4_GRENADE.ExpClose"
ENT.ExplosionSound4 = "TFA_BO4_GRENADE.Flux"

ENT.NukeSound1 = "TFA_BO4_OVERKILL.NukeFlash"
ENT.NukeSound2 = "TFA_BO4_OVERKILL.NukeEcho"

--[Parameters]--
ENT.Delay = 3

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		local impulse = (data.OurOldVelocity - 2 * data.OurOldVelocity:Dot(data.HitNormal) * data.HitNormal) * 0.25
		phys:ApplyForceCenter(impulse)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

	self:EmitSoundNet("TFA_BO4_OVERKILL.Cook")

	if CLIENT then return end
	self:Ignite(2)
end

function ENT:Think()
	if CLIENT and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)
		if self.DLight then
			self.DLight.pos = self:GetPos()
			self.DLight.r = 255
			self.DLight.g = 120
			self.DLight.b = 0
			self.DLight.brightness = 1
			self.DLight.Decay = 1000
			self.DLight.Size = 256
			self.DLight.dietime = CurTime() + 1
		end
	end

	return BaseClass.Think(self)
end

function ENT:DoExplosionEffect()
	ParticleEffect("bo3_panzer_explosion", self:GetPos(), Angle(0,0,0))

	self:EmitSound(self.NukeSound1)
	self:EmitSound(self.NukeSound2)
end

function ENT:NukeEffectEnemy(ent)
	local fx = EffectData()
	fx:SetOrigin(ent:GetPos())

	util.Effect("HelicopterMegaBomb", fx)

	ent:EmitSound("TFA_BO4_OVERKILL.NukeSoul")
end

function ENT:Explode()
	if nzombies then
		nzPowerUps:Nuke(self:GetPos())

		util.ScreenShake(self:GetPos(), 20, 255, 2.5, 2048)
		self:DoExplosionEffect()
		self:Remove()
		return
	end

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_PREVENT_PHYSICS_FORCE))
	damage:SetDamage(math.huge)

	for k, v in pairs(ents.GetAll()) do
		if v:IsPlayer() then
			v:ScreenFade(SCREENFADE.IN, Color(255,255,255,150), 1, 0.1)
		end
		if v:IsNPC() or v:IsNextBot() then
			if string.find(v:GetClass(), "boss") then
				damage:SetDamage(math.max(10000, v:GetMaxHealth() / 2))
			end
			damage:SetDamageForce(v:GetUp()*5000 + v:GetRight()*math.random(-1000,1000))
			if v:EyePos() then
				damage:SetDamagePosition(v:EyePos())
			end
			
			self:NukeEffectEnemy(v)

			v:TakeDamageInfo(damage)
			v:Ignite(4)
		end
	end
	
	util.ScreenShake(self:GetPos(), 50000, 255, 2.5, 2048)

	self:DoExplosionEffect()
	self:Remove()
end