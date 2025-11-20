-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

DEFINE_BASECLASS("tfa_gun_base")
// hi, please dont look in here. its fucking ugly as shit and probaly the worst thing you'll ever see

SWEP.Akimbo = true
SWEP.AnimCycle = 1
SWEP.Animations = {
	["reload_rh"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_RELOAD_DEPLOYED
	},
	["reload_lh"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,
		["value"] = ACT_VM_RELOAD2
	},
}

SWEP.SpeedColaActivities = {
	[ACT_VM_DRAW] = true,
	[ACT_VM_DRAW_DEPLOYED or 0] = true,
	[ACT_VM_RELOAD] = true,
	[ACT_VM_HOLSTER] = true,
	[ACT_VM_RELOAD2] = true,
	[ACT_VM_RELOAD_DEPLOYED] = true,
}

SWEP.Secondary.ClipSize = 6
SWEP.Secondary.DefaultClip = 6
SWEP.Secondary.AmmoConsumption = 1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "SMG1_Grenade"
SWEP.Secondary.RPM = 600
SWEP.Secondary.Damage = engine.ActiveGamemode() == "nzombies" and 3000 or 120

local l_CT = CurTime
local sp = game.SinglePlayer()
local typev, tanim, pos

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Int", "AkimboAttackValue")
end

function SWEP:FixAkimbo()
end

function SWEP:CycleSafety()
end

function SWEP:AkimboReload()
	return self:Clip1() < self:GetMaxClip1() and self:Clip2() < self:GetMaxClip2()
end

function SWEP:ToggleAkimbo(override, val)
	if override then
		self:SetAnimCycle(val)
		self.AnimCycle = self:GetAnimCycle()
	end
end

function SWEP:CompleteReload(...)
	if hook.Run("TFA_CompleteReload", self) then return end

	if self:AkimboReload() then
		local maxclip1 = self:GetMaxClip1()
		local curclip1 = self:Clip1()
		local amounttoreplace1 = math.min(maxclip1 - curclip1, self:Ammo1())
		self:TakePrimaryAmmo(amounttoreplace1 * -1)
		self:TakePrimaryAmmo(amounttoreplace1, true)

		local maxclip = self:GetMaxClip2()
		local curclip = self:Clip2()
		local amounttoreplace = math.min(maxclip - curclip, self:Ammo1())
		self:TakeSecondaryAmmo(amounttoreplace * -1)
		self:TakePrimaryAmmo(amounttoreplace, true)
		return
	end

	if self:GetAkimboAttackValue() == 1 then
		local maxclip = self:GetMaxClip2()
		local curclip = self:Clip2()
		local amounttoreplace = math.min(maxclip - curclip, self:Ammo1())
		self:TakeSecondaryAmmo(amounttoreplace * -1)
		self:TakePrimaryAmmo(amounttoreplace, true)
		return
	else
		return BaseClass.CompleteReload(self, ...)
	end
end

function SWEP:Reload(...)
	if self:GetAnimCycle() == 1 then
		return BaseClass.Reload(self, ...)
	else
		return BaseClass.Reload2(self, ...)
	end
end

function SWEP:ChooseReloadAnim()
	local self2 = self:GetTable()
	if not self:VMIV() then return false, 0 end
	if self2.GetStatL(self, "IsProceduralReloadBased") then return false, 0 end

	if self:AkimboReload() then
		typev, tanim = self:ChooseAnimation("reload")
	elseif self:GetAkimboAttackValue() == 0 then
		typev, tanim = self:ChooseAnimation("reload_rh")
	else
		typev, tanim = self:ChooseAnimation("reload_lh")
	end

	local fac = 1

	if self:GetStatL("LoopedReload") and self:GetStatL("LoopedReloadInsertTime") then
		fac = self:GetStatL("LoopedReloadInsertTime")
	end

	self:SetAnimCycle(self2.ViewModelFlip and 0 or 1)
	self2.AnimCycle = self:GetAnimCycle()

	return self.PlayChosenAnimation(self, typev, tanim, fac, fac ~= 1)
end

function SWEP:ChooseShootAnim(ifp)
	local self2 = self:GetTable()
	if ifp == nil then ifp = IsFirstTimePredicted() end
	if not self:VMIV() then return end

	if self2.LuaShellEject and (ifp or sp) then
		self:EventShell()
	end

	if self:GetAkimboAttackValue() == 0 then
		typev, tanim = self:ChooseAnimation("shoot2")
	else
		typev, tanim = self:ChooseAnimation("shoot1")
	end

	return self2.PlayChosenAnimation(self, typev, tanim)
end

function SWEP:CanSecondaryAttack()
	local self2 = self:GetTable()

	local v = hook.Run("TFA_PreCanPrimaryAttack", self)
	if v ~= nil then return v end

	stat = self:GetStatus()

	if not TFA.Enum.ReadyStatus[stat] and stat ~= TFA.Enum.STATUS_SHOOTING then
		if self:GetStatL("LoopedReload") and TFA.Enum.ReloadStatus[stat] then
			self:SetReloadLoopCancel(true)
		end

		return false
	end

	if self:GetSprintProgress() >= 0.1 and not self:GetStatL("AllowSprintAttack", false) then
		return false
	end

	if self:GetStatL("Secondary.ClipSize") <= 0 and self:Ammo1() < self:GetStatL("Secondary.AmmoConsumption") then
		return false
	end

	if self:GetPrimaryClipSize(true) > 0 and self:Clip2() < self:GetStatL("Secondary.AmmoConsumption") then
		return false
	end

	if self2.GetStatL(self, "Primary.FiresUnderwater") == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextSecondaryFire(l_CT() + 0.5)
		self:EmitSound(self:GetStatL("Primary.Sound_Blocked"))
		return false
	end

	self2.SetHasPlayedEmptyClick(self, false)

	if l_CT() < self:GetNextSecondaryFire() then return false end

	local v2 = hook.Run("TFA_CanPrimaryAttack", self)
	if v2 ~= nil then return v2 end

	return true
end

function SWEP:SecondaryAttack(...)
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanSecondaryAttack() then return end

	self:PreSecondaryAttack()
	if hook.Run("TFA_PrimaryAttack", self) then return end

	self:ToggleAkimbo(true, 0)
	self:SetAkimboAttackValue(1)
	self:TriggerAttack("Secondary", 2)

	self:PostSecondaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)
end

function SWEP:PrimaryAttack(...)
	local self2 = self:GetTable()
	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	if not IsValid(self) then return end
	if ply:IsPlayer() and not self:VMIV() then return end
	if not self:CanPrimaryAttack() then return end

	self:PrePrimaryAttack()
	if hook.Run("TFA_PrimaryAttack", self) then return end

	self:ToggleAkimbo(true, 1)
	self:SetAkimboAttackValue(0)
	self:TriggerAttack("Primary", 1)

	self:PostPrimaryAttack()
	hook.Run("TFA_PostPrimaryAttack", self)
end

function SWEP:PostPrimaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end
	local snd1 = self:GetStat("Primary.SoundLayer1")
	local snd2 = self:GetStat("Primary.SoundLayer2")
	local snd3 = self:GetStat("Primary.SoundLayer3")
	local sndpap = self:GetStat("Primary.SoundFlux")

	if not ifp then return end
	if snd1 then
		self:EmitGunfireSound(snd1)
	end
	if snd2 then
		self:EmitGunfireSound(snd2)
	end
	if snd3 then
		self:EmitGunfireSound(snd3)
	end
	if sndpap then
		self:EmitGunfireSound(sndpap)
	end
end

function SWEP:PostSecondaryAttack()
	local ply = self:GetOwner()
	local ifp = IsFirstTimePredicted()
	if not IsValid(ply) then return end
	local snd1 = self:GetStat("Primary.SoundLayer1")
	local snd2 = self:GetStat("Primary.SoundLayer2")
	local snd3 = self:GetStat("Primary.SoundLayer3")
	local sndpap = self:GetStat("Primary.SoundFlux")

	if not ifp then return end
	if snd1 then
		self:EmitGunfireSound(snd1)
	end
	if snd2 then
		self:EmitGunfireSound(snd2)
	end
	if snd3 then
		self:EmitGunfireSound(snd3)
	end
	if sndpap then
		self:EmitGunfireSound(sndpap)
	end
end

function SWEP:PreSpawnProjectile(ent)
	local ply = self:GetOwner()
	if self:GetAkimboAttackValue() == 0 then
		pos = ply:GetShootPos() + ply:GetUp()*-5 + ply:GetRight()*-20
	else
		pos = ply:GetShootPos() + ply:GetUp()*-5 + ply:GetRight()*20
	end
	ent:SetPos(pos)
end

function SWEP:PostSpawnProjectile(ent)
	local ply = self:GetOwner()
	local phys = ent:GetPhysicsObject()
	local vel = self:GetStat("Primary.ProjectileVelocity")

	if self:GetAkimboAttackValue() == 0 then
		pos = ply:GetShootPos() + ply:GetUp()*-5 + ply:GetRight()*-20
	else
		pos = ply:GetShootPos() + ply:GetUp()*-5 + ply:GetRight()*20
	end

	if IsValid(phys) and self:GetOwner():IsPlayer() then
		phys:SetVelocity((ply:GetEyeTrace().HitPos - pos):GetNormalized()*vel)
	end
end

local hudenabled_cvar = GetConVar("cl_tfa_hud_enabled")

local draw = draw
local cam = cam
local surface = surface
local render = render
local Vector = Vector
local Matrix = Matrix
local TFA = TFA
local math = math

local function ColorAlpha(color_in, new_alpha)
	if color_in.a == new_alpha then return color_in end
	return Color(color_in.r, color_in.g, color_in.b, new_alpha)
end

local targ, lactive = 0, -1
local targbool = false
local hudhangtime_cvar = GetConVar("cl_tfa_hud_hangtime")
local hudfade_cvar = GetConVar("cl_tfa_hud_ammodata_fadein")
local lfm, fm = 0, 0

SWEP.CLAmmoProgress = 0
SWEP.TextCol = Color(255, 255, 255, 255) --Primary text color
SWEP.TextColContrast = Color(32, 32, 32, 255) --Secondary Text Color (used for shadow)

//haha funny replace the entire function to change 2 things
function SWEP:DrawHUDAmmo()
	local self2 = self:GetTable()
	local stat = self2.GetStatus(self)

	if not hudenabled_cvar:GetBool() then return end

	fm = self:GetFireMode()
	targbool = (not TFA.Enum.HUDDisabledStatus[stat]) or fm ~= lfm
	targbool = targbool or (stat == TFA.Enum.STATUS_SHOOTING and self2.LastBoltShoot and l_CT() > self2.LastBoltShoot + self2.BoltTimerOffset)
	targbool = targbool or (self2.GetStatL(self, "PumpAction") and (stat == TFA.Enum.STATUS_PUMP or (stat == TFA.Enum.STATUS_SHOOTING and self:Clip1() == 0)))
	targbool = targbool or (stat == TFA.Enum.STATUS_FIDGET)

	targ = targbool and 1 or 0
	lfm = fm

	if targ == 1 then
		lactive = RealTime()
	elseif RealTime() < lactive + hudhangtime_cvar:GetFloat() then
		targ = 1
	elseif self:GetOwner():KeyDown(IN_RELOAD) then
		targ = 1
	end

	self2.CLAmmoProgress = math.Approach(self2.CLAmmoProgress, targ, (targ - self2.CLAmmoProgress) * RealFrameTime() * 2 / hudfade_cvar:GetFloat())

	local myalpha = 225 * self2.CLAmmoProgress
	if myalpha < 1 then return end
	local amn = self2.GetStatL(self, "Primary.Ammo")
	if not amn then return end
	if amn == "none" or amn == "" then return end
	--local mzpos = self:GetMuzzlePos()

	if self2.GetHidden(self) then return end

	local xx, yy

	local mzpos = self:GetOwner():ShouldDrawLocalPlayer() and self:GetAttachment(2) or self2.OwnerViewModel:GetAttachment(2)
	if mzpos then
		local pos = mzpos.Pos
		local ts = pos:ToScreen()

		xx, yy = ts.x, ts.y
	else
		xx, yy = ScrW() * .35, ScrH() * .6
	end

	local v, newx, newy, newalpha = hook.Run("TFA_DrawHUDAmmo", self, xx, yy, myalpha)
	if v ~= nil then
		if v then
			xx = newx or xx
			yy = newy or yy
			myalpha = newalpha or myalpha
		else
			return
		end
	end

	if self:GetInspectingProgress() < 0.01 and self2.GetStatL(self, "Primary.Ammo") ~= "" and self2.GetStatL(self, "Primary.Ammo") ~= 0 then
		local str, clipstr

		if self2.GetStatL(self, "Primary.ClipSize") and self2.GetStatL(self, "Primary.ClipSize") ~= -1 then
			clipstr = language.GetPhrase("tfa.hud.ammo.clip1")

			str = clipstr:format(self:Clip1())

			if (self:Clip1() > self2.GetStatL(self, "Primary.ClipSize")) then
				str = clipstr:format(self2.GetStatL(self, "Primary.ClipSize") .. " + " .. (self:Clip1() - self2.GetStatL(self, "Primary.ClipSize")))
			end

			draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			str = language.GetPhrase("tfa.hud.ammo.reserve1"):format(self2.Ammo1(self))
			yy = yy + TFA.Fonts.SleekHeight
			xx = xx - TFA.Fonts.SleekHeight / 3
			draw.DrawText(str, "TFASleekMedium", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleekMedium", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
			yy = yy + TFA.Fonts.SleekHeightMedium
			xx = xx - TFA.Fonts.SleekHeightMedium / 3
		end

		str = string.upper(self:GetFireModeName() .. (#self2.GetStatL(self, "FireModes") > 2 and " | +" or ""))

		draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
		draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
		yy = yy + TFA.Fonts.SleekHeightSmall
		xx = xx - TFA.Fonts.SleekHeightSmall / 3

		if self2.GetStatL(self, "IsAkimbo") then
			local angpos2 = self:GetOwner():ShouldDrawLocalPlayer() and self:GetAttachment(1) or self2.OwnerViewModel:GetAttachment(1)

			if angpos2 then
				local pos2 = angpos2.Pos
				local ts2 = pos2:ToScreen()

				xx, yy = ts2.x, ts2.y
			else
				xx, yy = ScrW() * .35, ScrH() * .6
			end

			if self2.GetStatL(self, "Secondary.ClipSize") and self2.GetStatL(self, "Secondary.ClipSize") ~= -1 then
				clipstr = language.GetPhrase("tfa.hud.ammo.clip1")

				str = clipstr:format(self:Clip2())

				if (self:Clip2() > self2.GetStatL(self, "Secondary.ClipSize")) then
					str = clipstr:format(self2.GetStatL(self, "Secondary.ClipSize") .. " + " .. (self:Clip2() - self2.GetStatL(self, "Secondary.ClipSize")))
				end

				draw.DrawText(str, "TFASleek", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
				draw.DrawText(str, "TFASleek", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
				str = language.GetPhrase("tfa.hud.ammo.reserve1"):format(self2.Ammo2(self))
				yy = yy + TFA.Fonts.SleekHeight
				xx = xx - TFA.Fonts.SleekHeight / 3
				draw.DrawText(str, "TFASleekMedium", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
				draw.DrawText(str, "TFASleekMedium", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
				yy = yy + TFA.Fonts.SleekHeightMedium
				xx = xx - TFA.Fonts.SleekHeightMedium / 3
			end

			str = string.upper(self:GetFireModeName() .. (#self2.FireModes > 2 and " | +" or ""))
			draw.DrawText(str, "TFASleekSmall", xx + 1, yy + 1, ColorAlpha(self2.TextColContrast, myalpha), TEXT_ALIGN_RIGHT)
			draw.DrawText(str, "TFASleekSmall", xx, yy, ColorAlpha(self2.TextCol, myalpha), TEXT_ALIGN_RIGHT)
		end
	end
end