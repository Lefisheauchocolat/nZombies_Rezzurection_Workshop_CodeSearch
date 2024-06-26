AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Blast Furnace"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Delay = 1.5
ENT.Kills = 0
ENT.MaxKills = 12
ENT.Range = 200

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

function ENT:Initialize()
	local p = self:GetParent()
	if IsValid(p) then
		if p:IsPlayer() then
			self.MaxKills = 20
		else
			self:SetParent(nil)
		end
	end

	self:SetModel("models/dav0r/hoverball.mdl")

	self:SetNoDraw(true)
	self:DrawShadow(false)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)

	self:EmitSound("NZ.POP.BlastFurnace.Expl")
	self:EmitSound("NZ.POP.BlastFurnace.Sweet")

	ParticleEffectAttach("bo3_aat_blastfurnace", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	self.killtime = CurTime() + self.Delay

	if CLIENT then return end
	self:SetTrigger(true)
end

local time
function ENT:Think()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
			if self.Kills >= self.MaxKills then break end
			if v == self:GetOwner() then continue end
			if v:AATIsBlastFurnace() then continue end
			if (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 then
				time = math.random(2,5)*0.5

				v:AATBlastFurnace(time, self:GetAttacker(), self:GetInflictor())
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
