local PLAYER = FindMetaTable("Player")
if PLAYER then
	if SERVER then
		--Below function credited to CmdrMatthew
		local function getvel(pos, pos2, time) -- target, starting point, time to get there
			local diff = pos - pos2 --subtract the vectors

			local velx = diff.x/time -- x velocity
			local vely = diff.y/time -- y velocity

			local velz = (diff.z - 0.5*(-GetConVarNumber( "sv_gravity"))*(time^2))/time -- x = x0 + vt + 0.5at^2 conversion

			return Vector(velx, vely, velz)
		end

		function PLAYER:NZLaunch(time, pos, flag)
			if not time then return end
			if not pos or not isvector(pos) then return end
			if not flag then flag = 0 end

			time = math.max(tonumber(time), 0.1)

			local ent = ents.Create("nz_playerlauncher")
			ent:SetPos(self:GetPos() + vector_up)
			ent:SetAngles(Angle(0,0,0))
			ent:SetOwner(self)
			ent.Delay = time

			ent:Spawn()

			self:SetNZLauncher(ent)
			ent:SetLocalVelocity(getvel(pos, self:GetPos(), time))

			hook.Call("PlayerJumpPadLaunched", nzJumps, self, ent, pos, flag)
		end
	end

	function PLAYER:GetNZLauncher()
		return self:GetNW2Entity("nzlauncher", nil)
	end

	function PLAYER:SetNZLauncher(ent)
		return self:SetNW2Entity("nzlauncher", ent)
	end
end
