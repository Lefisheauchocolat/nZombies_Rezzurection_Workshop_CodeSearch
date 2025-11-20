
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
ENT.PrintName = "Spikemore"

--[Sounds]--
ENT.BounceSound = "TFA_BO1_SPIKEMORE.Plant"

--[Parameters]--
ENT.Exploded = false

ENT.Range = 400
ENT.DetectRange = 80

ENT.RPM = 1200
ENT.NumShots = 8

ENT.NZThrowIcon = Material("vgui/icon/hud_t5_claymore.png", "unlitgeneric smooth")
ENT.NZHudIcon = Material("vgui/icon/hud_t5_claymore.png", "unlitgeneric smooth")

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:PhysicsCollide(data, phys)
	local active = self:GetActivated()
	self:EmitSound(self.BounceSound)
	phys:EnableMotion(false)
	phys:Sleep()

	self:SetActivated(true)
	sound.EmitHint(SOUND_COMBAT, self:GetPos(), 500, 0.2, IsValid(self:GetOwner()) and self:GetOwner() or self)

	local ent = data.HitEntity
	local ang = self:GetAngles()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetAngles(self.DesiredAng or ang)
		if IsValid(ent) and ent:GetClass() == self:GetClass() and not active then
			self:Reorient(ent)
		end
	end)
end

function ENT:Reorient(ent)
	local qty = 12 --retries
	local randomintensity = 0 --how intense the randomness should be
    local radv = 12 --size of circle
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
	self:UseTriggerBounds(true)

	self.Shots = 0
	self.NextAttack = 0

	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and ply:HasPerk("dtap2") then
		self.Dtap = true
	end

	if CLIENT then return end
	self:OverflowCheck()
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

local max_bbettys = GetConVar("nz_difficulty_max_placeables")
function ENT:OverflowCheck()
	local ply = self:GetOwner()
	if not ply.activespikemors then ply.activespikemors = {} end
	table.insert(ply.activespikemors, self)

	if #ply.activespikemors > max_bbettys:GetInt() then
		for k, v in pairs(ply.activespikemors) do
			if not IsValid(v) then continue end
			if v == self then continue end
			v:Trigger()
			break
		end
	end
end

function ENT:Think()
	if SERVER and self:GetActivated() then
		local ply = self:GetOwner()
		local angle = math.cos(math.rad(35))

		if !self.Triggered then
			for k, v in pairs(ents.FindInCone(self:GetAttachment(1).Pos, self:GetForward(), self.DetectRange, angle)) do
				if not (v:IsNextBot() or v:IsNPC()) then continue end
				if v:Health() <= 0 then continue end

				self:Trigger()
			end
		else
			if self.Exploded and self.NextAttack < CurTime() then
				local dofire = true
				for k, v in RandomPairs(ents.FindInCone(self:GetAttachment(1).Pos, self:GetForward(), self.Range, angle)) do
					if not (v:IsNextBot() or v:IsNPC()) then continue end
					if v:Health() <= 0 then continue end

					self:FireSpike(v)
					/*if self.Dtap then
						timer.Simple(0, function()
							if not IsValid(self) then return end
							self:FireSpike()
						end)
					end*/

					dofire = false
					break
				end

				if dofire then
					self:FireSpike()
					/*if self.Dtap then
						timer.Simple(0, function()
							if not IsValid(self) then return end
							self:FireSpike()
						end)
					end*/
				end

				self.NextAttack = CurTime() + (60/self.RPM)
				self.Shots = self.Shots + 1
				util.ScreenShake(self:GetPos(), 4, 5, 1, self.Range)

				if self.Shots >= self.NumShots then
					self:Remove()
					return false
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
	local wep = ply:GetWeapon('tfa_bo1_spikemore')
	if not IsValid(wep) or ply:GetAmmoCount(GetNZAmmoID("specialgrenade")) >= wep.NZSpecialWeaponData.MaxAmmo then
		wep = ply:GetWeapon('tfa_bo1_spikemore_trap')
	end

	if IsValid(wep) then
		local pickup = false
		if wep.NZSpecialCategory and wep.NZSpecialCategory == "trap" and ply:GetAmmoCount(wep:GetPrimaryAmmoType()) + wep:Clip1() < wep.Primary.DefaultClip then
			pickup = true
			ply:GiveAmmo(1, wep:GetPrimaryAmmoType(), true)
		elseif wep.NZSpecialCategory and wep.NZSpecialCategory == "specialgrenade" and ply:GetAmmoCount(GetNZAmmoID("specialgrenade")) < wep.NZSpecialWeaponData.MaxAmmo then
			pickup = true
			ply:GiveAmmo(1, GetNZAmmoID("specialgrenade"), true)
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

function ENT:Trigger()
	if self.Triggered then return end
	self.Triggered = true

	self:EmitSound("TFA_BO1_SPIKEMORE.Alert")
	timer.Simple(0.25, function()
		if not IsValid(self) then return end
		self:Explode()
	end)
end

function ENT:FireSpike(ent)
	local pos = self:GetAttachment(1).Pos
	local dir = self:GetForward() + self:GetUp()*math.Rand(0,0.4)
	if IsValid(ent) then
		dir = (ent:EyePos() - ent:OBBCenter()*math.Rand(0,0.4)) - pos
	end

	local bulletinfo = {
		Attacker = IsValid(self:GetOwner()) and self:GetOwner() or self,
		Callback = function(attacker, trace, dmginfo)
			if CLIENT then return end
			dmginfo:SetDamageType(DMG_MISSILEDEFENSE)
			if self.Inflictor and IsValid(self.Inflictor) then
				dmginfo:SetInflictor(self.Inflictor)
			end

			local tent = trace.Entity
			if IsValid(tent) then
				if tent:IsPlayer() then
					dmginfo:SetDamage(0)
					dmginfo:ScaleDamage(0)
				end

				/*if not tent:IsWorld() then
					if tent:IsValidZombie() then
						local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
						local health = tonumber(nzCurves.GenerateHealthCurve(round))*0.6 //60% of zombie max health
						dmginfo:SetDamage(health + self.Damage) //plus actual SWEP damage

						local headbone = tent:LookupBone("ValveBiped.Bip01_Head1")
						if !headbone then headbone = tent:LookupBone("j_head") end
						if headbone and tent:GetBonePosition(headbone):DistToSqr(trace.HitPos) < 144 then //12^2
							dmginfo:SetDamage(tent:Health() + 666) //headshots
							dmginfo:SetDamagePosition(tent:GetBonePosition(headbone))
						end

						if tent.NZBossType or tent.IsMooBossZombie or string.find(tent:GetClass(), "zombie_boss") then
							local rand = math.random(12,24)
							damage:SetDamage(math.max(rand, tent:GetMaxHealth() / rand))
						end
					end

					local spike = ents.Create("bo1_spikemore_spike")
					spike:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")
					spike:SetOwner(tent)
					spike:SetBoneTarget(trace.PhysicsBone)

					spike:Spawn()

					spike:EmitSound("TFA_BO1_SPIKEMORE.Hit")
				else*/
				if tent:IsWorld() then
					local spike = ents.Create("bo1_spikemore_spike_world")
					spike:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")
					spike:SetPos(trace.HitPos - trace.Normal*math.Rand(2,9))
					spike:SetAngles(trace.Normal:Angle())

					spike:Spawn()

					spike:EmitSound("TFA_BO1_SPIKEMORE.Hit")
				end
			elseif trace.HitWorld then
				local spike = ents.Create("bo1_spikemore_spike_world")
				spike:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")
				spike:SetPos(trace.HitPos - trace.Normal*math.Rand(2,9))
				spike:SetAngles(trace.Normal:Angle())

				spike:Spawn()

				spike:EmitSound("TFA_BO1_SPIKEMORE.Hit")
			end
		end,
		Damage = self.Damage,
		Force = 80,
		Tracer = 0,
		TracerName = "none",
		Src = pos,
		Dir = dir,
		Spread = IsValid(ent) and Vector(0.8,0.8,0.8) or Vector(0.2, 0.2, 0.2),
		IgnoreEntity = self,
	}

	self:FireBullets(bulletinfo)
end

function ENT:DoExplosionEffect()
	local tr = util.QuickTrace(self:GetPos(), Vector(0,0,-64), self)
	util.Decal("Scorch", tr.HitPos - tr.HitNormal, tr.HitPos + tr.HitNormal)

	self:EmitSound("TFA_BO1_SPIKEMORE.Blast")
	self:EmitSound("TFA_BO1_SPIKEMORE.Flux")

	ParticleEffect("bo1_spikemore_explode", self:GetAttachment(1).Pos, self:GetForward():Angle())
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	self.Damage = self.mydamage or self.Damage
	self.NextAttack = CurTime()

	self:DoExplosionEffect()
	SafeRemoveEntityDelayed(self, 8) //better safe than sorry
end

function ENT:OnRemove()
	if SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) and ply.activespikemors and table.HasValue(ply.activespikemors, self) then
			table.RemoveByValue(ply.activespikemors, self)
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
			local wep = ply:GetWeapon('tfa_bo1_spikemore')
			if not IsValid(wep) then
				wep = ply:GetWeapon('tfa_bo1_spikemore_trap')
			end

			if IsValid(wep) then
				local special = wep.NZSpecialCategory == "specialgrenade"
				if wep.NZSpecialWeaponData and ply:GetAmmoCount(special and "nz_specialgrenade" or wep:GetPrimaryAmmoType()) + (special and 0 or wep:Clip1()) >= wep.NZSpecialWeaponData.MaxAmmo then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - remove Spikemore"
				else
					return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup Spikemore"
				end
			else
				return "Spikemore"
			end
		else
			if IsValid(ply) then
				return ply:Nick().."'s Spikemore"
			else
				return "Spikemore"
			end
		end
	end
end