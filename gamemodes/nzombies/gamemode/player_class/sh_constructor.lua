-- Main Tables
nzPlayers = nzPlayers or AddNZModule("Players")
nzPlayers.Data = nzPlayers.Data or {}

-- Variables
local downedspeed = 30

-- Copy-pasted from the wiki, a nice little function
local CMoveData = FindMetaTable( "CMoveData" )
function CMoveData:RemoveKeys( keys )
	-- Using bitwise operations to clear the key bits.
	local newbuttons = bit.band( self:GetButtons(), bit.bnot( keys ) )
	self:SetButtons( newbuttons )
end

//credit TFA Base maintainers for this
//lua/tfa/modules/tfa_hooks.lua #202

local band = bit.band
local bxor = bit.bxor
local bnot = bit.bnot
hook.Add("FinishMove", "nzPlayerTick", function(ply, cmovedata)
	if not ply.GetDownButtons then return end

	local lastButtons = ply:GetDownButtons()
	local buttons = cmovedata:GetButtons()
	local changed = bxor(lastButtons, buttons)
	local pressed = band(changed, bnot(lastButtons), buttons)

	ply:SetDownButtons(buttons)
	ply:SetLastPressedButtons(pressed)
end)

//shared version of PLAYER:KeyDown() for HUD and spectator HUD related stuff
local PLAYER = FindMetaTable("Player")
function PLAYER:HasButtonDown(button)
	if not self.GetDownButtons or (button == nil) or !isnumber(button) then
		return false
	end
	return bit.band(self:GetDownButtons(), button) ~= 0
end

-- Stops players from moving if downed
hook.Add("SetupMove", "nzFreezePlayersDowned", function( ply, mv, cmd )
	if !ply:GetNotDowned() then
		mv:SetMaxClientSpeed(downedspeed)
	end
end)

local lockedPlayers = {}
hook.Add("StartCommand", "nzPlayerDownFake", function(ply, cmd)
	if !ply:GetNotDowned() then
		cmd:RemoveKey(IN_SPEED)
		cmd:RemoveKey(IN_JUMP)
		cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_DUCK))
	end

	if nzRound:InState(ROUND_GO) then
		if !ply:Alive() then
			cmd:RemoveKey(IN_DUCK)
		end
		cmd:RemoveKey(IN_ATTACK)
		cmd:RemoveKey(IN_ATTACK2)
		cmd:ClearMovement()
	end

	if SERVER and ply:Alive() and ply:GetNotDowned() then
		if cmd:IsForced() then
			if !lockedPlayers[ply] then
				lockedPlayers[ply] = CurTime()
			end

			if lockedPlayers[ply] and lockedPlayers[ply] + 0.25 < CurTime() and ply:GetTargetPriority() > 0 then
				ply:SetTargetPriority(TARGET_PRIORITY_NONE)
				ply:GodEnable()
				ply:SetNW2Bool("nzLagProtection", true)
			end
		elseif lockedPlayers[ply] then
			if ply:GetNW2Bool("nzLagProtection", false) then
				ply:SetNW2Bool("nzLagProtection", false)
			end
			if ply:HasGodMode() then
				print('[NZ] Player '..ply:Nick()..' stopped sending CMoveData for '..math.Round(CurTime() - lockedPlayers[ply], 2)..' seconds and was granted notarget')
				ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
				ply:GodDisable()
			end

			lockedPlayers[ply] = nil
		end
	end
end)

if CLIENT then
	hook.Add("InputMouseApply", "nzPlayerDownFake", function(cmd)
		if nzRound:InState(ROUND_GO) then
			cmd:SetMouseX(0)
			cmd:SetMouseY(0)
			return true
		end
	end)
end

hook.Add("PlayerSwitchWeapon", "nzPlayerWeaponSwap", function(ply, oldWep, newWep)
	if not IsValid(ply) or not IsValid(newWep) then return end

	if not ply:HasPerk("mulekick") and newWep:GetNWInt("SwitchSlot", 0) == 3 then
		return true
	end
end)

hook.Add("PlayerSpawn", "SetupHands", function(ply)
	local mdl = ply:GetInfo( "cl_playermodel" )
	ply:SetModel(mdl)
	
	local col = ply:GetInfo( "cl_playercolor" )
	ply:SetPlayerColor( Vector( col ) )

	local col = Vector( ply:GetInfo( "cl_weaponcolor" ) )
	if col:Length() == 0 then
		col = Vector( 0.001, 0.001, 0.001 )
	end
	ply:SetWeaponColor( col )
	
	local skin = ply:GetInfoNum( "cl_playerskin", 0 )
	ply:SetSkin( skin )

	local groups = ply:GetInfo( "cl_playerbodygroups" )
	if ( groups == nil ) then groups = "" end
	local groups = string.Explode( " ", groups )
	for k = 0, ply:GetNumBodyGroups() - 1 do
		ply:SetBodygroup( k, tonumber( groups[ k + 1 ] ) or 0 )
	end
	
	timer.Simple(0, function()
		if IsValid(ply) then ply:SetupHands() end
	end)
end)

hook.Add("ScalePlayerDamage", "nzFriendlyFire", function(ply, hitgroup, dmginfo)
	local attacker = dmginfo:GetAttacker()
	if IsValid(attacker) and attacker:IsPlayer() then
		dmginfo:SetDamage(0)
		dmginfo:ScaleDamage(0)
		return true
	end
	if nzRound:InState(ROUND_GO) then
		dmginfo:SetDamage(0)
		dmginfo:ScaleDamage(0)
		return false
	end
end)

hook.Add("EntityFireBullets", "nzFriendlyFire", function(ply, data)
	if IsValid(ply) and ply:IsPlayer() then
		local tr = util.QuickTrace(data.Src, data.Src + data.Dir * data.Distance, ply)
		local ent = tr.Entity
		if IsValid(ent) and ent:IsPlayer() then
			data.IgnoreEntity = ent
			return true
		end
	end
end)