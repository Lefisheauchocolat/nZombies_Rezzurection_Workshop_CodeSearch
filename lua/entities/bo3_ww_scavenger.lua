
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
ENT.PrintName = "Scavenger Bolt"

--[Sounds]--
ENT.ExplosionSound = "TFA_BO3_SCAVENGER.Explode"
ENT.ExplosionSoundPAP = "TFA_BO3_SCAVENGER.ExplodePAP"
ENT.RampUpSound = "TFA_BO3_SCAVENGER.RampUp"

--[Parameters]--
ENT.NZThrowIcon = Material("vgui/icon/hud_indicator_sniper_explosive.png", "unlitgeneric smooth")
ENT.NZHudIcon = Material("vgui/icon/hud_indicator_sniper_explosive.png", "unlitgeneric smooth")

ENT.Delay = 3
ENT.Range = 280
ENT.Kills = 0

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Impacted")
end

function ENT:Draw()
	self:DrawModel()

	if nzombies then return end

	local icon = surface.GetTextureID("models/weapons/tfa_bo3/scavenger/i_scavenger_indicator")
	local angle = LocalPlayer():EyeAngles()
	local pos = self:GetPos() + (self:GetUp() * 12) + (self:GetForward() * - 5)
	local totaldist = 350^2
	local distfade = 250^2
	local playerpos = LocalPlayer():GetPos():DistToSqr(self:GetPos())
	local fadefac = 1 - math.Clamp((playerpos - totaldist + distfade) / distfade, 0, 1)
	
	angle = Angle(angle.x, angle.y, 0)
	angle:RotateAroundAxis(angle:Up(), -90)
	angle:RotateAroundAxis(angle:Forward(), 90)
	
	if IsValid(LocalPlayer()) and self:GetImpacted() then
		cam.Start3D2D(pos, angle, 1)
			surface.SetTexture(icon)
			surface.SetDrawColor(255,255,255,255*fadefac)
			surface.DrawTexturedRect(-8, -8, 16,16)
		cam.End3D2D()
	end
end

function ENT:PhysicsCollide(data, phys)
	if self:GetImpacted() then return end
	self:SetImpacted(true)

	local ent = data.HitEntity
	local ang = self:GetAngles()

	timer.Simple(0, function()
		if not self:IsValid() then return end
		self:SetAngles(ang)
		self:SetPos(data.HitPos)
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	sound.EmitHint(SOUND_DANGER, self:GetPos(), 512, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)
end

function ENT:StartTouch(ent)
	if ent == self:GetOwner() then return end
	if not ent:IsSolid() then return end
	if nzombies and ent:IsPlayer() then return end
	if self:GetImpacted() then return end

	self:SetParent(ent)

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	local ply = self:GetOwner()
	if nzombies and IsValid(ply) then
		ply:GivePoints(10)
	end

	sound.EmitHint(SOUND_DANGER, self:GetPos(), 512, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 2)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:SetBuoyancyRatio(0)
	end

	if self:GetUpgraded() then
		self.color = Color(240, 100, 220)
	else
		self.color = Color(255, 200, 20)
	end

	timer.Simple(0.5,function()
		if not IsValid(self) then return end
		self:EmitSound(self.RampUpSound)
	end)

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:DoExplosionEffect()
	if self:GetUpgraded() then
		self:EmitSound(self.ExplosionSoundPAP)
		ParticleEffect("bo3_scavenger_explosion_2", self:GetPos(), Angle(0,0,0))
	else
		self:EmitSound(self.ExplosionSound)
		ParticleEffect("bo3_scavenger_explosion", self:GetPos(), Angle(0,0,0))
	end
end

function ENT:Explode()
	self.Damage = self.mydamage or self.Damage

	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			if v == self then continue end
			if nzombies and v:IsPlayer() and v ~= ply then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			self:InflictDamage(v)
		end
	end

	util.ScreenShake(self:GetPos(), 20, 255, 1, 1024)

	self:DoExplosionEffect()
	SafeRemoveEntity(self)
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	local distfac = self:GetPos():Distance(ent:GetPos())
	distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
	local fuck = distfac > 0.67

	local damage = DamageInfo()
	damage:SetDamage(fuck and ent:Health() + 666 or self.Damage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(nzombies and DMG_BLAST or bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamageForce(ent:GetUp()*20000 + (ent:GetPos() - self:GetPos()):GetNormalized()*15000)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if ent:IsPlayer() then
		damage:SetDamage(200*distfac)
	end

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "zombie_boss")) then
		damage:ScaleDamage(math.Round(nzRound:GetNumber()/10, 1))
	elseif fuck and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) and ent ~= ply then
		ent:SetHealth(1)
		ent:SetNW2Bool("WavePopKilled", true)

		if math.random(10) > 5 then //50% chance to spawn a gib
			local gib = ents.Create("bo3_misc_gib")
			gib:SetPos(ent:WorldSpaceCenter())
			gib:Spawn()

			local phys = gib:GetPhysicsObject()
			if IsValid(phys) then
				phys:AddAngleVelocity(Vector(0,math.random(1000,2000),0))
				phys:SetVelocity(Vector(math.random(-100,100), math.random(-100,100), math.random(200,400)))
			end
		end
	end

	if nzombies and (ent:IsPlayer() and ent ~= self:GetOwner()) then return end
	ent:TakeDamageInfo(damage)

	if SERVER and (ent:IsNPC() or ent:IsNextBot()) and (damage:GetDamage() > ent:Health()) then
		if IsValid(ply) and ply:IsPlayer() and ply:GetPos():Distance(self:GetPos()) > 1600 then
			self.Kills = self.Kills + 1
			if self.Kills == 6 and not ply.bo3scavachievement then
				TFA.BO3GiveAchievement("Shooting on Location", "vgui/overlay/achievment/scavenger.png", ply, 1)
				ply.bo3scavachievement = true
			end
		end
	end
end

function ENT:OnRemove()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 3
			dlight.Decay = 500
			dlight.Size = 512
			dlight.DieTime = CurTime() + 1
		end
	end
end
