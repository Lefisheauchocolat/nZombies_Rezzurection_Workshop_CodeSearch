AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Molotov"

ENT.BounceSound = Sound("HEGrenade.Bounce")
ENT.ExplodeSound = "TFA_BO1_MOLOTOV.Loop"
ENT.ShatterSound = "TFA_BO1_MOLOTOV.Explode"

ENT.Range = 120
ENT.Delay = 10
ENT.Life = 8
ENT.LifePaP = 16

DEFINE_BASECLASS(ENT.Base)

local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Upgraded")
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	if data.HitNormal:Dot(Vector(0,0,-1))<0.75 then
		if data.Speed > 60 then
			self:EmitSound(self.BounceSound)
		end

		local impulse = (data.OurOldVelocity - 3 * data.OurOldVelocity:Dot(data.HitNormal) * data.HitNormal)*0.9
		phys:ApplyForceCenter(impulse)
	else
		self:StopParticles()

		self:SetNoDraw(true)
		self:DrawShadow(false)

		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetAngles(data.HitNormal:Angle() - Angle(90,0,0))
			self:SetPos(data.HitPos)
			self:SetSolid(SOLID_NONE)
			self:SetMoveType(MOVETYPE_NONE)
			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		end)

		self:Explode()
		phys:EnableMotion(false)
		phys:Sleep()

		ParticleEffect(self:GetUpgraded() and "bo1_molotov_impact_2" or "bo1_molotov_impact", data.HitPos + vector_up, angle_zero)

		self:SetActivated(true)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self.killtime = CurTime() + self.Delay
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	ParticleEffectAttach(self:GetUpgraded() and "bo1_molotov_trail_2" or "bo1_molotov_trail", PATTACH_POINT_FOLLOW, self, 1)

	self:NextThink(CurTime())
end

function ENT:Think()
	local ply = self:GetOwner()
	if CLIENT and self:GetActivated() and dlight_cvar:GetBool() then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			local upg = self:GetUpgraded()
			local colr, colg, colb = upg and 90 or 235, upg and 230 or 75, upg and 255 or 15

			dlight.pos = self:GetPos() + vector_up
			dlight.r = colr
			dlight.g = colg
			dlight.b = colb
			dlight.brightness = 3
			dlight.Decay = 1000
			dlight.Size = 400
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self.killtime and self.killtime < CurTime() then
			self:Remove()
			return false
		end
		if self:WaterLevel() > 0 then
			self:Remove()
			return false
		end

		if self:GetActivated() then
			local ply = self:GetOwner()
			local tr = {
				start = self:GetPos(),
				filter = self,
				mask = MASK_SHOT_HULL
			}

			for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
				if v:IsPlayer() or v:IsNPC() or v:IsNextBot() or v:IsVehicle() then
					if v.NextBurn and v.NextBurn > CurTime() then continue end
					if v == self:GetOwner() and self:GetUpgraded() then continue end
					if v:IsPlayer() and not pvp_bool:GetBool() then continue end
					if v:IsPlayer() and IsValid(ply) and ply:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

					tr.endpos = v:WorldSpaceCenter()
					local tr1 = util.TraceLine(tr)
					if tr1.HitWorld then continue end

					v.NextBurn = CurTime() + 1/3
					self:InflictDamage(v)
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	local mydamage = self:GetUpgraded() and math.random(28,36) or math.random(14,18)

	local damage = DamageInfo()
	damage:SetDamage(mydamage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageType(bit.bor(DMG_SLOWBURN, DMG_AIRBOAT))

	local distfac = self:GetPos():Distance(ent:GetPos())
	distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
	damage:ScaleDamage(math.Clamp(distfac*(4/3), 0.2, 1.2))

	ent:Ignite(3)
	ent:TakeDamageInfo(damage)
end

function ENT:DoExplosionEffect()
	self:EmitSound(self.ShatterSound)
	self:EmitSound(self.ExplodeSound)
	ParticleEffectAttach(self:GetUpgraded() and "bo1_molotov_loop_2" or "bo1_molotov_loop", PATTACH_ABSORIGIN, self, 1)
	util.ScreenShake(self:GetPos(), 5, 255, 1, self.Range*1.5)
end

function ENT:Explode()
	self:DoExplosionEffect()

	local dmg = DamageInfo()
	dmg:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	dmg:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	dmg:SetDamage(60)
	dmg:SetDamageType(bit.bor(DMG_BURN, DMG_SLOWBURN))
	util.BlastDamageInfo(dmg, self:GetPos(), 150)

	self.killtime = nil
	SafeRemoveEntityDelayed(self, self:GetUpgraded() and self.LifePaP or self.Life) --removal of nade
end

function ENT:OnRemove()
	self:StopParticles()
	self:StopSound(self.ExplodeSound)
	self:EmitSound("TFA_BO1_MOLOTOV.Burn")
end