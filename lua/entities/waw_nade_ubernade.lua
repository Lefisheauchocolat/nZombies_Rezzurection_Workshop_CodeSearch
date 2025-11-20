AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Quizz Ubernade"

--[Sounds]--
ENT.BounceSound = "TFA_WAW_BBETTY.Plant"
ENT.LoopSound = "TFA_WAW_UBERNADE.Loop"
ENT.LoopSoundSweet = "TFA_WAW_UBERNADE.Loop.Sweet"

--[Parameters]--
ENT.Exploded = false
ENT.HasJumped = false
ENT.Delay = 2.8
ENT.Range = 280

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Impacted")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetImpacted() then return end

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

	self:SetImpacted(true)
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
	self:SetImpacted(false)

	self:NextThink(CurTime())

	if CLIENT then return end
	timer.Simple(6, function()
		if IsValid(self) and not self:GetImpacted() then
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
		if v:IsPlayer() and IsValid(ply) and v ~= ply and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

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
		end

		if v:IsPlayer() and v:Crouching() then
			damage:ScaleDamage(0.5)
		end

		if (v:IsNPC() or v:IsNextBot()) and dist >= 0.8 then
			damage:SetDamage(v:Health() + 666)
			v:SetHealth(1)
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