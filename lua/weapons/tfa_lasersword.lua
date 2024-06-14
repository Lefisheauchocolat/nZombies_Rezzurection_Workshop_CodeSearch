SWEP.Base = "tfa_melee_base"
SWEP.Category = "nZombies Buyable Knives"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "Melee"
SWEP.Author = "Laby"
SWEP.Slot = 0
SWEP.PrintName = "Lightsaber"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

--[Model]--

SWEP.ViewModelFOV = 65
SWEP.ViewModel = "models/weapons/nz/lasersword.mdl"
SWEP.WorldModel = "models/weapons/w_ttt_lightsaber.mdl"
SWEP.HoldType = "melee2"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = {
	Pos = {
		Up = 0,
		Right = 1,
		Forward = 3
	},
	Ang = {
		Up = 0,
		Right = 15,
		Forward = 180
	},
	Scale = 1
}

SWEP.Bodygroups_V = nil --{
	--[0] = 1,
	--[1] = 4,
	--[2] = etc.
--}
SWEP.BeltBG = 1


SWEP.EventTable = {
	[ACT_VM_DRAW_DEPLOYED] = {
	{ ["time"] = 27 / 30, ["type"] = "sound", ["value"] = Sound("lasersword.ignite") },
		{ ["time"] = 28/30, ["type"] = "lua", ["value"] = function(self)
			self.Bodygroups_V[ 1 ] = 1
		end},
	},
	[ACT_VM_FIDGET] = {
	{ ["time"] = 0 / 30, ["type"] = "sound", ["value"] = Sound("lasersword.putaway") },
		{ ["time"] = 0/30, ["type"] = "lua", ["value"] = function(self)
			self.Bodygroups_V[ 1 ] = 0
		end},
		{ ["time"] = 121 / 30, ["type"] = "sound", ["value"] = Sound("lasersword.ignite") },
		{ ["time"] = 123/30, ["type"] = "lua", ["value"] = function(self)
			self.Bodygroups_V[ 1 ] = 1
		end},
	}
}



--[Gun Related]--
SWEP.Primary.DamageType = DMG_SLOWBURN
SWEP.Primary.RPM = 200
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
		["act"] = ACT_VM_HITLEFT,
		["len"] = 100,
		["src"] = Vector(0, -16, 0),
		["dir"] = Vector(-10, 12, 0),
		["dmg"] = 666000,
		["dmgtype"] = DMG_SHOCK,
		["delay"] = 3 / 30,
		["snd"] = "lasersword.swing1",
		["snd_delay"] = 0,
		["hitflesh"] = "lasersword.hit",
		["hitworld"] = "weapons/lasersword/hit1.mp3",
		["viewpunch"] = Angle(0, 0, 0),
		["end"] = 1,
		["hull"] = 10,
	}
}
SWEP.Secondary.Attacks = {
	{
		["act"] = ACT_VM_HITRIGHT,
		["len"] = 200,
		["src"] = Vector(0, 0, 0),
		["dir"] = Vector(-1, 24, 2),
		["dmg"] = 666000,
		["dmgtype"] = DMG_SHOCK,
		["delay"] = 4 / 30,
		["snd"] = "lasersword.swing5",
		["snd_delay"] = 0,
		["hitflesh"] = "lasersword.hit",
		["hitworld"] = "weapons/lasersword/hit1.mp3",
		["viewpunch"] = Angle(0, 0, 0),
		["end"] = 1.5,
		["hull"] = 10,
	}
}


if surface and surface.GetTextureID then
	SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/tfa_mwr_harpoon")
end

if killicon and killicon.Add then
	killicon.Add("tfa_mwr_harpoon", "vgui/killicons/tfa_mwr_harpoon", Color(255, 80, 0, 191))
end

function SWEP:PreDrawViewModel( vm )

		self.Owner:GetViewModel():SetSubMaterial(0, nil)

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
