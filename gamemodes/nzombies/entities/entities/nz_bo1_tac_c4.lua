
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
ENT.PrintName = "Player Triggered Explosive"

--[Sounds]--
ENT.BounceSound = Sound("TFA_BO1_C4.Plant")
ENT.ExplodeSound = Sound("TFA_BO1_C4.Expl")

--[Parameters]--
ENT.Range = 220
ENT.NZThrowIcon = Material("vgui/icon/hud_t5_c4.png", "unlitgeneric smooth")
ENT.NZHudIcon = Material("vgui/icon/hud_t5_satchelcharge.png", "unlitgeneric smooth")
ENT.Impacted = false

DEFINE_BASECLASS(ENT.Base)

local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Upgraded")
end

function ENT:Draw()
	self:DrawModel()

	if self.pcolor then
		render.SetMaterial(Material("effects/c4_glow.vmt"))
		render.DrawSprite(self:GetAttachment(3).Pos, 1.5, 1.5, self.pcolor)
	end
end

function ENT:PhysicsCollide(data, phys)
	local ent = data.HitEntity
	if IsValid(ent) and ent:IsPlayer() then return end
	if !ent:IsWorld() and ent:IsSolid() then
		local pos = data.HitPos
		local ang = data.HitNormal:Angle() + Angle(-90,0,0)

		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetCollisionGroup(COLLISION_GROUP_WORLD)
			self:SetTrigger(true)
			self:SetAngles(ang)
			self:SetPos(pos)

			timer.Simple(0, function()
				if not IsValid(self) then return end
				if not IsValid(ent) then return end
				self:SetParent(ent)
			end)
		end)
	else
		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SetPos(data.HitPos - data.HitNormal*0.5)
			self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		end)
		self:SetAngles(data.HitNormal:Angle() + Angle(-90,0,0))
	end

	phys:EnableMotion(false)
	phys:Sleep()
	self.hitpos = data.HitPos
	self.hitnorm = data.HitNormal

	self:EmitSound(self.BounceSound)

	timer.Simple(0.4, function()
		if not IsValid(self) then return end
		if self.mytrail and IsValid(self.mytrail) then
			self.mytrail:Remove()
		end
	end)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
	end

	local ply = self:GetOwner()
	if IsValid(ply) then
		local pvcol = ply:GetPlayerColor()
		self.pcolor = Color(255*pvcol.x, 255*pvcol.y, 255*pvcol.z, 255)

		if not ply.ActiveC4s then ply.ActiveC4s = {} end
		table.insert(ply.ActiveC4s, self)

		if CLIENT then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep.IsC4 and wep.NZHudIcon then
				self.NZHudIcon = wep.NZHudIcon
			end
		end

		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep.IsC4 then
			self.WepClass = wep:GetClass()
		end
	end

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 1)
	self.RangeSqr = self.Range*self.Range
	self.KillRangeSqr = 80^2	

	if CLIENT then return end
	if self.nzPaPCamo then
		self:SetMaterial(self.nzPaPCamo)
	end
	if self.RampupSound then
		self:EmitSound(self.RampupSound)
	end

	self:OverflowCheck()
	//self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)

	self.mytrail = util.SpriteTrail(self, 3, self.pcolor, true, 3, 0, 0.2, 0.1, "effects/laser_citadel1")
end

local max_bbettys = GetConVar("nz_difficulty_max_placeables")
function ENT:OverflowCheck()
	local ply = self:GetOwner()

	if #ply.ActiveC4s > max_bbettys:GetInt() then
		for k, v in pairs(ply.ActiveC4s) do
			if not IsValid(v) then continue end
			if v == self then continue end

			v:Explode()
			break
		end
	end
end

function ENT:Think()
	if CLIENT and self.pcolor and dlight_cvar:GetBool() then
		local dlight = DynamicLight(self:EntIndex(), true)
		if (dlight) then
			dlight.pos = self:GetAttachment(3).Pos
			dlight.r = self.pcolor.r
			dlight.g = self.pcolor.g
			dlight.b = self.pcolor.b
			dlight.brightness = 0.5
			dlight.Decay = 1000
			dlight.Size = 24
			dlight.DieTime = CurTime() + 0.5
		end
	end

	if SERVER then
		local ply = self:GetOwner()
		if not IsValid(ply) then
			self:Explode()
			return false
		end

		if self.Cooked and self.Cooked < CurTime() then
			self:Explode()
			return false
		end

		local p = self:GetParent()
		if IsValid(p) and p:IsValidZombie() and p:Health() <= 0 then
			self:SetParent(nil)
			self:SetTrigger(false)
			self:SetPos(p:WorldSpaceCenter() + VectorRand(-6,6))

			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
				phys:EnableMotion(true)
				phys:Wake()
			end
		end
	end

	self:NextThink(CurTime())
	return true
end


function ENT:Use(ply, caller)
	if CLIENT then return end
	if IsValid(ply) and ply ~= self:GetOwner() then return end
	local wep = ply:GetWeapon(self.WepClass or 'tfa_bo1_c4')

	if IsValid(wep) then
		local pickup = false
		if ply:GetAmmoCount(wep:GetPrimaryAmmoType()) + wep:Clip1() < wep.NZSpecialWeaponData.MaxAmmo then
			ply:GiveAmmo(1, wep:GetPrimaryAmmoType(), true)
			pickup = true
		end

		if !pickup then
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetOrigin(self:GetAttachment(1).Pos)
			fx:SetNormal(vector_up*-1)
			fx:SetScale(2)
			fx:SetMagnitude(2)
			fx:SetRadius(2)

			util.Effect("ElectricSpark", fx)
			util.Effect("Sparks", fx)
		end

		self:EmitSound(self.BounceSound)
		self:Remove()
	end
end

function ENT:DoExplosionEffect()
	if self.hitpos then
		util.Decal("Scorch", self.hitpos + self.hitnorm, self.hitpos - self.hitnorm)
	end

	if self:GetUpgraded() then
		self:EmitSound(self.ExplodeSound)
		if self.FluxSound then
			self:EmitSound(self.FluxSound)
		end

		ParticleEffect(self.ExplosionEffect, self:WorldSpaceCenter(), (self.hitnorm and self.hitnorm:Angle() + Angle(-90,0,0)) or angle_zero)
		if self.GroundEffect and self.hitpos and self.hitnorm and self.hitnorm:Dot(Vector(0,0,-1))>0.9 then
			ParticleEffect(self.GroundEffect, self.hitpos, angle_zero)
		end
	else
		self:EmitSound(self.ExplodeSound)
		if self.FluxSound then
			self:EmitSound(self.FluxSound)
		end

		local fx = EffectData()
		fx:SetOrigin(self:GetPos())

		util.Effect("HelicopterMegaBomb", fx)
		util.Effect("Explosion", fx)
	end
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	if self.RampupSound then
		self:StopSound(self.RampupSound)
	end

	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(self:GetUpgraded() and DMG_SHOCK or DMG_BLAST)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsWorld() then continue end
		if v:IsPlayer() and v ~= ply then continue end
		if self:GetUpgraded() and v == ply then continue end
		if v.IsAATTurned and v:IsAATTurned() then continue end
		if v:IsValidZombie() and v:Health() <= 0 then continue end

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
			if v:IsPlayer() and v:Crouching() then
				damage:ScaleDamage(0.5)
			end
		end

		damage:SetDamageForce(v:GetUp()*math.random(15,20)*(1000*distfac) + (v:EyePos() - self:GetPos()):GetNormalized()*math.random(10,20)*1000)

		if (v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "zombie_boss")) then
			damage:ScaleDamage(math.max(1, math.Round(nzRound:GetNumber()/10, 1)))
		elseif (fuck or self:GetUpgraded()) and v:IsValidZombie() then
			damage:SetDamage(v:Health() + 666)

			if self:GetUpgraded() then
				damage:SetDamageForce(vector_up)

				if self.KillSound then
					v:EmitSound(self.KillSound)
				end
				if self.KillEffect then
					ParticleEffectAttach(self.KillEffect, PATTACH_POINT_FOLLOW, v, 2)
				end
				if self.GroundEffect and v:OnGround() then
					ParticleEffect(self.GroundEffect, v:GetPos(), angle_zero)
				end
			end
		end

		v:TakeDamageInfo(damage)
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnRemove(...)
	local ply = self:GetOwner()
	if IsValid(ply) and ply.ActiveC4s then
		table.RemoveByValue(ply.ActiveC4s, self)

		if table.IsEmpty(ply.ActiveC4s) then
			ply.ActiveC4s = nil
		end
	end

	return BaseClass.OnRemove(self, ...)
end

if CLIENT then
	function ENT:GetNZTargetText()
		local ply = self:GetOwner()
		local p = LocalPlayer()
		if IsValid(p:GetObserverTarget()) then
			p = p:GetObserverTarget()
		end

		if IsValid(self:GetParent()) then return end

		if p == ply then
			local wep = ply:GetWeapon(self.WepClass or 'tfa_bo1_c4')

			if IsValid(wep) then
				local special = wep.NZSpecialCategory == "specialgrenade"
				if wep.NZSpecialWeaponData and ply:GetAmmoCount(special and "nz_specialgrenade" or wep:GetPrimaryAmmoType()) + (special and 0 or wep:Clip1()) >= wep.NZSpecialWeaponData.MaxAmmo then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - remove C4"
				else
					return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup C4"
				end
			else
				return "Satchel Charge"
			end
		else
			if IsValid(ply) then
				return ply:Nick().."'s Satchel Charge"
			else
				return "Satchel Charge"
			end
		end
	end
end
