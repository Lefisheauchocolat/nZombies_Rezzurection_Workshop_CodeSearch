local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 4"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Magma Gat | BO4" or "Magma Gat"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/magmagat/c_magmagat.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/magmagat/w_magmagat.mdl"
SWEP.HoldType = "shotgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1.5,
        Right = 1,
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
SWEP.Primary.Sound = "TFA_BO4_BLUNDER.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO4_BLUNDER.Act"
SWEP.Primary.SoundLyr2 = "TFA_BO4_BLUNDER.Dist"
SWEP.Primary.SoundLyr3 = "TFA_BO4_BLUNDER.Lfe"
SWEP.Primary.Ammo = "BuckShot"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 600
SWEP.Primary.Damage = nzombies and 600 or 100
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 10
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 12
SWEP.Primary.Delay = 0.35
SWEP.MuzzleFlashEffect = "tfa_bo4_muzzleflash_magmagat"
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

SWEP.Primary.KickUp				= 1.0
SWEP.Primary.KickDown			= 1.0
SWEP.Primary.KickHorizontal		= 0.5
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 2.5
SWEP.Primary.SpreadIncrement = 2.5
SWEP.Primary.SpreadRecovery = 2

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-4.15, -1, 1.45)
SWEP.IronSightsAng = Vector(-0.5, 0, 0)
SWEP.IronSightTime = 0.4

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = "models/entities/tfa_bo3/wunderwaffe/stripperclip.mdl"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo4_ww_magmagat" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 1000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_bo4/magmagat/magma_rock.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.NZPaPName = "Magnus Operandi"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 20

function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 2
SWEP.Primary.MaxAmmoPAP = 50
SWEP.Primary.DamagePAP = 2100

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 2
self.Primary_TFA.MaxAmmo = 50
self.Primary_TFA.Damage = 2100
self.Bodygroups_V = {[1] = 1}
self.Bodygroups_W = {[1] = 1}
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 35 / 30,
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
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_BLUNDER.Draw") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_BLUNDER.Open") },
{ ["time"] = 30 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_BLUNDER.Insert") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_BLUNDER.Close") },
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

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched and (!cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool())) then
		vm:SetSubMaterial(3, self.nzPaPCamo)
		vm:SetSubMaterial(5, self.nzPaPCamo)
		vm:SetSubMaterial(6, self.nzPaPCamo)
		vm:SetSubMaterial(8, self.nzPaPCamo)
	else
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(5, nil)
		vm:SetSubMaterial(6, nil)
		vm:SetSubMaterial(8, nil)
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

function SWEP:PostSpawnProjectile(ent)
	local aimcone = self:GetIronSights() and 4 or 8
	local ang = self:GetOwner():GetAimVector():Angle()
	ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
	ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))

	local angvel = VectorRand(-2500,-500)
	angvel:Rotate(-1*self:GetOwner():EyeAngles())
	angvel:Rotate(Angle(0,ang.y,0))

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetAngles(ang)
		phys:AddAngleVelocity(angvel)
	end
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

	local lyr3 = self:GetStat("Primary.SoundLyr3")
	if lyr3 and ifp then
		self:EmitGunfireSound(lyr3)
	end

	if ifp and self.AttachmentCache["bo3_packapunch"] then
		self:EmitGunfireSound("TFA_BO3_PAP.Shoot")
	end
	if ifp and nzombies and self:HasNZModifier("pap") then
		nzSounds:PlayEnt("UpgradedShoot", self)
	end
end

local crosshair_chemgun = Material("vgui/overlay/chemicalgelgun_reticle.png", "smooth unlitgeneric")
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
	surface.SetMaterial(crosshair_chemgun)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 114, y  - 114, 228, 228)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 114, ScrH() / 2 - 114, 228, 228)
	end
end