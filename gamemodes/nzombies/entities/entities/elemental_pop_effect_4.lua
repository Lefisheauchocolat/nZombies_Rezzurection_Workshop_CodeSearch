AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Thunderwall"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Kills = 0
ENT.MaxKills = 20
ENT.Range = 500

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

	local ply = self:GetAttacker()
	local wep = self:GetInflictor()
	if IsValid(ply) and IsValid(wep) and wep.IsTFAWeapon then
		self:SetParent(nil)
		self:SetPos(ply:GetShootPos())

		wep:EmitGunfireSound("NZ.POP.Thunderwall.Shoot")

		if SERVER then
			local ball = ents.Create("bo3_ww_thundergun")
			ball:SetModel("models/dav0r/hoverball.mdl")
			ball:SetPos(ply:GetShootPos())
			ball:SetOwner(ply)
			ball:SetAngles(ply:GetAimVector():Angle())

			ball:Spawn()

			local dir = ply:GetAimVector()
			dir:Mul(1000)

			ball:SetVelocity(dir)

			local phys = ball:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetVelocity(dir)
			end

			ball:SetOwner(ply)
			ball.Inflictor = wep
		end
	end

	if CLIENT then return end
	local ply = self:GetAttacker()
	local wep = self:GetInflictor()
	local ang = math.cos(math.rad(45))

	for _, ent in pairs(ents.FindInCone(ply:GetShootPos(), wep:GetAimVector(), self.Range, ang)) do
		if ent:IsValidZombie() then
			if ent == ply then continue end
			if ent:Health() <= 0 then continue end
			if self.Kills >= self.MaxKills then break end

			self:ThundergunDamage(ent)
		end
	end
	self:Remove()
end

function ENT:ThundergunDamage(ent)
	if CLIENT then return end
	local ply = self:GetAttacker()
	local wep = self:GetInflictor()

	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(ply)
	damage:SetInflictor(wep)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(ent:GetUp()*20000 + wep:GetAimVector()*50000)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "nz_zombie_boss")) then
		damage:SetDamage(math.max(2000, ent:GetMaxHealth() / 6))
		damage:ScaleDamage(math.Round(nzRound:GetNumber()/8))
	end

	ent:TakeDamageInfo(damage)
	self.Kills = self.Kills + 1
end
