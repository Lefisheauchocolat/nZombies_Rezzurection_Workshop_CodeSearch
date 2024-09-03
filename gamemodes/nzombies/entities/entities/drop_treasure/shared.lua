AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName		= "drop_treasure"
ENT.Author			= "Zet0r"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DropType")

	self:NetworkVar("Bool", 1, "Blinking")

	self:NetworkVar("Float", 0, "BlinkTime")
	self:NetworkVar("Float", 1, "KillTime")
end

local vulturedrops = {
	["points"] =  {
		id = "points",
		model = Model("models/powerups/w_vulture_points.mdl"),
		blink = true,
		effect = function(ply)
			ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3") 
			ply:EmitSound("nz_moo/powerups/vulture/vulture_money.mp3") 
			ply:GivePoints(math.random(10, 20) * 5)
			return true
		end,
		timer = 30,
		draw = function(self)
			self:DrawModel()

			if !self.loopglow or !IsValid(self.loopglow) then
				local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
				local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
				local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

				if nzMapping.Settings.powerupstyle then
					local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
					self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
					self.loopglow:SetControlPoint(2, colorvec1)
					self.loopglow:SetControlPoint(3, colorvec2)
					self.loopglow:SetControlPoint(4, colorvec3)
					self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
				else
					self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
					self.loopglow:SetControlPoint(2, colorvec1)
					self.loopglow:SetControlPoint(3, colorvec2)
					self.loopglow:SetControlPoint(4, colorvec3)
					self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
				end
			end
		end,
		initialize = function(self)
			self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 
		end,
	},
	["ammo"] = {
		id = "ammo",
		model = Model("models/powerups/w_vulture_ammo.mdl"),
		blink = true,
		effect = function(ply)
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) then
				local max = wep.Primary.MaxAmmo or nzWeps:CalculateMaxAmmo(wep:GetClass(), wep:HasNZModifier("pap"))
				local give = math.Round(max/math.random(10, 20))
				local ammo = wep:GetPrimaryAmmoType()
				local cur = ply:GetAmmoCount(ammo)

				if (cur + give) > max then give = max - cur end
				if give <= 0 then return end

				ply:GiveAmmo(give, ammo)
				ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3")
				return true
			end
		end,
		timer = 30,
		draw = function(self)
			self:DrawModel()

			if !self.loopglow or !IsValid(self.loopglow) then
				local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
				local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
				local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

				if nzMapping.Settings.powerupstyle then
					local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
					self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
					self.loopglow:SetControlPoint(2, colorvec1)
					self.loopglow:SetControlPoint(3, colorvec2)
					self.loopglow:SetControlPoint(4, colorvec3)
					self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
				else
					self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
					self.loopglow:SetControlPoint(2, colorvec1)
					self.loopglow:SetControlPoint(3, colorvec2)
					self.loopglow:SetControlPoint(4, colorvec3)
					self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
				end
			end
		end,
		initialize = function(self)
			self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 
		end,
	},
}

function ENT:Draw()
	vulturedrops[self:GetDropType()].draw(self)
end

function ENT:Initialize()
	if SERVER then
		self:SetDropType(table.Random(vulturedrops).id)
	end

	self:SetModel(vulturedrops[self:GetDropType()].model)
	self:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")

	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:UseTriggerBounds(true, 8)

	self:SetBlinkTime(CurTime() + vulturedrops[self:GetDropType()].timer - 5)
	self:SetKillTime(CurTime() + vulturedrops[self:GetDropType()].timer)
	self:SetBlinking(false)
	self.NextDraw = CurTime()

	vulturedrops[self:GetDropType()].initialize(self)

	if CLIENT then return end
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

function ENT:StartTouch(ent)
	if IsValid(ent) and ent:IsPlayer() and vulturedrops[self:GetDropType()].effect(ent) then
		self:Remove()
	end
end

function ENT:Think()
	if not self:GetBlinking() and self:GetBlinkTime() < CurTime() and vulturedrops[self:GetDropType()].blink then
		self:SetBlinking(true)
	end

	if self:GetBlinking() and self.NextDraw < CurTime() then
		local time = self:GetKillTime() - self:GetBlinkTime()
		local final = math.Clamp(self:GetKillTime() - CurTime(), 0.1, 1)
		final = math.Clamp(final / time, 0.1, 1)

		self:SetNoDraw(not self:GetNoDraw())
		self.NextDraw = CurTime() + math.Clamp(1 * final, 0.1, 1)
	end

	if SERVER then
		if self:GetKillTime() < CurTime() then
			self:StopParticles()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	if IsValid(self) then
		self:StopParticles()
		if SERVER and !vulturedrops[self:GetDropType()].nopoof then
			local fx = EffectData()
			fx:SetOrigin(self:WorldSpaceCenter()) //position
			fx:SetAngles(angle_zero) //angle
			fx:SetNormal(Vector(0.65,0.65,0.65)) //size (dont ask why its a vector)
			fx:SetFlags(3) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

			local filter = RecipientFilter()
			filter:AddPVS(self:GetPos())
			if filter:GetCount() > 0 then
				util.Effect("nz_powerup_poof", fx, true, filter)
			end
		end
	end
end
