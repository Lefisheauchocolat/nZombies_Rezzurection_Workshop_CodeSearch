local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 2
SWEP.PrintName = nzombies and "Thundergun | BO3" or "Thundergun"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/thundergun/c_thundergun.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/thundergun/w_thundergun.mdl"
SWEP.HoldType = "shotgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
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
SWEP.Primary.Sound = "TFA_BO3_THUNDERGUN.Shoot"
SWEP.Primary.Ammo = "Thumper"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 60
SWEP.Primary.Damage = 115
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 2
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.MuzzleFlashEffect	= "tfa_bo3_muzzleflash_thundergun"
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
/*SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false*/
SWEP.Primary.DisplayFalloff = true
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
		{range = 480, damage = 1.0},
		{range = 900, damage = 0.6522},
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
SWEP.Primary.Spread		  = .001
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
SWEP.Primary.Projectile         = "bo3_ww_thundergun" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 1500 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

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
SWEP.AmmoTypeStrings = {thumper = "#tfa.ammo.bo3ww.tgun"}
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Zeus Cannon"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 12
SWEP.NZHudIcon = Material("vgui/icon/i_pv_hud_killstreak_thundergun.png", "unlitgeneric smooth")

function SWEP:NZMaxAmmo()
	local ammo_type = self:GetPrimaryAmmoType() or self.Primary_TFA.Ammo
	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
	end
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 4
SWEP.Primary.MaxAmmoPAP = 24
SWEP.MuzzleFlashEffectPAP = "tfa_bo3_muzzleflash_thundergun_pap"
SWEP.MoveSpeedPAP = 0.95

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 4
self.Primary_TFA.MaxAmmo = 24
self.MuzzleFlashEffect = "tfa_bo3_muzzleflash_thundergun_pap"
self.MoveSpeed = 0.95
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 55 / 30,
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_THUNDERGUN.Draw") },
{ ["time"] = 10 / 30, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = false},
},
[ACT_VM_RELOAD] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_THUNDERGUN.Eject") },
{ ["time"] = 15 / 30, ["type"] = "lua", value = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 16 / 30, ["type"] = "lua", value = function(self) self:EventShell() end, client = true, server = true},
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_THUNDERGUN.Replace") },
{ ["time"] = 55 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_THUNDERGUN.Lock") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_THUNDERGUN.CellOn") },
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

SWEP.Lights = {
	[0] = Material("models/weapons/tfa_bo3/thundergun/mtl_wpn_t7_zmb_hd_thundergun_glow_4.vmt"),
	[1] = Material("models/weapons/tfa_bo3/thundergun/mtl_wpn_t7_zmb_hd_thundergun_glow_3.vmt"),
	[2] = Material("models/weapons/tfa_bo3/thundergun/mtl_wpn_t7_zmb_hd_thundergun_glow_2.vmt"),
	[3] = Material("models/weapons/tfa_bo3/thundergun/mtl_wpn_t7_zmb_hd_thundergun_glow_1.vmt"),
}
SWEP.FP_FX = {}

SWEP.CylinderRadius = 180
SWEP.CylinderRange = 900
SWEP.CylinderKillRange = 480

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local sp = game.SinglePlayer()
local pvp_bool = GetConVar("sbox_playershurtplayers")
local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	
	self:NetworkVarTFA("Float", "NextWave")
end

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched and (!cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool())) then
		vm:SetSubMaterial(0, self.nzPaPCamo)
		vm:SetSubMaterial(1, self.nzPaPCamo)
		vm:SetSubMaterial(2, self.nzPaPCamo)
		vm:SetSubMaterial(3, self.nzPaPCamo)
		vm:SetSubMaterial(4, self.nzPaPCamo)
		vm:SetSubMaterial(6, self.nzPaPCamo)
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(2, nil)
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(4, nil)
		vm:SetSubMaterial(6, nil)
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	if self.Ispackapunched then
		ParticleEffect("bo3_thundergun_muzzleflash_smokeground_2", ply:GetPos() + ply:OBBCenter(), Angle(0,ply:GetAngles().y,0))
	else
		ParticleEffect("bo3_thundergun_muzzleflash_smokeground", ply:GetPos() + ply:OBBCenter(), Angle(0,ply:GetAngles().y,0))
	end

	if ifp then
		self:EmitGunfireSound("TFA_BO3_THUNDERGUN.Ext")
	end

	if self:VMIV() then
		if sp and SERVER then
			self:CallOnClient("DecrementLights", "")
		end
		self:DecrementLights()
	end

	if SERVER then
		self:ThundergunCylinderDamage()
	end
end

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function SWEP:ThundergunCylinderDamage()
	if CLIENT then return end
	local ply = self:GetOwner()

	local inner_range = self.CylinderKillRange
	local outer_range = self.CylinderRange
	local cylinder_radius = self.CylinderRadius

	local view_pos = ply:GetShootPos()
	local forward_view_angles = ply:IsPlayer() and ply:GetAimVector() or self:GetAimVector()
	local end_pos = view_pos + (forward_view_angles * outer_range)

	if shouldDisplayDebug() then
		local near_circle_pos = view_pos + (forward_view_angles*2)

		DLib.debugoverlay.Sphere(near_circle_pos, cylinder_radius, 5, Color(255, 0, 0, 255), true)
		DLib.debugoverlay.Line(near_circle_pos, end_pos, 5, Color(0, 0, 255, 255), true)
		DLib.debugoverlay.Sphere(end_pos, cylinder_radius, 5, Color(255, 0, 0, 255), true)
	end

	local outer_range_squared = outer_range * outer_range
	local cylinder_radius_squared = cylinder_radius * cylinder_radius
	local inner_range_squared = inner_range * inner_range

	for i, ent in pairs(ents.FindInSphere(view_pos, outer_range*1.1)) do
		if not (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()) then continue end

		if not pvp_bool:GetBool() and ent:IsPlayer() then continue end
		if ent == ply then continue end
		if nzombies and ent:IsPlayer() then continue end
		if ent:Health() <= 0 then continue end
		if ent:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end

		local test_origin = ent:WorldSpaceCenter()
		local test_range_squared = view_pos:DistToSqr(test_origin)
		if test_range_squared > outer_range_squared then
			if shouldDisplayDebug() then print('range') end
			continue // everything else in the list will be out of range
		end

		local normal = (test_origin - view_pos):GetNormalized()
		local dot = forward_view_angles:Dot(normal)
		if 0 > dot then
			if shouldDisplayDebug() then print('dot') end
			continue // guy's behind us
		end

		local radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin )
		if test_origin:DistToSqr(radial_origin) > cylinder_radius_squared then
			if shouldDisplayDebug() then print('cylinder') end
			continue // guy's outside the range of the cylinder of effect
		end

		local tr1 = util.TraceLine({
			start = view_pos,
			endpos = test_origin,
			filter = {self, ply},
			mask = MASK_SOLID_BRUSHONLY,
		})

		if tr1.HitWorld then
			if shouldDisplayDebug() then print(ent) print('cone') end
			continue // guy can't actually be hit from where we are
		end

		self:ThundergunDamage(ent, test_range_squared < inner_range_squared)
	end
end

function SWEP:ThundergunDamage(ent, kill)
	if CLIENT then return end

	local norm = (ent:GetPos() - self:GetPos()):GetNormalized()

	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamage(kill and ent:Health() + 666 or 75)
	damage:SetDamageForce((ent:GetUp()*40000 + self:GetForward()*20000) + norm*50000)
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if nzombies and ent.NZBossType then
		damage:SetDamage(math.max(1800, ent:GetMaxHealth() / 8))
		damage:ScaleDamage(math.Round(nzRound:GetNumber()/10))
	end

	ent:EmitSound("TFA_BO3_THUNDERGUN.Impact")
	ent:TakeDamageInfo(damage)

	if not kill and ent:IsPlayer() then
		ent:SetGroundEntity(nil)
		ent:SetLocalVelocity(ent:GetVelocity() + vector_up*80 + (norm*40))
		ent:SetDSP(32, false)
	end
end

function SWEP:Think2(...)
	if not self:GetNextWave() then
		self:SetNextWave(CurTime() + self:SharedRandom(8, 10))
	end

	if TFA.Enum.ReadyStatus[self:GetStatus()] and self:GetNextWave() < CurTime() then
		self:SetNextWave(CurTime() + self:SharedRandom(12, 16))
		if IsFirstTimePredicted() then self:EmitSoundNet("TFA_BO3_THUNDERGUN.Idle") end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:EnableLights()
	if SERVER then return end
	if not self:VMIV() then return end

	local light = self:GetStat("Lights")
	local keys = table.GetKeys(light)
	for i = 1, #keys do
		if self:Clip1() > keys[i] then
			light[keys[i]]:SetVector("$emissiveblendtint", Vector(3,3,3))
			if !self.FP_FX[i] or !self.FP_FX[i]:IsValid() then
				self.FP_FX[i] = CreateParticleSystem(self.OwnerViewModel, "bo3_thundergun_vm_mag", PATTACH_POINT_FOLLOW, i+6)
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
	if self:Ammo1() < 1 or self:Clip1() > 0 then 
		return
	end
	return BaseClass.Reload(self, ...) 
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

local crosshair_flamethrower = Material("vgui/overlay/hud_flamethrower_reticle.png", "smooth unlitgeneric")
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
	if not ply:IsValid() or self:GetOwner() ~= ply then return end

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
	surface.SetMaterial(crosshair_flamethrower)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 24, y  - 24, 48, 48)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 24, ScrH() / 2 - 24, 48, 48)
	end
end