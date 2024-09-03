-- 

if SERVER then
	local plyMeta = FindMetaTable("Player")

	function plyMeta:GiveAntiPowerUp(id, duration)
		if duration > 0 then
			if not nzPowerUps.ActivePlayerAntiPowerUps[self] then nzPowerUps.ActivePlayerAntiPowerUps[self] = {} end
			
			nzPowerUps.ActivePlayerAntiPowerUps[self][id] = (nzPowerUps.ActivePlayerAntiPowerUps[self][id] or CurTime()) + duration
			nzPowerUps:SendPlayerSync(self) -- Sync this player's powerups
		end
	end

	function plyMeta:RemoveAntiPowerUp(id, nosync)
		local PowerupData = nzPowerUps:Get(id)
		if PowerupData and PowerupData.expirefunc then
			PowerupData.expirefunc(id, self) -- Call expirefunc when manually removed
		end
	
		if not nzPowerUps.ActivePlayerAntiPowerUps[self] then nzPowerUps.ActivePlayerAntiPowerUps[self] = {} end
		nzPowerUps.ActivePlayerAntiPowerUps[self][id] = nil
		if not nosync then nzPowerUps:SendPlayerSync(self) end -- Sync this player's powerups
	end

	function plyMeta:RemoveAllAntiPowerUps()
		if not nzPowerUps.ActivePlayerAntiPowerUps[self] then nzPowerUps.ActivePlayerAntiPowerUps[self] = {} return end
		
		for k,v in pairs(nzPowerUps.ActivePlayerAntiPowerUps[self]) do
			self:RemoveAntiPowerUp(k, true)
		end

		nzPowerUps:SendPlayerSync(self)
	end

	function nzPowerUps:ActivateAnti(id, zed, ent)
		local PowerupData = self:Get(id)
		if !PowerupData or !PowerupData.antifunc then return end

		local ply
		if not PowerupData.global and PowerupData.anticond then //randomize for player
			for k, v in RandomPairs(player.GetAll()) do
				if PowerupData.anticond(v) then //make sure they qualify for the effect
					ply = v
					break
				end
			end
		end

		if hook.Call("OnPickupAntiPowerUp", nil, zed, ply, id, ent) then return end

		if not PowerupData.global then
			if IsValid(ply) then
				if not nzPowerUps.ActivePlayerAntiPowerUps[ply] or not nzPowerUps.ActivePlayerAntiPowerUps[ply][id] then -- If you don't have the powerup
					PowerupData.antifunc(id, ply, ent)
				end
				ply:GiveAntiPowerUp(id, PowerupData.antiduration * (ply:HasPerk("time") and 0.5 or 1))
			end
		else
			if PowerupData.antiduration and PowerupData.antiduration ~= 0 then
				if not self.ActiveAntiPowerUps[id] then
					PowerupData.antifunc(id, ply, ent)
				end
				self.ActiveAntiPowerUps[id] = (self.ActiveAntiPowerUps[id] or CurTime()) + PowerupData.antiduration * ((IsValid(ply) and ply:HasPerk("time")) and 0.5 or 1)
			else
				PowerupData.antifunc(id, ply, ent)
			end

			self:SendSync()
		end

		if isstring(PowerupData.announcement) then
			local name = string.Replace(PowerupData.name, " ", "")
			nzSounds:Play(name)
		end
	end

	function nzPowerUps:SpawnAntiPowerUp(pos, id)
		if not id then return end
		local PowerupData = self:Get(id)
		if (!PowerupData or !PowerupData.antifunc) then return end

		local ent = ents.Create("drop_powerup")
		id = hook.Call("OnPowerUpSpawned", nil, id, ent) or id
		if not IsValid(ent) then return end -- If a hook removed the powerup

		if not pos then
			pos = Entity(1):GetPos()
		end
		local pos = pos + Vector(0, 0, 50)

		ent:SetPowerUp(id)
		pos.z = pos.z - ent:OBBMaxs().z
		ent:SetModel(PowerupData.model)
		ent:SetPos(pos)
		ent:SetAngles(PowerupData.angle)
		ent:SetAnti(true)
		ent:Spawn()
	end

	hook.Add("Think", "CheckActiveAntiPowerups", function()
		for k,v in pairs(nzPowerUps.ActiveAntiPowerUps) do
			if CurTime() >= v then
				local func = nzPowerUps:Get(k).antiexpirefunc
				if func then func(id) end
				nzPowerUps.ActiveAntiPowerUps[k] = nil
				nzPowerUps:SendSync()
			end
		end

		for k,v in pairs(nzPowerUps.ActivePlayerAntiPowerUps) do
			if not IsValid(k) then
				nzPowerUps.ActivePlayerAntiPowerUps[k] = nil
				nzPowerUps:SendPlayerSyncFull()
			else
				for id, time in pairs(v) do
					if CurTime() >= time then
						local func = nzPowerUps:Get(id).antiexpirefunc
						if func then func(id, k) end
						nzPowerUps.ActivePlayerAntiPowerUps[k][id] = nil
						nzPowerUps:SendPlayerSync(k)
					end
				end
			end
		end
	end)
end

function nzPowerUps:IsAntiPowerupActive(id)
	local time = self.ActiveAntiPowerUps[id]
	if time then
		if CurTime() > time then
			self.ActiveAntiPowerUps[id] = nil
		else
			return true
		end
	end

	return false
end

function nzPowerUps:IsPlayerAntiPowerupActive(ply, id)
	if not self.ActivePlayerAntiPowerUps[ply] then self.ActivePlayerAntiPowerUps[ply] = {} end
	local time = self.ActivePlayerAntiPowerUps[ply][id]

	if time then
		if CurTime() > time then
			self.ActivePlayerAntiPowerUps[ply][id] = nil
		else
			return true
		end
	end

	return false
end

function nzPowerUps:AllActiveAntiPowerUps()
	return self.ActiveAntiPowerUps
end

AccessorFunc(nzPowerUps, "fAntiPowerUpChance", "AntiPowerUpChance", FORCE_NUMBER)

function nzPowerUps:ResetAntiPowerUpChance()
	local start = nzMapping.Settings.antipowerupstart
	self:SetAntiPowerUpChance(start > 0 and -start or 0)
end

function nzPowerUps:IncreaseAntiPowerUpChance()
	if not self:GetAntiPowerUpChance() then nzPowerUps:ResetAntiPowerUpChance() end
	self:SetAntiPowerUpChance(self:GetAntiPowerUpChance() + 1)
end
