
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
ENT.PrintName = "Airburst Nade"

--[Parameters]--
ENT.Delay = 0.4
ENT.Range = 220
ENT.BounceSound = "TFA_WAW_BBETTY.Plant"

DEFINE_BASECLASS( ENT.Base )

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 and !self.Exploded then
		self:EmitSound(self.BounceSound)
		sound.EmitHint(SOUND_COMBAT, data.HitPos, 500, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * (self.Exploded and 0.1 or 0.65)
	phys:SetVelocity( TargetVelocity )
end

function ENT:Initialize()
	BaseClass.Initialize(self)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

	self.colmins, self.colmaxs = self:GetCollisionBounds()
	self:PhysicsInitSphere(1, "metal_bouncy")

	self.killtime = CurTime() + self.Delay
	self.RangeSqr = self.Range * self.Range

	self:EmitSound("TFA_WAW_ABNADE.Charge")
	ParticleEffectAttach("waw_abnade_trail", PATTACH_POINT_FOLLOW, self, 1)

	if CLIENT then return end
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 30)
end

function ENT:Think()
	if SERVER and self.killtime < CurTime() and !self.Exploded then
		self:StopParticles()
		self:Explode()
		return false
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos, hitnorm, headshot)
	local ply = self:GetOwner()

	local dist = self:GetPos():DistToSqr(hitpos)
	dist = math.Remap(1 - math.Clamp(dist/self.RangeSqr, 0, 1), 0, 1, 0.5, 1)

	local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
	local health = tonumber(nzCurves.GenerateHealthCurve(round)) * 0.6

	local damage = DamageInfo()
	damage:SetDamage(self.Damage + (headshot and health or 0))
	if ent == ply then
		damage:SetDamage(50)
	end

	if !headshot and !ent.NZBossType and !ent.IsMooBossZombie then
		damage:ScaleDamage(dist)
	end

	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetReportedPosition(self:GetPos())
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce(hitnorm*8000)
	damage:SetDamageType(DMG_BLAST)

	ent:TakeDamageInfo(damage)
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	local ply = self:GetOwner()
	local pos = self:GetPos()

	local tr = {
		start = pos,
		filter = {self},
		mask = MASK_SHOT_HULL,
	}

	self.Damage = self.mydamage or self.Damage
	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if v:Health() <= 0 then continue end
		if v:IsPlayer() and v ~= ply then continue end

		local epos = v:GetPos()
		tr.endpos = Vector(epos[1],epos[2],pos[3])
		local tr1 = util.TraceLine(tr)
		if tr1.HitWorld then continue end

		self:InflictDamage(v, tr1.Entity == v and tr1.HitPos or tr.endpos, tr1.Normal, tr1.HitGroup == HITGROUP_HEAD)
		table.insert(tr.filter, v)
	end

	util.ScreenShake(pos, 10, 5, 1, self.Range*2)
	//util.BlastDamage(IsValid(self.Inflictor) and self.Inflictor or self, IsValid(ply) and ply or self, self:GetPos(), self.Range*0.5, 15)

	ParticleEffect("waw_abnade_explode", pos, angle_zero)
	self:StopSound("TFA_WAW_ABNADE.Charge")
	self:EmitSound("TFA_WAW_ABNADE.Expl")

	self:SetBodygroup(0, 1)
	self:PhysicsInitBox(self.colmins, self.colmaxs, "metal")
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetAngleVelocity(vector_origin)
		phys:AddAngleVelocity(Vector(1,math.Rand(0,1),0)*math.random(-200,200))
		phys:SetVelocity(vector_up*80 + self:GetRight()*math.random(-20,20))
	end

	SafeRemoveEntityDelayed(self, 6)
end

function ENT:OnRemove(...)
	self:StopSound("TFA_WAW_ABNADE.Charge")
	return BaseClass.OnRemove(self, ...)
end
