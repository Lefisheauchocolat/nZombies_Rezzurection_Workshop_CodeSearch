AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

function ENT:Initialize()
	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

local altsound = true
function ENT:Use(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 0.8

	if self.NextUse and self.NextUse > CurTime() then return end
	self.NextUse = CurTime() + 0.2

	if nzRound:InState(ROUND_CREATE) then
		self.NextUse = CurTime() + 0.8
		if altsound then
			self:EmitSound(self.OpenSound, SNDLVL_TALKING, math.random(97,103), 1, CHAN_WEAPON)
		else
			self:EmitSound(self.CloseSound, SNDLVL_TALKING, math.random(97,103), 1, CHAN_WEAPON)
		end
		altsound = !altsound
		return
	end

	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return end

	if wep.IsTFAWeapon and (!TFA.Enum.ReadyStatus[wep:GetStatus()] or wep:GetSprinting()) then
		return
	end

	if self:GetElectric() and not nzElec:IsOn() then
		return
	end

	local data = nzFridge:PlayerData(ply)
	if data then
		local slot, exists = GetPriorityWeaponSlot(ply)
		if IsValid(exists) then
			local starter = nzMapping.Settings.startwep
			if starter and wep:GetClass() == starter then
				local msg = "Entity("..self:EntIndex().."):BadGun()"
				ply:SendLua(msg)
				ply:Buy(math.huge, self, function() end)
				return
			end

			if (wep.NZWonderWeapon or wep:IsSpecial()) then
				local msg = "Entity("..self:EntIndex().."):BadGun()"
				ply:SendLua(msg)
				ply:Buy(math.huge, self, function() end)
				return
			end

			if self:GetUseBoxList() and nzMapping.Settings.rboxweps and not nzMapping.Settings.rboxweps[wep:GetClass()] then
				local msg = "Entity("..self:EntIndex().."):BadGun()"
				ply:SendLua(msg)
				ply:Buy(math.huge, self, function() end)
				return
			end

			if self.BlacklistWeapons and self.BlacklistWeapons[wep:GetClass()] then
				local msg = "Entity("..self:EntIndex().."):BadGun()"
				ply:SendLua(msg)
				ply:Buy(math.huge, self, function() end)
				return
			end
		end

		if ply:HasWeapon(data.weapon) and wep:GetClass() ~= data.weapon then
			local msg = "Entity("..self:EntIndex().."):BadGun('"..data.weapon.."')"
			ply:SendLua(msg)
			ply:Buy(math.huge, self, function() end)
			return
		end

		local price = self:GetPrice()
		if price > 0 then
			ply:Buy(price, self, function()
				nzFridge:PickupWeapon(ply)
				self:EmitSound(self.OpenSound, SNDLVL_TALKING, math.random(97,103), 1, CHAN_WEAPON)
				return true
			end)
		else
			nzFridge:PickupWeapon(ply)
			self:EmitSound(self.OpenSound, SNDLVL_TALKING, math.random(97,103), 1, CHAN_WEAPON)
		end
	else
		local starter = nzMapping.Settings.startwep
		if starter and wep:GetClass() == starter then
			local msg = "Entity("..self:EntIndex().."):BadGun()"
			ply:SendLua(msg)
			ply:Buy(math.huge, self, function() end)
			return
		end

		if (wep.NZWonderWeapon or wep:IsSpecial()) then
			local msg = "Entity("..self:EntIndex().."):BadGun()"
			ply:SendLua(msg)
			ply:Buy(math.huge, self, function() end)
			return
		end

		if self:GetUseBoxList() and nzMapping.Settings.rboxweps and not nzMapping.Settings.rboxweps[wep:GetClass()] then
			local msg = "Entity("..self:EntIndex().."):BadGun()"
			ply:SendLua(msg)
			ply:Buy(math.huge, self, function() end)
			return
		end

		if self.BlacklistWeapons and self.BlacklistWeapons[wep:GetClass()] then
			local msg = "Entity("..self:EntIndex().."):BadGun()"
			ply:SendLua(msg)
			ply:Buy(math.huge, self, function() end)
			return
		end

		local fuckinator = true
		for k, v in ipairs(ply:GetWeapons()) do //disease
			if v:GetNWInt("SwitchSlot", 0) > 0 then
				if v:GetClass() == wep:GetClass() then continue end
				fuckinator = false
				break
			end
		end

		if fuckinator then
			ply:Buy(math.huge, self, function() end)
			return
		end

		nzFridge:StoreWeapon(ply, wep)
		self:EmitSound(self.CloseSound, SNDLVL_TALKING, math.random(97,103), 1, CHAN_WEAPON)
	end
end
