AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Fire Flechette"

--[Parameters]--
ENT.Delay = 10

ENT.Life = 4.5
ENT.LifeUpgraded = 6
ENT.LifeRandom = 0.5

ENT.Range = 120
ENT.BlastRange = 140

ENT.Burn = false
ENT.AttackDelay = 0.75
ENT.HealthFraction = 20

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	local ang = self:GetAngles()
	local ent = data.HitEntity
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:StopParticles()
		self:SetAngles(ang)
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetPos(data.HitPos)
		if IsValid(ent) and IsValid(data.HitObject) and !ent:IsWorld() then
			self:SetParent(ent)
		end
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self.killtime = CurTime() + self.Life
	self.fuckangle = data.HitNormal:Angle()
	self.hitwall = data.HitNormal:Dot(Vector(0,0,-1)) < 0.9 
end

function ENT:StartTouch(ent)
	if self.Impacted then return end

	local ply = self:GetOwner()
	if ent == ply then return end
	if not ent:IsSolid() then return end
	if nzombies and !(ent:IsNextBot() or ent:IsNPC()) then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end
	if ent:Health() <= 0 then return end

	self.Impacted = true
	self:SetParent(ent)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:StopParticles()
	end)

	self.fuckangle = self:GetTouchTrace().HitNormal:Angle()
	self.killtime = CurTime() + self.Life
	self.hitwall = true
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 1)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	ParticleEffectAttach("bo2_hellgat_trail", PATTACH_POINT_FOLLOW, self, 1)
	self:EmitSound("TFA_BO2_HELLGAT.Proj")
	self:EmitSound("TFA_BO2_HELLGAT.Proj.Charge")

	self.killtime = CurTime() + self.Delay
	if self:GetUpgraded() then
		self.Life = self.LifeUpgraded
	end

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) and ply:IsPlayer() and ply:HasPerk("time") then
		self.Life = self.Life * 1.5
	end

	self.Life = self.Life + math.Rand(-self.LifeRandom,self.LifeRandom)

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	local pos = self:GetPos()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.dlight = self.dlight or DynamicLight(self:EntIndex(), false)
		if self.dlight then
			self.dlight.pos = pos
			self.dlight.r = 255
			self.dlight.g = 60
			self.dlight.b = 0
			self.dlight.brightness = self:GetActivated() and 2 or 1
			self.dlight.Decay = 2000
			self.dlight.Size = self:GetActivated() and 380 or 128
			self.dlight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		local ply = self:GetOwner()

		if self.Impacted and not self:GetActivated() and (self.killtime - self.Life) + 1 < CurTime() then
			self:CustomActivate()
		end

		if self.killtime < CurTime() then
			self:Remove()
			return false
		end

		if self:GetActivated() then
			if nzombies then
				local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
				local health = tonumber(nzCurves.GenerateHealthCurve(round))
				local mydamage = health / self.HealthFraction

				for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
					if not v:IsValidZombie() then continue end
					if v.HellgatAttack and v.HellgatAttack[self:GetCreationID()] and v.HellgatAttack[self:GetCreationID()] > CurTime() then continue end

					local damage = DamageInfo()
					damage:SetDamage(mydamage)
					damage:SetAttacker(IsValid(ply) and ply or self)
					damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
					damage:SetDamageForce((v:GetPos() - self:GetPos()):GetNormalized())
					damage:SetDamagePosition(v:WorldSpaceCenter())
					damage:SetDamageType(DMG_BURN)

					if (v.NZBossType or v.IsMooBossZombie) then
						damage:SetDamage(math.max(600, v:GetMaxHealth() / 18))
					else
						v:BO1BurnSlow(2)
					end

					v:TakeDamageInfo(damage)

					if not (v.NZBossType or v.IsMooBossZombie) then
						v:Extinguish()
					end

					if not v.HellgatAttack then v.HellgatAttack = {} end
					v.HellgatAttack[self:GetCreationID()] = CurTime() + self.AttackDelay
				end
			else
				for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
					if v:IsNPC() or v:IsNextBot() or v:IsPlayer() or v:IsVehicle() then
						if v:IsOnFire() then continue end
						if v:Health() <= 0 then continue end

						v:Ignite(0.5)
					end
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:CustomActivate()
	local p = self:GetParent()
	if IsValid(p) then
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		//self:SetPos(p:GetPos())

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
			phys:Sleep(true)
		end

		self:SetParent(nil)
	end

	if self.fuckangle then
		self:SetAngles(self.fuckangle)
	end

	self:SetActivated(true)

	self:StopSound("TFA_BO2_HELLGAT.Proj.Charge")
	self:EmitSound("TFA_BO2_HELLGAT.Explo")
	self:EmitSound("TFA_BO2_HELLGAT.Proj.Explo")

	ParticleEffect("bo2_hellgat_explode", self:GetPos(), self.fuckangle and (self.fuckangle - Angle(90,0,0)) or angle_zero)
	ParticleEffectAttach("bo2_hellgat_loop", PATTACH_POINT_FOLLOW, self, 1)

	self:Explode()

	if !self.Burn then
		self:Remove()
	else
		self:EmitSound("TFA_BO2_HELLGAT.Proj.Loop")
	end
end

function ENT:Explode()
	self.Damage = self.mydamage or self.Damage

	local ply = self:GetOwner()
	local p = self:GetParent() or self

	local tr = {
		start = self:GetPos(),
		filter = {self, p, ply},
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.BlastRange)) do
		if v:IsSolid() and not v:IsWorld() then
			if v == self then continue end
			if nzombies and v:IsPlayer() and v ~= ply then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			local damage = DamageInfo()
			damage:SetDamage(self.Damage)
			damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
			damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
			damage:SetDamageForce(v:GetUp()*math.random(8000,9000) + tr1.Normal*math.random(9000,12000))
			damage:SetDamagePosition(tr1.Entity == v and tr1.HitPos or tr.endpos)
			damage:SetDamageType(nzombies and DMG_BURN or bit.bor(DMG_BURN, DMG_SLOWBURN))

			if nzombies and v:IsValidZombie() then
				if (v.NZBossType or v.IsMooBossZombie) then
					damage:SetDamage(math.max(self.Damage, v:GetMaxHealth() / 12))
				else
					v:BO1BurnSlow(4)
				end

				if not v.HellgatAttack then v.HellgatAttack = {} end
				v.HellgatAttack[self:GetCreationID()] = CurTime() + self.AttackDelay
			end

			if v == ply then
				local dist = self:GetPos():Distance(v:GetPos())
				dist = 1 - math.Clamp(dist/self.Range, 0, 1)
				damage:SetDamage(50 * dist)
			end

			if v:IsNPC() then v:SetSchedule(SCHED_ALERT_STAND) end
			v:TakeDamageInfo(damage)

			if nzombies and v:IsValidZombie() then
				v:Extinguish()
			end

			if v:IsNPC() or v:IsNextBot() or v:IsPlayer() then
				table.insert(tr.filter, v)
			end
		end
	end

	util.ScreenShake(self:GetPos(), 4, 255, 1, self.BlastRange*2)
end

function ENT:OnRemove()
	self:StopParticles()

	self:StopSound("TFA_BO2_HELLGAT.Proj.Loop")
	self:StopSound("TFA_BO2_HELLGAT.Proj.Charge")
	self:EmitSound("TFA_BO2_HELLGAT.Proj.End")
end
