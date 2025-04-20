local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "KT-4 | BO3" or "KT-4"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/mirg2000/c_mirg2000.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/mirg2000/w_mirg2000.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -6, -1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 1,
        Forward = 4,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_MIRG.Shoot"
SWEP.Primary.Ammo = "AR2AltFire"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 220
SWEP.Primary.Damage = 1150000
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 10
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 7
SWEP.Primary.Delay = 0.35
SWEP.MuzzleFlashEffect	= "tfa_bo3_muzzleflash_mirg2k"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false
SWEP.MuzzleFlashEnabled = true

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
SWEP.Primary.Spread		  = .045
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.6
SWEP.Primary.KickDown			= 0.6
SWEP.Primary.KickHorizontal		= 0.2
SWEP.Primary.StaticRecoilFactor	= 0.4

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 2
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 70
SWEP.IronSightsPos = Vector(-5.63, -4.5, -0.92)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.35

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = "models/entities/tfa_bo3/wunderwaffe/stripperclip.mdl"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo3_ww_mirg" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 3000 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/dav0r/hoverball.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {ar2altfire = "#tfa.ammo.bo3ww.mirg"}
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Masamune"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 36

function SWEP:NZMaxAmmo()

	local ammo_type = self:GetPrimaryAmmoType() or self.Primary_TFA.Ammo

	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
	end
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 6
SWEP.Primary.MaxAmmoPAP = 36
SWEP.MuzzleFlashEffectPAP	= "tfa_bo3_muzzleflash_mirg2k_pap"
SWEP.MoveSpeedPAP = 0.95

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 6
self.Primary_TFA.MaxAmmo = 36
self.MuzzleFlashEffect	= "tfa_bo3_muzzleflash_mirg2k_pap"
self.MoveSpeed = 0.95
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 40 / 30,
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
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Stop") },
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_IDLE] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Idle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Prime") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Start") },
{ ["time"] = 35 / 30, ["type"] = "lua", value = function(self) self:DaSmokey() end, client = true, server = true},
{ ["time"] = 30 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Rechamber") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Stop") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Magout") },
{ ["time"] = 35 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Magin") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Rechamber") },
{ ["time"] = 65 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MIRG.Start") },
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

SWEP.ChargeStages = 3
SWEP.ChargeStageTime = .7

SWEP.Lights = {
	[0] = Material("models/weapons/tfa_bo3/mirg2000/mtl_wpn_t7_zmb_dlc2_mirg2000_glow3.vmt"),
	[1] = Material("models/weapons/tfa_bo3/mirg2000/mtl_wpn_t7_zmb_dlc2_mirg2000_glow2.vmt"),
	[2] = Material("models/weapons/tfa_bo3/mirg2000/mtl_wpn_t7_zmb_dlc2_mirg2000_glow1.vmt"),
}

SWEP.Glow = Material("models/weapons/tfa_bo3/mirg2000/mtl_wpn_t7_zmb_dlc2_mirg2000_glo.vmt")


--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:DaSmokey()
	if self:VMIV() and IsFirstTimePredicted() then
		ParticleEffectAttach(self.Ispackapunched and "bo3_mirg2k_vm_smoke_2" or "bo3_mirg2k_vm_smoke", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 5)
	end
end

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		self.Glow:SetVector("$color2", Vector(0,1,1))
		self.Glow:SetVector("$emissiveblendtint", Vector(0,2,2))
		if !cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool()) then
			vm:SetSubMaterial(3, self.nzPaPCamo)
			vm:SetSubMaterial(4, self.nzPaPCamo)
			vm:SetSubMaterial(7, self.nzPaPCamo)
			vm:SetSubMaterial(12, self.nzPaPCamo)
		end
	else
		self.Glow:SetVector("$color2", Vector(0,1,0))
		self.Glow:SetVector("$emissiveblendtint", Vector(0,1,0))
		vm:SetSubMaterial(3, nil)
		vm:SetSubMaterial(4, nil)
		vm:SetSubMaterial(7, nil)
		vm:SetSubMaterial(12, nil)
	end
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)
	
	self:NetworkVarTFA("Int", "ChargeStage")
	self:NetworkVarTFA("Float", "BeginChargeTime")
	self:NetworkVarTFA("Float", "TotalChargeTime")
	self:NetworkVarTFA("Bool", "PlayedTriggerSound")
end

function SWEP:Initialize(...)
	local light = self:GetStat("Lights")
	local keys = table.GetKeys(light)
	for i = 1, #keys do
		light[keys[i]]:SetVector("$emissiveblendtint", Vector(0,0,0))
	end

	return BaseClass.Initialize(self,...)
end

function SWEP:ResetLock()
	if self:GetBeginChargeTime() == 0 then return end
	self:SetChargeStage(0)
	self:SetBeginChargeTime(0)
	self:SetPlayedTriggerSound(false)
	local light = self:GetStat("Lights")
	local keys = table.GetKeys(light)
	for i = 1, #keys do
		light[keys[i]]:SetVector("$emissiveblendtint", Vector(0,0,0))
	end
end

-- thank you tf2 source code
function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	if not self:CanPrimaryAttack() then return end

	if not ply:IsPlayer() then
		return BaseClass.PrimaryAttack(self)
	end

	if ply:KeyDown(IN_RELOAD) then return end

	if self:GetBeginChargeTime() <= 0 then
		self:SetBeginChargeTime(CurTime())

		self:EmitSoundNet("TFA_BO3_MIRG.Charge2")

		if not self:GetPlayedTriggerSound() then
			self:EmitGunfireSound("TFA_BO3_MIRG.Charge1")
			self:SetPlayedTriggerSound(true)
		end

		local light = self:GetStat("Lights")
		local keysl = table.GetKeys(light)
		for i = 1, #keysl do
			if self:GetChargeStage() == keysl[i] then
				light[keysl[i]]:SetVector("$emissiveblendtint", self:LightsPaP())
			end
		end

		self:SetChargeStage(self:GetChargeStage() + 1)
		if self:GetChargeStage() >= self.ChargeStages then
			self:DaSmokey()
		end
	else
		if self:GetChargeStage() < math.min(self:Clip1(), self.ChargeStages) then
			self:SetTotalChargeTime(CurTime() - self:GetBeginChargeTime())

			if self:GetTotalChargeTime() >= self.ChargeStageTime then
				self:SetBeginChargeTime(0)
			end
		end

		local progress = self:GetBeginChargeTime() + self.ChargeStageTime
		progress = 1 - math.Clamp((progress - CurTime()) / self.ChargeStageTime, 0, 1)

		if progress >= 0.2 and progress <= 0.2 + engine.TickInterval() then //hehehe
			if IsFirstTimePredicted() then self:EmitSoundNet("TFA_BO3_MIRG.Charge3") end
		end
	end
end

function SWEP:LaunchGrenade()
	if self:GetChargeStage() > 0 then
		self:TakePrimaryAmmo(self:GetChargeStage()-1)
	end
	self:SetPlayedTriggerSound(false)
	if self:GetChargeStage() == 1 then
		self:StopSoundNet("TFA_BO3_MIRG.Charge1")
		self:StopSoundNet("TFA_BO3_MIRG.Charge2")
		self:StopSoundNet("TFA_BO3_MIRG.Charge3")
	end

	return BaseClass.PrimaryAttack(self)
end

function SWEP:PostPrimaryAttack()
	self:EmitGunfireSound("TFA_BO3_MIRG.Shoot.Charge."..self:GetChargeStage())
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() then
		ply.mirg2kachievmentKills = 0
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	if ply:IsPlayer() then
		if TFA.Enum.ReadyStatus[self:GetStatus()] and not self:GetSprinting() then
			if self:GetBeginChargeTime() > 0 and not ply:KeyDown(IN_ATTACK) then
				self:LaunchGrenade()
				self:ResetLock()
			end
		else
			self:ResetLock()
		end
	end
	
	BaseClass.Think2(self, ...)
end

function SWEP:Reload(...)
	if self:GetOwner():IsPlayer() then
		if self:GetChargeStage() > 0 or self:GetOwner():KeyDown(IN_ATTACK) then
			self:ResetLock()

			self:SetStatus(TFA.GetStatus("idle"))
			self:SetNextPrimaryFire(CurTime() + self.ChargeStageTime)
			return
		end
	end
	BaseClass.Reload(self, ...) 
end

function SWEP:LightsPaP()
	if self.Ispackapunched then
		return Vector(0,1,1)
	end
	return Vector(0,1,0)
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetCharge(self:GetChargeStage())
	ent:SetUpgraded(self.Ispackapunched)
end

/*function SWEP:PostSpawnProjectile(ent)
	local ply = self:GetOwner()
	local phys = ent:GetPhysicsObject()
	local vel = self:GetStat("Primary.ProjectileVelocity")

	local spread = (self:GetIronSights() and Vector(0,0,0) or VectorRand(-80,80))

	if ply:IsPlayer() then
		if IsValid(phys) then
			phys:SetVelocity((ply:GetAimVector() * vel) + spread)
		end
	end
end*/

function SWEP:OnDrop(...)
	self:StopSound("TFA_BO3_MIRG.Idle")
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:StopSound("TFA_BO3_MIRG.Idle")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster( ... )
	self:StopSoundNet("TFA_BO3_MIRG.Idle")
	return BaseClass.Holster(self,...)
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