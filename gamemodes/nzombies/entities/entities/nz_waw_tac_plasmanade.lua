
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
ENT.PrintName = "Plasma Grenade"

--[Parameters]--
ENT.Delay = 1.4
ENT.Range = 240
ENT.NZThrowIcon = Material("vgui/icon/hud_plasma_shield_bw.png", "smooth unlitgeneric")

local BounceSound = {
	[MAT_WOOD] = "TFA_WAW_PLASMANADE.Bounce.Wood",
	[MAT_DIRT] = "TFA_WAW_PLASMANADE.Bounce.Earth",
	[MAT_METAL] = "TFA_WAW_PLASMANADE.Bounce.Metal",
	[0] = "TFA_WAW_PLASMANADE.Bounce.Earth",
}

BounceSound[MAT_GRATE] = BounceSound[MAT_METAL]
BounceSound[MAT_VENT] = BounceSound[MAT_METAL]
BounceSound[MAT_GRASS] = BounceSound[MAT_DIRT]
BounceSound[MAT_SNOW] = BounceSound[MAT_DIRT]
BounceSound[MAT_SNOW] = BounceSound[MAT_DIRT]

DEFINE_BASECLASS( ENT.Base )

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:Draw()
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		local norm = (data.HitPos - self:GetPos()):GetNormalized()
		local tr = util.QuickTrace(self:GetPos(), norm*10, self)

		if tr.Hit then
			local finalsound = BounceSound[tr.MatType] or BounceSound[0]
			self:EmitSound(finalsound)
		end

		self:EmitSound("TFA_WAW_PLASMANADE.Bounce")
	end

	local ent = data.HitEntity
	if IsValid(ent) then
		self:InflictDamage(ent, data.HitPos, -data.HitNormal)
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )
end

function ENT:Initialize()
	BaseClass.Initialize(self)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self.Damage = self.mydamage or self.Damage

	self.killtime = CurTime() + self.Delay

	self:EmitSound("TFA_WAW_PLASMANADE.Charge")
	ParticleEffectAttach("waw_plasmanade_trail", PATTACH_POINT_FOLLOW, self, 2)

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 0, color_white, true, 6, 0, 0.4, 0.1, "effects/laser_citadel1.vmt")
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		local mul = 1 - math.Clamp((self:GetCreationTime() + self.Delay) - CurTime(), 0, 1)
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 255
			dlight.b = 255
			dlight.brightness = 0.5
			dlight.Decay = 2000
			dlight.Size = (self.Range*0.5) * mul
			dlight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:Explode()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos, hitnorm)
	if not hitpos then
		hitpos = ent:WorldSpaceCenter()
	end
	if not hitnorm then
		hitnorm = -ent:GetForward()
	end

	local damage = DamageInfo()
	damage:SetDamage(10)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce(hitnorm)
	damage:SetDamageType(DMG_PLASMA)

	ent:TakeDamageInfo(damage)
end

function ENT:Explode()
	local ply = self:GetOwner()

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsPlayer() and v:Alive() then
			if not v:GetNotDowned() then
				v:RevivePlayer(v)
				if v.OldPerks then
					for _, perk in pairs(v.OldPerks) do
						v:GivePerk(perk)
					end
				end
			end
			v:WAWPlasmaRage(12)
		end
	end

	util.ScreenShake(self:GetPos(), 10, 5, 1, self.Range*2)

	local tr = util.QuickTrace(self:GetPos(), vector_up*-2, self)
	if tr.HitWorld then
		ParticleEffect("waw_plasmanade_explode_arcs", self:GetPos(), angle_zero)
		util.Decal("Scorch", tr.HitPos - vector_up, tr.HitPos + vector_up)
	end

	ParticleEffect("waw_plasmanade_explode", self:GetPos(), angle_zero)
	self:EmitSound("TFA_WAW_PLASMANADE.Expl")
	self:EmitSound("TFA_WAW_PLASMANADE.Expl.Sweet")

	self:Remove()
end

function ENT:OnRemove(...)
	self:StopSound("TFA_WAW_PLASMANADE.Charge")

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 255
			dlight.b = 255
			dlight.brightness = 1
			dlight.Decay = 2000
			dlight.Size = self.Range*2
			dlight.dietime = CurTime() + 0.5
		end
		
	end

	return BaseClass.OnRemove(self, ...)
end
