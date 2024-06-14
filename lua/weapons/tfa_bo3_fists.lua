SWEP.Base = "tfa_melee_base"
DEFINE_BASECLASS(SWEP.Base)
SWEP.Category = "TFA Black Ops 3 Melees"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Author = "Olli, Fox, Mav"
SWEP.Slot = 0
SWEP.PrintName = "Fists"
SWEP.DrawCrosshair = true

--[Model]--
SWEP.ViewModel = "models/weapons/bo3_melees/fists/c_fists.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel = "models/weapons/bo3_melees/fists/w_fists.mdl"
SWEP.HoldType = "fist"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Scale = 0
}

--[Gun Related]--
SWEP.Primary.Sound = Sound("Weapon_BO3_FISTS.Swing")
SWEP.Primary.Sound_Hit = Sound("Weapon_BO3_FISTS.Hit")
SWEP.Primary.DamageType = bit.bor(DMG_CLUB, DMG_SLASH)
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 35
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.Damage = 75
SWEP.Secondary.MaxCombo = 0

--[Traces]--
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(20, 25, -5), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 8 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1, --time before next attack
		["hull"] = 10, --Hullsize
	},
	{
		["act"] = ACT_VM_MISSCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 50, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-20, 25, -5), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 8 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1, --time before next attack
		["hull"] = 10, --Hullsize
	}
}
SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 65, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(0, 35, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Secondary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 6 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_Hit,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 0.9, --time before next attack
		["hull"] = 10, --Hullsize
	},
	{
		["act"] = ACT_VM_HITRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 65, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(0, 35, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Secondary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 6 / 30, --Delay
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
SWEP.ImpactDecal = ""
SWEP.InspectPos = Vector(0, 0, 0)
SWEP.InspectAng = Vector(0, 0, 0)
SWEP.Secondary.CanBash = false
SWEP.AltAttack = false
SWEP.AllowSprintAttack = false

--[Tables]--
SWEP.SequenceRateOverride = {
	["showcase_in"] = 60 / 30,
	["showcase_out"] = 60 / 30,
	[ACT_VM_MISSCENTER] = 45 / 30,
	[ACT_VM_DRAW] = 60 / 30,
	[ACT_VM_HOLSTER] = 60 / 30,
	[ACT_VM_MISSRIGHT] = 45 / 30,
	["sprint_loop"] = 45 / 30
}

SWEP.EventTable = {
	["draw_first"] = {
		{time = 7 / 30, type = "sound", value = "Weapon_BO3_FISTS.Crack"},
	},
	["taunt"] = {
		{time = 1 / 30, type = "sound", value = "Weapon_BO3_FISTS.Taunt"},
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

SWEP.CustomizeAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "showcase_in",
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "showcase_idle",
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,
		["value"] = "showcase_out",
	}
}

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Customize_Mode = TFA.Enum.LOCOMOTION_HYBRID
