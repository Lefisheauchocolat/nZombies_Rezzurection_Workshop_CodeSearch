
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
ENT.PrintName = "Hellfire Tornado"

--[Parameters]--
ENT.Delay = 20
ENT.Range = 60

DEFINE_BASECLASS( ENT.Base )

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:UpdateTransmitState()
	return self:GetActivated() and TRANSMIT_ALWAYS or TRANSMIT_PVS
end

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:StartTouch(ent)
	local ply = self:GetOwner()
	if not ent:IsWorld() and ent:IsSolid() then
		if nzombies and ent:IsPlayer() then return end
		if not pvp_bool:GetBool() and ent:IsPlayer() then return end
		if ent == ply then return end
		ent:Ignite(4)
		if ent:Health() <= 0 then return end
		if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

		if ent:IsPlayer() or ent:IsNextBot() or ent:IsNPC() then
			ParticleEffectAttach("bo4_alistairs_fireball_kill", PATTACH_POINT_FOLLOW, ent, 0)
			ent:EmitSound("TFA_BO4_ALISTAIR.Charged.FireExpl")
			ent:EmitSound("TFA_BO4_HELLFIRE.Sizzle")

			self:InflictDamage(ent)
		end
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetActivated(true)
	self:SetNoDraw(true)
	self:DrawShadow(false)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_OBB)
	self:SetMoveType(bit.bor(MOVETYPE_FLYGRAVITY, MOVECOLLIDE_FLY_BOUNCE))
	self:SetLocalVelocity(self:GetForward() * 100)

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:UseTriggerBounds(true, self.Range)

	self:EmitSoundNet("TFA_BO4_HELLFIRE.Tornado.Start")
	self:EmitSoundNet("TFA_BO4_HELLFIRE.Tornado.Loop")

	ParticleEffectAttach("bo4_hellfire_tornado", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:Wake()
	end

	self.LastStuckPos = self:GetPos()
	self.NextStuckThink = CurTime()
	self.StuckStrength = 0

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self:DropToFloor()
	self:SetTrigger(true)
end

function ENT:IsStuck()
	if CLIENT then return end

	if self.NextStuckThink < CurTime() then
		self.NextStuckThink = CurTime() + 0.1

		if self.LastStuckPos:Distance(self:GetPos()) < 10 then
			local strength = math.Clamp(self:GetPos():DistToSqr(self:GetOwner():GetEyeTrace().HitPos), 0, 200) / 50

			self.StuckStrength = self.StuckStrength + math.Clamp(strength, 1, 4)
		else
			self.StuckStrength = 0
		end

		self.LastStuckPos = self:GetPos()

		if self.StuckStrength >= 5 then
			return true
		elseif self.StuckStrength == 0 then
			local dt = util.QuickTrace(self:GetPos(), self:GetUp()*-10, self)
			if not dt.Hit then
				self:DropToFloor()
			end
		end
	end

	return false
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 90
			dlight.b = 0
			dlight.brightness = 1
			dlight.Decay = 2000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) and self:GetActivated() then
			local tr = ply:GetEyeTrace()
			local norm = (tr.HitPos - self:GetPos()):GetNormalized()
			local fwd = Vector(norm.x,norm.y,0)

			if self:IsStuck() then
				self:SetPos(self:GetPos() + Vector(0,0,12))
			end

			self:SetLocalVelocity(fwd * 150)
		end

		util.ScreenShake(self:GetPos(), 4, 255, 0.1, 200)

		if self.killtime < CurTime() then
			self:StopSound("TFA_BO4_HELLFIRE.Tornado.Loop")
			self:EmitSound("TFA_BO4_HELLFIRE.Tornado.End")
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(1400, ent:GetMaxHealth() / 6))
		//damage:ScaleDamage(math.min(math.Round(nzRound:GetNumber()/12), 1))
	end

	ent:SetNW2Bool("RemoveRagdoll", true)
	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	self:StopSound("TFA_BO4_HELLFIRE.Tornado.Loop")
end