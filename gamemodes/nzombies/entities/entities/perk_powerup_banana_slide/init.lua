AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/hunter/plates/plate1x1.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:DrawShadow(false)
	self:SetTrigger(true)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self.killtime = CurTime() + (self:GetUpgraded() and self.DelayUpg or self.Delay)

	if self:WaterLevel() > 1 then
		SafeRemoveEntity(self)
		return
	end

	self:SetTrigger(true)
end

function ENT:Think()
	if self.killtime < CurTime() then
		self:StopParticles()
		SafeRemoveEntity(self)
		return false
	end

	if self:GetUpgraded() and !self.nextattack then
		self.nextattack = CurTime()
	end

	if self.nextattack and self.nextattack < CurTime() then
		self.nextattack = CurTime() + 0.1

		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
		local health = tonumber(nzCurves.GenerateHealthCurve(round))

		local damage = DamageInfo()
		damage:SetInflictor(self)
		damage:SetDamageType(DMG_RADIATION)
		damage:SetDamage(10)
		damage:SetDamageForce(vector_up*-1)

		for k, v in pairs(ents.FindInSphere(self:GetPos(), 32)) do
			if v:IsValidZombie() then
				damage:SetAttacker(v)
				damage:SetDamagePosition(v:WorldSpaceCenter())
				if v.NZBossType or v.IsMooBossZombie or v.IsMooMiniBoss then
					damage:SetDamage(math.max(v:GetMaxHealth()/12, 1200))
				end

				v:TakeDamageInfo(damage)
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() then
		ent.NZBananaSlip = self
		ent:SetFriction(0.2)
		return
	end

	if not (ent:IsNPC() or ent:IsNextBot()) then return end
	if ent == self:GetOwner() then return end
	if ent:IsValidZombie() and ent:GetSpecialAnimation() then return end

	local funny = math.random(200) == 1
	if funny then
		ent:EmitSound("nz_moo/effects/banana/banana_slip.wav", SNDLVL_TALKING, math.random(97,103))
	else
		ent:EmitSound("nz_moo/effects/banana/fall_0"..math.random(0.2)..".wav", SNDLVL_NORM, math.random(97,103))
	end

	local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
	local health = tonumber(nzCurves.GenerateHealthCurve(round))

	local damage = DamageInfo()
	damage:SetDamageType(funny and DMG_MISSILEDEFENSE or DMG_RADIATION)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(self)
	damage:SetDamage(funny and ent:Health() + 666 or math.max(health/4, 25))
	damage:SetDamageForce(funny and ent:GetForward()*28000 or self:GetUp())
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)

	if ent:IsValidZombie() and ent.SlipGunSequences and ent:Health() > 0 and ent.Alive then
		ent:DoSpecialAnimation(ent.SlipGunSequences[math.random(#ent.SlipGunSequences)])
	end
end

function ENT:EndTouch(ent)
	if ent:IsPlayer() and ent.NZBananaSlip and IsValid(ent.NZBananaSlip) and ent.NZBananaSlip == self then
		ent:SetFriction(1)
	end
end

function ENT:OnRemove()
	self:StopParticles()

	for _, ply in ipairs(player.GetAll()) do
		if ply.NZBananaSlip and IsValid(ply.NZBananaSlip) and ply.NZBananaSlip == self then
			ply:SetFriction(1)
		end
	end
end
