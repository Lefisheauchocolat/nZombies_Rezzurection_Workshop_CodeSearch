AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Nano Swarm"

--[Sounds]--
ENT.StartSound = "TFA_AW_NANOSWARM.Explode"
ENT.LoopSound = "TFA_AW_NANOSWARM.Loop"
ENT.EndSound = "TFA_AW_NANOSWARM.End"

--[Parameters]--
ENT.Range = 196
ENT.Delay = 20
ENT.BloomTime = 1
ENT.AttackInterval = 0.5

DEFINE_BASECLASS(ENT.Base)

local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")
local SinglePlayer = game.SinglePlayer()

local liftclasses = {
	["nz_zombie_boss_fireman"] = true,
	["nz_zombie_boss_krasny"] = true,
	["nz_zombie_boss_panzer"] = true,
	["nz_zombie_boss_panzer_bo3"] = true,
}

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Float", 0, "ImpactedTime")
end

function ENT:Draw()
	self:DrawModel()
	self:CreateShadow()

	if not self:GetActivated() then return end

	local ratio = 1 - math.Clamp((self:GetImpactedTime() + self.BloomTime  - CurTime()) / self.BloomTime, 0, 1)

	if !self.pvsfx or !IsValid(self.pvsfx) then
		self.pvsfx = CreateParticleSystem(self, "aw_nanoswarm_loop", PATTACH_POINT_FOLLOW, 1)
	end

	/*if !self.lamp1 or !IsValid(self.lamp1) then
		local lamp1 = ProjectedTexture()
		self.lamp1 = lamp1 

		lamp1:SetTexture( "sgm/playercircle" )
		lamp1:SetFarZ( 400 )
		lamp1:SetFOV( 0 )
		lamp1:SetBrightness( 4 )

		local tr1 = util.QuickTrace(self:GetPos(), vector_up*200, self)

		self.LampFOV = 110 + ((110/2)*(1 - tr1.Fraction))
		lamp1:SetPos( tr1.HitPos )
		lamp1:SetAngles( -vector_up:Angle() )
		lamp1:SetColor( Color(20, 45, 255, 12) )
		lamp1:Update()
	end*/
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then return end

	if data.Speed > 60 then
		sound.Play("sound/weapons/tfa_aw/grenade/grenade_bounce_default_0"..math.random(9)..".wav", data.HitPos, SNDLVL_NORM, math.random(97,103), 1)
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.4
	phys:SetVelocity( TargetVelocity )

	local ent = data.HitEntity

	if data.HitNormal:Dot(vector_up) < 0 and (!IsValid(ent) or ent:IsWorld() or data.Speed < 100) then
		local trace = util.TraceLine({
			start = self:GetPos(),
			endpos = data.HitPos + data.OurOldVelocity:GetNormalized(),
			mask = MASK_SHOT,
			filter = {ply, self}
		})

		local fx = EffectData()
		fx:SetStart( trace.StartPos )
		fx:SetOrigin( trace.HitPos )
		fx:SetEntity( trace.Entity )
		fx:SetSurfaceProp( trace.SurfaceProps )
		fx:SetHitBox( trace.HitBox )

		util.Effect("Impact", fx, false, true)

		util.Decal("Scorch", data.HitPos, data.HitPos + data.HitNormal*4, self)

		self:ActivateCustom(phys, ent)
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetImpactedTime( 0 )
	self:SetCollisionGroup( COLLISION_GROUP_PASSABLE_DOOR )
	self:DrawShadow( true )

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetBuoyancyRatio(0)
	end

	if !SinglePlayer or (SinglePlayer and SERVER) then
		ParticleEffectAttach("aw_nanoswarm_trail", PATTACH_ABSORIGIN_FOLLOW, self, 1)
	end

	self:NextThink(CurTime())

	if CLIENT then return end
	self.m_EntityCooldown = {}
end

function ENT:ActivateCustom(phys, ent)
	local hitAng = Angle(0,self:GetAngles()[2],0)
	self:SetAngles(hitAng)

	if IsValid(ent) and ent:IsSolid() and not (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()) then
		self:SetParent(ent)
	end

	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	end)

	phys:EnableMotion(false)
	phys:Sleep()

	self:SetImpactedTime(CurTime())
	self:SetActivated(true)
	self:CreateSphere()
	self:CreateGrid()
	self:SetBodygroup(1, 1)

	self:EmitSound(self.StartSound)
	self:EmitSound(self.LoopSound)

	self.killtime = CurTime() + self.Delay

	ParticleEffect("aw_nanoswarm_start", self:GetPos(), vector_up:Angle())
end

function ENT:CreateSphere()
	local startPos = self:GetPos()
	local startAng = Angle(0,self:GetAngles()[2],0)

	local vfxsphere = ents.Create("prop_dynamic")
	vfxsphere:SetModel("models/weapons/tfa_aw/dna_grenade/vfx_dna_sphere.mdl")
	vfxsphere:SetModelScale(0.01, 0)
	vfxsphere:SetPos(startPos)
	vfxsphere:SetAngles(startAng)
	vfxsphere:SetParent(self)
	vfxsphere:SetMoveType(MOVETYPE_NONE)

	vfxsphere:Spawn()

	self:DeleteOnRemove(vfxsphere)

	timer.Simple(0, function()
		vfxsphere:SetCollisionGroup(COLLISION_GROUP_NONE)
		vfxsphere:SetSolid(SOLID_NONE)
		vfxsphere:SetModelScale(1, 1)
	end)

	self.VFXSphere = vfxsphere
end

function ENT:CreateGrid()
	local startPos = self:GetPos()
	local startAng = Angle(0,self:GetAngles()[2],0)

	local vfxgrid = ents.Create("prop_dynamic")
	vfxgrid:SetModel("models/weapons/tfa_aw/dna_grenade/vfx_dna_grid.mdl")
	vfxgrid:SetModelScale(0.01, 0)
	vfxgrid:SetPos(startPos)
	vfxgrid:SetAngles(startAng)
	vfxgrid:SetParent(self)
	vfxgrid:SetMoveType(MOVETYPE_NONE)
	vfxgrid.StartAngle = startAng

	vfxgrid:Spawn()

	self:DeleteOnRemove(vfxgrid)

	timer.Simple(0, function()
		vfxgrid:SetCollisionGroup(COLLISION_GROUP_NONE)
		vfxgrid:SetSolid(SOLID_NONE)
		vfxgrid:SetModelScale(1, 1)
	end)

	local angAdd = 0
	local vfx_timer = "dna_vfx_grid"..vfxgrid:EntIndex()
	timer.Create(vfx_timer, 0, 0, function()
		if not IsValid(vfxgrid) then
			if timer.Exists(vfx_timer) then
				timer.Remove(vfx_timer)
			end
			return
		end

		angAdd = angAdd + 1
		if angAdd > 360 then
			angAdd = 0
		end

		vfxgrid:SetAngles(vfxgrid.StartAngle + Angle(0,angAdd,0))
	end)

	self.VFXGrid = vfxgrid
end

function ENT:Think()
	if CLIENT then
		local ratio = 1 - math.Clamp((self:GetImpactedTime() + self.BloomTime  - CurTime()) / self.BloomTime, 0, 1)

		if self.lamp1 and ( IsValid( self.lamp1 ) ) then
			local tr1 = util.TraceLine({
				start = self:GetPos(),
				endpos = self:GetPos() + vector_up*200,
				mask = MASK_SOLID_BRUSHONLY,
				filter = self
			})

			self.lamp1:SetFOV(self.LampFOV*ratio)
			self.lamp1:SetPos( tr1.HitPos )
			self.lamp1:SetAngles( -self:GetUp():Angle() )
			self.lamp1:Update()
		end

		if dlight_cvar:GetBool() and DynamicLight then
			local dlight = dlight or DynamicLight(self:EntIndex(), false)
			if dlight then
				dlight.pos = self:GetPos()
				dlight.r = 20
				dlight.g = self:GetActivated() and 45 or 255
				dlight.b = self:GetActivated() and 255 or 255
				dlight.brightness = 1
				dlight.Decay = 2000
				dlight.Size = self:GetActivated() and 512*ratio or 64
				dlight.dietime = CurTime() + 1
			end
		end

		if self.pvsfx and IsValid(self.pvsfx) then
			self.pvsfx:SetControlPoint(6, Vector(ratio, 0, 0)) //ring & nanomachines radius
			self.pvsfx:SetControlPoint(5, Vector(ratio, ratio, ratio))
		end

		self:SetNextClientThink(CurTime())
	end

	if SERVER then
		if self.killtime < CurTime() then
			self:Remove()
			return false
		end

		local ply = self:GetOwner()

		if self:GetActivated() then
			local ratio = 1 - math.Clamp((self:GetImpactedTime() + self.BloomTime  - CurTime()) / self.BloomTime, 0, 1)

			for _, ent in RandomPairs(ents.FindInSphere(self:GetPos(), self.Range*ratio)) do
				if ent:IsNPC() or ent:IsNextBot() then
					if ent:Health() <= 0 then continue end

					ent:AWNanoSwarm(math.Clamp(self.AttackInterval*2, 1, 2), ply, self.Inflictor, self.AttackInterval, 0.05, 25)
					break
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Explode()
end

function ENT:OnRemove()
	self:StopParticles()
	self:StopSound(self.LoopSound)
	self:EmitSound(self.EndSound)

	ParticleEffect("aw_nanoswarm_end", self:GetPos(), vector_up:Angle())

	if self.lamp1 and IsValid(self.lamp1) then
		self.lamp1:Remove()
	end
end
