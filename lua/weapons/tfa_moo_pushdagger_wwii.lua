SWEP.Base = "tfa_melee_base"
SWEP.Category = "nZombies Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "FlamingFox & Loonicity"
SWEP.Slot = 0
SWEP.PrintName = "Push Dagger (WWII)"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--

SWEP.Primary.Sound = Sound("TFA_CODWW2_KNIFE.Swing")
SWEP.Primary.Sound_Hit = Sound("TFA_CODWW2_MELEE.Hit")
SWEP.Primary.Sound_HitFlesh = Sound("TFA_CODWW2_KNIFE.Stab")
SWEP.ViewModelFOV = 65
SWEP.ViewModel = "models/weapons/tfa_codww2/dagger/c_katedagger.mdl"
SWEP.WorldModel = "models/weapons/tfa_codww2/dagger/w_katedagger.mdl"
SWEP.HoldType = "knife"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.6,
        Right = 1.2,
        Forward = 3,
        },
        Ang = {
		Up = -90,
        Right = 0,
        Forward = 10
        },
		Scale = 1.1
}

SWEP.EventTable = {
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_KNIFE.Draw") },
},
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_KNIFE.Draw") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 2 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_SML.Holster") },
},
[ACT_VM_FIDGET] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_KNIFE.Inspect1") },
{ ["time"] = 50 / 30, ["type"] = "sound", ["value"] = Sound("TFA_CODWW2_KNIFE.Inspect2") },
},
}

--[Gun Related]--
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

--[Traces]--
SWEP.Primary.Attacks = {
	{
		["act"] = ACT_VM_MISSLEFT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 60, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-45, 0, -5), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 250, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 8 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1.2, --time before next attack
		["hull"] = 1, --Hullsize
	}
}
SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_MISSRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 60, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(0, 35, 0), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = 250, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 5 / 30, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1.3, --time before next attack
		["hull"] = 1, --Hullsize
	}
}

SWEP.SequenceRateOverride = {
}

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

if surface and surface.GetTextureID then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_mwr_knuckle_knife_irish")
end

if killicon and killicon.Add then
	killicon.Add("tfa_mwr_knuckle_knife_irish", "vgui/killicons/tfa_mwr_knuckle_knife_irish", Color(255, 80, 0, 191))
end

if TFA and TFA.AddSound then
	local p1,p2="yurie_h1.shamrock_","weapons/tfa_cod/mwr/h1_dlc_wpn/melee_shamrock/shamrock_"
	TFA.AddSound(p1.."ins_01", CHAN_STATIC, 1, 75, 100, p2.."ins_01.ogg", ")")
	TFA.AddSound(p1.."ins_02", CHAN_STATIC, 1, 75, 100, p2.."ins_02.ogg", ")")
	TFA.AddSound(p1.."ins_03", CHAN_STATIC, 1, 75, 100, p2.."ins_03.ogg", ")")
	TFA.AddSound(p1.."ins_04", CHAN_STATIC, 1, 75, 100, p2.."ins_04.ogg", ")")
	TFA.AddSound(p1.."pulloutfirst_01", CHAN_STATIC, 1, 75, 100, p2.."pulloutfirst_01.ogg", ")")
	TFA.AddSound(p1.."pulloutfirst_02", CHAN_STATIC, 1, 75, 100, p2.."pulloutfirst_02.ogg", ")")
	TFA.AddSound(p1.."pulloutfirst_03", CHAN_STATIC, 1, 75, 100, p2.."pulloutfirst_03.ogg", ")")
end

if TFA and TFA.AddSound then
	local p1,p2 = "yurie_h1.","weapons/tfa_cod/mwr/h1_dlc_wpn/impacts/"

	TFA.AddSound(p1.."blade_stab_hit", CHAN_STATIC, 1, 75, 100, {p2.."wpn_blade_stab_hit_01.ogg",p2.."wpn_blade_stab_hit_02.ogg",p2.."wpn_blade_stab_hit_03.ogg"}, ")")
	TFA.AddSound(p1.."blade_swipe_hit", CHAN_STATIC, 1, 75, 100, {p2.."wpn_blade_swipe_hit_01.ogg",p2.."wpn_blade_swipe_hit_02.ogg",p2.."wpn_blade_swipe_hit_03.ogg"}, ")")
	TFA.AddSound(p1.."hammer_stab_hit", CHAN_STATIC, 1, 75, 100, {p2.."wpn_hammer_stab_hit_01.ogg",p2.."wpn_hammer_stab_hit_02.ogg"}, ")")
	TFA.AddSound(p1.."hammer_swipe_hit", CHAN_STATIC, 1, 75, 100, {p2.."wpn_hammer_swipe_hit_01.ogg",p2.."wpn_hammer_swipe_hit_02.ogg"}, ")")
	TFA.AddSound(p1.."shovel_swipe_hit", CHAN_STATIC, 1, 75, 100, {p2.."wpn_shovel_swipe_hit_01.ogg",p2.."wpn_shovel_swipe_hit_02.ogg"}, ")")

	p2="weapons/tfa_cod/mwr/h1_dlc_wpn/melee_gen/"
	TFA.AddSound(p1.."solid_impact", CHAN_STATIC, 1, 75, 100, {p2.."h1_melee_solid_impact_01.ogg",p2.."h1_melee_solid_impact_02.ogg",p2.."h1_melee_solid_impact_03.ogg"}, ")")

	p2="weapons/tfa_cod/mwr/h1_dlc_wpn/hatchet/"
	TFA.AddSound(p1.."melee_putaway", CHAN_STATIC, 1, 75, 100, p2.."melee_putaway_01.ogg", ")")

	p2="weapons/tfa_cod/mwr/h1_dlc_wpn/melee_stick/"
	TFA.AddSound(p1.."melee_swipe_gen", CHAN_STATIC, 1, 75, 100, {p2.."melee_swipe_gen_01.ogg",p2.."melee_swipe_gen_02.ogg",p2.."melee_swipe_gen_03.ogg",p2.."melee_swipe_gen_04.ogg"}, ")")

	-- wrong soungs I DONT FUCKING CARE as long as they fit
	p2="weapons/tfa_cod/mwr/foley/gear/"
	TFA.AddSound(p1.."viewmodel_small", CHAN_STATIC, .2, 75, {113,117}, {p2.."foley_land_gear_lt_01.ogg",p2.."foley_land_gear_lt_02.ogg",p2.."foley_land_gear_lt_03.ogg",p2.."foley_land_gear_lt_04.ogg",p2.."foley_land_gear_lt_05.ogg"}, ")")
	TFA.AddSound(p1.."viewmodel_medium", CHAN_STATIC, .3, 75, {98,102}, {p2.."foley_land_gear_med_01.ogg",p2.."foley_land_gear_med_02.ogg",p2.."foley_land_gear_med_03.ogg",p2.."foley_land_gear_med_04.ogg",p2.."foley_land_gear_med_05.ogg"}, ")")
	TFA.AddSound(p1.."viewmodel_large", CHAN_STATIC, .4, 75, {83,87}, {p2.."foley_land_gear_hv_01.ogg",p2.."foley_land_gear_hv_02.ogg",p2.."foley_land_gear_hv_03.ogg",p2.."foley_land_gear_hv_04.ogg",p2.."foley_land_gear_hv_05.ogg"}, ")")
end

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