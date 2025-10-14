
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
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)

	self:EmitSound("TFA_BO2_SHIELD.Plant")
	self:EmitSound("TFA_GHOSTS_TESLA.Arc")
	self:SetDestroyed(false)

	self.ActivateTime = CurTime() + 0.5
	self:SetNextAttack(0)
	self:SetActivated(false)

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

function ENT:Touch(ent)
	if not self:GetActivated() then return end
	if self:GetNextAttack() > CurTime() then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:Health() <= 0 then return end
	if not ent:IsSolid() then return end
	if ent:IsPlayer() and ent:Crouching() then return end

	self:InflictDamage(ent)
	self:TakeDamage(math.random(5)*5, ent, ent)

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) then
		local mult = ply:HasPerk("time") and 0.5 or 1
		self:SetNextAttack(CurTime() + self.AttackRateMin*mult)
	else
		self:SetNextAttack(CurTime() + self.AttackRateMin)
	end
end

function ENT:Think()
	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:SetHealth(1)
		self:TakeDamage(666, self, self)
		return false
	end

	if self:GetActivated() then
		if self:GetNextAttack() <= CurTime() then
			local tr = {
				start = self:GetAttachment(4).Pos,
				filter = self,
				mask = MASK_SOLID_BRUSHONLY,
			}

			for k, v in RandomPairs(ents.FindInSphere(self:GetPos(), self.Range)) do
				if v:IsNPC() or v:IsNextBot() then
					if v == self:GetOwner() then continue end
					if v:Health() <= 0 then continue end
					if v.Alive and not v:Alive() then continue end

					tr.endpos = v:EyePos()
					local tr1 = util.TraceLine(tr)
					if tr1.HitWorld then continue end

					self:InflictDamage(v)

					if nzombies then
						local mult = ply:HasPerk("time") and 0.5 or 1
						self:SetNextAttack(CurTime() + math.Rand(self.AttackRateMin*mult, self.AttackRateMax*mult))
					else
						self:SetNextAttack(CurTime() + math.Rand(self.AttackRateMin, self.AttackRateMax))
					end
					self:TakeDamage(math.random(5)*5, v, v)
					break
				end
			end
		end

		if self.NextArcSound and self.NextArcSound <= CurTime() then
			self:EmitSound("TFA_GHOSTS_TESLA.Arc")
			self.NextArcSound = CurTime() + math.Rand(2,4.5)
		end
	end

	if !self:GetActivated() and self.ActivateTime and self.ActivateTime <= CurTime() then
		self:SetActivated(true)
		self:SetNextAttack(CurTime() + self.AttackRateMin)
		self.ActivateTime = nil
		self.NextArcSound = CurTime() + math.Rand(0.5,1.5)

		self:EmitSound("TFA_GHOSTS_TESLA.Loop")
		self:EmitSound("TFA_GHOSTS_TESLA.Arc")

		ParticleEffectAttach("ghosts_teslatrap", PATTACH_POINT_FOLLOW, self, 1)
		ParticleEffectAttach("ghosts_teslatrap", PATTACH_POINT_FOLLOW, self, 2)
		ParticleEffectAttach("ghosts_teslatrap", PATTACH_POINT_FOLLOW, self, 3)
	end

	self:NextThink(CurTime())
	return true
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
		self:StopSound("TFA_GHOSTS_TESLA.Loop")
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
	damage:SetDamageForce(ent:GetUp())
	damage:SetDamagePosition(ent:WorldSpaceCenter() + ent:OBBCenter()*math.Rand(0.2,0.6))
	damage:SetDamageType(DMG_SHOCK)

	if ent == ply then
		damage:SetDamage(20)
	else
		if ent:IsPlayer() or ent:IsNextBot() or ent:IsNPC() then
			util.ParticleTracerEx("bo3_waffe_jump", self:GetAttachment(math.random(3)).Pos, ent:EyePos(), false, ply:EntIndex(), 0)

			if nzombies and (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss")) then
				damage:SetDamage(math.max(240, ent:GetMaxHealth()/16))
			else
				ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
			end

			if ent:OnGround() then
				ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
			end

			ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
			ent:EmitSound("TFA_GHOSTS_TESLA.Explode")
		end
	end

	ent:TakeDamageInfo(damage)
	self:EmitSound("TFA_GHOSTS_TESLA.Zap")
end
