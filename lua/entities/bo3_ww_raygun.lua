
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
ENT.PrintName = "Raygun"

--[Sounds]--
ENT.ExplosionSound = "TFA_BO3_RAYGUN.Exp"
ENT.ExplosionSoundCl = "TFA_BO3_RAYGUN.ExpCl"

--[Parameters]--
ENT.Delay = 10
ENT.Range = 100
ENT.Impacted = false
ENT.ImpactEffect = "bo3_raygun_impact"

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Vector", 0, "HitPos")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end
	self.Impacted = true

	self:StopSound("TFA_BO3_RAYGUN.Loop")
	self:StopParticles()

	self:Explode(data.HitPos)
	self:SetHitPos(data.HitPos)

	self:EmitSound(self.ExplosionSound)
	self:EmitSound(self.ExplosionSoundCl)

	ParticleEffect(self.ImpactEffect, data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))

	self:Remove()
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	local ply = self:GetOwner()
	if ent == ply then return end
	if not pvp_bool:GetBool() and ent:IsPlayer() then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self:StopParticles()

		local data = self:GetTouchTrace()
		self:InflictDamage(ent, self:GetPos(), data.HitGroup, self:GetForward())
		self:Explode(data.HitPos)
		self:SetHitPos(self:GetPos())

		self:EmitSound(self.ExplosionSound)
		self:EmitSound(self.ExplosionSoundCl)

		ParticleEffect(self.ImpactEffect, self:GetPos(), data.HitNormal:Angle())

		self:Remove()
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	//self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:SetBuoyancyRatio(0)
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_raygun_trail_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.ImpactEffect = "bo3_raygun_impact_2"
		self.color = Color(255, 40, 20)
	else
		ParticleEffectAttach("bo3_raygun_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.ImpactEffect = "bo3_raygun_impact"
		self.color = Color(50, 235, 30)
	end

	self:EmitSoundNet("TFA_BO3_RAYGUN.Loop")
	self:EmitSoundNet("TFA_BO3_RAYGUN.Flux")
	self.killtime = CurTime() + self.Delay
	self.Damage = self.mydamage or self.Damage

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:StopSound("TFA_BO3_RAYGUN.Loop")
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode(pos)
	if not pos then
		pos = self:GetPos()
	end

	self:StopSound("TFA_BO3_RAYGUN.Loop")
	self.Damage = self.mydamage or self.Damage

	local ply = self:GetOwner()
	local tr = {
		start = pos,
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == self then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			local own = v:GetOwner()
			if IsValid(own) and (own == ply or (nzombies and own:IsPlayer())) then continue end
			if v:IsPlayer() and IsValid(ply) and v ~= ply and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			self:InflictDamage(v, tr1.Entity == v and tr1.HitPos or tr.endpos, nil, tr1.Normal)
		end
	end

	util.ScreenShake(pos, 5, 255, 1, 120)
	
	self:Remove()
end

function ENT:InflictDamage(ent, hitpos, hitgroup, norm)
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(ent:GetUp()*math.random(4000,8000) + (norm and norm*math.random(6000,9000) or (ent:GetPos() - self:GetPos()):GetNormalized()*6000))
	damage:SetDamageType(nzombies and DMG_BLAST or bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if ent == self:GetOwner() then
		local distfac = self:GetPos():Distance(ent:WorldSpaceCenter())
		distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
		damage:SetDamage(25*distfac)
	elseif hitpos then
		damage:SetDamagePosition(hitpos)
		local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
		if !headbone then headbone = ent:LookupBone("j_head") end
		if (headbone and ent:GetBonePosition(headbone):DistToSqr(hitpos) < 12^2) or (hitgroup and hitgroup == HITGROUP_HEAD) then
			damage:SetDamage(self.Damage*7)
			damage:SetDamagePosition(ent:GetBonePosition(headbone))
		end
	end

	if nzombies and (ent:IsPlayer() and ent ~= self:GetOwner()) then return end
	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	self:StopSound("TFA_BO3_RAYGUN.Loop")
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