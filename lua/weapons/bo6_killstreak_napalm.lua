AddCSLuaFile()

SWEP.NZSpecialCategory = "killstreak"
SWEP.Type_Displayed = "Killstreak"
SWEP.Base 			= "tfa_gun_base"
SWEP.Category = "nZombies Killstreaks"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.UseHands = true
SWEP.Type_Displayed = "Misc"
SWEP.Author = "Hari"
SWEP.Slot = 0
SWEP.PrintName = "Napalm Strike"
SWEP.DrawCrosshair = false
SWEP.DrawCrosshairIronSights = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.DrawAmmo = false
SWEP.CanChangeWeapon = true

--[Model]--
SWEP.ViewModel = "models/nzr/2024/radio/vm_t5_radio.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel = "models/nzr/2024/radio/world/wm_t5_radio.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.VMPos = Vector(3, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = false

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 1,
        Right = 7,
        Forward = -4,
        },
        Ang = {
		Up = 0,
        Right = 90,
        Forward = -170
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = ""
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 100
SWEP.Primary.Damage = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.DisableChambering = true
SWEP.SelectiveFire = false
SWEP.FiresUnderwater = false
SWEP.NZPreventBox = true

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = 0.0

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(5, -3, 0)
SWEP.InspectAng = Vector(15, 20, 5)
SWEP.MoveSpeed = 1
SWEP.SafetyPos = Vector(0, 0, 0)
SWEP.SafetyAng = Vector(0, 0, 0)
SWEP.TracerCount = 0

--[Tables]--
SWEP.SequenceRateOverride = {
}

SWEP.SequenceLengthOverride = {
}

SWEP.SprintAnimation = {
}

SWEP.EventTable = {
    [ACT_VM_HOLSTER] = {
        { ["time"] = 14 / 30, ["type"] = "sound", ["value"] = Sound("Latte_Radio.Off") },
    },
    [ACT_VM_DRAW] = {
        { ["time"] = 0, ["type"] = "sound", ["value"] = Sound("TFA_BO.FOLEY.EQUIP") },
        { ["time"] = 17 / 30, ["type"] = "sound", ["value"] = Sound("Latte_Radio.On") },
    },
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0

SWEP.WorldModelBoneMods = {
}

DEFINE_BASECLASS(SWEP.Base)

local sp = game.SinglePlayer()

-- Disable functions that should not be used
function SWEP:IsSpecial()
	return true
end

function SWEP:PrimaryAttack()
	if self.CanChangeWeapon then
		self:SetNextPrimaryFire(CurTime()+1)

		local ply = self:GetOwner()
		if !IsValid(ply) or !ply:Alive() or !ply:GetNotDowned() then return end
		local pos = ply:GetEyeTrace().HitPos

		local tr = util.TraceLine({
			start = pos+Vector(0,0,4),
			endpos = pos+Vector(0,0,99999),
			filter = ply
		})
		if !tr.HitSky then
			if SERVER then
				ply:EmitSound("ambient/levels/prison/radio_random5.wav", 60)
				ply:ChatPrint("Napalm Strike cant be called under roof!")
			end
			return
		end

		self.CanChangeWeapon = false 
		self:SendViewModelAnim(ACT_VM_HOLSTER)

		if CLIENT then return end

		ply:EmitSound("ambient/levels/prison/radio_random3.wav", 60)
		timer.Simple(1, function()
			if !IsValid(self) or !IsValid(ply) then return end

			local wep = ""
			if IsValid(ply:GetPreviousWeapon()) then
				wep = ply:GetPreviousWeapon():GetClass()
			end
			ply:SetActiveWeapon(nil)
			self:Remove()
			timer.Simple(0, function()
				ply:SetUsingSpecialWeapon(false)
				ply:SelectWeapon(wep)
			end)

			self:Remove()
			local ent = ents.Create("bo6_napalm_marker")
			ent:SetPos(pos)
			ent.Player = ply
			ent:SetNoDraw(true)
			ent:Spawn()
		end)
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:CycleFireMode()
end

function SWEP:CycleSafety()
end

function SWEP:ToggleInspect()
end

if CLIENT then
	local arrowIcon = Material("bo6/hud/arrows.png")
	local targetIcon = Material("bo6/hud/target.png")
	hook.Add("PostDrawTranslucentRenderables", "nzrNapalmMarker", function()
		local ply = LocalPlayer()
		if ply:Alive() and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "bo6_killstreak_napalm" and ply:GetActiveWeapon().CanChangeWeapon then
			local color_arrow = Color(40,240,40)
			local color_target = Color(20,180,20)
			local pos = ply:GetEyeTrace().HitPos
			local tr = util.TraceLine({
				start = pos+Vector(0,0,4),
				endpos = pos+Vector(0,0,99999),
				filter = ply
			})
			if !tr.HitSky then
				color_arrow = Color(240,40,40)
				color_target = Color(180,20,20)
			end
			color_target.a = 20+math.abs(180*math.sin(CurTime()))
			color_arrow.a = 20+math.abs(180*math.sin(CurTime()))
			
			local angle = EyeAngles()
			angle:RotateAroundAxis( angle:Up(), -90 )
			angle:RotateAroundAxis( angle:Forward(), 90 )
			cam.Start3D2D(pos+Vector(0,0,48+(math.sin(CurTime())*16)), angle, 1)
				surface.SetMaterial(arrowIcon)
				surface.SetDrawColor(color_arrow)
				surface.DrawTexturedRect(-16, -16, 32, 32)
			cam.End3D2D()
			cam.Start3D2D(pos+Vector(0,0,4), Angle(0,0,0), 1+(math.sin(CurTime())*0.5))
				surface.SetMaterial(targetIcon)
				surface.SetDrawColor(color_target)
				local size = 64
				surface.DrawTexturedRect(-size/2, -size/2, size, size)
			cam.End3D2D()
		end 
	end)
end