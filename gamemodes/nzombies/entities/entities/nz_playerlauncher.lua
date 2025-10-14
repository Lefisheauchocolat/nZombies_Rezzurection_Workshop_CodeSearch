AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Pew Pew"
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:Initialize()
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_FLYGRAVITY)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetModel("models/dav0r/hoverball.mdl")

	if CLIENT then return end
	local ply = self:GetOwner()
	if IsValid(ply) then
		ply:SetNoTarget(true)
		ply:SetTargetPriority(TARGET_PRIORITY_NONE)
	end

	self:EmitSound(self.LaunchSound or "NZ.Jumppad.Launch")
	self.killtime = CurTime() + self.Delay
end

function ENT:Think()
	if SERVER then
		local ply = self:GetOwner()
		if not IsValid(ply) then
			self:Remove()
			return false
		end

		if self.killtime < CurTime() then
			self:Remove()
			return false
		end

	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	local ply = self:GetOwner()
	if IsValid(ply) and ply.GetNZLauncher and IsValid(ply:GetNZLauncher()) then
		ply:SetNZLauncher(nil)
	end

	if CLIENT then return end
	self:EmitSound("NZ.Jumppad.Fun")

	local ply = self:GetOwner()
	if IsValid(ply) then
		hook.Call("PlayerJumpPadLanded", nzJumps, ply, self)
		if IsValid(ply:GetNZLauncher()) then
			ply:EmitSound(self.LandingSound or "NZ.Jumppad.Land")
		end

		ply:SetNoTarget(false)
		if !nzPowerUps:IsPlayerPowerupActive(ply, "zombieblood") and TFA.WWNoTargetIngore(ply) then
			ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		end
	end
end

if CLIENT then
	function ENT:GetNZTargetText()
		return "WEEEEEEE!"
	end
	function ENT:Draw()
		if nzRound:InState(ROUND_CREATE) then
			self:DrawModel()
		end
	end
end
