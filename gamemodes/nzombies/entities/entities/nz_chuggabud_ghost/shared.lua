AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Chugga Buddy"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.Delay = 10

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Screamed")
end

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetRenderFX(15)

	self:SetScreamed(false)
	ParticleEffectAttach("nz_perks_chuggabud_ghost", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	self:EmitSound("NZ.ChuggaBud.Charge")

	if CLIENT then return end
	self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
	self:DropToFloor()
	self:SetTrigger(true)

	SafeRemoveEntityDelayed(self, self.Delay)
end

function ENT:Think()
	local ply = self:GetOwner()

	if CLIENT then
		local ang = ply:GetAngles()
		if self:GetScreamed() then
			ang = (ply:GetPos() - self:GetPos()):Angle()
		end

		local fwd = Angle(0, ang.yaw, ang.roll)

		self:SetSequence(ply:GetSequence())
		self:SetPlaybackRate(ply:GetPlaybackRate())
		self:SetCycle(ply:GetCycle())
		self:SetAngles(fwd)

		for i = 0, ply:GetNumPoseParameters() - 1 do
			local flMin, flMax = ply:GetPoseParameterRange(i)
			local sPose = ply:GetPoseParameterName(i)
			self:SetPoseParameter(sPose, math.Remap(ply:GetPoseParameter(sPose), 0, 1, flMin, flMax))
		end
	end

	if SERVER then
		local dot = (ply:GetPos() - self:GetPos()):Dot(ply:GetAimVector())

		if not self:GetScreamed() and ply:VisibleVec(self:WorldSpaceCenter()) and dot < 0 then
			self:SetScreamed(true)
			self:EmitSound("nzr/2022/perks/chuggabud/squeal1.wav", SNDLVL_NORM, 100, 1, CHAN_STATIC)
			SafeRemoveEntityDelayed(self, 0.33)
			return false
		end

		if not IsValid(ply) then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopParticles()
	self:SetTargetPriority(TARGET_PRIORITY_NONE)
	ParticleEffect("nz_perks_chuggabud_tp", self:GetPos(), angle_zero)
	sound.Play("nzr/2022/perks/chuggabud/teleport_out_0"..math.random(0,1)..".wav", self:GetPos(), SNDLVL_TALKING, math.random(95,105), 1)
end
