AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Party Flechette"

--[Parameters]--
ENT.Delay = 10
ENT.Life = 2
ENT.Range = 160

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

	ParticleEffect("bo2_blunderhoff_impact", data.HitPos, Angle(0,0,0))

	self.hitdata = data
	self.killtime = CurTime() + (self.Life - math.Rand(0,0.8))
	self.hitwall = data.HitNormal:Dot(Vector(0,0,-1)) < 0.9 
end

function ENT:StartTouch(ent)
	local ply = self:GetOwner()
	if ent == ply then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end
	if self:GetActivated() then return end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		self:SetParent(ent)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

		ParticleEffect("bo2_blunderhoff_impact", self:GetTouchTrace().HitPos, Angle(0,0,0))

		/*if nzombies and ent.TempBehaveThread and ent.DanceSequences then
			ent:TempBehaveThread(function(ent)
				local seq = ent.DanceSequences[math.random(#ent.DanceSequences)]
				ent:SetSpecialAnimation(true)
				ent:PlaySequenceAndWait(seq)
			end)
		end*/

		self.killtime = CurTime() + (self.Life - math.Rand(0,0.8))
		self.hitwall = true
		self:SetActivated(true)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 1)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self.RangeSqr = self.Range * self.Range
	self.killtime = CurTime() + self.Delay
	self:EmitSound("TFA_BO2_ACIDGAT.Proj.Fuse")

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	local pos = self:GetPos()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = pos
			dlight.r = 240
			dlight.g = 15
			dlight.b = 255
			dlight.brightness = 0.5
			dlight.Decay = 2000
			dlight.Size = 64
			dlight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		local ply = self:GetOwner()

		if self.killtime <= CurTime() then
			self:StopSound("TFA_BO2_ACIDGAT.Proj.Fuse")
			self:Remove()
			return false
		end

		if self:GetActivated() then
			local p = self:GetParent()
			if IsValid(p) and (p:IsNPC() or p:IsPlayer() or p:IsNextBot()) and p:Health() <= 0 then
				self:StopSound("TFA_BO2_ACIDGAT.Proj.Fuse")
				self:Remove()
				return false
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:DoExplosionEffect()
	self:EmitSound("TFA_BO2_BLUNDERHOFF.Explo")

	if self.hitwall then
		if self.hitdata then
			ParticleEffect("bo2_blunderhoff_explode", self:GetPos(), self.hitdata.HitNormal:Angle() - Angle(90,0,0))
		else
			ParticleEffect("bo2_blunderhoff_explode", self:GetPos(), self:GetAngles() - Angle(90,0,0))
		end
	else
		ParticleEffect("bo2_blunderhoff_explode_floor", self:GetPos(), Angle(0,0,0))
	end
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	self.Damage = self.mydamage or self.Damage

	local ply = self:GetOwner()
	local p = self:GetParent() or self

	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsNPC() or v:IsNextBot() or (not nzombies and v:IsPlayer()) then
			if v == ply then continue end
			if v:Health() <= 0 and v ~= p then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:BO2IsHoffDancing() then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end
			local hitpos = tr1.Entity == v and tr1.HitPos or v:EyePos()

			self:InflictDamage(v, hitpos)
		end
	end

	util.ScreenShake(self:GetPos(), 4, 4, 0.8, self.Range*2)
	self:DoExplosionEffect()
end

function ENT:InflictDamage(ent, hitpos)
	local ply = IsValid(self:GetOwner()) and self:GetOwner() or self
	local wep = IsValid(self.Inflictor) and self.Inflictor or self

	local dist = self:GetPos():DistToSqr(hitpos or ent:WorldSpaceCenter())
	local distfac = 1 - math.Clamp(dist/self.RangeSqr, 0, 0.5)

	local damage = DamageInfo()
	damage:SetDamage(self.Damage*distfac)
	damage:SetAttacker(ply)
	damage:SetInflictor(wep)
	damage:SetDamageForce((ent:GetPos() - self:GetPos()):GetNormalized())
	damage:SetDamagePosition(hitpos or ent:EyePos())
	damage:SetDamageType(DMG_BLAST_SURFACE)

	if nzombies and (ent.NZBossType or ent.IsMooZombieBoss or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(400, ent:GetMaxHealth() / 18))
	end

	if (damage:GetDamage() > ent:Health()) or (nzombies and nzPowerUps:IsPowerupActive("insta")) then
		if nzombies and ent:IsValidZombie() and (!ent.IsMooSpecial or (ent.IsMooSpecial and !ent.MooSpecialZombie)) and !ent.NZBossType and !ent.IsMooZombieBoss and !string.find(ent:GetClass(), "zombie_boss") then
			ent:SetNW2Bool("NZNoRagdoll", true)
			ent:SetHealth(1)

			ent:BO2HoffDance(1, ply, wep)
			return
		end

		if ent:IsNPC() then
			damage:SetDamageType(DMG_REMOVENORAGDOLL)
			damage:SetDamagePosition(ent:EyePos())
			ent:SetSchedule(SCHED_ALERT_STAND)
			ent:SetHealth(1)
		end

		ent:EmitSound("TFA_BO2_ACIDGAT.Proj.Explo")
		ParticleEffect("bo2_blunderhoff_infect", ent:GetPos(), Angle(0,0,0))
	end

	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	if SERVER then
		self:Explode()
	end
	self:StopSound("TFA_BO2_ACIDGAT.Proj.Fuse")
end
