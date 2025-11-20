
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
ENT.PrintName = "Keeper Sword"

--[Parameters]--
ENT.Delay = 25

ENT.Kills = 0
ENT.MaxKills = 24

ENT.Range = 160
ENT.RPM = 120

DEFINE_BASECLASS( ENT.Base )

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")

	self:NetworkVar("Float", 0, "NextPrimaryFire")

	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Entity", 1, "Attacker")
	self:NetworkVar("Entity", 2, "Inflictor")
end

function ENT:Touch(ent)
	local ply = self:GetOwner()
	if ent == ply and not self:GetActivated() then
		self:StopSound("TFA_BO3_KPRSWORD.Loop")
		ent:EmitSound("TFA_BO3_KPRSWORD.Return")

		if not nzombies then
			local wep = ent:GetWeapon("tfa_bo3_keepersword")
			if IsValid(wep) then
				wep:SetHasNuked(false)
			end
		end

		SafeRemoveEntity(self)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self,...)

	self:EmitSoundNet("TFA_BO3_KPRSWORD.Loop")

	self.Ratio = engine.TickInterval()*5
	self.AutomaticFrameAdvance = true
	self.TargetsToIgnore = {}
	self:SetActivated(true)
	self:SetTarget(nil)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:UseTriggerBounds(true, 2)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:SetBuoyancyRatio(0)
	end

	ParticleEffectAttach("bo3_keepersword_trail", PATTACH_POINT_FOLLOW, self, 2)

	self.killtime = CurTime() + self.Delay
	self:ResetSequence("idle")

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	local ply = self:GetOwner()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 50
			dlight.b = 10
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 128
			dlight.dietime = CurTime() + 0.1
		end
	end

	if SERVER then
		if IsValid(self:GetTarget()) and self:GetNextPrimaryFire() < CurTime() then
			if self:GetSequence() ~= self:SelectWeightedSequence(ACT_WALK) then
				self:ResetSequence("locomote")
			end

			local normalized = (self:GetTarget():EyePos() - self:GetPos()):GetNormalized()

			self:SetPos(LerpVector(self.Ratio, self:GetPos(), self:GetTarget():EyePos() + normalized*4))
			self:SetAngles(LerpAngle(self.Ratio, self:GetAngles(), normalized:Angle()))
		end

		if self:GetActivated() and not IsValid(self:GetTarget()) and self:GetNextPrimaryFire() < CurTime() then
			if self:GetSequence() ~= self:SelectWeightedSequence(ACT_IDLE) then
				self:ResetSequence("idle")
			end

			self:SetTarget(self:FindNearestEntity(self:GetPos(), 256, self.TargetsToIgnore))

			if IsValid(ply) and ply:Alive() then
				local forward = Angle(0, ply:EyeAngles()[2], ply:EyeAngles()[3]):Forward()
				local finalpos = ply:GetShootPos() + self:GetRight()*30 + forward*40
				self:SetPos(LerpVector(self.Ratio, self:GetPos(), finalpos))

				local finalang = Angle(0, ply:GetAimVector():Angle()[2], 0)
				self:SetAngles(LerpAngle(self.Ratio, self:GetAngles(), finalang))
			end
		end

		if not self:GetActivated() and not IsValid(self:GetTarget()) then
			if IsValid(ply) then
				if ply:Alive() then
					self:SetPos(LerpVector(0.1, self:GetPos(), ply:GetShootPos()))
					self:SetAngles(LerpAngle(0.1, self:GetAngles(), -ply:GetForward():Angle()))
				else
					self:StopSound("TFA_BO3_KPRSWORD.Loop")
					SafeRemoveEntity(self)
				end
			end
		end

		if self:GetActivated() then
			for _, v in pairs(ents.FindInSphere(self:GetPos(), 12)) do
				if v:IsNPC() or v:IsNextBot() or (pvp_bool:GetBool() and v:IsPlayer()) then
					if nzombies and v:IsPlayer() then return end
					if v == ply then return end
					if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then return end
					if v:Health() <= 0 then continue end

					self:InflictDamage(v)
				end
			end
		end

		if self.killtime < CurTime() and self:GetActivated() then
			self:SetActivated(false)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent)
	if not IsValid(ent) then return end

	self.Kills = self.Kills + 1
	self.TargetsToIgnore[self.Kills] = ent
	if self.Kills >= self.MaxKills then
		self:SetActivated(false)
	end

	local damage = DamageInfo()
	damage:SetDamagePosition(ent:EyePos())
	damage:SetDamageType(bit.bor(DMG_SLOWBURN, DMG_SLASH))
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamage(ent:Health() + 666)

	local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !headbone then headbone = ent:LookupBone("j_head") end
	if headbone then
		damage:SetDamagePosition(ent:GetBonePosition(headbone))
	end

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(1200, ent:GetMaxHealth() / 8))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
	end

	ent:Ignite(1.5)
	if ent:IsNPC() then
		ent:SetHealth(1)
	end
	ent:TakeDamageInfo(damage)

	ParticleEffect("bo3_keepersword_hit", ent:EyePos(), Angle(0,0,0))
	self:EmitSound("TFA_BO3_ZODSWORD.Impact")

	if IsValid(self:GetTarget()) then
		self:SetAngles(-self:GetTarget():GetForward():Angle())
	end

	self:SetNextPrimaryFire(CurTime() + (60 / self.RPM))

	local EnumToSeq = self:SelectWeightedSequence(ACT_RESET)
	self:ResetSequence(EnumToSeq)

	local pos = IsValid(ply) and ply:GetPos() or self:GetPos()
	self:SetTarget(self:FindNearestEntity(pos, self.Range, self.TargetsToIgnore))
end

function ENT:FindNearestEntity(pos, range, ent)
	local nearestEnt;

	local ply = self:GetOwner()
	for _, v in pairs(ents.FindInSphere(pos, range)) do
		if v:IsNPC() or v:IsNextBot() or (pvp_bool:GetBool() and v:IsPlayer()) then
			if v == ply then continue end
			if v:Health() <= 0 then continue end
			if nzombies and v:IsPlayer() then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			if !table.HasValue(ent, v) then
				nearestEnt = v;
				range = distance;
			end
		end
	end

	return nearestEnt;
end

function ENT:OnRemove()
	self:StopSound("TFA_BO3_KPRSWORD.Loop")
end
