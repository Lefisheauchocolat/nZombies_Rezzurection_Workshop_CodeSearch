
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
ENT.PrintName = "Zapgun"

--[Sounds]--

--[Parameters]--
ENT.Range = 20
ENT.Delay = 6

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Int", 0, "AttackType")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopParticles()
	self:EmitSound("TFA_BO3_ZAPGUN.Flux")
	self:SetHitPos(data.HitPos)

	if self:GetUpgraded() then
		ParticleEffect("bo3_zapgun_impact_pap", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	elseif self:GetAttackType() == 0 then
		ParticleEffect("bo3_zapgun_impact_left", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	else
		ParticleEffect("bo3_zapgun_impact_right", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	end

	util.ScreenShake(self:GetPos(), 5, 255, 0.5, 180)

	self:Remove()
end

function ENT:Touch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if nzombies and ent:IsPlayer() then return end
	if not pvp_bool:GetBool() and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end
	if ent:Health() <= 0 then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self.Impacted = true
		self:StopParticles()

		local data = self:GetTouchTrace()
		self:InflictDamage(ent, self:GetPos(), data.HitGroup, self:GetForward())
		self:SetHitPos(self:GetPos())
		ent:EmitSound("TFA_BO3_ZAPGUN.Flux")
		util.ScreenShake(self:GetPos(), 4, 255, 0.5, 180)

		if self:GetUpgraded() then
			ParticleEffect("bo3_zapgun_impact_pap", self:GetPos(), data.HitNormal:Angle())
		elseif self:GetAttackType() == 0 then
			ParticleEffect("bo3_zapgun_impact_left", self:GetPos(), data.HitNormal:Angle())
		else
			ParticleEffect("bo3_zapgun_impact_right", self:GetPos(), data.HitNormal:Angle())
		end

		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 4)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
	end

	self.killtime = CurTime() + self.Delay

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_zapgun_pap_beam",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self.color = Color(190, 125, 255)
	elseif self:GetAttackType() == 0 then
		ParticleEffectAttach("bo3_zapgun_left_beam",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self.color = Color(90, 90, 255)
	else
		ParticleEffectAttach("bo3_zapgun_right_beam",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self.color = Color(255, 90, 90)
	end

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos, hitgroup, norm)
	if ent == self:GetOwner() then return end
	if nzombies and ent:IsPlayer() then return end

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce(vector_up)
	damage:SetDamageType(DMG_SHOCK)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(400, ent:GetMaxHealth() / 24))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
	end

	if hitgroup and hitgroup == HITGROUP_HEAD then
		local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
		if !headbone then headbone = ent:LookupBone("j_head") end
		if headbone then
			damage:SetDamagePosition(ent:GetBonePosition(headbone))
		end

		ParticleEffect("blood_impact_red_01", hitpos, -norm)
		ent:EmitSound("TFA_BO3_WAFFE.Pop")
		ent:EmitSound("TFA_BO3_GENERIC.Gore")
	end

	if nzombies and ent:IsPlayer() then return end
	ent:TakeDamageInfo(damage)

	if ent:Health() <= 0 then
		ent:EmitSound("TFA_BO3_WAFFE.Death")
		ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
		ent:EmitSound("TFA_BO3_WAFFE.Zap")

		ParticleEffectAttach(self:GetUpgraded() and "bo3_waffe_electrocute_2" or "bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
		if ent:OnGround() then
			ParticleEffectAttach(self:GetUpgraded() and "bo3_waffe_ground_2" or "bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
		end
	end
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetHitPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 3
			dlight.Decay = 2000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.2
		end
	end
end