AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "drop_powerups"
ENT.Spawnable = false

ENT.Author = "Moo, Fox, Jen"
ENT.Contact = "dont"

game.AddParticles("particles/moo_powerup_fx.pcf")

ENT.NextDraw = 0

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "PowerUp")
	self:NetworkVar("String", 1, "HintString")

	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Blinking")
	self:NetworkVar("Bool", 2, "Anti")
	self:NetworkVar("Bool", 3, "PressUse")

	self:NetworkVar("Float", 0, "ActivateTime")
	self:NetworkVar("Float", 1, "BlinkTime")
	self:NetworkVar("Float", 2, "KillTime")
end

function ENT:Draw()
	if not self.GetActivated then return end

	if self:GetActivated() then
		self:DrawModel()
		if self.introglow and IsValid(self.introglow)then
			self.introglow:StopEmission()
		end
		if !self.loopglow or !IsValid(self.loopglow) then
			local global = nzPowerUps:Get(self:GetPowerUp()).global
			local colorvec1 = self:GetAnti() and nzMapping.Settings.powerupcol["anti"][1] or global and nzMapping.Settings.powerupcol["global"][1] or nzMapping.Settings.powerupcol["local"][1]
			local colorvec2 = self:GetAnti() and nzMapping.Settings.powerupcol["anti"][2] or global and nzMapping.Settings.powerupcol["global"][2] or nzMapping.Settings.powerupcol["local"][2]
			local colorvec3 = self:GetAnti() and nzMapping.Settings.powerupcol["anti"][3] or global and nzMapping.Settings.powerupcol["global"][3] or nzMapping.Settings.powerupcol["local"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_ABSORIGIN_FOLLOW)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(1,1,1))
			else
				self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_ABSORIGIN_FOLLOW)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(1,1,1))
			end
		end
	else
		if !self.introglow or !IsValid(self.introglow)then
			local global = nzPowerUps:Get(self:GetPowerUp()).global
			local colorvec1 = self:GetAnti() and nzMapping.Settings.powerupcol["anti"][1] or global and nzMapping.Settings.powerupcol["global"][1] or nzMapping.Settings.powerupcol["local"][1]
			local colorvec2 = self:GetAnti() and nzMapping.Settings.powerupcol["anti"][2] or global and nzMapping.Settings.powerupcol["global"][2] or nzMapping.Settings.powerupcol["local"][2]
			local colorvec3 = self:GetAnti() and nzMapping.Settings.powerupcol["anti"][3] or global and nzMapping.Settings.powerupcol["global"][3] or nzMapping.Settings.powerupcol["local"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.introglow = CreateParticleSystem(self, style.intro, PATTACH_ABSORIGIN_FOLLOW)
				self.introglow:SetControlPoint(2, colorvec1)
				self.introglow:SetControlPoint(3, colorvec2)
				self.introglow:SetControlPoint(4, colorvec3)
				self.introglow:SetControlPoint(1, Vector(1,1,1))
			else
				self.introglow = CreateParticleSystem(self, "nz_powerup_classic_intro", PATTACH_ABSORIGIN_FOLLOW)
				self.introglow:SetControlPoint(2, colorvec1)
				self.introglow:SetControlPoint(3, colorvec2)
				self.introglow:SetControlPoint(4, colorvec3)
				self.introglow:SetControlPoint(1, Vector(1,1,1))
			end
		elseif self.introglow and IsValid(self.introglow) then
			local max = (self:GetActivateTime() - self:GetCreationTime())
			local cur = (self:GetActivateTime() - CurTime())
			local ratio = 1 - math.Clamp(cur/max, 0, 1)

			self.introglow:SetControlPoint(5, Vector(ratio,ratio,ratio))
		end
	end
end

function ENT:Initialize()
	if SERVER then
		SafeRemoveEntityDelayed(self, 30)
	end

	local pdata = nzPowerUps:Get(self:GetPowerUp())
	self:SetModelScale(pdata.scale, 0)

	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

	self:UseTriggerBounds(true, 8)
	self:DrawShadow(false)

	self.GlobalPowerup = nzPowerUps:Get(self:GetPowerUp()).global
	self.LoopSound =  "nz_moo/powerups/powerup_lp_zhd.wav"
	self.GrabSound = "nz_moo/powerups/powerup_pickup_zhd.mp3"
	self.SpawnSound = "nz_moo/powerups/powerup_spawn_zhd_"..math.random(1,3)..".mp3"

	if !table.IsEmpty(nzSounds.Sounds.Custom.Loop) then
		self.LoopSound = tostring(nzSounds.Sounds.Custom.Loop[math.random(#nzSounds.Sounds.Custom.Loop)])
	end
	if !table.IsEmpty(nzSounds.Sounds.Custom.Grab) then
		self.GrabSound = tostring(nzSounds.Sounds.Custom.Grab[math.random(#nzSounds.Sounds.Custom.Grab)])
	end
	if !table.IsEmpty(nzSounds.Sounds.Custom.Spawn) then
		self.SpawnSound = tostring(nzSounds.Sounds.Custom.Spawn[math.random(#nzSounds.Sounds.Custom.Spawn)])
	end

	self:EmitSound("nz_moo/powerups/powerup_intro_start.mp3")
	self:EmitSound("nz_moo/powerups/powerup_intro_lp.wav",100, 100, 1, 2)

	self:SetBlinkTime(CurTime() + 25)
	self:SetKillTime(CurTime() + 30)

	self:SetActivated(false)
	self:SetBlinking(false)

	if CLIENT then return end
	local distfac = 0
	local nearest = self:FindNearestPlayer(self:GetPos())
	if IsValid(nearest) then
		local dist = self:GetPos():DistToSqr(nearest:GetPos())
		distfac = 1 - math.Clamp(dist / 40000, 0, 1) //200^2
	end

	if self:GetAnti() then
		self:SetActivateTime(CurTime() + (nzMapping.Settings.antipowerupdelay or 4))
	else
		self:SetActivateTime(CurTime() + (3 * distfac))
	end

	self:SetPressUse(pdata.pressuse and tobool(pdata.pressuse) or false)
	nzPowerUps:PowerupHudSync(self)

	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)

	if pdata.spawnfunc then
		pdata.spawnfunc(self:GetPowerUp(), self)
	end

	if IsValid(nearest) then
		self:OOBTest(nearest)
	end
end

function ENT:OOBTest(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	local size = Vector(2, 2, 2)
	local entpos = ply:WorldSpaceCenter()
	local pos = self:WorldSpaceCenter()

	local tr = util.TraceLine({
		start = pos,
		endpos = entpos,
		filter = {self, ply},
		mask = MASK_SOLID_BRUSHONLY
	})

	//Check 1, trace to player, if interrupted by world, teleport infront of a barricade closest to player
	if tr.HitWorld then
		local barricade = self:FindNearestBarricade(entpos)
		if barricade and IsValid(barricade) then
			//print('Powerup1, Trace to player blocked by world')
			local normal = (ply:GetPos() - barricade:GetPos()):GetNormalized()
			local fwd = barricade:GetForward()
			local dot = fwd:Dot(normal)

			if 0 < dot then
				self:SetPos(barricade:GetPos() + vector_up*50 + fwd*50)
			else
				self:SetPos(barricade:GetPos() + vector_up*50 + fwd*-50)
			end
			return
		end
	end

	//Check 2, raycast to player, if interrupted by a barricade, teleport infront of that barricade
	for k, v in pairs(ents.FindAlongRay(pos, entpos, -size, size)) do
		if v:GetClass() == "breakable_entry" then
			//print('Powerup2, Barricade blocking raycast to player')
			local normal = (ply:GetPos() - v:GetPos()):GetNormalized()
			local fwd = v:GetForward()
			local dot = fwd:Dot(normal)

			if 0 < dot then
				self:SetPos(v:GetPos() + vector_up*50 + fwd*50)
			else
				self:SetPos(v:GetPos() + vector_up*50 + fwd*-50)
			end
			return
		end
	end

	//Check 3, if theres a barricade next to us at all, place on side with player
	for k, v in pairs(ents.FindInSphere(pos, 60)) do
		if v:GetClass() == "breakable_entry" then
			//print('Powerup3, Barricade too close')
			local ply2 = self:FindNearestPlayer(v:GetPos())
			if ply2 and IsValid(ply2) then
				local normal = (self:GetPos() - v:GetPos()):GetNormalized()
				local normal2 = (ply2:GetPos() - v:GetPos()):GetNormalized()
				local fwd = v:GetForward()
				local dot = fwd:Dot(normal)
				local dot2 = fwd:Dot(normal2)

				if 0 < dot2 and dot > 0 then
					self:SetPos(v:GetPos() + vector_up*50 + fwd*50)
				elseif 0 > dot2 and dot < 0 then
					self:SetPos(v:GetPos() + vector_up*50 + fwd*-50)
				end
				return
			end
		end
	end
end

function ENT:FindNearestPlayer(pos)
	if not pos then
		pos = self:GetPos()
	end

	local nearbyents = {}
	for k, v in pairs(player.GetAll()) do
		if v:Alive() then
			table.insert(nearbyents, v)
		end
	end

	if table.IsEmpty(nearbyents) then return end
	if #nearbyents > 1 then
		table.sort(nearbyents, function(a, b) return tobool(a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos)) end)
	end
	return nearbyents[1]
end

function ENT:FindNearestBarricade(pos)
	if not pos then
		pos = self:GetPos()
	end

	local nearbyents = {}
	for k, v in pairs(ents.FindInSphere(pos, 2048)) do
		if v:GetClass() == "breakable_entry" then
			table.insert(nearbyents, v)
		end
	end

	if table.IsEmpty(nearbyents) then return end
	if #nearbyents > 1 then
		table.sort(nearbyents, function(a, b) return tobool(a:GetPos():DistToSqr(pos) < b:GetPos():DistToSqr(pos)) end)
	end
	return nearbyents[1]
end

function ENT:Use(ply)
	if self:GetActivated() and self:GetPressUse() and !self:GetAnti() and IsValid(ply) and ply:IsPlayer() then
		nzPowerUps:Activate(self:GetPowerUp(), ply, self)
		ply:EmitSound(nzPowerUps:Get(self:GetPowerUp()).collect or self.GrabSound)
		self:Remove()
	end
end

function ENT:StartTouch(ent)
	if not IsValid(ent) then return end

	if self:GetActivated() then
		if self:GetAnti() then
			if ent:IsValidZombie() then
				nzPowerUps:ActivateAnti(self:GetPowerUp(), ent, self)
				ent:EmitSound(nzPowerUps:Get(self:GetPowerUp()).collect or self.GrabSound)
				self:Remove()
			end
		elseif ent:IsPlayer() and not self:GetPressUse() then
			nzPowerUps:Activate(self:GetPowerUp(), ent, self)
			ent:EmitSound(nzPowerUps:Get(self:GetPowerUp()).collect or self.GrabSound)
			self:Remove()
		end
	end
end

local LAST_PULL_VEC = Vector(0,0,0)
local CURRENT_PUSH = 0
local PUSH_STRENGTH = 5

local PUSH = {
	Vector(PUSH_STRENGTH, 0, 0), --horizontal
	Vector(0, PUSH_STRENGTH, 0), --vertical
	Vector(-PUSH_STRENGTH, PUSH_STRENGTH, 0), --diagonal (left)
	Vector(PUSH_STRENGTH, PUSH_STRENGTH, 0) --diagonal (right)
}

function ENT:Think()
	if CLIENT then
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles() + Angle(2,50,5)*math.sin(CurTime()/10)*FrameTime())
	end

	if self:GetBlinking() and self.NextDraw < CurTime() then
		local time = self:GetKillTime() - self:GetBlinkTime()
		local final = math.Clamp(self:GetKillTime() - CurTime(), 0.1, 1)
		final = math.Clamp(final / time, 0.1, 1)

		self:SetNoDraw(not self:GetNoDraw())
		self.NextDraw = CurTime() + math.Clamp(1 * final, 0.1, 1)
	end

	if not self:GetActivated() and self:GetActivateTime() < CurTime() then
		self:DrawShadow(true)

		self:EmitSound(self.LoopSound, 75, 100, 1, 3)
		self:EmitSound(self.SpawnSound, 100)
		self:StopSound("nz_moo/powerups/powerup_intro_lp.wav")

		if SERVER then
			self:SetSolid(SOLID_OBB)
			if self:GetAnti() then
				self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
				UpdateAllZombieTargets(self)
			end

			local fx = EffectData()
			fx:SetOrigin(self:GetPos()) //position
			fx:SetAngles(angle_zero) //angle
			fx:SetNormal(Vector(1,1,1)) //size (dont ask why its a vector)
			fx:SetFlags(self:GetAnti() and 4 or self.GlobalPowerup and 1 or 2) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

			local filter = RecipientFilter()
			filter:AddPVS(self:GetPos())
			if filter:GetCount() > 0 then
				util.Effect("nz_powerup_poof", fx, true, filter)
			end

			self:SetActivated(true)
		end
	end

	if not self:GetBlinking() and self:GetBlinkTime() < CurTime() then
		self:SetBlinking(true)
	end

	if SERVER then
		if self:GetActivated() and !self:GetAnti() then
			local vulturetargets = {}
			for _, ply in ipairs(player.GetAll()) do
				if ply:HasUpgrade("vulture") then
					table.insert(vulturetargets, ply)
				end
			end

			if next(vulturetargets) ~= nil then
				if #vulturetargets > 1 then
					table.sort(vulturetargets, function(a, b) return tobool(a:GetPos():DistToSqr(self:GetPos()) < b:GetPos():DistToSqr(self:GetPos())) end)
				end

				local vtarget = vulturetargets[1]
				if IsValid(vtarget) and vtarget:Visible(self) then
					local angle = 1 - math.cos(math.rad(40))
					local dir = vtarget:EyeAngles():Forward()
					local facingdir = (vtarget:EyePos() - self:GetPos()):GetNormalized()

					local faceing = !((facingdir:Dot(dir) + 1) / 2 > angle)
					local eyesight = (vtarget:GetEyeTrace().Entity == self)

					local ratio = (1/engine.TickInterval())*(0.1*engine.TickInterval()) //0.1 taking into account tps
					local maxspeed = (eyesight and 24) or (faceing and 12) or 6
					local CURRENT_PUSH = Lerp(ratio, CURRENT_PUSH, maxspeed) //smooth out speed
					local targetpos = vtarget:OnGround() and (vtarget:GetPos() + vector_up*50) or vtarget:GetPos()

					LAST_PULL_VEC = LerpVector(ratio*0.5, LAST_PULL_VEC, (self:GetPos() - targetpos):GetNormalized()) //smooth out turning
					self:SetPos(self:GetPos() - LAST_PULL_VEC*CURRENT_PUSH)
				end
			end
		end

		local pdata = nzPowerUps:Get(self:GetPowerUp())
		if not pdata.nopush then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), pdata.pusharea or 12)) do --powerups are too close to each other!
				if v:GetClass() == "drop_powerup" and v ~= self then
					if not nzPowerUps:Get(v:GetPowerUp()).nopush then
						if v:EntIndex() < self:EntIndex() then
							if not self.pushdirection then self.pushdirection = math.random(4) end
							self:SetPos(self:GetPos() + (PUSH[self.pushdirection] / (pdata.pushdelta or 10)))
							v:SetPos(v:GetPos() - (PUSH[self.pushdirection] / (pdata.pushdelta or 10)))
						end
					end
				end
			end
		end
	end

	if CLIENT then
		self:SetNextClientThink(CurTime())
	end
	self:NextThink(CurTime())
	return true
end

if CLIENT then
	function ENT:GetNZTargetText()
		local hint = self:GetHintString()
		if hint ~= "" then
			if self:GetPressUse() then
				return "Press "..string.upper(input.LookupBinding("+USE")).." - "..hint
			else
				return hint
			end
		end
	end
end

function ENT:OnRemove()
	if IsValid(self) then
		self:StopParticles()
		self:StopSound("nz_moo/powerups/powerup_intro_lp.wav")
		self:StopSound(self.LoopSound)

		if SERVER then
			nzPowerUps:PowerupHudRemove(self)

			local fx = EffectData()
			fx:SetOrigin(self:GetPos()) //position
			fx:SetAngles(angle_zero) //angle
			fx:SetNormal(Vector(1,1,1)) //size (dont ask why its a vector)
			fx:SetFlags(self:GetAnti() and 4 or self.GlobalPowerup and 1 or 2) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

			local filter = RecipientFilter()
			filter:AddPVS(self:GetPos())
			if filter:GetCount() > 0 then
				util.Effect("nz_powerup_poof", fx, true, filter)
			end
		end
	end
end
