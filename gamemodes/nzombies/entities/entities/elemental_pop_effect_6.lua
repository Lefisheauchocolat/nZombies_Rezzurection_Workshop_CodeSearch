AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Turned"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Delay = 25
ENT.Dance = false
ENT.Range = 240

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

function ENT:Initialize()
	self:SetModel("models/dav0r/hoverball.mdl")

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	if CLIENT then return end
	if math.random(100) >= 70 then
		self.Dance = true
		self.Delay = 11
	end

	local p = self:GetParent()
	if IsValid(p) and p:Health() > 0 and p:IsValidZombie() and not p:IsAATTurned() and (!p.IsMooSpecial or (p.IsMooSpecial and !p.MooSpecialZombie)) then
		if p:GetClass() == "nz_zombie_boss_astro" then
			p:AATTurned(10, self:GetAttacker(), true)
			p:SetOwner(self:GetAttacker())
			return
		end

		p:AATTurned(self.Delay, self:GetAttacker(), self.Dance)
		p:SetOwner(self:GetAttacker())
	else
		for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
			if v:IsValidZombie() and v:Health() > 0 then
				if v:IsAATTurned() then continue end
				if v:GetClass() == "nz_zombie_boss_astro" then
					v:AATTurned(10, self:GetAttacker(), true)
					v:SetOwner(self:GetAttacker())
					break
				end
				if v.IsMooSpecial and !v.MooSpecialZombie then continue end

				v:AATTurned(self.Delay, self:GetAttacker(), self.Dance)
				v:SetOwner(self:GetAttacker())
				break
			end
		end
	end
	self:Remove()
end
