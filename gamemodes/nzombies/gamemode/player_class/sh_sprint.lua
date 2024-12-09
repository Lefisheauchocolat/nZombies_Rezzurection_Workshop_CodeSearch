local plymeta = FindMetaTable( "Player" )

//AccessorFunc( plymeta, "fStamina", "Stamina", FORCE_NUMBER )
//AccessorFunc( plymeta, "fMaxStamina", "MaxStamina", FORCE_NUMBER )
AccessorFunc( plymeta, "fLastStaminaRecover", "LastStaminaRecover", FORCE_NUMBER )
AccessorFunc( plymeta, "fLastStaminaLoss", "LastStaminaLoss", FORCE_NUMBER )
AccessorFunc( plymeta, "fStaminaLossAmount", "StaminaLossAmount", FORCE_NUMBER )
AccessorFunc( plymeta, "fStaminaRecoverAmount", "StaminaRecoverAmount", FORCE_NUMBER )
AccessorFunc( plymeta, "fMaxRunSpeed", "MaxRunSpeed", FORCE_NUMBER )
//AccessorFunc( plymeta, "bSprinting", "Sprinting", FORCE_BOOL )
AccessorFunc( plymeta, "bSpawned", "Spawned", FORCE_BOOL )

function plymeta:StopSprint(released)
	if released then
		self:SetSprinting(false)
		self:SetRunSpeed(self:GetMaxRunSpeed())
	else
		self:SetRunSpeed(self:GetWalkSpeed())
		self:SetSprinting(false)
		self:ConCommand("-speed")
	end

	hook.Run("OnStopSprint", self)
end

function plymeta:StartSprint()
	/*local MaxRunSpeed = self:GetMaxRunSpeed()

	if !MaxRunSpeed then
		MaxRunSpeed = self:GetRunSpeed()
		self:SetMaxRunSpeed(MaxRunSpeed)
	end

	self:SetRunSpeed( MaxRunSpeed )*/
	self:SetSprinting( true )
	hook.Run("OnStartSprint", self)
end

function plymeta:GetSprinting()
	return self:GetNW2Bool("nz_Sprinting", false)
end

function plymeta:SetSprinting(bool)
	return self:SetNW2Bool("nz_Sprinting", bool)
end

function plymeta:IsSprinting()
	return self:GetSprinting()
end

function plymeta:IsSpawned()
	return self:GetSpawned()
end

function plymeta:GetStamina()
	return self:GetNW2Float("nz_Stamina", 0)
end

function plymeta:SetStamina(float)
	return self:SetNW2Float("nz_Stamina", float)
end

function plymeta:GetMaxStamina()
	return self:GetNW2Float("nz_MaxStamina", 0)
end

function plymeta:SetMaxStamina(float)
	return self:SetNW2Float("nz_MaxStamina", float)
end

if SERVER then
	hook.Add("PlayerSpawn", "PlayerSprintSpawn", function( ply )
		ply:SetSprinting( false )
		ply:SetStamina( nzMapping.Settings.stamina )
		ply:SetMaxStamina( nzMapping.Settings.stamina )
		ply:SetSlidingStamina( 1 )

		--The rate is fixed on 0.05 seconds
		ply:SetStaminaLossAmount( 0.9 ) -- Sprint now lasts around 8 seconds without Staminup.
		ply:SetStaminaRecoverAmount( nzMapping.Settings.staminaregenamount ) -- Raised this slightly just incase.

		ply:SetLastStaminaLoss( 0 )
		ply:SetLastStaminaRecover( 0 )

		-- Delay this a bit - it seems like it takes the old sprint speed from last round state (Creative speed)
		timer.Simple(0.1, function()
			if IsValid(ply) then
				ply:SetMaxRunSpeed( ply:GetRunSpeed() )
				-- player variables (especially spritn vars) have been initialized
				ply:SetSpawned(true)
			end
		end)
	end)

	hook.Add("Think", "PlayerSprint", function()
		if !nzRound:InState( ROUND_CREATE ) then
			for _, ply in pairs( player.GetAll() ) do
				if ply:Alive() and ply:GetNotDowned() and ply:IsSprinting() and ply:GetStamina() >= 0 and ply:GetLastStaminaLoss() + 0.05 <= CurTime() then
					ply:SetStamina( math.Clamp( ply:GetStamina() - ply:GetStaminaLossAmount(), 0, ply:GetMaxStamina() ) )
					ply:SetLastStaminaLoss( CurTime() )

					-- Delay the recovery a bit, you can't sprint instantly after
					ply:SetLastStaminaRecover( CurTime() + nzMapping.Settings.staminaregendelay )

					if ply:GetStamina() == 0 then
						ply:StopSprint()
					end
				elseif ply:Alive() and ply:GetNotDowned() and !ply:IsSprinting() and ply:GetStamina() < ply:GetMaxStamina() and ply:GetLastStaminaRecover() + 0.05 <= CurTime() then
					ply:SetStamina( math.Clamp( ply:GetStamina() + nzMapping.Settings.staminaregenamount, 0, ply:GetMaxStamina() ) )
					ply:SetLastStaminaRecover( CurTime() )
				end
			end
		end
	end)

	hook.Add( "KeyRelease", "ButtonUp_NZ", function( ply, key )
		if key == IN_SPEED and ply:Alive() and ply:GetNotDowned() then
			ply:StopSprint(true)
		end
	end)

	hook.Add( "KeyPress", "OnSprintKeyReleased_NZ", function( ply, key )
		if key == IN_SPEED and ply:Alive() and ply:GetNotDowned() and ply:GetStamina() > 0 then
			ply:StartSprint()
		end
	end)
end
