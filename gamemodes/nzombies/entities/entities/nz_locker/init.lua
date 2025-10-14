AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetTrigger(true)
	//self:SetUseType(SIMPLE_USE)
	self:SetUsed(false)
end

function ENT:StartTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	if nzRound:InState(ROUND_CREATE) then
		if ply:KeyDown(IN_SPEED) then return end
		if self.NextUse and self.NextUse > CurTime() then return end
		self.NextUse = CurTime() + 1

		if self:GetLockerClass() ~= "" then
			local failed = self:TestLock(ply)
			if failed then return end
		end

		if self.DoCustomEffects then
			self:DoFX()
		end
		return
	end

	if self:GetUsed() then return end
	if not nzLocker.HasKey then
		ply:Buy(math.huge, self, function() end)
		return
	end
	if (nzLocker.HasKey ~= "" or self:GetFlag() ~= "") and nzLocker.HasKey ~= self:GetFlag() then
		ply:Buy(math.huge, self, function() end)
		return
	end

	if not ply:CanAfford(self:GetPrice()) then return end

	local time = self:GetTime()
	local price = self:GetPrice()
	if time > 0 then
		ply:Give("tfa_paparms")
		return time
	else
		if price > 0 then
			ply:Buy(self:GetPrice(), self, function() self:Unlock() return true end)
		else
			self:Unlock()
		end
	end
end

function ENT:StopTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	ply:SetUsingSpecialWeapon(false)
	ply:EquipPreviousWeapon()
	ply:StripWeapon("tfa_paparms")
end

function ENT:FinishTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	local price = self:GetPrice()
	if price > 0 then
		ply:Buy(self:GetPrice(), self, function() self:Unlock() return true end)
	else
		self:Unlock()
	end
end

function ENT:Unlock()
	self:Trigger()

	if self.DoCustomEffects then
		self:DoFX()
	end

	local flag = self:GetDoorFlag()
	if flag ~= "" then
		nzDoors:OpenLinkedDoors(flag)
	end

	local ent = self.LockedEnt
	if IsValid(ent) then
		local locks = ent.LockerLocks
		if locks and istable(locks) and not table.IsEmpty(locks) then
			local last = true
			for k, v in RandomPairs(locks) do
				if v:EntIndex() ~= self:EntIndex() then
					last = false
					ent.RelayUse = v
					table.RemoveByValue(ent.LockerLocks, self)
					break
				end
			end
			if last then
				ent.RelayUse = nil
			end
		else
			ent.RelayUse = nil
		end
	end

	if nzLocker.KeyConsume then
		nzLocker:UseKey()
	end
end

function ENT:DoFX()
	local msg3 = "Entity("..self:EntIndex().."):PopOff()"
	for k, v in ipairs(player.GetAll()) do
		if v:TestPVS(self) then
			v:SendLua(msg3)
		end
	end

	self:EmitSound(self.ActivateSound, SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
end

function ENT:TestLock(ply)
	if not IsValid(ply) then return end
	if self:GetLockerClass() == "" then return end
	local mins, maxs = self:GetCollisionBounds()
	mins = self:LocalToWorld(mins*1.1)
	maxs = self:LocalToWorld(maxs*1.1)

	local failed = true
	for _, ent in pairs(ents.FindInBox(mins, maxs)) do
		if ent:GetClass() == self:GetLockerClass() then
			failed = false
			break
		end
	end

	if failed then
		ply:ChatPrint('Lock is too far away from '..self:GetLockerClass())
	else
		ply:ChatPrint('Lock is within range of '..self:GetLockerClass())
	end

	return failed
end

function ENT:LockerLock()
	if self:GetLockerClass() == "" then return end
	local mins, maxs = self:GetCollisionBounds()
	mins = self:LocalToWorld(mins*1.1)
	maxs = self:LocalToWorld(maxs*1.1)

	for _, ent in pairs(ents.FindInBox(mins, maxs)) do
		if ent:GetClass() == self:GetLockerClass() then
			ent.RelayUse = self
			if not ent.LockerLocks then ent.LockerLocks = {} end
			table.insert(ent.LockerLocks, self)
			self.LockedEnt = ent
			break
		end
	end
end

function ENT:Reset()
	self:SetUsed(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	self:SetTrigger(true)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	if self:GetLockerClass() ~= "" then
		local ent = self.LockedEnt
		if IsValid(ent) then
			ent.LockerLocks = nil
			ent.RelayUse = nil
		end
		self.LockedEnt = nil
	end
end

function ENT:Trigger()
	self:SetUsed(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	self:SetTrigger(false)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
end
