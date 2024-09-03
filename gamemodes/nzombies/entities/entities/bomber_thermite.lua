
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Bomber Thermite"
ENT.NZThrowIcon = Material("grenade-256.png", "smooth unlitgeneric")

--[Parameters]--
ENT.Range = 150

DEFINE_BASECLASS( ENT.Base )

function ENT:Draw()
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	self:Explode()
	util.Decal("Scorch", data.HitPos - data.HitNormal, data.HitPos + data.HitNormal)
	self:StopParticles()
end

function ENT:Initialize()
	BaseClass.Initialize(self)
	self:SetModel("models/weapons/csgonade/w_eq_fraggrenade_thrown.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
	self.Damage = self.mydamage or self.Damage
	self.spawntime = CurTime()
	self.RangeSqr = self.Range*self.Range
	self:SetMoveType(MOVETYPE_VPHYSICS)

	if CLIENT then return end
	self:SetTrigger(true)
	ParticleEffectAttach("bo1_molotov_trail", PATTACH_POINT_FOLLOW, self, 1)
	--print(self:GetPhysicsObject())
end

function ENT:DoExplosionEffect()
	ParticleEffect("bo1_molotov_impact", self:GetPos(), Angle( 0, 0, 0 ))
	
	self:EmitSound("weapons/stinger_fire1.wav")
end

function ENT:Explode()
	local brainz = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsWorld() then continue end
		local expdamage = DamageInfo()
		expdamage:SetDamageType(DMG_BLAST)
		expdamage:SetAttacker(self)
		expdamage:SetDamage(40)
		expdamage:SetDamageForce(v:GetUp()*5000 + (v:GetPos() - self:GetPos()):GetNormalized() * 10000)
		
		tr.endpos = v:WorldSpaceCenter()
		local tr1 = util.TraceLine(tr)
		if tr1.HitWorld then continue end
		
		if IsValid(v) and v:IsPlayer() and v:GetNotDowned() then
			v:TakeDamageInfo(expdamage)
			v:Ignite(4)
		end

	end

	self:DoExplosionEffect()
	self:Remove()
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
		local x = diff.x*(t/time)
    	local y = diff.y*(t/time)
	
		return pos2 + Vector(x, y, z)
end
