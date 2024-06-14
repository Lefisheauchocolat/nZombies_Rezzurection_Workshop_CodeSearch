local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_melee_base"
SWEP.Category = "nZombies Buyable Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "Wavy"
SWEP.Slot = 0
SWEP.PrintName = "Galvaknuckles | BO4"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--
SWEP.ViewModel 			= "models/weapons/wavy_ports/bo4/c_bo4_galvies.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel 		= "models/weapons/wavy_ports/bo4/w_bo4_galvies.mdl"
SWEP.HoldType = "fist"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, -0.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 1.5,
        Forward = 4,
        },
        Ang = {
		Up = 0,
        Right = 0,
        Forward = 0
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = "TFA.BO2.GALVIES.SWING"
SWEP.Primary.Sound_Hit = "TFA.BO2.GALVIES.HITWORLD"
SWEP.Primary.Sound_HitFlesh = "TFA.BO2.GALVIES.HIT"
SWEP.Primary.DamageType = DMG_CLUB
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 1500
SWEP.Primary.MaxCombo = 0
SWEP.Secondary.MaxCombo = 0

--[Stuff]--
SWEP.ImpactDecal = "SmallScorch"
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
		["act"] = ACT_VM_HITCENTER, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 65, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-20, 0, 10), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 11 / 40, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1, --time before next attack
		["hull"] = 40, --Hullsize
	}
}
SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_HITRIGHT, -- Animation; ACT_VM_THINGY, ideally something unique per-sequence
		["len"] = 65, -- Trace distance
		["src"] = Vector(0, 0, 0), -- Trace source; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dir"] = Vector(-5, 0, 10), -- Trace direction/length; X ( +right, -left ), Y ( +forward, -back ), Z ( +up, -down )
		["dmg"] = SWEP.Primary.Damage, --Damage
		["dmgtype"] = SWEP.Primary.DamageType,
		["delay"] = 3 / 35, --Delay
		["spr"] = true, --Allow attack while sprinting?
		["snd"] = SWEP.Primary.Sound, -- Sound ID
		["hitflesh"] = SWEP.Primary.Sound_HitFlesh,
		["hitworld"] = SWEP.Primary.Sound_Hit,
		["viewpunch"] = Angle(0, 0, 0), --viewpunch angle
		["end"] = 1.5, --time before next attack
		["hull"] = 40, --Hullsize
	}
}

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.EventTable = {
}

SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only

--[[SWEP.EventTable = {
[ACT_VM_DRAW_DEPLOYED] = {
{ ["time"] = 3 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW.BOWIE.START") },
{ ["time"] = 22 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW.BOWIE.TURN") },
{ ["time"] = 48 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW.BOWIE.TOSS") },
{ ["time"] = 61 / 30, ["type"] = "sound", ["value"] = Sound("TFA_WAW.BOWIE.CATCH") },
},
}]]

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local devcon = GetConVar("developer")

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "Lunging")
	self:NetworkVarTFA("Bool", "Stabbed")
end

function SWEP:Equip(ply, ...)
	if nzombies then
		local wep = ply:Give('nz_bo4_galvies_display')
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:AdjustMouseSensitivity()
	if self:GetLunging() then
		return 0.25
	end
	if self:GetStatus() ~= TFA.Enum.STATUS_SHOOTING and self:GetNextPrimaryFire() > CurTime() and self:GetStabbed() then
		return math.Clamp(CurTime()/self:GetNextPrimaryFire(), 0, 1)
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

function SWEP:ApplyDamage(trace, dmginfo, attk)
	local dam, force = dmginfo:GetBaseDamage(), dmginfo:GetDamageForce()
	dmginfo:SetDamagePosition(trace.HitPos)
	dmginfo:SetReportedPosition(trace.StartPos)
	dmginfo:SetDamageForce(force*6)

	local ent = trace.Entity
	if nzombies then
		dmginfo:SetDamageType(DMG_SHOCK)
		dam = 1500
		dmginfo:SetDamage(dam)
	end

	trace.Entity:DispatchTraceAttack(dmginfo, trace, self:GetOwner():EyeAngles():Forward())

	dmginfo:SetDamage(dam)

	self:ApplyForce(trace.Entity, dmginfo:GetDamageForce(), trace.HitPos)
	self:SetMelAttackID(1)
end