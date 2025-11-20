local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 4"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 2
SWEP.PrintName = nzombies and "Tundragun | BO4" or "Tundragun"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/tundragun/c_tundragun.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/tundragun/w_tundragun.mdl"
SWEP.HoldType = "shotgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(2, 0, -1)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 0,
        Right = 1.2,
        Forward = 3.5,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO4_TUNDRAGUN.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO4_THUNDERGUN.Flux"
SWEP.Primary.Ammo = "Thumper"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 60
SWEP.Primary.Damage = nzombies and 115 or 200
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.MuzzleFlashEffect	= "tfa_bo4_muzzleflash_tundragun"
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
SWEP.Primary.Spread		  = .025
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 1.5
SWEP.Primary.KickDown			= 1.2
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor	= 0.35

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 3
SWEP.Primary.SpreadRecovery = 4

--[Projectile]--
SWEP.Primary.Projectile         = "bo4_ww_tundragun" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 2500 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_bo4/tundragun/p8_zm_zod_ice_crystalline_01.mdl" -- Entity to shoot's model

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = "models/weapons/tfa_bo3/thundergun/wind_reel.mdl"
SWEP.LuaShellScale = 1.3
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {thumper = "#tfa.ammo.bo4ww.tundra"}
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Boreas Blizzard"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 12

function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 4
SWEP.Primary.MaxAmmoPAP = 36
SWEP.MoveSpeedPAP = 0.95

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 4
self.Primary_TFA.MaxAmmo = 36
self.MoveSpeed = 0.95
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 60 / 30,
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
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO4_THUNDERGUN.Raise") },
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_THUNDERGUN.Open") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_THUNDERGUN.MagOut") },
{ ["time"] = 20 / 30, ["type"] = "lua", value = function(self) self:CleanParticles() end, client = true, server = false},
{ ["time"] = 40 / 30, ["type"] = "lua", value = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 40 / 30, ["type"] = "lua", value = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_THUNDERGUN.MagIn") },
{ ["time"] = 85 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_THUNDERGUN.Close") },
{ ["time"] = 90 / 30, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
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

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

SWEP.Lights = {
	[0] = Material("models/weapons/tfa_bo4/tundragun/xmaterial_9152d4d84247dcd.vmt"),
	[1] = Material("models/weapons/tfa_bo4/tundragun/xmaterial_915264d842471e8.vmt"),
	[2] = Material("models/weapons/tfa_bo4/tundragun/xmaterial_915274d8424739b.vmt"),
	[3] = Material("models/weapons/tfa_bo4/tundragun/xmaterial_915284d8424754e.vmt"),
}
SWEP.FP_FX = {}

local sp = game.SinglePlayer()

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched and (!cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool())) then
		vm:SetSubMaterial(0, self.nzPaPCamo)
		vm:SetSubMaterial(1, self.nzPaPCamo)
		vm:SetSubMaterial(2, self.nzPaPCamo)
		vm:SetSubMaterial(4, self.nzPaPCamo)
		vm:SetSubMaterial(6, self.nzPaPCamo)
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(2, nil)
		vm:SetSubMaterial(4, nil)
		vm:SetSubMaterial(6, nil)
	end
end

function SWEP:PostPrimaryAttack()
	if not self:VMIV() then return end

	if sp and SERVER then
		self:CallOnClient("DecrementLights", "")
	end
	self:DecrementLights()
end

function SWEP:EnableLights()
	if SERVER then return end
	if not self:VMIV() then return end

	ParticleEffectAttach("bo4_tundragun_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 6)

	local light = self:GetStat("Lights")
	local keys = table.GetKeys(light)
	for i = 1, #keys do
		if self:Clip1() > keys[i] then
			light[keys[i]]:SetVector("$emissiveblendtint", Vector(3,3,3))
			if !self.FP_FX[i] or !self.FP_FX[i]:IsValid() then
				self.FP_FX[i] = CreateParticleSystem(self.OwnerViewModel, "bo4_tundragun_vm_mag", PATTACH_POINT_FOLLOW, i+6)
			end
		end
	end
end

function SWEP:DecrementLights()
	if SERVER then return end
	if not self:VMIV() then return end

	local light = self:GetStat("Lights")
	local keys = table.GetKeys(light)
	for i = 1, #keys do
		if self:Clip1() <= keys[i] then
			light[keys[i]]:SetVector("$emissiveblendtint", vector_origin)
			if self.FP_FX[i] and self.FP_FX[i]:IsValid() then
				self.FP_FX[i]:StopEmission()
			end
		end
	end
end

function SWEP:Reload(...)
	if self:Ammo1() < 1 or self:Clip1()>0 then 
		return
	end
	BaseClass.Reload(self, ...) 
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

local crosshair_snow = Material("vgui/overlay/reticle_center_snowflake.png", "smooth unlitgeneric")
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

local crosshair_cvar = GetConVar("cl_tfa_bo3ww_crosshair")
local sv_tfa_fixed_crosshair = GetConVar("sv_tfa_fixed_crosshair")
local crossr_cvar = GetConVar("cl_tfa_hud_crosshair_color_r")
local crossg_cvar = GetConVar("cl_tfa_hud_crosshair_color_g")
local crossb_cvar = GetConVar("cl_tfa_hud_crosshair_color_b")
local crosscol = Color(255, 255, 255, 255)

function SWEP:DrawHUDBackground()
	if not crosshair_cvar:GetBool() then return end
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
	surface.SetMaterial(crosshair_snow)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 64, y  - 64, 128, 128)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 64, ScrH() / 2 - 64, 128, 128)
	end
end