
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
ENT.PrintName = "Ragnarok DG4"

--[Sounds]--
ENT.VortexStartSound = "TFA_BO3_DG4.Vortex.Start"
ENT.VortexLoopSound = "TFA_BO3_DG4.Vortex.Loop"
ENT.VortexEndSound = "TFA_BO3_DG4.Vortex.End"

--[Parameters]--
ENT.Range = 160
ENT.ConsumptionRate = 1
ENT.TakenAmmo = 0
ENT.NZThrowIcon = Material("vgui/icon/hud_talonspikes.png", "unlitgeneric smooth")
ENT.NZHudIcon = Material("vgui/icon/hud_talonspikes.png", "smooth unlitgeneric")

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "AmmoCount")
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Float", 0, "NextAmmo")
	self:NetworkVar("Entity", 0, "Target")
end

if CLIENT then
	function ENT:GetNZTargetText()
		local ply = self:GetOwner()
		if not IsValid(ply) then return end
		return ply:Nick().."'s - Ragnarok DG4s"
	end
end

function ENT:PhysicsCollide(data, phys)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(false)
	self:SetNoDraw(true)

	self:EmitSoundNet(self.VortexStartSound)
	self:EmitSoundNet(self.VortexLoopSound)

	ParticleEffectAttach( "bo3_dg4_placed", PATTACH_ABSORIGIN_FOLLOW, self, 0 )

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self:SetActivated(true)
	self:SetNextAmmo(CurTime() + engine.TickInterval())

	self:PostSpawnEntity()
end

function ENT:PostSpawnEntity()
	if CLIENT then return end
	local ply = self:GetOwner()

	local clone = ents.Create("bo3_special_dg4clone")
	clone:SetModel("models/weapons/tfa_bo3/dg4/dg4_prop.mdl")
	clone:SetAngles(self:GetAngles() - Angle(0,90,0))
	clone:SetOwner(IsValid(ply) and ply or self)
	clone:SetParent(self)
	clone:SetPos((self:GetPos() + self:GetRight()*-18))

	clone:Spawn()

	local clone2 = ents.Create("bo3_special_dg4clone")
	clone2:SetModel("models/weapons/tfa_bo3/dg4/dg4_prop.mdl")
	clone2:SetAngles(self:GetAngles() - Angle(0,90,0))
	clone2:SetOwner(IsValid(ply) and ply or self)
	clone2:SetParent(self)
	clone2:SetPos((self:GetPos() + self:GetRight()*18))

	clone2:Spawn()
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 45
			dlight.g = 165
			dlight.b = 255
			dlight.brightness = self:GetActivated() and 4 or 2
			dlight.Decay = 1000
			dlight.Size = self:GetActivated() and 256 or 128
			dlight.dietime = CurTime() + 0.1
		end
	end

	if SERVER then
		local wep = self:GetTarget()

		if not IsValid(self:GetOwner()) then
			self:StopSound(self.VortexLoopSound)
			SafeRemoveEntity(self)
			return false
		end

		if (self:GetAmmoCount() <= 0 or self.TakenAmmo >= 100 or (IsValid(wep) and wep:Clip1() <= 0)) and self:GetActivated() then
			self:SetActivated(false)

			self:StopParticles()

			ParticleEffect("bo3_dg4_finish", self:GetPos(), angle_zero)

			self:StopSound(self.VortexLoopSound)
			self:EmitSound(self.VortexEndSound)

			util.ScreenShake(self:GetPos(), 20, 255, 1.5, 512)

			SafeRemoveEntityDelayed(self, 30)
		end

		if self:GetAmmoCount() > 0 and self:GetActivated() then
			self:AOEEffect()
			if self:GetNextAmmo() < CurTime() then
				self:SetAmmoCount(math.max(self:GetAmmoCount()-5, 0))

				if IsValid(wep) then
					wep:SetClip1(math.max(wep:Clip1() - 5, 0))
				end

				self.TakenAmmo = self.TakenAmmo + 5
				self:SetNextAmmo(CurTime() + self.ConsumptionRate)
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

local liftclasses = {
	["nz_zombie_boss_fireman"] = true,
	["nz_zombie_boss_krasny"] = true,
	["nz_zombie_boss_panzer"] = true,
	["nz_zombie_boss_panzer_bo3"] = true,
}

function ENT:AOEEffect()
	util.ScreenShake(self:GetPos(), 4, 255, 0.1, self.Range*1.5)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if nzombies and v:IsPlayer() and !v:GetNotDowned() and !v.DownedWithSoloRevive then
			v.DownedWithSoloRevive = true
			v:StartRevive(v)
			timer.Simple(2, function()
				if IsValid(v) and !v:GetNotDowned() then
					v:RevivePlayer(v)
					if v.OldPerks then
						for _, perk in pairs(v.OldPerks) do
							v:GivePerk(perk)
						end
					end
					if v.DownPoints then
						v:GivePoints(tonumber(v.DownPoints))
					end
				end
			end)
		end

		if (v:IsNextBot() or v:IsNPC()) and v:Health() > 0 then
			if liftclasses[v:GetClass()] or v.CanPanzerLift then
				v:PanzerDGLift(0.5)
				continue
			end
			self:InflictDamage(v)
		end
	end
end

function ENT:OnRemove()
	self:StopParticles()
	self:StopSound(self.VortexLoopSound)
	self:ReturnToOwner()
end

function ENT:ReturnToOwner()
	local ply = self:GetOwner()
	if SERVER and IsValid(ply) then
		ply:EmitSound("weapon_bo3_cloth.med")
		self:EmitSound("weapon_bo3_gear.rattle")
		if not nzombies then
			ply:Give("tfa_bo3_dg4", true)
			local wep = ply:GetWeapon("tfa_bo3_dg4")
			if IsValid(wep) then
				wep.IsFirstDeploy = true
				if inf_cvar:GetBool() then
					wep:SetClip1(100)
				else
					wep:SetClip1(0)
				end
			end
		end
	end
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_ENERGYBEAM)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(ent:GetUp()*25000 + (ent:GetPos() - self:GetPos()):GetNormalized() * 10000)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if damage:GetDamage() >= ent:Health() then
		ent:SetNW2Bool("DG4Killed", true)
	end

	ent:TakeDamageInfo(damage)
end

function ENT:Use(act, cal)
	if CLIENT then return end
	if self:GetActivated() then return end
	if IsValid(act) and act == self:GetOwner() then
		self:Remove()
	end
end