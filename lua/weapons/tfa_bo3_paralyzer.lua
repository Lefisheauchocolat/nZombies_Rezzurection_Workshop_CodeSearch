local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 2"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Author = "FlamingFox"
SWEP.Slot = 3
SWEP.PrintName = nzombies and "Paralyzer | BO2" or "Paralyzer"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/paralyzer/c_paralyzer.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/tfa_bo3/paralyzer/w_paralyzer.mdl"
SWEP.HoldType = "physgun"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -2,
		Right = 3,
		Forward = -4,
	},
	Ang = {
		Up = -170,
		Right = 190,
		Forward = 10
	},
	Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_PARALYZER.FireIn"
SWEP.Primary.LoopSound = "TFA_BO3_PARALYZER.FireLoop"
SWEP.Primary.LoopSoundTail = "TFA_BO3_PARALYZER.FireOut"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Primary.RPM = 400
SWEP.Primary.Damage = 115
SWEP.Primary.NumShots = 1
SWEP.Primary.ClipSize = 115
SWEP.Primary.DefaultClip = 115
SWEP.Primary.Knockback = 0
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
SWEP.Primary.Spread		  = .00
SWEP.Primary.IronAccuracy = .00
SWEP.IronRecoilMultiplier = 0.6
SWEP.CrouchAccuracyMultiplier = 0.85

SWEP.Primary.KickUp				= 0.0
SWEP.Primary.KickDown			= 0.0
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor	= 0.0

SWEP.Primary.SpreadMultiplierMax = 3
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 6

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.LuaShellEffect = "ShellEject"
SWEP.LuaShellScale = 1
SWEP.LuaShellEjectDelay = 0
SWEP.ShellAttachment = "0"
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.AmmoTypeStrings = {alyxgun = "Coolant"}
SWEP.InspectPos = Vector(0, -2, -2)
SWEP.InspectAng = Vector(10, 2, 0)
SWEP.MoveSpeed = 0.85
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)
SWEP.SmokeParticle = ""

--[NZombies]--
SWEP.NZPaPName = "Petrifier"
SWEP.NZWonderWeapon = true
SWEP.NZDontRegen = true
SWEP.Primary.MaxAmmo = 115

function SWEP:NZMaxAmmo()
	if CLIENT then return end
	self:SetClip1( self.Primary.ClipSize )
end

SWEP.Ispackapunched = false
SWEP.MuzzleFlashEffectPAP = "tfa_bo3_muzzleflash_paralyzer_pap"
SWEP.MoveSpeedPAP = 0.9

function SWEP:OnPaP()
self.Ispackapunched = true
self.MuzzleFlashEffect = "tfa_bo3_muzzleflash_paralyzer_pap"
self.MoveSpeed = 0.9
self:ClearStatCache()
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
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.Deploy") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.Pullout") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.Putaway") },
},
[ACT_VM_IDLE] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.Loop") },

{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeUp") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeDown") },
{ ["time"] = 20 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.Spin") },

{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeUp") },
{ ["time"] = 60 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeDown") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.Spin") },

{ ["time"] = 80 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeUp") },
{ ["time"] = 100 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeDown") },
{ ["time"] = 80 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.Spin") },

{ ["time"] = 110 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.Spin") },
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeUp") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeDown") },
},
["sprint_loop"] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeUp") },
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_PARALYZER.TubeDown") },
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

SWEP.Glow = Material("models/weapons/tfa_bo3/paralyzer/mtl_t6_wpn_zmb_slowgun_glow.vmt")
SWEP.DefaultGlow = Vector(0.3, 0.3, 1)
SWEP.UpgradedGlow = Vector(0.15, 1, 0.2)

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

SWEP.ViewModelBoneMods = {
	["tag_control_dial_1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["tag_control_dial_2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["tag_control_dial_3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.CylinderRadius = 90
SWEP.CylinderRange = 400
SWEP.CylinderInnerRange = 90
SWEP.OverheatTime = 5
SWEP.CookingRate = 0.5 //anything at or above 5 will always instakill
SWEP.GlowLevel = 1
SWEP.ilastClip1 = 0

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local l_CT = CurTime
local nzombies = engine.ActiveGamemode() == "nzombies"
local _sp = game.SinglePlayer()
local i_lastClip1 = 0

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

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "HasEmitSound")
	self:NetworkVarTFA("Bool", "HitBarrier")
	self:NetworkVarTFA("Float", "GlowRatio")

	if SERVER then
		self:SetGlowRatio(0)
	end
	if CLIENT then
		self.ilastClip1 = 0
	end
end

function SWEP:Deploy(...)
	if SERVER and self:GetOwner():IsPlayer() then
		timer.Create("bo3_paralyzer_reload" ..self:EntIndex(), (self.Ispackapunched and 0.25 or 0.33), 0, function()
			if not IsValid(self) then return end
			if self:GetStatus() == TFA.Enum.STATUS_SHOOTING then return end

			if self:Clip1() < self.Primary_TFA.MaxAmmo then self:SetClip1(math.min(self:Clip1() + 1, self.Primary_TFA.MaxAmmo)) else return end

			if self:GetOwner():GetActiveWeapon() == self then self:EmitSound("TFA_BO3_PARALYZER.Tick") end
		end)
	end

	return BaseClass.Deploy(self,...)
end

/*function SWEP:PreDrawViewModel(vm, wep, ply)
	self.Glow:SetVector("$emissiveblendtint", LerpVector(self:GetGlowRatio(), (self.Ispackapunched and self.UpgradedGlow or self.DefaultGlow), Vector(1, 0.05, 0.05)))
end*/

function SWEP:PrePrimaryAttack()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if self:CanPrimaryAttack() and !self:GetHasEmitSound() then
		self:SetHitBarrier(false)
		self:SetHasEmitSound(true)
		if IsFirstTimePredicted() then
			self:EmitGunfireSound(self:GetStatL("Primary.Sound"))

			if self:VMIV() then
				ParticleEffectAttach(self:IsFirstPerson() and (self.Ispackapunched and "bo3_paralyzer_muzzleflash_pap" or "bo3_paralyzer_muzzleflash") or (self.Ispackapunched and "bo3_paralyzer_muzzleflash_3p_pap" or "bo3_paralyzer_muzzleflash_3p"), PATTACH_POINT_FOLLOW, (self:IsFirstPerson() and self.OwnerViewModel or self), 1)
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
					util.Effect("tfa_bo3_paralyzer_3p", fx, true, filter)
				end
			end
		end
	end
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local aim = self:GetAimVector()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end

	if ply:BO3IsFlying() and ifp and ply:KeyDown(IN_JUMP) then
		ParticleEffect("bo3_paralyzer_lift", ply:GetPos(), Angle(0,0,0))
	end

	local n_inner_range = self.CylinderInnerRange
	local n_outer_range = self.CylinderRange
	local n_cylinder_radius = self.CylinderRadius

	local n_inner_range_squared = n_inner_range * n_inner_range
	local n_outer_range_squared = n_outer_range * n_outer_range
	local n_cylinder_radius_squared = n_cylinder_radius * n_cylinder_radius

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

			if not (ent:IsPlayer() or ent:IsNextBot() or ent:IsNPC()) then continue end
			if ent == ply then continue end
			if ent:Health() <= 0 then continue end
			if nzombies and (ent.NZBossType or string.find(ent:GetClass(), "nz_zombie_boss")) then continue end

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
			if test_origin:DistToSqr(radial_origin) > n_cylinder_radius_squared then
				continue // guy's outside the range of the cylinder of effect
			end

			local tr1 = util.TraceLine({
				start = view_pos,
				endpos = test_origin,
				filter = {self, ply},
				mask = MASK_SOLID_BRUSHONLY,
			})

			if tr1.HitWorld then
				continue // guy can't actually be hit from where we are
			end

			if not ent:IsPlayer() or ply:IsNPC() then
				local dist_ratio = (n_outer_range_squared - test_range_squared) / (n_outer_range_squared)
				local final_time = tonumber(Lerp(dist_ratio, 0.1, self.CookingRate))
				if test_range_squared < n_inner_range_squared then
					final_time = self.CookingRate*2
				end

				ent:BO3Slow(final_time, ply, self, self.Ispackapunched)
			elseif ent:IsPlayer() and !ent:IsOnGround() then
				ent:BO3ParalyzerFly(self)
			end
		end
	end

	if self:Clip1() == 0 then
		self:SetNextPrimaryFire(self:GetNextCorrectedPrimaryFire(self.OverheatTime))
	end
end

//yeah, we copy paste to change one thing
function SWEP:TriggerAttack(tableName, clipID)
	local self2 = self:GetTable()
	local ply = self:GetOwner()

	local fnname = clipID == 2 and "Secondary" or "Primary"

	if TFA.Enum.ShootReadyStatus[self:GetShootStatus()] then
		self:SetShootStatus(TFA.Enum.SHOOT_IDLE)
	end

	if self:GetStatRawL("CanBeSilenced") and (ply.KeyDown and self:KeyDown(IN_USE)) and (SERVER or not sp) and (ply.GetInfoNum and ply:GetInfoNum("cl_tfa_keys_silencer", 0) == 0) then
		local _, tanim, ttype = self:ChooseSilenceAnim(not self:GetSilenced())
		self:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, self:GetActivityLength(tanim, true, ttype))

		return
	end

	self["SetNext" .. fnname .. "Fire"](self, self2["GetNextCorrected" .. fnname .. "Fire"](self, self2.GetFireDelay(self)))

	if self:GetMaxBurst() > 1 then
		self:SetBurstCount(math.max(1, self:GetBurstCount() + 1))
	end

	if self:GetStatL("PumpAction") and self:GetReloadLoopCancel() then return end

	self:SetStatus(TFA.Enum.STATUS_SHOOTING, self["GetNext" .. fnname .. "Fire"](self))
	self:ToggleAkimbo()
	self:IncreaseRecoilLUT()

	local ifp = IsFirstTimePredicted()

	local _, tanim, ttype = self:ChooseShootAnim(ifp)

	//ply:SetAnimation(PLAYER_ATTACK1)

	if SERVER and self:GetStatL(tableName .. ".SoundHint_Fire") then
		sound.EmitHint(bit.bor(SOUND_COMBAT, SOUND_CONTEXT_GUNFIRE), self:GetPos(), self:GetSilenced() and 500 or 1500, 0.2, self:GetOwner())
	end

	if self:GetStatL(tableName .. ".Sound") and ifp and not (sp and CLIENT) then
		if ply:IsPlayer() and self:GetStatL(tableName .. ".LoopSound") and self:ShouldEmitGunfireLoop(tableName) then
			self:EmitGunfireLoop()
		else
			local tgtSound = self:GetStatL(tableName .. ".Sound")

			if self:GetSilenced() then
				tgtSound = self:GetStatL(tableName .. ".SilencedSound", tgtSound)
			end

			if (not sp and SERVER) or not self:IsFirstPerson() then
				tgtSound = self:GetSilenced() and self:GetStatL(tableName .. ".SilencedSound_World", tgtSound) or self:GetStatL(tableName .. ".Sound_World", tgtSound)
			end

			self:EmitGunfireSound(tgtSound)
		end

		self:EmitLowAmmoSound()
	end

	self2["Take" .. fnname .. "Ammo"](self, self:GetStatL(tableName .. ".AmmoConsumption"))

	if self["Clip" .. clipID](self) == 0 and self:GetStatL(tableName .. ".ClipSize") > 0 then
		self["SetNext" .. fnname .. "Fire"](self, math.max(self["GetNext" .. fnname .. "Fire"](self), l_CT() + (self:GetStatL(tableName .. ".DryFireDelay", self:GetActivityLength(tanim, true, ttype)))))
	end

	self:ShootBulletInformation()
	self:UpdateJamFactor()
	local _, CurrentRecoil = self:CalculateConeRecoil()
	self:Recoil(CurrentRecoil, ifp)

	-- shouldn't this be not required since recoil state is completely networked?
	if sp and SERVER then
		self:CallOnClient("Recoil", "")
	end

	self:DoAmmoCheck(clipID)

	-- Condition self:GetStatus() == TFA.Enum.STATUS_SHOOTING is always true?
	if self:GetStatus() == TFA.Enum.STATUS_SHOOTING and self:GetStatL("PumpAction") then
		if self["Clip" .. clipID](self) == 0 and self:GetStatL("PumpAction.value_empty") then
			self:SetReloadLoopCancel(true)
		elseif (self:GetStatL(tableName .. ".ClipSize") < 0 or self["Clip" .. clipID](self) > 0) and self:GetStatL("PumpAction.value") then
			self:SetReloadLoopCancel(true)
		end
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local status = self:GetStatus()

	if ply:IsPlayer() then
		if ply:GetAmmoCount(self:GetPrimaryAmmoType()) ~= self.Primary.DefaultClip then
			ply:SetAmmo(self.Primary.DefaultClip, self:GetPrimaryAmmoType())
		end

		if SERVER then
			if status == TFA.Enum.STATUS_SHOOTING and !ply:BO3IsFlying() then
				local aim = self:GetAimVector()
				local dotdown = aim:Dot(vector_up*-1)

				if dotdown > 0.8 and not ply:OnGround() then
					ply:BO3ParalyzerFly(self)
				end
			end
			if ply:BO3IsFlying() and not ply:IsOnGround() then
				self:player_fly_rumble()
			end
		end

		if CLIENT and self.ilastClip1 ~= self:Clip1() then
			self.ilastClip1 = self:Clip1()
			self:SyncMeter()
		end
	end

	if SERVER then
		self:SetGlowRatio(1 - math.Clamp(self:Clip1() / self.Primary_TFA.MaxAmmo, 0, 1))
	end

	if self:GetHasEmitSound() and status ~= TFA.Enum.STATUS_SHOOTING then
		self:SetHasEmitSound(false)
		if IsFirstTimePredicted() then
			self:CleanParticles()
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:SyncMeter()
	if SERVER then return end

	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and self:VMIV() then
		local clip = self.Primary_TFA.MaxAmmo - self:Clip1()
		local fix,fix1,fix2 = 70, 70, -74
		self.ViewModelBoneMods["tag_control_dial_1"].angle = Angle(math.Truncate(clip*0.01)*-36 + fix,0,0)
		self.ViewModelBoneMods["tag_control_dial_2"].angle = Angle(math.Truncate(clip*0.1)*-36 + fix1,0,0)
		self.ViewModelBoneMods["tag_control_dial_3"].angle = Angle(clip*-36 + fix2,0,0)
	end
end

function SWEP:player_fly_rumble()
	if CLIENT then return end
	local ply = self:GetOwner()
	local ground = ply:GetGroundEntity()

	if IsValid(ground) then
		self:SetHitBarrier(false)
	else
		local ahead = self:get_ahead_ent()

		if IsValid(ahead) or ahead == Entity(0) and not self:GetHitBarrier() then
			ply:EmitSound("TFA_BO3_PARALYZER.HitWall")
			local mins, maxs = ply:GetHull()
			util.ScreenShake(ply:EyePos(), 5, 5, 0.5, maxs.z*2)

			if ply.TFAVOX_Sounds then
				local sndtbl = ply.TFAVOX_Sounds['damage']
				if sndtbl then
					TFAVOX_PlayVoicePriority(ply, sndtbl[HITGROUP_GENERIC], 99)
				end
			end

			self:SetHitBarrier(true)
		end
	end
end

function SWEP:get_ahead_ent()
	local ply = self:GetOwner()
	local vel = ply:GetVelocity()

	if vel:LengthSqr() < 225 then
		return nil
	end
	
	local trace = {
		start = ply:GetShootPos(),
		endpos = ply:GetShootPos() + (vel * .25),
		maxs = Vector(0, 1, 0) * 15,
		mins = Vector(0, 1, 0) * 15,
		filter = {self, ply},
		mask = MASK_SHOT_HULL,
	}

	local tr1 = util.TraceHull(trace)

	if tr1.HitNormal:Dot(Vector(0,0,-1)) > 0.8 then
		if IsValid(tr1.Entity) and tr1.Fraction < .5 then
			return tr1.Entity
		elseif tr1.Fraction < .5 and tr1.HitWorld then
			return Entity(0)
		end
	end

	return nil
end

function SWEP:Reload()
	return false
end

function SWEP:ShootBulletInformation()
end

function SWEP:OnRemove(...)
	timer.Remove("bo3_paralyzer_reload" ..self:EntIndex())
	self:StopSound("TFA_BO3_PARALYZER.Loop")
	self:StopSound("TFA_BO3_PARALYZER.FireLoop")
	return BaseClass.OnRemove(self,...)
end

function SWEP:OwnerChanged(...)
	timer.Remove("bo3_paralyzer_reload" ..self:EntIndex())
	self:StopSound("TFA_BO3_PARALYZER.Loop")
	self:StopSound("TFA_BO3_PARALYZER.FireLoop")
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:StopSound("TFA_BO3_PARALYZER.Loop")
	self:StopSound("TFA_BO3_PARALYZER.FireLoop")
	self:StopSoundNet("TFA_BO3_PARALYZER.Loop")
	self:StopSoundNet("TFA_BO3_PARALYZER.FireLoop")
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
		surface.DrawTexturedRect(x - 32, y  - 32, 64, 64)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 64)
	end
end