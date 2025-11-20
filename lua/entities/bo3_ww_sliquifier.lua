AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Soap"

--[Parameters]--
ENT.Delay = 2
ENT.Range = 120
ENT.RangePaP = 120
ENT.MaxInfects = 4
ENT.MaxInfectsPaP = 6

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
end

function ENT:PhysicsCollide(data,phys)
	local ent = data.HitEntity
	if self.Impacted then return end
	self:StopParticles()

	self:EmitSound("TFA_BO3_SLIPGUN.Impact")
	self:Explode(data.HitPos)

	if data.HitNormal:Dot(Vector(0,0,-1))>0.9 then
		self:CreateSlipPlate(data.HitPos, Angle(0,0,0))
		self:EmitSound("TFA_BO3_SLIPGUN.Splash")
	end

	ParticleEffect(self:GetUpgraded() and "bo3_sliquifier_impact_2" or "bo3_sliquifier_impact", self:GetPos(), Angle(0,0,0))
	//util.Decal(self:GetUpgraded() and "goo_splat_2" or "goo_splat", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)

	self.Impacted = true
	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		self:StopParticles()

		local data = self:GetTouchTrace()
		self:Explode(data.HitPos)
		self:InflictDamage(ent, data.HitPos, self:GetForward())

		if ent:IsOnGround() then
			self:CreateSlipPlate(ent:GetPos(), Angle(0,0,0))
		end

		self.Impacted = true
		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 6)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_sliquifier_trail_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.Range = self.RangePaP
		self.MaxInfects = self.MaxInfectsPaP
	else
		ParticleEffectAttach("bo3_sliquifier_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end

	self.killtime = CurTime() + self.Delay
	self.Infects = 0

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			ParticleEffect(self:GetUpgraded() and "bo3_sliquifier_impact_2" or "bo3_sliquifier_impact", self:GetPos(), Angle(0,0,0))
			self:Explode(self:GetPos())
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos, norm)
	ent:EmitSound("TFA_BO3_SLIPGUN.Explode")
	ParticleEffect(self:GetUpgraded() and "bo3_sliquifier_impact_2" or "bo3_sliquifier_impact", hitpos or self:GetPos(), -norm:Angle())

	local damage = DamageInfo()
	damage:SetDamage(nzombies and ent:Health() + 666 or self.mydamage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(norm or vector_up)
	damage:SetDamagePosition(hitpos or ent:EyePos())
	damage:SetDamageType(DMG_REMOVENORAGDOLL)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max(1000, ent:GetMaxHealth() / 12))
	end

	ent:TakeDamageInfo(damage)
end

function ENT:CreateSlipPlate(pos, ang) //this is absolutely foul, but its to avoid annoying console spam
	timer.Simple(0, function()
		if not IsValid(self) then return end
		local plate = ents.Create("bo3_ww_sliquifier_goo")
		plate:SetModel("models/dav0r/hoverball.mdl")
		plate:SetOwner(self:GetOwner())
		plate:SetPos(pos + vector_up)
		plate:SetAngles(ang)
		plate:SetUpgraded(self:GetUpgraded())

		plate:Spawn()
		plate:SetOwner(self:GetOwner())
		plate.Inflictor = self.Inflictor
	end)
end

function ENT:Explode(pos)
	util.ScreenShake(pos, 4, 255, 0.8, 200)

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
			if self.Infects >= self.MaxInfects then break end
			if v == ply then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			if not v:BO3IsSoaped() then
				v:BO3Soap(1, self:GetOwner(), self.Inflictor, self:GetUpgraded())
				self.Infects = self.Infects + 1
			end
		end
	end
end
