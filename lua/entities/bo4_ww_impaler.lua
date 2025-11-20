
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
ENT.PrintName = "Stake Bolt"

ENT.Delay = 10

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 1, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	self:InflictDamage(data.HitEntity, data.HitPos)

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

	self.killtime = CurTime() + 2
end

function ENT:StartTouch(ent)
	if self:GetActivated() then return end
	if ent == self:GetOwner() then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(self:GetOwner()) and !hook.Run("PlayerShouldTakeDamage", ent, self:GetOwner()) then return end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		local data = self:GetTouchTrace()
		self:InflictDamage(ent, self:GetPos(), data.HitGroup)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 2)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetBuoyancyRatio(0)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 0, Color(120, 120, 120), true, 8, 0, 0.3, 0.01, "cable/smoke.vmt")
end

function ENT:Think()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		local vel = phys:GetVelocity()
		phys:SetAngles(vel:Angle())
		phys:SetVelocity(vel)
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos, hitgroup)
	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce(self:GetForward()*5000)
	damage:SetDamageType(nZSTORM and DMG_BULLET or DMG_AIRBOAT)

	if hitgroup and hitgroup == HITGROUP_HEAD then
		damage:SetDamage(ent:Health() + 666)
	end

	ent:TakeDamageInfo(damage)
end
