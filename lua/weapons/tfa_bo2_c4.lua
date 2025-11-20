local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "Other"
//SWEP.SubCategory = "Call of Duty"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = nzombies and "#tfa.weapontype.tacgrenade" or "Grenade"
SWEP.Author = "FlamingFox"
SWEP.Slot = 4
SWEP.PrintName = nzombies and "C4 | BO2" or "C4"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true
SWEP.WWCrosshairEnabled = true

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo2/c4/c_c4.mdl"
SWEP.ViewModelFOV = 70
SWEP.WorldModel			= "models/weapons/tfa_bo2/c4/w_c4.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true
SWEP.ShowWorldModel = false

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 4,
        Right = 6,
        Forward = 3,
        },
        Ang = {
		Up = 180,
        Right = 190,
        Forward = -10
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Ammo = "tripmine"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 120
SWEP.Primary.Damage = nzombies and 400 or 100
SWEP.Primary.NumShots = 1
SWEP.Primary.Knockback = 0
SWEP.Primary.AmmoConsumption = nzombies and 0 or 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 2
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
SWEP.Primary.Round = nzombies and "nz_bo1_tac_c4" or "bo1_tac_c4"
SWEP.Primary.Projectile = nzombies and "nz_bo1_tac_c4" or "bo1_tac_c4"
SWEP.Primary.ProjectileModel = "models/weapons/tfa_bo2/c4/w_c4_projectile.mdl"
SWEP.Velocity = 550
SWEP.Underhanded = false
SWEP.AllowSprintAttack = false
SWEP.AllowUnderhanded = false
SWEP.DisableIdleAnimations = false

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(4, -2, 1)
SWEP.InspectAng = Vector(0, 25, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.Ispackapunched = false
SWEP.NZWonderWeapon = false
SWEP.NZPaPName = "Puncake"
SWEP.NZHudIcon = Material("vgui/icon/hud_t6_c4.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t5 = Material("vgui/icon/hud_t6_c4.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t6 = Material("vgui/icon/hud_t6_c4.png", "unlitgeneric smooth")

SWEP.NZSpecialCategory = "trap"
SWEP.NZSpecialWeaponData = {MaxAmmo = 3, AmmoType = "tripmine"}

SWEP.NZTrapSwitchEmpty = true
SWEP.NZTrapRegen = true
SWEP.NZTrapRegenAmount = 3
SWEP.NZRegenTakeClip = true

SWEP.NZSpecialPAP = true
SWEP.NZDisplayDeploy = "nz_bo2_c4_detonate"
SWEP.IsC4 = true

SWEP.SpeedColaFactor = 1
SWEP.SpeedColaActivities = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_RELOAD_SILENCED] = true,
}

SWEP.Primary.DamagePAP = 666

function SWEP:OnPaP()
self.Ispackapunched = true
self.nzPaPCamo = "models/weapons/tfa_bo1/c4/hyena_scroll2.vmt"
self.WElements = {
	["detonator"] = { type = "Model", model = "models/weapons/tfa_bo2/c4/w_c4_detonator.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.5, 2, 0.5), angle = Angle(180, -20, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = self.nzPaPCamo, skin = 0, bonemerge = false, active = true, bodygroup = {} },
	["c4"] = { type = "Model", model = "models/weapons/tfa_bo2/c4/w_c4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 5, 1), angle = Angle(180, -50, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = self.nzPaPCamo, skin = 0, bonemerge = false, active = true, bodygroup = {} },
}

self.TPaPOverrideMat = {[0] = true}
self.Primary_TFA.Damage = 666
self.Primary_TFA.DefaultClip = 6
self.NZTrapRegenAmount = 6
self.NZSpecialWeaponData.MaxAmmo = 6
self:ClearStatCache()
return true
end

function SWEP:NZSpecialHolster()
	self.nzThrowTime = nil
	self.nzHolsterTime = nil
	return true
end

--[Tables]--
SWEP.SequenceRateOverride = {
}
SWEP.SequenceLengthOverride = {
	[ACT_VM_THROW] = 20 / 40
}

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 0, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 5 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_cloth.med") },
{ ["time"] = 10 / 40, ["type"] = "sound", ["value"] = Sound("weapon_bo3_gear.rattle") },
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 5 / 45, ["type"] = "sound", ["value"] = Sound("TFA_BO1_C4.Trigger") },
},
}

--[Shit]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_LUA -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
SWEP.SprintBobMult = 0
SWEP.ProceduralHolsterTime = 0.015

SWEP.WElements = {
	["detonator"] = { type = "Model", model = "models/weapons/tfa_bo2/c4/w_c4_detonator.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(3.5, 2, 0.5), angle = Angle(180, -20, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = true, bodygroup = {} },
	["c4"] = { type = "Model", model = "models/weapons/tfa_bo2/c4/w_c4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6, 5, 1), angle = Angle(180, -50, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = true, bodygroup = {} },
}

SWEP.Attachments = {
[1] = {atts = {"bo3_packapunch"}, order = 1, hidden = engine.ActiveGamemode() == "nzombies"},
}

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local sp = game.SinglePlayer()

SWEP.Type = "Grenade"
SWEP.MuzzleFlashEffect = ""
SWEP.Secondary.IronSightsEnabled = false
SWEP.Delay_Underhand = 0.3

SWEP.IronSightsPosition = Vector(5,0,0)
SWEP.IronSightsAngle = Vector(0,0,0)
SWEP.Callback = {}

SWEP.C4KillEffect = "bo2_c4_pap_electrocute"

function SWEP:PreDrawViewModel(vm, ...)
	BaseClass.PreDrawViewModel(self, vm, ...)

	if self.Ispackapunched then
		vm:SetSubMaterial(0, "models/weapons/tfa_bo1/c4/hyena_scroll2.vmt")
		vm:SetSubMaterial(1, "models/weapons/tfa_bo1/c4/hyena_scroll2.vmt")
	else
		vm:SetSubMaterial(0, nil)
		vm:SetSubMaterial(1, nil)
	end
end

function SWEP:Initialize()
	self.ProjectileEntity = self.ProjectileEntity or self.Primary.Round
	self.ProjectileVelocity = self.Velocity or 550
	self.ProjectileModel = nil

	self:SetNW2Bool("Underhanded", false)

	BaseClass.Initialize(self)
end

function SWEP:Deploy()
	self:Reload()
	self:SetNW2Bool("Underhanded", false)

	self.oldang = self:GetOwner():EyeAngles()
	self.anga = Angle()
	self.angb = Angle()
	self.angc = Angle()

	self:CleanParticles()

	return BaseClass.Deploy(self)
end

function SWEP:ChoosePullAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChoosePullAnim then
		self.Callback.ChoosePullAnim(self)
	end

	if self:GetOwner():IsPlayer() then
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
	end

	self:SendViewModelAnim(ACT_VM_PULLPIN)

	if sp then
		self:CallOnClient("AnimForce", ACT_VM_PULLPIN)
	end

	return true, ACT_VM_PULLPIN
end

function SWEP:ChooseShootAnim()
	if not self:OwnerIsValid() then return end

	if self.Callback.ChooseShootAnim then
		self.Callback.ChooseShootAnim(self)
	end

	if self:GetOwner():IsPlayer() then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end

	local tanim = self:GetNW2Bool("Underhanded", false) and self.SequenceEnabled[ACT_VM_RELEASE] and ACT_VM_RELEASE or ACT_VM_THROW
	self:SendViewModelAnim(tanim)

	if sp then
		self:CallOnClient("AnimForce", tanim)
	end

	return true, tanim
end

function SWEP:ThrowStart()
	if self:Clip1() <= 0 then return end

	local success, tanim, animType = self:ChooseShootAnim()

	local delay = self:GetNW2Bool("Underhanded", false) and self.Delay_Underhand or self.Delay
	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW, delay)

	if success then
		self.LastNadeAnim = tanim
		self.LastNadeAnimType = animType
		self.LastNadeDelay = delay
	end
end

function SWEP:Throw()
	if self:Clip1() <= 0 then return end
	self.ProjectileVelocity = (self:GetNW2Bool("Underhanded", false) and self.Velocity_Underhand) or ((self.Velocity or 550) / 1.5)

	self:TakePrimaryAmmo(1)
	self:ShootBulletInformation()

	if self.LastNadeAnim then
		local len = self:GetActivityLength(self.LastNadeAnim, true, self.LastNadeAnimType)
		self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_THROW_WAIT, len - (self.LastNadeDelay or len))
	end
	self:EmitSound("TFA_BO2_GRENADE.Throw")
end

function SWEP:Think2(...)
	if not self:OwnerIsValid() then return end

	local stat = self:GetStatus()

	-- This is the best place to do this since Think2 is called inside FinishMove
	self:SetNW2Bool("Underhanded", self.AllowUnderhanded and self:KeyDown(IN_ATTACK2))

	if nzombies and SERVER then
		local ply = self:GetOwner()
		if IsValid(ply) and ply:IsPlayer() and ply:GetAmmoCount(self:GetPrimaryAmmoType()) + self:Clip1() > self.NZSpecialWeaponData.MaxAmmo then
			ply:SetAmmo(self.NZSpecialWeaponData.MaxAmmo - self:Clip1(), self:GetPrimaryAmmoType())
		end
	end

	local statusend = CurTime() >= self:GetStatusEnd()

	if stat == TFA.Enum.STATUS_GRENADE_PULL and statusend then
		stat = TFA.Enum.STATUS_GRENADE_READY
		self:SetStatus(stat, math.huge)
	end

	if stat == TFA.Enum.STATUS_GRENADE_READY and (self:GetOwner():IsNPC() or not self:KeyDown(IN_ATTACK2) and not self:KeyDown(IN_ATTACK)) then
		self:ThrowStart()
	end

	if stat == TFA.Enum.STATUS_GRENADE_THROW and statusend then
		self:Throw()
	end

	if SERVER and stat == TFA.Enum.STATUS_C4_DETONATE then
		self:DetonateC4()
	end

	if stat == TFA.Enum.STATUS_IDLE and self:Clip1() <= 0 and self:Ammo1() > 0 and self:GetNextPrimaryFire() <= CurTime() and self.Primary.ClipSize > 0 then
		self:Reload()
	end

	return BaseClass.Think2(self, ...)
end

function SWEP:DetonateC4()
	if not SERVER then return end

	local ply = self:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end

	if ply.ActiveC4s then
		for k, v in pairs(ply.ActiveC4s) do
			timer.Simple(.05 * k, function()
				if IsValid(v) then
					v:Explode()
				end
			end)
		end
	end
end

function SWEP:PrimaryAttack()
	if self:Clip1() <= 0 or not self:OwnerIsValid() or not self:CanPrimaryAttack() then return end

	local _, tanim = self:ChoosePullAnim()

	self:ScheduleStatus(TFA.Enum.STATUS_GRENADE_PULL, self:GetActivityLength(tanim))
	self:SetNW2Bool("Underhanded", false)
end

function SWEP:SecondaryAttack()
	if not self:CanSecondaryAttack() then return end
	
	if self:GetStatus() ~= TFA.Enum.STATUS_C4_DETONATE then
		self:SendViewModelAnim(ACT_VM_PRIMARYATTACK)
		self:ScheduleStatus(TFA.Enum.STATUS_C4_DETONATE, self:GetActivityLength())
		self:SetNextPrimaryFire(self:GetStatusEnd())
		return
	end
end

function SWEP:Reload()
	if self:Clip1() <= 0 and self:Ammo1() > 0 then
		self:TakePrimaryAmmo(1, true)
		self:SetClip1(1)
	end
end

function SWEP:ChooseIdleAnim(...)
	if self:GetStatus() == TFA.Enum.STATUS_GRENADE_READY then return end
	return BaseClass.ChooseIdleAnim(self, ...)
end

function SWEP:CycleSafety()
end

function SWEP:CanSecondaryAttack()
	local self2 = self:GetTable()
	local l_CT = CurTime
	
	stat = self:GetStatus()
	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self2.GetStatL(self, "Primary.FiresUnderwater") == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextPrimaryFire(l_CT() + 0.5)
		self:EmitSound(self:GetStatL("Primary.Sound_Blocked"))
		return false
	end

	if l_CT() < self:GetNextPrimaryFire() then return false end
	return true
end

function SWEP:Equip(ply, ...)
	if nzombies then
		if (nzEnemies and !nzEnemies.Updated) or nzRound:InState(ROUND_CREATE) then
			timer.Simple(engine.TickInterval()*2, function()
				if not IsValid(ply) then return end
				if ply.LastEquipmentClip1 then
					self:SetClip1(ply.LastEquipmentClip1)
					ply.LastEquipmentClip1 = nil
				end
				ply:SetAmmo(ply.LastEquipmentAmmo or self.NZSpecialWeaponData.MaxAmmo - self:Clip1(), self:GetPrimaryAmmoType())
				ply.LastEquipmentAmmo = nil
			end)
		end

		if IsValid(ply) and ply:IsPlayer() and IsFirstTimePredicted() and (not ply._TFA_LastJamMessage or ply._TFA_LastJamMessage < RealTime()) then
			ply:PrintMessage(HUD_PRINTCENTER, "Double tap USE button to detonate placed C4 at anytime")
			ply._TFA_LastJamMessage = RealTime() + 1
		end
	end

	return BaseClass.Equip(self, ply, ...)
end

function SWEP:PreSpawnProjectile(ent)
	if not self:GetOwner():IsPlayer() then
		ent.Cooked = CurTime() + 1.5
	end

	ent:SetUpgraded(self.Ispackapunched)

	if self.Ispackapunched then
		ent.nzPaPCamo = "models/weapons/tfa_bo1/c4/hyena_scroll2.vmt"

		ent.ExplodeSound = "TFA_BO2_C4.Expl"
		ent.FluxSound = "TFA_BO2_C4.Flux"
		ent.RampupSound = "TFA_BO2_C4.RampUp"
		ent.KillSound = "TFA_BO3_WAFFE.Zap"

		ent.KillEffect = self.C4KillEffect
		ent.ExplosionEffect = "bo2_c4_pap_explode"
		ent.GroundEffect = "bo2_c4_pap_ground"
	end
end

function SWEP:PostSpawnProjectile(ent)
	local angvel = Vector(0,math.random(-2000,-1500),math.random(-1500,-2000)) //The positive z coordinate emulates the spin from a right-handed overhand throw
	angvel:Rotate(-1*ent:EyeAngles())
	angvel:Rotate(Angle(0,self.Owner:EyeAngles().y,0))

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:AddAngleVelocity(angvel)
	end
end

local crosshair_c4 = Material("vgui/overlay/c4_reticle.png", "smooth unlitgeneric")
local CMIX_MULT = 1
local c1t = {}
local c2t = {}

local function ColorMix(c1, c2, fac, t)
	c1 = c1 or color_white
	c2 = c2 or color_white
	c1t.r = c1.r
	c1t.g = c1.g
	c1t.b = c1.b
	c1t.a = c1.a
	c2t.r = c2.r
	c2t.g = c2.g
	c2t.b = c2.b
	c2t.a = c2.a

	for k, v in pairs(c1t) do
		if t == CMIX_MULT then
			c1t[k] = Lerp(fac, v, (c1t[k] / 255 * c2t[k] / 255) * 255)
		else
			c1t[k] = Lerp(fac, v, c2t[k])
		end
	end

	return Color(c1t.r, c1t.g, c1t.b, c1t.a)
end

local crosshair_cvar = GetConVar("cl_tfa_bo3ww_crosshair")
local sv_tfa_fixed_crosshair = GetConVar("sv_tfa_fixed_crosshair")
local crossr_cvar = GetConVar("cl_tfa_hud_crosshair_color_r")
local crossg_cvar = GetConVar("cl_tfa_hud_crosshair_color_g")
local crossb_cvar = GetConVar("cl_tfa_hud_crosshair_color_b")
local crosscol = Color(255, 255, 255, 255)

local color_black_100 = Color(0, 0, 0, 100)
local color_black_180 = Color(0, 0, 0, 180)
local nzmodernhuds = {
	["Black Ops 3"] = true,
	["Black Ops 4"] = true,
	["Shadows of Evil"] = true,
	["Origins (HD)"] = true,
}

function SWEP:DrawHUDBackground()
	if not crosshair_cvar:GetBool() then return end
	local self2 = self:GetTable()
	local x, y
	
	local ply = LocalPlayer()
	if not ply:IsValid() or self:GetOwner() ~= ply then return false end

	if not ply.interpposx then
		ply.interpposx = ScrW() / 2
	end

	if not ply.interpposy then
		ply.interpposy = ScrH() / 2
	end

	local tr = {}
	tr.start = ply:GetShootPos()
	tr.endpos = tr.start + ply:GetAimVector() * 0x7FFF
	tr.filter = ply
	tr.mask = MASK_NPCSOLID
	local traceres = util.TraceLine(tr)
	local targent = traceres.Entity

	if self:GetOwner():ShouldDrawLocalPlayer() and not ply:GetNW2Bool("ThirtOTS", false) then
		local coords = traceres.HitPos:ToScreen()
		coords.x = math.Clamp(coords.x, 0, ScrW())
		coords.y = math.Clamp(coords.y, 0, ScrH())
		ply.interpposx = math.Approach(ply.interpposx, coords.x, (ply.interpposx - coords.x) * RealFrameTime() * 7.5)
		ply.interpposy = math.Approach(ply.interpposy, coords.y, (ply.interpposy - coords.y) * RealFrameTime() * 7.5)
		x, y = ply.interpposx, ply.interpposy
		-- Center of screen
	elseif sv_tfa_fixed_crosshair:GetBool() then
		x, y = ScrW() / 2, ScrH() / 2
	else
		tr.endpos = tr.start + self:GetAimAngle():Forward() * 0x7FFF
		local pos = util.TraceLine(tr).HitPos:ToScreen()
		x, y = pos.x, pos.y
	end

	local stat = self2.GetStatus(self)
	self2.clrelp = self2.clrelp or 0
	self2.clrelp = math.Approach(
		self2.clrelp,
		TFA.Enum.ReloadStatus[stat] and 0 or 1,
		((TFA.Enum.ReloadStatus[stat] and 0 or 1) - self2.clrelp) * RealFrameTime() * 7)

	local crossa = 255 * math.pow(math.min(1 - (((self2.IronSightsProgressUnpredicted2 or self:GetIronSightsProgress()) and
		not self2.GetStatL(self, "DrawCrosshairIronSights")) and (self2.IronSightsProgressUnpredicted2 or self:GetIronSightsProgress()) or 0),
		1 - self:GetSprintProgress(),
		1 - self:GetInspectingProgress(),
		self2.clrelp),
	2)

	teamcol = self2.GetTeamColor(self, targent)
	crossr = crossr_cvar:GetFloat()
	crossg = crossg_cvar:GetFloat()
	crossb = crossb_cvar:GetFloat()
	crosscol.r = crossr
	crosscol.g = crossg
	crosscol.b = crossb
	crosscol.a = crossa
	crosscol = ColorMix(crosscol, teamcol, 1, CMIX_MULT)
	crossr = crosscol.r
	crossg = crosscol.g
	crossb = crosscol.b
	crossa = crosscol.a

	surface.SetDrawColor(crossr, crossg, crossb, crossa)
	surface.SetMaterial(crosshair_c4)

	if ply:ShouldDrawLocalPlayer() or ply:GetNW2Bool("ThirtOTS", false) then
		surface.DrawTexturedRect(x - 24, y  - 24, 48, 48)
	else
		surface.DrawTexturedRect(ScrW() / 2 - 24, ScrH() / 2 - 24, 48, 48)
	end

	/*local tr = ply:GetEyeTrace()
	local ent = tr.Entity

	local w, h = ScrW(), ScrH()
	local scale = ((w/1920)+1)/2
	local lowres = scale < 0.96
	local font = "DermaLarge"

	if nzombies then
		font = "nz.small."..GetFontType(nzMapping.Settings.mainfont)
		if lowres then
			font = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))
		end
	end

	if IsValid(ent) and ent:GetClass() == "perk_machine" and ent:GetPerkID() == "pap" and ply:GetShootPos():DistToSqr(tr.HitPos) < 10000 then
		local usekey = "" .. string.upper(input.LookupBinding( "+use", true )) .. " - "

		local text = ""
		if self:HasNZModifier("pap") then
			if self:CanRerollPaP() then
				text = nzPowerUps:IsPowerupActive("bonfiresale") and ("Press " .. usekey .. "Repack [Cost: 500]") or ("Press " .. usekey .. "Repack [Cost: 2,500]")
			else
				text = "This weapon cannot be upgraded any further"
			end
		else
			text = nzPowerUps:IsPowerupActive("bonfiresale") and ("Press " .. usekey .. "Pack-a-Punch Weapon [Cost: 1,000]") or ("Press " .. usekey .. "Pack-a-Punch Weapon [Cost: 5,000]")
		end
		if !ent:IsOn() then
			text = "You must turn on the electricity first!"
		elseif ent:GetBeingUsed() then
			text = "Currently in Use"
		elseif ent:BrutusLocked() then
			text = "Press " .. usekey .. "Unlock [Cost: 2000]"
		end

		if (nzDisplay and nzDisplay.modernHUDs) and nzDisplay.modernHUDs[nzMapping.Settings.hudtype] or nzmodernhuds[nzMapping.Settings.hudtype] then
			surface.SetFont(font)
			surface.SetDrawColor(color_black_100)

			local wd, ht = surface.GetTextSize(text)
			surface.DrawRect(w/2 - ((wd/2)+12), h - 280*scale - (ht/2), wd + 24, ht)
		end

		draw.SimpleTextOutlined(text, font, w/2, h - 280*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_100)
	end*/
end

SWEP.CrosshairConeRecoilOverride = .05

TFA.FillMissingMetaValues(SWEP)
