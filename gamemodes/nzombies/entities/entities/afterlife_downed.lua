AddCSLuaFile()

ENT.Base = "base_nextbot"
ENT.PrintName = "Faked downed player"
ENT.Category = "Brainz"
ENT.Author = "Lolle & Zet0r"

function ENT:Initialize()
    --change those after creation
    self:SetModel( "models/player/kleiner.mdl" )
	self.OwnerData = {}
	self.OldPerks = {}
    if SERVER then self:GiveWeapon( "weapon_pistol" ) end
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "PerkOwner")
end

function ENT:BodyUpdate()
	if self:GetActivity() != ACT_HL2MP_SIT_PISTOL then self:StartActivity( ACT_HL2MP_SIT_PISTOL ) end
end

function ENT:Use( act, call, type, value )
    --revive here?
end

function ENT:RunBehaviour()
	while (true) do
        coroutine.wait(60)
    end
end

function ENT:GiveWeapon( wepclass )
	if !wepclass then return end

	if IsValid(self.Weapon) then
		self.Weapon:Remove()
	end

    self.Weapon = ents.Create( wepclass )
    if !IsValid(self.Weapon) then
        return
    end
    self.Weapon:SetOwner(self)
    self.Weapon:SetParent(self)
    self.Weapon:SetPos( self:GetAttachment(self:LookupAttachment("anim_attachment_RH")).Pos )
    self.Weapon:Spawn()
    self.Weapon:SetSolid(SOLID_NONE)
    self.Weapon:AddEffects(EF_BONEMERGE)
    self.Weapon:Fire( "SetParentAttachment", "anim_attachment_LH" )

end


local mat = Material("Models/effects/comball_tape")
function ENT:Draw()
	
	self:DrawModel()
	render.MaterialOverride(mat)
	self:DrawModel()
	render.MaterialOverride(nil)

end

-- FAS2 weapons seem to want this function
function ENT:InVehicle()
	return false
end

function ENT:RevivePlayer()
	local ply = self:GetPerkOwner()
	--PrintTable(self.OwnerData)
	
	if (IsValid(ply) and ply:IsPlayer()) then
		if ply:Alive() then
			if !ply:GetNotDowned() then
				ply:RevivePlayer()
			end
		else
			ply:Spawn()
		end
		
		ply:SetPos(self:GetPos())
		ply:SetEyeAngles(self:GetAngles())
		
		-- Yeah no, Who's Who doesn't actually let you keep your clone's perks or weapons
		if ply:GetNW2Bool("IsInAfterlife") then
			ply:GetWeapon("weapon_afterlife"):GiveAbilities(false)
			ply:EmitSound("motd/afterlife/afterlife_end.ogg")
		end
		
		ply:RemovePerks()
		ply:StripWeapon("weapon_afterlife")
		--ply:StripWeapons()
		if IsValid(nzPowerUps.ActivePlayerPowerUps[ply]) then
			if !nzPowerUps:IsPlayerPowerupActive(ply, "zombieblood") then
				ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
			end
		else
			ply:SetTargetPriority(TARGET_PRIORITY_PLAYER)
		end
		
		local hasammodata = false
		local tbl = self.OwnerData.weps or ply.OldWeps
		for k,v in pairs(tbl) do
			local wep = ply:Give(v.class)
			if !IsValid(wep) then continue end
			if v.ammo1 != nil then
				ply:SetAmmo(v.ammo1, wep.Primary.Ammo)
				ply:SetAmmo(v.ammo2, wep.Secondary.Ammo)
				wep:SetClip1(v.clip1)
				wep:SetClip2(v.clip2)
				hasammodata = true
			end
			if v.pap then
				if wep.OnPaP then
					wep:OnPaP()
					continue
				end
				wep:ApplyNZModifier("pap")
			end
		end
		if !hasammodata then ply:GiveMaxAmmo() end
		
		if ply:GetNW2Bool("HasDiedFromSwitchbox") or ply.WhosWhoClone then
			for k,v in pairs(self.OwnerData.perks) do
				if v != "whoswho" then
					ply:GivePerk(v)
				end
			end
			ply:SetNW2Bool("HasDiedFromSwitchbox", false)
		end
	end
	
	-- Everything bought as the clone will be refunded, even doors
	ply:GivePoints(ply.WhosWhoMoney or ply.AfterlifeMoney)
	if self.OwnerData.afterlives then
		ply:SetNW2Int("Afterlives", self.OwnerData.afterlives)
	end
	
	local revivor = nzRevive.Players[id] and nzRevive.Players[id].RevivePlayer or nil
	if IsValid(revivor) and revivor:IsPlayer() then
		if self.DownPoints then
			revivor:GivePoints(self.DownPoints)
		end
		revivor:StripWeapon("nz_revive_morphine") -- Remove the viewmodel again
	end
	
	self:Remove()
end

function ENT:StartRevive(revivor, nosync)
	local id = self:EntIndex()
	if !nzRevive.Players[id] then return end -- Not even downed
	if nzRevive.Players[id].ReviveTime then return end -- Already being revived
	
	nzRevive.Players[id].ReviveTime = CurTime()
	nzRevive.Players[id].RevivePlayer = revivor
	revivor.Reviving = self
	
	if IsValid(revivor) and revivor:IsPlayer() then
		if revivor:GetNW2Bool("IsInAfterlife", false) and revivor:HasWeapon("weapon_afterlife") then
			local wep = revivor:GetWeapon("weapon_afterlife")
			wep:SetStatus(4)
			wep:SendWeaponAnim(ACT_VM_RELOAD)
			wep:SetNextIdle(CurTime() + 5)
			timer.Simple(0, function()
				if IsValid(wep) then
					wep:EmitSound("motd/afterlife/afterlife_revive_loop.wav")
				end
			end)
		elseif revivor:GetNotDowned() and !revivor:HasWeapon("nz_revive_morphine") and !revivor:GetNW2Bool("IsInAfterlife", false) then
			revivor:Give("nz_revive_morphine") -- Give them the viewmodel
		end
	end

	if !nosync then hook.Call("PlayerBeingRevived", nzRevive, self, revivor) end
end
	
function ENT:StopRevive(nosync)
	local id = self:EntIndex()
	if !nzRevive.Players[id] then return end -- Not even downed
	
	local revivor = nzRevive.Players[id].RevivePlayer
	if IsValid(revivor) then
		if revivor:GetNWBool("in_afterlife") then
			revivor:GetWeapon("weapon_afterlife"):SendWeaponAnim(ACT_VM_IDLE)
		else
			revivor:StripWeapon("nz_revive_morphine") -- Remove the revivors viewmodel
		end
	end
		
	nzRevive.Players[id].ReviveTime = nil
	nzRevive.Players[id].RevivePlayer = nil
	
	if !nosync then hook.Call("PlayerNoLongerBeingRevived", nzRevive, self) end
end

function ENT:KillDownedPlayer()
	local ply = self:GetPerkOwner()
	self:RevivePlayer()
	
	timer.Simple(0.1, function()
		ply:SetNW2Int("Afterlives", 0)
		ply:TakeDamage(ply:Health()+1)
	end)
end

function ENT:OnRemove()
	local ply = self:GetPerkOwner()
	if (IsValid(ply) and ply:IsPlayer()) then
		-- No more refunds for you once you become your clone mate!
		ply.WhosWhoMoney = nil
	end
	
	local revivor = nzRevive.Players[id] and nzRevive.Players[id].RevivePlayer or nil
	if IsValid(revivor) then -- This shouldn't happen as players can't die if they are currently being revived
		revivor:StripWeapon("nz_revive_morphine") -- Remove the revivors if someone was reviving viewmodel
	end
	
	nzRevive.Players[self:EntIndex()] = nil
	
	if SERVER then
		net.Start("nz_WhosWhoActive")
			net.WriteBool(false)
		net.Send(ply)
		hook.Call("PlayerRevived", nzRevive, self)
	end
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end