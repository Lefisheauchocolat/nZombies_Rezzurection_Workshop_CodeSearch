AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Hell's Retriever"

--[Parameters]--
ENT.Delay = 20

ENT.Kills = 0
ENT.MaxKills = 4
ENT.MaxKillsPaP = 6

ENT.Range = 100
ENT.Decay = 20
ENT.RPM = 120

DEFINE_BASECLASS( ENT.Base )

local sp = game.SinglePlayer()
local pvp_bool = GetConVar("sbox_playershurtplayers")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Returning")
	self:NetworkVar("Bool", 2, "Upgraded")

	self:NetworkVar("Int", 0, "Charge")

	self:NetworkVar("Entity", 0, "Target")
	self:NetworkVar("Entity", 2, "Inflictor")
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end

	local ply = self:GetOwner()
	local ent = data.HitEntity
	local hitpos = data.HitPos - data.HitNormal
	if (ent:IsWorld() and ent:IsSolid()) and IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
		phys:SetBuoyancyRatio(0)
	end

	if IsValid(ent) and not ent:IsPlayer() then
		local damage = DamageInfo()
		damage:SetDamage(15)
		damage:SetDamageType(DMG_SLASH)
		damage:SetAttacker(IsValid(ply) and ply or self)
		damage:SetInflictor(self)
		damage:SetDamagePosition(data.HitPos)

		ent:TakeDamageInfo(damage)
	end

	ParticleEffect(self:GetUpgraded() and "bo2_tomahawk_hitworld_2" or "bo2_tomahawk_hitworld", hitpos, data.HitNormal:Angle() - Angle(90,0,0))

	timer.Simple(0, function()
		if not IsValid(self) then return end

		self:SetMoveType(MOVETYPE_FLYGRAVITY)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		self:SetPos(hitpos)

		self:SetActivated(true)
	end)
end

function ENT:Touch(ent)
	local ply = self:GetOwner()
	if ent == ply and self:GetReturning() then
		SafeRemoveEntity(self)
		return
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self,...)

	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:PhysicsInitSphere(0.2, "metal_bouncy")
	self:UseTriggerBounds(true, 2)

	self.TargetsToIgnore = {}
	self:SetReturning(false)
	self:SetActivated(false)
	self.NextPrimaryFire = CurTime()
	self.Range = self.Range * self:GetCharge()
	self.RPM = self.RPM + (self:GetCharge()*20)

	if self:GetUpgraded() then
		ParticleEffectAttach("bo2_tomahawk_trail_2", PATTACH_POINT_FOLLOW, self, 1)
		self.MaxKills = self.MaxKillsPaP
		self.color = Color(160, 240, 255, 255)
		self:SetSkin(1)
	else
		ParticleEffectAttach("bo2_tomahawk_trail", PATTACH_POINT_FOLLOW, self, 1)
		self.color = Color(255, 100, 90, 255)
	end

	self.killtime = CurTime() + self.Delay

	self:NextThink(CurTime())

	if CLIENT then return end
	self:SetTrigger(true)
end

local ammoclasses = {
	["item_ammo_357"] = true,
	["item_ammo_357_large"] = true,
	["item_ammo_ar2"] = true,
	["item_ammo_ar2_large"] = true,
	["item_ammo_ar2_altfire"] = true,
	["item_ammo_crossbow"] = true,
	["item_healthkit"] = true,
	["item_healthvial"] = true,
	["item_ammo_pistol"] = true,
	["item_ammo_pistol_large"] = true,
	["item_rpg_round"] = true,
	["item_box_buckshot"] = true,
	["item_ammo_smg1"] = true,
	["item_ammo_smg1_large"] = true,
	["item_ammo_smg1_grenade"] = true,
	["item_battery"] = true,
	["npc_grenade_frag"] = true,
	["ammo_357"] = true,
	["ammo_crossbow"] = true,
	["ammo_glockclip"] = true,
	["ammo_357"] = true,
	["ammo_9mmbox"] = true,
	["ammo_mp5clip"] = true,
	["ammo_mp5grenades"] = true,
	["ammo_rpgclip"] = true,
	["ammo_buckshot"] = true,
	["ammo_gaussclip"] = true,
}

function ENT:Think()
	if CLIENT then
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles() + Angle(1500,0,0)*FrameTime())
	end

	if CLIENT and DynamicLight and dlight_cvar:GetBool() then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetAttachment(1).Pos
			dlight.r = self.color.r
			dlight.g = self.color.g
			dlight.b = self.color.b
			dlight.brightness = 0.5
			dlight.Decay = 2000
			dlight.Size = 200
			dlight.dietime = CurTime() + 0.5
		end
	end

	local ply = self:GetOwner()
	if SERVER then
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 12)) do
			if ammoclasses[v:GetClass()] and not IsValid(v:GetParent()) then
				v:SetParent(self)

				if not self.PickedupAmmo then self.PickedupAmmo = {} end
				table.insert(self.PickedupAmmo, v)
				break
			end

			if self.Kills >= self.MaxKills then continue end
			if not self:GetActivated() then continue end
			if self.NextPrimaryFire > CurTime() then continue end

			if (v:IsNPC() or v:IsNextBot() or v:IsPlayer()) and v:Health() > 0 then
				if not pvp_bool:GetBool() and v:IsPlayer() then continue end
				if v == ply then continue end
				if self.TargetsToIgnore and self.TargetsToIgnore[v:GetCreationID()] then continue end

				self:InflictDamage(v)
				break
			end
		end

		if self:GetActivated() and self.NextPrimaryFire < CurTime() then
			local target = self:GetTarget()
			if (not IsValid(target) or target:Health() <= 0) then
				self:SetTarget(self:FindNearestEntity(self:GetPos(), self.Range, self.TargetsToIgnore))

				if not IsValid(self:GetTarget()) then
					self:StopParticles()
					ParticleEffectAttach(self:GetUpgraded() and "bo2_tomahawk_return_2" or "bo2_tomahawk_return", PATTACH_POINT_FOLLOW, self, 1)
					self:SetReturning(true)
				end
			end

			if (IsValid(target) and target:Health() > 0) then
				local pos = target:EyePos()
				local headbone = target:LookupBone("ValveBiped.Bip01_Head1")
				if !headbone then headbone = target:LookupBone("j_head") end
				if headbone then
					pos = target:GetBonePosition(headbone)
				end

				local norm = (pos - self:GetPos()):GetNormalized()
				self:SetPos(self:GetPos() + norm*20)
				self:SetLocalVelocity(norm*100)
			end
		end

		if self:GetReturning() then
			if self:GetActivated() then
				self:EmitSound("TFA_BO2_TOMAHAWK.Incoming")
				self:SetActivated(false)
			end

			if ply:Alive() then
				local norm = (ply:GetShootPos() - self:GetPos()):GetNormalized()
				self:SetPos(LerpVector(0.15, self:GetPos(), ply:GetShootPos()))
				self:SetLocalVelocity(norm * 400)
			else
				SafeRemoveEntity(self)
				return false
			end
		end

		if self.killtime < CurTime() and not self:GetReturning() then
			self:SetReturning(true)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:FindNearestEntity(pos, range, tab)
	local nearestEnt

	for _, v in RandomPairs(ents.FindInSphere(pos, range)) do
		if v:IsNPC() or v:IsNextBot() then
			if v == self:GetOwner() then continue end
			if v:Health() <= 0 then continue end
			if tab[v:GetCreationID()] then continue end

			nearestEnt = v
			local tr = util.TraceLine({
				start = pos,
				endpos = nearestEnt:EyePos(),
				filter = self,
				mask = MASK_SOLID_BRUSHONLY,
			})

			self.Range = self.Range - (self.Decay * (tr.HitWorld and 2 or 1))
			break
		end
	end

	return nearestEnt
end

function ENT:InflictDamage(ent)
	local ply = self:GetOwner()

	self.Damage = self.mydamage or self.Damage
	self.Kills = self.Kills + 1
	self.TargetsToIgnore[ent:GetCreationID()] = ent
	if self.Kills >= self.MaxKills then
		self:SetReturning(true)
		self:StopParticles()
		ParticleEffectAttach(self:GetUpgraded() and "bo2_tomahawk_return_2" or "bo2_tomahawk_return", PATTACH_POINT_FOLLOW, self, 1)
	end

	ent:EmitSound("TFA_BO2_TOMAHAWK.Impact")

	local damage = DamageInfo()
	damage:SetDamage(self.Damage * self:GetCharge())
	damage:SetDamageType(DMG_SLOWBURN)
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(self)
	damage:SetDamageForce(vector_up)

	local hitpos = ent:EyePos()
	local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !headbone then headbone = ent:LookupBone("j_head") end
	if headbone then
		hitpos = ent:GetBonePosition(headbone)
	end
	damage:SetDamagePosition(hitpos)

	ParticleEffect(self:GetUpgraded() and "bo2_tomahawk_impact_2" or "bo2_tomahawk_impact", hitpos, Angle(0,0,0))

	ent:TakeDamageInfo(damage)

	self:SetPos(hitpos)
	self:SetLocalVelocity(vector_origin)

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableGravity(false)
		phys:EnableDrag(false)
	end

	self.NextPrimaryFire = CurTime() + (60 / self.RPM)
	self:SetTarget(self:FindNearestEntity(self:GetPos(), self.Range, self.TargetsToIgnore))
end

function ENT:OnRemove()
	local ply = self:GetOwner()
	local wep = self:GetInflictor()

	if IsValid(wep) then
		wep:EmitSound("TFA_BO2_TOMAHAWK.Catch")
	end

	local pickup = self.PickedupAmmo
	if SERVER and pickup then
		for k, v in pairs(pickup) do
			if IsValid(v) then
				v:SetParent(nil)
				v:SetPos(ply:GetShootPos())
			end
		end
		self.PickedupAmmo = nil
	end

	timer.Simple(6, function()
		if not (IsValid(ply) and IsValid(wep) and ply:Alive()) then return end

		if not sp or (sp and SERVER) then
			ply:EmitSound("TFA_BO2_TOMAHAWK.Cooldown")
		end

		wep:SetClip1(1)
		wep:SetCharge(0)
		wep:SetChargeTime(CurTime() + wep.ChargeTime)
	end)

	return BaseClass.OnRemove(self)
end
