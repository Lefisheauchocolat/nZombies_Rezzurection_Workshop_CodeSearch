
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
ENT.PrintName = "Lil' Squidy"

--[Sounds]--
ENT.BounceSound = Sound("TFA_BO3_ARNIE.JarBounce")

--[Parameters]--
ENT.Delay = 1

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Activated")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end

	if data.Speed > 60 then
		self:EmitSound(self.BounceSound)
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )

	if data.Speed < 100 and data.HitNormal:Dot(vector_up) < 0 then
		self:ActivateCustom(phys)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)
	
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(12, "metal_bouncy")
	self:SetRoll(self:GetAngles())

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	timer.Simple(6, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 20)
end

function ENT:Think()
	if SERVER then
		if self:GetActivated() and self.killtime < CurTime() then
			self:CreateSquid()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:ActivateCustom(phys)
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:SetActivated(true)
end

function ENT:CreateSquid()
	local arnie = ents.Create("bo3_tac_lilarnie_squid")
	arnie:SetModel("models/weapons/tfa_bo3/octobomb/octobomb_arnie.mdl")
	arnie:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	arnie:SetPos(self:GetPos() - Vector(0,0,11))
	arnie:SetAngles(self:GetRoll() - Angle(0,90,0))

	arnie:SetUpgraded(self:GetUpgraded())
	arnie.Damage = self.mydamage
	arnie.mydamage = self.mydamage
			
	arnie:Spawn()
	arnie:DropToFloor()

	arnie:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
	arnie.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self

	self:Remove()
end
