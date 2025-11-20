
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

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Interdimensional Portal"

ENT.LoopSound = "TFA_BO3_IDGUN.Portal.Loop"
ENT.WindSound = "TFA_BO3_IDGUN.Portal.Wind"

--[Parameters]--
ENT.Delay = 8
ENT.Life = 6
ENT.SuccRange = 350
ENT.ExplodeRange = 512

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
	self:NetworkVar( "Bool", 1, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	self:StopParticles()

	util.ScreenShake(data.HitPos, 10, 255, 1, 1024)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	if data.HitNormal:Dot(Vector(0,0,-1))>0.6 then
		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetPos(data.HitPos + self:GetUp()*64)
			self:SetMoveType(MOVETYPE_NONE)
			self:SetAngles(Angle(0,90,0))
		end)
	end

	self.killtime = CurTime() + self.Life
	self:Portal()
end

function ENT:Portal()
	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_idgun_portal_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	else
		ParticleEffectAttach("bo3_idgun_portal", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	end

	self:EmitSound("TFA_BO3_IDGUN.Portal.Start")
	self:EmitSound(self.LoopSound)
	self:EmitSound(self.WindSound)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:UseTriggerBounds(true, 8)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:SetBuoyancyRatio(0)
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_idgun_trail_2",PATTACH_ABSORIGIN_FOLLOW,self,1)
		self.color = Color(255,90,60,255)
		self.Life = 8
	else
		ParticleEffectAttach("bo3_idgun_trail",PATTACH_ABSORIGIN_FOLLOW,self,1)
		self.color = Color(185,20,255,255)
		self.Life = 5
	end

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.dir = self:GetPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 1
			dlight.Decay = 2000
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			if self:GetActivated() then
				self:Explode()
			end
			self:Remove()
			return false
		end

		util.ScreenShake(self:GetPos(), 8, 255, 0.2, self.SuccRange)

		if self:GetActivated() then
			local tr = {
				start = self:GetPos(),
				filter = self,
				mask = MASK_SHOT_HULL
			}

			for k, v in pairs(ents.FindInSphere(self:GetPos(), self.SuccRange)) do
				if v:IsNPC() or v:IsNextBot() then
					if v == self:GetOwner() then continue end
					if v.NZBossType then continue end

					tr.endpos = v:WorldSpaceCenter()
					local tr1 = util.TraceLine(tr)
					if tr1.HitWorld then continue end

					if (v:IsNPC() or v:IsNextBot()) and not v:BO3IsPulledIn() then
						v:BO3PortalPull(2, self:GetOwner(), self.Inflictor, self:GetPos() - v:OBBCenter())
					end
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode()
	self:EmitSound("TFA_BO3_IDGUN.Portal.End")
	self:EmitSound("TFA_BO3_IDGUN.Portal.Expl")
	self:StopSound(self.LoopSound)
	self:StopSound(self.WindSound)

	self:StopParticles()

	util.ScreenShake(self:GetPos(), 10, 255, 1.5, 1024)

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.ExplodeRange)) do
		if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
			if v == ply then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:IsPlayer() and IsValid(ply) and ply:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			self:InflictDamage(v)
		end
	end

	if self:GetUpgraded() then
		ParticleEffect("bo3_idgun_implode_2", self:GetPos(), Angle(0,0,0))
	else
		ParticleEffect("bo3_idgun_implode", self:GetPos(), Angle(0,0,0))
	end
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_PREVENT_PHYSICS_FORCE, DMG_DISSOLVE))
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce((ent:GetPos() - self:GetPos()):GetNormalized() * 9000)
	damage:SetDamage(ent:Health() + 666)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(2000, ent:GetMaxHealth() / 8))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 4
			dlight.Decay = 1000
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.5
		end
	end

	self:StopSound(self.LoopSound)
	self:StopSound(self.WindSound)
end
