
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
ENT.PrintName = "Placed Trap"

--[Sounds]--
ENT.AttackSound = "TFA_BO2_BEARTRAP.Snap"
ENT.MortarSound = "TFA_BO2_BEARTRAP.Mortar"

--[Parameters]--
ENT.Delay = 1
ENT.NextAttack = 0

ENT.Uses = 0
ENT.MaxUses = 24
ENT.NZHudIcon = Material("vgui/icon/hud_beartrap.png", "unlitgeneric smooth")

DEFINE_BASECLASS(ENT.Base)

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Molotov")
	self:NetworkVar("Bool", 1, "Destroyed")
end

function ENT:PhysicsCollide(data, phys)
	timer.Simple(0, function()
		self:SetMoveType(MOVETYPE_NONE)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end)

	phys:EnableMotion(false)
	phys:Sleep()
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:UseTriggerBounds(true)

	local ply = self:GetOwner()
	if ply:IsPlayer() and ply:HasPerk("time") then
		self.Delay = 0.5
	end
	self.BackupIcon = self.NZHudIcon

	if CLIENT then return end
	self:OverflowCheck()
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

local max_bbettys = GetConVar("nz_difficulty_max_placeables")
function ENT:OverflowCheck()
	local ply = self:GetOwner()
	if not ply.activebeartraps then ply.activebeartraps = {} end
	table.insert(ply.activebeartraps, self)

	if #ply.activebeartraps > max_bbettys:GetInt() then
		for k, v in pairs(ply.activebeartraps) do
			if v == self then continue end
			v:Trigger()
			v:SetDestroyed(true)
			v:Reset()
			break
		end
	end
end

function ENT:InflictDamage(ent)
	if ent.BecomeCrawler and !ent.IsMooSpecial and !ent.IsMooBossZombie and !ent.HasGibbed and !ent.ShouldCrawl then //crawl
		timer.Simple(0, function()
			if not IsValid(ent) then return end
			if ent.Alive and not ent:Alive() then return end
			if ent:Health() <= 0 then return end
			if ent.ShouldCrawl then return end
			if ent.HasGibbed then return end

			local lleg = ent:LookupBone("j_knee_le")
			local rleg = ent:LookupBone("j_knee_ri")
			local randleggib = math.random(4)

			if (lleg and !ent.LlegOff) and (randleggib == 1 or randleggib == 3) then
				ent.LlegOff = true
				ent:DeflateBones({
					"j_knee_le",
					"j_knee_bulge_le",
					"j_ankle_le",
					"j_ball_le",
				})

				ParticleEffectAttach("ins_blood_dismember_limb", 4, ent, 7)
			end

			if (rleg and !ent.RlegOff) and (randleggib == 2 or randleggib == 3) then
				ent.RlegOff = true
	    		ent:DeflateBones({
					"j_knee_ri",
					"j_knee_bulge_ri",
					"j_ankle_ri",
					"j_ball_ri",
				})

				ParticleEffectAttach("ins_blood_dismember_limb", 4, ent, 8)
			end

			ent:EmitSound("nz_moo/zombies/gibs/bodyfall/fall_0"..math.random(2)..".mp3",100)
			ent.ShouldCrawl = true
			ent:BecomeCrawler()
		end)
	end

	local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
	local health = tonumber(nzCurves.GenerateHealthCurve(round))
	local mydamage = health*0.5
	if ent:Health() < mydamage and ent.GetCrawler and ent:GetCrawler() then
		mydamage = mydamage + 115
	end

	local damage = DamageInfo()
	damage:SetDamage(mydamage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageType(DMG_SLASH)
	damage:SetDamagePosition(self:WorldSpaceCenter() + vector_up)
	damage:SetDamageForce(vector_up)

	ent.IgnoreMeleeBonus = true
	ent:TakeDamageInfo(damage)
	ent.IgnoreMeleeBonus = false

	local jitter = VectorRand() * 25
	jitter.z = 20

	local qtr = util.QuickTrace(self:GetPos() + jitter, Vector(0,0,-256), self)
	util.Decal("Blood", qtr.HitPos - qtr.HitNormal, qtr.HitPos + qtr.HitNormal)
end

function ENT:Trap(ent)
	self:MortarCheck()
	self:InflictDamage(ent)
	self:Trigger()
	self:Reset()
end

function ENT:Reset()
	timer.Simple(self.Delay,function()
		if not IsValid(self) then return end
		if self:GetDestroyed() then
			self:Remove()
			return
		end

		self:SetSequence("idle_open")
	end)
end

function ENT:StartTouch(ent)
	if self:GetDestroyed() then return end
	if self.NextAttack > CurTime() then return end
	if not ent:IsValidZombie() then return end
	self:Trap(ent)
end

function ENT:Think()
	if not IsValid(self:GetOwner()) then
		self:Trigger()
		self:SetDestroyed(true)
		self:Reset()
		return false
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Trigger()
	local fx = EffectData()
	fx:SetOrigin(self:GetPos())
	fx:SetNormal(self:GetUp():GetNormalized()*15)
	fx:SetMagnitude(2)
	fx:SetScale(2)

	util.Effect("ElectricSpark", fx)

	self.NextAttack = CurTime() + self.Delay
	self.Uses = self.Uses + 1
	if self.Uses >= self.MaxUses then
		self:SetDestroyed(true)
	end

	self:EmitSound(self.AttackSound)
	self:SetSequence("idle_closed")
end

function ENT:MortarCheck()
	if self:GetMolotov() then
		self:MolotovExplode()
		self:SetBodygroup(2, 0)
		self:SetMolotov(false)
	end
end

function ENT:Use(ply, call)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if self:GetDestroyed() then return end
	if ply.NextUse and ply.NextUse > CurTime() then return end

	local moly = ply:GetWeapon('tfa_bo1_molotov')
	if self:GetMolotov() then
		local helper = self.MolotovPlayer
		if IsValid(helper) and helper == ply and helper:GetAmmoCount(GetNZAmmoID("specialgrenade")) < 3 then
			helper:GiveAmmo(1, GetNZAmmoID("specialgrenade"), false)
			self:SetBodygroup(2, 0)
			self:SetMolotov(false)

			ply.NextUse = CurTime() + 0.45
		end
	elseif IsValid(moly) and ply:GetAmmoCount(GetNZAmmoID("specialgrenade")) > 0 then
		self:SetBodygroup(2, 1)
		self:EmitSound(self.MortarSound)

		self:SetMolotov(true)
		self.MolotovPlayer = ply

		ply:RemoveAmmo(1, GetNZAmmoID("specialgrenade"), false)

		ply.NextUse = CurTime() + 0.45
	end

	if ply == self:GetOwner() then
		local wep = ply:GetWeapon('tfa_bo2_beartrap')
		if not IsValid(wep) or ply:GetAmmoCount(GetNZAmmoID("specialgrenade")) >= wep.NZSpecialWeaponData.MaxAmmo then
			wep = ply:GetWeapon('tfa_bo2_beartrap_trap')
		end

		if IsValid(wep) then
			local pickup = false
			if wep.NZSpecialCategory and wep.NZSpecialCategory == "trap" and ply:GetAmmoCount(wep:GetPrimaryAmmoType()) + wep:Clip1() < wep.Primary.DefaultClip then
				ply:GiveAmmo(1, wep:GetPrimaryAmmoType(), true)
				pickup = true
			elseif wep.NZSpecialCategory and wep.NZSpecialCategory == "specialgrenade" and ply:GetAmmoCount(GetNZAmmoID("specialgrenade")) < wep.NZSpecialWeaponData.MaxAmmo then
				ply:GiveAmmo(1, GetNZAmmoID("specialgrenade"), true)
				pickup = true
			end

			if !pickup then
				local fx = EffectData()
				fx:SetEntity(self)
				fx:SetOrigin(self:WorldSpaceCenter())
				fx:SetNormal(vector_up*-1)
				fx:SetScale(2)
				fx:SetMagnitude(2)
				fx:SetRadius(2)

				util.Effect("ElectricSpark", fx)
			end

			ply:EmitSound("weapon_bo3_gear.rattle")
			self:EmitSound("TFA_BO2_BEARTRAP.Raise")
			self:Remove()
		end
	end
end

function ENT:MolotovExplode()
	local ent = ents.Create("nz_bo1_molotov")
	ent:SetPos(self:GetPos() + vector_up)
	ent:SetAngles(angle_zero)
	ent:SetOwner(self:GetOwner())
	ent.Inflictor = self.Inflictor

	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	ent:SetVelocity(vector_up*-500)
	if IsValid(phys) then
		phys:SetVelocity(vector_up*-500)
	end
end

function ENT:OnRemove()
	if SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) and ply.activebeartraps and table.HasValue(ply.activebeartraps, self) then
			table.RemoveByValue(ply.activebeartraps, self)
		end

		if self:GetMolotov() then
			local helper = self.MolotovPlayer
			if IsValid(helper) and helper ~= ply and helper:GetAmmoCount(GetNZAmmoID("specialgrenade")) < 3 then
				helper:GiveAmmo(1, GetNZAmmoID("specialgrenade"), false)
			end
		end
	end

	if self:GetDestroyed() then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetOrigin(self:WorldSpaceCenter())
		fx:SetNormal(self:GetUp()*-1)
		fx:SetScale(25)

		util.Effect("cball_explode", fx)
		util.Effect("HelicopterMegaBomb", fx)

		self:EmitSound("TFA_BO2_SHIELD.Break")
		if SERVER then
			util.ScreenShake(self:GetPos(), 10, 255, 0.5, 150)
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

		local molotov = p:HasWeapon("tfa_bo1_molotov")
		if not self:GetMolotov() and molotov and p:GetAmmoCount(GetNZAmmoID("specialgrenade")) > 0 then
			if !self.NZHudIcon then
				self.NZHudIcon = Material("vgui/icon/molotov_tp.png", "unlitgeneric smooth")
			end

			return "Press "..string.upper(input.LookupBinding("+USE")).." - plant Molotov in trap"
		end

		if self.NZHudIcon ~= self.BackupIcon then
			self.NZHudIcon = self.BackupIcon
		end

		if p == ply then
			local wep = ply:GetWeapon('tfa_bo2_beartrap')
			if not IsValid(wep) then
				wep = ply:GetWeapon('tfa_bo2_beartrap_trap')
			end

			if IsValid(wep) then
				local special = wep.NZSpecialCategory == "specialgrenade"
				if wep.NZSpecialWeaponData and ply:GetAmmoCount(special and "nz_specialgrenade" or wep:GetPrimaryAmmoType()) + (special and 0 or wep:Clip1()) >= wep.NZSpecialWeaponData.MaxAmmo then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - remove Bear Trap"
				else
					return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup Bear Trap"
				end
			else
				return "Bear Trap"
			end
		else
			if IsValid(ply) then
				return ply:Nick().."'s Bear Trap"
			else
				return "Bear Trap"
			end
		end
	end
end
