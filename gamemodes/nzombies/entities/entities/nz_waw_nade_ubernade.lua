
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
ENT.PrintName = "Quizz Ubernade"

--[Sounds]--
ENT.BounceSound = "TFA_WAW_BBETTY.Plant"
ENT.LoopSound = "TFA_WAW_UBERNADE.Loop"
ENT.LoopSoundSweet = "TFA_WAW_UBERNADE.Loop.Sweet"
ENT.NZThrowIcon = Material("vgui/icon/hud_quizz_flare.png", "unlitgeneric smooth")

--[Parameters]--
ENT.Exploded = false
ENT.HasJumped = false
ENT.Delay = 2.8
ENT.Range = 280

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end

	if data.HitNormal:Dot(vector_up*-1) > 0.9 then
		self:EmitSound(self.BounceSound)
		self.HitPos = data.HitPos + data.HitNormal
		self:ActivateCustom(phys)
		return
	end

	if data.Speed > 60 then
		self:EmitSound(self.BounceSound)
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )

	if (data.Speed) < 100 and data.HitNormal:Dot(vector_up) < 0 then
		self.HitPos = data.HitPos + data.HitNormal
		self:ActivateCustom(phys)
	end
end

function ENT:ActivateCustom(phys)
	timer.Simple(0, function()
		if not IsValid(self) then return end
		//self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:SetActivated(true)
	self:SetAngles(self.DesiredAng)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:PhysicsInitSphere(0.1, "metal_bouncy")
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)
	self.RangeSqr = self.Range*self.Range

	ParticleEffectAttach("waw_ubernade_flare", PATTACH_POINT_FOLLOW, self, 2)
	self:EmitSound(self.LoopSound)
	self:EmitSound(self.LoopSoundSweet)
	self.DesiredAng = self:GetAngles()
	self:SetActivated(false)

	if CLIENT then return end
	timer.Simple(6, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 24)
end

function ENT:Think()
	if SERVER and self:GetCreationTime() + self.Delay < CurTime() then
		self:Jump()
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Jump()
	if not SERVER then return end
	if self.HasJumped then return end
	self.HasJumped = true

	self:StopSound(self.LoopSound)
	self:StopSound(self.LoopSoundSweet)
	self:EmitSound("TFA_WAW_UBERNADE.Click")
	self:StopParticles()

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(true)
		phys:Wake()
		phys:ApplyForceCenter(vector_up*500)
	end

	timer.Simple(0.1, function()
		if not self:IsValid() then return end
		self:Explode()
	end)
end

function ENT:DoExplosionEffect()
	if self.HitPos then
		ParticleEffect("waw_ubernade_ground", self.HitPos, angle_zero)
		util.Decal("Scorch", self.HitPos - vector_up, self.HitPos + vector_up)
	end

	ParticleEffect("waw_ubernade_explode", self:GetPos(), angle_zero)
	self:EmitSound("TFA_WAW_UBERNADE.Expl")
	self:EmitSound("TFA_WAW_UBERNADE.Expl.Sweet")
end

function ENT:Explode()
	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_ENERGYBEAM)

	self.Damage = self.mydamage or self.Damage
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsWorld() then continue end
		if v:IsPlayer() and v ~= ply then continue end

		tr.endpos = v:WorldSpaceCenter()
		local tr1 = util.TraceLine(tr)
		if tr1.HitWorld then continue end
		local hitpos = tr1.Entity == v and tr1.HitPos or tr.endpos

		local dist = self:GetPos():DistToSqr(hitpos)
		dist = 1 - math.Clamp(dist/self.RangeSqr, 0, 0.5)

		damage:SetDamage(self.Damage * dist)
		damage:SetDamagePosition(hitpos)

		if v == ply then
			damage:SetDamage(100 * dist)
			if v:Crouching() then
				damage:ScaleDamage(0.5)
			end
		end

		if (v:IsValidZombie() and not (v.NZBossType and v.IsMooBossZombie)) and dist >= 0.8 then
			damage:SetDamage(v:Health() + 666)
		end

		damage:SetDamageForce(v:GetUp()*math.random(280,320)*(100*dist) + (v:GetPos() - self:GetPos()):GetNormalized()*math.random(160,180)*(100*dist))

		v:TakeDamageInfo(damage)

		damage:SetDamage(self.Damage)
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnRemove()
	self:StopSound(self.LoopSound)
	self:StopSound(self.LoopSoundSweet)
end