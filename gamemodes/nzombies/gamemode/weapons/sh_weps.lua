local wepMeta = FindMetaTable("Weapon")

function nzWeps:GetReplacement(class) -- The weapon that the one provided turns into when PaP'd
	local selectedWep = weapons.Get(class)
	local replacement = ""
	if istable(selectedWep) then
		replacement = selectedWep.NZPaPReplacement
	end

	if (isstring(replacement)) then return weapons.Get(replacement) end
end

function wepMeta:GetReplacement() -- The weapon that the one provided turns into when PaP'd
	return nzWeps:GetReplacement(self:GetClass())
end

function nzWeps:GetAllReplacements(class) -- All weapons that this one can turn into when PaPing
	local replacements = {}
	local newClass = nzWeps:GetReplacement(class)
	
	for i = 1, 100 do -- While loop not needed, but feel free to turn this into one
		if !istable(newClass) then break end
		local shouldStop = false
		for _,v in pairs(replacements) do
			if (v.ClassName == newClass.ClassName) then
				shouldStop = true
				break
			end
		end

		if (shouldStop) then break end -- Could stop repeating the same values over and over if both weapons reference eachother as replacements
		table.insert(replacements, newClass)
		newClass = nzWeps:GetReplacement(newClass.ClassName)
	end

	return replacements
end

function wepMeta:GetAllReplacements() -- All weapons that this one can turn into when PaPing
	return nzWeps:GetAllReplacements(self:GetClass())
end

function nzWeps:GetReplaceChild(class) -- What this weapon was before it was turned into another weapon via PaPing
	local replacedBy = nil
	for _,v in pairs(weapons.GetList()) do
		if (isstring(v.NZPaPReplacement)) then
			if (v.NZPaPReplacement == class) then
				replacedBy = v
			end
		end
	end

	return replacedBy
end

function wepMeta:GetReplaceChild() -- What this weapon was before it was turned into another weapon via PaPing
	return nzWeps:ReplacedBy(self:GetClass())
end

function wepMeta:NZPerkSpecialTreatment( )
	if self:IsFAS2() or self:IsCW2() or self.IsTFAWeapon then
		return true
	end

	return false
end

function wepMeta:IsFAS2()
	return self.IsFAS2Weapon
end

function wepMeta:IsCW2()
	return self.CW20Weapon
end

function wepMeta:IsTFA()
	return self.IsTFAWeapon
end

function wepMeta:IsArc()
	if self.Base == "arccw_base" then
		return true
	else
		local base = weapons.Get(self.Base)
		if base and base.Base == "arccw_base" then
			return true
		end
	end

	return false
end

function wepMeta:CanRerollPaP()
	return (self.OnRePaP or (self.Attachments and ((self:IsCW2() and CustomizableWeaponry) or self.IsTFAWeapon) or self:IsFAS2()))
end

local old = wepMeta.GetPrintName
function wepMeta:GetPrintName()
	local name = old(self)
	if !name or name == "" then name = self:GetClass() end
	if self:HasNZModifier("pap") then
		name = self.NZPaPName or nz.Display_PaPNames[self:GetClass()] or nz.Display_PaPNames[name] or "Upgraded "..name
	end
	return name
end

local illegalspecials = {
	["specialweapon"] = true, //would do nothing
	["grenade"] = true, //would do nothing
	["knife"] = true,
	["display"] = true,
}

local old_setclip1 = wepMeta.SetClip1
function wepMeta:SetClip1(amount, ...)
	if self.NZSpeedRegenerating then
		return old_setclip1(self, amount, ...)
	end
	if nzPowerUps:IsPowerupActive("infinite") and (self.IsTFAWeapon or self.NZInfiniteSafe) and (!self.NZSpecialWeapon or illegalspecials[self.NZSpecialWeapon]) then
		if amount >= self:Clip1() then
			return old_setclip1(self, amount, ...)
		end
		return self:Clip1()
	end

	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and self.IsTFAWeapon then
		if ply:HasUpgrade("banana") and ply:GetNW2Int("nz.BananaCount", 0) > 0 and ply:GetSliding() and !self.NZSpecialWeapon then
			if amount >= self:Clip1() then
				return old_setclip1(self, amount, ...)
			end
			return self:Clip1()
		end

		local gum = nzGum:GetActiveGum(ply)

		if gum and gum == "stock_option" then
			local ammostring = self:GetStatL("Primary.Ammo")

			if ply:IsPlayer() and self:Ammo1() > 0 and self:GetPrimaryAmmoType() > 0 and (ammostring ~= ("none" or "")) and amount < self.Primary_TFA.ClipSize then
				local new = math.max(self:Clip1() - amount, 0)

				ply:RemoveAmmo(new, self:GetPrimaryAmmoType())
				return amount
			else
				return old_setclip1(self, amount, ...)
			end
		else
			return old_setclip1(self, amount, ...)
		end
	else
		return old_setclip1(self, amount, ...)
	end
end

local old_setclip2 = wepMeta.SetClip2
function wepMeta:SetClip2(amount, ...)
	if self.NZSpeedRegenerating then
		return old_setclip2(self, amount, ...)
	end
	if nzPowerUps:IsPowerupActive("infinite") and (self.IsTFAWeapon or self.NZInfiniteSafe) and (!self.NZSpecialWeapon or illegalspecials[self.NZSpecialWeapon]) then
		if amount >= self:Clip2() then
			return old_setclip2(self, amount, ...)
		end
		return self:Clip2()
	end

	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and self.IsTFAWeapon then
		if ply:HasUpgrade("banana") and ply:GetNW2Int("nz.BananaCount", 0) > 0 and ply:GetSliding() and !self.NZSpecialWeapon then
			if amount >= self:Clip2() then
				return old_setclip2(self, amount, ...)
			end
			return self:Clip2()
		end

		local gum = nzGum:GetActiveGum(ply)

		if gum and gum == "stock_option" then
			local ammotype = self.Akimbo and self:GetPrimaryAmmoType() or self:GetSecondaryAmmoType()
			local ammo = self.Akimbo and self:Ammo1() or self:Ammo2()
			local ammostring = self.Akimbo and self:GetStatL("Primary.Ammo") or self:GetStatL("Secondary.Ammo")

			if ply:IsPlayer() and ammo > 0 and ammotype > 0 and (ammostring ~= ("none" or "")) and amount < self.Secondary_TFA.ClipSize then
				local new = math.max(self:Clip2() - amount, 0)

				ply:RemoveAmmo(new, ammotype)
				return amount
			else
				return old_setclip2(self, amount, ...)
			end
		else
			return old_setclip2(self, amount, ...)
		end
	else
		return old_setclip2(self, amount, ...)
	end
end
