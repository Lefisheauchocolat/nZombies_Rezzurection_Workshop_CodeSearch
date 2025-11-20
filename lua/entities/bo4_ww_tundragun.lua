
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
ENT.PrintName = "ICE COLD"

--[Sounds]--
ENT.ExplosionSound1 = "TFA_BO4_TUNDRAGUN.Impact"
ENT.ExplosionSound2 = "TFA_BO3_GRENADE.ExpClose"
ENT.ExplosionSound3 = "TFA_BO3_GRENADE.Flux"

--[Parameters]--
ENT.Delay = 0.3
ENT.Range = 300
ENT.InnerRange = 100

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	util.Decal("snow_grenade", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)

	self:StopParticles()
	self:Explode(data.HitPos)
	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	if ent == self:GetOwner() then return end
	if not (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then return end

	self.Impacted = true
	self:StopParticles()
	self:Explode(self:GetPos())
	self:Remove()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	//self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:PhysicsInitSphere(8, "gmod_ice")
	self:UseTriggerBounds(true, 4)

	ParticleEffectAttach("bo4_tundragun_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self:WaterLevel() > 0 then
			self:Remove()
			return false
		end

		if self.killtime < CurTime() then
			self:Explode(self:GetPos())
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:DoExplosionEffect()
	ParticleEffect("bo4_tundragun_impact", self:GetPos(), angle_zero)

	self:EmitSound(self.ExplosionSound1)
	self:EmitSound(self.ExplosionSound2)
	self:EmitSound(self.ExplosionSound3)
end

function ENT:Explode(pos)
	if SERVER then
		local ply = self:GetOwner()
		if not pos then
			pos = self:GetPos()
		end

		local inner_range = self.InnerRange
		local outer_range = self.Range
		local inner_range_squared = inner_range * inner_range
		local outer_range_squared = outer_range * outer_range

		for k, ent in pairs(ents.FindInSphere(pos, self.Range)) do
			if not (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()) then continue end

			if ent:BO4IsFrozen() then continue end
			if nzombies and ent:IsPlayer() then continue end
			if ent == ply then continue end
			if ent:Health() <= 0 then continue end
			if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end

			local test_origin = ent:WorldSpaceCenter()
			local test_range_squared = pos:DistToSqr(test_origin)

			local tr1 = util.TraceLine({
				start = pos,
				endpos = test_origin,
				filter = {self, ply},
				mask = MASK_SOLID_BRUSHONLY,
			})

			if tr1.HitWorld then continue end
			local damagefinal = self.mydamage or self.Damage
			if nzombies and ent:IsValidZombie() then
				local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
				damagefinal = tonumber(nzCurves.GenerateHealthCurve(round)) + 6
			end
			local dist_ratio = (outer_range_squared - test_range_squared) / (outer_range_squared - inner_range_squared) 
			local damage = tonumber(Lerp(dist_ratio, damagefinal / 2, damagefinal))

			self:FreezegunDamage(ent, damage)
		end
	end

	self:DoExplosionEffect()
	self:Remove()
end

local function enemy_percent_damaged_by_freezegun(d, e)
	if not IsValid(e) then return 0 end
	return math.Clamp(1 - (d / e:Health()), .33, 1)
end

function ENT:FreezegunDamage(ent, amount)
	if ent:BO4IsFrozen() then return end
	local damage = DamageInfo()
	damage:SetDamageType(nZSTORM and DMG_VEHICLE or DMG_REMOVENORAGDOLL)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamage(math.Clamp(ent:Health() - 1, 1, amount))
	damage:SetDamageForce(ent:GetForward() * -100)

	if nzombies and ent.NZBossType then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 8))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
	end

	if ent:Health() <= 1 then
		ent:SetHealth(2)
	end
	local realhealth = ent:Health() - damage:GetDamage() //doing this because of weird hook run order on physicscollide and starttouch

	ent:TakeDamageInfo(damage)
	ParticleEffect("bo4_tundragun_zomb", ent:WorldSpaceCenter(), angle_zero)

	if ent:Health() > 0 then
		if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then return end
		if ent:IsPlayer() and not ent:Alive() then return end

		if realhealth <= 1 then
			if nzombies and nzPowerUps:IsPowerupActive("insta") then return end
			ent:BO4WintersFreeze(math.Rand(3,4), self:GetOwner(), self.Inflictor)
		elseif realhealth > 1 then
			ent:BO4WintersSlow(10, enemy_percent_damaged_by_freezegun(amount, ent))
		end
	end
end
