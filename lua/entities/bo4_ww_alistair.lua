
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
ENT.PrintName = "Transfur Goo"

--[Sounds]--
ENT.ExplosionSound = "TFA_BO4_ALISTAIR.Impact"
ENT.ExplosionSoundUpg = "TFA_BO4_ALISTAIR.Impact.Charged"

--[Parameters]--
ENT.Delay = 10

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "Upgrade")
end

function ENT:PhysicsCollide(data, phys)
	if self.Impacted then return end

	self:StopParticles()
	self:Explode()
	self:Remove()
	
	if self:GetUpgrade() == 0 then
		ParticleEffect("bo4_alistairs_impact", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	elseif self:GetUpgrade() == 1 then
		ParticleEffect("bo4_alistairs_impact_2", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	elseif self:GetUpgrade() == 2 then
		ParticleEffect("bo4_alistairs_impact_3", data.HitPos, data.HitNormal:Angle() - Angle(90,0,0))
	end

	util.Decal("Dark", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)
	self.Impacted = true
end

function ENT:StartTouch(ent)
	if self.Impacted then return end
	if ent == self:GetOwner() then return end
	if not ent:IsSolid() then return end
	if nzombies and ent:IsPlayer() then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		self:StopParticles()
		self:Explode()
		self:Remove()

		if self:GetUpgrade() == 0 then
			ParticleEffect("bo4_alistairs_impact", self:GetPos(), self:GetUp():Angle())
		elseif self:GetUpgrade() == 1 then
			ParticleEffect("bo4_alistairs_impact_2", self:GetPos(), self:GetUp():Angle())
		elseif self:GetUpgrade() == 2 then
			ParticleEffect("bo4_alistairs_impact_3", self:GetPos(), self:GetUp():Angle())
		end

		self.Impacted = true
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 6)

	if self:GetUpgrade() == 0 then
		ParticleEffectAttach("bo4_alistairs_trail_base",PATTACH_ABSORIGIN_FOLLOW,self,0)
	elseif self:GetUpgrade() == 1 then
		ParticleEffectAttach("bo4_alistairs_trail_base_2",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self.ExplosionSound = self.ExplosionSoundUpg
	elseif self:GetUpgrade() == 2 then
		ParticleEffectAttach("bo4_alistairs_trail_base_3",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self.ExplosionSound = self.ExplosionSoundUpg
	end
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if self:WaterLevel() > 0 then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode()
	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SOLID_BRUSHONLY
	}

	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 100)) do
		if not v:IsWorld() and v:IsSolid() then
			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			if nzombies and v:IsPlayer() then continue end
			if v == ply then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			damage:SetDamageForce(v:GetUp()*10000 + (v:GetPos() - self:GetPos()):GetNormalized() * 8000)
			damage:SetDamagePosition(v:WorldSpaceCenter())

			if v:IsNPC() then v:SetSchedule(SCHED_ALERT_STAND) end
			v:TakeDamageInfo(damage)
		end
	end
	
	self:EmitSound(self.ExplosionSound)
	self:Remove()
end
