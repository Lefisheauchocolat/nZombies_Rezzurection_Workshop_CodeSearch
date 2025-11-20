AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Transfur"

--[Parameters]--
ENT.Delay = 8
ENT.Impacted = false

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
end

function ENT:PhysicsCollide(data)
	if self.Impacted then return end
	self.Impacted = true

	ParticleEffect(self:GetUpgraded() and "bo3_vr11_impact_2" or "bo3_vr11_impact", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	util.ScreenShake(data.HitPos, 255, 5, 0.5, 200)
	self:EmitSound("TFA_BO3_VR11.Impact")

	local ply = self:GetOwner()
	if data.HitPos:DistToSqr(ply:GetPos()) < 576 then //24^2
		ply:BO3Vril(self.BuffTime, self:GetUpgraded())
	end

	self:Remove()
end

function ENT:StartTouch(ent)
	local ply = self:GetOwner()
	if ent == ply then return end
	if self.Impacted then return end

	if ent:IsPlayer() then
		self.Impacted = true

		ent:BO3Vril(self.BuffTime, self:GetUpgraded(), ply)

		ParticleEffect(self:GetUpgraded() and "bo3_vr11_hitzomb_2" or "bo3_vr11_hitzomb", self:GetPos(), Angle(0,0,0))
		util.ScreenShake(self:GetPos(), 255, 5, 0.5, 200)
		self:EmitSound("TFA_BO3_VR11.Impact")

		self:Remove()
		return
	end

	if ent:IsNPC() or ent:IsNextBot() then
		self.Impacted = true

		if ent.DirectorCalm and ent.Enraged then
			ent:DirectorCalm()
		end

		self:InflictDamage(ent)
		self:SpawnCIA(ent)

		if ent:GetClass() ~= "nextbot_bo3_vrill_human" then
			ParticleEffect(self:GetUpgraded() and "bo3_vr11_hitzomb_2" or "bo3_vr11_hitzomb", self:GetPos(), Angle(0,0,0))
		end
		util.ScreenShake(self:GetPos(), 255, 5, 0.5, 200)
		self:EmitSound("TFA_BO3_VR11.Impact")

		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	self.killtime = CurTime() + self.Delay
	self.Damage = self.mydamage or self.Damage

	if self:GetUpgraded() then
		self.BuffTime = 10
		ParticleEffectAttach("bo3_vr11_trail_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	else
		self.BuffTime = 5
		ParticleEffectAttach("bo3_vr11_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			SafeRemoveEntity(self)
			return false
		end

		if self:WaterLevel() > 0 then
			SafeRemoveEntity(self)
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:SpawnCIA(ent)
	if ent.DirectorCalm then return end
	if ent:GetClass() == "nextbot_bo3_vrill_human" then return end
	if ent:IsNPC() and ent:GetHullType() ~= HULL_HUMAN then return end
	if (ent.NZBossType or ent.IsMooBossZombie) then return end

	local ply = self:GetOwner()
	local human = ents.Create("nextbot_bo3_vrill_human")
	human:SetPos(ent:GetPos())
	human:SetAngles(ent:GetAngles())

	human:SetOwner(IsValid(ply) and ply or self)
	human:SetAttacker(IsValid(ply) and ply or self)
	human:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	human:SetUpgraded(self:GetUpgraded())

	human:Spawn()

	if engine.ActiveGamemode() == "sandbox" then
		cleanup.Add(ply, "NPC", human)

		undo.Create("Human")
		undo.AddEntity(human)
		undo.SetPlayer(ply)
		undo.Finish()
	end
end

function ENT:InflictDamage(ent)
	if ent.DirectorCalm then return end

	local ply = self:GetOwner()
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_REMOVENORAGDOLL)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:EyePos())

	if ent.NZBossType then
		damage:SetDamage(math.max(2000, ent:GetMaxHealth() / 10))
	else
		ent:SetHealth(1)
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)

	if (ent.NZBossType or ent.IsMooBossZombie) then return end
	ent:Remove()

	if ent:GetClass() == "nextbot_bo3_vrill_human" then
		if IsValid(ply) and ply:IsPlayer() and not ply.bo1vrillachievment then
			TFA.BO3GiveAchievement("Stuntman", "vgui/overlay/achievment/Stuntman_BO.png", ply)
			ply.bo1vrillachievment = true
		end
	end
end
