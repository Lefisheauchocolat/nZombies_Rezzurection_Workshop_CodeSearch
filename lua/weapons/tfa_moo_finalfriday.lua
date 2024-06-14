SWEP.Base = "tfa_melee_base"
SWEP.Category = "nZombies Buyable Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "YuRaNnNzZZ & FlamingFox & GhostlyMoo"
SWEP.Slot = 0
SWEP.PrintName = "Machete"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--

SWEP.ViewModelFOV = 65
SWEP.ViewModel = "models/weapons/tfa_l4d_mw2019/melee/c_machete.mdl"
SWEP.WorldModel = "models/weapons/tfa_l4d_mw2019/melee/w_machete.mdl"
SWEP.HoldType = "melee"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = {
    Pos = {
        Up = -4.5,
        Right = 1,
        Forward = 4,
    },
    Ang = {
		Up = 90,
        Right = -5,
        Forward = -180
    },
	Scale = 1
}

SWEP.EventTable = {
	["deploy"] = {
		{time = 7 / 30, type = "sound", value = "weapon_mw2019_machete.draw"},
	},
}

--[Gun Related]--
SWEP.Primary.Sound = Sound("weapon_mw2019_machete.swing_miss")
SWEP.Primary.Sound_Hit = Sound("weapon_mw2019_machete.swing_world")
SWEP.Primary.Sound_HitFlesh = Sound("weapon_mw2019_machete.swing_flesh")
SWEP.Primary.DamageType = DMG_SLASH
SWEP.Primary.RPM = 100
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.MaxCombo = 0

--[Stuff]--
SWEP.ImpactDecal = "ManhackCut"
SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)
SWEP.Secondary.CanBash = false
SWEP.AltAttack = false
SWEP.AllowSprintAttack = true
SWEP.CanKnifeLunge = true

SWEP.NZPreventBox = true	-- If true, this gun won't be placed in random boxes GENERATED. Users can still place it in manually.
SWEP.NZTotalBlackList = true	

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI

--[Traces]--
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_PRIMARYATTACK, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 65, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-15, 1, -35), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 950, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 7 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 1, --Hullsize
	},
	{
		["act"] = ACT_VM_HITLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 65, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-15, 1, -35), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 950, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 7 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 1, --Hullsize
	},
	{
		["act"] = ACT_VM_HITRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 65, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-45, 1, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 950, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 7 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 1, --Hullsize
	},
}

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local devcon = GetConVar("developer")

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "Lunging")
	self:NetworkVarTFA("Bool", "Stabbed")
end

function SWEP:AdjustMouseSensitivity()
	if self:GetLunging() then
		return 0.25
	end
	if self:GetStatus() ~= TFA.Enum.STATUS_SHOOTING and self:GetNextPrimaryFire() > CurTime() and self:GetStabbed() then
		return math.Clamp(CurTime()/self:GetNextPrimaryFire(), 0.2, 1)
	end
end

local l_CT = CurTime
local sp = game.SinglePlayer()

function SWEP:PrimaryAttack(...)
	local ply = self:GetOwner()
	local pos = ply:GetShootPos()
	local aim = self:GetAimVector()

	if ply:IsPlayer() then
		ply:LagCompensation(true)
	end

	local tr = util.TraceHull({
		start = pos,
		endpos = pos + (aim * 120),
		filter = ply,
		mins = Vector(-10, -5, 0),
		maxs = Vector(10, 5, 5),
		mask = MASK_SHOT_HULL,
	})

	if ply:IsPlayer() then
		ply:LagCompensation(false)
	end

	local ent = tr.Entity
	if IsValid(ent) and (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then
		local speed = ply:GetVelocity():Length()
		local dist = ply:GetPos():DistToSqr(ent:GetPos())

		local range = 60
		local maxrange = 120
		local maxspeed = ply:GetRunSpeed()/2

		local diff = maxrange - range
		range = math.Clamp((range + diff) * (speed/maxspeed), range, maxrange)

		if dist <= range^2 and speed > maxspeed then
			//self:SendViewModelAnim(ACT_VM_HITRIGHT)
			self:SetLunging(true)
			self:SetStabbed(true)
			if ent:Health() > 0 then
				ply:SetKnifingTarget(ent)
				if devcon:GetInt() > 0 then
					ply:PrintMessage(2, tostring(ply:GetKnifingTarget()))
				end
			end
			return self:SecondaryAttack()
		end
	end

	return BaseClass.PrimaryAttack(self, ...)
end

function SWEP:Think2()
	local ply = self:GetOwner()
	local status = self:GetStatus()
	local statusend = CurTime() > self:GetStatusEnd()

	if status == TFA.Enum.STATUS_SHOOTING and self:GetLunging() then
		if statusend then
			self:SetLunging(false)
		end
	end

	if self:GetStabbed() and status ~= TFA.Enum.STATUS_SHOOTING and CurTime() > self:GetNextPrimaryFire() then
		self:SetStabbed(false)
	end

	if IsValid(ply) and self:Clip1() <= 0 and self:Ammo1() > 0 and self:GetNextPrimaryFire() <= CurTime() and self.Primary.ClipSize > 0 then
		self:Reload(true)
	end

	return BaseClass.Think2(self)
end

function SWEP:Hoslter(...)
	if self:GetLunging() then
		return false
	end

	return BaseClass.Hoslter(self, ...)
end
