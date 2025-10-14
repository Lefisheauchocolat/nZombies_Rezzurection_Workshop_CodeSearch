local nzombies = engine.ActiveGamemode() == "nzombies"
local inf_cvar = GetConVar("sv_tfa_bo3ww_inf_specialist")

SWEP.Base = "tfa_backshield_base"
SWEP.Category = "TFA Zombies Buildables"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.74
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.buildable.shield"
SWEP.Author = "FlamingFox"
SWEP.Slot = 0
SWEP.PrintName = nzombies and "Rocket Shield | BO3" or "Rocket Shield"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/rocketshield/c_rocketshield.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/rocketshield/w_rocketshield.mdl"
SWEP.HoldType = "melee2"
SWEP.SprintHoldTypeOverride = "melee2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 2
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = 2,
		Right = 12,
		Forward = 4,
	},
	Ang = {
		Up = -105,
		Right = 192,
		Forward = -10
	},
	Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA_BO3_SHIELD.Swing"
SWEP.Primary.Sound_Hit = "TFA_BO3_SHIELD.Hit"
SWEP.Primary.DamageType = bit.bor(DMG_CLUB, DMG_PREVENT_PHYSICS_FORCE)
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 115
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.Damage = 115
SWEP.Secondary.MaxCombo = 0

SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.AmmoConsumption = 0
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = 3
SWEP.Secondary.DefaultClip = 3
SWEP.Secondary.AmmoConsumption = inf_cvar:GetBool() and 0 or 1
SWEP.Secondary.Ammo = "none"

SWEP.ShieldEnabled = true
SWEP.ShieldModel = "models/weapons/tfa_bo3/rocketshield/w_rocketshield_back.mdl"

--[Traces]--
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 70, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(65, 0, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 4 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 10, --Hullsize
	}
}

--[Stuff]--
SWEP.ImpactDecal = "ManhackCut"
SWEP.InspectPos = Vector(0, 3, 0)
SWEP.InspectAng = Vector(0, 0, 0)
SWEP.Secondary.CanBash = false
SWEP.AltAttack = false
SWEP.AllowSprintAttack = false

--[NZombies]--
SWEP.NZPaPName = "Goddard Aparatus"
SWEP.NZWonderWeapon = false
SWEP.NZSpecialCategory = "shield"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZHudIcon = Material("vgui/icon/t7_hud_rocket_shield.png", "unlitgeneric smooth")
SWEP.Ispackapunched = false

function SWEP:NZSpecialHolster(wep)
	return true
end

function SWEP:OnPaP()
self.Ispackapunched = true
self.PrintName = "Goddard Aparatus"
self:SetNW2String("PrintName", "Goddard Aparatus")

self.Secondary_TFA.ClipSize = 4
self.Secondary_TFA.DefaultClip = 4
self:SetClip2(self.Secondary_TFA.ClipSize)

self.Primary_TFA.ClipSize = 200
self.Primary_TFA.DefaultClip = 200
self:SetClip1(self.Primary_TFA.ClipSize)

local ply = self:GetOwner()
if IsValid(ply) then
	ply.RocketShieldPAP = true
	if SERVER and self.Shield and IsValid(self.Shield) then
		self.Shield:SetMaxHealth(self.Shield:GetMaxHealth()*2)
		self.Shield:SetHealth(self.Shield:GetMaxHealth())
	end
end

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HITCENTER] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_SHIELD.SwingCloth") },
},
[ACT_VM_PULLPIN] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ROCKETSHIELD.Start") },
},
[ACT_VM_THROW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO3_ROCKETSHIELD.End") },
},
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

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

SWEP.BO3CanDash = true
SWEP.BO3DashMult = 1.8

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Int", "KillCount")
	self:NetworkVarTFA("Bool", "Dashing")
end

function SWEP:AdjustMouseSensitivity()
	if self:GetDashing() then
		return 0.1
	end
end

if nzombies then
function SWEP:Equip(ply)
	if SERVER and ply.RocketShieldPAP then
		timer.Simple(0, function()
			if not IsValid(self) then return end
			self:ApplyNZModifier("pap")
			if IsValid(ply) and ply.PLEASEFIXNZSAWFULWEAPONSYSTEM then
				ply.PLEASEFIXNZSAWFULWEAPONSYSTEM = nil
			end
		end)
	end

	return BaseClass.Equip(self, ply)
end
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	if ply:IsNPC() then
		ply.OldSchedule = ply:GetCurrentSchedule()
		self:EmitSoundNet("TFA_BO3_ROCKETSHIELD.Start")
		ply:SetSchedule(SCHED_NPC_FREEZE)
		self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_PULL , 0.9)
		self:SetNextPrimaryFire(self:GetStatusEnd())
	end

	return BaseClass.PrimaryAttack(self)
end

function SWEP:SecondaryAttack()
	if not self:CanPrimaryAttack() then return end
	if not self:GetOwner():IsOnGround() then return end
	if self:GetStatus() == TFA.Enum.STATUS_GRENADE_PULL then return end
	if nzombies and not self:GetOwner():GetNotDowned() then return end
	if self:Clip2() < self:GetStatL("Secondary.AmmoConsumption") then return end

	self:SendViewModelAnim(ACT_VM_PULLPIN)
	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_PULL , 0.9)
	self:SetNextPrimaryFire(self:GetStatusEnd())
	self:SetDashing(true)

	self:TakeSecondaryAmmo(self:GetStatL("Secondary.AmmoConsumption"))
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local stat = self:GetStatus()
	local statusend = CurTime() >= self:GetStatusEnd()

	if stat == TFA.Enum.STATUS_GRENADE_PULL then
		if ply:IsOnGround() then
			if ply:IsNPC() then
				ply:SetVelocity(ply:GetForward()*1000)
			end

			if SERVER then
				self:Dash()
			end
		end

		if statusend then
			if ply:IsNPC() then
				ply:SetSchedule(ply.OldSchedule)
				self:EmitSoundNet("TFA_BO3_ROCKETSHIELD.End")
			end

			if SERVER and ply:IsPlayer() and self:GetKillCount() >= 10 then
				self:EmitSound("TFA_BO3_ROCKETSHIELD.Strike")

				if nzombies then
					if not ply.BO3BowlingCount then ply.BO3BowlingCount = 0 end
					ply.BO3BowlingCount = ply.BO3BowlingCount + 1
				end

				if not ply.bo3rocketshieldac then
					self:EmitSound("TFA_BO3_ROCKETSHIELD.Cheer")
					TFA.BO3GiveAchievement("Strike!", "vgui/overlay/achievment/rocketshield.png", ply)
					ply.bo3rocketshieldac = true
				end
			end

			self:SendViewModelAnim(ACT_VM_THROW)
			self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW, self:GetActivityLength())
			self:SetNextPrimaryFire(self:GetStatusEnd())

			self:SetDashing(false)
			self:SetKillCount(0)
		end
	end

	if SERVER and nzombies and stat == TFA.Enum.STATUS_GRENADE_THROW and statusend and !self:HasNZModifier("pap") and ply.BO3BowlingCount and ply.BO3BowlingCount >= 12 then
		if nzWeps.Updated then
			self:ApplyNZModifier("pap")
		else
			ply.PLEASEFIXNZSAWFULWEAPONSYSTEM = true
			ply.RocketShieldPAP = true
			ply:StripWeapon(self:GetClass())
		end

		local msg1 = "surface.PlaySound('weapons/tfa_bo3/rocketshield/sword_upgrade.wav')"
		ply:SendLua(msg1)
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:Dash()
	local ply = self:GetOwner()

	local damage = DamageInfo()
	damage:SetAttacker(ply)
	damage:SetInflictor(self)
	damage:SetDamageType(DMG_MISSILEDEFENSE)

	for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), 48)) do
		if not v:IsWorld() and v:IsSolid() then
			if v:Health() <= 0 then continue end
			if v:GetOwner() == self:GetOwner() then continue end
			if v == self:GetOwner() then continue end
			if nzombies and v.NZBossType then continue end

			damage:SetDamage(v:Health() + 666)
			damage:SetDamageForce(v:GetUp()*15000 + (v:GetPos() - self:GetPos()):GetNormalized() * 15000)

			v:TakeDamageInfo(damage)
		end
	end

	util.ScreenShake(ply:GetPos() + Vector(0,0,1), 4 * self:GetStatusProgress(), 255, 0.5, 120)
end

function SWEP:Holster(...)
	if self:GetDashing() then
		return false
	end
	return BaseClass.Holster(self, ...)
end
