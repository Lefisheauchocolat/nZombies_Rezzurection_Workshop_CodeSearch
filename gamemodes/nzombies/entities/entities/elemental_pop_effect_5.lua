AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Cryofreeze"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.MaxKills = 12
ENT.Kills = 0
ENT.Range = 240

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

function ENT:Initialize()
	self:SetParent(nil)
	self:SetModel("models/dav0r/hoverball.mdl")

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self:EmitSound("NZ.POP.Cryofreeze.Wind")
	ParticleEffect("bo3_aat_freeze_explode", self:GetPos(), angle_zero)

	if CLIENT then return end
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsValidZombie() and v:Health() > 0 then
			if v.NZBossType then continue end
			if string.find(v:GetClass(), "nz_zombie_boss") then continue end
			if v == self:GetOwner() then continue end
			if v:IsATTCryoFreeze() then continue end
			self.Kills = self.Kills + 1
			if self.Kills > self.MaxKills then break end

			v:ATTCryoFreeze(math.Rand(1.2,1.4), self:GetAttacker(), self:GetInflictor())
		end
	end
	self:Remove()
end
