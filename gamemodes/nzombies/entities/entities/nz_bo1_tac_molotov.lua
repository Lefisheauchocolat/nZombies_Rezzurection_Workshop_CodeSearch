
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
ENT.PrintName = "Molotov"

ENT.NZThrowIcon = Material("vgui/icon/weapon_molotov_cac.png", "unlitgeneric smooth")
ENT.NZTacticalPaP = true

ENT.BounceSound = Sound("HEGrenade.Bounce")
ENT.ExplodeSound = "TFA_BO1_MOLOTOV.Loop"
ENT.ShatterSound = "TFA_BO1_MOLOTOV.Explode"

ENT.Range = 120
ENT.Delay = 10
ENT.Life = 10
ENT.LifePaP = 20

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Upgraded")
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	if data.HitNormal:Dot(Vector(0,0,-1))<0.75 then
		if data.Speed > 60 then
			self:EmitSound(self.BounceSound)
		end

		local impulse = (data.OurOldVelocity - 3 * data.OurOldVelocity:Dot(data.HitNormal) * data.HitNormal)*0.9
		phys:ApplyForceCenter(impulse)
	else
		self:StopParticles()

		self:SetNoDraw(true)
		self:DrawShadow(false)
		self:SetAngles(data.HitNormal:Angle() - Angle(90,0,0))

		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetPos(data.HitPos)
			self:SetSolid(SOLID_NONE)
			self:SetMoveType(MOVETYPE_NONE)
			self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		end)

		self:Explode()
		phys:EnableMotion(false)
		phys:Sleep()

		ParticleEffect(self:GetUpgraded() and "bo1_molotov_impact_2" or "bo1_molotov_impact", data.HitPos - data.HitNormal, angle_zero)

		self:SetActivated(true)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self.killtime = CurTime() + self.Delay
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	ParticleEffectAttach(self:GetUpgraded() and "bo1_molotov_trail_2" or "bo1_molotov_trail", PATTACH_POINT_FOLLOW, self, 1)
end

function ENT:Think()
	local ply = self:GetOwner()
	if CLIENT and self:GetActivated() and dlight_cvar:GetBool() then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			local upg = self:GetUpgraded()
			dlight.pos = self:GetPos() + vector_up
			dlight.r = upg and 90 or 235
			dlight.g = upg and 230 or 75
			dlight.b = upg and 255 or 15
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 400
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self.killtime and self.killtime < CurTime() then
			self:Remove()
			return false
		end
		if self:WaterLevel() > 0 then
			self:Remove()
			return false
		end

		if self:GetActivated() then
			local ply = self:GetOwner()
			local tr = {
				start = self:GetPos(),
				filter = self,
				mask = MASK_SHOT_HULL
			}

			for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
				if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
					if IsValid(ply) and v:IsNPC() and v:Disposition(ply) == D_LI then continue end
					if self:GetUpgraded() and v:IsPlayer() then continue end
					if v.NextBurn and v.NextBurn > CurTime() then continue end

					tr.endpos = v:WorldSpaceCenter()
					local tr1 = util.TraceLine(tr)
					if tr1.HitWorld then continue end

					v.NextBurn = CurTime() + 1/3
					self:InflictDamage(v)
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos)
	local ply = self:GetOwner()
	local mydamage = math.random(40,60)
	local b_isplayer = ent:IsPlayer()
	local b_iszombie = ent:IsValidZombie()
	local b_upgraded = self:GetUpgraded()

	if b_iszombie then
		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
		local health = tonumber(nzCurves.GenerateHealthCurve(round)) + 666
		local rand = b_upgraded and math.random(6,9) or math.random(6,12)
		mydamage = math.max(mydamage, health / rand)

		if (ent.Alive and ent:Alive()) or (ent.IsAlive and ent:IsAlive()) then
			local time = b_upgraded and math.Rand(4,6) or math.Rand(2,4)
			ent:BO1BurnSlow(math.Round(time, 2), b_upgraded)
		end
	else
		if b_isplayer and ent:Health() <= 10 then return end
		ent:Ignite(b_isplayer and 0.4 or 3)
		if b_isplayer then return end
	end

	local damage = DamageInfo()
	damage:SetDamage(mydamage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(hitpos or ent:WorldSpaceCenter())
	damage:SetDamageType(bit.bor(DMG_BURN, DMG_SLOWBURN))

	local distfac = self:GetPos():Distance(ent:GetPos())
	distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
	damage:ScaleDamage(math.Clamp(distfac*(4/3), 0.2, 1.2))

	if ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss") then
		local rand = math.random(40,60)
		damage:SetDamage(math.max(rand, ent:GetMaxHealth() / rand))
	end

	ent:TakeDamageInfo(damage)
	if b_iszombie then ent:Extinguish() end
end

function ENT:DoExplosionEffect()
	self:EmitSound(self.ShatterSound)
	self:EmitSound(self.ExplodeSound)
	ParticleEffectAttach(self:GetUpgraded() and "bo1_molotov_loop_2" or "bo1_molotov_loop", PATTACH_ABSORIGIN, self, 0)
end

function ENT:Explode()
	self:DoExplosionEffect()

	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
			if IsValid(ply) and v:IsNPC() and v:Disposition(ply) == D_LI then continue end
			if v:IsPlayer() and v ~= ply then continue end
			if self:GetUpgraded() and v:IsPlayer() then continue end

			tr.endpos = v:WorldSpaceCenter() + (v:OBBCenter()*0.2)
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			self:InflictDamage(v, tr1.HitPos)
		end
	end

	self.killtime = nil
	SafeRemoveEntityDelayed(self, self:GetUpgraded() and self.LifePaP or self.Life) --removal of nade
end

function ENT:OnRemove()
	self:StopParticles()
	self:StopSound(self.ExplodeSound)
	self:EmitSound("TFA_BO1_MOLOTOV.Burn")
end