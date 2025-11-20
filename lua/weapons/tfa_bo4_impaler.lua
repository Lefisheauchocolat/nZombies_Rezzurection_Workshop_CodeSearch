local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 4"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = nzombies and "Savage Impaler | BO4" or "Savage Impaler"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo4/impaler/c_impaler.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo4/impaler/w_impaler.mdl"
SWEP.HoldType = "revolver"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 1.2,
        Forward = 3.5,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO4_IMPALER.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO4_IMPALER.Lfe"
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 300
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 400 or 100
SWEP.Primary.Knockback = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 24
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_muzzleflash_silenced"
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

SWEP.Primary.KickUp				= 0.3
SWEP.Primary.KickDown			= 0.2
SWEP.Primary.KickHorizontal		= 0.2
SWEP.Primary.StaticRecoilFactor	= 0.3

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 80
SWEP.IronSightsPos = Vector(-5.305, -1, 0.9)
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

--[Projectile]--
SWEP.Primary.Projectile         = "bo4_ww_impaler" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 4000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_bo4/impaler/impaler_projectile.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {xbowbolt = "#tfa.ammo.bo4ww.impaler"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Barrage"
SWEP.NZWonderWeapon = false
SWEP.NZUniqueWeapon = true
SWEP.Primary.MaxAmmo = 288

function SWEP:NZMaxAmmo()

    local ammo_type = self:GetPrimaryAmmoType() or self.Primary.Ammo

    if SERVER then
        self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
    end
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 48
SWEP.Primary.MaxAmmoPAP = 288
SWEP.Primary.DamagePAP = 200

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 48
self.Primary_TFA.NumShots = 3
self.Primary_TFA.MaxAmmo = 288
self.Primary_TFA.Damage = 500
self.Primary_TFA.RPM = 600
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 45 / 30,
	[ACT_VM_RELOAD_EMPTY] = 45 / 30,
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
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_IMPALER.Raise") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_IMPALER.Smoke") },
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(wep, vm)
	if SERVER then
		local ply = wep:GetOwner()
		local fx = EffectData()
		fx:SetEntity(wep)
		fx:SetAttachment(3)

		local filter = RecipientFilter()
		filter:AddPVS(ply:GetShootPos())
		if IsValid(ply) and wep:IsFirstPerson() then
			filter:RemovePlayer(ply)
		end

		if filter:GetCount() > 0 then
			util.Effect("tfa_bo4_impaler_3p", fx, true, filter)
		end
	end
	if CLIENT and not game.SinglePlayer() and not wep:IsFirstPerson() then
		ParticleEffectAttach("bo4_impaler_3p", PATTACH_POINT_FOLLOW, wep, 3)
	end
end},
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_IMPALER.MagOut") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_IMPALER.MagIn") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_IMPALER.Smoke") },
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(wep, vm)
	if SERVER then
		local ply = wep:GetOwner()
		local fx = EffectData()
		fx:SetEntity(wep)
		fx:SetAttachment(3)

		local filter = RecipientFilter()
		filter:AddPVS(ply:GetShootPos())
		if IsValid(ply) and wep:IsFirstPerson() then
			filter:RemovePlayer(ply)
		end

		if filter:GetCount() > 0 then
			util.Effect("tfa_bo4_impaler_3p", fx, true, filter)
		end
	end
end},
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_IMPALER.MagOut") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_IMPALER.MagIn") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO4_IMPALER.Chamber") },
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

--[Attachments]--
SWEP.ViewModelBoneMods = {
	["tag_gauge_pointer_pba"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

DEFINE_BASECLASS( SWEP.Base )

function SWEP:PreDrawViewModel(vm, wep, ply)
	self:SyncMeter(ply)
end

function SWEP:SyncMeter(ply)
	if not CLIENT then return end
	if self:VMIV() and ply:IsPlayer() and self:GetStatus() == TFA.Enum.STATUS_SHOOTING then
		local mult = self:Clip1() * 6
		local prog = 1 - self:GetStatusProgress()
		self.ViewModelBoneMods["tag_gauge_pointer_pba"].angle = Angle(0,math.Truncate(prog*-mult),0)
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	local lyr1 = self:GetStatL("Primary.SoundLyr1")
	if lyr1 and ifp then
		self:EmitGunfireSound(lyr1)
		if self.Ispackapunched then
			self:EmitGunfireSound("TFA_BO3_PAP.Shoot")
		end
	end
end

/*function SWEP:PostSpawnProjectile(ent)
	local ply = self:GetOwner()
	local phys = ent:GetPhysicsObject()
	local vel = self:GetStat("Primary.ProjectileVelocity")

	local spread = (self:GetIronSights() and Vector(0,0,0) or VectorRand(-150,150))

	if ply:IsPlayer() then
		if IsValid(phys) then
			phys:SetVelocity((ply:GetAimVector() * vel) + spread)
		end
	end
end*/

local crosshair_crossbow = Material("vgui/overlay/reticle_crossbow.png", "smooth unlitgeneric")
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
	surface.SetMaterial(crosshair_crossbow)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 64, y  - 64, 128, 128)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 64, ScrH() / 2 - 64, 128, 128)
	end
end