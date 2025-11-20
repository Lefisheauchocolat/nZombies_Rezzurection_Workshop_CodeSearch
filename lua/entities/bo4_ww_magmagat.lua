
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
ENT.PrintName = "Magma Blob"

--[Sound]--
ENT.PropelSound = Sound("TFA_BO4_BLUNDER.Magma.Loop")

--[Parameters]--
ENT.Delay = 10
ENT.Life = 7
ENT.LifeImpact = 1.5
ENT.Range = 100
ENT.BlastRange = 180

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	self:StopParticles()

	timer.Simple(0, function()
		if not self:IsValid() then return end
		self:SetAngles(data.HitNormal:Angle() + Angle(-90,0,0))
		self:SetPos(data.HitPos)
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	if nzombies then
		self:MonkeyBombNZ()
	else
		self:MonkeyBomb()
	end

	self.killtime = CurTime() + self.Life

	if data.HitNormal:Dot(Vector(0,0,-1))<0.9 then
		ParticleEffect("bo4_magmagat_puddle_billboard", data.HitPos - data.HitNormal, data.HitNormal:Angle() + Angle(-90,0,0), self)
	else
		ParticleEffect("bo4_magmagat_puddle", data.HitPos- data.HitNormal, data.HitNormal:Angle() + Angle(-90,0,0), self)
	end
end

function ENT:StartTouch(ent)
	if self:GetActivated() then return end

	local ply = self:GetOwner()
	if ent == ply then return end
	if not ent:IsSolid() then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end
	if nzombies and !(ent:IsNPC() or ent:IsNextBot()) then return end

	self:SetActivated(true)

	self:SetParent(ent)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	ent:Ignite(self.LifeImpact)
	ent:SetNW2Bool("OnAcid", true)
	if not ent:IsPlayer() and ent.Freeze then
		ent:Freeze(self.LifeImpact)
	end

	self.killtime = CurTime() + self.LifeImpact
	self.Impacted = true

	if nzombies and IsValid(ply) and ent:IsValidZombie() then
		ply:GivePoints(10)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 4)

	ParticleEffectAttach("bo4_magmagat_trail", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self:EmitSoundNet(self.PropelSound)
	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	local pos = self:GetPos()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = pos
			dlight.r = 255
			dlight.g = 45
			dlight.b = 0
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 200
			dlight.dietime = CurTime() + 0.2
		end
	end

	if SERVER then
		local ply = self:GetOwner()

		if self.killtime < CurTime() then
			self:StopSound(self.PropelSound)
			self:StopParticles()

			ParticleEffect("bo4_magmagat_explode", pos, Angle(-90,0,0))

			if IsValid(self:GetParent()) then
				self:Explode()
			end

			self:EmitSound("TFA_BO4_BLUNDER.Magma.End")
			self:Remove()
			return false
		end

		if not nzombies and self:GetActivated() and not IsValid(self:GetParent()) then
			self:MonkeyBomb()
			self:MonkeyBombNXB()
		end

		if self:GetActivated() and not IsValid(self:GetParent()) then
			for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
				if v:IsNPC() or v:IsNextBot() or v:IsPlayer() then
					if v:BO4IsMagmaIgnited() then continue end

					if v == self:GetOwner() then
						if pos:DistToSqr(v:GetPos()) < 32^2 then
							self:GetOwner():Ignite(engine.TickInterval())
						end
						continue
					end

					if nzombies and v:IsPlayer() then continue end
					if v:Health() <= 0 then continue end
					if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

					v:BO4Magma(math.Rand(1,2), self:GetOwner(), self.Inflictor, self.mydamage)
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:MonkeyBombNZ()
	if CLIENT then return end
	self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
	//UpdateAllZombieTargets(self)
end

function ENT:MonkeyBomb()
	if CLIENT then return end

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 1024)) do
		if v == ply then continue end
		if IsValid(ply) and ply:IsNPC() and ply:Disposition(v) == D_LI then continue end

		if IsValid(v) and v:IsNPC() then
			if v:GetEnemy() ~= self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())

				v:SetEnemy(self)
			end

			v:UpdateEnemyMemory(self, self:GetPos())
			v:SetSaveValue("m_vecLastPosition", self:GetPos())
			v:SetSchedule(SCHED_FORCED_GO_RUN)
		end
	end
end

function ENT:MonkeyBombNXB()
	if CLIENT then return end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 512)) do
		if v == self:GetOwner() then continue end
		if IsValid(v) and v:IsNextBot() then
			v.loco:FaceTowards(self:GetPos())
			v.loco:Approach(self:GetPos(), 99)
			if v.SetEnemy then
				v:SetEnemy(self)
			end
		end
	end
end

function ENT:Explode()
	local ent = self:GetParent()

	self.Damage = self.mydamage or self.Damage
	local damage = DamageInfo()
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageType(bit.bor(DMG_REMOVENORAGDOLL, DMG_ALWAYSGIB))
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(vector_up)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.BlastRange)) do
		if v:IsNPC() or v:IsNextBot() then
			if v == self:GetOwner() then continue end
			if nzombies and v.NZBossType then continue end
			if v:BO4IsMagmaIgnited() then continue end

			v:BO4Magma(math.Rand(1.5,3), self:GetOwner(), self.Inflictor, self.Damage)
		end
	end

	self:EmitSound("TFA_BO4_BLUNDER.Magma.Explode")
	self:EmitSound("TFA_BO4_BLUNDER.Magma.Explode.Swt")
	ParticleEffect("bo4_magmagat_explode", ent:WorldSpaceCenter(), Angle(0,0,0))

	ent:TakeDamageInfo(damage)
	self:Remove()
end

function ENT:OnRemove()
	self:StopSound(self.PropelSound)
	local p = self:GetParent()
	if IsValid(p) and p:GetNW2Bool("OnAcid") then
		p:SetNW2Bool("OnAcid", false)
	end
end
