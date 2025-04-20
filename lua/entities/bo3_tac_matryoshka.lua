
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
ENT.PrintName = "Матрёшка"

--[Parameters]--
ENT.Delay = 1
ENT.Range = 200
ENT.ClonesMax = 4
ENT.ClonesCount = 1

--[Sounds]--
ENT.ExplosionSound1 = "TFA_BO3_GRENADE.Dist"
ENT.ExplosionSound2 = "TFA_BO3_GRENADE.Exp"
ENT.ExplosionSound3 = "TFA_BO3_GRENADE.ExpClose"
ENT.ExplosionSound4 = "TFA_BO3_GRENADE.Flux"

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Int", 0, "Character")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		self:EmitSound("TFA_BO3_DOLL.Bounce")
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )

	if data.Speed < 100 and data.HitNormal:Dot(vector_up) < 0 then
		self:ActivateCustom(phys)
	end
end

function ENT:ActivateCustom(phys)
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:SetActivated(true)

	if SERVER then
		sound.EmitHint(SOUND_DANGER, self:GetPos(), 300, 0.5, IsValid(self:GetOwner()) and self:GetOwner() or self)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:EmitSoundNet("TFA_BO3_DOLL.Pop")
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(1, "metal_bouncy")
	self:SetRoll(self:GetAngles())

	if self:GetCharacter() == 1 then
		self.color = Color(0,0,255,255)
		self:SetSkin(1)
	elseif self:GetCharacter() == 2 then
		self.color = Color(255,0,0,255)
		self:SetSkin(2)
	elseif self:GetCharacter() == 3 then
		self.color = Color(0,255,0,255)
		self:SetSkin(3)
	elseif self:GetCharacter() == 4 then
		self.color = Color(255,255,0,255)
		self:SetSkin(4)
	end

	self.killtime = CurTime() + self.Delay
	self.Damage = self.mydamage or self.Damage

	if CLIENT then return end
	util.SpriteTrail(self, 1, self.color, false, 12, 1, 0.35, 2, "effects/laser_citadel1.vmt")

	timer.Simple(6, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 20)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex(), false)
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 1
			dlight.Decay = 2000
			dlight.Size = 128
			dlight.dietime = CurTime() + 0.1
		end
	end

	if SERVER then
		if self:GetActivated() and self.killtime < CurTime() then
			if self.ClonesCount > self.ClonesMax then
				self:Explode()
				self:Remove()
				return false
			end

			if self.ClonesCount <= 4 and self.ClonesCount ~= self:GetCharacter() then
				self:SpawnClones(self.ClonesCount)
			end

			self.ClonesCount = self.ClonesCount + 1
			self.killtime = CurTime() + math.Rand(0.15,0.2)
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

function ENT:Explode()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			local damage = DamageInfo()
			damage:SetDamage(self.Damage)
			damage:SetAttacker(IsValid(ply) and ply or self)
			damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
			damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
			damage:SetDamagePosition(v:WorldSpaceCenter())

			if v:IsPlayer() then
				local distfac = self:GetPos():Distance(v:GetPos())
				distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
				damage:SetDamage(200*distfac)
			end

			damage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 7000)

			v:TakeDamageInfo(damage)
		end
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:SpawnClones(val)
	local doll = ents.Create("bo3_tac_matryoshka_mini")
	doll:SetModel("models/weapons/tfa_bo3/matryoshka/matryoshka_prop.mdl")
	doll:SetPos(self:GetPos() + Vector(0,0,2))
	doll:SetAngles(Angle(0, math.random(-180,180), 0))
	doll:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

	doll.Damage = self.Damage
	doll.mydamage = self.Damage
	doll:SetCharacter(val)
	doll:SetSkin(val)

	doll:Spawn()

	local vel = Vector(math.random(-250,250), math.random(-250,250), math.random(200,400))

	doll:SetVelocity(vel)
	local phys = doll:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetVelocity(vel)
	end

	doll:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	doll.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self
end
