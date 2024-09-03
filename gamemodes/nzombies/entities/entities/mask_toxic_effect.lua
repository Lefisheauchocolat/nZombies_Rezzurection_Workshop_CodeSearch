AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Mask Toxic Cloud"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Delay = 6
ENT.Kills = 0
ENT.MaxKills = 6
ENT.Range = 140

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

function ENT:Initialize()
	self:SetModel("models/dav0r/hoverball.mdl")

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self:EmitSound("NZ.POP.BlastFurnace.Expl")
	self:EmitSound("NZ.AAT.Fallout.Start")
	self:EmitSound("NZ.AAT.Fallout.Loop")

	local p = self:GetParent()
	if IsValid(p) then
		ParticleEffect("bo3_aat_fallout_start", p:WorldSpaceCenter(), angle_zero)
	else
		ParticleEffect("bo3_aat_fallout_start", self:GetPos(), angle_zero)
	end

	ParticleEffectAttach("bo3_aat_fallout_loop", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	self:SetParent(nil)

	if CLIENT then return end
	self.killtime = CurTime() + self.Delay
	self:SetTrigger(true)
end

local time
function ENT:Think()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
			if self.Kills >= self.MaxKills then break end
			if v == self:GetOwner() then continue end
			if v:IsAATRadiated() then continue end
			if (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 then
				time = math.Rand(3,4)

				v:AATRadiation(time, self:GetAttacker(), self:GetInflictor(), false)
				self.Kills = self.Kills + 1
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
	self:StopParticles()
	self:StopSound("NZ.AAT.Fallout.Loop")
end
