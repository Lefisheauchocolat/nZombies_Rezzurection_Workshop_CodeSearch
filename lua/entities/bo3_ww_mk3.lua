
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
ENT.PrintName = "Raygun Mk3"

--[Sounds]--
ENT.ExplosionSound = "TFA_BO3_MK2.Impact"

--[Parameters]--
ENT.Delay = 10

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopParticles()
	self:EmitSound(self.ExplosionSound)
	self:SetHitPos(data.HitPos)

	if self:GetUpgraded() then
		ParticleEffect("bo3_mk3_impact_2", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	else
		ParticleEffect("bo3_mk3_impact", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	end

	local ent = data.HitEntity
	if not ent:IsWorld() and ent:IsSolid() then
		self:InflictDamage(ent, data.HitPos)
	end

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		local data = self:GetTouchTrace()
		self:InflictDamage(ent, self:GetPos(), data.HitGroup, self:GetForward())
		self:EmitSound(self.ExplosionSound)

		if self:GetUpgraded() then
			ParticleEffect("bo3_mk3_hitzomb_2", self:GetPos(), data.HitNormal:Angle())
		else
			ParticleEffect("bo3_mk3_hitzomb", self:GetPos(), data.HitNormal:Angle())
		end
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 6)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
	end

	self.killtime = CurTime() + self.Delay
	self.Damage = self.mydamage or self.Damage

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_mk2_trail_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(255, 40, 10)
	else
		ParticleEffectAttach("bo3_mk2_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(90, 255, 10)
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
	self.Damage = self.mydamage or self.Damage

	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(ent:GetUp()*4000 + (norm and norm*8000 or self:GetForward()*8000))
	damage:SetDamageType(bit.bor(DMG_ENERGYBEAM, DMG_AIRBOAT))
	damage:SetDamagePosition(hitpos)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:ScaleDamage(math.Round(nzRound:GetNumber()/10, 1))
	end

	local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !headbone then headbone = ent:LookupBone("j_head") end
	if (headbone and ent:GetBonePosition(headbone):DistToSqr(hitpos) < 8^2) or (hitgroup and hitgroup == HITGROUP_HEAD) then
		damage:SetDamage(self.Damage*4)
		damage:SetDamagePosition(ent:GetBonePosition(headbone))
	end

	if nzombies and ent:IsPlayer() then return end
	ent:TakeDamageInfo(damage)
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
			dlight.Size = 128
			dlight.DieTime = CurTime() + 0.2
		end
	end
end