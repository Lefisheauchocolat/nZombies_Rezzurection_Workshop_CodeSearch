
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
ENT.Base = "base_nextbot"
ENT.Spawnable = false

local sp = game.SinglePlayer()
local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "NextScream")
	self:NetworkVar("Bool", 0, "Upgraded")

	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

function ENT:Initialize()
	self:SetModel("models/weapons/tfa_bo3/vr11/vr11_human.mdl")
	self:SetCollisionBounds(Vector(-16, -16, 0), Vector(16, 16, 72))
	self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	self:SetSolid(SOLID_BBOX)
	self:UseTriggerBounds(true)
	self:SetHealth(1000)

	ParticleEffectAttach(self:GetUpgraded() and "bo3_vr11_zomb_smoke_2" or "bo3_vr11_zomb_smoke", PATTACH_ABSORIGIN_FOLLOW, self, 0)

	if SERVER and nzombies then
		self:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		UpdateAllZombieTargets(self)
	end

	self:SetNextScream(CurTime())

	if SERVER then
		self:SetMaxHealth(1000)
		self.loco:SetStepHeight(35)
		self.loco:SetAcceleration(900)
		self.loco:SetDeceleration(900)
		self:SetSolidMask(MASK_NPCSOLID_BRUSHONLY)
		self.Anim = false
	end
end

function ENT:Think()
	if CurTime() > self:GetNextScream() then
		self:MonkeyBomb()
		self:EmitSound("TFA_BO3_VR11.NBot.Scream")
		self:SetNextScream(CurTime() + math.Rand(2,4))
	end

	if SERVER then
		if self:WaterLevel() >= 2 then
			self:TakeDamage(self:Health() + 666)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:MonkeyBomb()
	if CLIENT then return end
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 2048)) do
		if v == self:GetOwner() then continue end
		if IsValid(v) and v:IsNPC() then
			if v:GetEnemy() ~= self then
				v:ClearSchedule()
				v:ClearEnemyMemory(v:GetEnemy())

				v:SetEnemy(self)
			end

			v:UpdateEnemyMemory(self, self:GetPos())
			v:SetSaveValue("m_vecLastPosition", self:GetPos())
			v:SetSchedule(SCHED_FORCED_GO_RUN)
		end
	end
end

local function GetClearPaths(ent, pos, tiles)
	local clearPaths = {}
	local filter = player.GetAll()
	for _, tile in pairs( tiles ) do
		local tr = util.TraceLine({
			start = pos,
			endpos = tile,
			filter = filter,
			mask = MASK_PLAYERSOLID
		})
		
		if not tr.Hit and util.IsInWorld(tile) then
			table.insert( clearPaths, tile )
		end
	end
	
	return clearPaths
end

local function GetSurroundingTiles(ent, pos)
	local tiles = {}
	local x, y, z
	local minBound, maxBound = ent:OBBMins(), ent:OBBMaxs()
	local checkRange = math.max(12, maxBound.x, maxBound.y)
	
	for z = -1, 1, 1 do
		for y = -1, 1, 1 do
			for x = -1, 1, 1 do
				local testTile = Vector(x,y,z)
				testTile:Mul( checkRange )
				local tilePos = pos + testTile
				table.insert( tiles, tilePos )
			end
		end
	end
	
	return tiles
end

local function CollisionBoxClear(ent, pos, minBound, maxBound)
	local filter = {ent}
	local tr = util.TraceEntity({
		start = pos,
		endpos = pos,
		filter = filter,
		mask = MASK_PLAYERSOLID
	}, ent)

	return !tr.StartSolid || !tr.AllSolid
end

function ENT:FindFreeSpot(pos, range, stepd, stepu)
	pos = pos or self:GetPos()
	range = range or 5000
	stepd = stepd or 35
	stepu = stepu or 35

	if navmesh.IsLoaded() then
		local tab = navmesh.Find(pos, range, stepd, stepu)
		for _, nav in RandomPairs(tab) do
			if IsValid(nav) and not nav:IsUnderwater() then
				pos = nav:GetRandomPoint()
				break
			end
		end
	end

	local minBound, maxBound = self:OBBMins(), self:OBBMaxs()
	if not CollisionBoxClear( self, pos, minBound, maxBound ) then

		local surroundingTiles = GetSurroundingTiles( self, pos )
		local clearPaths = GetClearPaths( self, pos, surroundingTiles )	
		for _, tile in pairs( clearPaths ) do
			if CollisionBoxClear( self, tile, minBound, maxBound ) then
				pos = tile
				break
			end
		end
	end

	return pos
end

function ENT:RunBehaviour()
	while (true) do
		self:PlaySequenceAndWait("react")
		self.loco:SetDesiredSpeed(200)

		self:EmitSoundNet("TFA_BO3_VR11.Effect.Timer")

		self:StartActivity(ACT_RUN)
		self:MoveToPos(self:FindFreeSpot(self:GetPos(), 5000, 35, 35), {maxage = 5})

		self:EmitSoundNet("TFA_BO3_ANNIHILATOR.Lfe")

		self:PlaySequenceAndWait("react")
		self.loco:SetDesiredSpeed(0)

		SafeRemoveEntity(self)
	end
end

function ENT:EyePos()
	return self:GetAttachment(1).Pos
end

function ENT:GetShootPos()
	return self:GetAttachment(1).Pos
end

function ENT:EmitSoundNet(sound)
	if CLIENT or sp then
		if sp and not IsFirstTimePredicted() then return end
		self:EmitSound(sound)
		return
	end

	local filter = RecipientFilter()
	filter:AddPAS(self:GetPos())

	net.Start("tfaSoundEvent", true)
		net.WriteEntity(self)
		net.WriteString(sound)
	net.Send(filter)
end

function ENT:OnRemove()
	self:StopSound("TFA_BO3_VR11.NBot.Scream")
	self:StopSound("TFA_BO3_VR11.Effect.Timer")

	if game.SinglePlayer() and !IsFirstTimePredicted() then return end

	if self:GetUpgraded() then
		self:EmitSound("TFA_BO3_SCAVENGER.ExplodePAP")
	else
		self:EmitSound("TFA_BO3_VR11.Effect.Explode")
	end
	self:EmitSound("TFA_BO3_GRENADE.Flux")
	self:EmitSound("TFA_BO3_ANNIHILATOR.Gib")
	self:EmitSound("TFA_BO3_ANNIHILATOR.Exp")

	ParticleEffect(self:GetUpgraded() and "bo3_scavenger_explosion_2" or "bo3_annihilator_blood", self:WorldSpaceCenter(), Angle(0,0,0))
	if SERVER then
		util.ScreenShake(self:GetPos(), 255, 6, 1.5, 450)
		self:Explode()
	end
end

function ENT:OnTakeDamage(dmginfo)
	if dmginfo:GetDamage() < self:GetMaxHealth() then
		dmginfo:SetDamage(0)
		dmginfo:ScaleDamage(0)
		return true
	end
end
