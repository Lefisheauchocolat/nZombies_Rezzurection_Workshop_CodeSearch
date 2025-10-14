AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Trial Player Watcher"
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Radius")
end

function ENT:Initialize()
	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)

	self:SetRadius(math.Clamp(self:GetRadius(), 50, 900))
	self:EmitSound("NZ.Trials.Start")
	self:EmitSound("NZ.Trials.StartLfe")

	if CLIENT then return end
	self.SqrRadius = self:GetRadius()^2
end

function ENT:Think()
	if SERVER then
		local ply = self:GetOwner()
		if not IsValid(ply) then
			self:Remove()
			return false
		end

		local ct = CurTime()
		if ply:GetPos():DistToSqr(self:GetPos()) > self.SqrRadius then
			if nzRound:GetState() == ROUND_PREP then
				ply.trialcoyotetime = ct + 25
				ply:SetNW2Float("nzStopWatch", ply.trialcoyotetime)
			end
			if not ply.trialcoyotetime then
				ply.trialcoyotetime = ct + 5
				ply:SetNW2Float("nzStopWatch", ply.trialcoyotetime)
			end

			if ply.trialcoyotetime and ply.trialcoyotetime < ct then
				self:Remove()
				return false
			end
		else
			if ply.trialcoyotetime then
				ply.trialcoyotetime = nil
				ply:SetNW2Float("nzStopWatch", 0)
			end
		end
	end

	self:NextThink(CurTime() + 0.25)
	return true
end

function ENT:OnRemove()
	self:StopParticles()
	if SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) then
			ply.trialcoyotetime = nil
			ply:SetNW2Float("nzStopWatch", 0)
		end
	end
end
