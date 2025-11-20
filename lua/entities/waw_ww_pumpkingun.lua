AddCSLuaFile()

ENT.Base = "tfa_exp_base"
ENT.PrintName = "Rocket-Propelled Pumpkin"

ENT.Delay = 10
ENT.Impacted = false
ENT.Range = 250
ENT.SearchRange = 400

ENT.Ratio = 0
ENT.CurveStrengthMin = 1
ENT.CurveStrengthMax = 1

ENT.BaseSpeed = 200
ENT.AccelerationTime = 1
ENT.MaxSpeed = 1000
ENT.AccelProgress = 0

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Vector", 0, "HitPos")
	self:NetworkVar("Bool", 0, "Upgraded")
end

function ENT:PhysicsCollide(data, phys)
	if nzombies and IsValid(data.HitEntity) and data.HitEntity:IsPlayer() then return end
	if self.Impacted then return end
	if IsValid(data.HitEntity) and (data.HitEntity:IsNPC() or data.HitEntity:IsNextBot()) then
		data.HitEntity:WAWPumpkin(math.Rand(2,3.2), self:GetOwner(), self.Inflictor, self:GetUpgraded())
	end
	self:Explode(data.HitPos)
	self:SetHitPos(data.HitPos)

	util.Decal("Scorch", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)

	self.Impacted = true
	self:Remove()
end

function ENT:StartTouch(ent)
	if ent == self:GetOwner() then return end
	if self.Impacted then return end
	if nzombies and not (ent:IsNPC() or ent:IsNextBot()) then return end

	if not ent:IsWorld() and ent:IsSolid() then
		if ent:IsNPC() or ent:IsNextBot() then
			ent:WAWPumpkin(math.Rand(2,3.2), self:GetOwner(), self.Inflictor, self:GetUpgraded())
		end
		self:SetHitPos(self:GetPos())
		self:Explode(self:GetPos())
		self.Impacted = true
		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:EmitSound("TFA_WAW_PUMPKINGUN.Shot")
	self.killtime = CurTime() + self.Delay
	ParticleEffectAttach(self:GetUpgraded() and "waw_pumpkingun_trail_2" or "waw_pumpkingun_trail", PATTACH_POINT_FOLLOW, self, 1)
	self:SetModelScale(0.65, 0)

	if self:GetUpgraded() then
		self.color = Color(0,200,255,255)
	else
		self.color = Color(255,150,0,255)
	end

	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	if nzombies then
		self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self:NextThink(CurTime())

	if CLIENT then return end
	if math.random(100) <= 20 then
		self.Talker = true
	end
	if self.Talker then
		self:EmitSound("TFA_WAW_PUMPKINGUN.Chatter")
	end
	self:SetTrigger(true)
end

function ENT:Think()
	if self.AccelerationTime > 0 and self.AccelProgress < 1 then
		self.LastAccelThink = self.LastAccelThink or CurTime()
		self.AccelProgress = Lerp((CurTime() - self.LastAccelThink) / self.AccelerationTime, self.AccelProgress, 1)
	end

	if CLIENT then
		if dlight_cvar:GetBool() and DynamicLight then
			local dlight = DynamicLight(self:EntIndex(), false)
			if dlight then
				dlight.pos = self:GetPos()
				dlight.r = self.color.r
				dlight.g = self.color.g
				dlight.b = self.color.b
				dlight.brightness = 2
				dlight.Decay = 2500
				dlight.Size = 128
				dlight.DieTime = CurTime() + 0.2
			end
		end

		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetVelocity():Angle() + Angle(90,0,0))
	end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		local speed = Lerp(self.AccelProgress, self.BaseSpeed, self.MaxSpeed)
		if self:WaterLevel() == 0 then
			phys:SetVelocity(self:GetForward() * speed)
		else
			phys:SetVelocity(self:GetForward() * speed/2)
		end

		phys:AddAngleVelocity(VectorRand() * (math.sin(CurTime() * 30))* math.random(self.CurveStrengthMin, self.CurveStrengthMax))
		self:SetAngles(phys:GetVelocity():Angle())

		if IsValid(self:GetTarget()) then
			local tang = (self:GetTarget():GetPos() - self:GetPos()) + self:GetTarget():OBBCenter()
			self.Ratio = math.Clamp(self.Ratio + 0.01, 0, 1)

			self:SetAngles(LerpAngle(self.Ratio, self:GetAngles(), tang:Angle()))
		end
	end

	if SERVER then
		if self:GetUpgraded() and not IsValid(self:GetTarget()) and self:GetCreationTime() + 0.2 < CurTime() or (IsValid(self:GetTarget()) and self:GetTarget():Health() <= 0) then
			if nzombies then
				self:SetTarget(self:FindNearestZombie(self:GetPos()))
			else
				self:SetTarget(self:FindNearestEntityCheap(self:GetPos()))
			end
		end

		if self.killtime < CurTime() then
			self:Explode(self:GetPos())
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:FindNearestEntityCheap(pos)
	if not pos then
		pos = self:GetPos()
	end

	local nearestent
	local ply = IsValid(self:GetOwner()) and self:GetOwner() or self
	local tr = {
		start = pos,
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(pos, self.SearchRange)) do
		if v:IsNPC() or v:IsNextBot() then
			if v == self:GetOwner() then continue end
			if v:Health() <= 0 then continue end
			if v:WAWIsPumpkin() then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.Entity ~= v then continue end

			nearestent = v
			break
		end
	end

	return nearestent
end

function ENT:FindNearestZombie(pos)
	if not nzombies then return end
	if not pos then
		pos = self:GetPos()
	end

	local nearestent
	local ply = IsValid(self:GetOwner()) and self:GetOwner() or self
	local tr = {
		start = pos,
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	if nzLevel then
		for k, v in nzLevel.GetZombieArray() do
			if not IsValid(v) or (v.Alive and not v:Alive()) then continue end
			if v:Health() <= 0 then continue end
			if v:WAWIsPumpkin() then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.Entity ~= v then continue end

			nearestent = v
			break
		end
	else
		for k, v in pairs(ents.FindInPVS(ply)) do
			if not v:IsValidZombie() then continue end
			if v:Health() <= 0 then continue end
			if v.Alive and not v:Alive() then continue end
			if v:WAWIsPumpkin() then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.Entity ~= v then continue end

			nearestent = v
			break
		end
	end

	return nearestent
end

function ENT:DoExplosionEffect()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())

	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)

	self:EmitSound("TFA_WAW_PUMPKINGUN.Explode")
	if self.Talker then
		self:StopSound("TFA_WAW_PUMPKINGUN.Chatter")
		self:EmitSound("TFA_WAW_PUMPKINGUN.Kaboom")
	end
end

function ENT:Explode(pos)
	if self.Impacted then return end

	if not pos then
		pos = self:GetPos()
	end

	local ply = self:GetOwner()
	local tr = {
		start = pos,
		filter = self,
		mask = MASK_SHOT_HULL
	}

	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(nzombies and DMG_BLAST or bit.bor(DMG_BLAST, DMG_AIRBOAT))

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == ply then continue end
			if nzombies and v:IsPlayer() then continue end
			local own = v:GetOwner()
			if IsValid(own) and (own == ply or (nzombies and own:IsPlayer())) then continue end
			if v:WAWIsPumpkin() then
				v.waw_pumpkingun_logic.statusEnd = CurTime() + math.Rand(0,0.25)
				continue
			end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			local hitpos = tr1.Entity == v and tr1.HitPos or tr.endpos
			damage:SetDamagePosition(hitpos)
			damage:SetDamageForce(v:GetUp()*15000 + (v:GetPos() - pos):GetNormalized() * 10000)

			if nzombies and v:IsValidZombie() then
				if (v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "zombie_boss")) then
					self.IsBoss = true
					damage:SetDamage(math.max(1800, v:GetMaxHealth() / 7))
				end
			end

			if (v:IsNPC() or v:IsNextBot()) and ((v:Health() - damage:GetDamage()) <= 0 or (v.PumpkinMark and v.PumpkinMark >= 3)) and !self.IsBoss then
				if v.PumpkinMark then v.PumpkinMark = 0 end
				v:WAWPumpkin(math.Rand(2,3.2), damage:GetAttacker(), damage:GetInflictor(), self:GetUpgraded())
			else
				local distfac = pos:Distance(hitpos)
				distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)

				if not v.PumpkinMark then v.PumpkinMark = 0 end
				v.PumpkinMark = v.PumpkinMark + ((distfac > 0.64 and 3) or (distfac > 0.28 and 2) or 1) //90hu //180hu

				/*local pktimer = "pumpkin_decay"..v:EntIndex()
				if timer.Exists(pktimer) then
					timer.Remove(pktimer)
				end
				timer.Create(pktimer, 6, 0, function()
					if not IsValid(v) then timer.Remove(pktimer) return end
					if v:Health() <= 0 then timer.Remove(pktimer) return end
					if not v.PumpkinMark then v.PumpkinMark = 0 end
					v.PumpkinMark = math.max(v.PumpkinMark - 1, 0)
					if v.PumpkinMark == 0 then timer.Remove(pktimer) return end
				end)*/

				v:TakeDamageInfo(damage)
			end
		end
	end

	util.ScreenShake(pos, 10, 255, 1, self.Range*1.5)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnRemove()
	self:StopSound("TFA_WAW_PUMPKINGUN.Shot")
	if CLIENT and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 4
			dlight.Decay = 2000
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.5
		end
	end
end
