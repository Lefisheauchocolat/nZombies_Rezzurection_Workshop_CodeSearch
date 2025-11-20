AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Spikemore"

--[Sounds]--
ENT.BounceSound = "TFA_BO1_SPIKEMORE.Plant"

--[Parameters]--
ENT.Exploded = false

ENT.Range = 400
ENT.DetectRange = 80

ENT.HP = 55
ENT.RPM = 1200
ENT.NumShots = 8

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Impacted")
end

function ENT:PhysicsCollide(data, phys)
	self:EmitSound(self.BounceSound)
	phys:EnableMotion(false)
	phys:Sleep()

	self:SetImpacted(true)
	sound.EmitHint(SOUND_COMBAT, self:GetPos(), 500, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)

	local ang = self:GetAngles()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:SetAngles(self.DesiredAng or ang)
	end)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	//self:PhysicsInitSphere(0.1, "metal_bouncy")
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)

	self.Shots = 0
	self.NextAttack = 0

	self:NextThink(CurTime())

	if CLIENT then return end
	self:OverflowCheck()
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

local max_bbettys = GetConVar("sv_tfa_miscww_max_placeables")
function ENT:OverflowCheck()
	local ply = self:GetOwner()
	if not ply.activespikemors then ply.activespikemors = {} end
	table.insert(ply.activespikemors, self)

	if #ply.activespikemors > max_bbettys:GetInt() then
		for k, v in pairs(ply.activespikemors) do
			if not IsValid(v) then continue end
			if v == self then continue end
			v:Trigger()
			break
		end
	end
end

function ENT:Think()
	if SERVER and self:GetImpacted() then
		local ply = self:GetOwner()
		local angle = math.cos(math.rad(35))

		if !self.Triggered then
			for k, v in pairs(ents.FindInCone(self:GetAttachment(1).Pos, self:GetForward(), self.DetectRange, angle)) do
				if v == ply then continue end
				if v:Health() <= 0 then continue end
				if v:IsPlayer() and IsValid(ply) and v ~= ply and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
				if v:IsPlayer() and self:FriendCheck(v) then continue end

				self:Trigger()
			end
		else
			if self.Exploded and self.NextAttack < CurTime() then
				local dofire = true
				for k, v in RandomPairs(ents.FindInCone(self:GetAttachment(1).Pos, self:GetForward(), self.Range, angle)) do
					if v == ply then continue end
					if v:Health() <= 0 then continue end
					if v:IsPlayer() and IsValid(ply) and v ~= ply and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
					if v:IsPlayer() and self:FriendCheck(v) then continue end

					self:FireSpike(v)
					dofire = false
					break
				end

				if dofire then
					self:FireSpike()
				end

				self.NextAttack = CurTime() + (60/self.RPM)
				self.Shots = self.Shots + 1

				if self.Shots >= self.NumShots then
					self:Remove()
					return false
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:FriendCheck(ent)
	local ply = self:GetOwner()
	if DLib and ent:IsPlayer() and IsValid(ply) and ply:IsPlayer() and ply:IsDLibFriend(ent) then
		return true 
	end
	return false
end

function ENT:Use(ply, caller)
	if CLIENT then return end
	if IsValid(ply) and ply == self:GetOwner() then
		ply:Give("tfa_bo1_spikemore", true)
		ply:GiveAmmo(1, "slam", false)
		self:Remove()
	end
end

function ENT:OnTakeDamage(dmg)
	if dmg:GetInflictor() == self or dmg:GetAttacker() == self then return end
	if self.Exploded then return end
	if dmg:IsExplosionDamage() then dmg:SetMaxDamage(math.Rand(10,20)) end
	if self.HP > 0 and self.HP - dmg:GetMaxDamage() <= 0 then
		self.Triggered = true
		self:Explode()
		self.Exploded = true
	end
	self.HP = self.HP - dmg:GetMaxDamage()
	dmg:SetAttacker(self)
	dmg:SetInflictor(self)
end

function ENT:Trigger()
	if self.Triggered then return end
	self.Triggered = true

	self:EmitSound("TFA_BO1_SPIKEMORE.Alert")
	timer.Simple(0.5, function()
		if not IsValid(self) then return end
		self:Explode()
	end)
end

function ENT:FireSpike(ent)
	local pos = self:GetAttachment(1).Pos
	local dir = self:GetForward() + self:GetUp()*math.Rand(0,0.4)
	if IsValid(ent) then
		dir = (ent:EyePos() - ent:OBBCenter()*math.Rand(0.2,0.6)) - (pos + self:GetUp()*math.Rand(0,0.4))
	end

	local bulletinfo = {
		Attacker = IsValid(self:GetOwner()) and self:GetOwner() or self,
		Callback = function(attacker, trace, dmginfo)
			if CLIENT then return end
			if self.Inflictor and IsValid(self.Inflictor) then
				dmginfo:SetInflictor(self.Inflictor)
			end

			if DLib then
				DLib.debugoverlay.Sphere(trace.HitPos, 5, 5, Color(255, 0, 0, 255), true)
			end

			local tent = trace.Entity
			if IsValid(tent) and tent:IsWorld() then
				/*if not  then
					local spike = ents.Create("bo1_spikemore_spike")
					spike:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")
					spike:SetOwner(tent)
					spike:SetBoneTarget(trace.PhysicsBone)

					spike:Spawn()

					spike:EmitSound("TFA_BO1_SPIKEMORE.Hit")
				else*/
					local spike = ents.Create("bo1_spikemore_spike_world")
					spike:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")
					spike:SetPos(trace.HitPos - trace.Normal*math.Rand(2,9))
					spike:SetAngles(trace.Normal:Angle())

					spike:Spawn()

					spike:EmitSound("TFA_BO1_SPIKEMORE.Hit")
				//end
			elseif trace.HitWorld then
				local spike = ents.Create("bo1_spikemore_spike_world")
				spike:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")
				spike:SetPos(trace.HitPos - trace.Normal*math.Rand(2,9))
				spike:SetAngles(trace.Normal:Angle())

				spike:Spawn()

				spike:EmitSound("TFA_BO1_SPIKEMORE.Hit")
			end
		end,
		Damage = self.Damage,
		Force = 80,
		Tracer = 0,
		TracerName = "none",
		Src = pos,
		Dir = dir,
		Distance = self.Range*2,
		Spread = IsValid(ent) and Vector(1,1,1) or Vector(0.2, 0.2, 0.2),
		IgnoreEntity = self,
	}

	self:FireBullets(bulletinfo)

	util.ScreenShake(self:GetPos(), 4, 5, 1, self.Range)
end

function ENT:DoExplosionEffect()
	local tr = util.QuickTrace(self:GetPos(), Vector(0,0,-64), self)
	util.Decal("Scorch", tr.HitPos - tr.HitNormal, tr.HitPos + tr.HitNormal)

	local fx = EffectData()
	fx:SetOrigin(self:GetPos())
	util.Effect("HelicopterMegaBomb", fx)

	self:EmitSound("TFA_BO1_SPIKEMORE.Blast")
	self:EmitSound("TFA_BO1_SPIKEMORE.Flux")

	ParticleEffect("bo1_spikemore_explode", self:GetAttachment(1).Pos, self:GetForward():Angle())
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	self.Damage = self.mydamage or self.Damage
	self.NextAttack = CurTime()

	self:DoExplosionEffect()
	SafeRemoveEntityDelayed(self, 8) //better safe than sorry
end

function ENT:OnRemove()
	if SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) and ply.activespikemors and table.HasValue(ply.activespikemors, self) then
			table.RemoveByValue(ply.activespikemors, self)
		end
	end
end