local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 2
SWEP.PrintName = nzombies and "Zap Gun Dual Wield | BO3" or "Zap Gun Dual Wield"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/zapgun/c_zapgun.mdl"
SWEP.ViewModelCombined	= "models/weapons/tfa_bo3/zapgun/c_wavegun.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/zapgun/w_zapgun.mdl"
SWEP.WorldModelCombined	= "models/weapons/tfa_bo3/zapgun/w_wavegun.mdl"
SWEP.HoldType = "duel"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.MuzzleAttachmentSilenced = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -2,
        Right = 1,
        Forward = 4.5,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_ZAPGUN.Shoot"
SWEP.Primary.SilencedSound = "TFA_BO3_WAVEGUN.Shoot"
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 360
SWEP.Primary.RPM_Wave = 100
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 115
SWEP.Primary.Knockback = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 8
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= ""
SWEP.MuzzleFlashEffectSilenced = "tfa_bo3_muzzleflash_wavegun"
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
SWEP.ViewModelPunchPitchMultiplier = 0.3 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 1.5 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.5 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.15 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.3 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.1 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .015
SWEP.Primary.IronAccuracy = .005
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.5
SWEP.Primary.KickDown			= 0.3
SWEP.Primary.KickHorizontal		= 0.25
SWEP.Primary.StaticRecoilFactor	= 0.45

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 2
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 0
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-4, -4, 0.8)
SWEP.IronSightsAng = Vector(0, -1.2, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo3_ww_zapguns" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 3000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/hunter/blocks/cube025x025x025.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {battery = "#tfa.ammo.bo3ww.zapgun"}
SWEP.InspectPos = Vector(0, -2, -3)
SWEP.InspectAng = Vector(15, 0, 0)
SWEP.InspectPos_WAVE = Vector(10, -5, -2)
SWEP.InspectAng_WAVE = Vector(24, 42, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 1)
SWEP.SafetyAng = Vector(-15, 0, 0)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Porter's X2 Zap Gun Dual Wield"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 96
SWEP.Secondary.MaxAmmo = 12
SWEP.NZHudIcon = Material("vgui/icon/uie_t5hud_icon_grenade_launcher.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_wavegun_active.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_wavegun_active_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_wavegun_active_bw.png", "unlitgeneric smooth")

function SWEP:NZMaxAmmo()
	local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo
	local ammo_type2 = self:GetSecondaryAmmoType() or self.Secondary.Ammo

	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
		self:SetClip2( self.Secondary.ClipSize )

		self.Owner:SetAmmo( self.Secondary.MaxAmmo, ammo_type2 )
		self:SetClip3( self.Tertiary.ClipSize )
    end
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 18
SWEP.Secondary.ClipSizePAP = 18

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 18
self.Secondary_TFA.ClipSize = 18
self.Tertiary.ClipSize = 4
self:SetClip3(4)
self:SetMaxClip3(4)
self.Primary_TFA.MaxAmmo = 144
self.Secondary_TFA.MaxAmmo = 24
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 45 / 30,
    [ACT_VM_RELOAD2] = 45 / 30,
    [ACT_VM_RELOAD_DEPLOYED] = 45 / 30,
    [ACT_VM_RELOAD_SILENCED] = 80 / 30,
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_in", --Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
	}
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 10 / 25, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.RightEnd") },
{ ["time"] = 10 / 25, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.LeftEnd") },
},
[ACT_VM_DETACH_SILENCER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Seperate") },
},
[ACT_VM_ATTACH_SILENCER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Join") },
},
[ACT_VM_RELOAD_SILENCED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RifleStart") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RifleMagOut") },
{ ["time"] = 30 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RifleFutz") },
{ ["time"] = 70 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RifleMagIn") },
{ ["time"] = 100 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_WAVEGUN.RiflePower") },
},
[ACT_VM_RELOAD2] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.RightStart") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.RightMagIn") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.RightEnd") },
},
[ACT_VM_RELOAD_DEPLOYED] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.LeftStart") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.LeftMagIn") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.LeftEnd") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.RightStart") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.LeftStart") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.RightMagIn") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.LeftMagIn") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.RightEnd") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ZAPGUN.Reload.LeftEnd") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

SWEP.WElements = {
	--[Fakegun]--
	["gun_left"] = { type = "Model", model = "models/weapons/tfa_bo3/zapgun/w_zapgun_left.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(5, 1.5, 2), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = true, bodygroup = {} },
}

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.CylinderRadius = 180
SWEP.CylinderRange = 480

SWEP.Akimbo = true
SWEP.AnimCycle = 1
SWEP.CanBeSilenced = true

SWEP.Secondary.Sound = SWEP.Primary.Sound
SWEP.Secondary.ClipSize = SWEP.Primary.ClipSize
SWEP.Secondary.DefaultClip = SWEP.Primary.ClipSize * 2
SWEP.Secondary.AmmoConsumption = SWEP.Primary.AmmoConsumption
SWEP.Secondary.Automatic = SWEP.Primary.Automatic
SWEP.Secondary.Ammo = "AR2AltFire"
SWEP.Secondary.RPM = SWEP.Primary.RPM
SWEP.Secondary.Damage = SWEP.Primary.Damage

SWEP.Tertiary = {}
SWEP.Tertiary.Sound = "TFA_BO3_WAVEGUN.Shoot"
SWEP.Tertiary.ClipSize = 2
SWEP.Tertiary.DefaultClip = 12
SWEP.Tertiary.AmmoConsumption = 1
SWEP.Tertiary.Ammo = "AR2AltFire"
SWEP.Tertiary.RPM = 100
SWEP.Tertiary.Damage = 115
SWEP.Tertiary.MuzzleFlashEnabled = true
SWEP.Tertiary.DryFireDelay = 0.25

SWEP.Animations = {
	["reload_lh"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_RELOAD2
	},
	["reload_rh"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_RELOAD_DEPLOYED
	},
}

SWEP.SpeedColaActivities = {
	[ACT_VM_DRAW] = true,
	[ACT_VM_DRAW_EMPTY] = true,
	[ACT_VM_DRAW_SILENCED] = true,
	[ACT_VM_DRAW_DEPLOYED or 0] = true,
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
	[ACT_VM_HOLSTER] = true,
	[ACT_VM_HOLSTER_EMPTY] = true,
	[ACT_VM_HOLSTER_SILENCED] = true,
	[ACT_SHOTGUN_RELOAD_START] = true,
	[ACT_SHOTGUN_RELOAD_FINISH] = true,
	[ACT_VM_RELOAD2] = true,
	[ACT_VM_RELOAD_DEPLOYED] = true,
	[ACT_VM_ATTACH_SILENCER] = true,
	[ACT_VM_DETACH_SILENCER] = true,
}

SWEP.StatCache_Blacklist = {
	["Primary.Projectile"] = true,
	["Primary.ProjectileVelocity"] = true,
	["Primary.KickUp"] = true,
	["Primary.KickDown"] = true,
	["Primary.KickHorizontal"] = true,

	["Akimbo"] = true,
	["HoldType"] = true,
	["WElements"] = true,
	["data.ironsights"] = true,

	["InspectPos"] = true,
	["InspectAng"] = true,

	["MuzzleFlashEffect"] = true,
	["MuzzleFlashEffectSilenced"] = true,
}

DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local sp = game.SinglePlayer()
local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")
local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched and (!cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool())) then
		if self:GetSilenced() then
			vm:SetSubMaterial(0, self.nzPaPCamo)
			vm:SetSubMaterial(1, self.nzPaPCamo)
			vm:SetSubMaterial(2, self.nzPaPCamo)
			vm:SetSubMaterial(3, self.nzPaPCamo)
		else
			vm:SetSubMaterial(0, self.nzPaPCamo)
			vm:SetSubMaterial(1, self.nzPaPCamo)
			vm:SetSubMaterial(5, self.nzPaPCamo)
			vm:SetSubMaterial(6, self.nzPaPCamo)
		end
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(2, nil)
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(5, nil)
		vm:SetSubMaterial(6, nil)
	end
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Int", "AkimboAttackValue")
	self:NetworkVarTFA("Int", "Clip3")
	self:NetworkVarTFA("Int", "MaxClip3")

	self:NetworkVarTFA("Float", "NextTertiaryFire")
end

function SWEP:Initialize(...)
	self:SetClip3(self.Tertiary.ClipSize)
	self:SetMaxClip3(self.Tertiary.ClipSize)
	return BaseClass.Initialize(self, ...)
end

function SWEP:Clip3()
	return self:GetClip3()
end

function SWEP:Ammo3()
	local ply = self:GetOwner()
	if not IsValid(ply) then return false end
	if ply:IsNPC() then return 9999 end

	return ply:GetAmmoCount(self:GetSecondaryAmmoTypeC() or -1)
end

function SWEP:TakePrimaryAmmo(num, pool, ...)
	if self:GetSilenced() then
		if pool then
			if (self:Ammo3() <= 0) then return end
			if not self:GetOwner():IsPlayer() then return end
			self:GetOwner():RemoveAmmo(math.min(self:Ammo3(), num), self:GetSecondaryAmmoTypeC())

			return
		end

		self:SetClip3(math.max(self:Clip3() - num, 0))
		return
	end
	return BaseClass.TakePrimaryAmmo(self, num, pool, ...)
end

function SWEP:FixAkimbo()
end

function SWEP:CycleSafety()
end

function SWEP:CanSecondaryAttack()
	local self2 = self:GetTable()

	local v = hook.Run("TFA_PreCanPrimaryAttack", self)
	if v ~= nil then return v end

	stat = self:GetStatus()

	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		if self:GetStatL("LoopedReload") and TFA.Enum.ReloadStatus[stat] then
			self:SetReloadLoopCancel(true)
		end

		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:GetStatL("Secondary.ClipSize") <= 0 and self:Ammo1() < self:GetStatL("Secondary.AmmoConsumption") then
		return false
	end

	if self:GetPrimaryClipSize(true) > 0 and self:Clip2() < self:GetStatL("Secondary.AmmoConsumption") then
		return false
	end

	if self2.GetStatL(self, "Primary.FiresUnderwater") == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextSecondaryFire(l_CT() + 0.5)
		self:EmitSound(self:GetStatL("Primary.Sound_Blocked"))
		return false
	end

	self2.SetHasPlayedEmptyClick(self, false)

	if l_CT() < self:GetNextSecondaryFire() then return false end

	local v2 = hook.Run("TFA_CanPrimaryAttack", self)
	if v2 ~= nil then return v2 end

	return true
end

function SWEP:Think2(...)
	local ply = self:GetOwner()

	if ply:IsPlayer() and ply:KeyDown(IN_USE) and ply:KeyPressed(IN_RELOAD) and self:GetStatus() ~= TFA.Enum.STATUS_SILENCER_TOGGLE then
		if not self:GetSilenced() then
			local _, tanim, ttype = self:PlayAnimation(self:GetStat("BaseAnimations.silencer_attach"))
		else
			local _, tanim, ttype = self:PlayAnimation(self:GetStat("BaseAnimations.silencer_detach"))
		end
		self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, self:GetActivityLength(tanim))
		self:SetNextPrimaryFire(self.GetNextCorrectedPrimaryFire(self, self:GetActivityLength(tanim, true)+0.1))
	end

	if self:GetStatus() == TFA.Enum.STATUS_SILENCER_TOGGLE then
		if not self.Akimbo and self:GetSilenced() then
			self:DetachWaveGun()
			if sp then
				self:CallOnClient("DetachWaveGun", "")
			end
		end

		if CurTime() > self:GetStatusEnd() and not self:GetSilenced() then
			self:AttachWaveGun()
			if sp then
				self:CallOnClient("AttachWaveGun", "")
			end
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:AttachWaveGun()
	self.ViewModelKitOld = self.ViewModelKitOld or self.ViewModel
	self.WorldModelKitOld = self.WorldModelKitOld or self.WorldModel
	self.ViewModel = self:GetStat("ViewModelCombined") or self.ViewModel
	self.WorldModel = self:GetStat("WorldModelCombined") or self.WorldModel
	if IsValid(self.OwnerViewModel) then
		self.OwnerViewModel:SetModel(self.ViewModel)
		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:SendViewModelAnim(ACT_VM_IDLE)
		end)
	end

	//self:SetSilenced(false) --inverted for some reason
	//self.Silenced = self:GetSilenced()

	self.Primary_TFA.Projectile = "bo3_ww_wavegun"
	self.Primary_TFA.KickUp = 1.5
	self.Primary_TFA.KickDown = 1
	self.Primary_TFA.KickHorizontal = 0.5

	self.HoldType = "ar2"
	self.Akimbo = false
	self.WElements.gun_left.active = false
	self.data.ironsights = 1
	self.PrintName = "Wave Gun | BO3"
	self.NZPaPName = "Max Wave Gun"
	self.DrawCrosshair = false

	self.InspectPos = Vector(10, -5, -2)
	self.InspectAng = Vector(24, 42, 16)

	self:SetModel(self.WorldModel)
	self:SetNextIdleAnim(-1)
end

function SWEP:DetachWaveGun()
	if self.ViewModelKitOld then
		self.ViewModel = self.ViewModelKitOld
		if IsValid(self.OwnerViewModel) then
			self.OwnerViewModel:SetModel(self.ViewModel)
		end
		self.ViewModelKitOld = nil
	end
	if self.WorldModelKitOld then
		self.WorldModel = self.WorldModelKitOld
		self:SetModel(self.WorldModel)
		self.ViewModelKitOld = nil
	end

	//self:SetSilenced(true) --inverted for some reason
	//self.Silenced = self:GetSilenced()

	self.Primary_TFA.Projectile = "bo3_ww_zapguns"
	self.Primary_TFA.KickUp = 0.5
	self.Primary_TFA.KickDown = 0.3
	self.Primary_TFA.KickHorizontal = 0.25

	self.HoldType = "duel"
	self.Akimbo = true
	self.WElements.gun_left.active = true
	self.data.ironsights = 0
	self.PrintName = "Zap Gun Dual Wield | BO3"
	self.NZPaPName = "Porter's X2 Zap Gun Dual Wield"
	self.DrawCrosshair = true

	self.InspectPos = Vector(0, -2, -3)
	self.InspectAng = Vector(15, 0, 0)

	local _, tanim, ttype = self:PlayAnimation(self:GetStat("BaseAnimations.silencer_detach"))

	self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, self:GetActivityLength(tanim))
	self:SetNextPrimaryFire(self.GetNextCorrectedPrimaryFire(self, self:GetActivityLength(tanim, true)+0.1))
end

function SWEP:Reload(...)
	if self:GetSilenced() then
		return self:Reload3()
	elseif self:GetAnimCycle() == 0 then
		return BaseClass.Reload(self, ...)
	else
		return BaseClass.Reload2(self, ...)
	end
end

function SWEP:AkimboReload()
	return self:Clip1() < self:GetMaxClip1() and self:Clip2() < self:GetMaxClip2()
end

local typev, tanim
function SWEP:ChooseReloadAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return false, 0 end
	if self2.GetStatL(self, "IsProceduralReloadBased") then return false, 0 end

	if self:GetSilenced() then
		typev, tanim = self:ChooseAnimation("reload_silenced")
	elseif self:AkimboReload() then
		typev, tanim = self:ChooseAnimation("reload")
	elseif self:GetAkimboAttackValue() == 0 then
		typev, tanim = self:ChooseAnimation("reload_rh")
	else
		typev, tanim = self:ChooseAnimation("reload_lh")
	end

	local fac = 1

	self:SetAnimCycle(self2.ViewModelFlip and 0 or 1)
	self2.AnimCycle = self:GetAnimCycle()

	return self.PlayChosenAnimation(self, typev, tanim, fac, fac ~= 1)
end

function SWEP:CompleteReload(...)
	if hook.Run("TFA_CompleteReload", self) then return end

	if self:GetSilenced() then
		local maxclip = self:GetMaxClip3()
		local curclip = self:Clip3()
		local amounttoreplace = math.min(maxclip - curclip, self:Ammo3())
		self:TakePrimaryAmmo(amounttoreplace * -1)
		self:TakePrimaryAmmo(amounttoreplace, true)
		return
	end

	if self:Clip1() < self:GetMaxClip1() and self:Clip2() < self:GetMaxClip2() then
		local maxclip1 = self:GetMaxClip1()
		local curclip1 = self:Clip1()
		local amounttoreplace1 = math.min(maxclip1 - curclip1, self:Ammo1())
		self:TakePrimaryAmmo(amounttoreplace1 * -1)
		self:TakePrimaryAmmo(amounttoreplace1, true)

		local maxclip = self:GetMaxClip2()
		local curclip = self:Clip2()
		local amounttoreplace = math.min(maxclip - curclip, self:Ammo1())
		self:TakeSecondaryAmmo(amounttoreplace * -1)
		self:TakePrimaryAmmo(amounttoreplace, true)
		return
	end

	if self:GetAkimboAttackValue() == 1 then
		local maxclip = self:GetMaxClip2()
		local curclip = self:Clip2()
		local amounttoreplace = math.min(maxclip - curclip, self:Ammo1())
		self:TakeSecondaryAmmo(amounttoreplace * -1)
		self:TakePrimaryAmmo(amounttoreplace, true)
		return
	else
		return BaseClass.CompleteReload(self, ...)
	end
end

function SWEP:Reload3(released)
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	local isplayer = ply:IsPlayer()
	local vm = self:VMIV()

	if isplayer and not vm then return end

	if self:Ammo3() <= 0 then return end
	if self:GetStatL("Tertiary.ClipSize") < 0 then return end
	//if not released and not self:GetLegacyReloads() then return end
	if self:GetLegacyReloads() and not dryfire_cvar:GetBool() and not self:KeyDown(IN_RELOAD) then return end
	if self:KeyDown(IN_USE) then return end
	if hook.Run("TFA_Reload", self) then return end

	local ct = l_CT()
	local stat = self:GetStatus()

	if TFA.Enum.ReadyStatus[stat] or ( stat == TFA.Enum.STATUS_SHOOTING and self:CanInterruptShooting() ) then
		if self:Clip3() < self:GetMaxClip3() then
			if hook.Run("TFA_Reload", self) then return end

			local _, tanim, ttype = self:ChooseReloadAnim()

			self:SetStatus(TFA.Enum.STATUS_RELOADING)

			if self:GetStatL("IsProceduralReloadBased") then
				self:SetStatusEnd(ct + self:GetStatL("ProceduralReloadTime"))
			else
				self:SetStatusEnd(ct + self:GetActivityLength(tanim, true, ttype))
				self:SetNextPrimaryFire(ct + self:GetActivityLength(tanim, false, ttype))
			end

			if CLIENT then
				self2.ReloadAnimationStart = ct
				self2.ReloadAnimationEnd = ct + self:GetActivityLength(tanim, false, ttype)
			end

			if not sp or not self:IsFirstPerson() then
				ply:SetAnimation(PLAYER_RELOAD)
			end

			self:SetNextPrimaryFire( -1 )
		elseif released or self:KeyPressed(IN_RELOAD) then--if ply:KeyPressed(IN_RELOAD) or not self:GetLegacyReloads() then
			self:CheckAmmo()
		end
	end
end

function SWEP:CanTertiaryAttack()
	local self2 = self:GetTable()

	local v = hook.Run("TFA_PreCanPrimaryAttack", self)
	if v ~= nil then return v end

	local stat = self:GetStatus()

	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		if self:GetStatL("LoopedReload") and TFA.Enum.ReloadStatus[stat] then
			self:SetReloadLoopCancel(true)
		end

		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:Clip3() < self:GetStatL("Tertiary.AmmoConsumption") then
		return false
	end

	if self2.GetStatL(self, "Primary.FiresUnderwater") == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextPrimaryFire(l_CT() + 0.5)
		self:EmitSound(self:GetStatL("Primary.Sound_Blocked"))
		return false
	end

	self2.SetHasPlayedEmptyClick(self, false)

	if l_CT() < self:GetNextPrimaryFire() then return false end

	local v2 = hook.Run("TFA_CanPrimaryAttack", self)
	if v2 ~= nil then return v2 end

	return true
end

function SWEP:TertiaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanTertiaryAttack() then return end

	if hook.Run("TFA_PrimaryAttack", self) then return end

	self.Primary_TFA.ProjectileVelocity = 2000
	self.MuzzleFlashEffectSilenced = self.Ispackapunched and "tfa_bo3_muzzleflash_wavegun_pap" or "tfa_bo3_muzzleflash_wavegun"
	self:TriggerAttack("Tertiary", 3)
	self.Primary_TFA.ProjectileVelocity = 4000

	if ply:IsPlayer() and ply:KeyDown(IN_USE) then return end
	hook.Run("TFA_PostPrimaryAttack", self)
	self:MicrowaveCylinderDamage()
end

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function SWEP:MicrowaveCylinderDamage()
	local ply = self:GetOwner()

	local outer_range = self.CylinderRange
	local cylinder_radius = self.CylinderRadius

	local view_pos = ply:GetShootPos()
	local forward_view_angles = ply:IsPlayer() and ply:GetAimVector() or self:GetAimVector()
	local end_pos = view_pos + (forward_view_angles * outer_range)

	if shouldDisplayDebug() then
		local near_circle_pos = view_pos + (forward_view_angles*2)

		DLib.debugoverlay.Sphere(near_circle_pos, cylinder_radius, 5, Color(255, 0, 0, 255), true)
		DLib.debugoverlay.Line(near_circle_pos, end_pos, 5, Color(0, 0, 255, 255), true)
		DLib.debugoverlay.Sphere(end_pos, cylinder_radius, 5, Color(255, 0, 0, 255), true)
	end

	local outer_range_squared = outer_range * outer_range
	local cylinder_radius_squared = cylinder_radius * cylinder_radius

	if SERVER then
		for i, ent in pairs(ents.FindInSphere(view_pos, outer_range*1.1)) do
			if not (ent:IsNPC() or ent:IsNextBot()) then continue end
			if nzombies and ent.NZBossType then continue end
			if ent == ply then continue end
			if ent:Health() <= 0 then continue end
			if ent:BO3IsCooking() then continue end

			local test_origin = ent:WorldSpaceCenter()
			local test_range_squared = view_pos:DistToSqr(test_origin)
			if test_range_squared > outer_range_squared then
				if shouldDisplayDebug() then print('range') end
				continue // everything else in the list will be out of range
			end

			local normal = (test_origin - view_pos):GetNormalized()
			local dot = forward_view_angles:Dot(normal)
			if 0 > dot then
				if shouldDisplayDebug() then print('dot') end
				continue // guy's behind us
			end

			local radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin )
			if test_origin:DistToSqr(radial_origin) > cylinder_radius_squared then
				if shouldDisplayDebug() then print('cylinder') end
				continue // guy's outside the range of the cylinder of effect
			end

			local tr1 = util.TraceLine({
				start = view_pos,
				endpos = test_origin,
				filter = {self, ply},
				mask = MASK_SOLID_BRUSHONLY,
			})

			if tr1.HitWorld then
				if shouldDisplayDebug() then print(ent) print('cone') end
				continue // guy can't actually be hit from where we are
			end

			ent:BO3Microwave(math.Rand(3,4), ply, self)
		end
	end
end

function SWEP:GetSecondaryDelay()
	local rpm2 = self:GetStat("Secondary.RPM")
	if rpm2 and rpm2 > 0 then
		return 60 / rpm2
	end
end

function SWEP:SecondaryAttack(...)
	if self:GetSilenced() then
		return BaseClass.SecondaryAttack(self,...)
	end

	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanSecondaryAttack() then return end

	self:PreSecondaryAttack()
	if hook.Run("TFA_PrimaryAttack", self) then return end

	self.MuzzleFlashEffect = self.Ispackapunched and "tfa_bo3_muzzleflash_zapgun_pap" or "tfa_bo3_muzzleflash_zapgun_right"

	self:ToggleAkimbo(true, 1)
	self:SetAkimboAttackValue(1)
	self:TriggerAttack("Secondary", 2)

	self:SetNextSecondaryFire(self2.GetNextCorrectedPrimaryFire(self, self2.GetSecondaryDelay(self)))

	if ply:IsPlayer() and ply:KeyDown(IN_USE) then return end
	self:PostSecondaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)
end

function SWEP:PrimaryAttack(...)
	if self:GetSilenced() then
		return self:TertiaryAttack()
	end

	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if ply:IsNPC() and math.random(5) > 3 then
		self:SecondaryAttack()
		return
	end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end

	self:PrePrimaryAttack()
	if hook.Run("TFA_PrimaryAttack", self) then return end

	self.MuzzleFlashEffect = self.Ispackapunched and "tfa_bo3_muzzleflash_zapgun_pap" or "tfa_bo3_muzzleflash_zapgun_left"

	self:ToggleAkimbo(true, 0)
	self:SetAkimboAttackValue(0)
	self:TriggerAttack("Primary", 1)

	if ply:IsPlayer() and ply:KeyDown(IN_USE) then return end
	self:PostPrimaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)
end

function SWEP:ToggleAkimbo(override, val)
	if override then
		self:SetAnimCycle(val)
		self.AnimCycle = self:GetAnimCycle()
	end
end

function SWEP:PostPrimaryAttack()
	if self:GetSilenced() then return end

	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if not IsFirstTimePredicted() then return end

	self:EmitGunfireSound("TFA_BO3_ZAPGUN.ShootRear")
	if self:VMIV() then
		ParticleEffectAttach(self.Ispackapunched and "bo3_zapgun_vm_pap" or "bo3_zapgun_vm_left", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 4)
	end
end

function SWEP:PostSecondaryAttack()
	if self:GetSilenced() then return end

	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if not IsFirstTimePredicted() then return end

	self:EmitGunfireSound("TFA_BO3_ZAPGUN.ShootRear")
	if self:VMIV() then
		ParticleEffectAttach(self.Ispackapunched and "bo3_zapgun_vm_pap" or "bo3_zapgun_vm_right", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 3)
	end
end

local pos
function SWEP:PreSpawnProjectile(ent)
	local ply = self:GetOwner()

	if ply:IsPlayer() then
		if self:GetSilenced() then
			pos = ply:GetShootPos()
		else
			pos = ply:GetShootPos() + (ply:GetRight() * (self:GetAkimboAttackValue() == 0 and -12 or 12))
		end

		ent:SetPos(pos)
	end

	if not self:GetSilenced() then
		ent:SetAttackType(self:GetAkimboAttackValue())
	end

	ent:SetUpgraded(self.Ispackapunched)
end

/*function SWEP:PostSpawnProjectile(ent)
	local ply = self:GetOwner()
	local phys = ent:GetPhysicsObject()
	local vel = self:GetStat("Primary.ProjectileVelocity")

	if ply:IsPlayer() then
		if self:GetSilenced() then
			pos = ply:GetShootPos()
		else
			pos = ply:GetShootPos() + (ply:GetRight() * (self:GetAkimboAttackValue() == 0 and -15 or 15))
		end

		if IsValid(phys) then
			phys:SetVelocity((ply:GetEyeTrace().HitPos - pos):GetNormalized()*vel + VectorRand(-60,60))
		end
	end
end*/

function SWEP:Holster(...)
	if self:GetSilenced() and self:GetStatus() == TFA.Enum.STATUS_SILENCER_TOGGLE then return false end
	return BaseClass.Holster(self, ...)
end

local hudenabled_cvar = GetConVar("cl_tfa_hud_enabled")

local draw = draw
local cam = cam
local surface = surface
local render = render
local Vector = Vector
local Matrix = Matrix
local TFA = TFA
local math = math

local function ColorAlpha(color_in, new_alpha)
	if color_in.a == new_alpha then return color_in end
	return Color(color_in.r, color_in.g, color_in.b, new_alpha)
end

local targ, lactive = 0, -1
local targbool = false
local hudhangtime_cvar = GetConVar("cl_tfa_hud_hangtime")
local hudfade_cvar = GetConVar("cl_tfa_hud_ammodata_fadein")
local lfm, fm = 0, 0

--hehe funny replace the entire function to change 2 things :DDDDDD
function SWEP:DrawHUDAmmo()
	local self2 = self:GetTable()
	local stat = self2.GetStatus(self)

	if not hudenabled_cvar:GetBool() then return end

	fm = self:GetFireMode()
	targbool = (not TFA.Enum.HUDDisabledStatus[stat]) or fm ~= lfm
	targbool = targbool or (stat == TFA.Enum.STATUS_SHOOTING and self2.LastBoltShoot and l_CT() > self2.LastBoltShoot + self2.BoltTimerOffset)
	targbool = targbool or (self2.GetStatL(self, "PumpAction") and (stat == TFA.Enum.STATUS_PUMP or (stat == TFA.Enum.STATUS_SHOOTING and self:Clip1() == 0)))
	targbool = targbool or (stat == TFA.Enum.STATUS_FIDGET)

	targ = targbool and 1 or 0
	lfm = fm

	if targ == 1 then
		lactive = RealTime()
	elseif RealTime() < lactive + hudhangtime_cvar:GetFloat() then
		targ = 1
	elseif self:GetOwner():KeyDown(IN_RELOAD) then
		targ = 1
	end

	self2.CLAmmoProgress = math.Approach(self2.CLAmmoProgress, targ, (targ - self2.CLAmmoProgress) * RealFrameTime() * 2 / hudfade_cvar:GetFloat())

	local myalpha = 225 * self2.CLAmmoProgress
	if myalpha < 1 then return end
	local amn = self2.GetStatL(self, "Primary.Ammo")
	if not amn then return end
	if amn == "none" or amn == "" then return end
	--local mzpos = self:GetMuzzlePos()

	if self2.GetHidden(self) then return end

	local xx, yy

	local mzpos = self:GetOwner():ShouldDrawLocalPlayer() and self:GetAttachment(2) or self2.OwnerViewModel:GetAttachment(2)
	if mzpos then
		local pos = mzpos.Pos
		local ts = pos:ToScreen()

		xx, yy = ts.x, ts.y
	else
		xx, yy = ScrW() * .35, ScrH() * .6
	end

	local v, newx, newy, newalpha = hook.Run("TFA_DrawHUDAmmo", self, xx, yy, myalpha)
	if v ~= nil then
		if v then
			xx = newx or xx
			yy = newy or yy
			myalpha = newalpha or myalpha
		else
			return
		end
	end

	if self:GetInspectingProgress() < 0.01 and self2.GetStatL(self, "Primary.Ammo") ~= "" and self2.GetStatL(self, "Primary.Ammo") ~= 0 then
		local str, clipstr

		if self2.GetStatL(self, "Primary.ClipSize") and self2.GetStatL(self, "Primary.ClipSize") ~= -1 then
			clipstr = language.GetPhrase("tfa.hud.ammo.clip1")

			str = clipstr:format(self:Clip1())

			if (self:Clip1() > self2.GetStatL(self, "Primary.ClipSize")) then
				str = clipstr:format(self2.GetStatL(self, "Primary.ClipSize") .. " + " .. (self:Clip1() - self2.GetStatL(self, "Primary.ClipSize")))
			end

			draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			str = language.GetPhrase("tfa.hud.ammo.reserve1"):format(self2.Ammo1(self))
			yy = yy + TFA.Fonts.SleekHeight
			xx = xx - TFA.Fonts.SleekHeight / 3
			draw.DrawText(str, "TFASleekMedium", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleekMedium", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			yy = yy + TFA.Fonts.SleekHeightMedium
			xx = xx - TFA.Fonts.SleekHeightMedium / 3
		end

		str = string.upper(self:GetFireModeName() .. (#self2.GetStatL(self, "FireModes") > 2 and " | +" or ""))

		draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
		draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
		yy = yy + TFA.Fonts.SleekHeightSmall
		xx = xx - TFA.Fonts.SleekHeightSmall / 3

		if self2.GetStatL(self, "IsAkimbo") then
			local angpos2 = self:GetOwner():ShouldDrawLocalPlayer() and self:GetAttachment(1) or self2.OwnerViewModel:GetAttachment(1)

			if angpos2 then
				local pos2 = angpos2.Pos
				local ts2 = pos2:ToScreen()

				xx, yy = ts2.x, ts2.y
			else
				xx, yy = ScrW() * .35, ScrH() * .6
			end

			if self2.GetStatL(self, "Secondary.ClipSize") and self2.GetStatL(self, "Secondary.ClipSize") ~= -1 then
				clipstr = language.GetPhrase("tfa.hud.ammo.clip1")

				str = clipstr:format(self:Clip2())

				if (self:Clip2() > self2.GetStatL(self, "Secondary.ClipSize")) then
					str = clipstr:format(self2.GetStatL(self, "Secondary.ClipSize") .. " + " .. (self:Clip2() - self2.GetStatL(self, "Secondary.ClipSize")))
				end

				draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
				draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
				str = language.GetPhrase("tfa.hud.ammo.reserve1"):format(self2.Ammo2(self))
				yy = yy + TFA.Fonts.SleekHeight
				xx = xx - TFA.Fonts.SleekHeight / 3
				draw.DrawText(str, "TFASleekMedium", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
				draw.DrawText(str, "TFASleekMedium", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
				yy = yy + TFA.Fonts.SleekHeightMedium
				xx = xx - TFA.Fonts.SleekHeightMedium / 3
			end

			str = string.upper(self:GetFireModeName() .. (#self2.FireModes > 2 and " | +" or ""))
			draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
		end
		//if self:GetSilenced() then
			xx, yy = ScrW() * .5, ScrH() * .85

			local str, clipstr

			clipstr = language.GetPhrase("tfa.hud.ammo.clip1")

			str = clipstr:format(self:Clip3())

			if (self:Clip3() > self.Tertiary.ClipSize) then
				str = clipstr:format(self.Tertiary.ClipSize) .. " + " .. (self:Clip3() - self.Tertiary.ClipSize)
			end

			draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_CENTER)
			draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_CENTER)
			str = language.GetPhrase("tfa.hud.ammo.reserve1"):format(self:Ammo3())
			yy = yy + TFA.Fonts.SleekHeight
			xx = xx - TFA.Fonts.SleekHeight / 3
			draw.DrawText(str, "TFASleekMedium", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_CENTER)
			draw.DrawText(str, "TFASleekMedium", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_CENTER)
			yy = yy + TFA.Fonts.SleekHeightMedium
			xx = xx - TFA.Fonts.SleekHeightMedium / 3

			str = string.upper("Wave Gun")
			draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_CENTER)
			draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_CENTER)
		//end
	end
end

local crosshair_flamethrower = Material("vgui/overlay/hud_flamethrower_reticle.png", "smooth unlitgeneric")
local CMIX_MULT = 1
local c1t = {}
local c2t = {}

local function ColorMix(c1, c2, fac, t)
	c1 = c1 or color_white
	c2 = c2 or color_white
	c1t.r = c1.r
	c1t.g = c1.g
	c1t.b = c1.b
	c1t.a = c1.a
	c2t.r = c2.r
	c2t.g = c2.g
	c2t.b = c2.b
	c2t.a = c2.a

	for k, v in pairs(c1t) do
		if t == CMIX_MULT then
			c1t[k] = Lerp(fac, v, (c1t[k] / 255 * c2t[k] / 255) * 255)
		else
			c1t[k] = Lerp(fac, v, c2t[k])
		end
	end

	return Color(c1t.r, c1t.g, c1t.b, c1t.a)
end

local sv_tfa_fixed_crosshair = GetConVar("sv_tfa_fixed_crosshair")
local crossr_cvar = GetConVar("cl_tfa_hud_crosshair_color_r")
local crossg_cvar = GetConVar("cl_tfa_hud_crosshair_color_g")
local crossb_cvar = GetConVar("cl_tfa_hud_crosshair_color_b")
local crosscol = Color(255, 255, 255, 255)

function SWEP:DrawHUDBackground()
	if not self:GetSilenced() then return end
	local self2 = self:GetTable()
	local x, y
	
	local ply = LocalPlayer()
	if not ply:IsValid() or self:GetOwner() ~= ply then return false end

	if not ply.interpposx then
		ply.interpposx = ScrW() / 2
	end

	if not ply.interpposy then
		ply.interpposy = ScrH() / 2
	end

	local tr = {}
	tr.start = ply:GetShootPos()
	tr.endpos = tr.start + ply:GetAimVector() * 0x7FFF
	tr.filter = ply
	tr.mask = MASK_NPCSOLID
	local traceres = util.TraceLine(tr)
	local targent = traceres.Entity

	if self:GetOwner():ShouldDrawLocalPlayer() and not ply:GetNW2Bool("ThirtOTS", false) then
		local coords = traceres.HitPos:ToScreen()
		coords.x = math.Clamp(coords.x, 0, ScrW())
		coords.y = math.Clamp(coords.y, 0, ScrH())
		ply.interpposx = math.Approach(ply.interpposx, coords.x, (ply.interpposx - coords.x) * RealFrameTime() * 7.5)
		ply.interpposy = math.Approach(ply.interpposy, coords.y, (ply.interpposy - coords.y) * RealFrameTime() * 7.5)
		x, y = ply.interpposx, ply.interpposy
		-- Center of screen
	elseif sv_tfa_fixed_crosshair:GetBool() then
		x, y = ScrW() / 2, ScrH() / 2
	else
		tr.endpos = tr.start + self:GetAimAngle():Forward() * 0x7FFF
		local pos = util.TraceLine(tr).HitPos:ToScreen()
		x, y = pos.x, pos.y
	end

	local stat = self2.GetStatus(self)
	self2.clrelp = self2.clrelp or 0
	self2.clrelp = math.Approach(
		self2.clrelp,
		TFA.Enum.ReloadStatus[stat] and 0 or 1,
		((TFA.Enum.ReloadStatus[stat] and 0 or 1) - self2.clrelp) * RealFrameTime() * 7)

	local crossa = 255 * math.pow(math.min(1 - (((self2.IronSightsProgressUnpredicted2 or self:GetIronSightsProgress()) and
		not self2.GetStatL(self, "DrawCrosshairIronSights")) and (self2.IronSightsProgressUnpredicted2 or self:GetIronSightsProgress()) or 0),
		1 - self:GetSprintProgress(),
		1 - self:GetInspectingProgress(),
		self2.clrelp),
	2)

	teamcol = self2.GetTeamColor(self, targent)
	crossr = crossr_cvar:GetFloat()
	crossg = crossg_cvar:GetFloat()
	crossb = crossb_cvar:GetFloat()
	crosscol.r = crossr
	crosscol.g = crossg
	crosscol.b = crossb
	crosscol.a = crossa
	crosscol = ColorMix(crosscol, teamcol, 1, CMIX_MULT)
	crossr = crosscol.r
	crossg = crosscol.g
	crossb = crosscol.b
	crossa = crosscol.a

	surface.SetDrawColor(crossr, crossg, crossb, crossa)
	surface.SetMaterial(crosshair_flamethrower)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 24, y  - 24, 48, 48)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 24, ScrH() / 2 - 24, 48, 48)
	end
end
