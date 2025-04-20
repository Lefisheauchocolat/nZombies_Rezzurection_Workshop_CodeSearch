-- Main Tables
nzJumps = nzJumps or AddNZModule("Launch")

nzJumps.LandingPadsCache = nzJumps.LandingPadsCache or {}

function nzJumps:GetLandingPadByFlag(id)
	if not id then return end
	for k, v in RandomPairs(nzJumps.LandingPadsCache) do
		if IsValid(v) and v.GetFlag and v:GetFlag() == id then
			return v
		end
	end
	return false
end

hook.Add("OnEntityCreated", "nzJumps.Iterator", function(ent)
	local class = ent:GetClass()

	if class == "nz_landingpad" then
		table.insert(nzJumps.LandingPadsCache, ent)
	end
end)

hook.Add("EntityRemoved", "nzJumps.Iterator", function(ent)
	local class = ent:GetClass()

	if class == "nz_landingpad" then
		for i = 1, #nzJumps.LandingPadsCache do
			if nzJumps.LandingPadsCache[i] == ent then
				table.remove(nzJumps.LandingPadsCache, i)
				break
			end
		end
	end
end)

//credit to PrikolMen for projectile-flight 3077166853
if SERVER then
	hook.Add("Move", "nzJumps.Move", function(ply, mv)
		local ent = ply:GetNZLauncher()
		if not IsValid(ent) then return end

		if ent:GetMoveType() == MOVETYPE_NONE then
			ply:SetNZLauncher(nil)
			return
		end

		local velocity = ent:GetVelocity()

		if not ply:Alive() or ply:GetMoveType() ~= MOVETYPE_WALK then
			mv:SetVelocity(velocity)
			ply:SetNZLauncher(nil)
			return
		end

		local halfTickInterval = engine.TickInterval() * 0.5
		velocity = velocity * halfTickInterval

		local mins, maxs = ply:GetCollisionBounds()
		mins[3] = maxs[3]/2

		local start = ent:WorldSpaceCenter()
		if util.TraceHull({start = start, endpos = start - velocity, filter = {ply, ent}, mins = mins, maxs = maxs}).HitWorld then
			ply:Fire("ignorefalldamage","",0)
			ply:SetNZLauncher(nil)
			return
		end

		mv:SetOrigin(start)
		mv:SetVelocity(velocity - math.max(1, ply:GetGravity()) * physenv.GetGravity() * halfTickInterval)
	end)
end

hook.Add("StartCommand", "nzJumps.Command", function(ply, cmd)
	local ent = ply:GetNZLauncher()
	if not IsValid(ent) then return end
	if not ply:IsOnGround() then
		cmd:RemoveKey(IN_SPEED)
		cmd:RemoveKey(IN_JUMP)
		cmd:RemoveKey(IN_DUCK)
		cmd:ClearMovement()
	end
end)
