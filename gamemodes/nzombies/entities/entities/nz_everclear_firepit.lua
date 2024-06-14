AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Firepit"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Delay = 10
ENT.Range = 190

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

	self:EmitSound("bo1_overhaul/nap/explode.mp3", 511)

	if CLIENT then return end
	local particles = ents.Create("info_particle_system")
	particles:SetKeyValue("start_active", "1")
	particles:SetKeyValue("effect_name", "napalm_postdeath_napalm")
	particles:SetPos(self:GetPos())
	particles:SetAngles(self:GetAngles())
	particles:Spawn()
	particles:Activate()
	particles:Fire("kill", "", self.Delay)

	SafeRemoveEntityDelayed(self, self.Delay)
end

function ENT:Think()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
			if v:IsValidZombie() then
				local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
				local health = tonumber(nzCurves.GenerateHealthCurve(round))

				local damage = DamageInfo()
				damage:SetDamageType(DMG_BURN)
				damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
				damage:SetInflictor(self)
				damage:SetDamagePosition(v:WorldSpaceCenter())
				damage:SetDamageForce(vector_origin)
				damage:SetDamage(health / 10)

				if v.NZBossType or string.find(v:GetClass(), "nz_zombie_boss") then
					damage:SetDamage(math.max(50, ent:GetMaxHealth() / 50))
					damage:ScaleDamage(math.min(math.Round(nzRound:GetNumber()/10, 1), 1))
				end

				v:TakeDamageInfo(damage)
			end
		end
	end

	self:NextThink(CurTime() + (1/3))
	return true
end

function ENT:OnRemove()
end
