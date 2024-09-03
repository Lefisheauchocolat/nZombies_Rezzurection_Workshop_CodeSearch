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
	nzPerks.VultureDropsTable[self:GetDropType()].draw(self)
end

function ENT:Initialize()
	if SERVER then
		SafeRemoveEntityDelayed(self, 60)
		if self:GetDropType() == "" then
			local chances = {}
			for id, data in pairs(nzPerks.VultureDropsTable) do
				chances[id] = data.chance
			end
			self:SetDropType(nzMisc.WeightedRandom(chances))
		end
	end

	local vulturedata = nzPerks.VultureDropsTable[self:GetDropType()]

	self:SetModel(vulturedata.model)
	self:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")

	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:UseTriggerBounds(true, 8)

	self:SetBlinkTime(CurTime() + vulturedata.timer - 5)
	self:SetKillTime(CurTime() + vulturedata.timer)
	self:SetBlinking(false)
	self.NextDraw = CurTime()

	vulturedata.initialize(self)

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
	local fuck = false
	for _, ply in pairs(player.GetAll()) do
		if ply:HasUpgrade("vulture") then
			fuck = true
			break
		end
	end

	if IsValid(ent) and ent:IsPlayer() and (ent:HasPerk("vulture") or fuck) then
		if nzPerks.VultureDropsTable[self:GetDropType()].effect(ent) then
			self:Remove()
		end
	end
end

function ENT:Touch(ent)
	local fuck = false
	for _, ply in pairs(player.GetAll()) do
		if ply:HasUpgrade("vulture") then
			fuck = true
			break
		end
	end

	if IsValid(ent) and ent:IsPlayer() then
		if self:GetDropType() == "gas" and (ent:HasPerk("vulture") or fuck) then
			nzPerks.VultureDropsTable[self:GetDropType()].effect(ent)
		end
	end
end

function ENT:Think()
	if not self:GetBlinking() and self:GetBlinkTime() < CurTime() and nzPerks.VultureDropsTable[self:GetDropType()].blink then
		self:SetBlinking(true)
	end

	if self:GetBlinking() and self.NextDraw < CurTime() then
		local time = self:GetKillTime() - self:GetBlinkTime()
		local final = math.Clamp(self:GetKillTime() - CurTime(), 0.1, 1)
		final = math.Clamp(final / time, 0.1, 1)

		self:SetNoDraw(not self:GetNoDraw())
		self.NextDraw = CurTime() + math.Clamp(1 * final, 0.1, 1)
	end

	if nzPerks.VultureDropsTable[self:GetDropType()].think then
		nzPerks.VultureDropsTable[self:GetDropType()].think(self)
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

		if nzPerks.VultureDropsTable[self:GetDropType()].onremove then
			nzPerks.VultureDropsTable[self:GetDropType()].onremove(self)
		end

		if SERVER then
			nzPowerUps:PowerupHudRemove(self)

			if nzPerks.VultureDropsTable[self:GetDropType()].poof then
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
