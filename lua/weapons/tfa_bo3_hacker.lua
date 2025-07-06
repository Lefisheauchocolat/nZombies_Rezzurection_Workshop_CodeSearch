local nzombies = engine.ActiveGamemode() == "nzombies"

SWEP.Base = "tfa_gun_base"
SWEP.Category = "TFA Wonder Weapons"
SWEP.SubCategory = "Black Ops 3"
SWEP.Spawnable = TFA_BASE_VERSION and TFA_BASE_VERSION >= 4.76
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Type_Displayed = "#tfa.weapontype.wonderweapon"
SWEP.Purpose = nzombies and nil or "Hack players to heal them, Hack NPCs to convert them into allies, Hack doors to unlock and open them"
SWEP.Author = "FlamingFox"
SWEP.Slot = 5
SWEP.PrintName = "Hacker Device"
SWEP.DrawCrosshair = true
SWEP.DrawCrosshairIS = false
SWEP.AutoSwitchTo = false

--[Model]--
SWEP.ViewModel			= "models/weapons/tfa_bo3/hacker/c_hacker.mdl"
SWEP.ViewModelFOV = 65
SWEP.WorldModel			= "models/weapons/tfa_bo3/hacker/w_hacker.mdl"
SWEP.HoldType = "slam"
SWEP.CameraAttachmentOffsets = {}
SWEP.CameraAttachmentScale = 1
SWEP.MuzzleAttachment = "1"
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0, 0, 0)
SWEP.VMPos_Additive = true

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = 3,
        Right = 3,
        Forward = 4,
        },
        Ang = {
		Up = -60,
        Right = 180,
        Forward = -5
        },
		Scale = 1
}

--[Gun Related]--
SWEP.Primary.Sound = nil
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = false
SWEP.Primary.RPM = 80
SWEP.Primary.RPM_Semi = nil
SWEP.Primary.RPM_Burst = nil
SWEP.Primary.Damage = 115
SWEP.Primary.Knockback = 0
SWEP.Primary.NumShots = 1
SWEP.Primary.AmmoConsumption = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.DryFireDelay = nil
SWEP.MuzzleFlashEnabled = false
SWEP.DisableChambering = true
SWEP.FiresUnderwater = false

--[Firemode]--
SWEP.Primary.BurstDelay = nil
SWEP.DisableBurstFire = true
SWEP.SelectiveFire = false
SWEP.OnlyBurstFire = false
SWEP.BurstFireCount = nil

--[LowAmmo]--
SWEP.FireSoundAffectedByClipSize = false
SWEP.LowAmmoSoundThreshold = 0.33 --0.33
SWEP.LowAmmoSound = nil
SWEP.LastAmmoSound = nil

--[Range]--
SWEP.Primary.Range = -1
SWEP.Primary.RangeFalloff = -1
SWEP.Primary.DisplayFalloff = false
SWEP.DisplayFalloff = false

--[Spread Related]--
SWEP.Primary.Spread		  = .00
SWEP.Primary.IronAccuracy = .00
SWEP.IronRecoilMultiplier = 0.0
SWEP.CrouchAccuracyMultiplier = 0.0

SWEP.Primary.KickUp				= 0.0
SWEP.Primary.KickDown			= 0.0
SWEP.Primary.KickHorizontal		= 0.0
SWEP.Primary.StaticRecoilFactor	= 0.0

SWEP.Primary.SpreadMultiplierMax = 0
SWEP.Primary.SpreadIncrement = 0
SWEP.Primary.SpreadRecovery = 0

--[Iron Sights]--
SWEP.data = {}
SWEP.data.ironsights = 0

--[Shells]--
SWEP.LuaShellEject = false
SWEP.EjectionSmokeEnabled = false

--[Misc]--
SWEP.InspectPos = Vector(1, -3, -2)
SWEP.InspectAng = Vector(15, -15, 0)
SWEP.MoveSpeed = 1
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
SWEP.SafetyPos = Vector(1, -2, -0.5)
SWEP.SafetyAng = Vector(-20, 35, -25)

--[NZombies]--
SWEP.NZPaPName = "Golden Hacker Device"
SWEP.NZWonderWeapon = true
SWEP.NZSpecialCategory = "shield"
SWEP.NZSpecialWeaponData = {MaxAmmo = 0, AmmoType = "none"}
SWEP.NZSpecialShowHUD = true
SWEP.NZHudIcon = Material("vgui/icon/uie_t5hud_icon_hacker.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7 = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_hack_active.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7zod = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_hack_active_bw.png", "unlitgeneric smooth")
SWEP.NZHudIcon_t7tomb = Material("vgui/icon/uie_t7_zm_hud_ammo_icon_hack_active_bw.png", "unlitgeneric smooth")
SWEP.Ispackapunched = false

SWEP.SpeedColaFactor = 1
SWEP.DTapSpeed = 1
SWEP.DTap2Speed = 1
SWEP.SpeedColaActivities = {}
SWEP.DTapActivities = {}

function SWEP:NZSpecialHolster(wep)
	self:StopSound("TFA_BO3_HACKER.Loop")
	return true
end

function SWEP:IsSpecial()
	return true
end

function SWEP:OnPaP()
self.Ispackapunched = true
self.HackerRange = 180
self.HackerRangeSqr = 32400
self.NZHudIcon = Material("vgui/icon/uie_t5hud_icon_hacker_gold.png", "unlitgeneric smooth")

self.Skin = 1
self:SetSkin(1)
self.PrintName = "Golden Hacker Device"
self:SetNW2String("PrintName", "Golden Hacker Device")

local ply = self:GetOwner()
if IsValid(ply) and !ply.HackerDevicePAP then
	ply.HackerDevicePAP = true
end

self:ClearStatCache()
return true
end

--[Tables]--
SWEP.StatusLengthOverride = {
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

SWEP.EventTable = {
[ACT_VM_DRAW] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HACKER.Open") },
{ ["time"] = 5 / 30, ["type"] = "lua", value = function(self) self.Skin = self.Ispackapunched and 1 or 0 end, client = true, server = true},
},
[ACT_VM_HOLSTER] = {
{ ["time"] = 1 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HACKER.Close") },
},
[ACT_VM_PRIMARYATTACK] = {
{ ["time"] = 5 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HACKER.Loop") },
{ ["time"] = 40 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HACKER.PenOut") },
},
[ACT_VM_PULLBACK] = {
{ ["time"] = 15 / 30, ["type"] = "sound", ["value"] = Sound("TFA_BO3_HACKER.PenIn") },
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

SWEP.BO3CanHack = true
SWEP.HackerRange = 80
SWEP.HackerRangeSqr = 6400
SWEP.equipment_got_in_round = 0

--[Coding]--
DEFINE_BASECLASS( SWEP.Base )

local passive = {
	"npc_seagull", "npc_crow", "npc_piegon",  "monster_cockroach",
	"npc_dog", "npc_gman", "npc_antlion_grub",
	-- "monster_scientist", -- Can't attack, but does run away
	"monster_nihilanth", -- Doesn't attack from spawn menu, so not allowing to change his dispositions
	"npc_turret_floor" -- Uses a special input for this sort of stuff
}

local friendly = {
	"npc_monk", "npc_alyx", "npc_barney", "npc_citizen",
	"npc_turret_floor", "npc_dog", "npc_vortigaunt",
	"npc_kleiner", "npc_eli", "npc_magnusson", "npc_breen", "npc_mossman", -- They can use SHOTGUNS!
	"npc_fisherman", -- He sorta can use shotgun
	"monster_barney", "monster_scientist", "player"
}

local hostile = {
	"npc_turret_ceiling", "npc_combine_s", "npc_combinegunship", "npc_combinedropship",
	"npc_cscanner", "npc_clawscanner", "npc_turret_floor", "npc_helicopter", "npc_hunter", "npc_manhack",
	"npc_stalker", "npc_rollermine", "npc_strider", "npc_metropolice", "npc_turret_ground",
	"npc_cscanner", "npc_clawscanner", "npc_combine_camera", -- These are friendly to enemies

	"monster_human_assassin", "monster_human_grunt", "monster_turret", "monster_miniturret", "monster_sentry"
}

local monsters = {
	"npc_antlion", "npc_antlion_worker", "npc_antlionguard", "npc_barnacle", "npc_fastzombie", "npc_fastzombie_torso",
	"npc_headcrab", "npc_headcrab_fast", "npc_headcrab_black", "npc_headcrab_poison", "npc_poisonzombie", "npc_zombie", "npc_zombie_torso", "npc_zombine",
	"monster_alien_grunt", "monster_alien_slave", "monster_babycrab", "monster_headcrab", "monster_bigmomma", "monster_bullchicken", "monster_barnacle",
	"monster_alien_controller", "monster_gargantua", "monster_nihilanth", "monster_snark", "monster_zombie", "monster_tentacle", "monster_houndeye"
}

local NPCsThisWorksOn = {}
SWEP.RecalcUsableNPCs = function(self)
	-- Not resetting NPCsThisWorksOn as you can't remove classes from the tables below
	-- Not including passive monsters here, you can't make them hostile or friendly
	for _, class in pairs( friendly ) do NPCsThisWorksOn[ class ] = true end
	for _, class in pairs( hostile ) do NPCsThisWorksOn[ class ] = true end
	for _, class in pairs( monsters ) do NPCsThisWorksOn[ class ] = true end
end

local color_black_100 = Color(0, 0, 0, 100)
local color_black_180 = Color(0, 0, 0, 180)
local l_CT = CurTime
local friendliedNPCs = {}
local hostaliziedNPCs = {}
local nzmodernhuds = {
	["Black Ops 3"] = true,
	["Black Ops 4"] = true,
	["Shadows of Evil"] = true,
	["Origins (HD)"] = true,
}

local function SetRelationships( ent, tab, status )
	for id, fnpc in pairs( tab ) do
		if ( !IsValid( fnpc ) ) then table.remove( tab, id ) continue end
		fnpc:AddEntityRelationship( ent, status, 999 )
		ent:AddEntityRelationship( fnpc, status, 999 )
	end
end

local function ProcessOtherNPC( ent )
	if ( table.HasValue( friendly, ent:GetClass() ) && !table.HasValue( hostaliziedNPCs, ent ) ) then -- It's a friendly that isn't made hostile
		SetRelationships( ent, friendliedNPCs, D_LI )
		SetRelationships( ent, hostaliziedNPCs, D_HT )
	elseif ( table.HasValue( hostile, ent:GetClass() ) && !table.HasValue( friendliedNPCs, ent ) ) then -- It's a hostile that isn't made friendly
		SetRelationships( ent, friendliedNPCs, D_HT )
		SetRelationships( ent, hostaliziedNPCs, D_LI )
	elseif ( table.HasValue( monsters, ent:GetClass() ) && !table.HasValue( friendliedNPCs, ent ) && !table.HasValue( hostaliziedNPCs, ent ) ) then -- It's a monster that isn't made friendly or hostile to the player
		SetRelationships( ent, friendliedNPCs, D_HT )
		SetRelationships( ent, hostaliziedNPCs, D_HT )
	end
end

function SWEP:SetupDataTables(...)
	BaseClass.SetupDataTables(self, ...)

	self:NetworkVarTFA("Entity", "HackerTarget")
end

function SWEP:Equip(...)
	if nzombies then
		self.equipment_got_in_round = tonumber(nzRound:GetNumber())
	end

	return BaseClass.Equip(self, ...)
end

function SWEP:Initialize(...)
	self.HackerUtils = {
		["prop_door_rotating"]	= {price = function(ent) return 200 end, time = function(ent) return 30 end, cond = function(ent) return (nzombies and (ent:GetDoorData() ~= nil and (ent:GetDoorData().buyable == nil or tobool(ent:GetDoorData().buyable)) or false)) or (not nzombies and true) end, func = function(ent) self:DoorHack(ent) end},
		["func_door_rotating"]	= {price = function(ent) return 200 end, time = function(ent) return 30 end, cond = function(ent) return (nzombies and (ent:GetDoorData() ~= nil and (ent:GetDoorData().buyable == nil or tobool(ent:GetDoorData().buyable)) or false)) or (not nzombies and true) end, func = function(ent) self:DoorHack(ent) end},
		["func_door"]			= {price = function(ent) return 200 end, time = function(ent) return 30 end, cond = function(ent) return (nzombies and (ent:GetDoorData() ~= nil and (ent:GetDoorData().buyable == nil or tobool(ent:GetDoorData().buyable)) or false)) or (not nzombies and true) end, func = function(ent) self:DoorHack(ent) end},
		["prop_buys"]			= {price = function(ent) return 200 end, time = function(ent) return 30 end, cond = function(ent) return (nzombies and (ent:GetDoorData() ~= nil and (ent:GetDoorData().buyable == nil or tobool(ent:GetDoorData().buyable)) or false)) or (not nzombies and true) end, func = function(ent) self:DoorHack(ent) end},
		["wall_block"]			= {price = function(ent) return 200 end, time = function(ent) return 30 end, cond = function(ent) return (nzombies and (ent:GetDoorData() ~= nil and (ent:GetDoorData().buyable == nil or tobool(ent:GetDoorData().buyable)) or false)) or (not nzombies and true) end, func = function(ent) self:DoorHack(ent) end},

		["nz_hackerbutton"]		= {price = function(ent) return 0 end, time = function(ent) return ent:GetTime() end, cond = function(ent) return ent:GetHaxLock() == 0 end, func = function(ent) end},
		["nz_bo3_hackerbutton"] = {price = function(ent) return ent:GetPrice() end, time = function(ent) return ent:GetTime() end, cond = function(ent) return ent:Hackable() end, func = function(ent) if SERVER then ent:Hack(self:GetOwner()) end end},

		["breakable_entry"]		= {price = function(ent) return 0 end, time = function(ent) return 5 end, cond = function(ent) return ent:GetHasPlanks() and (GetConVar("nz_difficulty_barricade_planks_max"):GetInt() > ent:GetNumPlanks()) end, func = function(ent) self:BarrierHack(ent) end},
		["perk_machine"]		= {price = function(ent) return 0 end, time = function(ent) return 5 end, cond = function(ent) return (ent:GetPerkID() == "pap" and IsValid(ents.FindByName("pap_gatef")[1])) or self:GetOwner():HasPerk(ent:GetPerkID()) end, func = function(ent) self:PerkMachineHack(ent) end},
		["drop_powerup"]		= {price = function(ent) return 5000 end, time = function(ent) return 4 end, cond = function(ent) return true end, func = function(ent) self:PowerupHack(ent) end},
		["wall_buys"]			= {price = function(ent) return 3000 end, time = function(ent) return 2.5 end, cond = function(ent) return ent.GetHacked and ent.GetBought and ent:GetBought() end, func = function(ent) self:WallbuyHack(ent) end},
		["nz_buildtable"]		= {price = function(ent) return 0 end, time = function(ent) return 3 end, cond = function(ent) return !ent:GetBrutusLocked() and !ent:GetCompleted() and ent:GetRemainingParts() <= 0 and (!nzombies or (nzombies and !nzRound:InState(ROUND_CREATE))) end, func = function(ent) self:BuildTableHack(ent) end},

		["random_box_windup"]	= {price = function(ent) return 600 end, time = function(ent) return 2 end, cond = function(ent) return !ent:GetWinding() and !ent:GetIsTeddy() end, func = function(ent) self:BoxResultHack(ent) end},
		["random_box_spawns"]	= {price = function(ent) return 1200 end, time = function(ent) return 4 end, cond = function(ent)
			local box = ents.FindByClass("random_box")[1]
			local boxed = false

			local tr = util.QuickTrace(ent:WorldSpaceCenter(), Vector(0,0,12), ent)
			local tr1 = tr.Entity

			if IsValid(tr1) and tr1:GetClass() == "random_box" then
				boxed = true
			end

			return IsValid(box) and not boxed and not box:GetOpen() and (box.GetActivated and box:GetActivated())
		end, func = function(ent) self:BoxSpawnHack(ent) end},

		["cod_plantedshield"]	= {price = function(ent) return 1000 end, time = function(ent) return 3 end, cond = function(ent) return (not nzombies and self:GetOwner():Armor() >= 50) or (nzombies and true) end, func = function(ent) self:PlantedShieldHack(ent) end},
		["player"]				= {price = function(ent) return 500 end, time = function(ent) return 7 end, cond = function(ent) return (not nzombies and self:GetOwner():Armor() > 0 and ent:Health() < ent:GetMaxHealth()) or (nzombies and true) end, func = function(ent) self:PlayerHack(ent) end},

		["prop_thumper"]		= {price = function(ent) return 0 end, time = function(ent) return 7 end, cond = function(ent) return true end, func = function(ent) if SERVER then ent:Fire("Disable") end end},
		["item_healthcharger"]	= {price = function(ent) return 0 end, time = function(ent) return 10 end, cond = function(ent) return true end, func = function(ent) if SERVER then ent:Fire("Recharge") end end},
		["item_suitcharger"]	= {price = function(ent) return ent:HasSpawnFlags(8192) and 1000 or 500 end, time = function(ent) return ent:HasSpawnFlags(8192) and 10 or 5 end, cond = function(ent) return true end, func = function(ent)
			if SERVER then
				local ply = self:GetOwner()
				if nzombies and IsValid(ply) and ply:IsPlayer() then
					ply:TakePoints(ent:HasSpawnFlags(8192) and 1000 or 500, true)
				end
				ent:Fire("Recharge")
			end
		end},
	}

	return BaseClass.Initialize(self, ...)
end

if nzombies then
	function SWEP:Equip(ply)
		if SERVER then
			/*timer.Simple(engine.TickInterval(), function()
				if not IsValid(self) then return end
				self:SetClip1(0)
			end)*/
			if ply.HackerDevicePAP then
				timer.Simple(0, function()
					if not IsValid(self) then return end
					self:ApplyNZModifier("pap")
				end)
			end
		end

		return BaseClass.Equip(self, ply)
	end
end

function SWEP:ResetHack(doanim)
	self:StopSound("TFA_BO3_HACKER.Loop")
	self:StopSoundNet("TFA_BO3_HACKER.Loop")
	self:SetHackerTarget(nil)

	if doanim then
		self:SendViewModelAnim(ACT_VM_PULLBACK)
		self:ScheduleStatus(TFA.Enum.STATUS_HACKING_END, self:GetActivityLength())
		self:SetNextPrimaryFire(self:GetStatusEnd())
	end
end

function SWEP:CanHack()
	local stat = self:GetStatus()
	local ply = self:GetOwner()
	local ent = self:GetHackerTarget()

	if not IsValid(ent) then
		return false
	end

	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_HACKING then
		return false
	end

	if not ent:IsNPC() and not self.HackerUtils[ent:GetClass()] then
		return false
	end

	if not ent:IsNPC() and not self.HackerUtils[ent:GetClass()].cond(ent) then
		return false
	end

	if nzombies and not ply:CanAfford(self.HackerUtils[ent:GetClass()].price(ent)) then
		return false
	end

	if (ply:GetShootPos():DistToSqr(ent:WorldSpaceCenter()) > self.HackerRangeSqr) then
		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if l_CT() < self:GetNextPrimaryFire() then return false end

	return true
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local targ = self:GetHackerTarget()
	local status = self:GetStatus()

	if self:CanHack() and status ~= TFA.Enum.STATUS_HACKING then
		local duration = self.HackerUtils[targ:GetClass()] and self.HackerUtils[targ:GetClass()].time(targ) or 5
		if nzombies and self:HasNZModifier("pap") then
			duration = math.max(duration*0.5, 1)
		end

		self:ScheduleStatus(TFA.Enum.STATUS_HACKING, duration)
		self:SendViewModelAnim(ACT_VM_PRIMARYATTACK)
	elseif !self:CanHack() and status == TFA.Enum.STATUS_HACKING then
		self:ScheduleStatus(TFA.Enum.STATUS_HACKING_END, self:GetActivityLength(ACT_VM_PULLBACK))
		self:ResetHack(true)
	end

	if status == TFA.Enum.STATUS_HACKING and CurTime() > self:GetStatusEnd() and IsValid(targ) then
		self:ScheduleStatus(TFA.Enum.STATUS_HACKING_END, self:GetActivityLength(ACT_VM_PULLBACK))
		self:SetNextPrimaryFire(self:GetStatusEnd())

		if targ:IsNPC() then
			self:RecalcUsableNPCs(targ)
			self:NPCHack(targ)
		else
			self.HackerUtils[targ:GetClass()].func(targ)
		end

		self:ResetHack(true)

		if IsFirstTimePredicted() then self:EmitSound("TFA_BO3_HACKER.Finish") end
		if SERVER and IsValid(ply) then
			if nzombies then
				local hacks = ply.HackerHacks or 0
				ply.HackerHacks = hacks + 1
				self:SetClip1(ply.HackerHacks)

				if ply.HackerHacks == 30 and not self:HasNZModifier("pap") then
					if nzBuilds then
						self:EmitSound("NZ.BO2.Shovel.Upgrade")
					end
					self:ApplyNZModifier("pap")

					self:ResetFirstDeploy()
					self:CallOnClient("ResetFirstDeploy", "")
					self:Deploy()
					self:CallOnClient("Deploy", "")
				end
			end
			if not ply.bo3hackachievement then
				TFA.BO3GiveAchievement("One Small Hack for a Man...", "vgui/overlay/achievment/hacker.png", ply)
				ply.bo3hackachievement = true
			end
		end
	end

	return BaseClass.Think2(self,...)
end

function SWEP:ChooseIdleAnim(...)
	if self:GetStatus() == TFA.Enum.STATUS_HACKING then return end
	return BaseClass.ChooseIdleAnim(self, ...)
end

function SWEP:DrawHUDBackground()
	local ply = self:GetOwner()
	local tr = ply:GetEyeTrace()
	local ent = tr.Entity
	local status = self:GetStatus()
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

	if status == TFA.Enum.STATUS_HACKING then
		draw.SimpleTextOutlined("Hacking", font, w/2, h/2 + 60*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, color_black_100)
	end

	if IsValid(ent) and not self:CanHack() then
		if nzombies and self.HackerUtils[ent:GetClass()] then
			if ply:GetShootPos():DistToSqr(ply:GetEyeTrace().HitPos) < self.HackerRangeSqr and self.HackerUtils[ent:GetClass()].cond(ent) then
				local text = "Press & Hold "..string.upper(input.LookupBinding("+USE")).." - Hack [Cost: "..self.HackerUtils[ent:GetClass()].price(ent).."]"

				if nzmodernhuds[nzMapping.Settings.hudtype] then
					surface.SetFont(font)
					surface.SetDrawColor(color_black_100)

					local wd, ht = surface.GetTextSize(text)
					surface.DrawRect(w/2 - ((wd/2)+12), h - 280*scale - (ht/2), wd + 24, ht)
				end

				draw.SimpleTextOutlined(text, font, w/2, h - 280*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_100)
			end
		elseif (not nzombies) and (ent:IsNPC() or self.HackerUtils[ent:GetClass()]) then
			if ply:GetShootPos():DistToSqr(ent:WorldSpaceCenter()) < self.HackerRangeSqr then
				draw.SimpleTextOutlined("Press & Hold "..string.upper(input.LookupBinding("+USE")).." - Hack", font, w/2, h/2 + 80*scale, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, color_black_100)
			end
		end
	end

	if status == TFA.Enum.STATUS_HACKING then
		local ct = CurTime()
		local time = self:GetStatusEnd() - ct
		local ctime = self:GetStatusEnd() - self:GetStatusStart()
		if !time or !ctime then return end

		surface.SetDrawColor(color_black_180)
		surface.DrawRect(w/2 - 150, h - 600*scale, 300, 20)
		surface.SetDrawColor(color_white)

		if time < ct then
			surface.DrawRect(w/2 - 145, h - 595*scale, 290 * (1-time/ctime), 10)
		else
			surface.DrawRect(w/2 - 145, h - 595*scale, 290, 10)
		end
	end
end

function SWEP:PrimaryAttack()
	return false
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Reload()
	return false
end

function SWEP:CycleSafety()
	return false
end

function SWEP:OnDrop(...)
	self:ResetHack(false)
	return BaseClass.OnDrop(self,...)
end

function SWEP:OwnerChanged(...)
	self:ResetHack(false)
	return BaseClass.OwnerChanged(self,...)
end

function SWEP:Holster(...)
	self:ResetHack(false)
	return BaseClass.Holster(self,...)
end

function SWEP:OnRemove(...)
	if SERVER and nzombies and not IsValid(ents.FindByClass("nz_bo3_hacker")[1]) then
		hook.Call("RespawnHackerDevice")
	end
	return BaseClass.OnRemove(self,...)
end

function SWEP:PlayerHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		if nzombies then
			ent:GivePoints(500, true)
			ply:TakePoints(500, true)
		else
			local armor = ply:Armor()
			local hp = ent:Health()
			local maxhp = ent:GetMaxHealth()
			local diff = math.Clamp(maxhp - hp, 0, armor)

			ply:SetArmor(math.max(armor - diff, 0))
			ent:SetHealth(math.Clamp(hp + diff, hp, maxhp))
		end
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:BarrierHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		ent:ResetPlanks(true)

		if nzRound:GetNumber() ~= curround then
			self.BoardsRepaired = 0
			curround = nzRound:GetNumber()
		else
			self.BoardsRepaired = self.BoardsRepaired + 1
		end

		if self.BoardsRepaired < 4 then
			ply:GivePoints(100, true)
		else
			ply:TakePoints(50, true)
		end
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:PerkMachineHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		if ent:GetPerkID() == "pap" then
			local door1 = ents.FindByName("pap_gatel")[1]
			local door2 = ents.FindByName("pap_gatef")[1]
			local door3 = ents.FindByName("pap_gater")[1]

			if IsValid(door1) then
				door1:Fire("Open", nil, engine.TickInterval(), ply, ply)
				door2:Fire("Open", nil, engine.TickInterval(), ply, ply)
				door3:Fire("Open", nil, engine.TickInterval(), ply, ply)

				ply:GivePoints(1000, true)

				timer.Simple(30, function() 
					if not IsValid(door1) then return end
					door1:Fire("Close")
					door2:Fire("Close")
					door3:Fire("Close")
				end)
			end
		else
			ply:RemovePerk(ent:GetPerkID())
			ply:GivePoints(ent:GetPrice(), true)

			ply:EmitSound("TFA_BO3_HACKER.Throwup")
		end
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:BoxResultHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		local box = ent.Box
		if not IsValid(box) then return end
		if box.GunHacked then
			local weap = ents.Create("nz_bo3_drop_weapon")
			weap:SetGun(ent:GetWepClass())
			weap:SetPos(ent:GetPos() + box:GetUp()*12)
			weap:SetAngles(ent:GetAngles())
			weap:Spawn()

			box:Close()
			ent:Remove()

			ply:GivePoints(nzMapping.Settings.rboxprice or 950, true)

			box.GunHacked = false
		else
			ent:Remove()
			box:Close()

			box:BuyWeapon(ply)
			ply:GivePoints(math.max((nzMapping.Settings.rboxprice or 950) - math.Round((nzMapping.Settings.rboxprice or 950)*0.63157894737), 5))

			box.GunHacked = true
		end
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:BoxSpawnHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		local box = ents.FindByClass("random_box")[1]
		if IsValid(box) and !box:GetOpen() then
			box:MarkForRemoval()

			for k, v in pairs(ents.FindByClass("random_box_spawns")) do
				v.PossibleSpawn = false
				v:SetBodygroup(1,0)
				v.Box = nil
			end

			ent.PossibleSpawn = true

			nzRandomBox.Spawn(box.SpawnPoint, true)

			timer.Simple(engine.TickInterval(), function()
				if IsValid(ent) and IsValid(ply) then
					ent.Box:BuyWeapon(ply)
					ply:TakePoints(250, true)
				end
			end)
		end
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:PowerupHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		if ent:GetPowerUp() == "firesale" then
			nzPowerUps:SpawnPowerUp(ent:GetPos() - Vector(0,0,50), "bonfiresale")
			ent:Remove()
		elseif ent:GetPowerUp() == "maxammo" then
			nzPowerUps:SpawnPowerUp(ent:GetPos() - Vector(0,0,50), "firesale")
			ent:Remove()
		else
			nzPowerUps:SpawnPowerUp(ent:GetPos() - Vector(0,0,50), "maxammo")
			ent:Remove()
		end

		ply:TakePoints(5000, true)
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:DoorHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		if nzombies then
			local data = ent:GetDoorData()
			if !data then return end

			local datalink = data.link
			if datalink then
				nzDoors:OpenLinkedDoors(datalink, ply)
			else
				nzDoors:OpenDoor(ent)
			end

			ply:TakePoints(200, true)
		else
			ent:Fire("unlock", "", .01)
			ent:Fire("Open")
		end
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:NPCHack(ent)
	if SERVER then
		if ent:GetClass() == "npc_turret_floor" then
			ent:Fire("SelfDestruct")
			return
		end

		if ( ent:IsNPC() && !table.HasValue( passive, ent:GetClass() ) && NPCsThisWorksOn[ ent:GetClass() ] ) then 
			table.insert( friendliedNPCs, ent )
			table.RemoveByValue( hostaliziedNPCs, ent )

			-- Remove the NPC from any squads so the console doesn't spam. TODO: Add a suffix like _friendly instead?
			ent:Fire( "SetSquad", "" )

			-- Special case for stalkers
			if ( ent:GetClass() == "npc_stalker" ) then
				ent:SetSaveValue( "m_iPlayerAggression", 0 )
			end

			-- Is this even necessary anymore?
			for id, class in pairs( friendly ) do ent:AddRelationship( class .. " D_LI 999" ) end
			for id, class in pairs( monsters ) do ent:AddRelationship( class .. " D_HT 999" ) end
			for id, class in pairs( hostile ) do ent:AddRelationship( class .. " D_HT 999" ) end

			SetRelationships( ent, friendliedNPCs, D_LI )
			SetRelationships( ent, hostaliziedNPCs, D_HT )

			for id, oent in pairs( ents.GetAll() ) do
				if ( oent:IsNPC() && oent != ent ) then ProcessOtherNPC( oent ) end
			end

			ent:Activate()
		end
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:PlantedShieldHack(ent)
	local ply = self:GetOwner()
	if ent.Bakuretsu then
		ent:Bakuretsu()
	end
	if SERVER then
		ent:SetHealth(ent:GetMaxHealth())
		ent:SetBodygroup(0, 0)
		ent.Damage = 0
		if nzombies then
			ply:TakePoints(1000, true)
		else
			ply:SetArmor(math.max(ply:Armor() - 50, 0))
		end
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:WallbuyHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		local ang = ent:GetAngles()
		ang:RotateAroundAxis(ang:Up(), 180)
		ang:RotateAroundAxis(ang:Right(), 180)
		ent:SetAngles(ang)
		ent:SetHacked(not ent:GetHacked())

		ply:TakePoints(3000, true)
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end

function SWEP:BuildTableHack(ent)
	local ply = self:GetOwner()
	if SERVER then
		for k, v in pairs(ents.FindByClass("nz_buildable")) do
			if v:GetBuildable() == ent:GetBuildable() then
				if !v:GetActivated() then
					v:Trigger()
				else
					nzBuilds:UpdateHeldParts(v)
				end
			end
		end

		for k, v in pairs(ents.FindByClass("nz_digsite")) do
			if v:GetOverride() and v:GetBuildable() == ent:GetBuildable() and not v:GetActivated() then
				v:Trigger()
			end
		end

		ent:StopParticles()
		ent:StopSound(ent.BuildLoopSound or "NZ.Buildable.Craft.Loop")
		if not ent.ClassicSounds then
			ent:StopSound("NZ.Buildable.Craft.LoopSweet")
		end

		if IsValid(ent.CraftedModel) then
			ParticleEffect("nzr_building_poof", ent.CraftedModel:WorldSpaceCenter(), angle_zero)
			ent.CraftedModel:Reset()
		end
		if IsValid(ent.CraftedModel2) then
			ent.CraftedModel2:Reset()
		end

		ent:SetCompleted(true)
		ent:EmitSound(ent.BuildEndSound or "NZ.Buildable.Craft.Finish")
		if not ent.ClassicSounds then
			ent:EmitSound("NZ.Buildable.Craft.FinishSweet")
		end

		ply:GivePoints(2000, true)
	end

	ent:EmitSound("TFA_BO3_HACKER.Success")
end
