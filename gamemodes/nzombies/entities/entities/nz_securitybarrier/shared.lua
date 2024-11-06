AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Hydrogen Defense Barrier"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

function ENT:Initialize()
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:DrawShadow(false)

	self:EmitSound("nz_moo/powerups/security/zct_barrier.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_AUTO)
end

function ENT:OnRemove()
	self:StopSound("nz_moo/powerups/security/zct_recharge.wav")
	self:EmitSound("nz_moo/powerups/security/zct_barrier_hit.wav", SNDLVL_65dB, math.random(97,103), 1, CHAN_ITEM)
	if self.loopeffect and IsValid(self.loopeffect) then
		self.loopeffect:StopEmission()
	end
end
