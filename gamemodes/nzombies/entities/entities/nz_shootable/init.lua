AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/nzr/song_ee/teddybear.mdl")
	end
	local snd = self.ActivateSound
	if not snd or not file.Exists("sound/"..snd, "GAME") then
		self.ActivateSound = Sound("zmb/stinger/afterlife_end.wav")
	end

	/*if self:GetHurtType() == nil then
		self:SetHurtType(4)
	end
	if self:GetRewardType() == nil then
		self:SetRewardType(2)
	end
	if self:GetPointAmount() == nil then
		self:SetPointAmount(1000)
	end
	if self:GetGlobal() == nil and #player.GetAllPlaying() > 1 then
		self:SetGlobal(true)
	end*/

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)

	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
end

local switch_reward = {
	[1] = function(self, ply)
		local count = 1
		for k, v in pairs(ents.FindByClass("nz_shootable")) do
			if not v:GetActivated() and v:GetFlag() == self:GetFlag() and v:GetKillAll() then
				count = count + 1
			end
		end

		if self:GetKillAll() and count > 1 then
			count = count - 1
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! "..count.." remaining.")
		else
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! Bonus points rewarded.")
			if self:GetGlobal() then
				for k, v in pairs(player.GetAllPlaying()) do
					v:GivePoints(self:GetPointAmount())
				end
			else
				ply:GivePoints(self:GetPointAmount())
			end
		end
	end,
	[2] = function(self, ply)
		local count = 1
		for k, v in pairs(ents.FindByClass("nz_shootable")) do
			if not v:GetActivated() and v:GetFlag() == self:GetFlag() then
				count = count + 1
			end
		end

		if self:GetKillAll() and count > 1 then
			count = count - 1
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! "..count.." remaining.")
		else
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! Random perk rewarded.")
			if self:GetGlobal() then
				for k, v in pairs(player.GetAllPlaying()) do
					v:GiveRandomPerk()
				end
			else
				ply:GiveRandomPerk()
			end
		end
	end,
	[3] = function(self, ply)
		local count = 1
		for k, v in pairs(ents.FindByClass("nz_shootable")) do
			if not v:GetActivated() and v:GetFlag() == self:GetFlag() then
				count = count + 1
			end
		end

		if self:GetKillAll() and count > 1 then
			count = count - 1
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! "..count.." remaining.")
		else
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! Pack a' Punch rewarded.")
			if self:GetGlobal() then
				for k, v in pairs(player.GetAllPlaying()) do
					self:GivePap(v)
				end
			else
				self:GivePap(ply)
			end
		end
	end,
	[4] = function(self, ply)
		local count = 1
		for k, v in pairs(ents.FindByClass("nz_shootable")) do
			if not v:GetActivated() and v:GetFlag() == self:GetFlag() then
				count = count + 1
			end
		end

		if self:GetKillAll() and count > 1 then
			count = count - 1
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! "..count.." remaining.")
		else
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! A Door somewhere has opened...")
			print(self:GetDoorFlag())
			nzDoors:OpenLinkedDoors(self:GetDoorFlag())
		end
	end,
	[5] = function(self, ply)
		local count = 1
		for k, v in pairs(ents.FindByClass("nz_shootable")) do
			if not v:GetActivated() and v:GetFlag() == self:GetFlag() then
				count = count + 1
			end
		end

		if self:GetKillAll() and count > 1 then
			count = count - 1
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! "..count.." remaining.")
		else
			PrintMessage(HUD_PRINTTALK, ply:Nick().." found a secret! Electricity Activated.")
			nzElec:Activate()
		end
	end,
}

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
			if not IsValid(ply) or not IsValid(wep) then return end

			ply:StripWeapon(wep:GetClass())
			local wep2 = ply:Give(wep.NZPaPReplacement)
			timer.Simple(0, function()
				if not IsValid(ply) or not IsValid(wep2) then return end

				wep2:ApplyNZModifier("pap")
			end)
		elseif wep.OnPaP then
			if not IsValid(ply) or not IsValid(wep) then return end

			ply:StripWeapon(wep:GetClass())
			local wep2 = ply:Give(wep:GetClass())
			timer.Simple(0, function()
				if not IsValid(ply) or not IsValid(wep2) then return end

				wep2:ApplyNZModifier("pap")
			end)
		end
	end
end

function ENT:Update(data)
	if data then
		if data.flag then
			self:SetFlag(tonumber(data.flag))
		end
		if data.model and util.IsValidModel(data.model) then
			self:SetModel(tostring(data.model))
		end
		if data.hurttype then
			self:SetHurtType(tonumber(data.hurttype))
		end
		if data.rewardtype then
			self:SetRewardType(tonumber(data.rewardtype))
		end
		if data.pointamount then
			self:SetPointAmount(tonumber(data.pointamount))
		end
		if data.door then
			self:SetDoorFlag(tostring(data.door))
		end
		if data.killall then
			self:SetKillAll(tobool(data.killall))
		end
		if data.upgrade then
			self:SetUpgrade(tobool(data.upgrade))
		end
		if data.global then
			self:SetGlobal(tobool(data.global))
		end
		if data.sound and file.Exists("sound/"..data.sound, "GAME") then
			self.ActivateSound = Sound(data.sound)
		end
		if data.skin then
			self:SetSkin(tonumber(data.skin))
		end
	end
end

local testtime = 0
function ENT:OnTakeDamage(dmginfo)
	if self:GetActivated() then return end
	if nzRound:InState(ROUND_CREATE) and testtime > CurTime() then return end

	local ply = dmginfo:GetAttacker()
	local wep = dmginfo:GetInflictor()

	if not IsValid(ply) then return end
	if not IsValid(wep) then return end
	if not ply:IsPlayer() then return end
	if self:GetUpgrade() and not wep:HasNZModifier("pap") then return end
	if self:GetWepClass() ~= "" and wep:GetClass() ~= self:GetWepClass() then return end

	local dmgtype = dmginfo:GetDamageType()
	local meleedamage = bit.band(dmgtype, bit.bor(DMG_CLUB, DMG_SLASH, DMG_CRUSH)) ~= 0
	local burndamage = bit.band(dmgtype, bit.bor(DMG_BURN, DMG_SLOWBURN)) ~= 0
	local shockdamage = bit.band(dmgtype, bit.bor(DMG_SHOCK, DMG_ENERGYBEAM)) ~= 0
	local blastdamage = dmginfo:IsExplosionDamage()
	local bulletdamage = dmginfo:IsBulletDamage()

	if (self:GetHurtType() == 1 and meleedamage) or (self:GetHurtType() == 2 and blastdamage) or (self:GetHurtType() == 3 and burndamage) or (self:GetHurtType() == 4 and bulletdamage) or (self:GetHurtType() == 5 and shockdamage) then
		hook.Call("PlayerActivateShootable", nil, ply, self, dmginfo)
		ply:EmitSound(self.ActivateSound, 75, math.random(95,105), 1, CHAN_VOICE2)

		if nzRound:InState(ROUND_CREATE) then
			ply:ChatPrint('Test activated '..self:GetClass()..'['..self:EntIndex()..']')
			testtime = CurTime() + 2
		return end

		self:Trigger()
		switch_reward[self:GetRewardType()](self, ply)
	end
end

function ENT:Use(ply)
	if not nzRound:InState(ROUND_CREATE) then return end
	if ply.NextUse and ply.NextUse > CurTime() then return end

	ply.NextUse = CurTime() + 2
	ply:ChatPrint('Test activated '..self:GetClass()..'['..self:EntIndex()..']')

	self:StopSound(self.ActivateSound)
	self:EmitSound(self.ActivateSound)
end

function ENT:Trigger()
	self:SetActivated(true)
	self:SetTrigger(false)
	self:SetNoDraw(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
end

function ENT:Reset()
	self:SetActivated(false)
	self:SetNoDraw(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	self:SetTrigger(true)
end
