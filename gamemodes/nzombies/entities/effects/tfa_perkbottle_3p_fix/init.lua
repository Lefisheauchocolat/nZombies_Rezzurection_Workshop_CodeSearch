function EFFECT:Init(data)
	self.WeaponEnt = data:GetEntity()
	self.Skin = data:GetFlags()
	if not IsValid(self.WeaponEnt) then return end

	self.WeaponEnt.Skin = tonumber(self.Skin)

	local owent = self.WeaponEnt:GetOwner()
	if IsValid(owent) and owent == LocalPlayer() and owent:GetActiveWeapon() == self.WeaponEnt and IsValid(owent:GetViewModel()) then
		owent:GetViewModel().Skin = tonumber(self.Skin)
	end

	self.WeaponEnt:ClearStatCache("Skin")
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end