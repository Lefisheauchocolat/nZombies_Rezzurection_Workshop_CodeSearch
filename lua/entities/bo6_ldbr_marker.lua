
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
ENT.PrintName = "LDBR"

--[Parameters]--
ENT.Delay = 2
ENT.MaxMissiles = 32
ENT.NumMissiles = 0

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Float", 1, "NextScream")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
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

function ENT:ActivateCustom(phys)
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:SetNextScream(CurTime())

	self.LandingSpots = {}
	self.StartingSpots = {}

	self.killtime = CurTime() + self.Delay
	self.NextGlow = CurTime() + 0.5

	self:SetActivated(true)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self.AutomaticFrameAdvance = true
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInitSphere(8, "metal_bouncy")
	self:SetRoll(self:GetAngles())
	self:SetModel("models/weapons/w_eq_smokegrenade.mdl")

	if CLIENT then return end
	timer.Simple(2, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 30)
end

function ENT:Think()
	if self:GetActivated() and self:GetNextScream() < CurTime() then
		self:SetNextScream(CurTime() + 1.5)
	end

	if SERVER then
		if self:GetActivated() and self.killtime < CurTime() and self.NumMissiles < self.MaxMissiles then
			self:Mortar()
			self.killtime = CurTime() + 0.5
			if self.NumMissiles%5 == 0 then
				self.killtime = CurTime() + 1
			end
		end

		if self.NumMissiles >= self.MaxMissiles then
			SafeRemoveEntityDelayed(self, 1)
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Mortar()
	local trace = {}
	local i = self.NumMissiles%5
	local a_v_land_offsets = self:BuildLandingOffset()
	local a_v_start_offsets = self:BuildStartingOffset()

	self.StartingSpots[i] = self:GetPos() + a_v_start_offsets[i]
	self.LandingSpots[i] = self:GetPos() + a_v_land_offsets[i]

	local v_start_trace = self.StartingSpots[i] - Vector(0, 0, 2000)

	uptrace = util.QuickTrace(self:GetPos(), Vector(0,0,8000), self)

	trace = util.TraceLine({
		start = v_start_trace,
		endpos = self.LandingSpots[i],
		filter = self,
		mask = MASK_SOLID,
		ignoreworld = (uptrace.HitWorld or uptrace.HitSky),
	})

	if not util.IsInWorld(trace.HitPos) then
		trace = util.TraceLine({
			start = trace.HitPos - trace.HitNormal,
			endpos = self.LandingSpots[i],
			filter = self,
			mask = MASK_SOLID,
			ignoreworld = (uptrace.HitWorld or uptrace.HitSky),
		})
	end

	self.LandingSpots[i] = trace.HitPos

	if SERVER then
		local dist = self.StartingSpots[i]:Distance(self.LandingSpots[i])
		local mortar = ents.Create("bo3_tac_gstrike_mortar")
		mortar:SetModel("models/weapons/tfa_bo3/qed/w_maxgl_proj.mdl")
		mortar:SetPos(self.StartingSpots[i])
		mortar:SetAngles(Angle(90,0,0))
		mortar:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)

		local dam = 10000
		if engine.ActiveGamemode() == "nzombies" then
			dam = nzRound:GetNumber()*1000+10000
		end
		mortar.Damage = dam
		mortar.mydamage = dam
		mortar.Delay = 12
		mortar:SetLandingSpot(self.LandingSpots[i])

		mortar:Spawn()

		local dir = (self.LandingSpots[i] - self.StartingSpots[i]):GetNormalized()*dist

		mortar:SetVelocity(dir)
		local phys = mortar:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(dir)
		end

		mortar:SetOwner(IsValid(self:GetOwner()) and self:GetOwner() or self)
		mortar.Inflictor = IsValid(self.Inflictor) and self.Inflictor or self
	end

	self.NumMissiles = self.NumMissiles + 1
end

function ENT:BuildLandingOffset()
	local a_offsets = {}
	a_offsets[0] = Vector(0, 0, 1)
	a_offsets[1] = Vector(-1, 1, 0) * math.random(80,480)
	a_offsets[2] = Vector(1, 1, 0) * math.random(80,480)
	a_offsets[3] = Vector(1, -1, 0) * math.random(80,480)
	a_offsets[4] = Vector(-1, -1, 0) * math.random(80,480)

	return a_offsets
end

function ENT:BuildStartingOffset()
	local a_offsets = {}
	a_offsets[0] = Vector( 0, 0, 2000)
	a_offsets[1] = Vector(-500, 500, 2000)
	a_offsets[2] = Vector(500, 500, 2000)
	a_offsets[3] = Vector(500, -500, 2000)
	a_offsets[4] = Vector(-500, -500, 2000)

	return a_offsets
end