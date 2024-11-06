AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName		= "drop_vulture"
ENT.Author			= "Zet0r"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DropType")

	self:NetworkVar("Bool", 1, "Blinking")

	self:NetworkVar("Float", 0, "BlinkTime")
	self:NetworkVar("Float", 1, "KillTime")
end

function ENT:Draw()
	if not self.GetDropType or self:GetDropType() == "" then
		return
	end

	local vulturedata = nzPerks:GetVultureDrop(self:GetDropType())
	if not vulturedata then
		return
	end

	if !vulturedata.nodraw then
		self:DrawModel()
	end

	if vulturedata.draw then
		vulturedata.draw(self)
	end

	if vulturedata.glow and (!self.loopglow or !IsValid(self.loopglow)) then
		local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
		local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
		local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

		if nzMapping.Settings.powerupstyle then
			local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
			self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
			self.loopglow:SetControlPoint(2, colorvec1)
			self.loopglow:SetControlPoint(3, colorvec2)
			self.loopglow:SetControlPoint(4, colorvec3)
			self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
		else
			self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
			self.loopglow:SetControlPoint(2, colorvec1)
			self.loopglow:SetControlPoint(3, colorvec2)
			self.loopglow:SetControlPoint(4, colorvec3)
			self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
		end
	end
end

function ENT:Initialize()
	if SERVER then
		SafeRemoveEntityDelayed(self, 60)
		if self:GetDropType() == "" then
			local chances = {}
			local vulturelist = nzMapping.Settings.vulturelist
			for id, data in pairs(nzPerks.VultureData) do
				if data.condition and !data.condition(self:GetPos()) then
					continue
				end
				if vulturelist and !vulturelist[id][1] then
					continue
				end
				chances[id] = data.chance
			end

			if table.IsEmpty(chances) then
				self:SetNoDraw(true)
				SafeRemoveEntityDelayed(self, 0)
				return
			else
				self:SetDropType(nzMisc.WeightedRandom(chances))
			end
		end
	end

	local vulturedata = nzPerks:GetVultureDrop(self:GetDropType())
	if not vulturedata then
		self:SetNoDraw(true)
		SafeRemoveEntityDelayed(self, 0)
		return
	end

	self:SetModel(vulturedata.model)
	self:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")
	self:EmitSound(vulturedata.dropsound or "nz_moo/powerups/vulture/vulture_drop.mp3", SNDLVL_NORM, math.random(97,103), 1, CHAN_WEAPON)

	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:UseTriggerBounds(true, 8)

	self:SetBlinkTime(CurTime() + vulturedata.timer - 5)
	self:SetKillTime(CurTime() + vulturedata.timer)
	self:SetBlinking(false)
	self.NextDraw = CurTime()

	if CLIENT and vulturedata.lamp then
		local lamp = ProjectedTexture()
		self.lamp = lamp

		lamp:SetTexture( "effects/flashlight001" )
		lamp:SetFarZ(42)
		lamp:SetFOV(math.random(55,70))

		lamp:SetPos(self:GetPos() + vector_up*24)
		lamp:SetAngles(Angle(90,0,0))

		local cvec = nzMapping.Settings.powerupcol["mini"][1]
		lamp:SetColor(Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255))
		lamp:Update()
	end

	if vulturedata.initialize then
		vulturedata.initialize(self)
	end

	if CLIENT then return end
	nzPowerUps:PowerupHudSync(self)

	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)

	local nearest = self:FindNearestPlayer(self:GetPos())
	if IsValid(nearest) then
		self:OOBTest(nearest)
	end
end

function ENT:OOBTest(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	local size = Vector(2, 2, 2)
	local entpos = ply:GetPos()
	local pos = self:GetPos()

	local tr = util.TraceLine({
		start = pos,
		endpos = entpos,
		filter = {self, ply},
		mask = MASK_SOLID_BRUSHONLY
	})

	//Check 1, trace to player, if interrupted by world, teleport infront of a barricade closest to player
	if tr.HitWorld then
		local barricade = self:FindNearestBarricade(entpos)
		if IsValid(barricade) then
			//print('Powerup1, Trace to player blocked by world')
			local normal = (ply:GetPos() - barricade:GetPos()):GetNormalized()
			local fwd = barricade:GetForward()
			local dot = fwd:Dot(normal)
			if 0 < dot then
				self:SetPos(barricade:WorldSpaceCenter() + fwd*50)
			else
				self:SetPos(barricade:WorldSpaceCenter() + fwd*-50)
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
				self:SetPos(v:WorldSpaceCenter() + fwd*50)
			else
				self:SetPos(v:WorldSpaceCenter() + fwd*-50)
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
					self:SetPos(v:WorldSpaceCenter() + fwd*50)
				elseif 0 > dot2 and dot < 0 then
					self:SetPos(v:WorldSpaceCenter() + fwd*-50)
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

function ENT:StartTouch(ent)
	local vulturedata = nzPerks:GetVultureDrop(self:GetDropType())
	if not vulturedata or not vulturedata.effect then return end

	local fuck = false
	for _, ply in pairs(player.GetAll()) do
		if ply:HasUpgrade("vulture") then
			fuck = true
			break
		end
	end

	if IsValid(ent) and ent:IsPlayer() and (ent:HasPerk("vulture") or fuck) and vulturedata.effect(ent) then
		self:Remove()
	end
end

function ENT:Touch(ent)
	local vulturedata = nzPerks:GetVultureDrop(self:GetDropType())
	if not vulturedata or not vulturedata.effect then return end

	local fuck = false
	for _, ply in pairs(player.GetAll()) do
		if ply:HasUpgrade("vulture") then
			fuck = true
			break
		end
	end

	if IsValid(ent) and ent:IsPlayer() and vulturedata.touch and (ent:HasPerk("vulture") or fuck) then
		vulturedata.effect(ent)
	end
end

function ENT:Think()
	local vulturedata = nzPerks:GetVultureDrop(self:GetDropType())
	if vulturedata.blink and !self:GetBlinking() and self:GetBlinkTime() < CurTime() then
		self:SetBlinking(true)
	end

	if self:GetBlinking() and self.NextDraw < CurTime() then
		local time = self:GetKillTime() - self:GetBlinkTime()
		local final = math.Clamp(self:GetKillTime() - CurTime(), 0.1, 1)
		final = math.Clamp(final / time, 0.1, 1)

		self:SetNoDraw(not self:GetNoDraw())
		self.NextDraw = CurTime() + math.Clamp(1 * final, 0.1, 1)
	end

	if vulturedata and vulturedata.think then
		vulturedata.think(self)
	end

	if SERVER then
		if self:GetKillTime() < CurTime() then
			self:StopParticles()
			self:Remove()
			return false
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	if IsValid(self) then
		self:StopParticles()

		local vulturedata = nzPerks:GetVultureDrop(self:GetDropType())
		if vulturedata then
			if vulturedata.onremove then
				vulturedata.onremove(self)
			end

			if CLIENT then
				if vulturedata.glow and (self.loopglow and IsValid(self.loopglow)) then
					self.loopglow:StopEmission()
				end
				if vulturedata.lamp and IsValid(self.lamp) then
					self.lamp:Remove()
				end
			end
		end

		if SERVER then
			nzPowerUps:PowerupHudRemove(self)

			local vulturedata = nzPerks:GetVultureDrop(self:GetDropType())
			if vulturedata and vulturedata.poof then
				local fx = EffectData()
				fx:SetOrigin(self:WorldSpaceCenter()) //position
				fx:SetAngles(angle_zero) //angle
				fx:SetNormal(Vector(0.65,0.65,0.65)) //size (dont ask why its a vector)
				fx:SetFlags(3) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

				local filter = RecipientFilter()
				filter:AddPVS(self:GetPos())
				if filter:GetCount() > 0 then
					util.Effect("nz_powerup_poof", fx, true, filter)
				end
			end
		end
	end
end
