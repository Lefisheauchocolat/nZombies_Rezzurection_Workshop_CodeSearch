
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
ENT.PrintName = "Hell's Retriever"

ENT.NZThrowIcon = Material("vgui/icon/ui_icon_inventory_tomahawk.png", "unlitgeneric smooth")
ENT.NZTacticalPaP = true

--[Parameters]--
ENT.Delay = 20

ENT.Kills = 0
ENT.MaxKills = 4
ENT.MaxKillsPaP = 6

ENT.Range = 100
ENT.Decay = 20
ENT.RPM = 120

DEFINE_BASECLASS( ENT.Base )

local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Returning")
	self:NetworkVar("Bool", 2, "Upgraded")

	self:NetworkVar("Int", 0, "Charge")
	self:NetworkVar("Int", 1, "Kills")

	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Entity", 1, "Inflictor")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end

	local ply = self:GetOwner()
	local ent = data.HitEntity
	local hitpos = data.HitPos - data.HitNormal
	if (ent:IsWorld() and ent:IsSolid()) and IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
	end

	if IsValid(ent) and not ent:IsPlayer() then
		local damage = DamageInfo()
		damage:SetDamage(15)
		damage:SetDamageType(DMG_SLASH)
		damage:SetAttacker(IsValid(ply) and ply or self)
		damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
		damage:SetDamagePosition(data.HitPos)

		ent:TakeDamageInfo(damage)
	end

	ParticleEffect(self:GetUpgraded() and "bo2_tomahawk_hitworld_2" or "bo2_tomahawk_hitworld", hitpos, data.HitNormal:Angle() - Angle(90,0,0))

	timer.Simple(0, function()
		if not IsValid(self) then return end

		self:SetMoveType(MOVETYPE_FLYGRAVITY)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		self:SetPos(hitpos)

		self:SetActivated(true)
	end)
end

function ENT:Touch(ent)
	local ply = self:GetOwner()
	if ent == ply and self:GetReturning() then
		SafeRemoveEntity(self)
		return
	end
end

function ENT:StartTouch(ent)
	if not ent:IsValidZombie() then return end
	if ent:Health() <= 0 then return end
	if self:GetActivated() then return end

	local ply = self:GetOwner()
	if (ent:IsWorld() and ent:IsSolid()) and IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
	end

	self:InflictDamage(ent)

	local hitpos = ent:EyePos()
	local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !headbone then headbone = ent:LookupBone("j_head") end
	if headbone then
		hitpos = ent:GetBonePosition(headbone)
	end

	timer.Simple(0, function()
		if not IsValid(self) then return end

		self:SetMoveType(MOVETYPE_FLYGRAVITY)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		self:SetPos(hitpos)

		self:SetActivated(true)
	end)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self,...)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:PhysicsInitSphere(0.2, "metal_bouncy")
	self:UseTriggerBounds(true, 2)

	self.TargetsToIgnore = {}
	self:SetReturning(false)
	self:SetActivated(false)
	self.NextPrimaryFire = CurTime()
	self.Range = self.Range * self:GetCharge()
	self.RPM = self.RPM + (self:GetCharge()*20)

	if self:GetUpgraded() then
		ParticleEffectAttach("bo2_tomahawk_trail_2", PATTACH_POINT_FOLLOW, self, 1)
		self.MaxKills = self.MaxKillsPaP
		self.color = Color(160, 240, 255, 255)
		self:SetSkin(1)
	else
		ParticleEffectAttach("bo2_tomahawk_trail", PATTACH_POINT_FOLLOW, self, 1)
		self.color = Color(255, 100, 90, 255)
	end

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self.PickedupPowerup = {}
	self:SetTrigger(true)
end

function ENT:Think()
	if CLIENT then
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles() + Angle(1500,0,0)*FrameTime())
	end

	if CLIENT and DynamicLight and dlight_cvar:GetBool() then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetAttachment(1).Pos
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 0.5
			dlight.Decay = 2000
			dlight.Size = 200
			dlight.dietime = CurTime() + 0.5
		end
	end

	local ply = self:GetOwner()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
			if v:GetClass() == "drop_powerup" then
				if v.GetActivated and not v:GetActivated() then continue end
				if v.GetAnti and v:GetAnti() then continue end

				v:SetPos(self:WorldSpaceCenter())
				v:SetParent(self)
				table.insert(self.PickedupPowerup, v)
			else
				if self.NextPrimaryFire > CurTime() then continue end

				if self:GetActivated() and v:IsNextBot() and self:GetKills() < self.MaxKills and v:Health() > 0 then
					if self.TargetsToIgnore and self.TargetsToIgnore[v:GetCreationID()] then continue end

					local pos = v:EyePos()
					local headbone = v:LookupBone("ValveBiped.Bip01_Head1")
					if !headbone then headbone = v.IsMooSpecial and v:LookupBone("j_spineupper") or v:LookupBone("j_head") end
					if headbone then
						pos = v:GetBonePosition(headbone)
					end

					if pos:DistToSqr(self:WorldSpaceCenter()) <= 400 then
						self:InflictDamage(v)
						break
					end
				end
			end
		end

		local target = self:GetTarget()
		if self:GetActivated() then
			if (IsValid(target) and target:Health() > 0) and self.NextPrimaryFire < CurTime() then
				local pos = target:EyePos()
				local headbone = target:LookupBone("ValveBiped.Bip01_Head1")
				if !headbone then headbone = target.IsMooSpecial and target:LookupBone("j_spineupper") or target:LookupBone("j_head") end
				if headbone then
					pos = target:GetBonePosition(headbone)
				end

				local norm = (pos - self:GetPos()):GetNormalized()
				self:SetPos(self:GetPos() + norm*20)
				self:SetLocalVelocity(norm*100)
			end

			if (not IsValid(target) or target:Health() <= 0) and self.NextPrimaryFire < CurTime() then
				self:SetTarget(self:FindNearestEntity(self:GetPos(), self.Range, self.TargetsToIgnore))

				if not IsValid(self:GetTarget()) then
					self:SetReturning(true)
					self:StopParticles()
					ParticleEffectAttach(self:GetUpgraded() and "bo2_tomahawk_return_2" or "bo2_tomahawk_return", PATTACH_POINT_FOLLOW, self, 1)
				end
			end
		end

		if self:GetReturning() then
			if self:GetActivated() then
				self:EmitSound("TFA_BO2_TOMAHAWK.Incoming")
				self:SetActivated(false)
			end

			if ply:Alive() then
				local norm = (ply:GetShootPos() - self:GetPos()):GetNormalized()
				self:SetPos(LerpVector(0.1, self:GetPos(), ply:GetShootPos()))
				self:SetLocalVelocity(norm * 400)
			else
				SafeRemoveEntity(self)
				return false
			end
		end

		if self.killtime < CurTime() and not self:GetReturning() then
			self:SetReturning(true)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()
	self.Damage = self.mydamage or self.Damage
	self:SetKills(self:GetKills() + 1)
	self.TargetsToIgnore[ent:GetCreationID()] = ent
	if self:GetKills() >= self.MaxKills then
		self:SetReturning(true)
		self:StopParticles()
		ParticleEffectAttach(self:GetUpgraded() and "bo2_tomahawk_return_2" or "bo2_tomahawk_return", PATTACH_POINT_FOLLOW, self, 1)
	end

	ent:EmitSound("TFA_BO2_TOMAHAWK.Impact")

	local damage = DamageInfo()
	damage:SetDamage(self.Damage * self:GetCharge())
	damage:SetDamageType(DMG_SLOWBURN)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamageForce(vector_up)

	local hitpos = ent:EyePos()
	local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !headbone then headbone = ent:LookupBone("j_head") end
	if headbone then
		hitpos = ent:GetBonePosition(headbone)
	end
	damage:SetDamagePosition(hitpos)

	ParticleEffect(self:GetUpgraded() and "bo2_tomahawk_impact_2" or "bo2_tomahawk_impact", hitpos, Angle(0,0,0))

	if (ent.NZBossType or ent.IsMooBossZombie) then
		damage:SetDamage(math.max(600*self:GetCharge(), ent:GetMaxHealth() / 8))
	end

	ent:TakeDamageInfo(damage)

	self:SetPos(hitpos)
	self:SetLocalVelocity(vector_origin)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
	end

	self.NextPrimaryFire = CurTime() + (60 / self.RPM)
	self:SetTarget(self:FindNearestEntity(self:GetPos(), self.Range, self.TargetsToIgnore))
end

function ENT:FindNearestEntity(pos, range, tab)
	local targets = {}
	local tr = {
		start = pos,
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local ply = self:GetOwner()

	for _, v in RandomPairs(ents.FindInSphere(pos, range)) do
		if IsValid(ply) and v:IsNPC() and v:Disposition(ply) == D_LI then continue end
		if v:IsNextBot() and v:Health() > 0 and !tab[v:GetCreationID()] then
			table.insert(targets, v)
		end
	end

	if table.IsEmpty(targets) then
		return
	end

	local target
	local bestrating = -1
	for i, ent in pairs(targets) do
		local currating = 0
		tr.filter = {self, ply, ent}

		tr.endpos = ent:GetPos() + vector_up
		local t1 = util.TraceLine(tr)
		if not t1.Hit then
			currating = currating + 4
		end

		tr.endpos = ent:EyePos()
		local t2 = util.TraceLine(tr)
		if not t2.Hit then
			currating = currating + 3
		end

		if currating > bestrating then
			bestrating = currating
			target = targets[i]

			if bestrating >= 7 then
				self.Range = self.Range - self.Decay
				return target
			end
		end
	end

	if bestrating >= 3 then
		self.Range = self.Range - self.Decay
		return target
	else
		self.Range = self.Range - self.Decay
		return targets[1]
	end

	return
end

function ENT:OnRemove()
	local ply = self:GetOwner()
	local wep = self:GetInflictor()

	if IsValid(wep) then
		wep:EmitSound("TFA_BO2_TOMAHAWK.Catch")
	end

	if SERVER and self.PickedupPowerup then
		for _, fucker in pairs(self.PickedupPowerup) do
			if IsValid(fucker) and fucker:GetParent() == self then
				fucker:SetParent(nil)

				nzPowerUps:Activate(fucker:GetPowerUp(), IsValid(ply) and ply or nil, fucker)
				local GLOBAL = nzPowerUps:Get(fucker:GetPowerUp()).global
				if IsValid(ply) then
					fucker:SetPos(ply:GetShootPos())
					ply:EmitSound(nzPowerUps:Get(fucker:GetPowerUp()).collect or "nz_moo/powerups/powerup_pickup_zhd.mp3")
				end
				fucker:Remove()
			end
		end
	end

	local time = (IsValid(ply) and ply:HasPerk("time")) and 4 or 5
	if self:GetKills() <= 0 then
		time = 1.5
	end

	timer.Simple(time, function()
		if !IsValid(ply) or !IsValid(wep) or !ply:Alive() then return end

		wep:SetClip1(1)
		ply:SetAmmo(1, GetNZAmmoID("specialgrenade"))

		if SERVER then
			local msg1 = "LocalPlayer():StopSound('weapons/tfa_bo2/tomahawk/tomahawk_cooldown.wav')"
			local msg2 = "surface.PlaySound('weapons/tfa_bo2/tomahawk/tomahawk_cooldown.wav')"
			ply:SendLua(msg1)
			ply:SendLua(msg2)
		end
	end)
end
