local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 2"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "Jet Gun | BO2" or "Jet Gun"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo2/jetgun/c_jetgun.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo2/jetgun/w_jetgun.mdl"
SWEP.HoldType = "physgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -5,
        Right = 3,
        Forward = 1,
        },
        Ang = {
		Up = 190,
        Right = 190,
        Forward = 5
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO2_JETGUN.Start"
SWEP.Primary.LoopSound = "TFA_BO2_JETGUN.Loop"
SWEP.Primary.LoopSoundTail = "TFA_BO2_JETGUN.Stop"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 1200
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = nzombies and 115 or 45
SWEP.Primary.Knockback = 1
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 2
SWEP.Primary.Knockback = -12
SWEP.Primary.ClipSize = 260
SWEP.Primary.DefaultClip = 260
SWEP.Primary.DryFireDelay = 0.35
SWEP.MuzzleFlashEffect = "tfa_bo2_muzzleflash_jetgun"
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
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Recoil]--
SWEP.ViewModelPunchPitchMultiplier = 0.09 --0.5
SWEP.ViewModelPunchPitchMultiplier_IronSights = 0.09 --.09

SWEP.ViewModelPunch_MaxVertialOffset				= 2.0 --3
SWEP.ViewModelPunch_MaxVertialOffset_IronSights		= 1.95 --1.95
SWEP.ViewModelPunch_VertialMultiplier				= 0.25 --1
SWEP.ViewModelPunch_VertialMultiplier_IronSights	= 0.25 --0.25

SWEP.ViewModelPunchYawMultiplier = 0.25 --0.6
SWEP.ViewModelPunchYawMultiplier_IronSights = 0.25 --0.25

SWEP.ChangeStateRecoilMultiplier = 1.3 --1.3
SWEP.CrouchRecoilMultiplier = 0.65 --0.65
SWEP.JumpRecoilMultiplier = 1.65 --1.3
SWEP.WallRecoilMultiplier = 1.1 --1.1

--[Spread Related]--
SWEP.Primary.Spread		  = .04
SWEP.Primary.IronAccuracy = .04
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.0
SWEP.Primary.KickDown			= 0.0
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor	= 0.0

SWEP.Primary.SpreadMultiplierMax = 2
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 2

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 0.5
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "2"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(-1, -6, -3)
SWEP.InspectAng = Vector(20, 5, 0)
SWEP.MoveSpeed = 0.85
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(0, 0, -0)
SWEP.SafetyAng = Vector(-15, 15, -15)

--[NZombies]--
SWEP.NZWonderWeapon = true
SWEP.NZSpecialCategory = "shield"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/zm_jetgun_icon.png", "unlitgeneric smooth")

SWEP.Primary.MaxAmmo = 260

function SWEP:NZSpecialHolster()
	self:StopSound("TFA_BO2_JETGUN.Loop")
	self:StopSound("TFA_BO2_JETGUN.Rattle.Loop")
	return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO2_JETGUN.Raise") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.short") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0.5

SWEP.ViewModelBoneMods = {
	["j_barrel"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["j_dial_left"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["j_dial_right"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.SpinSpeed = 1
SWEP.SpinAng = 0

SWEP.Secondary.RPM = 900

SWEP.CylinderRadius = 256
SWEP.CylinderRange = 512
SWEP.CylinderKillRange = 82

SWEP.ActivateTime = 1.5
SWEP.OverheatTime = 30
SWEP.LastGib = 0

DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local sp = game.SinglePlayer()
local pvp_bool = GetConVar("sbox_playershurtplayers")
local developer = GetConVar("developer")
local function shouldDisplayDebug()
	return developer:GetBool() and DLib
end

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

	self:NetworkVarTFA("Bool", "IsSpinning")
	self:NetworkVarTFA("Bool", "OverHeating")
	self:NetworkVarTFA("Bool", "HasEmitSound")
end

function SWEP:ShootBulletInformation()
end

function SWEP:PreDrawViewModel(vm, wep, ply)
	self:SyncMeter(ply)
end

function SWEP:Equip(ply, ...)
	if SERVER and IsValid(ply) and ply:IsPlayer() then
		timer.Create("bo2_jetgun_reload"..self:EntIndex(), 0.2, 0, function()
			if not IsValid(self) then return end
			if self:GetStatus() == TFA.Enum.STATUS_SHOOTING then return end
			if self:Clip1() < self.Primary.MaxAmmo then self:SetClip1(math.min(self:Clip1() + 1, self.Primary.MaxAmmo)) else return end
		end)
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:CanPrimaryAttack(...)
	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() then
		if self:GetSpinTime() < self.ActivateTime then
			return false
		end
	end

    return BaseClass.CanPrimaryAttack(self,...)
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local aim = self:GetAimVector()
	if not IsValid(ply) then return end

	local n_inner_range = self.CylinderKillRange
	local n_outer_range = self.CylinderRange
	local n_cylinder_radius = self.CylinderRadius

	local n_inner_range_squared = n_inner_range * n_inner_range
	local n_outer_range_squared = n_outer_range * n_outer_range
	local n_radius_squared = n_cylinder_radius * n_cylinder_radius

	local self_pos = self:GetPos()
	local view_pos = ply:GetShootPos()
	local forward_view_angles = self:GetAimVector()
	local end_pos = view_pos + (forward_view_angles * n_outer_range)

	if shouldDisplayDebug() and self:Clip1()%5 == 0 then
		local near_circle_pos = view_pos + (forward_view_angles*2)

		DLib.debugoverlay.Sphere(near_circle_pos, n_inner_range, 5, Color(255, 0, 0, 255), true)
		DLib.debugoverlay.Line(near_circle_pos, end_pos, 5, Color(0, 0, 255, 255), true)
		DLib.debugoverlay.Sphere(end_pos, n_cylinder_radius, 5, Color(255, 0, 0, 255), true)
	end

	if SERVER then
		for i, ent in pairs(ents.FindInSphere(view_pos, n_outer_range*1.1)) do
			if ent:GetClass() == "drop_powerup" then
				ent:SetPos(LerpVector(0.15, ent:GetPos(), ply:GetShootPos()))
				continue
			end
			if not (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then continue end
			if nzombies and ent:IsPlayer() then continue end
			if not pvp_bool:GetBool() and ent:IsPlayer() then continue end
			if ent == ply then continue end
			if ent:Health() <= 0 then continue end
			if ent:IsPlayer() and !hook.Run("PlayerShouldTakeDamage", ent, ply) then continue end

			local test_origin = ent:WorldSpaceCenter()
			local test_range_squared = view_pos:DistToSqr(test_origin)
			if test_range_squared > n_outer_range_squared then
				continue
			end

			local normal = (test_origin - view_pos):GetNormalized()
			local dot = forward_view_angles:Dot(normal)
			if math.abs(dot) < 0.7 then
				continue
			end

			local radial_origin = PointOnSegmentNearestToPoint( view_pos, end_pos, test_origin )
			if test_origin:DistToSqr(radial_origin) > n_radius_squared then
				continue
			end

			local tr1 = util.TraceLine({
				start = view_pos,
				endpos = test_origin,
				filter = {self, ply},
				mask = MASK_SOLID_BRUSHONLY,
			})

			if tr1.HitWorld then
				continue
			end

			ent:EmitSound("TFA_BO2_JETGUN.Suck")
			local ent_pos = ent:GetPos()

			local jetgun_blow_suck = 1
			if dot < 0 then
				jetgun_blow_suck = 1 //set to -1 to make the jetgun blow away enemies behind you
			end

			if ent:IsNPC() then
				ent:SetGroundEntity(nil)
				local vecPush = (self_pos - ent_pos):GetNormalized() * (15 * jetgun_blow_suck)
				if bit.band(ent:GetFlags(), FL_BASEVELOCITY) != 0 then
					vecPush = vecPush + ent:GetBaseVelocity()
				end
				ent:SetVelocity(vecPush)
			end

			if ent:IsNextBot() then
				ent.loco:FaceTowards(self_pos)
				ent.loco:SetVelocity((self_pos - ent_pos):GetNormalized() * (250 * jetgun_blow_suck))
			end

			if ent:IsPlayer() then
				local vecPush = (self_pos - ent_pos):GetNormalized() * (150 * jetgun_blow_suck)
				ent:SetLocalVelocity(vecPush)
			end

			if test_range_squared < n_inner_range_squared and math.abs(dot) > 0 then
				self:InflictDamage(ent)
			end
		end
	end

	self:CallOnClient("RenderExaustParticles", "")

	if self:Clip1() <= 0 then
		self:EmitSound("TFA_BO2_JETGUN.Explode")
		self:SetOverHeating(true)
		self:SetNextPrimaryFire(self:GetNextCorrectedPrimaryFire(self.OverheatTime))

		local fx = EffectData()
		fx:SetOrigin(self:GetPos())
		util.Effect("HelicopterMegaBomb", fx)
	end
end

function SWEP:RenderExaustParticles()
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and not self:IsFirstPerson() then
		ParticleEffectAttach("bo2_jetgun_exhaust", PATTACH_POINT_FOLLOW, self, 2)
	end
end

function SWEP:RenderGrindParticles(cyborg)
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and not self:IsFirstPerson() then
		ParticleEffectAttach(tobool(cyborg) and "bo2_jetgun_grind_blue" or "bo2_jetgun_grind", PATTACH_POINT_FOLLOW, self, 2)
	end
end

function SWEP:InflictDamage(ent)
	local ply = self:GetOwner()

	local mydamage = self.Primary_TFA.Damage
	if nzombies and ent:IsValidZombie() then
		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
		local health = tonumber(nzCurves.GenerateHealthCurve(round))
		local rand = math.random(3,4)

		mydamage = (health / rand) + 666
	end

	local damage = DamageInfo()
	damage:SetDamageType(DMG_MISSILEDEFENSE)
	damage:SetAttacker(ply)
	damage:SetInflictor(self)
	damage:SetDamage(mydamage)
	damage:SetDamagePosition(ent:WorldSpaceCenter())
	damage:SetDamageForce(self:GetForward() * -8000)

	ent:EmitSound("TFA_BO2_JETGUN.Grind")

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end

	if nzombies and (ent.NZBossType or ent.IsMooBossZombie or string.find(ent:GetClass(), "nz_zombie_boss")) then
		damage:SetDamage(math.max(220, ent:GetMaxHealth() / 40))
	end

	ent:TakeDamageInfo(damage)
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

	if self:GetOverHeating() then
		return false
	end

    return true
end

function SWEP:Think2(...)
	local status = self:GetStatus()
	local ply = self:GetOwner()

	if CLIENT and ply:IsPlayer() then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			self.SpinSpeed = math.Approach(self.SpinSpeed, 8, FrameTime()*5)
		end
		self:DoSpin()
	end

	if CLIENT and sp then
        return BaseClass.Think2(self,...)
	end

	if IsValid(ply) and ply:IsPlayer() then
		if (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) and self:CanSpinUp() then
			if not self:GetIsSpinning() then
				if IsFirstTimePredicted() then self:EmitSound("TFA_BO2_JETGUN.Rattle.Start") end
			end
			self:SetIsSpinning(true)
		else
			if self:GetIsSpinning() then
				if IsFirstTimePredicted() then
					self:StopSound("TFA_BO2_JETGUN.Rattle.Loop")
					self:EmitSound("TFA_BO2_JETGUN.Rattle.Stop")
				end
			end
			self:SetIsSpinning(false)
			self:SetHasEmitSound(false)
		end

		if self:GetOverHeating() and self:GetNextPrimaryFire() < CurTime() then
			self:SetOverHeating(false)
		end

		if self:GetIsSpinning() then
			self:SetSpinTime(math.Clamp(self:GetSpinTime() + (FrameTime() * 2), 0, self.ActivateTime*2.5))

			if self:GetNextSecondaryFire() < CurTime() then
				local ang = self:GetAimVector():Angle()
				local fwd = Angle(0,ang.yaw,ang.roll)

				ParticleEffect("bo2_jetgun_floor", ply:GetPos() + (ply:GetUp()*4), fwd)
				self:SetNextSecondaryFire(self:GetNextCorrectedPrimaryFire(60/self.Secondary_TFA.RPM))
			end

			if self:GetSpinTime() >= self.ActivateTime then
				if not self:GetHasEmitSound() then
					self:SetHasEmitSound(true)
					if ply:KeyDown(IN_ATTACK) then
						self:EmitGunfireSound("TFA_BO2_JETGUN.Start")
					end
					self:EmitSound("TFA_BO2_JETGUN.Rattle.Loop")
				end

				if not (ply:KeyDown(IN_ATTACK) or ply:KeyDown(IN_ATTACK2)) then
					self:SetHasEmitSound(false)
					self:SetIsSpinning(false)
				end
			end 
		else
			if self:GetSpinTime() > 0 then
				self:SetSpinTime(math.Approach(self:GetSpinTime(), 0, FrameTime()*2))
			end
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

	self.ViewModelBoneMods["j_barrel"].angle = Angle(0, 0, -self.SpinAng)
end

function SWEP:Reload()
	return false
end

function SWEP:SyncMeter(ply)
	if not CLIENT then return end
	if self:VMIV() and ply:IsPlayer() then
		local clip = self.Primary.MaxAmmo - self:Clip1()
		local clip2 = self.ActivateTime - math.Clamp(self:GetSpinTime(), 0, self.ActivateTime*2.5)
		self.ViewModelBoneMods["j_dial_left"].angle = Angle(0,0,math.Truncate(clip*0.6) - 50)
		self.ViewModelBoneMods["j_dial_right"].angle = Angle(0,0,-math.Truncate(clip2*60) + 35)
	end
end

function SWEP:OnRemove(...)
	timer.Remove("bo2_jetgun_reload"..self:EntIndex())
	self:StopSound("TFA_BO2_JETGUN.Loop")
	self:StopSound("TFA_BO2_JETGUN.Rattle.Loop")
	return BaseClass.OnRemove(self,...)
end

function SWEP:OnDrop(...)
	timer.Remove("bo2_jetgun_reload"..self:EntIndex())
	self:StopSound("TFA_BO2_JETGUN.Loop")
	self:StopSound("TFA_BO2_JETGUN.Rattle.Loop")
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	timer.Remove("bo2_jetgun_reload"..self:EntIndex())
	self:StopSound("TFA_BO2_JETGUN.Loop")
	self:StopSound("TFA_BO2_JETGUN.Rattle.Loop")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSoundNet("TFA_BO2_JETGUN.Loop")
	self:StopSoundNet("TFA_BO2_JETGUN.Rattle.Loop")
	return BaseClass.Holster(self,...)
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
local color_red = Color(255, 0, 0, 255)

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
	if self:GetOverHeating() then
		crosscol = ColorAlpha(color_red, crossa)
	end
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