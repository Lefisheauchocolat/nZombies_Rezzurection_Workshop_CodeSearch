
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
ENT.PrintName = "Матрёшка (nZombies)"

--[Parameters]--
ENT.Delay = 1.5
ENT.Range = 200
ENT.NZThrowIcon = Material("vgui/icon/t7_zm_hud_doll.png", "unlitgeneric smooth")

--[Sounds]--
ENT.ExplosionSound1 = "TFA_BO3_GRENADE.Dist"
ENT.ExplosionSound2 = "TFA_BO3_GRENADE.Exp"
ENT.ExplosionSound3 = "TFA_BO3_GRENADE.ExpClose"
ENT.ExplosionSound4 = "TFA_BO3_GRENADE.Flux"

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Character")
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

	if data.Speed < 100 then
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
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:EmitSoundNet("TFA_BO3_DOLL.Pop")
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(1, "metal_bouncy")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

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

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 1, self.color, false, 24, 1, 0.35, 2, "effects/laser_citadel1.vmt")
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
			dlight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:Explode()
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

function ENT:Explode()
	local ply = self:GetOwner()
	local tr = {
		start = self:WorldSpaceCenter(),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetDamage(10000)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end
			if v:IsPlayer() and v ~= ply then continue end

			if v:IsPlayer() then
				local distfac = self:GetPos():Distance(v:GetPos())
				distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
				damage:SetDamage(150*distfac)
			end

			damage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 7000)
			damage:SetDamagePosition(v:WorldSpaceCenter())

			v:TakeDamageInfo(damage)

			damage:SetDamage(10000)
		end
	end

	util.ScreenShake(self:GetPos(), 15000, 255, 1, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end
