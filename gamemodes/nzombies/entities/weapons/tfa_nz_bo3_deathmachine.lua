local nzombies = engine.ActiveGamemode() == "nzombies"
--[[
	This is a modified version of FlamingFox's BO3 Deathmachine to actually work properly within the nZ gamemode.
	The added bonus is that it no longer yoinks your weapon when you go to dequip the Deathmachine.
]]

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.71
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Wonder Weapon"
SWEP.Purpose = "BO1 Deathmachine with an updated look by JBird632"
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "Death Machine | BO3" or "Death Machine"
SWEP.AutoSwitchTo	= true
SWEP.AutoSwitchFrom	= false
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.NZPreventBox = true
SWEP.NZTotalBlacklist = true
SWEP.NZSpecialCategory = "display" --this makes it count as special, as well as what category it replaces
--(display is generic stuff that should only be carried temporarily and never holstered and kept)

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/deathmachine/c_deathmachine.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/deathmachine/w_deathmachine.mdl"
SWEP.HoldType = "physgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -3,
        Right = 4,
        Forward = -8,
        },
        Ang = {
		Up = 10,
        Right = 175,
        Forward = -20
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = Sound("TFA_BO3_M134.Stop")
SWEP.Primary.LoopSound = Sound("TFA_BO3_M134.Loop")
SWEP.Primary.LoopSoundTail = Sound("TFA_BO3_M134.Stop")
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1666
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 575 -- Base damage multiplied by the Round's Zombie Health. This ensures the Deathmachine ALWAYS kills.
SWEP.Primary.Knockback = 5
SWEP.Primary.NumShots = 3
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 350
SWEP.Primary.DryFireDelay = 0.5
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0.33 --0.33
SWEP.LowAmmoSound = nil
SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.09 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 2.0 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.25 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.25 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.65 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Spread Related]--
SWEP.Primary.Spread		  = .035
SWEP.Primary.IronAccuracy = .035
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.1
SWEP.Primary.KickDown			= 0.1
SWEP.Primary.KickHorizontal		= 0.15
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = true
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = "models/tfa/rifleshell.mdl"
SWEP.LuaShellScale = 0.5
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = true

--[Misc]--
SWEP.InspectPos = Vector(-1, -6, -3)
SWEP.InspectAng = Vector(20, 5, 0)
SWEP.MoveSpeed = 1.00 -- 0.85
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)

--[NZombies]--
SWEP.NZPaPName = "Flesh Ripper"
SWEP.NZWonderWeapon = false
SWEP.Primary.MaxAmmo = 999

function SWEP:NZMaxAmmo()
	if SERVER then
		self:GetOwner():SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
		self:SetClip1( self.Primary.ClipSize )
	end
end

SWEP.Ispackapunched = false
SWEP.Primary.DefaultClipPAP = 1666
SWEP.Primary.MaxAmmoPAP = 1666

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.DefaultClip = 1666
self.Primary_TFA.MaxAmmo = 1666
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
}

SWEP.RunSightsPos = Vector(1, -3, 3)
SWEP.RunSightsAng = Vector(-15, 30, 5)

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_M134.Raise") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_M134.Raise") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

SWEP.ViewModelBoneMods = {
	["tag_barrel_spin"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.SpinSpeed = 1
SWEP.SpinAng = 0

DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local sp = game.SinglePlayer()

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("Float", "SpinTime")

	self:NetworkVarTFA("Bool", "IsSpinning")
	self:NetworkVarTFA("Bool", "HasEmitSound")
end

function SWEP:CanPrimaryAttack(...)
	if self:GetSpinTime() < 1 then
		return false
	end
    return BaseClass.CanPrimaryAttack(self,...)
end

function SWEP:CanSpinUp()
    stat = self:GetStatus()

    if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:IsSafety() then
		return false
	end

    return true
end

function SWEP:Think2(...)
	local status = self:GetStatus()
	local ply = self:GetOwner()
	self.WepOwner = self.Owner

	if CLIENT then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			self.SpinSpeed = math.Approach(self.SpinSpeed, 20, 1)
		end
		self:DoSpin()
	end

	if CLIENT and sp then
        return BaseClass.Think2(self,...)
	end

	if IsValid(ply) then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			if not self:GetIsSpinning() then
				if IsFirstTimePredicted() then self:EmitSoundNet("TFA_BO3_M134.SpinStart") end
			end

			self:SetIsSpinning(true) 
		else
			if l_CT() > self:GetNextPrimaryFire() or self.Primary.Automatic then
				if self:GetIsSpinning() then
					if IsFirstTimePredicted() then self:EmitSoundNet("TFA_BO3_M134.SpinStop") end
				end
				self:SetIsSpinning(false)
			end
		end
		if self:GetIsSpinning() then
			self:SetSpinTime(self:GetSpinTime() + (FrameTime() / 0.4))

			if self:GetSpinTime() >= 1 then
				self:EmitSoundNet("TFA_BO3_M134.SpinLoop")

				if not (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) then
					self:SetIsSpinning(false)
				end
			end 
		else
			self:SetSpinTime(0)
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:DoSpin()
	if not CLIENT then return end
	if not sp and not IsFirstTimePredicted() then return end

	self.SpinAng = self.SpinAng or 0
	self.SpinSpeed = self.SpinSpeed or 10
		
	if self.SpinAng > 7200 then
		self.SpinAng = -7200
	end
	
	self.SpinAng = self.SpinAng - self.SpinSpeed

	if self.SpinSpeed > 0 then
		self.SpinSpeed = self.SpinSpeed * 0.95
	elseif self.SpinSpeed < 0 then
		self.SpinSpeed = 0
	end
	self.ViewModelBoneMods["tag_barrel_spin"].angle = Angle(0, 0, -self.SpinAng)
end

function SWEP:OnDrop(...)
	self:StopSound("TFA_BO3_M134.SpinLoop")
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_BO3_M134.SpinLoop")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSound("TFA_BO3_M134.SpinLoop")
	return BaseClass.Holster(self,...)
end

function SWEP:NZSpecialHolster(wep)
	if IsValid(self.Owner) then
		print(self.Owner, self.WepOwner)
		self:StopSound("TFA_BO3_M134.SpinLoop")
		-- As it stands right now... Loosing the Deathmachine while firing causes the firing sound to continue playing. Use "stopsound" in console or shoot another gun and it should stop.
		self.Owner:RemovePowerUp("deathmachine", false)
	end
		
	return true
end
	
--[[function SWEP:Equip(owner)
	owner:SetActiveWeapon("tfa_nz_bo3_deathmachine")
	
	--let's not call a meta function every damn shot
	SWEP.Primary.Damage = 100 * (nzRound:GetZombieHealth() or 75)
	self:ClearStatCache()
end]]

function SWEP:OnRemove()
	if not IsValid(self.WepOwner:GetActiveWeapon()) or not self.WepOwner:GetActiveWeapon():IsSpecial() then self.WepOwner:SetUsingSpecialWeapon(false) end
		
	self.WepOwner:SetActiveWeapon(nil) -- Despite what it may seem... This nil is actually intentional, so no need to worry if an error relating to this appears.
	self.WepOwner:EquipPreviousWeapon()
end