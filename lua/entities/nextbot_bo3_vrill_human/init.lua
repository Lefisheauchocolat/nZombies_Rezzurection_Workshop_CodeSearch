
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

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:OnKilled(ent, dmginfo)
	SafeRemoveEntity(self)
end

function ENT:Explode()
	self:StopSound("TFA_BO3_VR11.NBot.Scream")
	self:StopSound("TFA_BO3_VR11.Effect.Timer")

	local tr = {
		start = self:EyePos(),
		filter = {self, self:GetOwner()},
		mask = MASK_SOLID_BRUSHONLY
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self:GetUpgraded() and 220 or 160)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == self then continue end
			if v == self:GetOwner() then continue end
			if v:GetClass() == self:GetClass() then continue end
			if nzombies and v:IsPlayer() then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			self:InflictDamage(v)
		end
	end

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 4096)) do
		if v:IsNPC() and v:GetEnemy() == self then
			v:ClearSchedule()
			v:ClearEnemyMemory(v:GetEnemy())
			v:SetSchedule(SCHED_ALERT_STAND)
		end
	end
end

function ENT:InflictDamage(ent)
	if ent:GetClass() == self:GetClass() then return end

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(self:GetAttacker())
	damage:SetInflictor(self:GetInflictor())
	damage:SetDamageForce(ent:GetUp()*math.random(4000,8000) + (ent:GetPos() - self:GetPos()):GetNormalized()*12000)
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max(1600, ent:GetMaxHealth() / 12))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

