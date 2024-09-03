if GetConVar("nz_pap_muzzleflash_size") == nil then
	CreateClientConVar("nz_pap_muzzleflash_size", 1, true, false, "Sets the size of the upgraded muzzleflash for weapons that use 'muz_pap' as the muzzleflash effect.", 0, 3)
end

if GetConVar("nz_pap_muzzleflash_dlight") == nil then
	CreateClientConVar("nz_pap_muzzleflash_dlight", 1, true, false, "Enable or disable the dynamic light for the 'muz_pap' muzzleflash effect. (0 Disabled, 1 Enabled)", 0, 1)
end

if GetConVar("nz_pap_muzzleflash_dlight_brightness") == nil then
	CreateClientConVar("nz_pap_muzzleflash_dlight_brightness", 1, true, false, "Sets the brightness of the dynamic light for the 'muz_pap' muzzleflash effect. (Default is 2, Float)", 0.5, 5)
end

if GetConVar("nz_pap_muzzleflash_dlight_size") == nil then
	CreateClientConVar("nz_pap_muzzleflash_dlight_size", 144, true, false, "Sets the radius, in hammer units, of the dynamic light for the 'muz_pap' muzzleflash effect. (Default is 256, Integer)", 1, 1024)
end

local nz_flashsize = GetConVar("nz_pap_muzzleflash_size")
local nz_flashdlight = GetConVar("nz_pap_muzzleflash_dlight")
local nz_flashdlightlevel = GetConVar("nz_pap_muzzleflash_dlight_brightness")
local nz_flashdlightsize = GetConVar("nz_pap_muzzleflash_dlight_size")

local type_radius_mods = { //bonus dlight size for certain weapon types
	["Carbine"] = 20,
	["Rifle"] = 60,
	["Revolver"] = 90,
	["Dual Revolvers"] = 90,
	["Designated Marksman Rifle"] = 100,
	["Light Machine Gun"] = 120,
	["Shotgun"] = 180,
	["Sniper Rifle"] = 200,
}

function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	if not IsValid(self.WeaponEnt) then return end

	self.WeaponEntOG = self.WeaponEnt
	self.Attachment = data:GetAttachment()
	self.Position = self:GetTracerShootPos(data:GetOrigin(), self.WeaponEnt, self.Attachment)

	//decrease dietime based on rpm, min of 0.05s at 600rpm, max of 0.2s at 60rpm
	self.Life = 0.05
	if self.WeaponEnt.IsTFAWeapon then
		self.Life = 0.2 - math.Clamp((self.WeaponEnt:GetStatL("Primary.RPM")/60) / (1/engine.TickInterval()), 0, 0.15)
	end

	self.DieTime = CurTime() + self.Life

	self.OwnerEnt = self.WeaponEnt:GetOwner()
	if not IsValid(self.OwnerEnt) then
		self.OwnerEnt = self.WeaponEnt:GetParent()
	end

	local colorvec1 = nzMapping.Settings.papmuzzlecol[1]
	local colorvec2 = nzMapping.Settings.papmuzzlecol[2]
	local colorvec3 = nzMapping.Settings.papmuzzlecol[3]
	local colorvec4 = nzMapping.Settings.papmuzzlecol[4]
	local colorvec5 = nzMapping.Settings.papmuzzlecol[5]

	if IsValid(self.OwnerEnt) then
		self.Dist = self.Position:Distance(self.OwnerEnt:EyePos())

		if nz_flashdlight:GetBool() then
			self.DLight = DynamicLight(self.OwnerEnt:EntIndex(), false)
			if (self.DLight) then
				local cointoss = nzMapping.Settings.papmuzzlecol[math.random(5)]

				//increase intensity based on damage
				local glowlevel = nz_flashdlightlevel:GetFloat()
				if self.WeaponEnt.IsTFAWeapon then
					glowlevel = glowlevel + (math.sqrt(self.WeaponEnt:GetStatL("Primary.Damage")/150) * self.WeaponEnt:AmmoRangeMultiplier())
				end

				//increase light radius based on weapon type
				local radius = nz_flashdlightsize:GetInt()
				if self.WeaponEnt.IsTFAWeapon and type_radius_mods[self.WeaponEnt:GetType()] then
					radius = radius + type_radius_mods[self.WeaponEnt:GetType()]
				end

				self.DLight.pos = self.Position + self.OwnerEnt:EyeAngles():Forward() * self.Dist
				self.DLight.r = cointoss[1]*255
				self.DLight.g = cointoss[2]*255
				self.DLight.b = cointoss[3]*255
				self.DLight.brightness = math.min(glowlevel, 5)
				self.DLight.Decay = 3000
				self.DLight.Size = math.min(radius, 1024)
				self.DLight.DieTime = CurTime() + self.Life
			end
		end

		if self.OwnerEnt == LocalPlayer() and !self.OwnerEnt:ShouldDrawLocalPlayer() then
			self.WeaponEnt = self.OwnerEnt:GetViewModel()
		end
	end

	local mflash = CreateParticleSystem(self.WeaponEnt, (self.WeaponEntOG:IsCarriedByLocalPlayer() and !LocalPlayer():ShouldDrawLocalPlayer()) and "nz_pap_muzzleflash" or "nz_pap_muzzleflash_3p", PATTACH_POINT_FOLLOW, self.Attachment)
	if mflash and IsValid(mflash) then
		local flashsize = nz_flashsize:GetFloat()
		mflash:SetControlPoint(1, Vector(flashsize, flashsize, flashsize))
		mflash:SetControlPoint(2, colorvec1)
		mflash:SetControlPoint(3, colorvec2)
		mflash:SetControlPoint(4, colorvec3)
		mflash:SetControlPoint(5, colorvec4)
		mflash:SetControlPoint(6, colorvec5)
	end
end

function EFFECT:Think()
	if CurTime() > self.DieTime then
		return false
	elseif self.DLight and IsValid(self.OwnerEnt) then
		self.DLight.pos = self.OwnerEnt:EyePos() + self.OwnerEnt:EyeAngles():Forward() * self.Dist
	end

	return true
end

function EFFECT:Render()
end
