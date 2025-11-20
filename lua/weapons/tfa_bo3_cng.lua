local nzombies = engine.ActiveGamemode() == "nzombies"
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Custom Zombies"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = "Conceptualized by Harry Bo21 & Madgaz. \nFrom the Black Ops 3 custom map 'ATONEMENT' by Planet & Madgaz"
SWEP.Author = "Harrybo21, Madgaz, Divinefury, FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Compact Nuke Gun | BO3" or "Compact Nuke Gun"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.DrawWeaponInfoBox = true

/*ADDITIONAL CREDITS LISTED IN THE GSC
Raptroes
Hubashuba
WillJones1989
alexbgt
NoobForLunch
Symbo
TheIronicTruth
JAMAKINBACONMAN
Sethnorris
Yen466
Lilrifa
Easyskanka
Erthrock
Will Luffey
ProRevenge
DTZxPorter
Zeroy
JBird632
StevieWonder87
BluntStuffy
RedSpace200
Frost Iceforge
thezombieproject
Smasher248
JiffyNoodles
MadGaz
MZSlayer
AndyWhelen
Collie
ProGamerzFTW
Scobalula
Azsry
GerardS0406
PCModder
IperBreach
TomBMX
Treyarch and Activision
AllModz
TheSkyeLord*/

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/cng/c_cng.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/cng/w_cng.mdl"
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
        Right = 1,
        Forward = 3,
        },
        Ang = {
		Up = -180,
        Right = 190,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_CNG.Shoot"
SWEP.Primary.Ammo = "gravity"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 90
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 2000 or 200
SWEP.Primary.Knockback = 15
SWEP.Primary.NumShots = 9
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = SWEP.Primary.ClipSize * 5
SWEP.Primary.DryFireDelay = 0.5
SWEP.MuzzleFlashEffect	= "tfa_bo3_muzzleflash_cng"
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
SWEP.LowAmmoSoundThreshold = 0.33 --0.33
SWEP.LowAmmoSound = nil
SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.DisplayFalloff = false

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
SWEP.Primary.Spread		  = .11
SWEP.Primary.IronAccuracy = .04
SWEP.IronRecoilMultiplier = 0.85
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 1
SWEP.Primary.KickDown			= 1
SWEP.Primary.KickHorizontal		= 0.5
SWEP.Primary.StaticRecoilFactor	= 0.5

SWEP.Primary.SpreadMultiplierMax = 4
SWEP.Primary.SpreadIncrement = 2
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.IronBobMult 	 = 0.065
SWEP.IronBobMultWalk = 0.065
SWEP.data = {}
SWEP.data.ironsights = 1
SWEP.Secondary.IronFOV = 75
SWEP.IronSightsPos = Vector(-4, -4, 1.5)
SWEP.IronSightsAng = Vector(1, 0, 0)
SWEP.IronSightTime = 0.45

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
SWEP.MoveSpeed = 0.95
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)
SWEP.ImpactDecal = "FadingScorch"
SWEP.TracerCount = 2

--[NZombies]--
SWEP.NZPaPName = "Atomwaffe Ex 935"
SWEP.NZWonderWeapon = true
SWEP.Primary.MaxAmmo = 36

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:GetOwner():SetAmmo( self.Primary.MaxAmmo, self:GetPrimaryAmmoType() )
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.Primary.ClipSizePAP = 6
SWEP.Primary.DamagePAP = 400

function SWEP:OnPaP()
self.Silenced = true
self.Ispackapunched = true
self.Primary_TFA.ClipSize = 6
self.Primary_TFA.MaxAmmo = 72
self.Primary_TFA.Damage = 3200
self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 80 / 35,
}
SWEP.SequenceLengthOverride = {
	[ACT_VM_HOLSTER] = 15 / 30,
	[ACT_VM_HOLSTER_EMPTY] = 15 / 30,
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_in", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_in_empty",
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_loop", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_loop_empty",
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "sprint_out", --Number for act, String/Number for sequence
		["value_empty"] = "sprint_out_empty",
	}
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_DRAW_EMPTY] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER_EMPTY] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_RELOAD] = {
{ ["time"] = 25 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GKZ.Gears") },
{ ["time"] = 45 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Open") },
{ ["time"] = 75 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO2_BLUNDERGAT.Close") },
{ ["time"] = 140 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GKZ.First") },
},
[ACT_VM_PULLBACK] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_CNG.Charge") },
{ ["time"] = 4 / 30, ["type"] = "lua", value = function(self)
	if CLIENT and self:VMIV() then
		ParticleEffectAttach("bo3_cng_charge_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
	end
	if CLIENT and not self:IsFirstPerson() then
		ParticleEffectAttach("bo3_cng_charge_3p", PATTACH_POINT_FOLLOW, self, 1)
	end
	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(1)

		local filter = RecipientFilter()
		filter:AddPVS(self:GetOwner():GetShootPos())
		filter:RemovePlayer(self:GetOwner())

		util.Effect("tfa_bo3_cng_3p", fx, nil, filter)
	end
end, client = true, server = true},
{ ["time"] = 28 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_CNG.Charge") },
{ ["time"] = 30 / 30, ["type"] = "lua", value = function(self)
	if CLIENT and self:VMIV() then
		ParticleEffectAttach("bo3_cng_charge_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
	end
	if CLIENT and not self:IsFirstPerson() then
		ParticleEffectAttach("bo3_cng_charge_3p", PATTACH_POINT_FOLLOW, self, 2)
	end
	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(2)

		local filter = RecipientFilter()
		filter:AddPVS(self:GetOwner():GetShootPos())
		filter:RemovePlayer(self:GetOwner())

		util.Effect("tfa_bo3_cng_3p", fx, nil, filter)
	end
end, client = true, server = true},
{ ["time"] = 58 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_CNG.Charge") },
{ ["time"] = 60 / 30, ["type"] = "lua", value = function(self)
	if CLIENT and self:VMIV() then
		ParticleEffectAttach("bo3_cng_charge_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 3)
	end
	if CLIENT and not self:IsFirstPerson() then
		ParticleEffectAttach("bo3_cng_charge_3p", PATTACH_POINT_FOLLOW, self, 3)
	end
	if SERVER then
		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(3)

		local filter = RecipientFilter()
		filter:AddPVS(self:GetOwner():GetShootPos())
		filter:RemovePlayer(self:GetOwner())

		util.Effect("tfa_bo3_cng_3p", fx, nil, filter)
	end
end, client = true, server = true},
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
[1] = {atts = {"bo3_packapunch"}, order = 1},
}

local _sp = game.SinglePlayer()

SWEP.CustomBulletCallback = function(attacker, trace, dmginfo)
	local wep = dmginfo:GetInflictor()
	local ent = trace.Entity
	if trace and IsValid(ent) and not ent:IsWorld() then
		dmginfo:SetDamageType(DMG_SHOCK)
		dmginfo:SetDamageForce(dmginfo:GetDamageForce()*8)

		if IsValid(wep) then
			local upgraded = wep.Ispackapunched
			local ratio = wep:GetChargeRatio()
			local time = upgraded and 3 or 1.5
			local damage = dmginfo:GetDamage()
			local maxinfects = 1

			if ratio > 1/3 then
				maxinfects = 2
				time = time*2
				dmginfo:SetDamage(damage*1.5)
			end

			if ratio > 2/3 then
				maxinfects = 3
				time = time + 0.5
				dmginfo:SetDamage(damage*2)
			end

			if SERVER then
				if !nzombies or (nzombies and !ent:IsPlayer()) then
					ent:BO3NukeAfterburn(time, attacker, true, 0.5, 0.01)
				end

				for _, v in pairs(ents.FindInSphere(trace.HitPos, math.max(150*ratio, 25))) do
					if v == ent then continue end
					if nzombies and v:IsPlayer() then continue end
					if v == attacker then continue end
					if v:Health() <= 0 then continue end
					if v:GetMaxHealth() <= 0 then continue end
					if v:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", v, attacker) then continue end
					if IsValid(attacker) and attacker:IsNPC() and attacker:Disposition(v) == D_LI then continue end

					if v:IsSolid() and v:VisibleVec(trace.HitPos) then
						v:BO3NukeAfterburn(time + math.Rand(-0.1,0.1), attacker, true, 0.5, 0.01)
					end
				end
			end

			if ratio > 1/3 and (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) and (!wep.NukeGunShockCount or wep.NukeGunShockCount < maxinfects) and (!ent.NukeGunMark or ent.NukeGunMark ~= CurTime()) then
				ent.NukeGunMark = CurTime()
				wep.NukeGunShockCount = (wep.NukeGunShockCount or 0) + 1

				if !_sp and CLIENT then
					local fx = EffectData()
					fx:SetStart(trace.StartPos)
					fx:SetOrigin(trace.HitPos)
					fx:SetAttachment(wep.NukeGunShockCount)
					fx:SetEntity(wep)

					util.Effect("tfa_bo3_cng_tether", fx)
				end

				if SERVER then
					local trfx = EffectData()
					trfx:SetStart(trace.StartPos)
					trfx:SetOrigin(trace.HitPos)
					trfx:SetAttachment(wep.NukeGunShockCount)
					trfx:SetEntity(wep)

					local trfilter = RecipientFilter()
					trfilter:AddPVS(attacker:GetShootPos())
					if _sp then
						trfilter:AddPlayer(attacker)
					else
						trfilter:RemovePlayer(attacker)
					end

					util.Effect("tfa_bo3_cng_tether", trfx, nil, trfilter)

					util.Decal("Scorch", ent:GetPos() - vector_up, ent:GetPos() + vector_up)

					local max = 1
					local dmg = upgraded and 500 or 250
					local range = upgraded and 400 or 200
					local dur = upgraded and 0.75 or 0.5

					if ratio >= 2/3 then
						max = 2
						dmg = upgraded and 1000 or 500
						range = upgraded and 800 or 400
						dur = upgraded and 1.5 or 1
					end

					if ratio >= 1 then
						max = 3
						dur = upgraded and 3 or 1.5
					end

					local waff = ents.Create("bo3_ww_cng")
					waff:SetModel("models/dav0r/hoverball.mdl")
					waff:SetPos(trace.HitPos)
					waff:SetAngles(Angle(90,0,0))
					waff:SetOwner(attacker)
					waff:SetTarget(ent)

					waff.ArcDelay = math.Rand(0.2,0.4)
					waff.MaxChain = max
					waff.ZapRange = range
					waff.ShockTime = dur + math.Rand(-0.15,0.25)
					waff.ShockDamage = dmg

					waff:Spawn()
					waff:SetOwner(attacker)
				end
			end
		end
	end

	if trace and trace.Hit and not trace.HitSky then
		if (_sp and SERVER) or (!_sp and CLIENT) then
			if IsValid(wep) and wep:GetChargeRatio() > 1/3 then
				ParticleEffect("bo3_cng_charge_hit", trace.HitPos - trace.Normal, trace.HitNormal:Angle() + Angle(90,0,0))
			end

			ParticleEffect("bo3_cng_hit", trace.HitPos - trace.Normal, trace.HitNormal:Angle() + Angle(90,0,0))
		end

		if SERVER then
			local fx = EffectData()
			fx:SetOrigin(trace.HitPos - trace.Normal)
			fx:SetNormal(trace.HitNormal)
			fx:SetFlags((IsValid(wep) and wep:GetChargeRatio() > 1/3) and 2 or  1)

			local filter = RecipientFilter()
			filter:AddPVS(attacker:GetShootPos())
			filter:RemovePlayer(attacker)

			if filter:GetCount() > 0 then
				util.Effect("tfa_bo3_cng_impact", fx, nil, filter)
			end
		end
	end
end

SWEP.Secondary.Damage = 5000
SWEP.NukeGunShockCount = 0

SWEP.ChargeTime = 2.85
SWEP.ChargeDownSound = "TFA_BO3_SUNGOD.Charge.Down"

SWEP.ChargeAnimations = {
	["idle_charged"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "charge_loop",
		["enabled"] = true --Manually force a sequence to be enabled
	},
	["idle"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "idle",
		["enabled"] = true --Manually force a sequence to be enabled
	},
}

SWEP.HasPlayedChargeSound = false

SWEP.CylinderRadius = 100
SWEP.CylinderRange = 200
SWEP.CylinderKillRange = 100

DEFINE_BASECLASS( SWEP.Base )

local dryfire_cvar = GetConVar("sv_tfa_allow_dryfire")
local pvp_bool = GetConVar("sbox_playershurtplayers")
local cvar_papcamoww = GetConVar("nz_papcamo_ww")

local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVarTFA("Float", "ChargeStart")
end

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if !cvar_papcamoww or (cvar_papcamoww and cvar_papcamoww:GetBool()) then
		if self.Ispackapunched then
			vm:SetSubMaterial(0, self.nzPaPCamo)
			vm:SetSubMaterial(1, self.nzPaPCamo)
			vm:SetSubMaterial(2, self.nzPaPCamo)
			vm:SetSubMaterial(3, self.nzPaPCamo)
			//vm:SetSubMaterial(4, self.nzPaPCamo)
			//vm:SetSubMaterial(5, self.nzPaPCamo)
			vm:SetSubMaterial(6, self.nzPaPCamo)
		else
			vm:SetSubMaterial(0, nil)
			vm:SetSubMaterial(1, nil)
			vm:SetSubMaterial(2, nil)
			vm:SetSubMaterial(3, nil)
			//vm:SetSubMaterial(4, nil)
			//vm:SetSubMaterial(5, nil)
			vm:SetSubMaterial(6, nil)
		end
	end
end

function SWEP:Equip(ply, ...)
	if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and (not ply._TFA_LastJamMessage or ply._TFA_LastJamMessage < RealTime()) then
		ply:PrintMessage(HUD_PRINTCENTER, "#tfa.msg.miscww.cng.hint")
		ply._TFA_LastJamMessage = RealTime() + 1
		ply._TFA_ChargeCancelWarned = false
	end
	return BaseClass.Equip(self, ply, ...)
end

function SWEP:ResetCharge(doanim)
	if self:GetChargeStart() == 0 then return end

	if doanim then
		self:SendViewModelAnim(ACT_VM_RELEASE)
		self:ScheduleStatus(TFA.Enum.STATUS_BASHING, self:GetActivityLength())
		self:SetNextPrimaryFire(self:GetStatusEnd())
		if IsFirstTimePredicted() then
			self:EmitSound(self.ChargeDownSound)
		end
	end

	self:SetChargeStart(0)
	self.HasPlayedChargeSound = false
	self.NukeGunShockCount = 0

	//self:StopSound(self.ChargeLoopSound)
end

function SWEP:AltAttack()
	if self:GetSprinting() then return end
	if not TFA.Enum.ReadyStatus[self:GetStatus()] then return end
	if self:GetChargeStart() > 0 then return end
	if not self:CanPrimaryAttack() then return end

	if self:Clip1() < 3 then
		if not dryfire_cvar:GetBool() then
			self:Reload(true)
		end
	return end

	if self:GetStatus() ~= TFA.Enum.STATUS_CHARGE_UP then
		self:SendViewModelAnim(ACT_VM_PULLBACK)
		self:ScheduleStatus(TFA.Enum.STATUS_CHARGE_UP, self:GetActivityLength())
		self:SetChargeStart(CurTime())
	end

	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and not ply._TFA_ChargeCancelWarned then
		ply:PrintMessage(HUD_PRINTCENTER, "#tfa.msg.miscww.cng.cancel")
		ply._TFA_ChargeCancelWarned = true
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	if CLIENT and dlight_cvar:GetBool() and DynamicLight then
		self.DLight = self.DLight or DynamicLight(self:EntIndex())

		if self.DLight and self:Clip1() > 0 then
			local attpos = (self:IsFirstPerson() and ply:GetViewModel() or self):GetAttachment(4)

			self.DLight.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
			self.DLight.r = 0
			self.DLight.g = 255
			self.DLight.b = 20
			self.DLight.decay = 1000
			self.DLight.brightness = 1
			self.DLight.size = 32 + (64 * self:GetChargeRatio())
			self.DLight.dietime = CurTime() + 0.5
		end
	elseif self.DLight then
		self.DLight.dietime = -1
	end

	if ply:IsPlayer() then
		if TFA.Enum.ReadyStatus[self:GetStatus()] and not self:GetSprinting() then
			if self:GetCharged() and not self.HasPlayedChargeSound then
				self.HasPlayedChargeSound = true
				/*if IsFirstTimePredicted() then
					self:EmitSound(self.ChargeLoopSound)
				end*/
			end
		elseif self:GetChargeStart() > 0 then
			self:CleanParticles()
			self:ResetCharge(true)
		end
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:PrePrimaryAttack()
	if self:GetChargeStart() > 0 and self:GetChargeRatio() > 1/3 then
		self.LastAmmoConsumption = self.Primary_TFA.AmmoConsumption
		self.Primary_TFA.AmmoConsumption = math.Clamp(self.LastAmmoConsumption + math.floor(3*self:GetChargeRatio()), 1, math.min(self:Clip1(), 3))
		self:ClearStatCache("Primary.AmmoConsumption")
	end
end

function SWEP:ChooseIdleAnim(...)
	if self:GetChargeStart() > 0 and self.ChargeAnimations["idle_charged"] then
		return self:PlayAnimation(self.ChargeAnimations.idle_charged)
	end

	return BaseClass.ChooseIdleAnim(self, ...)
end

function SWEP:PrimaryAttack(...)
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsNPC() then
		if self:GetChargeStart() > 0 and !self:GetCharged() then
			return
		end
		if self:Clip1() >= 3 and math.random(12) <= (1*math.max(GetConVar("skill"):GetInt(), 1)) then
			self:AltAttack()
			return
		end
	end

	BaseClass.PrimaryAttack(self, ...)
end

function SWEP:PostPrimaryAttack()
	self:ThundergunCylinderDamage()

	if self:GetChargeStart() > 0 and self:GetChargeRatio() > 1/3 then
		self.Primary_TFA.AmmoConsumption = self.LastAmmoConsumption or 1
		self.LastAmmoConsumption = nil
		self:ClearStatCache("Primary.AmmoConsumption")
	end

	if self:VMIV() then
		ParticleEffectAttach("bo3_cng_muzzle_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 1)
		if self:GetChargeStart() > 0 then
			if self:GetChargeRatio() > 1/3 then
				ParticleEffectAttach("bo3_cng_muzzle_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 2)
			end
			if self:GetChargeRatio() > 2/3 then
				ParticleEffectAttach("bo3_cng_muzzle_vm", PATTACH_POINT_FOLLOW, self.OwnerViewModel, 3)
			end
		end
	end

	if SERVER or (CLIENT and not self:IsFirstPerson()) then
		ParticleEffectAttach("bo3_cng_muzzle_3p", PATTACH_POINT_FOLLOW, self, 1)
		if self:GetChargeStart() > 0 then
			if self:GetChargeRatio() > 1/3 then
				ParticleEffectAttach("bo3_cng_muzzle_3p", PATTACH_POINT_FOLLOW, self, 2)
			end
			if self:GetChargeRatio() > 2/3 then
				ParticleEffectAttach("bo3_cng_muzzle_3p", PATTACH_POINT_FOLLOW, self, 3)
			end
		end
	end

	self:ResetCharge()
end

function SWEP:Reload(...)
	if self:GetChargeStart() > 0 then
		self:CleanParticles()
		self:ResetCharge(true)
		return
	end
	return BaseClass.Reload(self, ...)
end

function SWEP:GetChargeRatio()
	if self:GetChargeStart() == 0 then
		return 0
	else
		return math.Clamp((CurTime() - self:GetChargeStart()) / self.ChargeTime, 0, 1)
	end
end

function SWEP:GetCharged()
	if self:GetChargeStart() > 0 then
		return tobool(math.min(CurTime() - self:GetChargeStart(), self.ChargeTime) == self.ChargeTime)
	else
		return false
	end
end

function SWEP:OnRemove(...)
	//self:StopSound(self.ChargeLoopSound)
	return BaseClass.OnRemove(self,...)
end

function SWEP:OwnerChanged(...)
	//self:StopSound(self.ChargeLoopSound)
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	//self:StopSound(self.ChargeLoopSound)
	//self:StopSoundNet(self.ChargeLoopSound)
	return BaseClass.Holster(self,...)
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

	local launched_sounds = 0
	local outer_range_squared = outer_range * outer_range
	local cylinder_radius_squared = cylinder_radius * cylinder_radius
	local inner_range_squared = inner_range * inner_range

	for i, ent in pairs(ents.FindInSphere(view_pos, outer_range*1.1)) do
		if not (ent:IsNPC() or ent:IsPlayer() or ent:IsNextBot()) then continue end

		if ent == ply then continue end
		if ent:Health() <= 0 then continue end
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

		local hitpos = tr1.Entity == ent and tr1.HitPos or test_origin
		if not ply:VisibleVec(hitpos) then
			if shouldDisplayDebug() then print(ent) print('cone') end
			continue // guy can't actually be hit from where we are
		end

		if nzombies and ent:IsPlayer() then
			if wep:GetChargeRatio() >= 0.91 then
				v:RevivePlayer(self)
			end
			continue
		end

		if not pvp_bool:GetBool() and ent:IsPlayer() then continue end
		if ent:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end

		local fling_vec = (ent:GetPos() - self:GetPos()):GetNormalized()
		local dist_mult = (outer_range_squared - test_range_squared) / outer_range_squared
		if 5000 < test_range_squared then //~70^2
			fling_vec = fling_vec + (test_origin - radial_origin):GetNormalized()
		end

		fling_vec = Vector(fling_vec.x, fling_vec.y, math.abs(fling_vec.z))
		fling_vec = fling_vec * ( 10000 + 20000 * dist_mult )

		self:ThundergunDamage(ent, test_range_squared < inner_range_squared, fling_vec, hitpos)

		if (launched_sounds < 1 or math.random(2) == 1) and launched_sounds < 3 then
			launched_sounds = launched_sounds + 1

			ent:EmitSound("TFA_BO3_CNG.Launch")
		end
	end
end

function SWEP:ThundergunDamage(ent, kill, fling_vec, hitpos)
	if CLIENT then return end

	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(self:GetOwner())
	damage:SetInflictor(self)
	damage:SetDamage(kill and self.Secondary_TFA.Damage or 75)
	damage:SetDamageForce(fling_vec)
	damage:SetDamagePosition(hitpos or ent:WorldSpaceCenter())

	if nzombies and ent.NZBossType then
		damage:SetDamage(math.max(self.Ispackapunched and 800 or 600, ent:GetMaxHealth() / 12))
		damage:ScaleDamage(math.Round(nzRound:GetNumber()/10))
	end

	ent:EmitSound("TFA_BO3_THUNDERGUN.Impact")
	ent.NukeGunTossed = true
	ent:TakeDamageInfo(damage)
	ent.NukeGunTossed = false

	if not kill and ent:IsPlayer() then
		ent:SetGroundEntity(nil)
		ent:SetLocalVelocity(ent:GetVelocity() + vector_up*80 + (fling_vec*20))
		ent:SetDSP(32, false)
	end
end
