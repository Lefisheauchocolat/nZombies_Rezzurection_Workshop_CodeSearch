local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "BO1 Scavenger remake by Rayjiun"
SWEP.Author = "Rayjiun, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = "Scavenger"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/scavenger/c_scavenger.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/scavenger/w_scavenger.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -5.5,
        Right = 1,
        Forward = 14,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = 5
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_SCAVENGER.Shoot"
SWEP.Primary.Ammo = "XBowBolt"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 350
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.RPM_Displayed = 60
SWEP.Primary.Damage = nzombies and 4000 or 300
SWEP.Primary.Knockback = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect = "tfa_bo3_muzzleflash_scavenger"
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil
SWEP.PumpAction = {
	["type"] = TFA.Enum.ANIMATION_ACT,
	["value"] = ACT_VM_PULLBACK,
	["value_empty"] = ACT_VM_PULLBACK,
}

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
SWEP.Primary.Spread		  = .055
SWEP.Primary.IronAccuracy = .001
SWEP.IronRecoilMultiplier = 0.8
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 1.2
SWEP.Primary.KickDown			= 0.8
SWEP.Primary.KickHorizontal		= 1.0
SWEP.Primary.StaticRecoilFactor	= 0.3

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 4
SWEP.Primary.SpreadRecovery = 5

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 40
SWEP.IronSightsPos = Vector(-3.927, -2, 0.78)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.IronSightTime = 0.45

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellModel = nil
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Projectile]--
SWEP.Primary.Projectile         = "bo3_ww_scavenger" -- Entity to shoot
SWEP.Primary.ProjectileVelocity = 3500 -- Entity to shoot's velocity
SWEP.Primary.ProjectileModel    = "models/weapons/tfa_bo3/scavenger/scavenger_projectile.mdl" -- Entity to shoot's model

--[Misc]--
SWEP.AmmoTypeStrings = {xbowbolt = "#tfa.ammo.bo3ww.115bolt"}
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 0.925
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)

--[NZombies]--
SWEP.NZPaPName = "Hyena Infra-Dead"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 15

function SWEP:NZMaxAmmo()
	local ammo_type = self:GetPrimaryAmmoType() or self.Primary_TFA.Ammo
	if SERVER then
		self.Owner:SetAmmo( self.Primary.MaxAmmo, ammo_type )
		self:SetClip1( self.Primary.ClipSize )
	end
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 6
SWEP.Primary.DamagePAP = 500
SWEP.Primary.MaxAmmoPAP = 30
SWEP.MuzzleFlashEffectPAP = "tfa_bo3_muzzleflash_scavenger_pap"
SWEP.MoveSpeedPAP = 0.95

function SWEP:OnPaP()
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 6
self.Primary_TFA.Damage = 8800
self.Primary_TFA.MaxAmmo = 30
self.MuzzleFlashEffect = "tfa_bo3_muzzleflash_scavenger_pap"
self.MoveSpeed = 0.95
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 85 / 30,
}
SWEP.SequenceLengthOverride ={
	[ACT_VM_HOLSTER] = 40 / 45,
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
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 10 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltUp") },
{ ["time"] = 15 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltBack") },
{ ["time"] = 20 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltForward") },
{ ["time"] = 25 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltDown") },
},
[ACT_VM_PULLBACK] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltUp") },
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltBack") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltForward") },
{ ["time"] = 25 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltDown") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 10 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltUp") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltBack") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.MagOut") },
{ ["time"] = 52 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.Futz") },
{ ["time"] = 80 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.MagIn") },
{ ["time"] = 100 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltForward") },
{ ["time"] = 105 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BoltDown") },
{ ["time"] = 110 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SCAVENGER.BeepReload") },
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
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.Bodygroups_V = {
	[1] = 0
}

SWEP.DTapActivities = {
	[ACT_VM_PRIMARYATTACK] = true,
	[ACT_VM_PRIMARYATTACK_EMPTY] = true,
	[ACT_VM_PRIMARYATTACK_SILENCED] = true,
	[ACT_VM_PRIMARYATTACK_1] = true,
	[ACT_VM_SECONDARYATTACK] = true,
	[ACT_VM_HITCENTER] = true,
	[ACT_SHOTGUN_PUMP] = true,
	[ACT_VM_PULLBACK] = true,
}

--[RTScope]--
SWEP.RTDrawEnabled = true
SWEP.RTReticleMaterial = Material("models/weapons/tfa_bo3/scavenger/reticle")
SWEP.RTReticleMaterialPAP = Material("models/weapons/tfa_bo3/scavenger/upgraded_reticle")
SWEP.RTShadowMaterial = Material("vgui/scope_shadowmask_test")
SWEP.RTReticleScale = 1
SWEP.RTShadowScale = 2
SWEP.RTMaterialOverride = -1 -- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque = true -- Do you want your render target to be opaque?
SWEP.RTScopeFOV = 20 -- Default FOV / Scope Zoom / screenscale
SWEP.RTBGBlur = true -- Draw background blur when 3D scope is active?

local cd = {}
local fallbackReticle = Material("scope/gdcw_scopesightonly")
local fallbackShadow = Material("vgui/scope_shadowmask_test")
local flipcv = GetConVar("cl_tfa_viewmodel_flip")

-- im using RT because its the only way i know how to do the thermal vision (cam.start3d)
SWEP.RTCode = function(self, rt, scrw, scrh)
	if not self.OwnerIsValid or not self:VMIV() then return end

	local rtw, rth = rt:Width(), rt:Height()
	-- clearing view
	render.OverrideAlphaWriteEnable(true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-rtw, -rth, rtw * 2, rth * 2)

	local vm = self.OwnerViewModel

	local ang = vm:GetAngles()
	ang:RotateAroundAxis(ang:Forward(), -self:GetStat("IronSightsAng").z)

	local scopeAtt = self:GetStat("RTScopeAttachment", -1)

	if scopeAtt > 0 then
		local AngPos = vm:GetAttachment(scopeAtt)

		if AngPos then
			ang = AngPos.Ang

			if flipcv:GetBool() then
				ang.y = -ang.y
			end
		end
	end
	--ang:RotateAroundAxis(ang:Forward(), -22.5)

	cd.angles = ang
	cd.origin = self:GetOwner():GetShootPos()
	cd.x = 0
	cd.y = 0
	cd.w = rtw
	cd.h = rth
	cd.fov = self:GetStat("RTScopeFOV", 90 / self:GetStat("ScopeZoom", 1) / 2)
	cd.drawviewmodel = false
	cd.drawhud = false

	local tab = ents.GetAll()

	-- main RT render view
	render.Clear(0, 0, 0, 255, true, true)
	render.SetScissorRect(0, 0, rtw, rth, true)

	if self:GetIronSightsProgress() > .75 then
		render.RenderView(cd)
		
		if self.Ispackapunched then
			cam.Start3D(cd.origin, cd.angles)

			-- thermal highlighting start

			for _, ent in pairs(tab) do
				if ent == (self:GetOwner() or self:GetOwner():GetViewModel()) then continue end
				if ent:IsValid() and (ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot()) then

					if not ent:IsEffectActive(EF_NODRAW) then
						render.SuppressEngineLighting(false)
						render.MaterialOverride( Material("vgui/overlay/white") )
						render.SetBlend(1)
						ent:DrawModel()
					end
				end
			end

			render.SetBlend(1)
			render.MaterialOverride(nil)
			render.SuppressEngineLighting(false)

			DrawColorModify({
				[ "$pp_colour_addr" ] 		= 0,
				[ "$pp_colour_addg" ] 		= 134/255,
				[ "$pp_colour_addb" ] 		= 189/255,
				[ "$pp_colour_brightness" ] = 0,
				[ "$pp_colour_contrast" ]	= 0.5,
				[ "$pp_colour_colour" ] 	= 0.8,
				[ "$pp_colour_mulr" ] 		= 0,
				[ "$pp_colour_mulg" ] 		= 0,
				[ "$pp_colour_mulb" ] 		= 0
			})
			DrawBloom( 0.65, 1, 10, 10, 1, 1, 1, 1, 1 )
			-- thermal highlighting end

			cam.End3D()
		end
	end

	render.SetScissorRect(0, 0, rtw, rth, false)
	render.OverrideAlphaWriteEnable(false, true)

	cam.Start2D()
	
	-- ADS transition darkening
	draw.NoTexture()
	surface.SetDrawColor(ColorAlpha(color_black, 255 * (1 - self:GetIronSightsProgress())))
	surface.DrawRect(0, 0, rtw, rth)

	if self.Ispackapunched then
		surface.SetMaterial(self:GetStat("RTReticleMaterialPAP", fallbackReticle))
		surface.SetDrawColor(self:GetStat("RTReticleColor", color_white))
		local retScale = self:GetStat("RTReticleScale", 1)
		surface.DrawTexturedRect(rtw / 2 - rtw * retScale / 2, rth / 2 - rth * retScale / 2, rtw * retScale, rth * retScale)
	else
		surface.SetMaterial(self:GetStat("RTReticleMaterial", fallbackReticle))
		surface.SetDrawColor(self:GetStat("RTReticleColor", color_white))
		local retScale = self:GetStat("RTReticleScale", 1)
		surface.DrawTexturedRect(rtw / 2 - rtw * retScale / 2, rth / 2 - rth * retScale / 2, rtw * retScale, rth * retScale)
	end
	surface.SetMaterial(self:GetStat("RTShadowMaterial", fallbackShadow))
	surface.SetDrawColor(self:GetStat("RTShadowColor", color_white))
	local shadScale = self:GetStat("RTShadowScale", 2)
	surface.DrawTexturedRect(rtw / 2 - rtw * shadScale / 2, rth / 2 - rth * shadScale / 2, rtw * shadScale, rth * shadScale)
	
	cam.End2D()
end

DEFINE_BASECLASS( SWEP.Base )

function SWEP:Think2()
	if self:GetIronSightsProgress() >= 0.9 then
		self.Bodygroups_V = {[1] = 1}
	else
		self.Bodygroups_V = {[1] = 0}
	end

	return BaseClass.Think2(self)
end

local cvar_papcamoww = GetConVar("nz_papcamo_ww")

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		if !cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool()) then
			vm:SetSubMaterial(0, self.nzPaPCamo)
			vm:SetSubMaterial(1, self.nzPaPCamo)
			vm:SetSubMaterial(4, self.nzPaPCamo)
		end
		vm:SetSubMaterial(2, "models/weapons/tfa_bo3/scavenger/mtl_scavenger_wires_up.vmt")
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(1, nil)
		vm:SetSubMaterial(2, nil)
		vm:SetSubMaterial(4, nil)
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end
	if ifp then
		self:EmitGunfireSound("TFA_BO3_SCAVENGER.Flux")
		if self.Ispackapunched then
			self:EmitGunfireSound("TFA_BO3_PAP.Shoot")
		end
	end
end

function SWEP:PreSpawnProjectile(ent)
	ent:SetUpgraded(self.Ispackapunched)
end

/*function SWEP:PostSpawnProjectile(ent)
	local aimcone = self:GetIronSights() and 1 or 10
	local dir
	local ang = self:GetOwner():GetAimVector():Angle()
	ang:RotateAroundAxis(ang:Right(), -aimcone / 2 + math.Rand(0, aimcone))
	ang:RotateAroundAxis(ang:Up(), -aimcone / 2 + math.Rand(0, aimcone))
	dir = ang:Forward()

	ent:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
	local phys = ent:GetPhysicsObject()

	if IsValid(phys) then
		phys:SetAngles(ang)
		phys:SetVelocity(dir * self:GetStat("Primary.ProjectileVelocity"))
	end
end*/
