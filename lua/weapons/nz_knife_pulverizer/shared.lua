SWEP.Base = "tfa_melee_base"
SWEP.Category = "nZombies Buyable Knives"
SWEP.PrintName = "The Pulverizer"
SWEP.Author		= "Laby" --Author Tooltip
SWEP.ViewModel = "models/weapons/bo3_melees/mace/c_mace_nz.mdl"
SWEP.WorldModel = "models/weapons/bo3_melees/mace/w_mace_2.mdl"
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 70
SWEP.UseHands = true
SWEP.HoldType = "melee2"
SWEP.DrawCrosshair = true

SWEP.Primary.Directional = false

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.DisableIdleAnimations = true

SWEP.Secondary.CanBash = false
SWEP.Secondary.MaxCombo = 0
SWEP.Primary.MaxCombo = 0

SWEP.VMPos = Vector(0,0,0) --The viewmodel positional offset, constantly.  Subtract this from any other modifications to viewmodel position.

-- nZombies Stuff


SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -5,
        Right = 1.5,
        Forward = 3,
        },
        Ang = {
		Up = -90,
        Right = 180,
        Forward = -90
        },
		Scale = 1
}

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW_DEPLOYED)
	self.HolsterTime = CurTime() + (45/30)
	
end
SWEP.Primary.Attacks = {
	{
		['act'] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 26*7, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
				["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-38, 0, -38), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 500, --This isn't overpowered enough, I swear!!
		["dmgtype"] = bit.bor(DMG_CLUB),  --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 10 / 30, --Delay
		['snd_delay'] = 11 / 30,
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "Weapon_BO3_KATANA.Swing", -- Sound ID
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1.25, --time before next attack
		["hull"] = 1, --Hullsize
		['hitflesh'] = "Weapon_BO3_MACE.Hit_Flesh",
		['hitworld'] ="Weapon_BO3_AXE.Hit"
	},
	{
		['act'] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		['len'] = 26*7, -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-10, 0, -45), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		['dmg'] = 500, --This isn't overpowered enough, I swear!!
		["dmgtype"] = bit.bor(DMG_CLUB),  --DMG_SLASH,DMG_CRUSH, etc.
		["delay"] = 6 / 30, --Delay
		['snd_delay'] = 7 / 30,
		['spr'] = true, --Allow attack while sprinting?
		['snd'] = "Weapon_BO3_KATANA.Swing", -- Sound ID
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1.25, --time before next attack
		["hull"] = 1, --Hullsize
		['hitflesh'] = "Weapon_BO3_MACE.Hit_Flesh",
		['hitworld'] ="Weapon_BO3_AXE.Hit"
	}
}

SWEP.EventTable = {
	["draw_first"] = {
		{time = 1 / 30, type = "sound", value = "Weapon_BO3_MACE.Draw"}
	}
}


SWEP.SequenceRateOverride = {
	[ACT_VM_MISSCENTER] = 45/ 30
}


if CLIENT then
	SWEP.WepSelectIconCSO = Material("vgui/killicons/tfa_cso_mastercombatknife")
	SWEP.DrawWeaponSelection = TFA_CSO_DrawWeaponSelection
end
--[Coding]--
SWEP.AllowSprintAttack = true
SWEP.CanKnifeLunge = true

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
