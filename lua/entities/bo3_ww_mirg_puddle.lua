
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
ENT.PrintName = "Blob"

--[Sounds]--
ENT.ExplosionSound = "TFA_BO3_MIRG.Explode"
ENT.SporeGrowSound = "TFA_BO3_MIRG.Spore.Grow"
ENT.SporeExplSound = "TFA_BO3_MIRG.Spore.Explode"

--[Parameters]--
ENT.Delay = 3
ENT.DelayUpg = 5

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
	self:NetworkVar( "Bool", 1, "LitFam")
	self:NetworkVar( "Int", 0, "Charge")
end

function ENT:PhysicsCollide(data, phys)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	if self:GetUpgraded() then
		ParticleEffectAttach( "bo3_mirg2k_puddle_2", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
	else
		ParticleEffectAttach( "bo3_mirg2k_puddle", PATTACH_ABSORIGIN_FOLLOW, self, 0 )
	end

	self.CoolDown = CurTime()

	self:EmitSoundNet("TFA_BO3_MIRG.Slime")
	if self:GetUpgraded() then
		self.killtime = CurTime() + (self.DelayUpg * self:GetCharge())
		self.AtkDelay = 0.2
	else
		self.killtime = CurTime() + (self.Delay * self:GetCharge())
		self.AtkDelay = 0.4
	end

	local tr1 = util.TraceLine({
		start = self:WorldSpaceCenter(),
		endpos = self:WorldSpaceCenter() - Vector(0, 0, 1024),
		filter = {self},
		mask = MASK_SOLID_BRUSHONLY,
	})

	self:SetLitFam(math.random(100) >= 60)
	self:SetPos(tr1.HitPos + Vector(0,0,2))
	self:SetAngles(tr1.HitNormal:Angle() + Angle(90,0,0))

	if CLIENT then return end
	self:SetTrigger(true)
	if self:WaterLevel() > 1 then
		SafeRemoveEntity(self)
		return
	end
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		if self:GetUpgraded() then
			color = Color(0, 255, 230, 255)
		else
			color = Color(65, 255, 20, 255)
		end
		
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight and self:GetLitFam() then
			dlight.pos = self:GetPos()
			dlight.r = color.r
			dlight.g = color.g
			dlight.b = color.b
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 128
			dlight.dietime = CurTime() + 0.5
		end
	end
	if SERVER then
		if self.killtime < CurTime() then
			self:StopSound("TFA_BO3_MIRG.Slime")
			self:StopParticles()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:StartTouch(ent)
	if (ent:IsNPC() or ent:IsNextBot()) and self.CoolDown < CurTime() then
		if not ent:BO3IsSpored() and ent:Health() > 0 then
			if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then return end
			local ply = self:GetOwner()
			if not IsValid(ply) then return end

			if nzombies and nzPowerUps:IsPowerupActive("insta") then
				ent:BO3Spore(0.5, self:GetOwner(), self.Inflictor, self:GetUpgraded())
			else
				ent:BO3Spore(math.Rand(1,2), self:GetOwner(), self.Inflictor, self:GetUpgraded())
			end

			if ply:IsPlayer() then
				if not ply.mirg2kachievmentKills then ply.mirg2kachievmentKills = 0 end
				ply.mirg2kachievmentKills = ply.mirg2kachievmentKills + 1

				if ply.mirg2kachievmentKills == 10 and not ply.bo3kt4achievment then
					TFA.BO3GiveAchievement("Crop Duster", "vgui/overlay/achievment/mirg2000.png", ply)
					ply.bo3kt4achievment = true
				end
			end

			self.CoolDown = CurTime() + self.AtkDelay + math.Rand(-0.1,0.1)
		end
	end
end

function ENT:OnRemove()
	self:StopSound("TFA_BO3_MIRG.Slime")
end