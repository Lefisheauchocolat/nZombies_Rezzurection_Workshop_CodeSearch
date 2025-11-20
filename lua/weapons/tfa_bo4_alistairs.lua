local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 4"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = nzombies and "Alistair's Folly | BO4" or "Alistair's Folly"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/alistairs/c_alistairs.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/alistairs/w_alistairs.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 1.5,
        Forward = 3,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO4_ALISTAIR.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO4_RAYGUN.Lfe"
SWEP.Primary.Ammo = "Battery"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 181
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 600 or 80
SWEP.Primary.Knockback = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_bo4_muzzleflash_alistairs"
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
SWEP.Primary.Spread		  = .02
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.6
SWEP.Primary.KickDown			= 0.6
SWEP.Primary.KickHorizontal		= 0.2
SWEP.Primary.StaticRecoilFactor	= 0.2

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1.5
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(-5.23, 0, -0.05)
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

--[Projectile]--
SWEP.Primary.Projectile         = "bo4_ww_alistair" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 3000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {battery = "#tfa.ammo.bo4ww.alistairs"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)

--[NZombies]--
SWEP.NZPaPReplacement = "tfa_bo4_alistairs_lv2"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 96
SWEP.Ispackapunched = false
SWEP.NZHudIcon = Material("vgui/icon/hud_alistairs_folly_bo4.png", "unlitgeneric smooth")

function SWEP:NZMaxAmmo()
	local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
	end
end

function SWEP:OnPaP()
self.Ispackapunched = true
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 70 / 30,
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.HammerDown") },
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.HammerUp") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.HammerUp") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.Open") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.MagOut") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.MagIn") },
{ ["time"] = 80 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.Close") },
{ ["time"] = 95 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_ALISTAIR.HammerDown") },
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

SWEP.VElements = {
	["sprite"] = { type = "Sprite", sprite = "sprites/animglow01-", bone = "tag_fx_light", rel = "", pos = Vector(0,0,0), size = {x = 0.5, y = 0.5}, color = Color(0, 255, 0, 150), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = true, active = true },
}

DEFINE_BASECLASS( SWEP.Base )

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched and (!cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool())) then
		vm:SetSubMaterial(1, self.nzPaPCamo)
		vm:SetSubMaterial(4, self.nzPaPCamo)
		vm:SetSubMaterial(5, self.nzPaPCamo)
		vm:SetSubMaterial(6, self.nzPaPCamo)
	else
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(4, nil)
		vm:SetSubMaterial(5, nil)
		vm:SetSubMaterial(6, nil)
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), true)

		if self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(3)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 0
			self.DLight.g = 225
			self.DLight.b = 0
			self.DLight.decay = 500
			self.DLight.brightness = 0.1
			self.DLight.size = 64 * 0.5
			self.DLight.dietime = CurTime() + 1
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local lyr1 = self:GetStatL("Primary.SoundLyr1")
	if lyr1 and ifp then
		self:EmitGunfireSound(lyr1)
	end
end

/*function SWEP:PostSpawnProjectile(ent)
	local ply = self:GetOwner()
	local phys = ent:GetPhysicsObject()
	local vel = self:GetStat("Primary.ProjectileVelocity")

	local spread = (self:GetIronSights() and Vector(0,0,0) or VectorRand(-50,50))

	if ply:IsPlayer() then
		if IsValid(phys) then
			phys:SetVelocity((ply:GetAimVector() * vel) + spread)
		end
	end
end*/
