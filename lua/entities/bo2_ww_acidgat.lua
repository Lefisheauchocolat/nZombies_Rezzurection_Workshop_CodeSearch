AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Flechette"

--[Parameters]--
ENT.Delay = 10
ENT.Life = 3
ENT.Range = 140

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	timer.Simple(0.4, function()
		if not IsValid(self) then return end
		if self.SmokeTrail and IsValid(self.SmokeTrail) then
			self.SmokeTrail:Remove()
		end
	end)

	local ang = self:GetAngles()
	local ent = data.HitEntity

	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetAngles(ang)
		self:SetPos(data.HitPos)
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		if IsValid(ent) and not ent:IsWorld() and IsValid(ent:GetPhysicsObject()) then
			self:SetParent(ent)
		end
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	if self:GetUpgraded() and nzombies and SERVER then
		self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
		//UpdateAllZombieTargets(self)
	end

	self.hitdata = data
	ParticleEffect("bo4_acidgat_impact", data.HitPos, Angle(0,0,0))
	self.killtime = CurTime() + (self.Life - math.Rand(0,1))
	self:EmitSound("TFA_BO2_ACIDGAT.Proj.Fuse")
end

function ENT:StartTouch(ent)
	local ply = self:GetOwner()
	if ent == ply then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end
	if self:GetActivated() then return end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		self:SetParent(ent)
		ent:SetNW2Bool("OnAcid", true)
		if not ent:IsPlayer() and ent.Freeze and not ent.NZBossType then
			ent:Freeze(3)
		end

		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		if SERVER and nzombies and self:GetUpgraded() then
			self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
			//UpdateAllZombieTargets(self)
		end

		ParticleEffect("bo4_acidgat_impact", self:GetPos(), Angle(0,0,0))
		self.killtime = CurTime() + math.Rand(2,3)
		self:EmitSound("TFA_BO2_ACIDGAT.Proj.Fuse")

		self:SetActivated(true)

		timer.Simple(0.4, function()
			if not IsValid(self) then return end
			if self.SmokeTrail and IsValid(self.SmokeTrail) then
				self.SmokeTrail:Remove()
			end
		end)

		if nzombies and IsValid(ply) and ent:IsValidZombie() then
			ply:GivePoints(10)
		end
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 4)
	self:EmitSound("TFA_BO2_ACIDGAT.Proj.Fweep")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self.killtime = CurTime() + self.Delay

	self:NextThink(CurTime())

	if CLIENT then return end
	local num = math.random(180,200)
	self.SmokeTrail = util.SpriteTrail(self, 1, Color(num,num,num, 60), true, 6, 1, 0.4, 0.1, "trails/smoke")
	self:SetTrigger(true)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight and self:GetActivated() then
			dlight.pos = self:GetAttachment(1).Pos
			dlight.r = 50
			dlight.g = 255
			dlight.b = 50
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 64
			dlight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		if not nzombies and self:GetActivated() then
			self:MonkeyBomb()
			self:MonkeyBombNXB()
		end

		if self.killtime <= CurTime() then
			self:Explode()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:MonkeyBomb()
	if CLIENT then return end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 1024)) do
		if v == self:GetOwner() then continue end
		if IsValid(v) and v:IsNPC() then
			if v:GetEnemy() ~= self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())

				v:SetEnemy(self)
			end

			v:UpdateEnemyMemory(self, self:GetPos())
			v:SetSaveValue("m_vecLastPosition", self:GetPos())
			v:SetSchedule(SCHED_FORCED_GO_RUN)
		end
	end
end

function ENT:MonkeyBombNXB()
	if CLIENT then return end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 1024)) do
		if v == self:GetOwner() then continue end
		if IsValid(v) and v:IsNextBot() then
			v.loco:FaceTowards(self:GetPos())
			v.loco:Approach(self:GetPos(), 99)
			if v.SetEnemy then
				v:SetEnemy(self)
			end
		end
	end
end

function ENT:DoExplosionEffect()
	self:EmitSound("TFA_BO2_ACIDGAT.Proj.Explo")
	self:EmitSound("TFA_BO2_ACIDGAT.Proj.Sweet")

	if self.hitdata then
		ParticleEffect("bo4_acidgat_explode", self:GetPos(), self.hitdata.HitNormal:Angle() - Angle(90,0,0))
	else
		ParticleEffect("bo4_acidgat_explode", self:GetPos(), Angle(0,0,0))
	end
end

function ENT:Explode()
	self.Damage = self.mydamage or self.Damage

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			local damage = DamageInfo()
			damage:SetDamage(self.Damage)
			damage:SetAttacker(IsValid(ply) and ply or self)
			damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
			damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 8000)
			damage:SetDamagePosition(v:WorldSpaceCenter())
			damage:SetDamageType(DMG_RADIATION)

			if v:IsPlayer() then
				local dist = self:GetPos():Distance(v:GetPos())
				dist = 1 - math.Clamp(dist/self.Range, 0, 1)
				damage:SetDamage(50 * dist)
			end

			if nzombies and (v.NZBossType or string.find(v:GetClass(), "zombie_boss")) then
				damage:SetDamage(math.max(self.Damage, v:GetMaxHealth() / 16))
				//damage:ScaleDamage(math.min(math.Round(nzRound:GetNumber()/8), 1))
			end

			v:TakeDamageInfo(damage)
		end
	end

	util.ScreenShake(self:GetPos(), 8, 255, 1, self.Range * 2.5)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnRemove()
	self:StopSound("TFA_BO2_ACIDGAT.Proj.Fweep")
	self:StopSound("TFA_BO2_ACIDGAT.Proj.Fuse")

	local p = self:GetParent()
	if IsValid(p) and p:GetNW2Bool("OnAcid") then
		p:SetNW2Bool("OnAcid", false)
	end
end
