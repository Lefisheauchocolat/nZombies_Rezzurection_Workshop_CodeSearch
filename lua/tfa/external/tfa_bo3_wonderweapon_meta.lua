local PLAYER = FindMetaTable("Player")

if PLAYER then
	function PLAYER:GetEyeWorldTrace()
		local weap = self:GetActiveWeapon()
		if not IsValid(weap) then
			weap = self
		end

		local trace = util.TraceLine({
			start = self:GetShootPos(),
			endpos = self:GetShootPos() + (weap:GetAimVector() * 0x7fff),
			filter = self,
			mask = MASK_SOLID_BRUSHONLY,
		})

		return trace
	end
end
