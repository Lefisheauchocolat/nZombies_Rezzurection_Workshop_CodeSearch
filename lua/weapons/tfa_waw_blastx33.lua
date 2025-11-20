local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Light Rifle from Halo 4 animated by BluntStuffy. \nFrom the World at War custom map 'Zombie Sumpf' by xJimmy33"
SWEP.Author = "BluntStuffy, xJimmy33, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Wunderwaffe Blast-X33 | WAW" or "Wunderwaffe Blast-X33"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true
SWEP.DrawWeaponInfoBox = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/blastx33/c_blastx33.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/blastx33/w_blastx33.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(1.2, 6, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -3,
        Right = 1,
        Forward = 15,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_WAW_BLASTX33.Shoot"
SWEP.Primary.Ammo = "CombineHeavyCannon"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 90
SWEP.Primary.Damage = 115
SWEP.Primary.DamageType = DMG_SHOCK
SWEP.Primary.PenetrationPower = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.HullSize = 5
SWEP.ImpactDecal = "FadingScorch"
SWEP.MuzzleFlashEffect = "tfa_bo3_muzzleflash_raygunmk2"
SWEP.TracerName = "tfa_waw_tracer_blastx33"
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
SWEP.Primary.Spread		  = .01
SWEP.Primary.IronAccuracy = .0001
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.8
SWEP.Primary.KickDown			= 0.6
SWEP.Primary.KickHorizontal		= 0.4
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 1
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 4

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.IronInSound = "weapon_bo3_gear.rattle"
SWEP.IronOutSound = "weapon_bo3_gear.rattle"
SWEP.Secondary.IronFOV = 65
SWEP.IronSightsPos = Vector(-3.755, -5, 0.26)
SWEP.IronSightsAng = Vector(2, 0, 0)
SWEP.IronSightTime = 0.4

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {ar2altfire = "Green"}
SWEP.VMOffsetWalk = Vector(-1, -1, -1)
SWEP.InspectPos = Vector(10, -5, -2)
SWEP.InspectAng = Vector(24, 42, 16)
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.RunSightsPos = Vector(1, -2, -0.5)
SWEP.RunSightsAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""
SWEP.ImpactEffect = ""
SWEP.TracerCount = 1

--[NZombies]--
SWEP.NZPaPName = "Wunderwaffe Blast-X115"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 64

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.MuzzleFlashEffectPAP = "tfa_bo3_muzzleflash_raygunmk2_pap"
SWEP.TracerNamePAP = "tfa_waw_tracer_blastx33_pap"

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.RPM = 240
self.Primary_TFA.Automatic = true
self.TracerName = "tfa_waw_tracer_blastx33_pap"
self.MuzzleFlashEffect = "tfa_bo3_muzzleflash_raygunmk2_pap"
self.WW3P_FX = "waw_lightrifle_3p_core_2"
self:ClearStatCache()
return true
end

SWEP.CustomBulletCallback = function(ply, trace, dmginfo)
	dmginfo:SetDamage(0)
	if CLIENT then return end
	local enemy = trace.Entity
	if IsValid(enemy) and ((not nzombies and enemy:IsPlayer()) or enemy:IsNPC() or enemy:IsNextBot()) and enemy:Health() > 0 then
		local ent = ents.Create("waw_ww_blastx33")
		ent:SetModel("models/dav0r/hoverball.mdl")
		ent:SetPos(enemy:GetPos())
		ent:SetAngles(angle_zero)

		ent:SetOwner(ply)
		ent:SetTarget(enemy)
		ent:SetAttacker(dmginfo:GetAttacker())
		ent:SetInflictor(dmginfo:GetInflictor())
		ent:SetUpgraded(dmginfo:GetInflictor().Ispackapunched)

		ent:Spawn()

		ent:SetOwner(ply)
	end
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 70 / 40,
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 20 / 45, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = true},
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
{ ["time"] = 10 / 45, ["type"] = "lua", value = function(self) self:CleanParticles() end, client = true, server = true},
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 20 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK2.Switch") },
{ ["time"] = 40 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK2.Draw") },
{ ["time"] = 45 / 45, ["type"] = "lua", value = function(self) self:EnableLights() end, client = true, server = true},
},
[ACT_VM_RELOAD] = {
{ ["time"] = 10 / 40, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK2.MagOut") },
{ ["time"] = 65 / 40, ["type"] = "sound", ["value"] = Sound("TFA_BO3_MK2.MagIn") },
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

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.GlowTime = 0
SWEP.WW3P_FX = "waw_lightrifle_3p_core"
SWEP.WW3P_ATT = 2

--[Effects]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Float", "NextWave")
end

function SWEP:Think2(...)
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		if self.GlowTime > CurTime() then
			self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)
			if self.DLight then
				local attpos = (self:IsFirstPerson() and self.OwnerViewModel or self):GetAttachment(1)

				self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
				self.DLight.r = 110
				self.DLight.g = 255
				self.DLight.b = 80
				self.DLight.decay = 500
				self.DLight.brightness = 0.5
				self.DLight.size = 64
				self.DLight.dietime = CurTime() + 1
			end
		end
	end

	if not self:GetNextWave() then
		self:SetNextWave(CurTime() + self:SharedRandom(8, 10))
	end

	if TFA.Enum.ReadyStatus[self:GetStatus()] and self:GetNextWave() < CurTime() then
		self:SetNextWave(CurTime() + self:SharedRandom(8, 12))
		self.GlowTime = CurTime() + 1

		if self:VMIV() then
			ParticleEffectAttach(self.Ispackapunched and "waw_lightrifle_idle_2" or "waw_lightrifle_idle", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
		end

		if SERVER then
			local ply = self:GetOwner()
			local fx = EffectData()
			fx:SetEntity(self)
			fx:SetAttachment(1)
			fx:SetFlags(self.Ispackapunched and 2 or 1)

			local filter = RecipientFilter()
			filter:AddPVS(ply:GetShootPos())
			if IsValid(ply) and self:IsFirstPerson() then
				filter:RemovePlayer(ply)
			end

			if filter:GetCount() > 0 then
				util.Effect("tfa_waw_lightrifle_3p", fx, true, filter)
			end
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:EnableLights()
	if not self:VMIV() then return end
	self:CleanParticles()

	if IsFirstTimePredicted() then 
		ParticleEffectAttach(self.Ispackapunched and "waw_lightrifle_core_2" or "waw_lightrifle_core", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
		ParticleEffectAttach(self.Ispackapunched and "waw_lightrifle_coreb_2" or "waw_lightrifle_coreb", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 3)
	end
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		vm:SetSubMaterial(0, "models/weapons/tfa_waw/blastx33/mtl_light_rifle_pap.vmt")
		vm:SetSubMaterial(1, "models/weapons/tfa_waw/blastx33/rg2_glow_pap.vmt")
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(1, nil)
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

local crosshair_revive = Material("vgui/overlay/revive_reticle.png", "smooth unlitgeneric")
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
	surface.SetMaterial(crosshair_revive)

	local scale = ScreenScale(8)
	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - scale, y  - scale, scale*2, scale*2)
	else
		surface.DrawTexturedRect(ScrW() / 2 - scale, ScrH() / 2 - scale, scale*2, scale*2)
	end
end