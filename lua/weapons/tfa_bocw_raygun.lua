SWEP.Base = "tfa_bash_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Cold War"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Manufacturer = "Group 935"
SWEP.Type_Displayed = "935 Battery Cells"
SWEP.Author = "Goanna, Fox, Mav, Raven"
SWEP.Slot = 1
SWEP.PrintName = "Ray Gun | BOCW"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.TracerCount 		= 0
SWEP.Primary.Delay		= 0.35
SWEP.Type = "Wonder Weapon"


--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bocw/raygun/c_kate_nzbocwraygun.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/tfa_bocw/raygun/w_kate_nzbocwraygun.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 8
SWEP.MuzzleAttachment = "1"
SWEP.MuzzleAttachmentSilenced = "2"
SWEP.VMPos = Vector(0, -1, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = {
	Pos = {
		Up = -1,
		Right = 1.6,
		Forward = 3
	},
	Ang = {
		Up = 0,
		Right = -10,
		Forward = 180
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.

--[Projectile]--
SWEP.Primary.Projectile         = "bo4_ww_raygun" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 3000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BOCW_RAYGN.Shoot"
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 181
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 400
SWEP.Primary.Knockback = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_bo4_muzzleflash_raygun"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

--[Range]--
SWEP.Primary.RangeFalloffLUT = {
	bezier = false, -- Whenever to use Bezier or not to interpolate points?
	-- you probably always want it to be set to true
	range_func = "linear", -- function to spline range
	-- "linear" for linear splining.
	-- Possible values are "quintic", "cubic", "cosine", "sinusine", "linear" or your own function
	units = "meters", -- possible values are "inches", "inch", "hammer", "hu" (are all equal)
	-- everything else is considered to be meters
	lut = { -- providing zero point is not required
		-- without zero point it is considered to be as {range = 0, damage = 1}
		{range = 200, damage = 1},
	}
}

--[Spread Related]--
SWEP.Primary.Spread		  = .025
SWEP.Primary.IronAccuracy = .025
SWEP.IronRecoilMultiplier = 0.7
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 0.3
SWEP.Primary.KickDown 			= 0.2
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor = 0.5

SWEP.Primary.SpreadMultiplierMax = 1
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 1

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 80
SWEP.IronSightsPos = Vector(-4.62, 0, -0.4)
SWEP.IronSightsAng = Vector(2, 0, 0)
SWEP.IronSightTime = 0.35

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 0.8
SWEP.LuaShellEjectDelay = 0
--SWEP.LuaShellModel = "models/entities/mw2cr_shells/rifle/fx_shell.mdl"
SWEP.ShellAttachment = "0"

--[Misc]--
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, 2.5)
SWEP.SafetyAng = Vector(-20, 5, -10)

--[NZombies]--
SWEP.NZPaPName = "Porter's X2 Ray Gun"
SWEP.NZWonderWeapon = false
SWEP.Primary.MaxAmmo = 160

function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 40
self.Primary_TFA.MaxAmmo = 200
self.Primary_TFA.Damage = 600
self.MuzzleFlashEffect = "tfa_bo4_muzzleflash_raygun_pap"
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 100 / 30,
}
SWEP.SequenceRateOverride = {
	["sprint_in"] = 45 / 30,
    ["sprint_loop"] = 40 / 30,
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
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_PSTL.Draw") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_PSTL.Holster") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_RAYGN.Raise") },
{ ["time"] = 30 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_RAYGN.Dial") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 12 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_RAYGN.Open") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_RAYGN.BatOut") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_RAYGN.BatIn") },
{ ["time"] = 80 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_RAYGN.BatIn") },
{ ["time"] = 100 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_RAYGN.Close") },
},
[ACT_VM_FIDGET] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BOCW_RAYGN.Inspect1") },
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

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Equip(ply, ...)
    if engine.ActiveGamemode() == "nzombies" and SERVER then
        net.Start("TFA.BO3.QED_SND")
            net.WriteString("Raygun")
        net.Broadcast()
    end

    return BaseClass.Equip(self, ply, ...)
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		vm:SetSubMaterial(0, self.nzPaPCamo)
		vm:SetSubMaterial(1, self.nzPaPCamo)
		vm:SetSubMaterial(2, self.nzPaPCamo)
		vm:SetSubMaterial(3, "models/weapons/tfa_bo3/raygun/mtl_wpn_t7_zmb_raygun_power_pap.vmt")
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(2, nil)
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(4, nil)
	end
end