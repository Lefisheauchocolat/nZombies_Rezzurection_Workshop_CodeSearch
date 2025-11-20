local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "Other"
//SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = nzombies and "#tfa.weapontype.tacgrenade" or "Grenade"
SWEP.Purpose = "Crouch to take reduced damage from explosion. 250hu radius."
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "Bouncing Betty | WAW" or "Bouncing Betty"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_waw/bbetty/c_bbetty.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_waw/bbetty/w_bbetty.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 6, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -3,
        Right = 3.5,
        Forward = 4.5,
        },
        Ang = {
		Up = 0,
        Right = 190,
        Forward = -10
        },
		Scale = 0.9
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Ammo = "slam"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = nzombies and 400 or 200
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.AmmoConsumption = nzombies and 0 or 1
SWEP.Primary.ClipSize = nzombies and 999 or 1
SWEP.Primary.DefaultClip = nzombies and 999 or 3
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false
SWEP.Delay = 0.15

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = .001

--[Projectiles]--
SWEP.Primary.Round = nzombies and "nz_waw_tac_bbetty" or "waw_tac_bbetty"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_waw/bbetty/w_bbetty.mdl"
SWEP.Velocity = 1200
SWEP.Underhanded = false
SWEP.AllowSprintAttack = nzombies and true or false
SWEP.AllowUnderhanded = false
SWEP.DisableIdleAnimations = false

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.VMOffsetWalk = Vector(-1, -1, -1)
SWEP.RunSightsPos = Vector(0, -1, -0.5)
SWEP.RunSightsAng = Vector(-10, 0, 0)
SWEP.InspectPos = Vector(0, 0, 1.5)
SWEP.InspectAng = Vector(10, 0, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.Ispackapunched = false
SWEP.NZHudIcon = Material("vgui/icon/hud_zom_bouncing_betty.png", "unlitgeneric smooth")
SWEP.NZHudIcon_cod5 = Material("vgui/icon/hud_bouncing_betty.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t5 = Material("vgui/icon/hud_zom_bouncing_betty.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/hud_zom_bouncing_betty_t7.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/hud_bouncing_betty_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/hud_zom_bouncing_betty_t7.png", "unlitgeneric smooth")

SWEP.NZTacticalRegen = true
SWEP.NZTacticalRegenAmount = 2

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

function SWEP:NZSpecialHolster()
	self.nzThrowTime = nil
	self.nzHolsterTime = nil
	return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}
SWEP.SequenceLengthOverride = {
	[ACT_VM_DRAW] = 15/35
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_PULLPIN] = {
{ ["time"] = 15 / 35, ["type"] = "sound", ["value"] = Sound("TFA_WAW_BBETTY.Pin") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 1
SWEP.ProceduralHolsterTime = 0.015

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:Equip(ply, ...)
	if nzombies then
		timer.Simple(engine.TickInterval(), function()
			if not IsValid(ply) then return end
			ply:SetAmmo(2, GetNZAmmoID("specialgrenade"))
		end)
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:PreSpawnProjectile(ent)
	local ang = self:GetAimVector():Angle()
	ent:SetAngles(Angle(0, ang[2], 0))
	ent.DesiredAng = ent:GetAngles()
end

function SWEP:PostSpawnProjectile(ent)
	local phys = ent:GetPhysicsObject()
	ent:SetVelocity(vector_up*-self:GetStatL("Velocity"))
	if IsValid(phys) then
		phys:SetVelocity(vector_up*-self:GetStatL("Velocity"))
	end
	if ent.DesiredAng then
		ent:SetAngles(ent.DesiredAng)
	end
end
