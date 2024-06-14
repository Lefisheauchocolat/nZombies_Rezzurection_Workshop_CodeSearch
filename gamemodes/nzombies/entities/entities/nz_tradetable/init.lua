AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/zmb/bo2/tranzit/zm_work_bench.mdl")
	end

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)
end

function ENT:GivePlayerWeapon(ply)
	local wep1 = self:GetWeapon()
	if not IsValid(wep1) then return end

	local slot, exists = GetPriorityWeaponSlot(ply)
	wep1:SetNWInt("SwitchSlot", slot)

	local newammo = wep1:GetPrimaryAmmoType()
	wep1.Primary_TFA.Ammo = game.GetAmmoName(newammo)
	wep1:ClearStatCache("Primary.Ammo")

	if IsValid(exists) then
		exists:Holster()
		ply:SetActiveWeapon(nil)
		ply:SelectWeapon(wep1)
	end

	wep1.NZIgnorePickup = false
	wep1:SetParent(nil)
	self:SetWeapon(nil)

	if IsValid(exists) then
		self:SetWeapon(exists)
		self:SetUserIndex(ply:EntIndex())
		exists.NZIgnorePickup = true

		ply:DropWeapon(exists)

		exists.NoSpawnAmmo = true
		exists:SetPos(self:WorldSpaceCenter() + vector_up*(self.WeaponOffset or 24))
		exists:SetAngles(self:GetAngles() + Angle(0,90,0))
		exists:SetParent(self)
	end

	wep1:SetPos(ply:EyePos())
	ply:PickupWeapon(wep1)
	if !IsValid(exists) then
		self:SetUserIndex(0)
	end

	self.NextUse = CurTime() + 0.4
	timer.Simple(0, function()
		if not IsValid(ply) or not IsValid(wep1) then return end
		nzCamos:GenerateCamo(ply, wep1)
	end)
end

function ENT:TakePlayerWeapon(ply)
	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return end

	self:SetWeapon(wep)
	self:SetUserIndex(ply:EntIndex())
	wep.NZIgnorePickup = true

	ply:DropWeapon(wep)

	wep.NoSpawnAmmo = true
	wep:SetPos(self:WorldSpaceCenter() + vector_up*(self.WeaponOffset or 24))
	wep:SetAngles(self:GetAngles() + Angle(0,90,0))
	wep:SetParent(self)

	self.NextUse = CurTime() + 0.4
end

function ENT:Use(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if nzRound:InState(ROUND_CREATE) or ply:IsInCreative() then return end

	if self.NextUse and self.NextUse > CurTime() then return end
	if ply.NextUse and ply.NextUse > CurTime() then return end

	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		if not wep.IsTFAWeapon or (not self:GetAllowWonder() and wep.NZWonderWeapon) or wep:IsSpecial() then
			ply:Buy(math.huge, self, function() end)
			return
		end

		if !TFA.Enum.ReadyStatus[wep:GetStatus()] or wep:GetSprinting() then
			return
		end
	end

	local gun = self:GetWeapon()
	if not IsValid(gun) then
		local fuckinator = true
		for k, v in ipairs(ply:GetWeapons()) do //disease
			if v:GetNWInt("SwitchSlot", 0) > 0 then
				if IsValid(wep) and v:GetClass() == wep:GetClass() then continue end
				fuckinator = false
				break
			end
		end

		if fuckinator then
			ply:Buy(math.huge, self, function() end)
			return
		end

		self:TakePlayerWeapon(ply)
	else
		if ply:EntIndex() ~= self:GetUserIndex() then
			local price = self:GetPrice()
			if price > 0 then
				ply:Buy(price, self, function()
					self:GivePlayerWeapon(ply)
					return true
				end)
			else
				self:GivePlayerWeapon(ply)
			end
		else
			self:GivePlayerWeapon(ply)
		end
	end
end

function ENT:MaxAmmo()
	local wep = self:GetWeapon()
	if IsValid(wep) then
		local maxammo = wep.Primary and wep.Primary.MaxAmmo or wep.MaxAmmo
		local maxammo2 = wep.Secondary and wep.Secondary.MaxAmmo or wep.MaxAmmo2
		if !maxammo or maxammo <= 0 and wep.Primary then
			maxammo = wep.Primary.DefaultClip
		end

		local clip1 = wep.Primary and wep.Primary.ClipSize or 0
		if clip1 and clip1 > 0 then
			wep:SetClip1(clip1)
		end

		local clip2 = wep.Secondary and wep.Secondary.ClipSize or 0
		if clip2 and clip2 > 0 then
			wep:SetClip2(clip2)
		end

		if wep.StoredNZAmmo and maxammo and maxammo > 0 and wep.StoredNZAmmo < maxammo then
			wep.StoredNZAmmo = maxammo
		end
		if wep.StoredNZAmmo2 and maxammo2 and maxammo2 > 0 and wep.StoredNZAmmo2 < maxammo2 then
			wep.StoredNZAmmo2 = maxammo2
		end
	end
end

function ENT:Reset()
	if IsValid(self:GetWeapon()) then
		self:GetWeapon():Remove()
		self:SetWeapon(nil)
	end
end
