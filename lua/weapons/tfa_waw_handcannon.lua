local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Joke weapon from Dead Space animated by chromastone10. \nFrom the World at War custom map 'Exo Zombies' by chromastone10 \n\nCannot be manually reloaded, automatically reloads when not firing for 6 seconds."
SWEP.Author = "chromastone10, FlamingFox"
SWEP.Slot = 1
SWEP.PrintName = nzombies and "Hand Cannon | WAW" or "Hand Cannon"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/handcannon/c_handcannon.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/handcannon/w_handcannon.mdl"
SWEP.HoldType = "pistol"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -4,
        Right = 1.2,
        Forward = 13,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_WAW_HANDCANNON.Shoot"
SWEP.Primary.Sound_DryFire = "TFA_BO2_RAYGUN.Deny"
SWEP.Primary.Sound_Blocked = "TFA_BO2_RAYGUN.Deny"
SWEP.Primary.Ammo = "HelicopterGun"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 666
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 115 or 50
SWEP.Primary.Knockback = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEnabled	= false
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
SWEP.Primary.Range = 800
SWEP.Primary.RangeFalloff = 200
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
		{range = 200, damage = 1.0},
		{range = 800, damage = 0.33},
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
SWEP.Primary.Spread		  = .02
SWEP.Primary.IronAccuracy = .02
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.5
SWEP.Primary.KickDown			= 0.5
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 1
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 1

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {helicoptergun = "BANG! BANG!"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.RunSightsPos = Vector(2, -9, -9)
SWEP.RunSightsAng = Vector(45, 0, 0)
SWEP.SmokeParticle = ""
SWEP.TraceCount = 0
SWEP.ImpactEffect = ""

--[NZombies]--
SWEP.NZPaPName = "Hand Cannon Full-Auto"
SWEP.NZWonderWeapon = false
SWEP.NZUniqueWeapon = true
SWEP.Primary.MaxAmmo = 450

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self.Owner:SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.RegenDelay = 6
SWEP.RoundDropOffInterval = 4

function SWEP:OnPaP()
self.Ispackapunched = true
self.RegenDelay = 5
self.RoundDropOffInterval = 6
self.Primary_TFA.Automatic = true
self.Primary_TFA.MaxAmmo = 500
self.Primary_TFA.RPM = 666
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_HANDCANNON.Short") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("TFA_WAW_HANDCANNON.Short") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 5 / 35, ["type"] = "sound", ["value"] = Sound("TFA_WAW_HANDCANNON.Cloth") },
{ ["time"] = 20 / 35, ["type"] = "sound", ["value"] = Sound("TFA_WAW_HANDCANNON.Cloth") },
{ ["time"] = 35 / 35, ["type"] = "sound", ["value"] = Sound("TFA_WAW_HANDCANNON.Short") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1

DEFINE_BASECLASS( SWEP.Base )

local sp = game.SinglePlayer()
local pvp_bool = GetConVar("sbox_playershurtplayers")
local developer = GetConVar("developer")

local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("Float", "NextRegen")
end

local lock_mins = Vector(4, 4, 4)*-1
local lock_maxs = Vector(4, 4, 4)
local doorsclasses = {
	["func_door_rotating"] = true,
	["prop_door_rotating"] = true,
}

function SWEP:ShootBulletInformation()
end

function SWEP:PrePrimaryAttack()
	self:SetNextRegen(CurTime())
	local ply = self:GetOwner()

	if ply:IsPlayer() then
		ply:LagCompensation(true)
	end

	local tr = util.TraceLine({
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + (self:GetAimVector() * self:GetStatL("Primary.Range")),
		filter = {ply, self},
		mins = lock_mins,
		maxs = lock_maxs,
		mask = MASK_SHOT_HULL,
	})

	if ply:IsPlayer() then
		ply:LagCompensation(false)
	end

	local ent = tr.Entity
	if IsValid(ent) then
		if IsFirstTimePredicted() then
			ParticleEffect("bo3_thundergun_hit", tr.HitPos, (tr.StartPos - tr.HitPos):Angle())
		end

		if SERVER then
			local falloff = math.min(self:GetStatL("Primary.RangeFalloff") / self:GetStatL("Primary.Range"), 0.95)
			local ratio = math.Clamp((1 - tr.Fraction) / (1 - falloff), 0, 1)
			local mydamage = self:GetStatL("Primary.Damage")

			if nzombies and ent:IsValidZombie() then
				local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
				local health = tonumber(nzCurves.GenerateHealthCurve(round))

				mydamage = math.Round(health / math.Clamp(round/self.RoundDropOffInterval, 1, 5)) + 115
			end

			mydamage = mydamage*self:GetStatL("Primary.NumShots")

			mydamage = Lerp(ratio, mydamage/3, mydamage)

			local damage = DamageInfo()
			damage:SetDamageType(DMG_AIRBOAT)
			damage:SetAttacker(ply)
			damage:SetInflictor(self)
			damage:SetDamage(mydamage)
			damage:SetDamagePosition(tr.HitPos)
			damage:SetDamageForce((tr.HitPos - tr.StartPos):GetNormalized() * 24000)

			if nzombies and (ent.NZBossType or ent.IsMooBossZombie) then
				local fuck = 60*self:GetStatL("Primary.NumShots")
				damage:SetDamage(math.max(Lerp(ratio, fuck/3, fuck), ent:GetMaxHealth() / 80))
			end

			ent:TakeDamageInfo(damage)

			if ratio == 1 and doorsclasses[ent:GetClass()] then
				self:HandleDoor(ent)
			end
		end
	else
		if tr.Hit and !tr.HitSky and IsFirstTimePredicted() then
			ParticleEffect("bo3_thundergun_hit", tr.HitPos + tr.HitNormal, tr.HitNormal:Angle())
		end
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local ct = CurTime()
	if ply:IsPlayer() and TFA.Enum.ReadyStatus[self:GetStatus()] and self:GetNextRegen() + self.RegenDelay < ct and self:Clip1() < self:GetStatL("Primary.ClipSize") and self:Ammo1() > 0 then
		self:SetStatus(TFA.Enum.STATUS_RELOADING)
		self:SetStatusEnd(ct + engine.TickInterval())
		self:SetNextPrimaryFire(self:GetStatusEnd())
		if CLIENT then
			self.ReloadAnimationStart = ct
			self.ReloadAnimationEnd = ct + engine.TickInterval()
		end
		if not sp or not self:IsFirstPerson() then
			ply:SetAnimation(PLAYER_RELOAD)
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:Reload()
	return false
end

local cv_doordestruction = GetConVar("sv_tfa_melee_doordestruction")

function SWEP:HandleDoor(ent)
	if CLIENT then return end
	if not cv_doordestruction:GetBool() then return end
	if ent:GetClass() ~= "func_door_rotating" and ent:GetClass() ~= "prop_door_rotating" then return end
	if ent.TFADoorUntouchable and ent.TFADoorUntouchable > CurTime() then return end

	ent:EmitSound("ambient/materials/door_hit1.wav", 100, math.random(80, 120))

	local newname = "TFABash" .. self:EntIndex()
	self.PreBashName = self:GetName()
	self:SetName(newname)

	ent:Fire("unlock", "", .01)
	ent:SetKeyValue("Speed", "500")
	ent:SetKeyValue("Open Direction", "Both directions")
	ent:SetKeyValue("opendir", "0")
	ent:Fire("openawayfrom", newname, .01)
	ent.TFADoorUntouchable = CurTime() + 4

	timer.Simple(0.02, function()
		if not IsValid(self) or self:GetName() ~= newname then return end
		self:SetName(self.PreBashName)
	end)

	timer.Simple(0.3, function()
		if IsValid(ent) then
			ent:SetKeyValue("Speed", "100")
		end
	end)
end

local crosshair_flechette = Material("vgui/overlay/hud_flamethrower_reticle_t5.png", "smooth unlitgeneric")
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
	surface.SetMaterial(crosshair_flechette)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 32, y - 32, 64, 64)
	else
		surface.DrawTexturedRect((ScrW() / 2) - 32, (ScrH() / 2) - 32, 64, 64)
	end
end