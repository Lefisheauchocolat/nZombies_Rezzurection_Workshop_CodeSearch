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

local nzombies = engine.ActiveGamemode() == "nzombies"

if GetConVar("cl_tfa_fx_wonderweapon_dlights") == nil then
	CreateClientConVar("cl_tfa_fx_wonderweapon_dlights", 0, true, false, "Enable or disable dynamic lights on entites and muzzleflashes. (0 false, 1 true), Default is 0.")
end

if GetConVar("cl_tfa_bo3ww_crosshair") == nil then
	CreateClientConVar("cl_tfa_bo3ww_crosshair", 1, true, false, "Enable or disable the original crosshairs for their respective wonder weapons. (0 false, 1 true), Default is 1.")
end

if GetConVar("cl_tfa_fx_wonderweapon_3p") == nil then
	CreateClientConVar("cl_tfa_fx_wonderweapon_3p", 1, true, false, "Enable or disable third person particles on wonder weapons that have them. (0 false, 1 true), Default is 1.")
end

local function CreateReplConVar(cvarname, cvarvalue, description, ...)
	return CreateConVar(cvarname, cvarvalue, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, description, ...)
end -- replicated only on clients, archive/notify on server

if GetConVar("sv_tfa_bo3ww_inf_specialist") == nil then
	CreateReplConVar("sv_tfa_bo3ww_inf_specialist", "0", "Enable or disable infinite ammo on zombie specific specialist weapons. REQURIES MAP RESTART (0 false, 1 true), Default is 0.")
end

if nzombies then
	if GetConVar("nz_difficulty_bo3_tacticalkills") == nil then
		CreateReplConVar("nz_difficulty_bo3_tacticalkills", "50", "Amount of kills required to upgrade Monkeybombs in nZombies. Default is 50.")
	end
end

if not TFA.Enum.ChargeStatus then
	TFA.Enum.ChargeStatus = {}
end

if not TFA.Enum.STATUS_CHARGE_UP then
	TFA.AddStatus("CHARGE_UP")

	TFA.Enum.ReadyStatus[TFA.Enum.STATUS_CHARGE_UP] = true
	TFA.Enum.IronStatus[TFA.Enum.STATUS_CHARGE_UP] = true
end

TFA.Enum.ChargeStatus[TFA.Enum.STATUS_CHARGE_UP] = true

if not TFA.Enum.STATUS_CHARGE_DOWN then
	TFA.AddStatus("CHARGE_DOWN")

	TFA.Enum.IronStatus[TFA.Enum.STATUS_CHARGE_DOWN] = true
end

TFA.Enum.ChargeStatus[TFA.Enum.STATUS_CHARGE_DOWN] = true

if not TFA.Enum.STATUS_RAGNAROK_DEPLOY then
	TFA.AddStatus("RAGNAROK_DEPLOY")

	TFA.Enum.HUDDisabledStatus[TFA.Enum.STATUS_RAGNAROK_DEPLOY] = true
	TFA.Enum.IronStatus[TFA.Enum.STATUS_RAGNAROK_DEPLOY] = true
end

if not TFA.Enum.STATUS_HACKING then
	TFA.AddStatus("HACKING")

	TFA.Enum.HUDDisabledStatus[TFA.Enum.STATUS_HACKING] = true
	TFA.Enum.ReadyStatus[TFA.Enum.STATUS_HACKING] = true
	TFA.Enum.IronStatus[TFA.Enum.STATUS_HACKING] = true
end

if not TFA.Enum.STATUS_HACKING_END then
	TFA.AddStatus("HACKING_END")

	TFA.Enum.HUDDisabledStatus[TFA.Enum.STATUS_HACKING_END] = true
	TFA.Enum.IronStatus[TFA.Enum.STATUS_HACKING_END] = true
end

TFA.BO3Indicators = {
	['bo3_ww_crossbow'] = Material("vgui/icon/hud_indicator_arrow.png", "smooth unlitgeneric"),
	['bo3_ww_scavenger'] = Material("vgui/icon/hud_indicator_sniper_explosive.png", "smooth unlitgeneric")
}

TFA.BO3VisionEnts = {
	["bo3_special_dg4"] = {range = 500, fade = 100, red = 0, blu = 0.3, grn = 0.2, blur = false, blurMul = 0.2, blurDelay = 0.01},
	["bo4_specialist_dg5"] = {range = 500, fade = 100, red = 0, blu = 0.3, grn = 0.2, blur = false, blurMul = 0.2, blurDelay = 0.01},
	["bo3_ww_gkzmk3_bh"] = {range = 400, fade = 200, red = 0.15, blu = 0.25, grn = 0.05, blur = false, blurMul = 0.2, blurDelay = 0.01},
	["bo3_tac_gersch"] = {range = 800, fade = 200, red = 0.1, blu = 0.3, grn = 0, blur = false, blurMul = 0.2, blurDelay = 0.01, upgrade = true},
	["bo3_ww_idgun"] = {range = 600, fade = 200, red = 0.2, blu = 0.3, grn = 0, blur = false, blurMul = 0.2, blurDelay = 0.01, upgrade = true},
	["nz_bo3_tac_gersch"] = {range = 800, fade = 200, red = 0.1, blu = 0.3, grn = 0, blur = false, blurMul = 0.2, blurDelay = 0.01, upgrade = true},
	["bo3_ww_gkz"] = {range = 250, fade = 100, red = 0.15, blu = 0.05, grn = .15, blur = false, blurMul = 0.2, blurDelay = 0.01},
}

TFA.BO3NoModSound = {
	["TFA_BO3_JGB.ZMB.Squish"] = true,
	["TFA_BO3_JGB.ZMB.Kick"] = true,
	["TFA_BO3_JGB.ZMB.Shrink"] = true,
	["TFA_BO3_JGB.ZMB.UnShrink"] = true,
}

TFA.BO3BloodColor = {
	[BLOOD_COLOR_GREEN] = "bo3_annihilator_blood_zomb",
	[BLOOD_COLOR_ZOMBIE] = "bo3_annihilator_blood_zomb",
	[BLOOD_COLOR_YELLOW] = "bo3_annihilator_blood_yellow",
	[BLOOD_COLOR_ANTLION] = "bo3_annihilator_blood_yellow",
	[BLOOD_COLOR_RED] = "bo3_annihilator_blood",
}

-- Projectile Models
//projectiles
util.PrecacheModel("models/weapons/tfa_bo3/scavenger/scavenger_projectile.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/keepersword/keepersword_projectile.mdl")

//throwables
util.PrecacheModel("models/weapons/tfa_bo3/gstrike/gstrike_prop.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/monkeybomb/monkeybomb_prop.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/octobomb/octobomb_arnie.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/matryoshka/matryoshka_prop.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/qed/w_qed.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/gersch/w_gersch.mdl")

//misc
util.PrecacheModel("models/weapons/tfa_bo3/grenade/grenade_prop.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/dg4/dg4_prop.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/qed/w_haymaker.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/qed/w_kn44.mdl")
util.PrecacheModel("models/weapons/tfa_bo3/qed/w_maxgl.mdl")

-- Surface Sounds
if SERVER then
	util.AddNetworkString("TFA.BO3.QED_SND")
	util.AddNetworkString("TFA.BO3.REMOVERAG")
	util.AddNetworkString("TFA.BO3.ACHIEVEMENT")

	net.Receive("TFA.BO3.REMOVERAG", function(len, ply)
		local ply = net.ReadEntity()
		if not IsValid(ply) then return end
		
		SafeRemoveEntity(ply:GetRagdollEntity())
	end)

	local reward = {
		[1] = 950,
		[2] = 2250,
		[3] = 4500,
	}

	if nzombies and TFA.WWNoTargetIngore == nil then
		local function WonderWeaponNoTarget(ply)
			if ply.BO3IsTransfur and ply:BO3IsTransfur() then
				return false
			end
			if ply.BO4IsStealth and ply:BO4IsStealth() then
				return false
			end
			if ply.HasVultureStink and ply:HasVultureStink() then
				return false
			end

			return true
		end
		TFA.WWNoTargetIngore = WonderWeaponNoTarget
	end

	local function BO3GiveAchievement(str, icon, ply, num)
		if IsValid(ply) then
			ply:EmitSound("TFA_BO3_GENERIC.Funny")

			if not num then num = 1 end
			num = math.Clamp(num, 1, 3)

			if nzombies and ply:Alive() then
				ply:GivePoints(reward[num])
			end

			net.Start("TFA.BO3.ACHIEVEMENT")
				net.WriteString(str)
				net.WriteString(icon)
				net.WriteInt(num, 8)
			return net.Send(ply)
		end
	end
	TFA.BO3GiveAchievement = BO3GiveAchievement
end

TFA.QEDSounds = {
	WeaponTake = "weapons/tfa_bo3/qed/vox/zmb_vox_ann_random_weapon_0.wav",
	MaxAmmo = "weapons/tfa_bo3/qed/vox/zmb_vox_ann_powerup_maxammo_0.wav",
	StealAmmo = "weapons/tfa_bo3/qed/vox/zmb_vox_ann_points_negative.wav",
	WeaponGive = "weapons/tfa_bo3/qed/vox/zmb_vox_ann_random_weapon_1.wav",
	DeathMachine = "weapons/tfa_bo3/qed/vox/death_machine.wav",
	Tesla = "weapons/tfa_bo3/qed/vox/ann_tesla_02.wav",
	Specialist = "weapons/tfa_bo3/dg4/sword_ready_3p.wav",
	MonkeyUpgrade = "weapons/tfa_bo3/monkeybomb/monkey_kill_confirm.wav",
	Shield = "weapons/tfa_bo3/zm_common.all.sabl.4316.wav",
	Raygun = "weapons/tfa_bo3/zm_common.all.sabl.510.wav",
}

if CLIENT then
	net.Receive("TFA.BO3.QED_SND", function(len, ply)
		local event = net.ReadString()
		local snd = TFA.QEDSounds[event]

		surface.PlaySound(snd)
	end)

	local trophies = {
		[1] = "vgui/overlay/achievement_bronze.png",
		[2] = "vgui/overlay/achievement_silver.png",
		[3] = "vgui/overlay/achievement_gold.png"
	}

	local achievement, trophy, icon, text, text2
	net.Receive("TFA.BO3.ACHIEVEMENT", function(len, ply)
		LocalPlayer():EmitSound("TFA_BO3_GENERIC.Funny")
		local actext = net.ReadString()
		local acicon = net.ReadString()
		local actype = net.ReadInt(8)

		if IsValid(achievement) then achievement:Remove() end
		local w, h = ScrW(), ScrH()
		local scale = (w/1920 + 1) / 2

		achievement = vgui.Create("DImage")
		achievement:SetImage("vgui/overlay/achievement_bkg2.png")
		achievement:SetSize(340*scale, 85*scale)
		achievement:SetPos(w - (480*scale), h * (0.05*scale))

		achievement.CreateTime = CurTime()
		achievement.Alpha = 0
		achievement.Offset = 0

		achievement.Think = function()
			if achievement.CreateTime + 6 < CurTime() then
				achievement.Alpha = math.Approach(achievement.Alpha, 0, FrameTime() * 2)
				if achievement.Alpha <= 0 then
					achievement:Remove()
				end
			elseif achievement.Alpha < 1 then
				achievement.Alpha = math.Approach(achievement.Alpha, 1, FrameTime() * 5)
			end
			achievement:SetAlpha(achievement.Alpha * 255)
		end

		if IsValid(trophy) then trophy:Remove() end
		trophy = vgui.Create("DImage", achievement)
		trophy:SetSize(30*scale, 30*scale)
		trophy:SetPos(95*scale, 46*scale)
		trophy:SetImage(trophies[actype], "vgui/avatar_default")

		if IsValid(icon) then icon:Remove() end
		local icon = vgui.Create("DImage", achievement)
		icon:SetSize(72*scale, 72*scale)
		icon:SetPos(10*scale, 6*scale)
		icon:SetImage(acicon, "vgui/avatar_default")

		if IsValid(text) then text:Remove() end
		local text = vgui.Create("DLabel", achievement)
		text:SetSize(256*scale, 64*scale)
		text:SetPos(100*scale, -10*scale)
		text:SetFont("HudHintTextLarge")
		text:SetText("You have earned a trophy.")
		text:SetTextColor(color_white)

		if IsValid(text2) then text2:Remove() end
		local text2 = vgui.Create("DLabel", achievement)
		text2:SetSize(256*scale, 64*scale)
		text2:SetPos(135*scale, 30*scale)
		text2:SetFont("HudHintTextLarge")
		text2:SetText(actext)
		text2:SetTextColor(color_white)
	end)
end

-- Refil Specialist function
function TFA.SpecialistAmmoRefil(npc, attacker, inflictor)
	if not IsValid(npc) or not IsValid(attacker) or not IsValid(inflictor) or not attacker:IsPlayer() then return end

	for _, wep in pairs(attacker:GetWeapons()) do
		if wep.IsTFAWeapon and wep.NZSpecialCategory == "specialist" and inflictor:GetClass() ~= wep:GetClass() then
			if wep:Clip1() < wep:GetStatL("Primary.ClipSize") then
				local clipsize = wep:GetStatL("Primary.ClipSize")

				if wep:Clip1() == clipsize then return end
				local amount = wep.AmmoRegen or 1
				if nzombies and attacker:HasPerk("time") then
					amount = math.Round(amount * 2)
				end

				wep:SetClip1(math.Min(wep:Clip1() + amount, clipsize))

				if wep:Clip1() >= clipsize then
					if wep.OnSpecialistRecharged then
						wep:OnSpecialistRecharged()
						wep:CallOnClient("OnSpecialistRecharged", "")
					end
					hook.Run("OnSpecialistRecharged", wep, attacker, inflictor)

					if attacker:GetActiveWeapon() ~= wep and wep.IsTFAWeapon then
						wep:ResetFirstDeploy()
						if SERVER and game.SinglePlayer() then
							wep:CallOnClient("ResetFirstDeploy", "")
						end
					end

					if SERVER then
						net.Start("TFA.BO3.QED_SND")
						net.WriteString("Specialist")
						net.Send(attacker)
					end
				end
			end
		end
	end
end
