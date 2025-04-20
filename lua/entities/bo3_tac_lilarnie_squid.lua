
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
ENT.PrintName = "Arnie"

--[Parameters]--
ENT.Delay = 12
ENT.DelayPAP = 18
ENT.color = Color(140, 255, 100)

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Dying")
	self:NetworkVar("Float", 0, "NextScream")
end

function ENT:PhysicsCollide(data, phys)
end

function ENT:StartTouch(ent)
	if ent == self:GetOwner() then return end
	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		ent:EmitSound("TFA_BO3_ARNIE.ZombieDie")
		local data = self:GetTouchTrace()
		self:InflictDamage(ent, data.HitPos, data.Normal)
	end
end

function ENT:Initialize(...)
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel(self.DefaultModel)
	end

	self:SetMoveType(MOVETYPE_NONE)
	self:PhysicsInit(SOLID_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	self.AutomaticFrameAdvance = true
	self:DrawShadow(true)

	self:ResetSequence("start")
	timer.Simple(self:SequenceDuration("start"), function() 
		if IsValid(self) then
			if self:GetUpgraded() then
				ParticleEffectAttach("bo3_lilarnie_loop_2",PATTACH_ABSORIGIN_FOLLOW,self,0)
				ParticleEffectAttach("bo3_lilarnie_puddle_2",PATTACH_ABSORIGIN_FOLLOW,self,0)
			else
				ParticleEffectAttach("bo3_lilarnie_loop",PATTACH_ABSORIGIN_FOLLOW,self,0)
				ParticleEffectAttach("bo3_lilarnie_puddle",PATTACH_ABSORIGIN_FOLLOW,self,0)
			end
			self:ResetSequence("loop")
		end
	end)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	if self:GetUpgraded() then
		ParticleEffect("bo3_lilarnie_start_2", self:GetPos(), Angle(0,0,0))
		self.killtime = CurTime() + self.DelayPAP
		self.color = Color(100, 10, 170)
	else
		ParticleEffect("bo3_lilarnie_start", self:GetPos(), Angle(0,0,0))
		self.killtime = CurTime() + self.Delay
		self.color = Color(140, 255, 100)
	end
	
	self:EmitSoundNet("TFA_BO3_ARNIE.AcidSizzle")
	self:EmitSoundNet("TFA_BO3_ARNIE.OctoExpl")

	self:EmitSoundNet("TFA_BO3_ARNIE.Loop")
	self:EmitSoundNet("TFA_BO3_ARNIE.OctoFlail")

	self:SetNextScream(CurTime() + math.Rand(2, 3.5))

	if CLIENT then return end
	self:SetTrigger(true)
	self:DropToFloor()
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos() + Vector(0,0,4)
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 1
			dlight.Decay = 2000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 0.1
		end
	end

	if self:GetNextScream() < CurTime() and not self:GetDying() then
		self:EmitSound("TFA_BO3_ARNIE.AttackVox")
		self:SetNextScream(CurTime() + math.Rand(3, 5))
	end

	if SERVER then
		self:MonkeyBombNXB()
		self:MonkeyBomb()

		if self.killtime < CurTime() and not self:GetDying() then
			self:SetDying(true)

			self:StopSound("TFA_BO3_ARNIE.Loop")
			self:StopSound("TFA_BO3_ARNIE.OctoFlail")

			self:EmitSound("TFA_BO3_ARNIE.DeathThroes")
			self:EmitSound("TFA_BO3_ARNIE.DeathVox")

			self:ResetSequence("end")
			SafeRemoveEntityDelayed(self, self:SequenceDuration("end")-0.5)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos, norm)
	if CLIENT then return end

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_RADIATION)
	damage:SetDamageForce((norm and norm*15000 or ent:GetForward()*-15000) + ent:GetUp()*22000)
	damage:SetDamagePosition(hitpos or ent:WorldSpaceCenter())

	ent:SetNW2Bool("OctoBombed", true)
	ent:SetHealth(1)
	ent:TakeDamageInfo(damage)
end

function ENT:Explode()
	self:StopSound("TFA_BO3_ARNIE.Loop")
	self:StopSound("TFA_BO3_ARNIE.OctoFlail")

	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
		if v:IsNPC() or v:IsPlayer() or v:IsNextBot() then
			if v == ply then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			self:InflictDamage(v, tr1.Entity == v and tr1.HitPos or v:WorldSpaceCenter())
		end
	end
end

function ENT:MonkeyBomb()
	if CLIENT then return end
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2048)) do
		if v == self:GetOwner() then continue end
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
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2048)) do
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

function ENT:OnRemove()
	self:StopParticles()
	if SERVER then
		self:Explode()

		for k, v in pairs(ents.FindInSphere(self:GetPos(), 4096)) do
			if v:IsNPC() and v:GetEnemy() == self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())

				v:SetSchedule(SCHED_ALERT_STAND)
			end
		end
	end

	if self:GetUpgraded() then
		ParticleEffect("bo3_lilarnie_start_2", self:GetPos(), Angle(0,0,0))
	else
		ParticleEffect("bo3_lilarnie_start", self:GetPos(), Angle(0,0,0))
	end

	self:EmitSound("TFA_BO3_ARNIE.OctoEnd")
	self:EmitSound("TFA_BO3_ARNIE.AcidSizzle")

	self:StopSound("TFA_BO3_ARNIE.Loop")
	self:StopSound("TFA_BO3_ARNIE.OctoFlail")
end
