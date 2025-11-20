
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
ENT.PrintName = "GKZ-45"

--[Sounds]--
ENT.StartSound = "TFA_BO3_GKZMK3.Orb.Start"
ENT.LoopSound = "TFA_BO3_GKZMK3.Orb.Loop"
ENT.EndSound = "TFA_BO3_GKZMK3.Orb.End"

--[Parameters]--
ENT.Delay = 10
ENT.Life = 3.5
ENT.Range = 110

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
	
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		if data.HitNormal:Dot(Vector(0,0,-1))>0.9 then
			self:SetPos(data.HitPos + Vector(0,0,48))
		end
		self:SetAngles(Angle(0,0,0))
	end)
	
	self:EmitSound("TFA_BO3_GKZMK3.Orb.Start")
	self:EmitSound("TFA_BO3_GKZMK3.Orb.Loop")

	ParticleEffectAttach("bo3_gkz_loop", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	self.killtime = CurTime() + self.Life

	phys:EnableMotion(false)
	phys:Sleep()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetBuoyancyRatio(0)
	end

	ParticleEffectAttach("bo3_gkz_trail", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:StartTouch(ent)
	local ply = self:GetOwner()
	if ent == ply then return end
	if not ent:IsSolid() then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if not self:GetActivated() and (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then
		local data = self:GetTouchTrace()
		local damage = DamageInfo()
		damage:SetAttacker(IsValid(ply) and ply or self)
		damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
		damage:SetDamage(self:GetUpgraded() and 190 or 100)
		damage:SetDamageType(bit.bor(DMG_PREVENT_PHYSICS_FORCE, DMG_DISSOLVE))
		damage:SetDamageForce(data.Normal)
		damage:SetDamagePosition(data.HitPos)

		if nzombies and ent.NZBossType then
			damage:ScaleDamage(math.Round(nzRound:GetNumber()/8))
		end

		ent:TakeDamageInfo(damage)
	end

	if ent:GetClass() == "bo3_ww_mk3" then
		self:StopSound("TFA_BO3_GKZMK3.Orb.Loop")
		self:StopParticles()
		self:CreateBlackHole()
		self:Remove()
	end
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex(), false)
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 250
			dlight.b = 50
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 256
			dlight.dietime = CurTime() + 1
		end
	end

	if SERVER then
		if self:GetActivated() then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
				if v:GetClass() == "bo3_ww_mk3" and self:GetPos():Distance(v:GetPos()) < 42 then
					self:StopSound("TFA_BO3_GKZMK3.Orb.Loop")
					self:CreateBlackHole()
					self:StopParticles()
					self:Remove()
					return false
				end

				if v:IsNPC() then
					self:SmokeyHead(v)
					if not v.Old_Speed then
						v.Old_Speed = v:GetMoveVelocity()
					end

					v:SetMoveVelocity(v.Old_Speed/3)
				end

				if v:IsNextBot() then
					self:SmokeyHead(v)

					v.loco:SetVelocity(v:GetForward() * (v.loco:GetDesiredSpeed()/3))
				end
			end
		end

		if self.killtime < CurTime() then
			self:StopSound("TFA_BO3_GKZMK3.Orb.Loop")
			self:Explode()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:SmokeyHead(ent)
	if not IsValid(ent) or ent:Health() <= 0 then return end
	local att = ent:WorldSpaceCenter()

	ParticleEffect("bo3_gkz_zomb", att, Angle(0,0,0))
end

function ENT:CreateBlackHole()
	local bhole = ents.Create("bo3_ww_gkzmk3_bh")
	bhole:SetModel("models/hunter/misc/sphere025x025.mdl")
	bhole:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	bhole:SetPos(self:GetPos())
	bhole:SetAngles(Angle(0,0,0))
	bhole:SetUpgraded(self:GetUpgraded())

	bhole:Spawn()

	bhole:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	bhole.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self
end

function ENT:Explode()
	self:StopSound("TFA_BO3_GKZMK3.Orb.Loop")
	self:EmitSound("TFA_BO3_GKZMK3.Orb.End")

	util.ScreenShake(self:GetPos(), 10, 255, 1, 512)
	ParticleEffect("bo3_gkz_explode", self:GetPos(), Angle(0,0,0))

	self:Remove()
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 250
			dlight.b = 50
			dlight.brightness = 5
			dlight.Decay = 2000
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.5
		end
	end

	self:StopSound("TFA_BO3_GKZMK3.Orb.Loop")
end
