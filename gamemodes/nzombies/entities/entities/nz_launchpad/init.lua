
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

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/zmb/bo1/moon/zom_moon_jump_pad.mdl")
	end

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE)

	self:UseTriggerBounds(true)
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
	self:AddEFlags(EFL_FORCE_CHECK_TRANSMIT)
end

function ENT:Use(ply)
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

	local ent = nzJumps:GetLandingPadByFlag(self:GetFlag())
	if not IsValid(ent) then return end

	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 1/3

	if !(ply:IsInCreative() or nzRound:InState(ROUND_CREATE)) and self:GetRequireActive() and not ent:GetActivated() then return end
	if !(ply:IsInCreative() or nzRound:InState(ROUND_CREATE)) and self:GetElectric() and not nzElec:IsOn() then return end
	if self:CoolingDown() then return end

	local price = self:GetPrice()
	if price > 0 and not ply:IsInCreative() then
		ply:Buy(price, self, function()
			self:SetNextUse(CurTime() + self:GetCooldown())
			self:EmitSound(self.ChargeSound or "NZ.Jumppad.Charge")

			timer.Simple(1, function()
				if not IsValid(self) then return end
				self:Launch()
			end)

			return true
		end)
	else
		self:SetNextUse(CurTime() + (ply:IsInCreative() and 4 or self:GetCooldown()))
		self:EmitSound(self.ChargeSound or "NZ.Jumppad.Charge")

		timer.Simple(1, function()
			if not IsValid(self) then return end
			self:Launch()
		end)
	end
end

local flymins, flymaxs = Vector(-6.211900, -6.091400, -6.534200), Vector(6.211900, 5.972800, 5.708400)

function ENT:Launch()
	local ent = nzJumps:GetLandingPadByFlag(self:GetFlag())
	if not IsValid(ent) then return end

	local pos = self:GetPos()
	util.ScreenShake(pos, 255, 5, 2, 120)

	local launchplayers = {}
	for _, ply in ipairs(player.GetAll()) do
		if ply:Alive() and (!ply:IsSpectating() or ply:IsInCreative()) and ply:GetPos():DistToSqr(pos) < (80*self:GetModelScale())^2 then
			table.insert(launchplayers, ply)
		end
	end
	if table.IsEmpty(launchplayers) then return end

	for i=1, #launchplayers do
		local ply = launchplayers[i]
		if not IsValid(ply) then continue end

		if nzRound:InProgress() then
			self:jump_pad_enemy_follow_or_ignore(ply, ent, #launchplayers)
		end
		self:LaunchPlayer(ply, ent)
	end
end

function ENT:FindFinalLaunchPos()
end

function ENT:LaunchPlayer(ply, ent)
	local pos = self:GetPos()
	local ppos = ply:GetPos()
	ppos[3] = pos[3]

	local dir = (ppos - pos):GetNormalized()
	local offset = ppos:Distance(pos)*0.8

	local epos = ent:GetPos() + ent:OBBCenter()
	local finalpos = epos + (dir*offset)

	local start, height, failed = ply:GetPos() + vector_up, self:GetAirTime(), false
	local segs = math.Clamp(math.Round(finalpos:Distance(start)/40), 8, 64)
	local lastpos = start
	for i = 0, segs-1, 1 do
		local frac = i/segs
		local lpos = self:LaunchArc(finalpos, start, height, height*frac)
		local mins, maxs = ply:GetCollisionBounds()
		mins[3] = maxs[3]/2
		if util.TraceHull({start = lastpos, endpos = lpos, filter = {ply, self}, mins = mins, maxs = maxs}).HitWorld then
			failed = true
			break
		end
		if util.TraceHull({start = lastpos, endpos = lpos, filter = {ply, self}, mins = flymins, maxs = flymaxs}).HitWorld then
			failed = true
			break
		end
		lastpos = lpos
	end

	if failed then
		ply:SetPos(pos + (dir*(offset*0.2)))
		finalpos = epos + (dir*(offset*0.2))
	end

	ply:NZLaunch(self:GetAirTime(), finalpos, self:GetFlag())
end

function ENT:jump_pad_enemy_follow_or_ignore(ply, ent, plycount)
	if not IsValid(ent) then return end
	if not nzMapping.Settings.navgroupbased then return end
	if nzNav.Functions.IsInSameNavGroup(ply, ent) then return end

	local zombies = {}
	if nzLevel then
		for k, v in nzLevel.GetZombieArray() do
			if not IsValid(v) or not v:Alive() then continue end
			if v:Health() <= 0 then continue end
			if v.NZBossType or v.IsMooBossZombie then continue end
			if nzNav.Functions.IsInSameNavGroup(v, ent) then continue end

			if v.IsTarget and v:IsTarget(ply) then
				table.insert(zombies, v)
			end
		end
	else
		for k, v in pairs(ents.FindByClass("nz_zombie_*")) do
			if not v:IsValidZombie() then continue end
			if v:Health() <= 0 then continue end
			if v.NZBossType or v.IsMooBossZombie then continue end
			if nzNav.Functions.IsInSameNavGroup(v, ent) then continue end

			if v.IsTarget and v:IsTarget(ply) then
				table.insert(zombies, v)
			end
		end
	end

	local numplayers = #player.GetAllPlaying()
	if (game.SinglePlayer() or numplayers <= 1 or plycount >= numplayers) then
		self:BlackOps4Moment(zombies, ply)
	else
		self:stop_chasing_the_sky(zombies, ply)
	end
end

function ENT:stop_chasing_the_sky(zombies, ply)
	timer.Simple(engine.TickInterval(), function()
		for i=1, #zombies do
			local ent = zombies[i]
			if not IsValid(ent) then continue end
			ent:RemoveTarget()
		end
	end)
end

function ENT:BlackOps4Moment(zombies, ply)
	timer.Simple(self:GetAirTime(), function()
		for i=1, #zombies do
			local ent = zombies[i]
			if not IsValid(ent) then continue end
			timer.Simple(i*(engine.TickInterval()*3), function()
				if not IsValid(ent) then return end
				ent:RespawnZombie()
			end)
		end
	end)
end

function ENT:Reset()
	self:SetNextUse(0)
	local ent = nzJumps:GetLandingPadByFlag(self:GetFlag())
	if IsValid(ent) then
		ent:Reset()
	end
end

function ENT:TurnOn()
	if not self.Elec then return end
	self:SetElectric(false)
end

function ENT:TurnOff()
	if not self.Elec then return end
	self:SetElectric(true)
end
