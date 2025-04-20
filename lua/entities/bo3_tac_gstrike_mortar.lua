
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile()

ENT.Base = "tfa_exp_base"
ENT.PrintName = "Mortar"

ENT.Delay = 3
ENT.Range = 200

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:SetupDataTables()
	self:NetworkVar( "Vector", 0, "LandingSpot")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:Explode()
	util.Decal("Scorch", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)

	self:Remove()
end

function ENT:CreateRocketTrail()
	if not SERVER then return end

	local rockettrail = ents.Create("env_rockettrail")
	rockettrail:DeleteOnRemove(self)

	rockettrail:SetPos(self:GetPos() - self:GetForward()*12)
	rockettrail:SetAngles(self:GetAngles())
	rockettrail:SetParent(self)
	rockettrail:SetMoveType(MOVETYPE_NONE)
	rockettrail:AddSolidFlags(FSOLID_NOT_SOLID)

	rockettrail:SetSaveValue("m_Opacity", 0.2)
	rockettrail:SetSaveValue("m_SpawnRate", 200)
	rockettrail:SetSaveValue("m_ParticleLifetime", 1)
	rockettrail:SetSaveValue("m_StartColor", Vector(0.1, 0.1, 0.1))
	rockettrail:SetSaveValue("m_EndColor", Vector(1, 1, 1))
	rockettrail:SetSaveValue("m_StartSize", 12)
	rockettrail:SetSaveValue("m_EndSize", 32)
	rockettrail:SetSaveValue("m_SpawnRadius", 4)
	rockettrail:SetSaveValue("m_MinSpeed", 16)
	rockettrail:SetSaveValue("m_MaxSpeed", 32)
	rockettrail:SetSaveValue("m_nAttachment", 1)
	rockettrail:SetSaveValue("m_flDeathTime", CurTime() + self.Delay)

	rockettrail:Activate()
	rockettrail:Spawn()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:EmitSoundNet("TFA_BO3_GSTRIKE.Launch")
	self:EmitSoundNet("TFA_BO3_GSTRIKE.Incoming")
	self:CreateRocketTrail()

	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self.killtime = CurTime() + self.Delay
end

function ENT:Think()
	if SERVER then
		if self:GetLandingSpot() then
			if self:GetPos():DistToSqr(self:GetLandingSpot()) <= 32^2 then
				self:SetSolid(SOLID_VPHYSICS)
				self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			end
		end

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
	ParticleEffect("doi_mortar_explosion", self:GetPos(), Angle(-90,0,0))

	self:EmitSound("TFA_BO3_GSTRIKE.Exp")
	self:EmitSound("TFA_BO3_GSTRIKE.Exp.Debris")
	self:EmitSound("TFA_BO3_GRENADE.ExpClose")
	self:EmitSound("TFA_BO3_GRENADE.Flux")
end

function ENT:Explode()
	self:StopSound("TFA_BO3_GSTRIKE.Incoming")

	self.Damage = self.mydamage or self.Damage

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if nzombies and v:IsPlayer() then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			local damage = DamageInfo()
			damage:SetDamage(self.Damage)
			damage:SetAttacker(IsValid(ply) and ply or self)
			damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
			damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
			damage:SetDamagePosition(v:WorldSpaceCenter())

			if v:IsPlayer() then
				local distfac = self:GetPos():Distance(v:GetPos())
				distfac = 1 - math.Clamp(distfac/250, 0, 1)
				damage:SetDamage(200*distfac)
			end

			if nzombies and v.NZBossType then
				damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
			end

			damage:SetDamageForce(v:GetUp()*15000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)

			v:TakeDamageInfo(damage)
		end
	end

	util.ScreenShake(self:GetLandingSpot(), 15, 255, 1.5, 512)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnRemove()
	self:StopSound("TFA_BO3_GSTRIKE.Incoming")
end
