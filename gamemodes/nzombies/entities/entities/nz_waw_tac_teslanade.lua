
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
ENT.PrintName = "Quizz Teslanade"
ENT.NZThrowIcon = Material("vgui/icon/quizz_teslanade.png", "unlitgeneric smooth")

--[Sounds]--
ENT.BounceSound = Sound("TFA_WAW_QUIZZTESLA.Bounce")

--[Parameters]--
ENT.Delay = 1.8
ENT.Life = 7.8
ENT.Range = 200
ENT.TPRange = 42^2
ENT.Rate = 0.1
ENT.Kills = 0

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 1, "Activated")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:Draw()
	self:SetRenderAngles(self:GetRoll())
	self:DrawModel()

	if !self.pvslight1 or !IsValid(self.pvslight1) then
		self.pvslight1 = CreateParticleSystem(self, "waw_teslanade_wm1", PATTACH_POINT_FOLLOW, 1)
	end
	if !self.pvslight2 or !IsValid(self.pvslight2) then
		self.pvslight2 = CreateParticleSystem(self, "waw_teslanade_wm2", PATTACH_POINT_FOLLOW, 2)
	end
	if !self.pvslight3 or !IsValid(self.pvslight3) then
		self.pvslight3 = CreateParticleSystem(self, "waw_teslanade_wm2", PATTACH_POINT_FOLLOW, 3)
	end
	if !self.pvslight4 or !IsValid(self.pvslight4) then
		self.pvslight4 = CreateParticleSystem(self, "waw_teslanade_wm3", PATTACH_POINT_FOLLOW, 4)
	end

	if self:GetActivated() and (!self.pvsfx or !IsValid(self.pvsfx)) then
		self.pvsfx = CreateParticleSystem(self, "waw_teslanade_loop", PATTACH_ABSORIGIN_FOLLOW, 0)
	end
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
	self:PhysicsInitSphere(0.2, "metal_bouncy")
	self:SetRoll(self:GetAngles())

	self.killtime = nil

	if CLIENT then return end
	timer.Simple(6, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)
	self:SetTrigger(true)
	SafeRemoveEntityDelayed(self, 24)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)
		if self.DLight and self:GetActivated() then
			self.DLight.pos = self:GetPos()
			self.DLight.r = 220
			self.DLight.g = 250
			self.DLight.b = 255
			self.DLight.brightness = 1
			self.DLight.Decay = 2000
			self.DLight.Size = 300
			self.DLight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		local ply = self:GetOwner()
		if self.collapsing then
			self:SetPos(self:GetPos() - vector_up*0.2)
		end

		if self:GetActivated() then
			if self.killtime and self.killtime < CurTime() and !self.collapsing then
				self:Collapse()
			end

			for k, v in RandomPairs(ents.FindInSphere(self:GetPos(), self.Range)) do
				if v:IsValidZombie() then
					if v == ply then continue end
					if v.Alive and not v:Alive() then continue end
					if v:Health() <= 0 then continue end
					if v:WAWTeslaWarping() then continue end

					v:WAWTeslaWarp(2, ply, self.Inflictor)
					break
				end
				if v:IsPlayer() and v:GetPos():DistToSqr(self:GetPos()) < self.TPRange then
					local spawn = table.Random(ents.FindByClass("player_spawns"))
					if IsValid(spawn) then
						ParticleEffect("waw_teslanade_warpout", v:WorldSpaceCenter(), angle_zero)

						local pos = spawn:GetPos()
						v:ViewPunch(Angle(-4, math.random(-6, 6), 0))
						v:SetPos(pos)
						v:EmitSound("TFA_WAW_QUIZZTESLA.Teleport")

						ParticleEffect("nz_perks_chuggabud_tp", pos, angle_zero)
					end
				end
			end
		end

		if not self:GetActivated() and self.killtime and self.killtime < CurTime() and !self.collapsing then
			self:StartActivate()
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

	self:SetAngles(angle_zero)
	self:EmitSound("TFA_WAW_QUIZZTESLA.Warmup")
	self.killtime = CurTime() + self.Delay
	ParticleEffectAttach("waw_teslanade_start", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
end

function ENT:StartActivate()
	self:SetActivated(true)

	self.killtime = CurTime() + self.Life
	self:EmitSound("TFA_WAW_QUIZZTESLA.Loop")
end

function ENT:Collapse()
	self:SetActivated(false)
	self.collapsing = true

	self:StopParticles()
	self:StopSound("TFA_WAW_QUIZZTESLA.Loop")
	self:EmitSound("TFA_WAW_QUIZZTESLA.Flux")
	self:EmitSound("TFA_WAW_QUIZZTESLA.End")

	ParticleEffect("waw_teslanade_end", self:GetPos(), Angle(0,0,0))

	util.Decal("Scorch", self:GetPos() - vector_up, self:GetPos() + vector_up)

	SafeRemoveEntityDelayed(self, 2)
	self:SetTargetPriority(TARGET_PRIORITY_NONE)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsValidZombie() and v:WAWTeslaWarping() and v.waw_teslawarp_logic then
			v.waw_teslawarp_logic.statusEnd = CurTime() + engine.TickInterval()*math.random(0,4)
		end
	end
end
