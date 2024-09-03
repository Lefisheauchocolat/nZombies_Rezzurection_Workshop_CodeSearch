
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
ENT.PrintName = "Wind Storm (AAT Projectile)"

ENT.LoopSound = "TFA_BO4_ALISTAIR.Charged.WindLoop"

--[Parameters]--
ENT.Delay = 10
ENT.Life = 10
ENT.Range = 150

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	self:StopParticles()
	self:EmitSound(self.LoopSound)
	self:SetAngles(angle_zero)

	ParticleEffect("nz_aat_windstorm_start", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	ParticleEffectAttach("nz_aat_windstorm_loop", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	timer.Simple(0, function()
		if not IsValid(self) then return end
		local tr = util.QuickTrace(data.HitPos, vector_up*-200, self)
		if tr.Hit and tr.HitWorld then
			self:SetPos(tr.HitPos)
		else
			self:SetPos(data.HitPos)
		end
	end)

	self.killtime = CurTime() + self.Life

	phys:EnableMotion(false)
	phys:Sleep()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	ParticleEffectAttach("bo4_alistairs_trail_storm", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	if nzombies then
		self.TornadoEnts = {}
	end
	self:SetTrigger(true)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		dlight = dlight or DynamicLight(self:EntIndex(), false)
		if self:GetActivated() and dlight then
			dlight.pos = self:GetPos()
			dlight.r = 159
			dlight.g = 215
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 200
			dlight.dietime = CurTime() + 0.1
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:StopSound(self.LoopSound)
			self:Remove()
			return false
		end

		if self:GetActivated() then
			local pos = self:GetPos()

			for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
				if v:IsNPC() or v:IsNextBot() then
					if v == self:GetOwner() then continue end
					if nzombies and (v.NZBossType or string.find(v:GetClass(), "zombie_boss")) then continue end
					if v:BO4IsTornado() then continue end
					if v:Health() <= 0 then continue end
					local vpos = v:GetPos()

					if v:IsNPC() then
						v:SetGroundEntity(nil)

						local pushDir = (vpos - pos):GetNormalized()
						local magnitude = -15
						local vecPush = magnitude * pushDir
						if bit.band(v:GetFlags(), FL_BASEVELOCITY) != 0 then
							vecPush = vecPush + v:GetBaseVelocity()
						end

						v:SetVelocity(vecPush)
					end

					if v:IsNextBot() then
						if not nzombies then
							v.loco:FaceTowards(pos)
							v.loco:SetVelocity((pos - vpos):GetNormalized() * 250)
						end
						v.loco:Approach(pos, 99)
					end

					if vpos:DistToSqr(pos) < 3600 then
						if nzombies then
							v:BO4Tornado(math.Rand(4.5,5.5), self:GetOwner(), self.Inflictor)
							table.insert(self.TornadoEnts, v)
						else
							self:InflictDamage(v)
						end
					end
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_ALWAYSGIB)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(ent:GetUp()*30000)

	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	self:StopSound(self.LoopSound)
	self:EmitSound("TFA_BO4_ALISTAIR.Charged.WindEnd")

	if SERVER and nzombies then
		for k, v in pairs(self.TornadoEnts) do
			if IsValid(v) and v:IsValidZombie() and v:Alive() then
				local status = v:GetNWEntity("BO4.TornadoLogic")
				if IsValid(status) and status.statusEnd > CurTime() then
					status.statusEnd = CurTime()
				end
			end
		end
	end
end