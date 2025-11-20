local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Unsure of who made the model. \nFrom the World at War custom map 'Pistol Defense NEON' by NGcaudle"
SWEP.Author = "NGcaudle, SHIPPUDEN1592, FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = nzombies and "Thunder Shot | WAW" or "Thunder Shot"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/thunderpistol/c_thunderpistol.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/thunderpistol/w_thunderpistol.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(-1, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -2.5,
        Right = 1.2,
        Forward = 3.8,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_WAW_TPISTOL.Shoot"
SWEP.Primary.SoundLyr1 = "TFA_BO2_RAYGUN.Act"
SWEP.Primary.SoundLyr2 = "TFA_BO2_RAYGUN.Flux"
SWEP.Primary.Ammo = "AR2AltFire"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 400
SWEP.Primary.Damage = nzombies and 115 or 100
SWEP.Primary.PenetrationPower = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 10
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 6
SWEP.Primary.Delay = 0.25
SWEP.MuzzleFlashEffect	= "tfa_waw_muzzleflash_tpistol"
SWEP.TracerName = "tfa_waw_tracer_tpistol"
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
SWEP.MainBullet = SWEP.MainBullet or {}
SWEP.MainBullet.Distance = 4096 //overwrites TFA bullet range

SWEP.Primary.Range = 4096
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
SWEP.Primary.Spread		  = .001
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.7
SWEP.CrouchAccuracyMultiplier = 1

SWEP.Primary.KickUp				= 2
SWEP.Primary.KickDown			= 1
SWEP.Primary.KickHorizontal		= 0.5
SWEP.Primary.StaticRecoilFactor	= 0.2

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 1
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-3.83, -2, 0.8)
SWEP.IronSightsAng = Vector(-2.2, 2.5, 7.9)
SWEP.IronSightTime = 0.25

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
SWEP.NZPaPName = "Thunder Clap"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 24

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self.Owner:SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.MuzzleFlashEffectPAP = "tfa_waw_muzzleflash_tpistol_pap"
SWEP.TracerNamePAP = "tfa_waw_tracer_tpistol_pap"
SWEP.Primary.ClipSizePAP = 2
SWEP.Primary.DamagePAP = 65

function SWEP:OnPaP()
self.Ispackapunched = true

self.CylinderKillRange = 220
self.ImpactMaxKills = 6

self.MainBullet.Distance = 8192
self.Primary.Range = 8192
self.Primary_TFA.ClipSize = 2

self.MuzzleFlashEffect = "tfa_waw_muzzleflash_tpistol_pap"
self.TracerName = "tfa_waw_tracer_tpistol_pap"

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 30 / 35,
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
{ ["time"] = 1 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 15 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_TPISTOL.SlideFwd") },
{ ["time"] = 15 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_TPISTOL.CellOn") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_TPISTOL.MagOut") },
{ ["time"] = 35 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_TPISTOL.MagIn") },
},
[ACT_VM_RELOAD_EMPTY] = {
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_TPISTOL.MagOut") },
{ ["time"] = 30 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_TPISTOL.MagIn") },
{ ["time"] = 65 / 40, ["type"] = "sound", ["value"] = Sound("TFA_WAW_TPISTOL.SlideFwd") },
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

SWEP.CylinderRadius = 180
SWEP.CylinderRange = 220
SWEP.CylinderKillRange = 200

SWEP.ImpactMaxKills = 4
SWEP.ImpactKillRange = 80

local pvp_bool = GetConVar("sbox_playershurtplayers")

SWEP.CustomBulletCallback = function(attacker, trace, dmginfo)
	if trace then
		local ent = trace.Entity
		local wep = dmginfo:GetInflictor()

		if trace.Hit and not trace.HitSky then
			sound.Play("weapons/tfa_waw/thunderpistol/prj_whizby_0"..math.random(0,3)..".wav", trace.HitPos, SNDLVL_IDLE, math.random(97,103), 0.5)
			ParticleEffect((IsValid(wep) and wep.Ispackapunched) and "waw_tpistol_hit_2" or "waw_tpistol_hit", trace.HitPos - trace.Normal, trace.HitNormal:Angle())
		end

		if SERVER and IsValid(ent) and IsValid(wep) and wep:IsWeapon() then
			dmginfo:SetDamage(0)
			dmginfo:ScaleDamage(0)
			dmginfo:SetMaxDamage(0)

			wep:ThundergunDamage(ent, true, trace.Normal*40000, trace.HitPos)

			if ent:IsNPC() or ent:IsNextBot() or ent:IsVehicle() or ent:IsPlayer() then
				local count = 0

				for k, v in pairs(ents.FindInSphere(trace.HitPos, wep.ImpactKillRange)) do
					if v == attacker then continue end
					if v == ent then continue end

					if not pvp_bool:GetBool() and v:IsPlayer() then continue end
					if v:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, attacker) then continue end
					if nzombies and v:IsPlayer() then continue end

					if v:Health() <= 0 then continue end
					if v.HasTakenDamageThisTick then continue end

					wep:ThundergunDamage(v, true, (v:WorldSpaceCenter() - trace.HitPos):GetNormalized()*math.random(6000,20000) + v:GetUp()*math.random(12000,18000), v:WorldSpaceCenter())

					count = count + 1
					if count >= wep.ImpactMaxKills then
						break
					end
				end
			end
			return true
		end
	end
end

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
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

	ParticleEffect("waw_tpistol_muzzleflash_smoke_floor", ply:GetPos() + ply:OBBCenter(), Angle(0,ply:GetAngles().y,0))

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
		if ent.HasTakenDamageThisTick then continue end

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
			start = radial_origin,
			endpos = test_origin,
			filter = {self, ply},
			mask = MASK_SHOT_HULL,
		})

		local hitpos = tr1.Entity == ent and tr1.HitPos or ent:WorldSpaceCenter()
		if not ply:VisibleVec(hitpos) then
			if shouldDisplayDebug() then print(ent) print('cone') end
			continue // guy can't actually be hit from where we are
		end

		local fling_vec = (ent:GetPos() - self:GetPos()):GetNormalized()
		local dist_mult = (outer_range_squared - test_range_squared) / outer_range_squared
		if 5000 < test_range_squared then //~70^2
			fling_vec = fling_vec + (test_origin - radial_origin):GetNormalized()
		end

		fling_vec = Vector(fling_vec.x, fling_vec.y, math.abs(fling_vec.z))
		fling_vec = fling_vec * ( 10000 + 20000 * dist_mult )

		self:ThundergunDamage(ent, test_range_squared < inner_range_squared, fling_vec, hitpos)
	end
end

function SWEP:ThundergunDamage(ent, kill, fling_vec, hitpos)
	if CLIENT then return end

	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamage(kill and ent:Health() + 666 or 75)
	damage:SetDamageForce(fling_vec)
	damage:SetDamagePosition(hitpos or ent:WorldSpaceCenter())

	if nzombies and ent.NZBossType then
		damage:SetDamage(math.max(self.Ispackapunched and 800 or 600, ent:GetMaxHealth() / 12))
		damage:ScaleDamage(math.Round(nzRound:GetNumber()/10))
	end

	ent:EmitSound("TFA_BO3_THUNDERGUN.Impact")
	ent:TakeDamageInfo(damage)

	if not kill and ent:IsPlayer() then
		ent:SetGroundEntity(nil)
		ent:SetLocalVelocity(ent:GetVelocity() + vector_up*80 + (fling_vec*20))
		ent:SetDSP(32, false)
	end
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

	local teamcol = Color(255,255,255)
	if IsValid(targent) and tr.start:Distance(traceres.HitPos) < self:GetStatL("Primary.Range") then
		teamcol = self2.GetTeamColor(self, targent)
	end

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
