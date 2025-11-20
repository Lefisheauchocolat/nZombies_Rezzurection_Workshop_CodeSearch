AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Gravity Spike"

--[Sounds]--
ENT.VortexLoopSound = "TFA_WAW_SPIKE.Loop"
ENT.VortexEndSound = "TFA_WAW_SPIKE.End"

--[Parameters]--
ENT.Range = 108
ENT.ConsumptionRate = 1
ENT.TakenAmmo = 0
ENT.NZThrowIcon = Material("vgui/icon/gravity_spikes_codm.png", "unlitgeneric smooth")
ENT.NZHudIcon = Material("vgui/icon/gravity_spikes_codm.png", "smooth unlitgeneric")

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "AmmoCount")
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Float", 0, "NextAmmo")
	self:NetworkVar("Entity", 0, "Target")
end

if CLIENT then
	function ENT:GetNZTargetText()
		local ply = self:GetOwner()
		if not IsValid(ply) then return end
		return ply:Nick().."'s - Gravity Spikes"
	end
end

function ENT:PhysicsCollide(data, phys)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self:SetMoveType( MOVETYPE_NONE )
	self:DrawShadow( false )
	self:SetNoDraw( true )

	self:EmitSound( self.VortexLoopSound )

	ParticleEffectAttach( "waw_gravspike_vortex", PATTACH_ABSORIGIN_FOLLOW, self, 0 )

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	self:SetActivated( true )
	self:SetNextAmmo( CurTime() + engine.TickInterval() )
	self:NextThink(CurTime())
	self:PostSpawnEntity()

	if CLIENT then return end
	self.m_EntityCooldown = {}
end

function ENT:PostSpawnEntity()
	if CLIENT then return end
	local ply = self:GetOwner()

	local clone = ents.Create("waw_special_gravspike_clone")
	clone:SetModel("models/weapons/tfa_waw/grav_spike/w_grav_spike.mdl")
	clone:SetAngles(self:GetAngles())
	clone:SetOwner(IsValid(ply) and ply or self)
	clone:SetParent(self)
	clone:SetPos((self:GetPos() + self:GetRight()*-16))

	clone:Spawn()

	local clone2 = ents.Create("waw_special_gravspike_clone")
	clone2:SetModel("models/weapons/tfa_waw/grav_spike/w_grav_spike.mdl")
	clone2:SetAngles(self:GetAngles())
	clone2:SetOwner(IsValid(ply) and ply or self)
	clone2:SetParent(self)
	clone2:SetPos((self:GetPos() + self:GetRight()*16))

	clone2:Spawn()
end

function ENT:Think()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		local dlight = dlight or DynamicLight(self:EntIndex(), false)
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = self:GetActivated() and 180 or 255
			dlight.g = self:GetActivated() and 200 or 200
			dlight.b = self:GetActivated() and 255 or 100
			dlight.brightness = 1
			dlight.Decay = 1500
			dlight.Size = self:GetActivated() and math.random(256,258) or 64
			dlight.dietime = CurTime() + 0.5
		end
	end

	if SERVER then
		local wep = self:GetTarget()

		if not IsValid(self:GetOwner()) then
			self:StopSound(self.VortexLoopSound)
			SafeRemoveEntity(self)
			return false
		end

		if (self:GetAmmoCount() <= 0 or self.TakenAmmo >= 100 or (IsValid(wep) and wep:Clip1() <= 0)) and self:GetActivated() then
			self:SetActivated(false)

			self:StopParticles()

			ParticleEffect("waw_gravspike_implode", self:GetPos(), angle_zero)

			self:StopSound(self.VortexLoopSound)
			self:EmitSound(self.VortexEndSound)

			util.ScreenShake(self:GetPos(), 10, 10, 1.5, 400)

			SafeRemoveEntityDelayed(self, 30)
		end

		if self:GetAmmoCount() > 0 and self:GetActivated() then
			self:AOEEffect()
			if self:GetNextAmmo() < CurTime() then
				self:SetAmmoCount(math.max(self:GetAmmoCount()-5, 0))

				if IsValid(wep) then
					wep:SetClip1(math.max(wep:Clip1() - 5, 0))
				end

				self.TakenAmmo = self.TakenAmmo + 5
				self:SetNextAmmo(CurTime() + self.ConsumptionRate)
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

local liftclasses = {
	["nz_zombie_boss_fireman"] = true,
	["nz_zombie_boss_krasny"] = true,
	["nz_zombie_boss_panzer"] = true,
	["nz_zombie_boss_panzer_bo3"] = true,
}

function ENT:AOEEffect()
	util.ScreenShake(self:GetPos(), 4, 10, 0.1, self.Range*1.5)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if nzombies and v:IsPlayer() and !v:GetNotDowned() and !v.DownedWithSoloRevive then
			v.DownedWithSoloRevive = true
			v:StartRevive(v)
			timer.Simple(4, function()
				if IsValid(v) and !v:GetNotDowned() then
					v:RevivePlayer(v)
					for _, perk in pairs(v.OldPerks) do
						v:GivePerk(perk)
					end
					if v.DownPoints then
						v:GivePoints(tonumber(v.DownPoints))
					end
				end
			end)
		end

		if (v:IsNextBot() or v:IsNPC()) then
			if v:BO3IsShockStun() then continue end
			if v:Health() <= 0 then continue end
			if self.m_EntityCooldown[v:EntIndex()] and self.m_EntityCooldown[v:EntIndex()] + 0.75 > CurTime() then continue end

			if liftclasses[v:GetClass()] or v.CanPanzerLift then
				v:PanzerDGLift(0.5)
				continue
			end

			if v.NZBossType then continue end

			self:InflictDamage(v)
			self.m_EntityCooldown[v:EntIndex()] = CurTime()
		end
	end
end

function ENT:OnRemove()
	self:StopParticles()
	self:StopSound(self.VortexLoopSound)
	self:ReturnToOwner()
end

function ENT:ReturnToOwner()
	local ply = self:GetOwner()
	if SERVER and IsValid(ply) then
		ply:EmitSound("weapon_bo3_cloth.med")
		self:EmitSound("weapon_bo3_gear.rattle")
		if not nzombies then
			ply:Give("tfa_waw_grav_spike", true)
			local wep = ply:GetWeapon("tfa_waw_grav_spike")
			if IsValid(wep) then
				wep.IsFirstDeploy = true
				if inf_cvar:GetBool() then
					wep:SetClip1(100)
				else
					wep:SetClip1(0)
				end
			end
		end
	end
end

function ENT:InflictDamage(ent)
	local fx = EffectData()
	fx:SetStart(self:GetPos())
	fx:SetOrigin(ent:EyePos())
	util.Effect( "tfa_waw_crossbow_tether", fx )

	local damage = DamageInfo()
	damage:SetDamageType(nzombies and DMG_ENERGYBEAM or DMG_SHOCK)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamage(ent:Health() + 666)
	damage:SetDamageForce(ent:GetUp()*25000 + (ent:GetPos() - self:GetPos()):GetNormalized() * 10000)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	ent.NukeGunShocked = true
	ent:TakeDamageInfo(damage)
	ent:Extinguish()
	ent.NukeGunShocked = nil
end

function ENT:Use(act, cal)
	if CLIENT then return end
	if self:GetActivated() then return end
	if IsValid(act) and act == self:GetOwner() then
		self:Remove()
	end
end