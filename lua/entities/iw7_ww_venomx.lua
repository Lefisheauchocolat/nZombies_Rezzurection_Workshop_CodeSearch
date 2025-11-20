AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Biolum-Pod"

--[Parameters]--
ENT.Delay = 1.2
ENT.Range = 200
ENT.Impacted = false

ENT.BounceSoundWood = Sound("TFA_IW7_VENOMX.Bounce.Wood")
ENT.BounceSoundMetal = Sound("TFA_IW7_VENOMX.Bounce.Stone")
ENT.BounceSoundEarth = Sound("TFA_IW7_VENOMX.Bounce.Earth")

DEFINE_BASECLASS(ENT.Base)

local MAT_WOOD = {
	[18] = true,
	[17] = true,
	[14] = true,
	[20] = true,
	[87] = true,
}
local MAT_EARTH = {
	[85] = true,
	[79] = true,
	[67] = true,
	[12] = true,
	[54] = true,
	[0] = true,
}

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		local impulse = (data.OurOldVelocity - 2 * data.OurOldVelocity:Dot(data.HitNormal) * data.HitNormal) * 0.25
		phys:ApplyForceCenter(impulse)

		local surf = data.TheirSurfaceProps
		if (MAT_WOOD[surf]) then
			self:EmitSound(self.BounceSoundWood)
		elseif (MAT_EARTH[surf]) then
			self:EmitSound(self.BounceSoundEarth)
		else
			self:EmitSound(self.BounceSoundMetal)
		end

		sound.EmitHint(SOUND_DANGER, data.HitPos, 200, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:SetRenderMode(RENDERMODE_GLOW)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("iw7_venomx_trail_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(200, 150, 50, 255)
	else
		ParticleEffectAttach("iw7_venomx_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(200, 255, 0, 255)
	end

	self.killtime = CurTime() + self.Delay
	self.RangeSqr = self.Range*self.Range

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:Explode()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:DoExplosionEffect()
	self:EmitSound("TFA_IW7_VENOMX.Explode")

	if self:GetUpgraded() then
		ParticleEffect("iw7_venomx_explode_2", self:GetPos(), Angle(0,0,0))
	else
		ParticleEffect("iw7_venomx_explode", self:GetPos(), Angle(0,0,0))
	end
end

function ENT:Explode()
	self.Damage = nzombies and self.mydamage or 100
	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_RADIATION))

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if nzombies and (v:IsPlayer() and v ~= self:GetOwner()) then continue end
			if v:Health() <= 0 then continue end

			local distfac = self:GetPos():DistToSqr(v:GetPos())
			distfac = 1 - math.Clamp(distfac/self.RangeSqr, 0.1, 1)

			damage:SetDamage(self.Damage * distfac)
			damage:SetDamageForce(v:GetUp()*12000 + (v:GetPos() - self:GetPos()):GetNormalized() * 12000)
			damage:SetDamagePosition(v:WorldSpaceCenter())

			v:TakeDamageInfo(damage)
		end
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, self.Range*2)

	self:SpawnGasCloud()
	self:DoExplosionEffect()
	self:Remove()
end

function ENT:SpawnGasCloud()
	self.Damage = self.mydamage or self.Damage

	local gas = ents.Create("iw7_ww_venomx_gas")
	gas:SetModel("models/hunter/misc/sphere025x025.mdl")
	gas:SetPos(self:GetPos())
	gas:SetAngles(Angle(0,0,0))

	gas.Damage = nzombies and (self.Damage / 10) or self.Damage
	gas:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	gas.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self
	gas:SetUpgraded(self:GetUpgraded())

	gas:Spawn()
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 500
			dlight.DieTime = CurTime() + 0.2
		end
	end
end
