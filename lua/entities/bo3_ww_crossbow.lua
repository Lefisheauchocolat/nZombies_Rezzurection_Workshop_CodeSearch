
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
ENT.PrintName = "Explosive Tipped Bolt"

--[Sounds]--
ENT.BeepSound = "TFA_BO3_CROSSBOW.Alert"

--[Parameters]--
ENT.NZThrowIcon = Material("vgui/icon/hud_indicator_arrow.png", "unlitgeneric smooth")
ENT.NZHudIcon = Material("vgui/icon/hud_indicator_arrow.png", "unlitgeneric smooth")

ENT.Delay = 12
ENT.Duration = 2
ENT.BeepDelay = 0.35
ENT.Range = 220
ENT.Kills = 0

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Blink")
	self:NetworkVar("Bool", 2, "Impacted")
	self:NetworkVar("Float", 0, "BeepTimer")
end

function ENT:Draw()
	self:DrawModel()

	if self:GetBlink() and self.color then
		render.SetMaterial(Material("effects/blueflare1"))
		render.DrawSprite(self:GetAttachment(1).Pos, 12, 12, self.color)
	end

	if nzombies then return end

	local icon = surface.GetTextureID("models/weapons/tfa_bo3/crossbow/i_crossbow_indicator")
	local angle = LocalPlayer():EyeAngles()
	local pos = self:WorldSpaceCenter() + Vector(0,0,15)
	local totaldist = 400^2
	local distfade = 300^2
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

	self:EmitSound("TFA_BO3_CROSSBOW.Impact.Rock")
	self.killtime = CurTime() + self.Duration
	self.hitdata = data

	local ang = self:GetAngles()
	local ent = data.HitEntity
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetAngles(ang)
		self:SetPos(data.HitPos)
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		if IsValid(ent) and not ent:IsWorld() and IsValid(ent:GetPhysicsObject()) then
			self:SetParent(ent)
		end
	end)

	phys:EnableMotion(false)
	phys:Sleep()
	
	if nzombies then
		self:MonkeyBombNZ()
	else
		self:MonkeyBomb()
	end
end

function ENT:StartTouch(ent)
	if ent == self:GetOwner() then return end
	if not ent:IsSolid() then return end
	if self:GetImpacted() then return end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		self:SetParent(ent)
		self:EmitSound("TFA_BO3_CROSSBOW.Impact.Flesh")
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)

		if nzombies then
			local ply = self:GetOwner()
			if nzombies and IsValid(ply) then
				ply:GivePoints(10)
			end
			if ent:IsValidZombie() and not (ent.NZBossType or ent.IsMooBossZombie) then
				ent:SetBlockAttack(true)
			end
		end

		if nzombies then
			self:MonkeyBombNZ()
		else
			self:MonkeyBomb()
		end

		self.killtime = CurTime() + self.Duration
		self:SetImpacted(true)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetBuoyancyRatio(0)
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	self.killtime = CurTime() + self.Delay
	self:SetBeepTimer(CurTime() + self.BeepDelay)

	if self:GetUpgraded() then
		self.color = Color(255,20,0,255)
		self.Duration = 5
	else
		self.color = Color(120,255,70,255)
		self.Duration = 2
	end

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 1, self.color, false, 5, 1, 0.2, 2, "effects/laser_citadel1.vmt")
end

function ENT:Think()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		local vel = phys:GetVelocity()
		phys:SetAngles(vel:Angle())
		phys:SetVelocity(vel)
	end

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = DynamicLight(self:EntIndex())
		if dlight and self:GetImpacted() and self:GetBlink() then
			dlight.pos = self:GetAttachment(1).Pos
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 0.5
			dlight.Decay = 1000
			dlight.Size = 64
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		if self:GetImpacted() and self:GetBeepTimer() <= CurTime() then
			if IsFirstTimePredicted() then self:EmitSound(self.BeepSound) end

			self.BeepDelay = math.max(self.BeepDelay - (self:GetUpgraded() and .02 or .05), 0.1)

			self:SetBlink(not self:GetBlink())
			self:SetBeepTimer(CurTime() + self.BeepDelay)
		end

		if self:GetImpacted() and not nzombies then
			self:MonkeyBombNXB()
			self:MonkeyBomb()
		end

		if self.killtime < CurTime() then
			self:Explode()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode()
	self.Damage = self.mydamage or self.Damage

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if not v:IsWorld() and v:IsSolid() then
			self:InflictDamage(v)
		end
	end

	if self.hitdata then
		util.Decal("Scorch", self.hitdata.HitPos - self.hitdata.HitNormal, self.hitdata.HitPos + self.hitdata.HitNormal)
	end

	util.ScreenShake(self:GetPos(), 10, 255, 0.8, 512)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	local p = self:GetParent()

	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(ent:GetUp()*12000 + (ent:GetPos() - self:GetPos()):GetNormalized() * 10000)
	damage:SetDamageType(bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if ent == ply then
		local distfac = self:GetPos():Distance(ent:WorldSpaceCenter())
		distfac = 1 - math.Clamp(distfac/self.Range, 0, 1)
		damage:SetDamage(200*distfac)
	end
	
	if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
		damage:ScaleDamage(math.max(nzRound:GetNumber()/10, self:GetUpgraded() and 2 or 1))
	end

	if nzombies and (ent:IsPlayer() and ent ~= ply) then return end
	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)

	if SERVER and (ent:IsNPC() or ent:IsNextBot()) and (damage:GetDamage() > ent:Health()) then
		self.Kills = self.Kills + 1
		if self.Kills == 6 and IsValid(ply) and ply:IsPlayer() and IsValid(p) and p:IsPlayer() then
			if SERVER and not ply.bo3bowachievement then
				TFA.BO3GiveAchievement("Sacrificial Lamb", "vgui/overlay/achievment/sacrificial_lamb.png", ply)
				ply.bo3bowachievement = true
			end
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

function ENT:MonkeyBombNZ()
	if not self:GetUpgraded() then return end
	if CLIENT then return end
	self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
	UpdateAllZombieTargets(self)
end

function ENT:OnRemove()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 4096)) do
			if v:IsNPC() and v:GetEnemy() == self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())

				v:SetSchedule(SCHED_ALERT_STAND)
			end
		end
	end
end