
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
ENT.PrintName = "Yellow Lightning Ball"

--[Parameters]--
ENT.Delay = 10

ENT.MaxChain = 3
ENT.MaxChainPaP = 4
ENT.ZapRange = 120
ENT.ZapRangePaP = 140

ENT.Decay = 10

DEFINE_BASECLASS(ENT.Base)

local pvp_bool = GetConVar("sbox_playershurtplayers")
local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "HeadShot")
	self:NetworkVar("Bool", 1, "Upgraded")

	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Entity", 1, "Attacker")
	self:NetworkVar("Entity", 2, "Inflictor")

	self:NetworkVar("Int", 0, "Kills")
end

function ENT:PhysicsCollide(data, phys)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetSolid(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableDrag(false)
		phys:EnableGravity(false)
	end

	self.killtime = CurTime() + self.Delay
	self.TargetsToIgnore = {}

	if self:GetUpgraded() then
		self.MaxChain = self.MaxChainPaP
		self.ZapRange = self.ZapRangePaP
	end

	if self:GetHeadShot() then
		self.MaxChain = self.MaxChain * 3
		self.ZapRange = self.ZapRange * 3 
	end

	if CLIENT then return end
	self:OnCollide()
	self:SetTrigger(true)
end

function ENT:Think(...)
	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnCollide()
	if not IsValid(self:GetTarget()) then
		SafeRemoveEntity(self)
		return
	end

	timer.Simple(engine.TickInterval(), function()
		if not IsValid(self) then return end
		if not IsValid(self:GetTarget()) or self:GetTarget():Health() <= 0 then return end
		self:Zap(self:GetTarget())
	end)
	self:SetKills(0)

	local timername = self:EntIndex().."dg1shartsnfartz"
	timer.Create(timername, 0.25, self.MaxChain - 1, function()
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
	local upg = self:GetUpgraded()

	util.ParticleTracerEx(upg and "bo4_dg1_jump_2" or "bo4_dg1_jump", self:GetPos(), att, false, self:GetOwner():EntIndex(), ent:EntIndex())

	ParticleEffectAttach(upg and "bo4_dg1_electrocute_2" or "bo4_dg1_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
	if ent:OnGround() then
		ParticleEffectAttach(upg and "bo4_dg1_ground_2" or "bo4_dg1_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
	end

	if nzombies and ent:IsValidZombie() and not ent.IsMooSpecial then
		ParticleEffectAttach(upg and "bo4_dg1_eyes_2" or "bo4_dg1_eyes", PATTACH_POINT_FOLLOW, ent, 3)
		ParticleEffectAttach(upg and "bo4_dg1_eyes_2" or "bo4_dg1_eyes", PATTACH_POINT_FOLLOW, ent, 4)
	end

	ent:EmitSound("TFA_BO3_WAFFE.Bounce")
	ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
	ent:EmitSound("TFA_BO3_WAFFE.Zap")

	self:SetPos(att)

	self:InflictDamage(ent)
	self.TargetsToIgnore[self:GetKills()] = ent
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamage(ent:Health() + 666)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamageType(DMG_SHOCK)
	damage:SetDamageForce(vector_up)
	damage:SetDamagePosition(ent:EyePos())

	if !nzombies and math.random(10) > 6 then
		local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
		if !headbone then headbone = ent:LookupBone("j_head") end
		if headbone then
			damage:SetDamagePosition(ent:GetBonePosition(headbone))
		end

		ParticleEffect("blood_impact_red_01", ent:EyePos(), ent:GetForward():Angle())
		ent:EmitSound("TFA_BO3_WAFFE.Pop")
		ent:EmitSound("TFA_BO3_GENERIC.Gore")
	end

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
		damage:SetDamage(math.max(600, ent:GetMaxHealth() / 22))
		//damage:ScaleDamage(math.Round(nzRound:GetNumber()/12))
	end

	if SERVER then
		ent:TakeDamageInfo(damage)
	end
end

function ENT:FindNearestEntity(pos, tab)
	local nearbyents = {}
	for k, v in pairs(ents.FindInSphere(pos, 128)) do
		if v:IsNPC() or v:IsNextBot() or (not nzombies and v:IsPlayer()) then
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
			if v == self:GetOwner() then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(self:GetOwner()) and !hook.Run("PlayerShouldTakeDamage", v, self:GetOwner()) then continue end

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
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
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
