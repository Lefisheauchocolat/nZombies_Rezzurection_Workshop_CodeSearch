
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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_FLY)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:UseTriggerBounds(true, 6)
	self:SetTrigger(true)

	self.Ratio = engine.TickInterval()*5
	self:EmitSound("TFA_BO2_ZMDRONE.Idle")
	self:EmitSound("TFA_BO2_ZMDRONE.Hum")
	self:SetDestroyed(false)
	self:SetNextAttack(0)
	self.DecayDelay = CurTime() + 1
	self.finalpos = self:GetPos() + Vector(0,0,10) + self:GetForward()*30

	for k, v in pairs(ents.FindByClass(self:GetClass())) do
		if v:GetOwner() == self:GetOwner() and v ~= self then
			v:Remove()
		end
	end

	local ply = self:GetOwner()
	if IsValid(ply) then
		if nzombies and ply:IsPlayer() then
			timer.Simple(0, function()
				if not IsValid(ply) or not IsValid(self) then return end
				ply:AddBuildable(self)
			end)
		end
		ply.NextTrapUse = CurTime() + 0.35 //use delay

		if not util.IsInWorld(self:GetPos()) then
			self:SetPos(ply:GetShootPos()) //plz dont get stuck in walls
		end
	end
end

function ENT:Think()
	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:SetHealth(1)
		self:TakeDamage(666, self, self)
		return false
	end

	self:TurbineDecay()
	self:Targeting()

	self:NextThink(CurTime())
	return true
end

function ENT:TurbineDecay()
	if self:GetDestroyed() then return end
	if self.DecayDelay < CurTime() then
		self:TakeDamage(10, self)
		self.DecayDelay = CurTime() + 1
	end
end

function ENT:Targeting()
	if self:GetDestroyed() then return end
	if !self.TargetEnt or !IsValid(self.TargetEnt) or self.TargetEnt:Health() <= 0 then
		self.TargetEnt = self:FindNearestEntity(self:GetPos())
	end

	local target = self.TargetEnt
	local ply = self:GetOwner()
	if IsValid(target) then
		local normal = (target:GetPos() - self:GetPos()):GetNormalized()
		local forward = self:GetForward()
		local dot = forward:Dot(normal)

		self:SetAngles(LerpAngle(self.Ratio, self:GetAngles(), normal:Angle())) //aiming

		if target:GetClass() == "drop_powerup" then
			self:SetPos(LerpVector(0.05, self:GetPos(), target:GetPos()))
			if self:GetPos():DistToSqr(target:GetPos()) < 100 then
				nzPowerUps:Activate(target:GetPowerUp(), ply, target)
				local GLOBAL = nzPowerUps:Get(target:GetPowerUp()).global
				ply:EmitSound(nzPowerUps:Get(target:GetPowerUp()).collect or "nz_moo/powerups/powerup_pickup_zhd.mp3")
				target:Remove()
			end
		else
			if self:GetNextAttack() < CurTime() and dot > .8 then
				local muzzle = self:GetAttachment(1)

				local fx1 = EffectData()
				fx1:SetScale(2)
				fx1:SetOrigin(muzzle.Pos)
				fx1:SetAngles(muzzle.Ang)
				util.Effect("MuzzleEffect", fx1)

				self:EmitSound("TFA_BO2_MOWER.Shoot")
				self:EmitSound("TFA_BO2_ZMDRONE.Shoot")

				if nzombies and IsValid(ply) then
					self:SetNextAttack(CurTime() + (60 / (ply:HasPerk("time") and self.RPMRapid or self.RPM)))
				else
					self:SetNextAttack(CurTime() + (60 / self.RPM))
				end

				self:InflictDamage(target)
			end
		end
	else //shitty fake 'breathing' animation thingy
		local breath = math.sin(CurTime())
		local breath2 = math.cos(CurTime()) * 0.5

		local finalpos = self.finalpos + (self:GetForward() * breath2) + (self:GetUp() * breath*4)
		self:SetPos(LerpVector(self.Ratio, self:GetPos(), finalpos))

		local finalang = Angle(breath2*6, self:GetForward():Angle()[2], breath*4)
		self:SetAngles(LerpAngle(self.Ratio, self:GetAngles(), finalang))
	end
end

function ENT:FindNearestEntity(pos)
	local nearbyents = {}
	local tr = {
		start = pos,
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local friends = {
		[D_LI] = true,
		[D_NU] = true,
	}

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 350)) do
		if v:IsNPC() or v:IsNextBot() or (v:GetClass() == "drop_powerup") then
			if v == ply then continue end
			if v:GetMaxHealth() > 0 and v:Health() <= 0 then continue end
			if v.Alive and not v:Alive() then continue end
			if v:IsNPC() and friends[v:Disposition(ply)] then continue end

			if v:GetClass() == "drop_powerup" then
				if v.GetActivated and not v:GetActivated() then continue end
				if v.GetAnti and v:GetAnti() then continue end
			else
				tr.endpos = v:WorldSpaceCenter()
				local tr1 = util.TraceLine(tr)
				if tr1.HitWorld then continue end
			end

			table.insert(nearbyents, v)
		end
	end

	table.sort(nearbyents, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
	return nearbyents[1]
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()

	local mydamage = 10
	if nzombies and ent:IsValidZombie() then
		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
		local health = tonumber(nzCurves.GenerateHealthCurve(round))
		local rand = math.random(5,10)

		mydamage = math.max(mydamage, health / rand)
	end

	local damage = DamageInfo()
	damage:SetDamage(mydamage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(self:GetAttachment(1).Ang:Forward()*6500)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	if ent.NZBossType then
		local rand = math.random(40, 50)
		damage:SetDamage(math.max(mydamage, ent:GetMaxHealth() / rand))
	end

	if ent:IsNPC() or ent:IsNextBot() then
		ParticleEffect("blood_impact_red_01", ent:WorldSpaceCenter() + (ent:OBBCenter() * math.Rand(.1,.7) + VectorRand(-8, 8)), ent:GetForward():Angle())
		local rand = VectorRand(-21,21)
		rand = Vector(rand.x, rand.y, 1)
		util.Decal("Blood", ent:GetPos() - rand, ent:GetPos() + rand)
	end

	ent:TakeDamageInfo(damage)
	ent:EmitSound("TFA_BO3_GENERIC.Gib")
end

function ENT:OnTakeDamage(dmginfo)
	if self:GetDestroyed() then return end
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) then return end
	if nzombies and attacker:IsPlayer() then return end

	/*local ply = self:GetOwner()
	local damage = dmginfo:GetDamage()
	if nzombies and IsValid(ply) and ply:HasPerk("amish") then
		damage = damage * 0.5
	end*/

	self:SetHealth(self:Health() - dmginfo:GetDamage())

	if self:Health() <= 0 then
		if nzombies then
			self:SetDestroyed(true)
			self:Remove()
		return end

		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetOrigin(self:WorldSpaceCenter())
		fx:SetNormal(self:GetUp()*-1)
		fx:SetScale(25)

		util.Effect("cball_explode", fx)

		self:StopSound("TFA_BO2_ZMDRONE.Idle")
		self:StopSound("TFA_BO2_ZMDRONE.Hum")
		if IsValid(ply) then
			ply:EmitSound("TFA_BO2_SHIELD.Break")
		end

		self:DropToFloor()
		self:SetDestroyed(true)
	end
end

function ENT:Use(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if not nzombies and !self:GetDestroyed() and ply ~= self:GetOwner() then return end
	if ply.NextTrapUse and ply.NextTrapUse > CurTime() then return end

	local own = self:GetOwner()
	if nzombies and IsValid(own) and own:IsPlayer() and ply ~= own and own:GetInfoNum("nz_buildable_sharing", 0) < 1 then return end

	if not ply:HasWeapon(self:GetTrapClass()) then
		ply.NextTrapUse = CurTime() + 0.25

		local wep = ply:Give(self:GetTrapClass())
		if IsValid(wep) then
			local hp = math.Clamp(self:Health() / self:GetMaxHealth(), 0, 1)
			wep:SetClip1(math.Round(hp * wep.Primary_TFA.ClipSize))
			wep:SetNextPrimaryFire(CurTime() + 10)
		end

		self:EmitSound("TFA_BO2_SHIELD.Pickup")
		self:Remove()
	end
end
