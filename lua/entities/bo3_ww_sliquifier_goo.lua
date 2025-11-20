AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Goo"

--[Sounds]--
ENT.SplashSound = "TFA_BO3_SLIPGUN.Splash"

--[Parameters]--
ENT.Delay = 10
ENT.DelayPAP = 20
ENT.BoundsMin = Vector(-47, -47, -2)
ENT.BoundsMax = Vector(47, 47, 2)
ENT.RestoreEnts = {}
ENT.RestorePlayers = {}

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetNoDraw(true)
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	if self:GetUpgraded() then
		ParticleEffectAttach("bo3_sliquifier_puddle_2", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(50, 255, 10, 255)
		self.BoundsMin = Vector(-50, -50, -2)
		self.BoundsMax = Vector(50, 50, 2)
		self.killtime = CurTime() + self.DelayPAP
	else
		ParticleEffectAttach("bo3_sliquifier_puddle", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		self.color = Color(120, 20, 255, 255)
		self.killtime = CurTime() + self.Delay
	end

	self:NextThink(CurTime())

	if CLIENT then return end
	//sound.EmitHint(SOUND_DANGER, self:GetPos(), 200, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)
	self:SetTrigger(true)
	if self:WaterLevel() > 1 then
		self:Remove()
		return
	end
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)
		if self.DLight then
			self.DLight.pos = self:GetPos()
			self.DLight.r = self.color.r
			self.DLight.g = self.color.g
			self.DLight.b = self.color.b
			self.DLight.brightness = 1
			self.DLight.Decay = 1000
			self.DLight.Size = 300
			self.DLight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		local inside_entities = {}

		for k, ent in ipairs(ents.FindInBox(self:LocalToWorld(self.BoundsMin), self:LocalToWorld(self.BoundsMax))) do
			if !ent:IsWorld() and ent:IsSolid() and !(ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()) and !self.RestoreEnts[ent:EntIndex()] then
				ent:EmitSound("TFA_BO3_SLIPGUN.Splash")
				ent:SetFriction(0.15)
				ent.SliqPuddle = self
				self.RestoreEnts[ent:EntIndex()] = {a = ent:GetCreationID(), b = ent:GetFriction()}
			end

			if ent:IsNPC() or ent:IsNextBot() then
				ent:BO3Slip(0.2)
			end

			if ent:IsPlayer() then
				local puddle = ent:GetSliqPuddle()
				if not IsValid(puddle) then
					self.RestorePlayers[ent:EntIndex()] = true
					ent:EmitSound("TFA_BO3_SLIPGUN.Splash")
					ent:SetSliqPuddle(self)
					ent:SetFriction(0.15)
				end
			end

			if self.RestoreEnts[ent:EntIndex()] then
				inside_entities[ent:EntIndex()] = true
			end

			if self.RestorePlayers[ent:EntIndex()] then
				inside_entities[ent:EntIndex()] = true
			end
		end

		for k, _ in pairs(self.RestorePlayers) do
			if !inside_entities[k] then
				local ply = Entity(k)
				if IsValid(ply) then
					local puddle = ply:GetSliqPuddle()
					if IsValid(puddle) and puddle ~= self then
						self.RestorePlayers[k] = nil
						continue
					end

					ply:SetFriction(1)
					ply:SetSliqPuddle(nil)
					self.RestorePlayers[k] = nil
				end
			end
		end

		for k, data in pairs(self.RestoreEnts) do
			if !inside_entities[k] then
				local ent = Entity(k)
				if IsValid(ent) then
					if ent:GetCreationID() ~= data.a then
						self.RestoreEnts[k] = nil
						continue
					end

					local puddle = ent.SliqPuddle
					if IsValid(puddle) and puddle ~= self then
						self.RestoreEnts[k] = nil
						continue
					end

					ent:SetFriction(data.b)
					ent.SliqPuddle = nil
					self.RestoreEnts[k] = nil
				end
			end
		end

		if self.killtime < CurTime() then
			self:StopParticles()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	for _, ply in ipairs(player.GetAll()) do
		if IsValid(ply:GetSliqPuddle()) and ply:GetSliqPuddle() == self then
			ply:SetFriction(1)
			ply:SetSliqPuddle(nil)
		end
	end

	for id, data in pairs(self.RestoreEnts) do
		local ent = Entity(id)
		if IsValid(ent) and ent:GetCreationID() == data.a then
			ent:SetFriction(data.b)
		end
	end
end