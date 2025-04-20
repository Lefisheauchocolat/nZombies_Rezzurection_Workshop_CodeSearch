
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
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(CONTINUOUS_USE)

	self:SetCollisionBounds(Vector(-10,-10, 0), Vector(10, 10, 42))
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:UseTriggerBounds(true, 5)
	self:SetTrigger(true)

	self.AutomaticFrameAdvance = true
	self:EmitSound("TFA_BO2_RAKETRAP.Fall")
	self:SetDestroyed(false)
	self:SetAttacked(false)
	self:SetNextAttack(CurTime() + 1)

	if nzombies then
		local count = 0
		for k, v in ipairs(ents.FindByClass(self:GetClass())) do
			if v:GetOwner() == self:GetOwner() and v ~= self then
				if #player.GetAllPlaying() <= 1 then
					if count >= 1 then
						v:SetHealth(1)
						v:TakeDamage(666, self, self)
						continue
					end

					count = count + 1
				else
					v:SetHealth(1)
					v:TakeDamage(666, self, self)
				end
			end
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
			self:SetPos(ply:GetPos()) //plz dont get stuck in walls
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

	if self:GetAttackDelay() ~= 0 and self:GetAttackDelay() < CurTime() and not self:GetAttacked() then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 25)) do
			if not v:IsWorld() and v:IsSolid() then
				if v == self then continue end
				if v:Health() <= 0 then continue end
				if nzombies and (v:IsPlayer() and v ~= self:GetOwner()) then continue end

				self:InflictDamage(v)
				self:TakeDamage(math.random(5)*5, v, v)
			end
		end

		self:SetAttacked(true)
	end

	if self:GetAttacked() and self:GetAttackDelay() + 0.5 < CurTime() then
		self:SetAttacked(false)
		self:SetAttackDelay(0)
		self:ResetSequence("fall")
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Touch(ent)
	if self:GetAttacked() then return end
	if self:GetAttackDelay() > CurTime() then return end
	if self:GetNextAttack() > CurTime() then return end

	if nzombies and ent:IsPlayer() then return end
	if ent:Health() <= 0 then return end
	if not ent:IsSolid() then return end
	if ent:IsPlayer() and ent:Crouching() then return end

	local time = 1.5
	local rate = (5 / 30)

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) then
		time = ply:HasPerk("time") and 1 or 1.5
	end

	self:ResetSequence("swing")
	self:SetAttackDelay(CurTime() + rate)
	self:SetNextAttack(CurTime() + (time - rate))

	self:EmitSound("TFA_BO2_RAKETRAP.Slice")
	self:EmitSound("TFA_BO2_RAKETRAP.Swing")
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) then return end
	if nzombies and attacker:IsPlayer() then return end

	self:SetHealth(self:Health() - dmginfo:GetDamage())

	if self:Health() <= 0 then
		if IsValid(ply) then
			ply:EmitSound("TFA_BO2_SHIELD.Break")
		end
		self:SetDestroyed(true)
		self:Remove()
	end
end

function ENT:Use(ply)
	if CLIENT then return end
	if self:GetDestroyed() then return end
	if not IsValid(ply) then return end
	if not nzombies and ply ~= self:GetOwner() then return end
	if ply.NextTrapUse and ply.NextTrapUse > CurTime() then return end

	local own = self:GetOwner()
	if nzombies and IsValid(own) and own:IsPlayer() and ply ~= own and own:GetInfoNum("nz_buildable_sharing", 0) < 1 then return end

	if not ply:HasWeapon(self:GetTrapClass()) then
		ply.NextTrapUse = CurTime() + 0.25

		local wep = ply:Give(self:GetTrapClass())
		if IsValid(wep) then
			local hp = math.Clamp(self:Health() / self:GetMaxHealth(), 0, 1)
			wep:SetClip1(math.Round(hp * wep.Primary_TFA.ClipSize))
		end

		self:EmitSound("TFA_BO2_SHIELD.Pickup")
		self:Remove()
	end
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(ent:GetUp()*5000 - self:GetForward()*10000)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	if ent.NZBossType then
		damage:SetDamage(math.max(400, ent:GetMaxHealth() / 12))
	end

	if ent == ply then
		damage:SetDamage(20)
	end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		ParticleEffect("blood_impact_red_01", ent:WorldSpaceCenter() + (ent:OBBCenter() * .7), ent:GetForward():Angle())
		local rand = VectorRand(-12,12)
		rand = Vector(rand.x, rand.y, 1)
		util.Decal("Blood", ent:GetPos() - rand, ent:GetPos() + rand)
	end

	ent:TakeDamageInfo(damage)
	ent:EmitSound("TFA_BO3_GENERIC.Gib")
	self:EmitSound("TFA_BO2_RAKETRAP.Hit")
end