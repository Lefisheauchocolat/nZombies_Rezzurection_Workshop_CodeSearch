local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Beta Winter's Howl model from BO1 animated by OffTh EWall, conceptualized by RedSpace2000. \nFrom the World at War custom map 'Project Viking' by RedSpace2000"
SWEP.Author = "RedSpace2000, OffTh EWall, echo000, pacman25, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Icelazer | WAW" or "Icelazer"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true
SWEP.DrawWeaponInfoBox = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo1/icelazer/c_icelazer.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo1/icelazer/w_icelazer.mdl"
SWEP.HoldType = "ar2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 1,
        Forward = 8,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO1_ICELAZER.Shoot"
SWEP.Primary.Ammo = "Thumper"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 90
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 115 or 400
SWEP.Primary.Knockback = 20
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 1
SWEP.MuzzleFlashEffect	= "tfa_bo3_muzzleflash_waffe_pap"
SWEP.TractorBeamEffect = "tfa_bo1_icelazer_tractorbeam"
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
		{range = 1000, damage = 0.5},
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

SWEP.Primary.KickUp				= 2
SWEP.Primary.KickDown			= 2
SWEP.Primary.KickHorizontal		= 1
SWEP.Primary.StaticRecoilFactor	= 0

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 3
SWEP.Primary.SpreadRecovery = 5

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
SWEP.InspectPos = Vector(8, -5, -1)
SWEP.InspectAng = Vector(20, 30, 16)
SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.SmokeParticle = ""
SWEP.TracerName = "tfa_bo1_icelazer_tracer"

--[NZombies]--
SWEP.NZPaPName = "Makankōsappō"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 10

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self.Owner:SetAmmo( self.Primary_TFA.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary_TFA.ClipSize )
end

SWEP.Primary.ClipSizePAP = 1
SWEP.Primary.MaxAmmoPAP = 20
SWEP.Primary.SoundPAP = "TFA_BO1_ICELAZER.ShootPaP"

function SWEP:OnPaP()
self.Ispackapunched = true

self.MuzzleFlashEffect = "tfa_bo1_muzzleflash_icelazer_pap"

self.Primary_TFA.ChargeSound = "TFA_BO1_ICELAZER.ChargePaP"
self.Primary_TFA.ChargeCancelSoundPAP = ""
self.Primary_TFA.Sound = "TFA_BO1_ICELAZER.ShootPaP"
self.Primary_TFA.MaxAmmo = 20
self.Primary_TFA.Damage = 2000

self.Primary_TFA.ChargeTime = 2
self.Primary_TFA.CylinderRadius = 140
self.Primary_TFA.CylinderRange = 1500
self.Primary_TFA.CylinderKillRange = 200

self.Primary_TFA.RangeFalloffLUT = {
	bezier = false,
	range_func = "linear",
	units = "hu",
	lut = {
		{range = 200, damage = 1.0},
		{range = 1500, damage = 0.5},
	}
}

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
    [ACT_VM_RELOAD] = 80 / 30,
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO1_ICELAZER.Raise") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO1_ICELAZER.Putaway") },
},
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO1_ICELAZER.Raise") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO1_ICELAZER.Ready") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO1_ICELAZER.MagOut") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO1_ICELAZER.MagIn") },
{ ["time"] = 90 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO1_ICELAZER.Ready") },
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
[1] = {atts = {"bo3_packapunch", "bo1_icelazer_range"}, order = 1, hidden = nzombies},
}

SWEP.Primary.ChargeSound = "TFA_BO1_ICELAZER.Charge"
SWEP.Primary.ChargeCancelSound = "TFA_BO1_ICELAZER.Cancel"
SWEP.Primary.ChargeTime = 2.5
SWEP.Primary.CylinderRadius = 120
SWEP.Primary.CylinderRange = 1000
SWEP.Primary.CylinderKillRange = 100

SWEP.ScreenModRangeSqr = 122500

SWEP.TracerNamePAP = "tfa_bo1_icelazer_tracer_pap"
SWEP.TractorBeamEffectPAP = "tfa_bo1_icelazer_tractorbeam_pap"

SWEP.AttachmentTableOverride = {
	["bo3_packapunch"] = {
		["MuzzleFlashEffect"] = 'tfa_bo1_muzzleflash_icelazer_pap',
		["Primary"] = {
			["Sound"] = 'TFA_BO1_ICELAZER.ShootPaP',
			["ChargeTime"] = 2,
			["CylinderRange"] = 1500,
			["CylinderRadius"] = 140,
			["CylinderKillRange"] = 200,
			["ChargeSound"] = "TFA_BO1_ICELAZER.ChargePaP",
			["ChargeCancelSoundPAP"] = "",
		},
	},
}

DEFINE_BASECLASS( SWEP.Base )

local pvp_bool = GetConVar("sbox_playershurtplayers")
local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "GunChargedUp")
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	if self.Ispackapunched then
		vm:SetSubMaterial(0, self.nzPaPCamo)
	else
		vm:SetSubMaterial(0, nil)
	end
end

function SWEP:PrimaryAttack(...)
	if not self:CanPrimaryAttack() then return end

	if not self:GetGunChargedUp() and self:GetStatus() ~= TFA.Enum.STATUS_CHARGE_UP then
		self:SendViewModelAnim(ACT_VM_PULLBACK_HIGH)
		self:ScheduleStatus(TFA.Enum.STATUS_CHARGE_UP, self.Primary.ChargeTime)
		self:EmitGunfireSound(self.Primary.ChargeSound)
		self:SetNextPrimaryFire(self:GetStatusEnd())

		local ply = self:GetOwner()
		if ply:IsPlayer() and IsFirstTimePredicted() then
			local tr = util.QuickTrace(ply:GetShootPos(), self:GetAimVector()*self.Primary.CylinderRange, {ply, self})

			local fx = EffectData()
			fx:SetStart(ply:GetShootPos())
			fx:SetOrigin(tr.HitPos)
			fx:SetEntity(self)
			fx:SetAttachment(1)

			TFA.Effects.Create(self.Ispackapunched and self.TractorBeamEffectPAP or self.TractorBeamEffect, fx)

			if self:VMIV() then
				ParticleEffectAttach((self.Primary.ChargeTime <= 2) and (self:IsFirstPerson() and "bo1_icelazer_buildup_quick" or "bo1_icelazer_buildup_3p") or (self:IsFirstPerson() and "bo1_icelazer_buildup" or "bo1_icelazer_buildup_3p"), PATTACH_POINT_FOLLOW, (self:IsFirstPerson() and self.OwnerViewModel or self), 3)
			end

			if self.Ispackapunched then
				if self:VMIV() then
					ParticleEffectAttach(self:IsFirstPerson() and "bo1_icelazer_charge_vm" or "bo1_icelazer_charge_3p", PATTACH_POINT_FOLLOW, (self:IsFirstPerson() and self.OwnerViewModel or self), 1)
				end

				if SERVER then
					local fx = EffectData()
					fx:SetEntity(self)
					fx:SetAttachment(1)

					local filter = RecipientFilter()
					filter:AddPVS(ply:GetShootPos())
					if IsValid(ply) then
						filter:RemovePlayer(ply)
					end

					if filter:GetCount() > 0 then
						util.Effect("tfa_bo1_icelazer_3p", fx, true, filter)
					end
				end
			end
		end
	end

	BaseClass.PrimaryAttack(self, ...)
end

function SWEP:Deploy(...)
	self:SetGunChargedUp(false)
	self:StopSound("TFA_BO1_ICELAZER.Loop")
	self:EmitSound("TFA_BO1_ICELAZER.Loop")

	return BaseClass.Deploy(self, ...)
end

function SWEP:OnRemove(...)
	self:StopSound("TFA_BO1_ICELAZER.Loop")
	self:StopSoundNet("TFA_BO1_ICELAZER.Loop")

	return BaseClass.OnRemove(self, ...)
end

function SWEP:Holster(...)
	self:SetGunChargedUp(false)
	self:StopSound("TFA_BO1_ICELAZER.Loop")
	self:StopSoundNet("TFA_BO1_ICELAZER.Loop")
	
	return BaseClass.Holster(self, ...)
end

function SWEP:OwnerChanged(...)
	self:SetGunChargedUp(false)
	self:StopSound("TFA_BO1_ICELAZER.Loop")
	self:StopSoundNet("TFA_BO1_ICELAZER.Loop")

	return BaseClass.OwnerChanged(self,...)
end

function SWEP:CompleteReload(...)
	self:SetGunChargedUp(false)
	
	return BaseClass.CompleteReload(self, ...)
end

function SWEP:Think2(...)
	local status = self:GetStatus()
	local ply = self:GetOwner()

	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex(), false)

		if status == TFA.Enum.STATUS_CHARGE_UP and self.DLight then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(1)
			local progress = math.Clamp(self:GetStatusProgress(), 0, 1)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 255
			self.DLight.g = self.Ispackapunched and 180 or 0
			self.DLight.b = 0
			self.DLight.decay = 1500
			self.DLight.brightness = math.random(0,2) * progress
			self.DLight.size = 160 * progress * math.random(1,3)
			self.DLight.dietime = CurTime() + 0.5
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end

	if status == TFA.Enum.STATUS_CHARGE_UP then
		if ply:IsNPC() then
			local tr = util.QuickTrace(ply:EyePos(), ply:GetAimVector()*self.Primary.CylinderRange, {ply, self})
			local fx = EffectData()
			fx:SetStart(ply:GetShootPos())
			fx:SetOrigin(tr.HitPos)
			fx:SetEntity(self)
			fx:SetAttachment(1)
			TFA.Effects.Create("tfa_bo1_icelazer_tractorbeam_npc", fx)
		end

		if self:GetStatusEnd() <= CurTime() then
			self:CleanParticles()
			self:SetGunChargedUp(true)
			self:StopSound(self.Primary.ChargeSound)
			self:SetStatusEnd(0)
			self:SetStatus(TFA.Enum.STATUS_IDLE)
		end
	end

	if (status == TFA.Enum.STATUS_SHOOTING) and self:GetGunChargedUp() then
		self:ScheduleStatus(TFA.Enum.STATUS_CHARGE_DOWN, self:GetActivityLength() - 0.6)
	end

	if ply:IsPlayer() and status == TFA.Enum.STATUS_CHARGE_UP and not ply:KeyDown(IN_ATTACK) then
		if IsFirstTimePredicted() then
			self:EmitSound(self.Primary.ChargeCancelSound)
		end
		self:CleanParticles()
		self:StopSound(self.Primary.ChargeSound)
		self:ScheduleStatus(TFA.Enum.STATUS_CHARGE_DOWN, 0.25)
		self:SetNextPrimaryFire(self:GetStatusEnd())
	end

	if (status == TFA.Enum.STATUS_SHOOTING and self:GetStatusEnd() <= CurTime() or status == TFA.Enum.STATUS_IDLE) and self:GetGunChargedUp() then
		self:ScheduleStatus(TFA.Enum.STATUS_CHARGE_DOWN, self:GetActivityLength() - 0.6)
	end

	if status == TFA.Enum.STATUS_CHARGE_DOWN and self:GetStatusEnd() <= CurTime() then
		self:SetGunChargedUp(false)
		self:SetStatusEnd(0)
		self:SetStatus(TFA.Enum.STATUS_IDLE)
	end

	return BaseClass.Think2(self, ...)
end

local function PointOnSegmentNearestToPoint(a, b, p)
	local ab = b - a
	local ap = p - a

	local t = ap:Dot(ab) / (ab.x^2 + ab.y^2 + ab.z^2)
		t = math.Clamp(t, 0, 1)
	return a + t*ab
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local isplayer = ply:IsPlayer()

	local inner_range = self.Primary.CylinderKillRange
	local outer_range = self.Primary.CylinderRange
	local cylinder_radius = self.Primary.CylinderRadius

	local view_pos = ply:GetShootPos()
	local forward_view_angles = isplayer and ply:GetAimVector() or self:GetAimVector()
	local end_pos = view_pos + (forward_view_angles * outer_range)

	if shouldDisplayDebug() then
		local near_circle_pos = view_pos + (forward_view_angles*2)

		DLib.debugoverlay.Sphere(near_circle_pos, cylinder_radius, 5, Color(255, 0, 0, 255), true)
		DLib.debugoverlay.Line(near_circle_pos, end_pos, 5, Color(0, 0, 255, 255), true)
		DLib.debugoverlay.Sphere(end_pos, cylinder_radius, 5, Color(255, 0, 0, 255), true)
	end

	if SERVER then
		if isplayer then
			if !self.Ispackapunched then
				ply:SetNW2Float("TFA.IceLazerFade", CurTime() + 1.6)
			end
		else
			self:SetGunChargedUp(false)
			self:SetStatusEnd(0)
		end

		local inner_range_squared = inner_range * inner_range
		local outer_range_squared = outer_range * outer_range
		local cylinder_radius_squared = cylinder_radius * cylinder_radius
		for i, ent in pairs(ents.FindInSphere(view_pos, outer_range*1.1)) do
			if not (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then continue end
			if ent == ply then continue end

			if ent:IsPlayer() and !self.Ispackapunched then
				local dist = ent:GetPos():DistToSqr(ply:GetPos())
				if dist < self.ScreenModRangeSqr then
					local mult = 1 - math.Clamp(dist/self.ScreenModRangeSqr, 0, 0.6)
					ent:SetNW2Float("TFA.IceLazerFade", CurTime() + mult)
				end

				if nzombies then continue end
			end

			if ent:Health() <= 0 then continue end
			if not pvp_bool:GetBool() and ent:IsPlayer() then continue end
			if ent:IsPlayer() and IsValid(ply) and isplayer and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end

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

			local fatal = false
			local damagefinal = self:GetStatL("Primary.Damage")
			if test_range_squared < inner_range_squared then
				damagefinal = ent:Health() + 666
				fatal = true
			else
				normal = normal + (test_origin - radial_origin):GetNormalized()*0.5
			end

			local dist_ratio = (outer_range_squared - test_range_squared) / (outer_range_squared - inner_range_squared) 
			local damage = tonumber(Lerp(dist_ratio, damagefinal / 2, damagefinal))

			self:IceLazerDamage(ent, damage, normal*(math.random(40,70)*100), hitpos, fatal)
		end
	end

	if isplayer and IsFirstTimePredicted() then
		local tr = util.QuickTrace(ply:GetShootPos(), ply:GetAimVector()*self.Primary.CylinderRange, {ply, self})

		local fx = EffectData()
		fx:SetStart(ply:GetShootPos())
		fx:SetOrigin(tr.HitPos)
		fx:SetNormal(tr.HitNormal)
		fx:SetFlags((tr.Hit and !tr.HitSky) and 1 or 2)
		fx:SetEntity(self)
		fx:SetAttachment(1)

		TFA.Effects.Create(self.Ispackapunched and self.TracerNamePAP or self.TracerName, fx)
	end
end

function SWEP:IceLazerDamage(ent, mydamage, force, hitpos, fatal)
	local damage = DamageInfo()
	damage:SetDamageType(bit.bor(DMG_ENERGYBEAM, DMG_AIRBOAT))
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamagePosition(hitpos)
	damage:SetDamage(mydamage)
	damage:SetDamageForce(force)

	local boss = nzombies and (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss"))
	if nzombies then
		if boss then
			mydamage = (ent:Health()/2) + 115
			damage:SetDamage(mydamage)

			if ent.lazer_stunned_before then //not sure why killing the boss is random chance
				if math.random(100) > 20 then //but thats how redspace coded it originally
					damage:SetDamageType(DMG_ENERGYBEAM)
					damage:SetDamage(ent:Health() + 115)

					ent.lazer_stunned_before = nil
					ent:SetHealth(1)
					ent:SetNW2Bool("IceLazerPop", true)

					ent:TakeDamageInfo(damage)
				end
				return
			end
		elseif !fatal then
			local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
			local health = tonumber(nzCurves.GenerateHealthCurve(round))
			local rand = math.random(100) > 33 and 3 or 1 //66% chance to 'stun' 33% chance to kill

			mydamage = (health/rand) + 115
			damage:SetDamage(mydamage)
		end
	end

	if math.floor(ent:Health() - mydamage) <= 0 or ent.lazer_stunned_before then
		ent.lazer_stunned_before = nil
		ent:SetHealth(1)
		ent:SetNW2Bool("IceLazerPop", true)
		if nzombies and ent:IsValidZombie() then
			damage:SetDamageType(DMG_ENERGYBEAM)
		end
	else
		ParticleEffectAttach("bo1_icelazer_pop", PATTACH_ABSORIGIN_FOLLOW, ent, 0)

		if nzombies and ent:IsValidZombie() and !boss then
			local time = self.Ispackapunched and math.Rand(2.4,3.2) or math.Rand(1.4,2)
			ent:SetNW2Bool("OnAcid", true)
			ent:Freeze(time)

			local timername = "lazer_stunned"..ent:EntIndex()
			if timer.Exists(timername) then timer.Remove(timername) end
			timer.Create(timername, time, 1, function()
				if not IsValid(ent) then return end
				ent:SetNW2Bool("OnAcid", false)
			end)
		end
	end

	if ent.IsDrGNextbot then
		ent.Flinching = true
		ent:SetNW2Bool("DrGBaseClimbing", true)
	end

	ent:TakeDamageInfo(damage)

	if nzombies and !ent.lazer_stunned_before then
		ent.lazer_stunned_before = true
	end

	local rand = VectorRand(-21,21)
	rand = Vector(rand.x, rand.y, 1)
	util.Decal("Blood", ent:GetPos() - rand, ent:GetPos() + rand)
end

function SWEP:ShootBullet()
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