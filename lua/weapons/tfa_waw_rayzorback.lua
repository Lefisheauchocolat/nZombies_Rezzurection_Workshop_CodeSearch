local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "BO3 Razorback with parts from the Ray Gun kit bashed on. \nFrom the World at War custom map 'Nightclub' (any many others) by Reaper"
SWEP.Author = "Reaper, FlamingFox"
SWEP.Slot = 2
SWEP.PrintName = nzombies and "Rayzorback-118 | WAW" or "Rayzorback-118"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/rayzorback/c_rayzorback.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/rayzorback/w_rayzorback.mdl"
SWEP.HoldType = "smg"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -3,
        Right = 1,
        Forward = 13,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_WAW_RAYZOR.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO3_MK2.Shoot"
SWEP.Primary.SoundLyr2 = "TFA_BO2_RAYGUN.Flux1"
SWEP.Primary.Sound_DryFire = "TFA_BO2_RAYGUN.Deny"
SWEP.Primary.Sound_Blocked = "TFA_BO2_RAYGUN.Deny"
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 652
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 240 or 80
SWEP.Primary.DamageType = DMG_ENERGYBEAM
SWEP.Primary.Knockback = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_waw_muzzleflash_rayzorback"
SWEP.MuzzleFlashEffectSilenced = "tfa_bo3_muzzleflash_waffe"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true

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
SWEP.MainBullet = nzombies and nil or (SWEP.MainBullet or {})
SWEP.MainBullet.Distance = nzombies and nil or 4096 //overwrites TFA bullet range

SWEP.Primary.Range = nzombies and -1 or 4096
SWEP.Primary.RangeFalloff = nzombies and -1 or nil
SWEP.Primary.DisplayFalloff = nzombies and false or true
SWEP.DisplayFalloff = nzombies and false or true
SWEP.Primary.RangeFalloffLUT = nzombies and nil or {
	bezier = false, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "linear", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "hu", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = { -- providing zero point is not required
		-- without zero point it is considered to be as {range = 0, damage = 1}
		{range = 2048, damage = 1.0},
		{range = 4096, damage = 0.5},
	}
}

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
SWEP.Primary.StaticRecoilFactor	= 0.4

SWEP.Primary.SpreadMultiplierMax = 2.25
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(-2.865, -1, 0.66)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {battery = "115 Magazine"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 0.975
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""
SWEP.TracerName = "tfa_waw_tracer_rayzorback"
SWEP.ImpactDecal = "FadingScorch"
SWEP.TracerCount = 1

--[NZombies]--
SWEP.NZPaPName = "Epidemic Beacon"
SWEP.NZWonderWeapon = false
SWEP.Primary.MaxAmmo = 220
SWEP.NZHudIcon = Material("vgui/icon/zom_hud_icon_vril_combo.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/hud_lightning_bolt_64.png", "unlitgeneric smooth")

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self.Owner:SetAmmo( self.Primary_TFA.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary_TFA.ClipSize )

	self.Owner:SetAmmo( self.Secondary_TFA.MaxAmmo, self:GetSecondaryAmmoType() )
	self:SetClip2( self.Secondary_TFA.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.MuzzleFlashEffectPAP = "tfa_waw_muzzleflash_rayzorback_pap"
SWEP.Primary.ClipSizePAP = 30
SWEP.Primary.MaxAmmoPAP = 330
SWEP.Primary.DamagePAP = 210

function SWEP:OnPaP()
self.Ispackapunched = true

self.Secondary_TFA.ClipSize = 4
self.Secondary_TFA.MaxAmmo = 20

self.Primary_TFA.ClipSize = 30
self.Primary_TFA.MaxAmmo = 330
self.Primary_TFA.Damage = 460

self.MuzzleFlashEffect = "tfa_waw_muzzleflash_rayzorback_pap"
self.MuzzleFlashEffectSilenced = "tfa_bo3_muzzleflash_waffe_pap"
self.TracerName = "tfa_waw_tracer_rayzorback_pap"

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 36 / 30,
    [ACT_VM_RELOAD_EMPTY] = 36 / 30,
    [ACT_VM_RELOAD_SILENCED] = 36 / 30,
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
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagOut") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagIn") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagOut") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagIn") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.Twist") },
},
[ACT_VM_RELOAD_SILENCED] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagOut") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagIn") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.Twist") },
},
[ACT_VM_ATTACH_SILENCER] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagOut") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagIn") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.Start") },
{ ["time"] = 40 / 30, ["type"] = "lua", value = function(self)
	self:SetSparkler(true)
	self.Skin = self.Ispackapunched and 2 or 1
	self:SetSkin(self.Ispackapunched and 2 or 1)
	self:ApplyViewModelModifications()
end, client = true, server = true},
},
[ACT_VM_DETACH_SILENCER] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagOut") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.Stop") },
{ ["time"] = 50 / 30, ["type"] = "lua", value = function(self)
	self:SetSparkler(false)
	if CLIENT then
		self:CleanParticles()
	end
	if self:VMIV() then
		ParticleEffectAttach(self.Ispackapunched and "waw_rayzorback_vm_2" or "waw_rayzorback_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
	end
end, client = true, server = true},
{ ["time"] = 55 / 30, ["type"] = "lua", value = function(self)
	self.Skin = 0
	self:SetSkin(0)
	self:ApplyViewModelModifications()
end, client = true, server = true},
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.MagIn") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW_RAYZOR.Twist") },
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
		["MuzzleFlashEffect"] = 'tfa_waw_muzzleflash_rayzorback_pap',
		["MuzzleFlashEffectSilenced"] = 'tfa_bo3_muzzleflash_waffe_pap',
		["TracerName"] = 'tfa_waw_tracer_rayzorback_pap',
	},
}

SWEP.Secondary.Sound = "TFA_BO3_WAFFE.Shoot"
SWEP.Secondary.ClipSize = 3
SWEP.Secondary.DefaultClip = 15
SWEP.Secondary.AmmoConsumption = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "GaussEnergy"
SWEP.Secondary.RPM = 90
SWEP.Secondary.Damage = 115
SWEP.Secondary.MaxAmmo = 12

SWEP.StatCache_Blacklist = {
	["Skin"] = true,
	["Primary.Projectile"] = true,
	["Primary.ProjectileVelocity"] = true,
	["Primary.ProjectileModel"] = true,

	["Primary.KickUp"] = true,
	["Primary.KickDown"] = true,
	["Primary.KickHorizontal"] = true,

	["HoldType"] = true,

	["MuzzleFlashEffect"] = true,
	["MuzzleFlashEffectSilenced"] = true,
}

SWEP.CustomBulletCallback = function(attacker, trace, dmginfo)
	if trace and trace.Hit and not trace.HitSky then
		local ent = trace.Entity
		local wep = dmginfo:GetInflictor()

		ParticleEffect((IsValid(wep) and wep.Ispackapunched) and "waw_rayzorback_hit_2" or "waw_rayzorback_hit", trace.HitPos - trace.Normal, trace.HitNormal:Angle())
	end
end

DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local legacy_reloads_cv = GetConVar("sv_tfa_reloads_legacy")
local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")
local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "Sparkler")
end

function SWEP:GetSecondaryDelay()
	local rpm2 = self:GetStat("Secondary.RPM")
	if rpm2 and rpm2 > 0 then
		return 60 / rpm2
	end
end

function SWEP:DrawWorldModel(...)
	BaseClass.DrawWorldModel(self, ...)

	if self:GetSilenced() then
		self.Skin = self.Ispackapunched and 2 or 1
		self:SetSkin(self.Ispackapunched and 2 or 1)
	elseif self.Skin == 1 then
		self.Skin = 0
		self:SetSkin(0)
	end
end

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if self.GetSparkler and self:GetSparkler() then
		if !self.CL_FPDrawFX or !self.CL_FPDrawFX:IsValid() then
			self.CL_FPDrawFX = CreateParticleSystem(self.OwnerViewModel, self.Ispackapunched and "waw_rayzorback_vm_arcs_2" or "waw_rayzorback_vm_arcs", PATTACH_POINT_FOLLOW, 1)
		end
	elseif self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) then
		self.CL_FPDrawFX:StopEmission()
	end

	if !cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool()) then
		if self.Ispackapunched then
			vm:SetSubMaterial(0, self.nzPaPCamo)
			vm:SetSubMaterial(1, self.nzPaPCamo)
			vm:SetSubMaterial(2, self.nzPaPCamo)
			vm:SetSubMaterial(3, self.nzPaPCamo)
			vm:SetSubMaterial(4, self.nzPaPCamo)
			vm:SetSubMaterial(5, self.nzPaPCamo)
			vm:SetSubMaterial(6, self.nzPaPCamo)
			vm:SetSubMaterial(7, self.nzPaPCamo)
			vm:SetSubMaterial(8, self.nzPaPCamo)
			vm:SetSubMaterial(12, self.nzPaPCamo)
			vm:SetSubMaterial(13, self.nzPaPCamo)
		else
			vm:SetSubMaterial(0, nil)
			vm:SetSubMaterial(1, nil)
			vm:SetSubMaterial(2, nil)
			vm:SetSubMaterial(3, nil)
			vm:SetSubMaterial(4, nil)
			vm:SetSubMaterial(5, nil)
			vm:SetSubMaterial(6, nil)
			vm:SetSubMaterial(7, nil)
			vm:SetSubMaterial(8, nil)
			vm:SetSubMaterial(12, nil)
			vm:SetSubMaterial(13, nil)
		end
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end
	if self:GetSilenced() then return end

	local lyr1 = self:GetStatL("Primary.SoundLyr1")
	if lyr1 and ifp then
		self:EmitGunfireSound(lyr1)
	end

	local lyr2 = self:GetStatL("Primary.SoundLyr2")
	if lyr2 and ifp then
		self:EmitGunfireSound(lyr2)
	end

	if ply:IsNPC() then
		self.LastNPCRoll = math.random(30/GetConVar("skill"):GetInt())
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent.AttachNPCEffect = true
	ent:SetUpgraded(self.Ispackapunched)
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

	local stat = self:GetStatus()

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

	local ply = self:GetOwner()
	if ply:IsNPC() and self:GetSilenced() and self:Clip2() <= 0 then
		ply:SetSchedule(SCHED_HIDE_AND_RELOAD)
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

		self.Primary_TFA.Projectile         = "bo3_ww_wunderwaffe"
		self.Primary_TFA.ProjectileVelocity = 3500
		self.Primary_TFA.ProjectileModel    = "models/dav0r/hoverball.mdl"

		self:PrePrimaryAttack()
		if hook.Run("TFA_PrimaryAttack", self) then return end

		self:TriggerAttack("Secondary", 2)

		self:SetNextPrimaryFire(self:GetNextCorrectedPrimaryFire(self:GetSecondaryDelay()))

		self:PostPrimaryAttack()
		hook.Run("TFA_PostPrimaryAttack", self)

		self.Primary_TFA.Projectile         = nil
		self.Primary_TFA.ProjectileVelocity = nil
		self.Primary_TFA.ProjectileModel    = nil
		return
	end

	return BaseClass.PrimaryAttack(self, ...)
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

function SWEP:Think2(...)
	local ply = self:GetOwner()

	if SERVER then
		if IsValid(ply) and ply:IsNPC() and self.LastNPCRoll and (ply:IsCurrentSchedule(SCHED_RELOAD) or ply:IsCurrentSchedule(SCHED_HIDE_AND_RELOAD)) and self:GetNextPrimaryFire() < l_CT() then
			local npcseq = ply:GetSequence()
			if string.find(ply:GetSequenceActivityName(ply:GetSequence()), "_RELOAD") then
				local dur, id = ply:SequenceDuration(ply:GetSequence())
				if self:GetSilenced() then
					self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, dur - engine.TickInterval()*2)
					self:SetNextPrimaryFire(l_CT() + (dur - engine.TickInterval()*2))
				elseif self.LastNPCRoll == 1 then
					self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, dur - engine.TickInterval()*2)
					self:SetNextPrimaryFire(l_CT() + (dur - engine.TickInterval()*2))
				end
			end
		end
	end

	if self:GetStatus() == TFA.Enum.STATUS_SILENCER_TOGGLE and l_CT() >= self:GetStatusEnd() then
		if self:GetSilenced() then
			self:DetachWaveGun()
			//if sp then
				self:CallOnClient("DetachWaveGun", "")
			//end
		else
			self:AttachWaveGun()
			//if sp then
				self:CallOnClient("AttachWaveGun", "")
			//end
		end
	end

	BaseClass.Think2(self, ...)
end

function SWEP:AttachWaveGun()
	self.Primary_TFA.KickUp = 1
	self.Primary_TFA.KickDown = 1
	self.Primary_TFA.KickHorizontal = 0.25

	self.PrintName = "RZB-Sparker"
	self.NZPaPName = "EB-Electrocution"

	self.HoldType = "crossbow"

	local ply = self:GetOwner()
	if ply:IsNPC() then
		self:EmitSound("TFA_WAW_RAYZOR.Start")
		self:SetSparkler(true)
		self.Skin = self.Ispackapunched and 2 or 1
		self:SetSkin(self.Ispackapunched and 2 or 1)
		self:SetNextPrimaryFire(l_CT() + 1.2)
	end

	self:ClearStatCache()
end

function SWEP:DetachWaveGun()
	self.Primary_TFA.KickUp = 0.25
	self.Primary_TFA.KickDown = 0.2
	self.Primary_TFA.KickHorizontal = 0.15

	self.PrintName = nzombies and "Rayzorback-118 | WAW" or "Rayzorback-118"
	self.NZPaPName = "Epidemic Beacon"

	self.HoldType = "ar2"

	local ply = self:GetOwner()
	if ply:IsNPC() then
		self:EmitSound("TFA_WAW_RAYZOR.Stop")
		self:SetSparkler(false)
		self.Skin = 0
		self:SetSkin(0)
		self:SetNextPrimaryFire(l_CT() + 0.4)
	end

	self:ClearStatCache()
end