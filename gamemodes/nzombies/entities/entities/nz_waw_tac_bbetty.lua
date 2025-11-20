
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
ENT.PrintName = "Bouncing Betty"

--[Sounds]--
ENT.BounceSound = "TFA_WAW_BBETTY.Plant"

--[Parameters]--
ENT.Exploded = false
ENT.HasJumped = false
ENT.Range = 250

ENT.NZThrowIcon = Material("vgui/icon/hud_zom_bouncing_betty.png", "unlitgeneric smooth")
ENT.NZHudIcon = Material("vgui/icon/hud_bouncing_betty.png", "unlitgeneric smooth")
ENT.GlowTexture = Material("models/weapons/tfa_waw/bbetty/mtl_weapon_bbetty_mine_glow")

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:Draw()
	self:DrawModel()
	if LocalPlayer() == self:GetOwner() and self:GetActivated() then
		local num = render.GetBlend()

		render.SuppressEngineLighting(false)
		render.MaterialOverride(self.GlowTexture)
		render.SetBlend(0.1)
		self:DrawModel()
		render.SetBlend(num)
		render.MaterialOverride(nil)
		render.SuppressEngineLighting(false)
	end
end

function ENT:PhysicsCollide(data, phys)
	phys:EnableMotion(false)
	phys:Sleep()

	if self:GetActivated() then return end
	self:SetActivated(true)

	self:EmitSound(self.BounceSound)
	sound.EmitHint(SOUND_COMBAT, self:GetPos(), 500, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)

	local ent = data.HitEntity
	local ang = self:GetAngles()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetAngles(self.DesiredAng or ang)
		if IsValid(ent) and ent:GetClass() == self:GetClass() then
			self:Reorient(ent)
		end
	end)
end

function ENT:Reorient(ent)
	local qty = 12 --retries
	local randomintensity = 0 --how intense the randomness should be
    local radv = 6 --size of circle
    local pi = math.pi / (qty/2)

    local pos = ent:GetPos()
    local tr = {
		start = pos,
		filter = {self},
		mask = MASK_SOLID_BRUSHONLY,
	}

	for i = 1, qty do
		local posx, posy = radv * math.sin(pi * math.random(qty)), radv * math.cos(pi * math.random(qty))
		local offset = Vector(posx + (math.Rand(-radv, radv) * randomintensity), posy + (math.Rand(-radv, radv) * randomintensity), 0)
		tr.endpos = pos + offset
		local traceres = util.TraceLine(tr)
		pos = pos + traceres.Normal * math.Clamp(traceres.Fraction,0,1) * offset:Length()

		local tr1 = util.TraceLine({
			start = pos,
			endpos = pos - Vector(0,0,64),
			filter = self,
			mask = MASK_SOLID,
		})

		if tr1.AllSolid or tr1.StartSolid or tr1.Fraction == 1 or IsValid(tr1.Entity) and tr1.Entity:GetClass() == self:GetClass() then
			continue
		end

		self:SetPos(pos)
		break
	end
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	//self:PhysicsInitSphere(0.1, "metal_bouncy")
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true, 2)
	self.RangeSqr = self.Range*self.Range
	self.KillRangeSqr = 80^2

	if CLIENT then return end
	self:OverflowCheck()
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

local max_bbettys = GetConVar("nz_difficulty_max_placeables")
function ENT:OverflowCheck()
	local ply = self:GetOwner()
	if not ply.activebbettys then ply.activebbettys = {} end
	table.insert(ply.activebbettys, self)

	if #ply.activebbettys > max_bbettys:GetInt() then
		for k, v in pairs(ply.activebbettys) do
			if not IsValid(v) then continue end
			if v == self then continue end
			v:Jump()
			break
		end
	end
end

function ENT:Think()
	if SERVER and self:GetActivated() and self:GetCreationTime() + 0.5 < CurTime() then
		local ply = self:GetOwner()
		for k, v in pairs(ents.FindInSphere(self:GetPos(), 40)) do
			if v == self:GetOwner() then continue end
			if v:IsNPC() or v:IsNextBot() then
				if v:IsNPC() then
					if v:Disposition((IsValid(ply) and ply or self)) ~= 3 then
						self:Jump()
					end
				else
					self:Jump()
				end
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Use(ply, caller)
	if CLIENT then return end
	if IsValid(ply) and ply ~= self:GetOwner() then return end
	local wep = ply:GetWeapon('tfa_waw_bbetty')
	if not IsValid(wep) or ply:GetAmmoCount(GetNZAmmoID("specialgrenade")) >= wep.NZSpecialWeaponData.MaxAmmo then
		wep = ply:GetWeapon('tfa_waw_bbetty_trap')
	end

	if IsValid(wep) then
		local pickup = false
		if wep.NZSpecialCategory and wep.NZSpecialCategory == "trap" and ply:GetAmmoCount(wep:GetPrimaryAmmoType()) + wep:Clip1() < wep.NZSpecialWeaponData.MaxAmmo then
			ply:GiveAmmo(1, wep:GetPrimaryAmmoType(), true)
			pickup = true
		elseif wep.NZSpecialCategory and wep.NZSpecialCategory == "specialgrenade" and ply:GetAmmoCount(GetNZAmmoID("specialgrenade")) < wep.NZSpecialWeaponData.MaxAmmo then
			ply:GiveAmmo(1, GetNZAmmoID("specialgrenade"), true)
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

function ENT:Jump()
	if not SERVER then return end
	if self.HasJumped then return end
	self.HasJumped = true

	self:EmitSound("TFA_WAW_BBETTY.Trigger")

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(true)
		phys:Wake()
		phys:ApplyForceCenter(vector_up*4200)
	end

	timer.Simple(math.Rand(0.48,0.52), function() --im stupid so im using a timer
		if not self:IsValid() then return end
		self:Explode()
	end)
end

function ENT:DoExplosionEffect()
	local tr = util.QuickTrace(self:GetPos(), Vector(0,0,-64), self)
	util.Decal("Scorch", tr.HitPos - tr.HitNormal, tr.HitPos + tr.HitNormal)

	local fx = EffectData()
	fx:SetOrigin(self:GetPos())

	util.Effect("HelicopterMegaBomb", fx)
	util.Effect("Explosion", fx)
end

function ENT:Explode()
	local ply = self:GetOwner()
	local tr = {
		start = self:GetPos(),
		filter = self,
		mask = MASK_SHOT_HULL
	}

	local damage = DamageInfo()
	damage:SetAttacker(IsValid(ply) and ply or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_BLAST)

	for k, v in pairs(ents.FindInSphere(self:GetPos(), self.Range)) do
		if v:IsWorld() then continue end
		if v:IsPlayer() and v ~= ply then continue end
		if IsValid(v:GetOwner()) and v:GetOwner():IsPlayer() then continue end
		if v.IsAATTurned and v:IsAATTurned() then continue end

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

		if (v.NZBossType or v.IsMooBossZombie or string.find(v:GetClass(), "zombie_boss")) then
			damage:ScaleDamage(math.max(1, math.Round(nzRound:GetNumber()/10, 1)))
		elseif fuck and v:IsValidZombie() then
			damage:SetDamage(v:Health() + 666)
			damage:SetDamageType(DMG_MISSILEDEFENSE)
		end

		damage:SetDamageForce(v:GetUp()*math.random(15,20)*(1000*distfac) + (v:EyePos() - self:GetPos()):GetNormalized()*math.random(10,20)*1000)

		v:TakeDamageInfo(damage)

		damage:SetDamage(self.Damage)
		if fuck then
			damage:SetDamageType(DMG_BLAST)
		end
	end

	util.ScreenShake(self:GetPos(), 10, 255, 1, self.Range*2)

	self:DoExplosionEffect()
	self:Remove()
end

function ENT:OnRemove()
	if SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) and ply.activebbettys and table.HasValue(ply.activebbettys, self) then
			table.RemoveByValue(ply.activebbettys, self)
		end
	end
end

if CLIENT then
	function ENT:GetNZTargetText()
		local ply = self:GetOwner()
		local p = LocalPlayer()
		if IsValid(p:GetObserverTarget()) then
			p = p:GetObserverTarget()
		end

		if p == ply then
			local wep = ply:GetWeapon('tfa_waw_bbetty')
			if not IsValid(wep) then
				wep = ply:GetWeapon('tfa_waw_bbetty_trap')
			end

			if IsValid(wep) then
				local special = wep.NZSpecialCategory == "specialgrenade"
				if wep.NZSpecialWeaponData and ply:GetAmmoCount(special and "nz_specialgrenade" or wep:GetPrimaryAmmoType()) + (special and 0 or wep:Clip1()) >= wep.NZSpecialWeaponData.MaxAmmo then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - remove Bouncing Betty"
				else
					return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup Bouncing Betty"
				end
			else
				return "Bouncing Betty"
			end
		else
			if IsValid(ply) then
				return ply:Nick().."'s Bouncing Betty"
			else
				return "Bouncing Betty"
			end
		end
	end
end