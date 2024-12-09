--Gamemode Overrides

local load_queue = {}
function GM:PlayerInitialSpawn( ply )
	load_queue[ply] = true
end

hook.Add("SetupMove", "nzStartSpectator", function( ply, _, cmd )
	if load_queue[ply] and not cmd:IsForced() then
		load_queue[ply] = nil
		ply:SetSpectator()
	end
end)

function GM:PlayerDeath( ply, wep, killer )
	ply:SetSpectator()
	ply:SetTargetPriority(TARGET_PRIORITY_NONE)
end

function GM:PlayerDeathThink( ply )
	-- Allow players in creative mode to respawn
	if ply:IsInCreative() and nzRound:InState(ROUND_CREATE) then
		if ply:KeyDown(IN_JUMP) or ply:KeyDown(IN_ATTACK) then
			ply:Spawn()
			return true
		end
	end

	local players = player.GetAllPlayingAndAlive()

	if ply:KeyPressed(IN_RELOAD) then
		ply:SetSpectatingType(ply:GetSpectatingType() + 1)
		if ply:GetSpectatingType() > 5 then
			ply:SetSpectatingType(4)
			ply:SetupHands(players[ply:GetSpectatingID()])
		end

		ply:Spectate(ply:GetSpectatingType())
	elseif ply:KeyPressed(IN_ATTACK) then
		ply:SetSpectatingID(ply:GetSpectatingID() + 1)
		if ply:GetSpectatingID() > #players then
			ply:SetSpectatingID(1)
		end

		ply:SpectateEntity(players[ply:GetSpectatingID()])
		ply:SetupHands(players[ply:GetSpectatingID()])
	elseif ply:KeyPressed(IN_ATTACK2) then
		ply:SetSpectatingID(ply:GetSpectatingID() - 1)
		if ply:GetSpectatingID() <= 0 then
			ply:SetSpectatingID(#players)
		end

		ply:SpectateEntity(players[ply:GetSpectatingID()])
		ply:SetupHands(players[ply:GetSpectatingID()])
	end

	//evil
	if ply:KeyPressed(IN_WALK) and IsValid(ply:GetObserverTarget()) and ply:GetObserverTarget() ~= ply and (!ply.NextSpectatorScare or ply.NextSpectatorScare < CurTime()) then
		local s_ent = ply:GetObserverTarget()
		if ply.LastSpectatorUse and ply.LastSpectatorUse + 0.15 > CurTime() then
			local snd = "nz_moo/zombies/vox/_zhd/behind/behind_0"..math.random(0,3)..".mp3"
			if s_ent:IsPlayer() and file.Exists("sound/"..snd, "GAME") then
				local msg = "surface.PlaySound('"..snd.."')"
				ply:SendLua(msg)
				s_ent:SendLua(msg)
			end
			ply.NextSpectatorScare = CurTime() + 120
		end
		ply.LastSpectatorUse = CurTime()
	end
end

local function disableDeadUse( ply, ent )
	if !ply:Alive() then return false end
end

hook.Add( "PlayerUse", "nzDisableDeadUse", disableDeadUse)

local hooks = hook.GetTable().AllowPlayerPickup
if hooks then
	for k,v in pairs(hooks) do
		hook.Remove("AllowPlayerPickup", k)
	end
end

local function disableDeadPickups( ply, ent )
	if !ply:Alive() then
		return false
	else
		-- This will allow pickups even if the weapon can't holster
		/*local wep = ply:GetActiveWeapon()
		if IsValid(wep) and !wep:IsSpecial() then
			local holster = wep.Holster
			wep.Holster = function() return true end
			timer.Simple(0, function() wep.Holster = holster end)
		end*/
		return true
	end
end

hook.Add( "AllowPlayerPickup", "_nzDisableDeadPickups", disableDeadPickups)
