
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
ENT.PrintName = "EMP Grenade (Thrown)"

--[Parameters]--
ENT.Delay = 1.75
ENT.Range = 300
ENT.NZThrowIcon = Material("vgui/icons/emp_bo2_icon.png", "unlitgeneric smooth")

local BounceSound = {
	[MAT_WOOD] = "TFA.BO1.M67.Bounce.Wood",
	[MAT_DIRT] = "TFA.BO1.M67.Bounce.Earth",
	[MAT_METAL] = "TFA.BO1.M67.Bounce.Metal",
	[0] = "TFA.BO1.M67.Bounce.Earth",
}

BounceSound[MAT_GRATE] = BounceSound[MAT_METAL]
BounceSound[MAT_VENT] = BounceSound[MAT_METAL]
BounceSound[MAT_GRASS] = BounceSound[MAT_DIRT]
BounceSound[MAT_SNOW] = BounceSound[MAT_DIRT]
BounceSound[MAT_SNOW] = BounceSound[MAT_DIRT]

DEFINE_BASECLASS( ENT.Base )

function ENT:Draw()
	self:DrawModel()
end

function ENT:PhysicsCollide(data, phys)
	if data.Speed > 60 then
		local norm = (data.HitPos - self:GetPos()):GetNormalized()
		local tr = util.QuickTrace(self:GetPos(), norm*10, self)

		if tr.Hit then
			local finalsound = BounceSound[tr.MatType] or BounceSound[0]
			self:EmitSound(finalsound)
		end

		local ent = data.HitEntity
		if data.Speed > 200 and IsValid(ent) and ent:IsValidZombie() then
			self:InflictDamage(ent, data.HitPos)
		end

		sound.EmitHint(SOUND_DANGER, data.HitPos, 500, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)
	end

	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = phys:GetVelocity()
	NewVelocity:Normalize()

	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	local TargetVelocity = NewVelocity * LastSpeed * 0.6
	phys:SetVelocity( TargetVelocity )
end

function ENT:Initialize()
	BaseClass.Initialize(self)

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	--self.Damage = self.mydamage or self.Damage
	self.killtime = CurTime() + self.Delay
	self.spawntime = CurTime()
	--self.RangeSqr = self.Range*self.Range

	if CLIENT then return end
	self:SetTrigger(true)
	util.SpriteTrail(self, 0, Color(120, 120, 120), true, 6, 0, 0.5, 0.005, "cable/smoke.vmt")
end

function ENT:Think()
	if SERVER then
		if self.killtime < CurTime() then
			self:Explode(self:GetPos())
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:StartTouch(ent)
	if not (ent:IsNextBot() or ent:IsNPC()) then return end
	self:InflictDamage(ent, self:WorldSpaceCenter())
end

function ENT:InflictDamage(ent, hitpos)
	local damage = DamageInfo()
	damage:SetDamage(5)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamagePosition(hitpos)
	damage:SetDamageForce(ent:GetForward()*-1000)
	damage:SetDamageType(DMG_GENERIC)

	local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !headbone then headbone = ent:LookupBone("j_head") end
	if headbone and ent:GetBonePosition(headbone):DistToSqr(hitpos) < 10^2 then
		damage:ScaleDamage(10)
		damage:SetDamagePosition(ent:GetBonePosition(headbone))
	end

	local ang = ent:GetForward():Angle()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		ang = phys:GetVelocity():Angle()
	end

	ParticleEffect("blood_impact_red_01", hitpos, ang)
	ent:TakeDamageInfo(damage)
end

function ENT:DoExplosionEffect()
	ParticleEffect("bo3_qed_explode_smoke", self:GetPos(), Angle( 0, 0, 0 ))
	ParticleEffect("bo3_qed_explode_flash", self:GetPos(), Angle( 0, 0, 0 ))
	ParticleEffect("bo3_qed_explode_dots", self:GetPos(), Angle( 0, 0, 0 ))
    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )

    util.Effect( "emp_flashexplosion", effectdata)
	
	self:EmitSound("TFA_BO2.EMP.EXPLODE")
	self:EmitSound("TFA_BO2.EMP.EXPLODEFLUX")
end

function ENT:Explode()
	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsWorld() then continue end
		
		tr.endpos = v:WorldSpaceCenter()
		local tr1 = util.TraceLine(tr)
		if tr1.HitWorld then continue end
		
		if IsValid(v) and v:IsPlayer() and v:GetNotDowned() then
			v:NZSonicBlind(2)
		end
		
		if IsValid(v) and v:IsValidZombie() and v.IsMooZombie and v:Health() > 0 then
			v:PerformStun( math.Rand(6,8) )
		end
		
		if IsValid(v) and (v.NZBossType or v.IsMooBossZombie) and v:Health() > 0 then
			v:PerformStun( math.Rand(4,6) )
		end
		
		--[[if v:GetClass() == "perk_machine" then
			if !v:BrutusLocked() then v:OnBrutusLocked() end
		end]]
		
		--[[if v:GetClass() == "drop_powerup" then
			v:Remove()
		end]]
		
		if v:GetClass() == "nz_zombie_boss_avogadro" then
			v:PerformDeath()
		end
		
		if v:GetClass() == "power_box" then
			if IsElec() and nzRound:InProgress() then
				nzElec:Reset()	
			end
		end
		
		--[[if v:GetClass() == "random_box" then
			if v:GetOpen() then v:Close() end
		end]]
		
		--[[if v:GetClass() == "random_box_windup" then
			v:Remove()
		end]]
		
		--[[if v:GetClass() == "pap_weapon_fly" then
			v:Remove()
		end]]
		
		if v.GetBuildClass then
			v:SetHealth(1)
			v:TakeDamage(666, v, v)
		end
		
		--[[if v.MonkeyBomb then
			v:Remove()
		end]]

	end

	self:DoExplosionEffect()
	self:Remove()
end
