local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Model ported by JBird632. Animated by Rollonmath42. Originally scripted by AwesomePieMan. \nFrom the World At War custom map 'Snowglobe' by JBird632"
SWEP.Author = "JBird632, Rollonmath42, AwesomePieMan, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Photon Ionizer | WAW" or "Photon Ionizer"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/xray/c_xray.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/xray/w_xray.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -6,
        Right = 1.2,
        Forward = 13,
        },
        Ang = {
		Up = 0,
        Right = 170,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_WAW_XRAY.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_WAW_XRAY.Act"
SWEP.Primary.SilencedSound = "TFA_WAW_XRAY.Blast"
SWEP.Primary.SilencedSoundLyr1 = "TFA_WAW_XRAY.Blast.Act"
SWEP.Primary.Sound_DryFire = "TFA_BO2_RAYGUN.Deny"
SWEP.Primary.Sound_Blocked = "TFA_BO2_RAYGUN.Deny"
SWEP.Primary.Ammo = "Uranium"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 550
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 220 or 40
SWEP.Primary.DamageType = DMG_ENERGYBEAM
SWEP.Primary.PenetrationPower = 0
SWEP.Primary.Knockback = 4
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_waw_muzzleflash_xray"
SWEP.MuzzleFlashEffectSilenced	= "tfa_waw_muzzleflash_xray"
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
SWEP.ViewModelPunchPitchMultiplier = 0.5 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 3 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .01
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.25
SWEP.Primary.KickDown			= 0.2
SWEP.Primary.KickHorizontal		= 0.15
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 2.5
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(-2.76, -1, 0.25)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.35

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""
SWEP.TracerName = "tfa_waw_tracer_xray"
SWEP.ImpactDecal = "FadingScorch"
SWEP.TracerCount = 1

--[NZombies]--
SWEP.NZPaPName = "Xmas-Xray"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 180
SWEP.Secondary.MaxAmmo = 12
SWEP.NZHudIcon = Material("vgui/icon/hud_xray_shot.png", "unlitgeneric smooth")

SWEP.StoredHudIcon = Material("vgui/icon/hud_xray_shot.png", "unlitgeneric smooth")
SWEP.StoredHudIconPaP = Material("vgui/icon/hud_xray_shot_up.png", "unlitgeneric smooth")
SWEP.StoredHudIconSil = Material("vgui/icon/hud_xray_blast.png", "unlitgeneric smooth")
SWEP.StoredHudIconSilPaP = Material("vgui/icon/hud_xray_blast_up.png", "unlitgeneric smooth")

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:GetOwner():SetAmmo( self.Secondary.MaxAmmo, self:GetSecondaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
	self:SetClip2( self.Secondary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.MuzzleFlashEffectPAP = "tfa_waw_muzzleflash_xmas"
SWEP.TracerNamePAP = "tfa_waw_tracer_xmas"
SWEP.Primary.ClipSizePAP = 45
SWEP.Primary.DamagePAP = 60

function SWEP:OnPaP()
self.Ispackapunched = true
self.Secondary_TFA.ClipSize = 8
self.Secondary_TFA.MaxAmmo = 24
self.Primary_TFA.ClipSize = 45
self.Primary_TFA.MaxAmmo = 270
self.Primary_TFA.Damage = 440
self.MuzzleFlashEffect = "tfa_waw_muzzleflash_xmas"
self.MuzzleFlashEffectSilenced	= "tfa_waw_muzzleflash_xmas"
self.TracerName = "tfa_waw_tracer_xmas"
self.NZHudIcon = self.StoredHudIconPaP
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 78 / 45,
    [ACT_VM_RELOAD_SILENCED] = 78 / 45,
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
{ ["time"] = 1 / 20, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 20, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 20, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 20, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_ATTACH_SILENCER] = {
{ ["time"] = 30 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_XRAY.Tap") },
{ ["time"] = 35 / 40, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MICROWAVE.Rifle.End") },
},
[ACT_VM_DETACH_SILENCER] = {
{ ["time"] = 30 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_XRAY.Tap") },
{ ["time"] = 35 / 40, ["type"] = "sound", ["value"] = Sound("TFA_BO1_MICROWAVE.Rifle.End") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 30 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_XRAY.Tap") },
{ ["time"] = 30 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_XRAY.MagOut") },
{ ["time"] = 35 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO2_RAYGUN.Open") },
{ ["time"] = 70 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_XRAY.MagIn") },
{ ["time"] = 70 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO2_RAYGUN.Close") },
},
[ACT_VM_RELOAD_SILENCED] = {
{ ["time"] = 30 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_XRAY.Tap") },
{ ["time"] = 30 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_XRAY.MagOut") },
{ ["time"] = 35 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO2_RAYGUN.Open") },
{ ["time"] = 70 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_XRAY.MagIn") },
{ ["time"] = 70 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO2_RAYGUN.Close") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

SWEP.CanBeSilenced = true
SWEP.Silenced = false

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.AttachmentTableOverride = {
	["bo3_packapunch"] = {
		["MuzzleFlashEffect"] = 'tfa_waw_muzzleflash_xmas',
		["MuzzleFlashEffectSilenced"] = 'tfa_waw_muzzleflash_xmas',
		["TracerName"] = 'tfa_waw_tracer_xmas',
	},
}

SWEP.Secondary.Sound = "TFA_WAW_XRAY.Blast"
SWEP.Secondary.ClipSize = 4
SWEP.Secondary.DefaultClip = 12
SWEP.Secondary.AmmoConsumption = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "GaussEnergy"
SWEP.Secondary.RPM = 90
SWEP.Secondary.Damage = 115

SWEP.CustomBulletCallback = function(ply, tr, dmg)
	if CLIENT then return end
	local ent = tr.Entity
	local wep = dmg:GetInflictor()
	if IsValid(ent) and ent:Health() > 0 and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) and IsValid(wep) and wep:GetSilenced() then
		if ent:IsPlayer() and
		(nzombies or !pvp_bool:GetBool() or (ent == ply) or !hook.Run("PlayerShouldTakeDamage", ent, ply))
		then return end

		if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "zombie_boss")) then
			dmg:SetDamage(math.max(600, ent:GetMaxHealth()/12))
			return
		end

		dmg:SetDamageForce(vector_origin)
		dmg:SetDamage(1)

		if wep.Ispackapunched then
			if !ent:WAWIsXmasInfected() then
				ent:WAWXmasInfect(1.5, ply, wep)
			end
		else
			if !ent:WAWIsXrayInfected() then
				ent:WAWXrayInfect(1.5, ply, wep)
			end
		end
	end
end

DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local legacy_reloads_cv = GetConVar("sv_tfa_reloads_legacy")
local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")

function SWEP:GetSecondaryDelay()
	local rpm2 = self:GetStat("Secondary.RPM")
	if rpm2 and rpm2 > 0 then
		return 60 / rpm2
	end
end

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if self.Ispackapunched then
		self.Skin = 1
		self:SetSkin(1)
	else
		self.Skin = 0
		self:SetSkin(0)
	end

	vm:SetSubMaterial(0, nil)
end

function SWEP:DrawWorldModel(...)
	BaseClass.DrawWorldModel(self, ...)

	if self.Ispackapunched then
		self.Skin = 1
		self:SetSkin(1)
	elseif self.Skin == 1 then
		self.Skin = 0
		self:SetSkin(0)
	end
end

function SWEP:Think2(...)
	if self:GetStatus() == TFA.Enum.STATUS_SILENCER_TOGGLE and CurTime() > self:GetStatusEnd() then
		if self:GetSilenced() then
			self.NZHudIcon = self.Ispackapunched and self.StoredHudIconPaP or self.StoredHudIcon
		else
			self.NZHudIcon = self.Ispackapunched and self.StoredHudIconSilPaP or self.StoredHudIconSil
		end
	end

	BaseClass.Think2(self, ...)
end

local function Dryfire(self, self2, reload)
	if not dryfire_cvar:GetBool() and reload then
		self:Reload(true)
	end

	if self2.GetHasPlayedEmptyClick(self) then return end

	self2.SetHasPlayedEmptyClick(self, true)

	if SERVER and self:GetStatL("Primary.SoundHint_DryFire") then
		sound.EmitHint(SOUND_COMBAT, self:GetPos(), 500, 0.2, self:GetOwner())
	end

	if self:GetOwner():IsNPC() or self:KeyPressed(IN_ATTACK) then
		local enabled, tanim, ttype = self:ChooseDryFireAnim()

		if enabled then
			self:SetNextPrimaryFire(l_CT() + self:GetStatL("Primary.DryFireDelay", self:GetActivityLength(tanim, true, ttype)))
			return
		end
	end

	if IsFirstTimePredicted() then
		self:EmitSound(self:GetStatL("Primary.Sound_DryFire"))
	end
end

function SWEP:CanSecondaryAttack()
	local self2 = self:GetTable()

	local v = hook.Run("TFA_PreCanPrimaryAttack", self)

	if v ~= nil then
		return v
	end

	stat = self:GetStatus()

	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		if self:GetStatL("LoopedReload") and TFA.Enum.ReloadStatus[stat] then
			self:SetReloadLoopCancel(true)
		end

		return false
	end

	if self:IsSafety() then
		if IsFirstTimePredicted() then
			self:EmitSound(self:GetStatL("Primary.Sound_DrySafety"))

			if SERVER and self:GetStatL("Primary.SoundHint_DryFire") then
				sound.EmitHint(SOUND_COMBAT, self:GetPos(), 200, 0.2, self:GetOwner())
			end
		end

		if l_CT() < self:GetLastSafetyShoot() + 0.2 then
			self:CycleSafety()
			-- self:SetNextPrimaryFire(l_CT() + 0.1)
		end

		self:SetLastSafetyShoot(l_CT() + 0.2)

		return
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:GetStatL("Primary.ClipSize") <= 0 and self:Ammo2() < self:GetStatL("Secondary.AmmoConsumption") then
		Dryfire(self, self2)
		return false
	end

	if self:GetSecondaryClipSize(true) > 0 and self:Clip2() < self:GetStatL("Secondary.AmmoConsumption") then
		Dryfire(self, self2, true)
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

	if v2 ~= nil then
		return v2
	end

	if self:CheckJammed() then
		if IsFirstTimePredicted() then
			self:EmitSound(self:GetStatL("Primary.Sound_Jammed"))
		end

		local typev, tanim = self:ChooseAnimation("shoot1_empty")

		if typev ~= TFA.Enum.ANIMATION_SEQ then
			self:SendViewModelAnim(tanim)
		else
			self:SendViewModelSeq(tanim)
		end

		self:SetNextPrimaryFire(l_CT() + 1)

		return false
	end

	return true
end

function SWEP:PrimaryAttack(...)
	if self:GetSilenced() then
		local ply = self:GetOwner()
		if not IsValid(ply) then return end
		if ply:IsPlayer() and not self:VMIV() then return end
		if not self:CanSecondaryAttack() then return end

		self:PrePrimaryAttack()
		if hook.Run("TFA_PrimaryAttack", self) then return end

		self:TriggerAttack("Secondary", 2)

		self:SetNextPrimaryFire(self:GetNextCorrectedPrimaryFire(self:GetSecondaryDelay()))

		self:PostPrimaryAttack()
		hook.Run("TFA_PostPrimaryAttack", self)
		return
	end

	return BaseClass.PrimaryAttack(self, ...)
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	if self:GetSilenced() then
		local lyrs = self:GetStatL("Primary.SilencedSoundLyr1")
		if lyrs and ifp then
			self:EmitGunfireSound(lyrs)
		end
	else
		local lyr = self:GetStatL("Primary.SoundLyr1")
		if lyr and ifp then
			self:EmitGunfireSound(lyr)
		end
	end
end

function SWEP:Reload(...)
	if self:GetSilenced() then
		return BaseClass.Reload2(self, ...)
	end
	return BaseClass.Reload(self, ...)
end

function SWEP:CompleteReload(...)
	if hook.Run("TFA_CompleteReload", self) then return end

	if self:GetSilenced() then
		local maxclip = self:GetMaxClip2()
		local curclip = self:Clip2()
		local amounttoreplace = math.min(maxclip - curclip, self:Ammo2())
		self:TakeSecondaryAmmo(amounttoreplace * -1)
		self:TakeSecondaryAmmo(amounttoreplace, true)
		return
	end

	return BaseClass.CompleteReload(self, ...)
end
