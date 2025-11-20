local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "nZombies Powerups"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Deathmachine Powerup"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = "Death Machine"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/mingun/c_mingun.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/mingun/w_mingun.mdl"
SWEP.HoldType = "physgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.MuzzleAttachmentSilenced = "2"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -3,
        Right = 3.5,
        Forward = -5,
        },
        Ang = {
		Up = -170,
        Right = 190,
        Forward = 10
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_MINGN.Start"
SWEP.Primary.LoopSound = "TFA_BO3_MINGN.Loop"
SWEP.Primary.LoopSoundTail = "TFA_BO3_MINGN.Stop"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1200
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 115
SWEP.Primary.Knockback = 0
SWEP.Primary.NumShots = 3
SWEP.Primary.AmmoConsumption = 0
SWEP.Primary.ClipSize = 666
SWEP.Primary.DefaultClip = 666
SWEP.Primary.DryFireDelay = 0.35
SWEP.DisableChambering = true
SWEP.FiresUnderwater = true

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0 --0.33
SWEP.LowAmmoSound = ""
SWEP.LastAmmoSound = ""

--[Range]--
SWEP.Primary.DisplayFalloff = true
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
		{range = 100, damage = 1.0},
	}
}

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.09 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 3.0 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.5 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.25 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.65 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Spread Related]--
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .01
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.2
SWEP.Primary.KickDown			= 0.1
SWEP.Primary.KickHorizontal		= 0.1
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 2

SWEP.ChangeStateAccuracyMultiplier = 1.5 --1.5
SWEP.CrouchAccuracyMultiplier = 1.0 --0.5
SWEP.JumpAccuracyMultiplier = 3.0 --2
SWEP.WalkAccuracyMultiplier = 1.35 --1.35

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = "models/tfa/rifleshell.mdl"
SWEP.LuaShellScale = 0.5
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {ar2 = "7.62x51mm"}
SWEP.InspectPos = Vector(11, -2, -3)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(-1, -2, -0.5)
SWEP.SafetyAng = Vector(-15, 25, -20)
SWEP.TracerCount = 3

--[NZombies]--
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "display"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}

SWEP.AmmoRegen = 3

function SWEP:NZSpecialHolster(wep)
	local ply = self:GetOwner()
	if SERVER and IsValid(ply) then
		ply:SetUsingSpecialWeapon(false)
		ply:EquipPreviousWeapon()
		ply:RemovePowerUp("deathmachine")
	end
	return true
end

SWEP.CustomBulletCallback = function(ply, tr, dmg)
	if SERVER and nzombies then
		local ent = tr.Entity
		if IsValid(ent) and ent:IsValidZombie() and ply:IsPlayer() then
			local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
			local health = nzCurves.GenerateHealthCurve(round)

			dmg:SetDamage(health / 3)

			if ent.NZBossType then
				dmg:SetDamage(math.max(200, ent:GetMaxHealth() / 80))
				dmg:ScaleDamage(math.Round(nzRound:GetNumber()/8))
			end
		end
	end
end

--[Animations]--
SWEP.Animations = {
}

--[Tables]--
SWEP.SequenceLengthOverride = {
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.heavy") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MINGN.Equip") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.heavy") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

SWEP.SpinSpeed = 1
SWEP.SpinAng = 0

--[Attachments]--
SWEP.ViewModelBoneMods = {
	["tag_barrel_spin"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local sp = game.SinglePlayer()

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self,...)

	self:NetworkVarTFA("Float", "SpinTime")
	self:NetworkVarTFA("Bool", "IsSpinning")
end

function SWEP:GetAmmoForceMultiplier()
	return 1
end

function SWEP:CanPrimaryAttack(...)
	if self:GetOwner():IsPlayer() and self:GetSpinTime() < 1 then
		return false
	end
    return BaseClass.CanPrimaryAttack(self,...)
end

function SWEP:CanSpinUp()
    stat = self:GetStatus()

    if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:IsSafety() then
		return false
	end

    return true
end

function SWEP:Think2(...)
	local status = self:GetStatus()
	local ply = self:GetOwner()

	if CLIENT and ply:IsPlayer() then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			self.SpinSpeed = math.Approach(self.SpinSpeed, 20, FrameTime()*60)
		end
		self:DoSpin()
	end

	if CLIENT and sp then
        return BaseClass.Think2(self,...)
	end

	if IsValid(ply) and ply:IsPlayer() then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			if not self:GetIsSpinning() then
				if IsFirstTimePredicted() then self:EmitSoundNet("TFA_BO3_MINGN.SpinStart") end
			end

			self:SetIsSpinning(true) 
		else
			if l_CT() > self:GetNextPrimaryFire() or self.Primary.Automatic then
				if self:GetIsSpinning() then
					if IsFirstTimePredicted() then self:EmitSoundNet("TFA_BO3_MINGN.SpinStop") end
				end

				self:SetIsSpinning(false)
			end
		end
		if self:GetIsSpinning() then
			self:SetSpinTime(self:GetSpinTime() + (FrameTime() / 0.4))

			if self:GetSpinTime() >= 1 then
				self:EmitSoundNet("TFA_BO3_MINGN.SpinLoop")

				if not (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) then
					self:SetIsSpinning(false)
				end
			end 
		else
			self:SetSpinTime(0)
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:DoSpin()
	if not CLIENT then return end
	if not sp and not IsFirstTimePredicted() then return end

	self.SpinAng = self.SpinAng or 0
	self.SpinSpeed = self.SpinSpeed or 10
		
	if self.SpinAng > 7200 then
		self.SpinAng = -7200
	end

	self.SpinAng = self.SpinAng - self.SpinSpeed

	if self.SpinSpeed > 0 then
		self.SpinSpeed = self.SpinSpeed * 0.98
	elseif self.SpinSpeed < 0 then
		self.SpinSpeed = 0
	end

	self.ViewModelBoneMods["tag_barrel_spin"].angle = Angle(0, 0, -self.SpinAng)
end

function SWEP:OnDrop(...)
	self:StopSound("TFA_BO3_MINGN.Loop")
	self:StopSound("TFA_BO3_MINGN.SpinLoop")
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_BO3_MINGN.Loop")
	self:StopSound("TFA_BO3_MINGN.SpinLoop")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSoundNet("TFA_BO3_MINGN.Loop")
	self:StopSoundNet("TFA_BO3_MINGN.SpinLoop")
	return BaseClass.Holster(self,...)
end

local crosshair_minigun = Material("vgui/overlay/reticle_minigun.png", "smooth unlitgeneric")
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

local sv_tfa_fixed_crosshair = GetConVar("sv_tfa_fixed_crosshair")
local crossr_cvar = GetConVar("cl_tfa_hud_crosshair_color_r")
local crossg_cvar = GetConVar("cl_tfa_hud_crosshair_color_g")
local crossb_cvar = GetConVar("cl_tfa_hud_crosshair_color_b")
local crosscol = Color(255, 255, 255, 255)

function SWEP:DrawHUDBackground() //hehe funny copy paste entire function to change 1 thing
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
	surface.SetMaterial(crosshair_minigun)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 32, y  - 32, 64, 64)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 64)
	end
end
