local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Conceptualized by Whippytrout. \nFrom the World at War custom map 'Alcatraz' by Whippytrout"
SWEP.Author = "Whippytrout, Bluntstuffy, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Blunderhoff | WAW" or "Blunderhoff"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo2/blunderhoff/c_blunderhoff.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo2/blunderhoff/w_blunderhoff.mdl"
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
        Right = 1.4,
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
SWEP.Primary.Sound = "TFA_BO2_BLUNDERGAT.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO2_ACIDGAT.Shoot"
SWEP.Primary.Ammo = "CombineCannon"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 900
SWEP.Primary.Damage = nzombies and 400 or 60
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 15
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.Delay = 0.35
SWEP.MuzzleFlashEffect	= "tfa_bo2_muzzleflash_blunderhoff"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

--[Firemode]--
SWEP.Primary.BurstDelay = 0.01
SWEP.DisableBurstFire = false
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = true
SWEP.BurstFireCount = 3
SWEP.FireModes = {"3Burst"}

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

SWEP.ViewModelPunch_MaxVertialOffset				= 2 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.6 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .12
SWEP.Primary.IronAccuracy = .08
SWEP.IronRecoilMultiplier = 0.7
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 1.0
SWEP.Primary.KickDown			= 0.5
SWEP.Primary.KickHorizontal		= 0.5
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 2

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-2.96, -1, 0.4)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.4

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo2_ww_blunderhoff" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 3000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_bo2/blunderhoff/blunderhoff_projectile.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {combinecannon = "Party"}
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.NZPaPName = "Boogie Bomb"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 90

function SWEP:NZMaxAmmo()
    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo
    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Ispackapunched = false

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.MaxAmmo = 150
self.Primary_TFA.Damage = 1200
self.Primary_TFA.ClipSize = 6
self.Bodygroups_V = {[1] = 1}
self.Bodygroups_W = {[1] = 1}
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 35 / 35,
	[ACT_VM_RELOAD_EMPTY] = 35 / 35,
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
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Close") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 10 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Open") },
{ ["time"] = 30 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Insert") },
{ ["time"] = 65 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Close") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 10 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Open") },
{ ["time"] = 30 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Insert") },
{ ["time"] = 65 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Close") },
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

--[Attachments]--
SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

SWEP.AttachmentTableOverride	= {
	["bo3_packapunch"] = {
		["Bodygroups_V"] = {
			["1"] = 1,
		},
		["Bodygroups_W"] = {
			["1"] = 1,
		},
	},
}
--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		vm:SetSubMaterial(0, self.nzPaPCamo)
		vm:SetSubMaterial(2, self.nzPaPCamo)
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(2, nil)
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local lyr1 = self:GetStat("Primary.SoundLyr1")
	if lyr1 and ifp then
		self:EmitGunfireSound(lyr1)
	end

	if ifp and self.AttachmentCache["bo3_packapunch"] then
		self:EmitGunfireSound("TFA_BO3_PAP.Shoot")
	end
	if ifp and nzombies and self:HasNZModifier("pap") then
		nzSounds:PlayEnt("UpgradedShoot", self:GetOwner())
	end
end
