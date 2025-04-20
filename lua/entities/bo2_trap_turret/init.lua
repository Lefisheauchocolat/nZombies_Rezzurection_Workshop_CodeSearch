
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

	self:SetDestroyed(false)
	self:SetNextAttack(0)
	self:SetRapidFire(false)

	self:EmitSound("TFA_BO2_SHIELD.Plant")
	self:EmitSound("TFA_BO2_MOWER.Start")

	self.turbine_activate_wait = CurTime() + 1.6
	self.turbine_power_wait = CurTime() + math.random(8, 12)

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

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) then return end
	if nzombies and attacker:IsPlayer() then return end

	self:SetHealth(self:Health() - dmginfo:GetDamage())

	if self:Health() <= 0 then
		if IsValid(ply) then
			ply:EmitSound("TFA_BO2_SHIELD.Break")
		end

		self:EmitSound("TFA_BO2_MOWER.Stop")
		self:StopSound("TFA_BO2_MOWER.Loop")

		self:SetDestroyed(true)
		self:Remove()
	end
end

/*function ENT:InflictDamage(ent)
	local ply = self:GetOwner()

	local mydamage = 15
	if nzombies and ent:IsValidZombie() then
		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
		local health = tonumber(nzCurves.GenerateHealthCurve(round))
		local rand = math.random(6,12)

		mydamage = math.max(mydamage, health / rand)
	end

	local damage = DamageInfo()
	damage:SetDamage(mydamage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon() or self)
	damage:SetDamageForce(self:GetAttachment(1).Ang:Forward()*6500)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	if ent.NZBossType then
		local rand = math.random(30, 60)
		damage:SetDamage(math.max(mydamage, ent:GetMaxHealth() / rand))
	end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		ParticleEffect("blood_impact_red_01", ent:WorldSpaceCenter() + (ent:OBBCenter() * math.Rand(.1,.7) + VectorRand(-8, 8)), ent:GetForward():Angle())
		local rand = VectorRand(-21,21)
		rand = Vector(rand.x, rand.y, 1)
		util.Decal("Blood", ent:GetPos() - rand, ent:GetPos() + rand)
	end

	ent:TakeDamageInfo(damage)
	ent:EmitSound("TFA_BO3_GENERIC.Gib")
end*/

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

function ENT:TurretOn()
	if self:GetActivated() then return end
	self:SetActivated(true)
	self:SetNextAttack(CurTime() + 1)

	self:EmitSound("TFA_BO2_MOWER.Loop")
	ParticleEffectAttach("bo2_headchopper_leak", PATTACH_POINT_FOLLOW, self, 3)

	if nzombies then
		self:SetTargetPriority(TARGET_PRIORITY_NONE)
	end
end

function ENT:TurretOff()
	if not self:GetActivated() then return end
	self:SetActivated(false)

	self:EmitSound("TFA_BO2_MOWER.Stop")
	self:StopSound("TFA_BO2_MOWER.Loop")
	self:StopParticles()

	if nzombies then
		self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
	end
end
