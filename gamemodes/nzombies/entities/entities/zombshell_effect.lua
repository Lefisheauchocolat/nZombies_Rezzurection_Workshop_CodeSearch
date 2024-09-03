AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "ZombShell"
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.Delay = 5

function ENT:Initialize()
	self:SetModel("models/props_junk/popcan01a.mdl")

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self.killtime = CurTime() + self.Delay

	self:EmitSound("NZ.ZombShell.Start")
	self:EmitSound("NZ.ZombShell.Loop")
	ParticleEffectAttach("nz_perks_zombshell", PATTACH_ABSORIGIN_FOLLOW, self, 0)
end

function ENT:Think()
	/*if CLIENT and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 220
			dlight.g = 255
			dlight.b = 100
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 256
			dlight.dietime = CurTime() + 0.1
		end
	end*/

	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 100)) do
			if v:IsValidZombie() and v:Health() > 0 then
				if (v.NZBossType or v.IsMooBossZombie) then continue end
				if v.IsAATTurned and v:IsAATTurned() then continue end

				v:ZombSlow(0.15)
			end
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
	self:StopSound("NZ.ZombShell.Loop")
	self:EmitSound("NZ.ZombShell.End")
end
