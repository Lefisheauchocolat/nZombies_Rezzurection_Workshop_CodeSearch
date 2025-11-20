local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Advanced Warfare"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox, Deika"
SWEP.Slot = 2
SWEP.PrintName = nzombies and "Magnetron | AW" or "Magnetron"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_aw/magnetron/c_magnetron.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_aw/magnetron/w_magnetron.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -1, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -6,
        Right = 1,
        Forward = 13,
        },
        Ang = {
		Up = -180,
        Right = 200,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_AW_MWAVE.Start"
SWEP.Primary.LoopSound = "TFA_AW_MWAVE.Loop"
SWEP.Primary.LoopSoundTail = "TFA_AW_MWAVE.Stop"
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 900
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 115
SWEP.Primary.Knockback = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 500
SWEP.MuzzleFlashEnabled = false
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
		{range = 500, damage = 0.1},
	}
}

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.1 -- Default value is 0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.1 -- Default value is 0.09

SWEP.ViewModelPunch_MaxVertialOffset				= 3 -- Default value is 3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 -- Default value is 1.95
SWEP.ViewModelPunch_VertialMultiplier				= 1 -- Default value is 1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 -- Default value is 0.25

SWEP.ViewModelPunchYawMultiplier = 0.1 -- Default value is 0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.1 -- Default value is 0.25

--[Spread Related]--
SWEP.Primary.Spread		  = .01
SWEP.Primary.IronAccuracy = .01
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.1
SWEP.Primary.KickDown			= 0.1
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor	= 0.2

SWEP.Primary.SpreadMultiplierMax = 0
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 0

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-3.555, -3, 0.4)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.4

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 0.925
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(2, -2, 1)
SWEP.SafetyAng = Vector(-20, 30, -15)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Positron"
SWEP.NZWonderWeapon = true
SWEP.Ispackapunched = false
SWEP.Primary.MaxAmmo = 500

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo( self.Primary_TFA.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary_TFA.ClipSize )
end

SWEP.MuzzleFlashEffectPAP = "tfa_aw_muzzleflash_magnetron_pap"

function SWEP:OnPaP()
self.Ispackapunched = true
self.MuzzleFlashEffect = "tfa_aw_muzzleflash_magnetron_pap"
self.OverheatTime = 6
self.MoveSpeed = 0.95
self:ClearStatCache()
return true
end

--[Tables]--
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
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_PULLBACK] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_AW_MWAVE.Overheat.In") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_AW_MWAVE.Overheat.Out") },
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

SWEP.CylinderRadius = 90
SWEP.CylinderRange = 500
SWEP.CylinderInnerRange = 100
SWEP.OverheatTime = 5
SWEP.CookingRate = 0.5

SWEP.Attachments = {
	[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local sp = game.SinglePlayer()
local pvp_bool = GetConVar("sbox_playershurtplayers")
local color_overheat = Color(255, 80, 0, 255)
local color_heat = Color(255, 160, 0, 255)
local vector_overheat = Vector()

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("Float", "SpinTime")
	self:NetworkVarTFA("Bool", "HasEmitSound")
end

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if self:GetStatus() == TFA.Enum.STATUS_SHOOTING then
		if (!self.CL_FPDrawFX or !self.CL_FPDrawFX:IsValid()) then
			self.CL_FPDrawFX = CreateParticleSystem(self.OwnerViewModel, "aw_magnetron_heat", PATTACH_POINT_FOLLOW, 1)
		else
			local ratio = math.Clamp(self:Clip1() / 100, 0, 1)
			if ratio > 0.2 then
				ratio = math.Remap(ratio, 0.2, 1, 0, 1)
				vector_overheat:SetUnpacked(ratio, ratio, ratio)

				self.CL_FPDrawFX:SetControlPoint(2, vector_overheat)

				local fuckshit = color_heat:ToVector()
				if ratio > 0.8 then
					ratio = math.Remap(ratio, 0.8, 1, 0, 1)
					fuckshit = color_heat:Lerp(color_overheat, ratio):ToVector()
				end
				self.CL_FPDrawFX:SetControlPoint(1, fuckshit)
			end
		end
	elseif self.CL_FPDrawFX and IsValid(self.CL_FPDrawFX) and self:Clip1() <= 0 then
		self.CL_FPDrawFX:StopEmission()
		self.CL_FPDrawFX = nil
	end
end

function SWEP:ShootBulletInformation()
	local ply = self:GetOwner()

	local trace = util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + VectorRand(-8,8) + self:GetAimVector()*(self.CylinderRange*0.6),
		filter = {self, ply},
		mask = MASK_SHOT,
	})

	if trace.Hit and not trace.HitSky then
		if IsFirstTimePredicted() then
			ParticleEffect(self.Ispackapunched and "aw_magnetron_hit_2" or "aw_magnetron_hit", trace.HitPos + trace.HitNormal, trace.HitNormal:Angle())
		end
	end
end

function SWEP:PrePrimaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if self:CanPrimaryAttack() and !self:GetHasEmitSound() then
		self:SetHasEmitSound(true)
		if IsFirstTimePredicted() then
			self:EmitGunfireSound(self:GetStatL("Primary.Sound"))
			self:EmitSound("TFA_AW_MWAVE.Rise")

			if self:VMIV() then
				ParticleEffectAttach(self.Ispackapunched and "aw_magnetron_muzzleflash_2" or "aw_magnetron_muzzleflash", PATTACH_POINT_FOLLOW, (self:IsFirstPerson() and self.OwnerViewModel or self), 1)
			end

			if SERVER then
				local fx = EffectData()
				fx:SetEntity(self)
				fx:SetAttachment(1)
				fx:SetNormal(self:GetAimVector())
				fx:SetFlags(self.Ispackapunched and 1 or 0)

				local filter = RecipientFilter()
				filter:AddPVS(ply:GetShootPos())
				if IsValid(ply) then
					filter:RemovePlayer(ply)
				end

				if filter:GetCount() > 0 then
					util.Effect("tfa_aw_magnetron_3p", fx, true, filter)
				end
			end
		end
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local aim = self:GetAimVector()
	if not IsValid(ply) then return end
	if CLIENT then return end

	local n_outer_range = self.CylinderRange
	local n_inner_range = self.CylinderInnerRange
	local n_cylinder_radius = self.CylinderRadius

	local n_outer_range_squared = n_outer_range * n_outer_range
	local n_inner_range_squared = n_inner_range * n_inner_range
	local n_radius_squared = n_cylinder_radius * n_cylinder_radius

	local angle = math.cos(math.rad(40))
	local view_pos = ply:GetShootPos()
	local forward_view_angles = self:GetAimVector()
	local end_pos = view_pos + (forward_view_angles * n_outer_range)

	for i, ent in pairs(ents.FindInSphere(view_pos, n_outer_range*1.1)) do
		if not (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then continue end
		if nzombies and ent:IsPlayer() then continue end
		if not pvp_bool:GetBool() and ent:IsPlayer() then continue end
		if ent == ply then continue end
		if ent:Health() <= 0 then continue end
		if ent:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end

		local test_origin = ent:WorldSpaceCenter()
		local test_range_squared = view_pos:DistToSqr(test_origin)
		if test_range_squared > n_outer_range_squared then
			continue // everything else in the list will be out of range
		end

		local normal = (test_origin - view_pos):GetNormalized()
		local dot = forward_view_angles:Dot(normal)
		if 0 > dot then
			continue // guy's behind us
		end

		local radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin )
		if test_origin:DistToSqr(radial_origin) > n_radius_squared then
			continue // guy's outside the range of the cylinder of effect
		end

		local tr1 = util.TraceLine({
			start = view_pos,
			endpos = test_origin,
			filter = {self, ply},
			mask = MASK_SHOT_HULL,
		})

		local hitpos = tr1.Entity == ent and tr1.HitPos or ent:WorldSpaceCenter()
		if not ply:VisibleVec(hitpos) then
			continue
		end

		local dist_ratio = (n_outer_range_squared - test_range_squared) / (n_outer_range_squared - n_inner_range_squared)
		local final_time = tonumber(Lerp(dist_ratio, 0.1, self.CookingRate))

		ent:AWMicrowave(final_time, ply, self, self.Ispackapunched, hitpos)
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local status = self:GetStatus()
	local statusend = self:GetStatusEnd() < CurTime()

	if self:GetHasEmitSound() and status ~= TFA.Enum.STATUS_SHOOTING then
		self:SetHasEmitSound(false)
		if IsFirstTimePredicted() then
			self:StopSound("TFA_AW_MWAVE.Rise")
			self:StopSoundNet("TFA_AW_MWAVE.Rise")

			self:CleanParticles()
		end
	end

	if SERVER then
		local ratio = math.Clamp((self:GetSpinTime() / self.OverheatTime), 0, 1)
		if self:GetSpinTime() > 0 then
			self:SetClip1(100*ratio)
		end
	end

	if IsValid(ply) and ply:IsPlayer() then
		if self:GetStatus() == TFA.Enum.STATUS_SHOOTING then
			self:SetSpinTime(math.Clamp(self:GetSpinTime() + engine.TickInterval(), 0, self.OverheatTime))

			if self:GetSpinTime() >= self.OverheatTime then
				self:StopSound("TFA_AW_MWAVE.Rise")
				self:StopSoundNet("TFA_AW_MWAVE.Rise")
				self:SetHasEmitSound(false)
				self:SetIronSightsRaw(false)

				if IsFirstTimePredicted() then
					self:CleanParticles()
				end

				self:SendViewModelAnim(ACT_VM_PULLBACK)
				self:ScheduleStatus(TFA.Enum.STATUS_OVERHEAT, self:GetActivityLength())
				self:SetNextPrimaryFire(self:GetStatusEnd())
			end
		else
			if self:GetSpinTime() > 0 then
				self:SetSpinTime(math.Approach(self:GetSpinTime(), 0, engine.TickInterval()*2))
			end
		end
	end

	return BaseClass.Think2(self,...)
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
	surface.SetMaterial(crosshair_flamethrower)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 24, y  - 24, 48, 48)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 24, ScrH() / 2 - 24, 48, 48)
	end
end