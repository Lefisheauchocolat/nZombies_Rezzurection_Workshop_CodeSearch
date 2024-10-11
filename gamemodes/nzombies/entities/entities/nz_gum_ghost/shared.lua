AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Gum Ghost"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.Delay = 10

function ENT:Initialize()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetRenderFX(15)

	ParticleEffectAttach("nz_perks_chuggabud_ghost", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	self:EmitSound("NZ.ChuggaBud.Charge")
	local ply = self:GetOwner()
	if IsValid(ply) then
		ply.GumDoppelganger = self
	end

	local gum = nzGum:GetData("doppelganger")
	if gum and gum.time then
		self.Delay = gum.time
	end

	if CLIENT then return end
	self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
	self:DropToFloor()
	self:SetTrigger(true)

	SafeRemoveEntityDelayed(self, self.Delay)
end

function ENT:Think()
	local ply = self:GetOwner()

	if CLIENT then
		local ang = ply:GetAngles()
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
		if not IsValid(ply) then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	local ply = self:GetOwner()
	if IsValid(ply) and ply.GumDoppelganger then
		ply.GumDoppelganger = nil
	end

	self:StopParticles()
	self:SetTargetPriority(TARGET_PRIORITY_NONE)
	ParticleEffect("nz_perks_chuggabud_tp", self:GetPos(), angle_zero)
	sound.Play("nzr/2022/perks/chuggabud/teleport_out_0"..math.random(0,1)..".wav", self:GetPos(), SNDLVL_TALKING, math.random(95,105), 1)
end
