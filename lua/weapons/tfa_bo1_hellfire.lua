local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "BO1 Winter's Howl retextured and conceptualized by Treminator. \nFrom the World at War mod 'UGX 1.1' by UGX Team"
SWEP.Author = "Treminator, FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = nzombies and "Hellfire | WAW" or "Hellfire"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true
SWEP.DrawWeaponInfoBox = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo1/hellfire/c_hellfire.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo1/hellfire/w_hellfire.mdl"
SWEP.HoldType = "revolver"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -4.4,
        Right = 1.2,
        Forward = 12,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO1_HELLFIRE.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO1_HELLFIRE.Firey"
SWEP.Primary.Ammo = "AlyxGun"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 181
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 115 or 85
SWEP.Primary.Knockback = 30
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 9
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 4
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect = "tfa_bo1_muzzleflash_hellfire"
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
		{range = 100, damage = 1.0},
		{range = 450, damage = 0.5},
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
SWEP.IronRecoilMultiplier = 0.85
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 0.6
SWEP.Primary.KickDown			= 0.6
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor	= 0.4

SWEP.Primary.SpreadMultiplierMax = 1
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 1

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(-4.125, 0, 0.35)
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
SWEP.Primary.Projectile         = "bo1_ww_hellfire" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 1200 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {alyxgun = "#tfa.ammo.miscww.hellfire"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Hellfire Mk2"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 36
SWEP.Ispackapunched = false

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo(self.Primary.MaxAmmo, self:GetPrimaryAmmoType())
	self:SetClip1(self.Primary.ClipSize)
end

SWEP.Primary.ClipSizePAP = 12

function SWEP:OnPaP()
self.Ispackapunched = true

self.RoundDropOffInterval = 15
self.CylinderRadius = 150
self.CylinderRange = 500
self.CylinderInnerRange = 100

self.Primary_TFA.ClipSize = 12
self.Primary_TFA.MaxAmmo = 48

self.Primary_TFA.RangeFalloffLUT = {
	bezier = false,
	range_func = "linear",
	units = "hu",
	lut = {
		{range = 100, damage = 1.0},
		{range = 500, damage = 0.5},
	}
}

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 75 / 35,
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
{ ["time"] = 1 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 1 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 15 / 40, ["type"] = "sound", ["value"] = Sound("TFA_BO1_HELLFIRE.Twist") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_HELLFIRE.Open") },
{ ["time"] = 10 / 35, ["type"] = "lua", value = function(self) self:CleanParticles() end, client = true, server = false},
{ ["time"] = 20 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_HELLFIRE.Twist") },
{ ["time"] = 25 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_HELLFIRE.ClipOff") },
{ ["time"] = 75 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_HELLFIRE.ClipOn") },
{ ["time"] = 80 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_HELLFIRE.Twist") },
{ ["time"] = 100 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO1_HELLFIRE.Close") },
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

SWEP.RoundDropOffInterval = 10
SWEP.CylinderRadius = 100
SWEP.CylinderRange = 450
SWEP.CylinderInnerRange = 100

--[Attachments]--
SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = nzombies},
}

SWEP.WW3P_FX = "bo1_hellfire_3p"
SWEP.WW3P_ATT = 1

DEFINE_BASECLASS( SWEP.Base )

local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

function SWEP:Think2(...)
	local ply = self:GetOwner()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex())

		if self.DLight then
			local attpos = (self:IsFirstPerson() and self.OwnerViewModel or self):GetAttachment(1)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 65
			self.DLight.g = 255
			self.DLight.b = 240
			self.DLight.decay = 1000
			self.DLight.brightness = 0.5
			self.DLight.size = 128
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

	if SERVER then
		self:HellfireCylinder()
	end
end

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function SWEP:HellfireCylinder()
	if CLIENT then return end
	local ply = self:GetOwner()

	local inner_range = self.CylinderInnerRange
	local outer_range = self.CylinderRange
	local cylinder_radius = self.CylinderRadius

	local view_pos = ply:GetShootPos()
	local forward_view_angles = ply:IsPlayer() and ply:GetAimVector() or self:GetAimVector()
	local end_pos = view_pos + (forward_view_angles*outer_range)

	if shouldDisplayDebug() then
		local near_circle_pos = view_pos + (forward_view_angles*2)

		DLib.debugoverlay.Sphere(near_circle_pos, cylinder_radius, 5, Color(255, 0, 0, 255), true)
		DLib.debugoverlay.Line(near_circle_pos, end_pos, 5, Color(0, 0, 255, 255), true)
		DLib.debugoverlay.Sphere(end_pos, cylinder_radius, 5, Color(255, 0, 0, 255), true)
	end

	local inner_range_squared = inner_range * inner_range
	local outer_range_squared = outer_range * outer_range
	local cylinder_radius_squared = cylinder_radius * cylinder_radius

	for i, ent in pairs(ents.FindInSphere(view_pos, outer_range*1.1)) do
		if not (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()) then continue end

		if nzombies and ent:IsPlayer() then continue end
		if ent == ply then continue end
		if ent:Health() <= 0 then continue end
		if ent:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end
		if IsValid(ply) and ply:IsNPC() and ply:Disposition(ent) == D_LI then continue end

		local test_origin = ent:WorldSpaceCenter()
		local test_range_squared = view_pos:DistToSqr(test_origin)
		if test_range_squared > outer_range_squared then
			continue
		end

		local normal = (test_origin - view_pos):GetNormalized()
		local dot = forward_view_angles:Dot(normal)
		if 0 > dot then
			continue
		end

		local radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin )
		if test_origin:DistToSqr(radial_origin) > cylinder_radius_squared then
			continue
		end

		local tr1 = util.TraceLine({
			start = radial_origin,
			endpos = test_origin,
			filter = {self, ply},
			mask = MASK_SHOT_HULL,
		})

		local hitpos = tr1.Entity == ent and tr1.HitPos or ent:WorldSpaceCenter()
		if not ply:VisibleVec(hitpos) then
			continue
		end

		local damagefinal = self.Primary_TFA.Damage
		if nzombies and ent:IsValidZombie() then
			local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
			local health = tonumber(nzCurves.GenerateHealthCurve(round))

			damagefinal = health / math.Clamp(round/self.RoundDropOffInterval, 1, 3)
		end

		local dist_ratio = (outer_range_squared - test_range_squared) / (outer_range_squared - inner_range_squared) 
		local damage = tonumber(Lerp(dist_ratio, damagefinal / 2, damagefinal))
		normal = normal + (test_origin - radial_origin):GetNormalized()*0.5

		self:HellfireDamage(ent, damage, math.max(dist_ratio, 0.5), normal*(math.random(40,60)*100), hitpos)
	end
end

function SWEP:HellfireDamage(ent, amount, ratio, normal, hitpos)
	local fatal = math.floor(ent:Health() - amount) <= 0

	local damage = DamageInfo()
	damage:SetDamageType(nzombies and DMG_BURN or DMG_SLOWBURN)
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamage(fatal and ent:Health() + 666 or amount)
	damage:SetDamageForce(normal)
	damage:SetDamagePosition(hitpos)

	if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "nz_zombie_boss")) then
		damage:SetDamage(math.max(621*ratio, ent:GetMaxHealth() / 12))
	end

	if fatal then
		ent:EmitSound("weapons/tfa_bo1/hellfire/zombie_burn_0"..math.random(0,5)..".wav", math.random(60,75), math.random(95,105), 1, CHAN_VOICE2)

		if not ent:IsPlayer() and math.random(12) < 4 and (!ent.IsMooSpecial or (ent.IsMooSpecial and !ent.MooSpecialZombie)) then
			ent:SetNW2Bool("HellfireKilled", true)

			local headpos = ent:EyePos()
			local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
			if !headbone then headbone = ent:LookupBone("j_head") end
			if headbone then
				headpos = ent:GetBonePosition(headbone)
				damage:SetDamagePosition(headpos)
			end

			ParticleEffect("blood_impact_red_01", headpos, ent:GetForward():Angle())
			ent:EmitSound("TFA_BO3_WAFFE.Pop")
			ent:EmitSound("TFA_BO3_WAFFE.Sizzle")

			if nzombies and ent:IsValidZombie() then
				ParticleEffectAttach("bo1_hellfire_volcano", PATTACH_POINT_FOLLOW, ent, 2)
			end
		end

		if ent:IsNPC() then
			ent:SetHealth(1)
			ent:SetSchedule(SCHED_ALERT_STAND)
		end
	else
		if nzombies and !(ent.NZBossType or ent.IsMooBossZombie) then
			ent:BO1BurnSlow(3*ratio)
		end
		ent:EmitSound("TFA_BO1_HELLFIRE.Ignite")
	end

	if !nzombies then
		ent:Ignite(3*ratio)
	end

	ent:TakeDamageInfo(damage)
end

function SWEP:PreSpawnProjectile(ent)
	if self.Ispackapunched then
		ent.Delay = 0.4
	end
end

local tpfx_cvar = GetConVar("cl_tfa_fx_wonderweapon_3p")
function SWEP:DrawWorldModel(...)
	if tpfx_cvar:GetBool() then
		if !self.CL_3PDrawFX or !self.CL_3PDrawFX:IsValid() then
			self.CL_3PDrawFX = CreateParticleSystem(self, tostring(self.WW3P_FX), PATTACH_POINT_FOLLOW, tonumber(self.WW3P_ATT))
		end
		if self.WW3P_CALLBACK then
			self:WW3P_CALLBACK(self, ply)
		end
	end

	return BaseClass.DrawWorldModel(self, ...)
end

local crosshair_flamethrower = Material("vgui/overlay/hud_flamethrower_reticle_t5.png", "smooth unlitgeneric")
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

	local teamcol = self2.GetTeamColor(self, targent)
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
		surface.DrawTexturedRect(x - 32, y  - 32, 64, 64)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 64)
	end
end