AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Green Lightning"

--[Parameters]--
ENT.Delay = 10

ENT.ArcDelay = 1/3
ENT.ArcDelayPaP = 1/3
ENT.MaxChain = 9
ENT.MaxChainPaP = 12
ENT.ZapRange = 600
ENT.ZapRangePaP = 800

ENT.Decay = 35
ENT.Kills = 0

DEFINE_BASECLASS(ENT.Base)

local pvp_bool = GetConVar("sbox_playershurtplayers")
local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")

	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Entity", 1, "Attacker")
	self:NetworkVar("Entity", 2, "Inflictor")
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
		self.ArcDelay = self.ArcDelayPaP
		self.MaxChain = self.MaxChainPaP
		self.ZapRange = self.ZapRangePaP
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

	self:Zap(self:GetTarget())
	self.Kills = 0

	local timername = self:EntIndex().."wawgreenkush"
	timer.Create(timername, self.ArcDelay, self.MaxChain - 1, function()
		if not IsValid(self) then
			timer.Stop(timername)
			timer.Remove(timername)
			return
		end

		self:SetTarget(self:FindNearestEntity(self:GetPos(), self.TargetsToIgnore))
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

		self.ZapRange = self.ZapRange - (self.Decay * (tr.HitWorld and 2 or 1))
		self:Zap(self:GetTarget())
		self.Kills = self.Kills + 1

		if self.Kills >= self.MaxChain then
			timer.Stop(timername)
			timer.Remove(timername)
			self:Remove()
			return
		end
	end)
end

function ENT:Zap(ent)
	local att = ent:GetAttachment(2) and ent:GetAttachment(2).Pos or ent:EyePos()

	util.ParticleTracerEx(self:GetUpgraded() and "waw_lightrifle_jump_2" or "waw_lightrifle_jump", self:GetPos(), att, false, self:GetOwner():EntIndex(), 0)

	self:EmitSound("TFA_BO3_WAFFE.Jump")
	ent:EmitSound("weapons/tfa_bo3/wunderwaffe/projectile/wpn_tesla_jump.wav", SNDLVL_NORM, math.random(95,105), 1, CHAN_STATIC)

	self:SetPos(att)

	ent:WAWBlastXInfect(math.Rand(2,4), self:GetAttacker(), self:GetInflictor(), self:GetUpgraded())
	self.TargetsToIgnore[self.Kills - 1] = ent
end

function ENT:FindNearestEntity(pos, tab)
	local nearbyents = {}
	local ply = self:GetOwner()
	for k, v in pairs(ents.FindInSphere(pos, self.ZapRange)) do
		if v:IsNPC() or v:IsNextBot() or (not nzombies and v:IsPlayer()) then
			if v:WAWIsBlastXInfected() then continue end
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
			if v == ply then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(ply) and ply:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

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
			if v:WAWIsBlastXInfected() then continue end
			if not pvp_bool:GetBool() and v:IsPlayer() then continue end
			if v == ply then continue end
			if v:Health() <= 0 then continue end
			if v:IsPlayer() and IsValid(ply) and ply:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, ply) then continue end

			if !table.HasValue(tab, v) then
				nearestent = v
				break
			end
		end
	end

	return nearestent
end
