
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
ENT.PrintName = "Black Hole"

ENT.LoopSound = "TFA_BO3_GKZMK3.Orb.Loop2"

--[Parameters]--
ENT.Life = 3.5
ENT.Range = 200

DEFINE_BASECLASS( ENT.Base )

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
	self:NetworkVar( "Bool", 1, "Activated")
end

function ENT:PhysicsCollide(data, phys)
end

function ENT:StartTouch(ent)
	local ply = self:GetOwner()
	if ent == ply then return end
	if ent:Health() <= 0 then return end
	if nzombies and ent:IsPlayer() then return end
	if ent:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", ent, ply) then return end

	if ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer() then
		local data = self:GetTouchTrace()
		self:InflictDamage(ent, data.HitPos, data.Normal)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:EmitSoundNet(self.LoopSound)

	local mins = Vector(-89, -89, -89)
	local maxs = Vector(89, 89, 89)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionBounds(mins, maxs)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	ParticleEffectAttach("bo3_gkz_bh_loop",PATTACH_ABSORIGIN_FOLLOW, self, 0)

	self.killtime = CurTime() + self.Life

	self:SetActivated(true)

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = 185
			dlight.g = 70
			dlight.b = 255
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 256 + 128
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		util.ScreenShake(self:GetPos(), 7, 255, 0.1, 210)

		if self.killtime < CurTime() then
			self:Explode()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent, hitpos, norm)
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(norm and norm*6000 or (ent:GetPos() - self:GetPos()):GetNormalized() * 6000)
	damage:SetDamagePosition(hitpos or ent:WorldSpaceCenter())
	damage:SetDamageType(DMG_DISSOLVE)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(800, ent:GetMaxHealth() / 12))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
	end

	ent:EmitSound("TFA_BO3_GKZMK3.Orb.Damage")
	ent:TakeDamageInfo(damage)
end

function ENT:Explode()
	self:StopSound(self.LoopSound)
	self:EmitSound("TFA_BO3_GKZMK3.Orb.End")

	local ply = self:GetOwner()
	local pos = self:GetPos()
	local tr = {
		start = pos,
		filter = self,
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if v:IsNPC() or v:IsNextBot() then
			if v == self:GetOwner() then continue end
			if v:Health() < 0 then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			self:InflictDamage(v, tr1.Entity == v and tr1.HitPos or v:WorldSpaceCenter())
		end
	end

	util.ScreenShake(pos, 10, 255, 1, 512)
	ParticleEffect("bo3_gkz_bh_explode", pos, Angle(0,0,0))

	self:Remove()
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = 185
			dlight.g = 70
			dlight.b = 255
			dlight.brightness = 4
			dlight.Decay = 2000
			dlight.Size = 512
			dlight.DieTime = CurTime() + 0.5
		end
	end

	self:StopSound(self.LoopSound)
end
