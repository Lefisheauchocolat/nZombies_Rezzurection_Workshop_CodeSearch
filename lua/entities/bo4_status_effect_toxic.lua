
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
ENT.Type = "anim"
ENT.PrintName = "Toxic Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local entMeta = FindMetaTable("Entity")
local nzombies = engine.ActiveGamemode() == "nzombies"

if SERVER then
	entMeta.BO4Toxic = function(self, duration, attacker, inflictor)
		if nzombies and self.IsAATTurned and self:IsAATTurned() then return end
		if nzombies and string.find(self:GetClass(), "nz_zombie_boss") then return end

		if duration == nil then
			duration = 0
		end
		if attacker == nil then
			attacker = self
		end
		if inflictor == nil then
			inflictor = self
		end

		if IsValid(self.bo4_toxicslow_logic) then
			self.bo4_toxicslow_logic:UpdateDuration(duration)
			return self.bo4_toxicslow_logic
		end

		self.bo4_toxicslow_logic = ents.Create("bo4_status_effect_toxic")
		self.bo4_toxicslow_logic:SetPos(self:WorldSpaceCenter())
		self.bo4_toxicslow_logic:SetParent(self)
		self.bo4_toxicslow_logic:SetOwner(self)

		self.bo4_toxicslow_logic:SetAttacker(attacker)
		self.bo4_toxicslow_logic:SetInflictor(inflictor)

		self.bo4_toxicslow_logic:Spawn()
		self.bo4_toxicslow_logic:Activate()

		self.bo4_toxicslow_logic:SetOwner(self)
		self.bo4_toxicslow_logic:UpdateDuration(duration)
		self:SetNW2Entity("BO4.ToxicLogic", self.bo4_toxicslow_logic)
		return self.bo4_toxicslow_logic
	end

	hook.Add("OnNPCKilled", "BO4.ToxicLogic", function(self)
		if IsValid(self.bo4_toxicslow_logic) then
			return self.bo4_toxicslow_logic:Remove()
		end
	end)
end

entMeta.BO4IsToxic = function(self)
	return IsValid(self:GetNW2Entity("BO4.ToxicLogic"))
end

ENT.SetupDataTables = function(self)
	self:NetworkVar("Entity", 0, "Attacker")
	self:NetworkVar("Entity", 1, "Inflictor")
end

ENT.Draw = function(self)
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	if CLIENT then return end

	local p = self:GetParent()
	if IsValid(p) and nzombies and p:IsValidZombie() then
		p:StartActivity(ACT_WALK)
		p.loco:SetAcceleration(45)
		p.loco:SetDesiredSpeed(45)
	end

	self.statusStart = CurTime()
	self.duration = 1
	self.statusEnd = self.statusStart + 1
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end
	self.duration = newtime
	self.statusEnd = CurTime() + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	local p = self:GetParent()
	if IsValid(p) and IsValid(self:GetAttacker()) then
		if p:IsNPC() then
			self:StupidNPC(p)
		end

		ParticleEffect("bo4_alistairs_toxic_zomb", p:EyePos(), angle_zero, p)
	end

	if self.statusEnd < CurTime() then
		if IsValid(p) then
			self:InflictDamage(p)
		end
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.InflictDamage = function(self, ent)
	local damage = DamageInfo()
	damage:SetDamageType(DMG_ALWAYSGIB)
	damage:SetAttacker(IsValid(self:GetAttacker()) and self:GetAttacker() or self)
	damage:SetInflictor(IsValid(self:GetInflictor()) and self:GetInflictor() or self)
	damage:SetDamagePosition(ent:EyePos())
	damage:SetDamageForce(vector_up)
	damage:SetDamage(ent:Health() + 666)

	local head = ent:LookupBone("ValveBiped.Bip01_Head1")
	if !head then head = ent:LookupBone("j_head") end
	if head then
		damage:SetDamagePosition(ent:GetBonePosition(head))
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:EmitSound("TFA_BO4_ALISTAIR.HeadPop")
	ent:TakeDamageInfo(damage)
end

ENT.OnRemove = function(self)
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

function ENT:FindFreeSpot(ent)
	local pos = self:GetPos()

	if navmesh.IsLoaded() then
		local tab = navmesh.Find(self:GetPos(), 10000, 10000, 10000)
		for _, nav in RandomPairs(tab) do
			if IsValid(nav) and not nav:IsUnderwater() then
				pos = nav:GetRandomPoint()
				break
			end
		end
	end

	local minBound, maxBound = ent:OBBMins(), ent:OBBMaxs()
	if not CollisionBoxClear( ent, pos, minBound, maxBound ) then

		local surroundingTiles = GetSurroundingTiles( ent, pos )
		local clearPaths = GetClearPaths( ent, pos, surroundingTiles )	
		for _, tile in pairs( clearPaths ) do
			if CollisionBoxClear( ent, tile, minBound, maxBound ) then
				pos = tile
				break
			end
		end
	end

	return pos
end

function ENT:StupidNPC(ent)
	if CLIENT then return end

	if IsValid(ent) and ent:IsNPC() then
		if ent:GetEnemy() ~= self:GetAttacker() then
			ent:ClearSchedule()
			ent:ClearEnemyMemory(ent:GetEnemy())

			ent:SetEnemy(self:GetAttacker())

			local pos = self:FindFreeSpot(ent)
			ent:UpdateEnemyMemory(self:GetAttacker(), pos)
			ent:SetSaveValue("m_vecLastPosition", pos)
		end

		ent:SetSchedule(SCHED_FORCED_GO_RUN)
	end
end
