
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

	self.AutomaticFrameAdvance = true
	self:SetDestroyed(false)

	self:EmitSound("TFA_BO2_SHIELD.Plant")

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) then
		self:SetNextAttack(CurTime() + (ply:HasPerk("time") and 1.2 or 8))
		self:SequenceThenIdle(ply:HasPerk("time") and "reset_zombie" or "reset")
		if ply:HasPerk('time') then
			self:EmitSound("TFA_BO2_FLINGER.Ready")
		end
	else
		self:SetNextAttack(CurTime() + 8)
		self:SequenceThenIdle("reset")
	end

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
	if self:GetDestroyed() then return end
	if self:GetNextAttack() > CurTime() then return end
	if not ent:IsPlayer() then return end
	if ent:Crouching() then return end

	ent:Fire("ignorefalldamage","",0)
	ent:SetGroundEntity(nil)
	ent:SetLocalVelocity(self:GetForward()*450 + Vector(0,0,400))
	for k, v in pairs(ents.FindInSphere(self:WorldSpaceCenter(), 45)) do
		if (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 then
			self:InflictDamage(v)
			self:TakeDamage(math.random(5)*5, v, v)
		end
	end

	local timetraveler = false
	if nzombies and ent:HasPerk('time') then
		timetraveler = true
	end

	self:ResetSequence("launch")
	timer.Simple(self:SequenceDuration(), function()
		if not IsValid(self) or not IsValid(ent) then return end
		if nzombies then
			self:SequenceThenIdle(timetraveler and "reset_zombie" or "reset")
			self:EmitSound("TFA_BO2_FLINGER.Ready")
		else
			self:SequenceThenIdle("reset")
		end
	end)

	self:TakeDamage(20, self)
	self:EmitSound("TFA_BO2_FLINGER.Shoot")

	if nzombies then
		self:SetNextAttack(CurTime() + (timetraveler and 1.4 or 8))
	else
		self:SetNextAttack(CurTime() + 8)
	end
end

function ENT:StartTouch(ent)
	if self:GetDestroyed() then return end
	if self:GetNextAttack() > CurTime() then return end
	if ent:IsPlayer() then return end
	if ent:Health() <= 0 then return end
	if not ent:IsSolid() then return end

	for k, v in pairs(ents.FindInSphere(self:WorldSpaceCenter(), 45)) do
		if (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 then
			self:InflictDamage(v)
			self:TakeDamage(math.random(5)*5, v, v)
		end
	end

	self:EmitSound("TFA_BO2_FLINGER.Shoot")
	self:SetNextAttack(CurTime() + 1)

	self:ResetSequence("launch")
	timer.Simple(self:SequenceDuration(), function()
		if not IsValid(self) then return end
		self:SequenceThenIdle("reset_zombie")
	end)
end

function ENT:Think()
	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:SetHealth(1)
		self:TakeDamage(666, self, self)
		return false
	end

	self:NextThink(CurTime())
	return true
end

function ENT:SequenceThenIdle(seq)
	self:StopParticles()
	self:ResetSequence(seq)
	ParticleEffectAttach("bo2_flinger_leak", PATTACH_POINT_FOLLOW, self, 2)
	timer.Simple(self:SequenceDuration(), function() 
		if not IsValid(self) then return end
		self:StopSound("TFA_BO2_FLINGER.Reset")
		self:ResetSequence("idle")
	end)
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

		self:StopSound("TFA_BO2_FLINGER.Reset")
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
	damage:SetDamageForce(self:GetForward()*40000 + ent:GetUp()*20000)
	damage:SetDamagePosition(ent:EyePos())
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	if ent.NZBossType then
		damage:SetDamage(math.max(1000, ent:GetMaxHealth() / 10))
	end

	ent:TakeDamageInfo(damage)

	if (ent:IsNPC() or ent:IsNextBot()) and IsValid(ply) and ply:IsPlayer() then
		if not self.Kills then self.Kills = 0 end

		self.Kills = self.Kills + 1
		if self.Kills == 10 then
			if not ply.bo2flingerachievment then
				TFA.BO3GiveAchievement("Vertigoner", "vgui/overlay/achievment/Vertigoner.png", ply)
				ply.bo2flingerachievment = true
			end
		end
	end
end

