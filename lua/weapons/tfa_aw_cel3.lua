local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Advanced Warfare"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "CEL-3 Cauterizer | AW" or "CEL-3 Cauterizer"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_aw/cel3/c_cel3.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_aw/cel3/w_cel3.mdl"
SWEP.HoldType = "shotgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -6,
        Right = 1,
        Forward = 14,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_AW_CEL3.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_AW_CEL3.Boom"
SWEP.Primary.SoundLyr2 = "TFA_AW_CEL3.Snap"
SWEP.Primary.Ammo = "BuckShot"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = nzombies and 180 or 50
SWEP.Primary.PenetrationPower = 0
SWEP.Primary.NumShots = 8
SWEP.Primary.Knockback = 0
SWEP.Primary.ClipSize = 16
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.Delay = 0.3
SWEP.MuzzleFlashEffect	= "tfa_aw_muzzleflash_cel3"
SWEP.TracerName = "tfa_aw_tracer_cel3"
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
SWEP.Primary.DisplayFalloff = false
SWEP.Primary.RangeFalloffLUT = {
	bezier = false, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "linear", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "hu", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = { -- providing zero point is not required
		-- without zero point it is considered to be as {range = 0, damage = 1}
		{range = 15, damage = 1},
		{range = 30, damage = 0.6},
	}
}

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.5 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 2 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .1
SWEP.Primary.IronAccuracy = .05
SWEP.IronRecoilMultiplier = 0.7
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 1
SWEP.Primary.KickDown			= 1
SWEP.Primary.KickHorizontal		= 0.6
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 4
SWEP.Primary.SpreadRecovery = 2

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-4.33, -2, 0.175)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.3

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.TracerCount = 1

--[NZombies]--
SWEP.NZPaPName = "CEL-3 Deatomizer"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 80

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self.Owner:SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.MuzzleFlashEffectPAP = "tfa_aw_muzzleflash_cel3_pap"
SWEP.TracerNamePAP = "tfa_aw_tracer_cel3_pap"
SWEP.Primary.ClipSizePAP = 24
SWEP.Primary.MaxAmmoPAP = 120
SWEP.Primary.DamagePAP = 80

function SWEP:OnPaP()
self.Ispackapunched = true

self.Primary_TFA.ClipSize = 24
self.Primary_TFA.MaxAmmo = 120
self.Primary_TFA.Damage = 300

self.Skin = 1
self:SetSkin(1)

self.MuzzleFlashEffect = "tfa_aw_muzzleflash_cel3_pap"
self.TracerName = "tfa_aw_tracer_cel3_pap"

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 40 / 30,
	[ACT_VM_RELOAD_EMPTY] = 50 / 30,
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_in", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_in_empty", --Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_loop_empty", --Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_out_empty", --Number for act, String/Number for sequence
	}
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Pullout") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Rechamber") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Rechamber.Fins") },
},
[ACT_VM_PRIMARYATTACK_1] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Rechamber") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Rechamber.Fins") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload1") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload2") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload3") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload4") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload5") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload1a") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload1") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload2") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload3") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload4") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_CEL3.Reload5") },
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

//SWEP.Glow = Material("models/weapons/tfa_aw/cel3/mtl_fusion_shotgun_exhaust.vmt")

//SWEP.FinGlow1 = Material("models/weapons/tfa_aw/cel3/mtl_fusion_shotgun_fin1.vmt")
//SWEP.FinGlow2 = Material("models/weapons/tfa_aw/cel3/mtl_fusion_shotgun_fin2.vmt")
//SWEP.FinGlow3 = Material("models/weapons/tfa_aw/cel3/mtl_fusion_shotgun_fin3.vmt")
//SWEP.FinGlow4 = Material("models/weapons/tfa_aw/cel3/mtl_fusion_shotgun_fin4.vmt")
SWEP.glow1 = 0
SWEP.glow2 = 0
SWEP.glow3 = 0
SWEP.glow4 = 0

--[Attachments]--
SWEP.Attachments = {
	[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.CustomBulletCallback = function(attacker, trace, dmginfo)
	if trace then
		sound.Play("weapons/tfa_aw/cel3/wpn_cauterizer_zap_0"..math.random(5)..".wav", trace.HitPos + trace.HitNormal, SNDLVL_IDLE, math.random(97,103), 0.25)
	end
end

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local ct = CurTime
local pap_vec = Vector(3, 0.95, 4)
local norm_vec = Vector(6, 0.2, 0)

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Float", "GlowRatio")
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

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	vm:SetSubMaterial(0, nil)
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local lyr1 = self:GetStat("Primary.SoundLyr1")
	if lyr1 and ifp then
		self:EmitGunfireSound(lyr1)
	end
	
	local lyr2 = self:GetStat("Primary.SoundLyr2")
	if lyr2 and ifp then
		self:EmitGunfireSound(lyr2)
	end

	if ply:IsPlayer() then
		self:SetGlowRatio(1.5)
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local status = self:GetStatus()

	if ply:IsPlayer() then
		if !self:IsEmpty1() and status ~= TFA.Enum.STATUS_RELOADING then
			local num = 400 / (1 + (self:GetGlowRatio() * 2))
			if math.random(num) <= 2 then
				self.glow1 = 1
			end
			if math.random(num) <= 2 then
				self.glow2 = 1
			end
			if math.random(num) <= 2 then
				self.glow3 = 1
			end
			if math.random(num) <= 2 then
				self.glow4 = 1
			end
		end

		if self:GetGlowRatio() > 0 then
			self:SetGlowRatio(math.Clamp(self:GetGlowRatio() - (FrameTime() / 1), 0, 1.5))
		end

		if self.glow1 > 0 then
			self.glow1 = math.Clamp(self.glow1 - (FrameTime() / 0.1), 0, 1)
		end
		if self.glow2 > 0 then
			self.glow2 = math.Clamp(self.glow2 - (FrameTime() / 0.1), 0, 1)
		end
		if self.glow3 > 0 then
			self.glow3 = math.Clamp(self.glow3 - (FrameTime() / 0.1), 0, 1)
		end
		if self.glow4 > 0 then
			self.glow4 = math.Clamp(self.glow4 - (FrameTime() / 0.1), 0, 1)
		end
	end

	return BaseClass.Think2(self,...)
end
