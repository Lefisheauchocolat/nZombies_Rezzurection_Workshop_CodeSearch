
-- Copyright (c) 2018-2020 TFA Base Devs

--joe biden: just shut up man.

AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Semtex Grenade (BO1)"

--[Parameters]--
--ENT.NZTacticalPaP = true
ENT.Delay = 2
--ENT.DelayPAP = 4
ENT.Range = 220
ENT.BeepDelay = 0.35
ENT.BeepSound = "TFA.BO1.SEMTEX.Alert"
ENT.NZThrowIcon = Material("nz_moo/huds/t5/hud_sticky_grenade.png", "unlitgeneric smooth")
ENT.NZThrowIcon_t5 = Material("nz_moo/huds/t5/hud_sticky_grenade.png", "unlitgeneric smooth")
ENT.NZThrowIcon_t7 = Material("vgui/icons/hud_sticky_grenade_t7.png", "unlitgeneric smooth")

DEFINE_BASECLASS( ENT.Base )

local nzombies = engine.ActiveGamemode() == "nzombies"
local blueflare = Material("effects/blueflare1")

function ENT:SetupDataTables()
	--self:NetworkVar("Bool", 0, "Upgraded")
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Blinking")
	self:NetworkVar("Float", 0, "BeepTimer")
end

function ENT:Draw()
	self:DrawModel()

	local attpos = self:GetAttachment(1)
	render.SetMaterial(blueflare)
	if self:GetBlinking() then
		render.DrawSprite(attpos.Pos, 8, 8, self.color)
	end
end

function ENT:StartTouch(ent)
	if ent == self:GetOwner() then return end
	if not ent:IsSolid() then return end
	if self:GetActivated() then return end

	if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
		self:SetParent(ent)
		self.HasParent = true
		print("im parented to flesh!")
		self:EmitSound("TFA_BO3_SEMTEX.Stick")
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)

		if nzombies then
			local ply = self:GetOwner()
			if nzombies and IsValid(ply) then
				ply:GivePoints(10)
			end
			if ent:IsValidZombie() and not (ent.NZBossType or ent.IsMooBossZombie) then
				ent:SetBlockAttack(true)
			end
		end

		self.killtime = CurTime() + self.Delay
		self:SetActivated(true)
	end
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end
	self:SetActivated(true)

	local ent = data.HitEntity
	local ang = self:GetAngles()

	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetAngles(ang)
		self:SetSolid(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		if IsValid(ent) and not ent:IsWorld() and IsValid(ent:GetPhysicsObject()) then
			self:SetParent(ent)
			print("im parented to physics!")
			self.HasParent = true
		end
	end)

	self.killtime = CurTime() + self.Delay
	self:EmitSound("TFA_BO3_SEMTEX.Stick")
	
	--[[if nzombies then
		self:MonkeyBombNZ()
	end]]

	phys:EnableMotion(false)
	phys:Sleep()
end

function ENT:Initialize()
	
	self:EmitSound("TFA.BO1.SEMTEX.Charge")
	BaseClass.Initialize(self)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	--self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:SetBeepTimer(CurTime() + self.BeepDelay)
	self.Delay = self.Delay
	self.HasParent = false
	
	--if self:GetUpgraded() then self.BeepSound = "TFA.BO1.SEMTEX.AlertUpgrade" end
	
	self.RangeSqr = self.Range * self.Range
	self.KillRangeSqr = 80^2
	
    local ply = self:GetOwner()
    if IsValid(ply) and ply:IsPlayer() then
        local pvcol = ply:GetPlayerColor()
        local pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)
		self.color = pcolor

    end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 0, self.color, true, 4, 0, 0.5, 0.1, "effects/laser_citadel1")
end

function ENT:Think()
	local parent = self:GetParent()
	
	if self:GetActivated() and CurTime() > self:GetBeepTimer() then
		if IsFirstTimePredicted() then self:EmitSound(self.BeepSound) end

		self.BeepDelay = math.max(self.BeepDelay - 0.05, 0.1)
		self:SetBlinking(not self:GetBlinking())
		self:SetBeepTimer(CurTime() + self.BeepDelay)
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:Explode()
			self:Remove()
			return false
		end
	end
	
	if self.HasParent and not IsValid(parent) then
		self:Explode()
		print("im an orphan!!")
	end

	self:NextThink(CurTime())
	return true
end

--[[function ENT:MonkeyBombNZ()
	if not self:GetUpgraded() then return end
	if CLIENT then return end
	self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
	UpdateAllZombieTargets(self)
end]]

function ENT:InflictDamage(ent, hitpos)
	if ent.IsAATTurned and ent:IsAATTurned() then return end

	local damage = DamageInfo()
	damage:SetDamage(5)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce(ent:GetForward())
	damage:SetDamageType(DMG_GENERIC)

	ParticleEffect("blood_impact_red_01", hitpos, angle_zero)
	ent:TakeDamageInfo(damage)
end

function ENT:DoExplosionEffect()
	local effectdata = EffectData()
	effectdata:SetOrigin(self:GetPos())

	util.Effect("HelicopterMegaBomb", effectdata)
	util.Effect("Explosion", effectdata)

	self:EmitSound("TFA.BO1.EXP.Explode")
	self:EmitSound("TFA.BO1.EXP.Flux")
	self:EmitSound("TFA.BO1.EXP.Lfe")
	self:EmitSound("TFA.BO1.EXP.Dirt")
end

function ENT:Explode()
	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_BLAST)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsWorld() then continue end
		if v:IsPlayer() and v ~= ply then continue end
		if IsValid(v:GetOwner()) and v:GetOwner():IsPlayer() then continue end
		if v.IsAATTurned and v:IsAATTurned() then continue end

		tr.endpos = v:WorldSpaceCenter()
		local tr1 = util.TraceLine(tr)
		if tr1.HitWorld then continue end
		local hitpos = tr1.Entity == v and tr1.HitPos or tr.endpos

		local dist = self:GetPos():DistToSqr(hitpos)
		local distfac = 1 - math.Clamp(dist/self.RangeSqr, 0, 0.5)
		local fuck = dist <= self.KillRangeSqr

		damage:SetDamage(self.Damage * distfac)
		damage:SetDamagePosition(hitpos)
		if v == ply then
			damage:SetDamage(50 * distfac)
		end

		if (v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "zombie_boss")) then
			damage:ScaleDamage(math.max(1, math.Round(nzRound:GetNumber()/10, 1)))
		elseif fuck and v:IsValidZombie() then
			v:SetHealth(1)
			damage:SetDamageType(DMG_MISSILEDEFENSE)
		end

		damage:SetDamageForce(v:GetUp()*math.random(15,20)*(1000*distfac) + (v:EyePos() - self:GetPos()):GetNormalized()*math.random(10,20)*1000)

		v:TakeDamageInfo(damage)

		damage:SetDamage(self.Damage)
		if fuck then
			damage:SetDamageType(DMG_BLAST)
		end
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end
