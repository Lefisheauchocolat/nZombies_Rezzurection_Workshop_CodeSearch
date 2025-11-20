AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Player Triggered Explosive"

--[Sounds]--
ENT.BounceSound = Sound("TFA_BO1_C4.Plant")
ENT.ExplodeSound = Sound("TFA_BO1_C4.Expl")

--[Parameters]--
ENT.Impacted = false
ENT.HP = 55
ENT.Range = 220

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")
local glowmat = Material("effects/c4_glow.vmt")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
end

function ENT:Draw()
	self:DrawModel()

	render.SetMaterial(glowmat)
	render.DrawSprite(self:GetAttachment(3).Pos, 1.5, 1.5, self.pcolor)
end

function ENT:PhysicsCollide(data, phys)
	self.Impacted = true

	local ent = data.HitEntity
	if !ent:IsWorld() and ent:IsSolid() then
		local pos = data.HitPos
		local ang = data.HitNormal:Angle() + Angle(-90,0,0)

		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetCollisionGroup(COLLISION_GROUP_WORLD)
			self:SetTrigger(true)
			self:SetAngles(ang)
			self:SetPos(pos)

			timer.Simple(0, function()
				if not IsValid(self) then return end
				if not IsValid(ent) then return end

				self:SetParent(ent)
				ent:CallOnRemove("c4_removed"..self:EntIndex(), function(p)
					if IsValid(self) then
						self:SetParent(nil)
						self:SetTrigger(false)
						self:SetPos(p:WorldSpaceCenter() + VectorRand(-6,6))

						local phys = self:GetPhysicsObject()
						if IsValid(phys) then
							phys:EnableMotion(true)
							phys:Wake()
						end
					end
				end)
			end)
		end)
	else
		timer.Simple(0, function()
			if not self:IsValid() then return end
			self:SetPos(data.HitPos - data.HitNormal*0.5)
			self:SetCollisionGroup(COLLISION_GROUP_WORLD)
			self:SetTrigger(true)
		end)
		self:SetAngles(data.HitNormal:Angle() + Angle(-90,0,0))
	end

	self.hitpos = data.HitPos
	self.hitnorm = data.HitNormal

	phys:EnableMotion(false)
	phys:Sleep()

	self:EmitSound(self.BounceSound)

	timer.Simple(0.5, function()
		if not IsValid(self) then return end
		if self.mytrail and IsValid(self.mytrail) then
			self.mytrail:Remove()
		end
	end)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	local ply = self:GetOwner()
	if IsValid(ply) then
		local pvcol = ply:GetPlayerColor()
		self.pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)

		if not ply.ActiveC4s then ply.ActiveC4s = {} end
		table.insert(ply.ActiveC4s, self)
	end

	self.RangeSqr = self.Range*self.Range

	self:NextThink(CurTime())

	if SERVER then
		if self.nzPaPCamo then
			self:SetMaterial(self.nzPaPCamo)
		end
		if self.RampupSound then
			self:EmitSound(self.RampupSound)
		end
		self.mytrail = util.SpriteTrail(self, 3, self.pcolor, true, 3, 0, 0.2, 0.1, "effects/laser_citadel1")
	end
end

function ENT:Think()
	if CLIENT and self.pcolor and dlight_cvar:GetBool() then
		local dlight = DynamicLight(self:EntIndex(), true)
		if (dlight) then
			dlight.pos = self:GetAttachment(3).Pos
			dlight.r = self.pcolor.r
			dlight.g = self.pcolor.g
			dlight.b = self.pcolor.b
			dlight.brightness = 0.5
			dlight.Decay = 1000
			dlight.Size = 24
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self.Cooked and self.Cooked <= CurTime() then
			self:Explode()
		end

		local p = self:GetParent()
		if IsValid(p) and p:IsNPC() and p:Health() <= 0 then
			self:SetParent(nil)
			self:SetTrigger(false)
			self:SetPos(p:WorldSpaceCenter() + VectorRand(-6,6))

			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableMotion(true)
				phys:Wake()
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:DoExplosionEffect()
	if self.hitpos then
		util.Decal("Scorch", self.hitpos + self.hitnorm, self.hitpos - self.hitnorm)
	end

	if self:GetUpgraded() then
		self:EmitSound(self.ExplodeSound)
		if self.FluxSound then
			self:EmitSound(self.FluxSound)
		end

		ParticleEffect(self.ExplosionEffect, self:WorldSpaceCenter(), (self.hitnorm and self.hitnorm:Angle() + Angle(-90,0,0)) or angle_zero)
		if self.GroundEffect and self.hitpos and self.hitnorm and self.hitnorm:Dot(Vector(0,0,-1))>0.9 then
			ParticleEffect(self.GroundEffect, self.hitpos, angle_zero)
		end
	else
		self:EmitSound(self.ExplodeSound)
		if self.FluxSound then
			self:EmitSound(self.FluxSound)
		end

		local fx = EffectData()
		fx:SetOrigin(self:GetPos())

		util.Effect("HelicopterMegaBomb", fx)
		util.Effect("Explosion", fx)
	end
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	if self.RampupSound then
		self:StopSound(self.RampupSound)
	end

	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(self:GetUpgraded() and DMG_SHOCK or DMG_BLAST)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsWorld() then continue end
		if v:IsPlayer() and v ~= ply then continue end
		if self:GetUpgraded() and v == ply then continue end
		if v:Health() <= 0 then continue end

		tr.endpos = v:WorldSpaceCenter()
		local tr1 = util.TraceLine(tr)
		if tr1.HitWorld then continue end
		local hitpos = tr1.Entity == v and tr1.HitPos or tr.endpos

		local dist = self:GetPos():DistToSqr(hitpos)
		local distfac = 1 - math.Clamp(dist/self.RangeSqr, 0, 0.5)

		damage:SetDamage(self.Damage * distfac)
		damage:SetDamagePosition(hitpos)
		if v == ply then
			damage:SetDamage(50 * distfac)
			if v:IsPlayer() and v:Crouching() then
				damage:ScaleDamage(0.5)
			end
		end

		damage:SetDamageForce(v:GetUp()*math.random(15,20)*(1000*distfac) + (v:EyePos() - self:GetPos()):GetNormalized()*math.random(10,20)*1000)

		if self:GetUpgraded() and (v:IsNPC() or v:IsNextBot() or v:IsVehicle()) then
			v:SetHealth(1)
			damage:SetDamage(v:Health() + 666)

			if self.KillSound then
				v:EmitSound(self.KillSound)
			end
			if self.GroundEffect and v:OnGround() then
				ParticleEffect(self.GroundEffect, v:GetPos(), angle_zero)
			end
		end

		v:TakeDamageInfo(damage)
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnTakeDamage(dmg)
	if dmg:GetInflictor() == self or dmg:GetAttacker() == self then return end
	if self.Exploded then return end

	if dmg:IsExplosionDamage() then
		if dmg:GetAttacker() == self:GetOwner() then
			return
		end
		dmg:SetMaxDamage(math.Rand(10,20))
	end

	if self.HP > 0 and self.HP - dmg:GetMaxDamage() <= 0 then
		self:Explode()
		self.Exploded = true
	end

	self.HP = self.HP - dmg:GetMaxDamage()

	dmg:SetAttacker(self)
	dmg:SetInflictor(self)
end

function ENT:OnRemove(...)
	local ply = self:GetOwner()
	if IsValid(ply) and ply.ActiveC4s then
		table.RemoveByValue(ply.ActiveC4s, self)
	end

	return BaseClass.OnRemove(self, ...)
end
