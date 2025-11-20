local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = "GKZ-45 Mk3"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/gkzmk3/c_gkzmk3.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/mk3/w_mk3.mdl"
SWEP.HoldType = "duel"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 0
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, -0.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1.5,
        Right = 1.2,
        Forward = 3.5,
        },
        Ang = {
		Up = 180,
        Right = 185,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_GKZ.Shoot"
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 95
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 800 or 90
SWEP.Primary.Knockback = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = 3
SWEP.Primary.DryFireDelay = 0.35
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
SWEP.Primary.Spread		  = .025
SWEP.Primary.IronAccuracy = .025
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.5
SWEP.Primary.KickDown			= 0.3
SWEP.Primary.KickHorizontal		= 0.25
SWEP.Primary.StaticRecoilFactor	= 0.45

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 2
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo3_ww_mk3" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 4000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/hunter/blocks/cube025x025x025.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.InspectPos = Vector(0, -2, -3)
SWEP.InspectAng = Vector(15, 0, 0)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 1)
SWEP.SafetyAng = Vector(-15, 0, 0)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Maelstrom of Eris"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 161
SWEP.Secondary.MaxAmmo = 161

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo(self.Primary.MaxAmmo, self:GetPrimaryAmmoType())
	self:SetClip1(self.Primary.ClipSize)
	self:GetOwner():SetAmmo(self.Secondary.MaxAmmo, self:GetSecondaryAmmoType())
	self:SetClip2(self.Secondary.ClipSize)
end

SWEP.Ispackapunched = false
SWEP.Primary.DamagePAP = nzombies and 11500 or 150
SWEP.Primary.ClipSizePAP = 5
SWEP.Primary.MaxAmmoPAP = 215
SWEP.Secondary.ClipSizePAP = 30
SWEP.Secondary.MaxAmmoPAP = 215

function SWEP:OnPaP()
self.Ispackapunched = true
self.Purpose = "Maelstrom of BluntStuffy"

self.Primary_TFA.Damage = 2000
self.Primary_TFA.ClipSize = 5
self.Primary_TFA.MaxAmmo = 215

self.Secondary_TFA.Damage = 2000
self.Secondary_TFA.ClipSize = 30
self.Secondary_TFA.MaxAmmo = 215
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 60 / 30,
    [ACT_VM_RELOAD2] = 60 / 30,
    [ACT_VM_RELOAD_DEPLOYED] = 60 / 30,
}
SWEP.SequenceLengthOverride = {
    [ACT_VM_RELOAD] = 95 / 30,
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK3.First") },
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GKZ.First") },
},
[ACT_VM_RELOAD2] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK3.Reload") },
},
[ACT_VM_RELOAD_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GKZ.Reload") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK3.Reload") },
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GKZ.Reload") },
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

SWEP.WElements = {
	--[Leftist]--
	["gun_left"] = { type = "Model", model = "models/weapons/tfa_bo3/gkzmk3/w_gkzmk3.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3, 1.5, 1), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = true, bodygroup = {} },
}

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

SWEP.Akimbo = true
SWEP.AnimCycle = 1
SWEP.CanBeSilenced = false

SWEP.Secondary.ClipSize = 15
SWEP.Secondary.DefaultClip = 90
SWEP.Secondary.AmmoConsumption = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Sound = "TFA_BO3_MK3.Shoot"
SWEP.Secondary.Ammo = SWEP.Primary.Ammo
SWEP.Secondary.RPM = 260
SWEP.Secondary.Damage = 800

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
}

SWEP.StatCache_Blacklist = {
	["Primary.Projectile"] = true,
	["Primary.ProjectileVelocity"] = true,
	["MuzzleFlashEffect"] = true,
}

DEFINE_BASECLASS( SWEP.Base )

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		vm:SetSubMaterial(5, "models/weapons/tfa_bo3/gkzmk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_lh_glow_mid_pap.vmt")
		vm:SetSubMaterial(3, "models/weapons/tfa_bo3/gkzmk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_lh_front_e_pap.vmt")
		vm:SetSubMaterial(6, "models/weapons/tfa_bo3/mk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_rh_front_pap.vmt")
		vm:SetSubMaterial(8, "models/weapons/tfa_bo3/gkzmk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_pap.vmt")
		vm:SetSubMaterial(13, "models/weapons/tfa_bo3/gkzmk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_rh_rear_off_pap.vmt")
		vm:SetSubMaterial(12, "models/weapons/tfa_bo3/mk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_rh_vents_pap.vmt")
		vm:SetSubMaterial(10, "models/weapons/tfa_bo3/gkzmk3/mtl_wpn_t7_zmb_dlc3_raygun_mk3_rh_rear_off_pap.vmt")
	else
		vm:SetSubMaterial(5, nil)
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(6, nil)
		vm:SetSubMaterial(8, nil)
		vm:SetSubMaterial(13, nil)
		vm:SetSubMaterial(12, nil)
		vm:SetSubMaterial(10, nil)
	end
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Int", "AkimboAttackValue")
end

function SWEP:FixAkimbo()
end

function SWEP:CycleSafety()
end

local l_CT = CurTime
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

function SWEP:Reload(...)
	if self:GetAnimCycle() == 0 then
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

	if self:AkimboReload() then
		if hook.Run("TFA_Reload", self) then return end
		typev, tanim = self:ChooseAnimation("reload")
	elseif self:GetAkimboAttackValue() == 0 then
		typev, tanim = self:ChooseAnimation("reload_rh")
	else
		if hook.Run("TFA_Reload", self) then return end
		typev, tanim = self:ChooseAnimation("reload_lh")
	end

	local fac = 1

	if self:GetStatL("LoopedReload") and self:GetStatL("LoopedReloadInsertTime") then
		fac = self:GetStatL("LoopedReloadInsertTime")
	end

	self:SetAnimCycle(self2.ViewModelFlip and 0 or 1)
	self2.AnimCycle = self:GetAnimCycle()

	return self.PlayChosenAnimation(self, typev, tanim, fac, fac ~= 1)
end

function SWEP:CompleteReload(...)
	if hook.Run("TFA_CompleteReload", self) then return end

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

function SWEP:GetSecondaryDelay()
	local rpm2 = self:GetStat("Secondary.RPM")
	if rpm2 and rpm2 > 0 then
		return 60 / rpm2
	end
end

function SWEP:SecondaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if ply:IsNPC() and self:Clip2() <= 0 then
		ply:SetSchedule(SCHED_RELOAD)
		return
	end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanSecondaryAttack() then return end

	self:PreSecondaryAttack()
	if hook.Run("TFA_PrimaryAttack", self) then return end

	self.Primary_TFA.Projectile = "bo3_ww_mk3"
	self.Primary_TFA.ProjectileVelocity = 4000
	self.MuzzleFlashEffect = self.Ispackapunched and "tfa_bo3_muzzleflash_mk3_pap" or "tfa_bo3_muzzleflash_mk3"

	self:ToggleAkimbo(true, 1)
	self:SetAkimboAttackValue(1)
	self:TriggerAttack("Secondary", 2)

	self:SetNextSecondaryFire(self2.GetNextCorrectedPrimaryFire(self, self2.GetSecondaryDelay(self)))

	self:PostSecondaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)
end

function SWEP:PrimaryAttack()
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if ply:IsNPC() and (math.random(50) <= 45 or IsValid(ply.GKZOrb)) then
		self:SecondaryAttack()
		return
	end

	if ply:IsNPC() and self:Clip1() <= 0 then
		ply:SetSchedule(SCHED_RELOAD)
		return
	end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end

	self:PrePrimaryAttack()
	if hook.Run("TFA_PrimaryAttack", self) then return end

	self.Primary_TFA.Projectile = "bo3_ww_gkz"
	self.Primary_TFA.ProjectileVelocity = 1400
	self.MuzzleFlashEffect = "tfa_bo3_muzzleflash_gkz"

	self:ToggleAkimbo(true, 0)
	self:SetAkimboAttackValue(0)
	self:TriggerAttack("Primary", 1)

	self:PostPrimaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)
end

function SWEP:ToggleAkimbo(override, val)
	if override then
		self:SetAnimCycle(val)
		self.AnimCycle = self:GetAnimCycle()
	end
end

local AttackSched = {
	[93] = true,
	[92] = true,
	[100] = true,
}

function SWEP:Think2(...)
	if not self:OwnerIsValid() then return BaseClass.Think2(self, ...) end

	local ply = self:GetOwner()
	if ply:IsNPC() and IsValid(ply.GKZOrb) and AttackSched[ply:GetCurrentSchedule()] then
		ply:PointAtEntity(ply.GKZOrb)
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:PostSecondaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end
	if ifp then
		self:EmitGunfireSound("TFA_BO3_MK3.Act")
		self:EmitGunfireSound("TFA_BO3_MK3.Decay")
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end
	if ifp then
		self:EmitGunfireSound("TFA_BO3_GKZ.Act")
		self:EmitGunfireSound("TFA_BO3_GKZ.Gears")
	end
end

local pos
function SWEP:PreSpawnProjectile(ent)
	local ply = self:GetOwner()

	if ply:IsPlayer() then
		if self:GetAkimboAttackValue() == 0 then
			pos = ply:GetShootPos() + (ply:GetRight() * -12)
		else
			pos = ply:GetShootPos() + (ply:GetRight() * 12)
		end

		ent:SetPos(pos)
	end

	ent:SetUpgraded(self.Ispackapunched)
end

function SWEP:PostSpawnProjectile(ent)
	local ply = self:GetOwner()
	local phys = ent:GetPhysicsObject()
	local vel = self:GetStatL("Primary.ProjectileVelocity")

	if ply:IsNPC() then
		if IsValid(phys) and IsValid(ply.GKZOrb) then
			phys:SetVelocity((ply.GKZOrb:GetPos() - ply:GetShootPos()):GetNormalized() * vel)
		end

		if self:GetAkimboAttackValue() == 0 then
			ply.GKZOrb = ent
		end
	end

	/*if ply:IsPlayer() then
		if self:GetAkimboAttackValue() == 0 then
			pos = ply:GetShootPos() + (ply:GetRight() * -12)
		else
			pos = ply:GetShootPos() + (ply:GetRight() * 12)
		end

		if IsValid(phys) then
			phys:SetVelocity((ply:GetEyeWorldTrace().HitPos - pos):GetNormalized() * vel)
		end
	end*/
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
	end
end
