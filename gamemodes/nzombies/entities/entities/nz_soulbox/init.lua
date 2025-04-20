AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/zmb/bo2/tomb/zm_tm_soul_box.mdl")
	end

	if self:GetElectric() == nil then
		self:SetElectric(false)
	end
	if self:GetRewardType() == nil then
		self:SetRewardType(1)
	end
	if not self.Range then
		self.Range = 400
	end
	if not self.ActivateSound then
		self.ActivateSound = Sound("zmb/tomb/evt_souls_full.wav")
	end

	//legacy soul catcher variables and functions
	self.CurrentAmount = 0
	self:SetTargetAmount(self.TargetAmount or self:GetSoulCost())
	self:SetCondition(self.Condition or function(z, dmg) return true end) -- Always allow
	self:SetRange(self.Range) -- Default range
	self:SetEnabled(self.Enabled or true)

	self.RewardsList = {
		[1] = self.RewardPowerUp,
		[2] = self.RewardPerk,
		[3] = self.RewardPAP,
		[4] = self.RewardDoor,
		[5] = self.RewardElec,
		[6] = self.MapScript,
	}

	self.MarkedPlayers = {}
	self.RangeSqr = self.Range*self.Range
	self.AutomaticFrameAdvance = true

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)

	self:Reset()
end

function ENT:SetCatchFunction(func) //legacy
	self.CatchFunc = func
end

function ENT:SetCompleteFunction(func) //legacy
	self.CompleteFunc = func
end

function ENT:SetTargetAmount(num) //legacy
	self.TargetAmount = tonumber(num)
	self:SetSoulCost(tonumber(num))
end

function ENT:SetCondition(func) //legacy
	self.Condition = func
end

function ENT:SetRange(num) //legacy
	self.Range = tonumber(num)
	self.RangeSqr = self.Range*self.Range
	self:SetSoulRange(self.Range)
end

function ENT:SetEnabled(bool) //legacy
	self.Enabled = tobool(bool)
end

function ENT:SetReleaseOverride(func) //legacy
	self.ReleaseOverride = func
end

function ENT:SetCurrentAmount(num) //legacy
	self.CurrentAmount = tonumber(num)
end

ENT.RewardPowerUp = function(self)
	local count = self:GetRemaining()

	if self.KillAll and count > 0 then
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." "..count.." of "..self:GetMaxRemaining().." remaining.")
	else
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." Random Power-Up rewarded.")

		local powerups = {"maxammo", "dp", "insta", "nuke", "bonuspoints"}
		nzPowerUps:SpawnPowerUp(self:GetPos(), powerups[math.random(#powerups)])
	end
end

ENT.RewardPerk = function(self)
	local count = self:GetRemaining()

	if self.KillAll and count > 0 then
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." "..count.." of "..self:GetMaxRemaining().." remaining.")
	else
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." Random perk rewarded.")

		for k, v in pairs(player.GetAllPlaying()) do
			v:GiveRandomPerk()
		end
	end
end

ENT.RewardPAP = function(self)
	local count = self:GetRemaining()

	if self.KillAll and count > 0 then
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." "..count.." of "..self:GetMaxRemaining().." remaining.")
	else
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." Pack a' Punch rewarded.")

		for k, v in pairs(player.GetAllPlaying()) do
			self:GivePap(v)
		end
	end
end

ENT.RewardDoor = function(self)
	local count = self:GetRemaining()

	if self.KillAll and count > 0 then
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." "..count.." of "..self:GetMaxRemaining().." remaining.")
	else
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." "..(self.DoorOpenText or "A door somewhere has opened..."))

		nzDoors:OpenLinkedDoors(self:GetDoorFlag())
	end
end

ENT.RewardElec = function(self)
	local count = self:GetRemaining()

	if self.KillAll and count > 0 then
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." "..count.." of "..self:GetMaxRemaining().." remaining.")
	else
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "Soul Box completed!").." Electricity activated.")

		if self:GetLimited() and self:GetAOE() >= 1 then
			local weball = false
			for k, v in pairs(ents.FindByClass("wunderfizz_machine")) do
				if v:IsOn() then 
					weball = true
					break
				end
			end

			for k, v in pairs(ents.FindInSphere(self:GetPos(), self:GetAOE())) do
				if v:EntIndex() == self:EntIndex() then continue end

				if v:IsBuyableEntity() and v:GetDoorData() then
					local data = v:GetDoorData()
					if data then
						if tonumber(data.price) == 0 and tobool(data.elec) then
							local turbine = v.Turbine
							if IsValid(turbine) and turbine.localpower then
								turbine:ResetTurbine(v, true)
							end

							nzDoors:OpenDoor(v)
						end
					end
				elseif nzElec.IsValidEntity and nzElec.ShouldTurnOn then
					if nzElec:IsValidEntity(v:GetClass()) and nzElec:ShouldTurnOn(v) then
						local turbine = v.Turbine
						if IsValid(turbine) and turbine.localpower then
							turbine:ResetTurbine(v, true) //bool removes ent from turbines localpower table, you usually want to do this
						end

						v:TurnOn()
					end
				else
					if v:GetClass() == "wunderfizz_machine" then 
						if !weball or nzMapping.Settings.cwfizz then
							local turbine = v.Turbine
							if IsValid(turbine) and turbine.localpower then
								turbine:ResetTurbine(v, true)
							end

							v:TurnOn()
						end
					elseif (v.TurnOff and v.TurnOn) then
						if v.IgnoreLocalPower then continue end

						local turbine = v.Turbine
						if IsValid(turbine) and turbine.localpower then
							turbine:ResetTurbine(v, true)
						end

						v:TurnOn()
					end
				end
			end
		else
			nzElec:Activate()
		end
	end
end

ENT.MapScript = function(self)
	//blank reward for use with mapscript soulboxes that run custom complete code
end

function ENT:ZedCheck(ply, wep, ent)
	if self:GetElectric() and not nzElec.Active then
		return false
	end
	if self:GetCompleted() then
		return false
	end
	if self:GetSpecials() and not (ent.IsMooSpecial or string.find(ent:GetClass(), "zombie_special")) then
		return false
	end

	local myzombie = self:GetZombieClass()
	if myzombie ~= "" then
		if nzConfig.ValidEnemies[myzombie] then
			if ent:GetClass() ~= myzombie then
				return false
			end
		elseif nzRound.BossData[myzombie] then
			if ent:GetClass() ~= nzRound.BossData[myzombie]["class"] then
				return false
			end
		end
	end

	local mygun = self:GetWepClass()
	if weapons.Get(mygun) ~= nil and wep:GetClass() ~= mygun then
		return false
	end

	return true
end

function ENT:NotifyZombieDeath(ply, wep, ent)
	if not IsValid(ply) or not IsValid(wep) or not IsValid(ent) then return end
	if not nzRound:InProgress() then return end

	if self.ReleaseOverride then self:ReleaseOverride(ent, ply, wep) return end //legacy

	if not self:GetOpen() then
		self:Open()
	end

	local fx = EffectData()
	fx:SetOrigin(ent:WorldSpaceCenter() + Vector(0,0,12))
	fx:SetEntity(self)
	util.Effect("nz_zombie_soul", fx)

	ent:EmitSound("nz_moo/zombies/vox/nuke_death/soul_0"..math.random(9)..".mp3", 100, math.random(85,105))

	self:SetSoulAmount(math.min(self:GetSoulAmount() + 1, self:GetSoulCost()))

	self.CurrentAmount = self.CurrentAmount + 1 //legacy
	if self.CatchFunc then
		self:CatchFunc(ent, ply, wep) //legacy
	end

	if self:GetSoulAmount() >= self:GetSoulCost() and not self.CompleteTime then
		self.CompleteTime = CurTime() + 2
		if self.CompleteFunc then
			self:CompleteFunc(ent, ply, wep) //legacy
		end
	end
end

function ENT:Think()
	if self.CompleteTime and self.CompleteTime < CurTime() then
		self.CompleteTime = nil
		if self:GetGivePowerup() then
			local powerups = {"maxammo", "dp", "insta", "nuke", "bonuspoints"}
			nzPowerUps:SpawnPowerUp(self:GetPos(), powerups[math.random(#powerups)])
		end

		self.RewardsList[tonumber(self:GetRewardType())](self)

		for i=1, player.GetCount() do
			local ply = Entity(i)
			if not IsValid(ply) or not ply:IsPlayer() then continue end

			if ply:GetPos():DistToSqr(self:GetPos()) <= self.RangeSqr then
				local msg1 = "LocalPlayer():StopSound('"..self.ActivateSound.."')"
				local msg2 = "surface.PlaySound('"..self.ActivateSound.."')"
				ply:SendLua(msg1)
				ply:SendLua(msg2)
			end
		end

		self:Close()

		timer.Simple(self:SequenceDuration("close"), function()
			if not IsValid(self) then return end
			self:SetNoDraw(true)
			self:SetSolid(SOLID_NONE)
			self:DrawShadow(false)
		end)
	end

	self:NextThink(CurTime())
	return true
end

function ENT:GivePap(ply)
	local wep = ply:GetActiveWeapon()
	if wep.NZSpecialCategory and !wep.OnPaP then
		for k, v in pairs(ply:GetWeapons()) do
			if v:GetNWInt("SwitchSlot", 0) > 0 and not v:HasNZModifier("pap") then
				wep = v
				break
			end
		end
	end
	if not IsValid(wep) then return end

	if nzWeps.Updated then
		if wep.NZPaPReplacement then
			local wep2 = ply:Give(wep.NZPaPReplacement)
			wep2:ApplyNZModifier("pap")
			ply:SelectWeapon(wep2:GetClass())
			ply:StripWeapon(wep:GetClass())
		elseif wep.OnPaP then
			if wep:HasNZModifier("pap") then
				wep:ApplyNZModifier("repap")
			else
				wep:ApplyNZModifier("pap")
			end

			wep:ResetFirstDeploy()
			wep:CallOnClient("ResetFirstDeploy", "")
			wep:Deploy()
			wep:CallOnClient("Deploy", "")
		end
	else
		if wep.NZPaPReplacement then
			ply:StripWeapon(wep:GetClass())
			local wep2 = ply:Give(wep.NZPaPReplacement)
			timer.Simple(0, function()
				if not IsValid(ply) or not IsValid(wep2) then return end

				wep2:ApplyNZModifier("pap")
			end)
		elseif wep.OnPaP then
			ply:StripWeapon(wep:GetClass())
			local wep2 = ply:Give(wep:GetClass())
			timer.Simple(0, function()
				if not IsValid(ply) or not IsValid(wep2) then return end

				wep2:ApplyNZModifier("pap")
			end)
		end
	end
end

function ENT:Use(ply)
	if not nzRound:InProgress() then
		if (nzRound:InState(ROUND_CREATE) or ply:IsInCreative()) then
			if ply.NextUse and ply.NextUse > CurTime() then return end

			ply.NextUse = CurTime() + 1.5

			local msg1 = "LocalPlayer():StopSound('"..self.ActivateSound.."')"
			local msg2 = "surface.PlaySound('"..self.ActivateSound.."')"
			ply:SendLua(msg1)
			ply:SendLua(msg2)

			if self:GetRewardType() == 4 then
				ply:ChatPrint((self.CompletedText or "Soul Box completed!").." "..(self.DoorOpenText or "A door somewhere has opened..."))
			end
		end
		return
	end
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if self.NextUse and self.NextUse > CurTime() then return end

	self.NextUse = CurTime() + (0.05 * self.UseCount)
	self.UseCount = self.UseCount + 1

	if self.UseCount == 50 then
		self:EmitSound("zmb/stinger/pip_club_loop.wav", 75, 100, 1, CHAN_STATIC)
	end
end

function ENT:Reset()
	if self.Elec then
		self:TurnOff()
	else
		self:Close()
	end

	self:SetSoulAmount(0)
	self.UseCount = 0

	self:SetNoDraw(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
end

function ENT:TurnOn()
	if not self.Elec then return end
	self:SetElectric(false)
	self:Open()
end

function ENT:TurnOff()
	if not self.Elec then return end
	self:SetElectric(true)
	self:Close()
end
