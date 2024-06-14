
function nzRevive.DoPlayerDeath(ply, dmg)
	if IsValid(ply) and ply:IsPlayer() then
		if (math.floor(ply:Health() - dmg:GetDamage()) <= 0) then
			if dmg:GetAttacker():IsValidZombie() and ply:HasPerk("whoswho") and ply:GetNW2Float("nz.ChuggaDelay", 0) < CurTime() then
				nzRevive:ChuggaBudTeleport(ply, true)
				ply:SetNW2Float("nz.ChuggaDelay", CurTime() + 180)
				return true
			end

			local allow = hook.Call("PlayerShouldTakeDamage", nil, ply, dmg:GetAttacker())

			if allow != false then -- Only false should prevent it (not nil)
				if ply:GetNotDowned() then
					ply:DownPlayer()
					return true
				else
					ply:KillDownedPlayer() -- Kill them if they are already downed
				end
			end

			return true
		elseif !ply:GetNotDowned() then
			return true -- Downed players cannot take non-fatal damage
		end
	end
end

function nzRevive.PostPlayerDeath(ply)
	-- Performs all the resetting functions without actually killing the player
	if !ply:GetNotDowned() then ply:KillDownedPlayer(nil, false, true) end
end

local function HandleKillCommand(ply)
	if (ply:IsPlaying() and !ply:IsSpectating()) or (ply:IsInCreative() and ply:Alive()) then
		if ply:GetNotDowned() then
			ply:DownPlayer()
		else
			if ply:GetDownedWithTombstone() then
				local id = ply:EntIndex()
				local data = nzRevive.Players and nzRevive.Players[id]
				if data and data.DownTime and data.DownTime + 2 > CurTime() then
					return false //protection against accidentally fat fingering your kill key one too many times (i do this alot)
				end
			end

			ply:KillDownedPlayer()
		end
	end
	return false
end

-- Hooks
hook.Add("EntityTakeDamage", "nzDownKilledPlayers", nzRevive.DoPlayerDeath)
hook.Add("PostPlayerDeath", "nzPlayerDeathRevivalReset", nzRevive.PostPlayerDeath)
hook.Add("CanPlayerSuicide", "nzSuicideDowning", HandleKillCommand)
