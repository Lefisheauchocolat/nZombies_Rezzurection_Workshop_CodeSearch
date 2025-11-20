local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_nade_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = nzombies and "#tfa.weapontype.tacgrenade" or "Grenade"
SWEP.Author = "FlamingFox"
SWEP.Slot = 5
SWEP.PrintName = "Q.E.D."
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/qed/c_qed.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/qed/w_qed.mdl"
SWEP.HoldType = "grenade"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, -6, -1.5)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -0.5,
        Right = 2.2,
        Forward = 3,
        },
        Ang = {
		Up = 90,
        Right = 0,
        Forward = 80
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Ammo = "Grenade"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = 115
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.AmmoConsumption = nzombies and 0 or 1
SWEP.Primary.ClipSize = nzombies and 999 or 1
SWEP.Primary.DefaultClip = nzombies and 999 or 1
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
SWEP.Primary.Round = nzombies and "nz_bo3_tac_qed" or "bo3_tac_qed"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_bo3/qed/w_qed.mdl"
SWEP.Velocity = 750
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
SWEP.InspectPos = Vector(0, 0, 1.5)
SWEP.InspectAng = Vector(10, 0, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.Ispackapunched = false
SWEP.NZUniqueWeapon = true
SWEP.NZHudIcon = Material("vgui/icon/i_pv_hud_wpn_qed.png", "unlitgeneric smooth")
SWEP.NZHudIcon_cod4 = Material("vgui/icon/qed_ammo_counter.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t5 = Material("vgui/icon/i_pv_hud_wpn_qed.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/t7_zm_derriese_hud_quantum.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/t7_zm_tomb_hud_quantum.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/t7_zm_tomb_hud_quantum.png", "unlitgeneric smooth")

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
}

SWEP.RunSightsPos = Vector(0, 1, 2)
SWEP.RunSightsAng = Vector(-20, 0, 5)

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 5 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_QED.Twist") },
{ ["time"] = 10 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_QED.Plunge") },
{ ["time"] = 10 / 35, ["type"] = "lua", value = function(wep, vm)
	if SERVER then
		local ply = wep:GetOwner()
		local fx = EffectData()
		fx:SetEntity(wep)
		fx:SetAttachment(1)

		local filter = RecipientFilter()
		filter:AddPVS(ply:GetShootPos())
		if IsValid(ply) and wep:IsFirstPerson() then
			filter:RemovePlayer(ply)
		end

		if filter:GetCount() > 0 then
			util.Effect("tfa_bo3_qed_3p", fx, true, filter)
		end
	end
end},
},
[ACT_VM_THROW] = {
{ ["time"] = 1 / 35, ["type"] = "sound", ["value"] = Sound("TFA_BO3_GRENADE.Throw") },
{ ["time"] = 1 / 35, ["type"] = "lua", value = function(wep, vm) wep:CleanParticles() end},
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

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

function SWEP:Equip(ply, ...)
	if nzombies then
		ply:SetAmmo(3, GetNZAmmoID("specialgrenade"))
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:PreSpawnProjectile(ent)
	local ang = self:GetAimVector():Angle()
	ent:SetAngles(Angle(0, ang[2], 0))
end
