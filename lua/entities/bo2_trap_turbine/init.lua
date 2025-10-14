
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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

local doortargets = {
	["prop_door_rotating"] = true,
	["func_door_rotating"] = true,
	["func_door"] = true,
	["prop_buys"] = true
}

//credit to Hidden for original turbine code.
//and thanks to MikeyRay for giving me the turbine GSC, most of this is a copy paste of that.

function ENT:Initialize()
	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(CONTINUOUS_USE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)

	self.AutomaticFrameAdvance = true
	self:SetDestroyed(false)
	self:SetActivated(false)

	self.RangeSqr = self.Range * self.Range
	self.localpower = {}
	self.turbine_activate_wait = CurTime() + self.Delay
	self.turbine_power_level = nil
	self.turbine_power_wait = self.turbine_activate_wait + 1
	self.turbine_next_decay = self.turbine_activate_wait + 1
	self.turbine_spark_wait = self.turbine_activate_wait + 1

	self:EmitSound("TFA_BO2_SHIELD.Plant")
	self:EmitSound("TFA_BO2_TURBINE.Wind")
	self:TurbineAnim()

	if nzombies then
		self:SetTargetPriority(TARGET_PRIORITY_PLAYER)

		for k, v in pairs(ents.FindByClass(self:GetClass())) do
			if v:GetOwner() == self:GetOwner() and v ~= self then
				v:SetHealth(1)
				v:TakeDamage(666, self)
				continue
			end
		end
	end

	local ply = self:GetOwner()
	if IsValid(ply) then
		if nzombies and ply:IsPlayer() then
			timer.Simple(0, function()
				if not IsValid(ply) or not IsValid(self) then return end
				ply:AddBuildable(self)
			end)
		end

		ply.NextTrapUse = CurTime() + 0.35 //use delay

		if not util.IsInWorld(self:GetPos()) then
			self:SetPos(ply:GetPos()) //plz dont get stuck in walls
		end
	end
end

function ENT:Think()
	local ply = self:GetOwner()
	if not IsValid(ply) then
		self:SetHealth(1)
		self:TakeDamage(666, self, self)
		return false
	end

	if not self:GetDestroyed() then
		if not self:GetActivated() and not self:TurbineIsPoweringOn() then
			self:TurbinePowerOn()
		end

		self:TurbineDecay()
		self:TurbinePowerDiminish()
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnTakeDamage(dmginfo)
	local attacker = dmginfo:GetAttacker()
	if not IsValid(attacker) then return end
	if nzombies and attacker:IsPlayer() then return end
	if self:GetDestroyed() then return end

	local ratio = 0.2
	local bonus = 0.5
	local dmg = dmginfo:GetDamage() * ratio
	local newdmg = (dmginfo:GetDamage() - dmg) * bonus
	local damage = math.min(newdmg, 100)

	self:SetHealth(self:Health() - damage)

	if self:Health() <= 0 then
		self:SetActivated(false)
		self:SetDestroyed(true)

		self:ResetSequence("death")
		self:StopParticles()
		self:StopSound("TFA_BO2_TURBINE.Loop")

		SafeRemoveEntityDelayed(self, self:SequenceDuration() - 0.5)
	else
		self:TurbineAnim()

		if attacker ~= self then
			self:EmitSound("TFA_BO2_SHIELD.Hit")
		end
	end
end

function ENT:Use(ply)
	if CLIENT then return end
	if self:GetDestroyed() then return end
	if not IsValid(ply) then return end
	if ply ~= self:GetOwner() then return end
	if ply.NextTrapUse and ply.NextTrapUse > CurTime() then return end

	if not ply:HasWeapon(self:GetTrapClass()) then
		local wep = ply:Give(self:GetTrapClass())
		if IsValid(wep) then
			local hp = math.Clamp(self:Health() / self:GetMaxHealth(), 0, 1)
			wep:SetClip1(math.Round(hp * wep.Primary_TFA.ClipSize))
		end

		self:EmitSound("TFA_BO2_SHIELD.Pickup")
		self:Remove()
	end
end

function ENT:TurbinePowerUpdate() //this is probably the worst thing ive ever wrote so avoid calling it as often as possible, thanks
	local t_balls = ents.FindByClass("wunderfizz_machine")

	for k, v in ipairs(ents.GetAll()) do
		if (nzombies and not nzElec:IsOn()) and (doortargets[v:GetClass()] or v:IsBuyableEntity()) then
			if table.HasValue(self.localpower, v) then
				if self:GetPos():DistToSqr(v:GetPos()) > self.RangeSqr then
					local data = v:GetDoorData()
					if data then
						local datanum = tonumber(data.elec) or 0
						if datanum > 0 then
							v:LockDoor()
							self:ResetTurbine(v, true)
						end
					end
				end
			else
				if self:GetPos():DistToSqr(v:GetPos()) < self.RangeSqr then
					local data = v:GetDoorData()
					if data then
						local datanum = tonumber(data.elec) or 0
						if datanum > 0 then
							nzDoors:OpenDoor(v)
							v.Turbine = self
							table.insert(self.localpower, v)
						end
					end
				end
			end
		end

		if (v.TurnOn and v.TurnOff) then
			if table.HasValue(self.localpower, v) then
				if self:GetPos():DistToSqr(v:GetPos()) > self.RangeSqr then
					if v:GetClass() == "wunderfizz_machine" then
						if (nzombies and not nzElec:IsOn()) then
							local b_ballin = false
							for _, baller in pairs(t_balls) do
								if baller:IsOn() and baller:EntIndex() ~= v:EntIndex() then 
									b_ballin = true
									break
								end
							end

							if b_ballin or nzMapping.Settings.cwfizz then
								v:TurnOff()
								self:ResetTurbine(v, true)
							end
						end
					elseif v:GetClass() == "perk_machine" then
						if (nzombies and not nzElec:IsOn()) then
							v:TurnOff()
							self:ResetTurbine(v, true)
						end
					else
						v:TurnOff()
						self:ResetTurbine(v, true)
					end
				end
			else
				if self:GetPos():DistToSqr(v:GetPos()) < self.RangeSqr then
					if v:GetClass() == "perk_machine" then
						if (nzombies and not nzElec:IsOn()) then
							v:TurnOn()
							v.Turbine = self
							table.insert(self.localpower, v)
						end
					else
						v:TurnOn()
						v.Turbine = self
						table.insert(self.localpower, v)
					end
				end
			end
		end
	end
end

local switch_anims = {
	[1] = function(self) self:ResetSequence("neardeath") end,
	[2] = function(self) self:ResetSequence("halfpower") end,
	[3] = function(self) self:ResetSequence("fullpower") end,
}

function ENT:TurbineAnim()
	local old_power_level = self.turbine_power_level
	if self:Health() <= 100 then
		self.turbine_power_level = 1
	elseif self:Health() <= 200 then
		self.turbine_power_level = 2
	else
		self.turbine_power_level = 3
	end

	if old_power_level ~= self.turbine_power_level then
		switch_anims[self.turbine_power_level](self)
	end
end

function ENT:TurbineIsPoweringOn()
	return self.turbine_activate_wait > CurTime()
end

function ENT:TurbinePowerOn()
	if self:GetActivated() then return end
	self:SetActivated(true)
	self:TurbinePowerUpdate()

	self:EmitSound("TFA_BO2_TURBINE.Loop")
end

function ENT:TurbinePowerOff()
	if not self:GetActivated() then return end
	self:SetActivated(false)
	self:TurbineRemovePower()

	self:StopSound("TFA_BO2_TURBINE.Loop")
	self:StopParticles()
end

function ENT:TurbineDecay()
	if self:GetDestroyed() then return end
	if self:TurbineIsPoweringOn() then return end
	if self.turbine_next_decay < CurTime() then
		local cost = 1
		if self.localpower and not table.IsEmpty(self.localpower) then
			cost = cost + #self.localpower
		end

		self:EmitSound("TFA_BO2_TURBINE.Pulse")
		ParticleEffect("bo2_turbine_flare", self:GetPos(), Angle(0,0,0))
		self:TakeDamage(10 * cost, self)

		self.turbine_next_decay = CurTime() + 2
	end
	if self.turbine_spark_wait < CurTime() then
		ParticleEffect("bo2_turbine_spark", self:GetAttachment(2).Pos - (self:GetForward()*4), Angle(0,0,0))
		self.turbine_spark_wait = CurTime() + math.Rand(0.5, 2)
	end
end

local switch_power = {
	[1] = function(self)
		self:TurbinePowerOff()
		self.turbine_activate_wait = CurTime() + math.random(6, 12)
		self.turbine_power_wait = self.turbine_activate_wait + math.random(9, 12)
	end,
	[2] = function(self)
		self:TurbinePowerOff()
		self.turbine_activate_wait = CurTime() + math.random(3, 6)
		self.turbine_power_wait = self.turbine_activate_wait + math.random(12, 20)
	end,
	[3] = function(self) end,
}

function ENT:TurbinePowerDiminish()
	if self:GetDestroyed() then return end
	if not self.turbine_power_level then return end
	if self.turbine_power_level >= 3 then return end

	if self.turbine_power_wait < CurTime() then
		switch_power[self.turbine_power_level](self)
	end
end

//bool removes ent from turbines localpower table
function ENT:ResetTurbine(ent, remove)
	if ent.Turbine and ent.Turbine == self then
		ent.Turbine = nil
	end
	if remove and self.localpower and table.HasValue(self.localpower, ent) then
		table.RemoveByValue(self.localpower, ent)
	end
end

function ENT:TurbineRemovePower()
	if not self.localpower or not istable(self.localpower) then return end

	local tabs = ents.FindByClass("bo2_trap_turbine")
	for k, v in pairs(self.localpower) do
		local powered = false
		for _, turbine in pairs(tabs) do
			if turbine:GetActivated() and turbine.localpower and table.HasValue(turbine.localpower, v) then
				powered = true
			end
		end

		if IsValid(v) and (nzombies and not nzElec:IsOn()) and (doortargets[v:GetClass()] or v:IsBuyableEntity()) and not powered then
			local data = v:GetDoorData()
			if data then
				local datanum = tonumber(data.elec) or 0
				if datanum > 0 then
					v:LockDoor()
					self:ResetTurbine(v)
				end
			end
		end

		if IsValid(v) and v.TurnOff and not powered then
			if v:GetClass() == "perk_machine" then
				if (nzombies and not nzElec:IsOn()) then
					v:TurnOff()
					self:ResetTurbine(v)
				end
			else
				v:TurnOff()
				self:ResetTurbine(v)
			end
		end
	end

	table.Empty(self.localpower)
end

