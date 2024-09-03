AddCSLuaFile()
AddCSLuaFile("cl_init.lua")

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

ENT.Exploded = false

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Upgraded")
end

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")
	self:SetNoDraw(true)
	self:DrawShadow(false)
	--self:PhysicsInit(SOLID_VPHYSICS)
	self:PhysicsInitBox(Vector(-4, -4, -4), Vector(4, 4, 4))
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetSolidFlags(FSOLID_NOT_STANDABLE)
	--self:SetSolid(SOLID_VPHYSICS)
	--self:SetMoveType(MOVETYPE_VPHYSICS)
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetBuoyancyRatio(0)
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:Wake()
	end
	
	self:EmitSound("weapons/raygun/wpn_ray_loop.wav", 70)
	
	self.LifeTime = CurTime() + 8
	self:NextThink(CurTime())
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true
	
	ParticleEffect( self:GetUpgraded() and "raygun_impact_pap" or "raygun_impact", self:GetPos(), angle_zero)
	self:EmitSound("weapons/raygun/wpn_ray_exp.ogg", 85, 100, 1, CHAN_WEAPON)
	self:EmitSound("weapons/raygun/wpn_ray_exp_cl.ogg", 70, 100, 1, CHAN_BODY)
	self:EmitSound("weapons/raygun/wpn_ray_flux.ogg", 80, math.random(70, 75), 0.75, CHAN_ITEM)
	
	if SERVER then
		local dmg = DamageInfo()
		dmg:SetDamageType(DMG_BLAST)
		dmg:SetAttacker(self.Owner)
		dmg:SetInflictor(self)
		dmg:SetDamage(self:GetUpgraded() and 600 or 300)
		--dmg:SetDamageForce( Vector(0,0,0) )
		util.BlastDamageInfo(dmg, self:GetPos(), 72)
		
		self:Remove()
	end
end

function ENT:PhysicsCollide(data)
	if self.Exploded or data.HitEntity == self.Owner then return end
	self:Explode()
end

function ENT:Think()
	if self.Exploded then return end
	local tr = util.QuickTrace(self:GetPos(), self:GetVelocity()*engine.TickInterval(), self)
	
	if tr.HitSky then
		if SERVER then self:Remove() end
		return
	elseif tr.Hit then
		self:SetPos(tr.HitPos + tr.HitNormal*3)
		self:Explode()
	end
	
	if SERVER then
		if CurTime() > self.LifeTime then
			self:Remove()
		end
	end
	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	self:StopSound("weapons/raygun/wpn_ray_loop.wav")
end