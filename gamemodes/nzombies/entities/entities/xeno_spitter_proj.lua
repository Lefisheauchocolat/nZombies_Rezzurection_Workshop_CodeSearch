ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Xenomorph Spitter Projectile"
ENT.Author = "Wavy"

ENT.Spawnable = false
ENT.AdminSpawnable = false

if SERVER then
	AddCSLuaFile()
end

function ENT:Draw()
end

function ENT:Initialize()
	if SERVER then
		self:EmitSound("character/alien/vocals/spitter/spitter_acid_loop_02.wav")
		self:SetModel("models/dav0r/hoverball.mdl")
		ParticleEffectAttach("bo3_mirg2k_trail",PATTACH_ABSORIGIN_FOLLOW,self,0)
		ParticleEffectAttach("bo3_mirg2k_muzzleflash",PATTACH_ABSORIGIN,self,0)
		self:SetNoDraw( true )
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		self:SetTrigger(true)
		self:UseTriggerBounds(true, 0)

		phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
			phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		end
	end
end


function ENT:StartTouch(ent)
	if self.Impacted then return end
	if ent == self:GetOwner() then return end
	if ent:Health() <= 0 then return end
	if !ent:IsSolid() then return end
	if ent:IsNPC() then return end
	if ent:IsNextBot() then return end
	if ent:IsPlayer() then return end
	
	self:Explode()
end

function ENT:Explode()
	if SERVER then
		local pos = self:GetPos()

		self.PFX = ents.Create("pfx2_03")
        self.PFX:SetPos(pos + Vector(0,0,1))
        self.PFX:SetAngles(Angle(0,0,0))
		self.PFX:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        self.PFX:Spawn()

		ParticleEffect("bo3_mirg2k_impact",self:GetPos(),Angle(0,0,0),nil)
		ParticleEffectAttach("bo3_sliquifier_puddle_2", PATTACH_ABSORIGIN_FOLLOW, self.PFX, 0)

		self:EmitSound("character/alien/vocals/spitter/spitter_miss_01.wav", 500)

		self.killtime = CurTime() + 8
		self.Exploded = true
	end
end

function ENT:Think()
	if SERVER then
		if self.Exploded then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 120)) do
				if v:IsPlayer() and v:GetNotDowned() and v:Health() > 1 then
					self:InflictDamage(v)

					if v:IsPlayer() and v:HasPerk("mask") then continue end
					v:NZNovaGas(1)
				end
			end

			if self.killtime < CurTime() then

				if IsValid(self.PFX) then
					self.PFX:Remove()
				end

				self:StopParticles()
				self:Remove()

				return false
			end
		end
	end

	self:NextThink(CurTime() + 0.35)
	return true
end

function ENT:InflictDamage(ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_ACID)
	damage:SetAttacker(self)
	damage:SetInflictor(self)
	damage:SetDamage(20)
	damage:SetDamageForce(ent:GetUp())
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	ent:TakeDamageInfo(damage)
end

function ENT:OnRemove()
	self:StopSound("character/alien/vocals/spitter/spitter_acid_loop_02.wav")
end

function ENT:getvel(pos, pos2, time)	-- target, starting point, time to get there
    local diff = pos - pos2 --subtract the vectors
     
    local velx = diff.x/time -- x velocity
    local vely = diff.y/time -- y velocity
 
    local velz = (diff.z - 0.5*(-GetConVarNumber( "sv_gravity"))*(time^2))/time --  x = x0 + vt + 0.5at^2 conversion
     
    return Vector(velx, vely, velz)
end	
	
function ENT:LaunchArc(pos, pos2, time, t)	-- target, starting point, time to get there, fraction of jump
	local v = self:getvel(pos, pos2, time).z
	local a = (-GetConVarNumber( "sv_gravity"))
	local z = v*t + 0.5*a*t^2
	local diff = pos - pos2
	local y = diff.y*(t/time)
	
	return pos2 + Vector(x, y, z)
end