
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
ENT.PrintName = "Void"

ENT.LoopSound = "TFA_BO4_ALISTAIR.Charged.ShrinkLoop"

--[Parameters]--
ENT.Delay = 10
ENT.Life = 7
ENT.Range = 120
ENT.NextAttack = 0

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	self:StopParticles()
	self:EmitSound(self.LoopSound)
	self:SetAngles(data.HitNormal:Angle())

	ParticleEffect("bo4_alistairs_impact_shrink", data.HitPos, Angle(0,0,0))
	ParticleEffectAttach("bo4_alistairs_shrink", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	local ent = data.HitEntity
	if ent:IsWorld() then
		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetPos(data.HitPos)
		end)
	end

	self.KillTime = CurTime() + self.Life
	
	phys:EnableMotion(false)
	phys:Sleep()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	ParticleEffectAttach("bo4_alistairs_trail_shrink", PATTACH_ABSORIGIN_FOLLOW, self, 1)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self.KillTime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		dlight = dlight or DynamicLight(self:EntIndex(), false)
		if self:GetActivated() and dlight then
			dlight.pos = self:GetPos()
			dlight.r = 20
			dlight.g = 255
			dlight.b = 5
			dlight.brightness = 2
			dlight.Decay = 1000
			dlight.Size = 200
			dlight.dietime = CurTime() + 0.1
		end
	end

	if SERVER then
		if self.KillTime < CurTime() then
			self:StopSound(self.LoopSound)
			self:EmitSound("TFA_BO4_ALISTAIR.Charged.ShrinkEnd")

			self:Remove()
			return false
		end

		if self:GetActivated() and self.NextAttack < CurTime() then
			local ply = self:GetOwner()

			for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
				if v:IsNPC() or v:IsNextBot() then
					if v:BO4IsShrunk() then continue end
					if v:Health() <= 0 then continue end
					if v == self:GetOwner() then continue end
					if nzombies and (v.NZBossType or string.find(v:GetClass(), "zombie_boss")) then continue end	

					v:BO4Shrink(1, self:GetOwner(), self.Inflictor)
					self.NextAttack = CurTime() + 0.05

					if (v:IsNPC() or v:IsNextBot()) and IsValid(ply) and ply:IsPlayer() then
						if not self.Kills then self.Kills = 0 end

						self.Kills = self.Kills + 1
						if self.Kills == 15 then
							if not ply.bo4shrinkachievement then
								TFA.BO3GiveAchievement("Shrinking Feeling", "vgui/overlay/achievment/Shrinking_Feeling.png", ply, 1)
								ply.bo4shrinkachievement = true
							end
						end
					end
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopSound(self.LoopSound)
end