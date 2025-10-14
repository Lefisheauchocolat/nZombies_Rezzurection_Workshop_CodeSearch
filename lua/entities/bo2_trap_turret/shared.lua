
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
ENT.Type = "anim"
ENT.PrintName = "Turret Trap"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

ENT.RPM = 350
ENT.RPMRapid = 600

ENT.NZHudIcon = Material("vgui/icon/zm_turret_icon.png", "smooth unlitgeneric")
ENT.bIsTrap = true

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "TrapClass")
	self:NetworkVar("Float", 0, "NextAttack")

	self:NetworkVar("Entity", 0, "Target")

	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Destroyed")
	self:NetworkVar("Bool", 2, "RapidFire")
end

function ENT:EmitSoundNet(sound)
	if CLIENT or sp then
		if sp and not IsFirstTimePredicted() then return end

		self:EmitSound(sound)
		return
	end

	local filter = RecipientFilter()
	filter:AddPAS(self:GetPos())
	if IsValid(self:GetOwner()) then
		filter:RemovePlayer(self:GetOwner())
	end

	net.Start("tfaSoundEvent", true)
	net.WriteEntity(self)
	net.WriteString(sound)
	net.Send(filter)
end

function ENT:Think()
	local ply = self:GetOwner()
	local ct = CurTime()

	if SERVER then
		if not IsValid(ply) then
			self:SetHealth(1)
			self:TakeDamage(666, self, self)
			return false
		end

		if self.turbine_power_wait < ct then
			self:TurretOff()
			self.turbine_activate_wait = ct + math.random(4, 6)
			self.turbine_power_wait = self.turbine_activate_wait + math.random(14, 20)
		end

		if not self:GetActivated() and self.turbine_activate_wait < ct then
			self:TurretOn()
		end
	end

	if self:GetActivated() then
		if self:GetNextAttack() < CurTime() then
			self:SetTarget(self:FindNearestEntity(self:GetPos()))
		end

		local ent = self:GetTarget()
		if IsValid(ent) then
			self:Attack(ent, self:GetAttachment(1).Pos)
			if SERVER then
				self:TakeDamage(math.random(5), ent, ent)
			end
		end
	end

	
	local rapid = self:GetRapidFire()
	if nzombies and IsValid(ply) and ply:HasPerk("time") then
		rapid = true
	end

	local nextthink = CurTime() + (60 / (rapid and self.RPMRapid or self.RPM))
	self:NextThink(nextthink)
	if CLIENT then
		self:SetNextClientThink(nextthink)
	end
	return true
end

function ENT:Attack(ent, pos)
	local bulletinfo = {
		Attacker = IsValid(self:GetOwner()) and self:GetOwner() or self,
		Callback = function(attacker, trace, dmginfo)
			if CLIENT then return end

			local turret = dmginfo:GetInflictor()
			if IsValid(turret) then
				turret:EmitSound("TFA_BO2_MOWER.Shoot")
				turret:EmitSound("TFA_BO2_MOWER.Decay")
			end

			dmginfo:SetDamageType(DMG_MISSILEDEFENSE)
			if IsValid(attacker) and attacker:IsPlayer() then
				dmginfo:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
			end

			local target = trace.Entity
			if IsValid(target) then
				if nzombies and target:IsValidZombie() then
					local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
					local health = tonumber(nzCurves.GenerateHealthCurve(round))
					local rand = math.random(6,12)

					dmginfo:SetDamage(math.max(15, health / rand))

					if target.NZBossType or string.find(target:GetClass(), "nz_zombie_boss") then
						local rand = math.random(40,60)
						dmginfo:SetDamage(math.max(15, target:GetMaxHealth()/rand))
					end
				end
			end
		end,
		Damage = 15,
		Force = 20,
		Tracer = 1,
		TracerName = "HelicopterTracer",
		Src = pos,
		Dir = ent:WorldSpaceCenter() - pos,
		Spread = Vector(5,5,5),
		IgnoreEntity = self,
	}

	if CLIENT then
		local muzzle = self:GetAttachment(1)
		local aimbone = self:LookupBone("tag_aim")
		local newang = WorldToLocal(ent:WorldSpaceCenter(), Angle(0,0,0), muzzle.Pos, self:GetAngles())
		self:ManipulateBoneAngles(aimbone, newang:Angle())

		muzzle = self:GetAttachment(1)
		local fx1 = EffectData()
		fx1:SetScale(2)
		fx1:SetOrigin(muzzle.Pos)
		fx1:SetAngles(muzzle.Ang)
		util.Effect("MuzzleEffect", fx1)
	end

	self:FireBullets(bulletinfo)
end

function ENT:TargetVisisble(ent, pos)
	if not IsValid(ent) then return false end

	local tr = {}
	tr.start = pos
	tr.filter = self
	tr.mask = MASK_SHOT
	tr.endpos = ent:WorldSpaceCenter()
	local tr1 = util.TraceLine(tr)
	return tr1.Entity == ent
end

function ENT:FindNearestEntity(pos)
	local nearbyents = {}

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 450)) do
		if v:IsNPC() or v:IsNextBot() or v:IsPlayer() then
			if nzombies and v:IsPlayer() then continue end
			if v == self:GetOwner() then continue end
			if v:Health() <= 0 then continue end
			if v.Alive and not v:Alive() then continue end
			if not self:TargetVisisble(v, pos) then continue end
			if v.Disposition and (v:Disposition(self:GetOwner()) == (D_LI or D_NU)) then continue end

			local normal = (v:GetPos() - pos):GetNormalized()
			local forward = self:GetForward()
			local dot = forward:Dot(normal)

			if dot < 0.4 then continue end

			table.insert(nearbyents, v)
		end
	end

	table.sort(nearbyents, function(a, b) return a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos) end)
	return nearbyents[1]
end

function ENT:OnRemove()
	self:StopSound("TFA_BO2_MOWER.Start")
	self:StopSound("TFA_BO2_MOWER.Loop")

	if self:GetDestroyed() then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetOrigin(self:WorldSpaceCenter())
		fx:SetNormal(self:GetUp()*-1)
		fx:SetScale(25)

		util.Effect("cball_explode", fx)
		util.Effect("HelicopterMegaBomb", fx)
	end

	if SERVER then
		local ply = self:GetOwner()
		if nzombies and IsValid(ply) and ply:IsPlayer() then
			ply:RemoveBuildable(self)
		end

		util.ScreenShake(self:GetPos(), 10, 255, 0.5, 150)
	end
end
