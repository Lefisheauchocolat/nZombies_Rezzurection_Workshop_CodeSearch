
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
ENT.PrintName = "Lightning Ball"
ENT.HasTrail = true

--[Sounds]--
ENT.LaunchSound = "TFA_BO3_WAFFE.Ext"
ENT.PropelSound = "TFA_BO3_WAFFE.Loop"
ENT.ExplosionSound = "TFA_BO3_WAFFE.Impact"
ENT.ExplosionSoundWater = "TFA_BO3_WAFFE.ImpactWater"

--[Parameters]--
ENT.Delay = 10
ENT.ArcDelay = 0.2

ENT.MaxChain = 10
ENT.MaxChainPaP = 24

ENT.ZapRange = 300
ENT.ZapRangePaP = 500
ENT.ZapRangeStart = 200

ENT.Decay = 20

DEFINE_BASECLASS(ENT.Base)

local pvp_bool = GetConVar("sbox_playershurtplayers")
local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 1, "Activated")

	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Int", 0, "Kills")
end

function ENT:PhysicsCollide(data, phys)
	if data.HitEntity:IsPlayer() then return end

	self:StopSound(self.PropelSound)
	self:DoZappyDamage(data.HitEntity)
	self:OnCollide(data.HitEntity, data.HitPos)

	if self:GetUpgraded() then
		ParticleEffect("bo3_waffe_impact_2", data.HitPos - data.HitNormal, data.HitNormal:Angle() - Angle(90,0,0))
	else
		ParticleEffect("bo3_waffe_impact", data.HitPos - data.HitNormal, data.HitNormal:Angle() - Angle(90,0,0))
	end

	SafeRemoveEntityDelayed(self, 6)
end

function ENT:StartTouch(ent)
	if ent == self:GetOwner() then return end
	if ent:IsNPC() or ent:IsNextBot() or (not nzombies and ent:IsPlayer()) then

		self:StopSound(self.PropelSound)
		self:DoZappyDamage(ent)
		self:OnCollide(ent, self:GetPos())

		SafeRemoveEntityDelayed(self, 6)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 12)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	self:EmitSound(self.PropelSound)
	self:EmitSound(self.LaunchSound)
	self.killtime = CurTime() + self.Delay
	self.TargetsToIgnore = {}

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_waffe_trail_2", PATTACH_POINT_FOLLOW, self, 1)
		self.color = Color(255, 200, 210, 255)
		self.MaxChain = self.MaxChainPaP
		self.ZapRange = self.ZapRangePaP
	else
		ParticleEffectAttach("bo3_waffe_trail", PATTACH_POINT_FOLLOW, self, 1)
		self.color = Color(220, 200, 250, 255)
		self.MaxChain = self.MaxChain
		self.ZapRange = self.ZapRange
	end

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think(...)
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		if self:GetActivated() then return end
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 2
			dlight.Decay = 2000
			dlight.Size = 256
			dlight.dietime = CurTime() + 0.2
		end
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:StopSound(self.PropelSound)
			self:Remove()
			return false
		end

		if self:WaterLevel() > 0 then
			self:EmitSound(self.ExplosionSoundWater)
			self:StopSound(self.PropelSound)
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:DoZappyDamage(ent)
	if CLIENT then return end
	if not IsValid(ent) then return end
	if ent:IsNPC() or ent:IsNextBot() then return end

	local zapp = DamageInfo()
	zapp:SetDamage(50)
	zapp:SetDamageType(DMG_SHOCK)
	zapp:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	zapp:SetInflictor(self)
	zapp:SetDamageForce(vector_up)
	zapp:SetDamagePosition(ent:WorldSpaceCenter())

	ent:TakeDamageInfo(zapp)
end

function ENT:OnCollide(ent, pos)
	if self:GetActivated() then return end
	self:SetActivated(true)

	util.ScreenShake(pos, 6, 255, 1, 200)
	self:EmitSound(self.ExplosionSound)
	self:StopSound(self.PropelSound)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetPos(pos)
		self:StopParticles()
	end)

	self:SetTarget(self:FindNearestEntity(self:GetPos(), self.TargetsToIgnore))

	if not IsValid(self:GetTarget()) then
		SafeRemoveEntity(self)
		return
	end

	self:Zap(self:GetTarget())
	self:EmitSound("TFA_BO3_WAFFE.Jump")
	self:EmitSound("TFA_BO3_WAFFE.Flux")
	self:SetKills(0)

	local timername = "waffechaintimer"..self:EntIndex()
	timer.Create(timername, self.ArcDelay, self.MaxChain, function()
		if not IsValid(self) then
			timer.Stop(timername)
			timer.Remove(timername)
			return
		end

		self:SetTarget(self:FindNearestEntityCheap(self:GetPos(), self.TargetsToIgnore))
		if not IsValid(self:GetTarget()) then
			timer.Stop(timername)
			timer.Remove(timername)
			SafeRemoveEntity(self)
			return
		end

		local tr = util.TraceLine({
			start = self:WorldSpaceCenter(),
			endpos = self:GetTarget():EyePos(),
			filter = {self, self:GetTarget(), self:GetOwner()},
			mask = MASK_SOLID_BRUSHONLY,
		}) //instead of removing if we hit a wall, just increase the decay penalty.

		self.ZapRange = self.ZapRange - (self.Decay * (tr.HitWorld and 3 or 1))
		self:Zap(self:GetTarget())
		self:SetKills(self:GetKills() + 1)

		if self:GetKills() == 5 then
			local wep = self:GetOwner():GetActiveWeapon()
			if IsValid(wep) and wep:GetClass() == "tfa_bo3_wunderwaffe" then
				wep:EmitSound("TFA_BO3_WAFFE.Meow.Happy")

				if wep.HappyLights then
					wep:CallOnClient("HappyLights", "")
				end

				if wep.GetNextWave and (wep:GetNextWave() - 2) < CurTime() then
					wep:SetNextWave(CurTime() + math.Rand(2, 4))
				end
			end
		end

		if self:GetKills() >= self.MaxChain then
			timer.Stop(timername)
			timer.Remove(timername)
			self:Remove()
			return
		end
	end)
end

function ENT:Zap(ent)
	local att = ent:GetAttachment(2) and ent:GetAttachment(2).Pos or ent:EyePos()
	local ply = IsValid(self:GetOwner()) and self:GetOwner() or self

	if self:GetUpgraded() then
		util.ParticleTracerEx("bo3_waffe_jump_2", self:GetPos(), att, false, ply:EntIndex(), 0)

		ParticleEffectAttach("bo3_waffe_electrocute_2", PATTACH_POINT_FOLLOW, ent, 2)
		if ent:OnGround() then
			ParticleEffectAttach("bo3_waffe_ground_2", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
		end
		if nzombies and ent:IsValidZombie() and not ent.IsMooSpecial then
			ParticleEffectAttach("bo3_waffe_eyes_2", PATTACH_POINT_FOLLOW, ent, 3)
			ParticleEffectAttach("bo3_waffe_eyes_2", PATTACH_POINT_FOLLOW, ent, 4)
		end
	else
		util.ParticleTracerEx("bo3_waffe_jump", self:GetPos(), att, false, ply:EntIndex(), 0)

		ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
		if ent:OnGround() then
			ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
		end
		if nzombies and ent:IsValidZombie() and not ent.IsMooSpecial then
			ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, ent, 3)
			ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, ent, 4)
		end
	end

	ent:EmitSound("TFA_BO3_WAFFE.Bounce")
	ent:EmitSound("TFA_BO3_WAFFE.Death")
	ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
	ent:EmitSound("TFA_BO3_WAFFE.Zap")

	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetPos(att)
	end)

	self:InflictDamage(ent, false)
	self.TargetsToIgnore[self:GetKills()] = ent
end

function ENT:InflictDamage(ent)
	if CLIENT then return end
	local ply = self:GetOwner()

	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_SHOCK)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:EyePos())

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(2200, ent:GetMaxHealth() / 9))
	end

	if not nzombies and math.random(10) < 4 then
		local headpos = ent:EyePos()
		local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
		if !headbone then headbone = ent:LookupBone("j_head") end
		if headbone then
			headpos = ent:GetBonePosition(headbone)
			damage:SetDamagePosition(headpos)
		end

		ParticleEffect("blood_impact_red_01", headpos, ent:EyeAngles())
		ent:EmitSound("TFA_BO3_WAFFE.Pop")
		ent:EmitSound("TFA_BO3_GENERIC.Gore")
	end

	ent:TakeDamageInfo(damage)
end

function ENT:FindNearestEntity(pos, tab)
	local nearbyents = {}
	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(pos, self.ZapRangeStart)) do
		if v:IsNPC() or v:IsNextBot() or v:IsPlayer() then
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
			if nzombies and v:IsPlayer() then continue end
			if v == self:GetOwner() then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			if !table.HasValue(tab, v) then
				table.insert(nearbyents, v)
			end
		end
	end

	table.sort(nearbyents, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
	return nearbyents[1]
end

function ENT:FindNearestEntityCheap(pos, tab)
	local nearestent
	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(pos, self.ZapRange)) do
		if v:IsNPC() or v:IsNextBot() or (not nzombies and v:IsPlayer()) then
			if v == ply then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(ply) and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end
			if !table.HasValue(tab, v) then
				nearestent = v
				break
			end
		end
	end

	return nearestent
end

function ENT:OnRemove()
	self:StopSound("TFA_BO3_WAFFE.Loop")
	self:StopSound(self.PropelSound)
end
