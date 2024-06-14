AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Frost Bite"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Delay = 6
ENT.Range = 160
ENT.KillRange = 240
ENT.Duration = 10

ENT.MaxKills = 12
ENT.Kills = 0

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

function ENT:Initialize()
	local p = self:GetParent()
	if IsValid(p) then
		p:EmitSound("NZ.Winters.Start")
		ParticleEffect("bo3_aat_freeze_explode", p:WorldSpaceCenter(), angle_zero)
	else
		self:EmitSound("NZ.Winters.Start")
	end

	self:SetModel("models/dav0r/hoverball.mdl")

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self:EmitSound("NZ.Winters.Loop")

	ParticleEffectAttach("nz_perks_winters", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.KillRange)) do
		if self.Kills >= self.MaxKills then break end
		if not (v:IsNPC() or v:IsNextBot()) then continue end
		if v:Health() <= 0 then continue end
		if v:IsATTCryoFreeze() then continue end
		if v.NZBossType then continue end
		if string.find(v:GetClass(), "nz_zombie_boss") then continue end
		if v.IsAATTurned and v:IsAATTurned() then continue end

		v:ATTCryoFreeze(math.Rand(1.4,1.6), self:GetAttacker(), self:GetInflictor())
		self.Kills = self.Kills + 1
	end

	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		local pos = self:GetPos()
		local ply = self:GetOwner()

		for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
			if not (v:IsNPC() or v:IsNextBot()) then continue end
			if v:Health() <= 0 then continue end
			if v:IsWintersWailSlow() then continue end
			if v:IsATTCryoFreeze() then continue end
			if string.find(v:GetClass(), "nz_zombie_boss") then continue end
			if v.IsAATTurned and v:IsAATTurned() then continue end

			v:WintersWailSlow(self.Duration, 0.1)
		end

		if self.killtime < CurTime() then
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

