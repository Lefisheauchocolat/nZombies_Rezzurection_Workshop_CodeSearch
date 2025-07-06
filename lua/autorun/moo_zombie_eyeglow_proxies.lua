local nzombies = engine.ActiveGamemode() == "nzombies"

if nzombies then
	if matproxy then
	    local color_waterbuff = Color(0, 50, 255, 255)
	    local color_bomberbuff = Color(150, 255, 75, 255)
	    local color_death = Color(255, 0, 0, 255)

	    matproxy.Add({
	        name = "ZombieEyeGlow",
	        init = function(self, mat, values)
	            self.ResultVar1 = values.srcvar1
	            self.ResultVar2 = values.srcvar2
	        end,
	        bind = function(self, mat, ent)
	            if not (IsValid(ent) and ent.IsAlive) then return end

	            local color = (nzMapping and nzMapping.Settings) and nzMapping.Settings.zombieeyecolor or color_white

	            if ent.GetWaterBuff and ent:GetWaterBuff() then
	                color = color_waterbuff
	            end
	            if ent.GetBomberBuff and ent:GetBomberBuff() then
	                color = color_bomberbuff
	            end
	            if ent.GetTripleBuff and ent:GetTripleBuff() then
	                color = color_death
	            end

	            mat:SetVector(self.ResultVar1, color:ToVector())

	            local int = ent:IsAlive() and 1 or 0
	            mat:SetInt(self.ResultVar2, int)
	        end
	    })
	end
end

