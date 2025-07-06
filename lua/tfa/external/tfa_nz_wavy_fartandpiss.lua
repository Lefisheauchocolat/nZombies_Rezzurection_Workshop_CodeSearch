local nzombies = engine.ActiveGamemode() == "nzombies"

--particles
game.AddParticles("particles/perks_aat_windstorm.pcf")
PrecacheParticleSystem("nz_aat_windstorm_loop")
PrecacheParticleSystem("nz_aat_windstorm_start")

game.AddParticles("particles/ghoul_fx.pcf")
PrecacheParticleSystem("glowingone_irradiate")

if CLIENT then

	local tab = {
		["$pp_colour_addr"] = 0.2,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0.1,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1.25,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}
	
	hook.Add("RenderScreenspaceEffects", "nZ.Berzerk.Overlay",function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if nzombies and nzPowerUps:IsPlayerPowerupActive(ply, "berzerk") then
			DrawColorModify(tab)
		end
	end)
end

if CLIENT then

	local tab2 = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0.2,
		["$pp_colour_brightness"] = 0.1,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1.1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0.1,
	}
	
	hook.Add("RenderScreenspaceEffects", "nZ.GodMode.Overlay",function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if nzombies and nzPowerUps:IsPlayerPowerupActive(ply, "godmode") then
			DrawColorModify(tab2)
		end
	end)
end

local function CalcGodModeView(ply, pos, ang, fov, znear, zfar)
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end
	if nzombies and nzPowerUps:IsPlayerPowerupActive(ply, "godmode") then
		local fov = fov - 8
		return {origin = pos, angles = ang, fov = fov, znear = znear, zfar = zfar, drawviewer = false }
	end
end

hook.Add("CalcView", "CalcGodModeView", CalcGodModeView )

if nzombies then
	hook.Add("PostGamemodeLoaded", "Wavy_NZ_CustomAATsdookybuttNZMOO", function()
	nzAATs:RegisterAAT("shatterblast", {
		name = "Shatter Blast", //name that displays next to AAT icon on some HUDs
		chance = 0.15, //0.10 would be 10% proc chance on every shot
		cooldown = 15, //cooldown in seconds
		color = Color(255, 215, 0), //color of AAT text on some HUDs
		ent = "shatterblast_effect", //***REQUIRES*** a NetworkVar Entity 'Attacker' and 'Inflictor', Entity is parented to zombie on proc
		flash = Material("vgui/wavy_hud_cp_aat_shatterblast_alt.png", "smooth unlitgeneric"),
		icon = Material("vgui/hud_wpn_aat_shatterblast.png", "smooth unlitgeneric"),
		desc = "Proc to create an explosion. Thats it."
	})
	nzAATs:RegisterAAT("windstorm", {
		name = "Wind Storm", //name that displays next to AAT icon on some HUDs
		chance = 0.2, //0.10 would be 10% proc chance on every shot
		cooldown = 30, //cooldown in seconds
		color = Color(180, 180, 180), //color of AAT text on some HUDs
		ent = "windstorm_effect", //***REQUIRES*** a NetworkVar Entity 'Attacker' and 'Inflictor', Entity is parented to zombie on proc
		flash = Material("vgui/wavy_hud_cp_aat_windstorm_alt221.png", "smooth unlitgeneric"),
		icon = Material("vgui/hud_wpn_aat_windstorm.png", "smooth unlitgeneric"),
		desc = "Proc to create a tornado that tears apart zombies within its radius."
	})
	nzAATs:RegisterAAT("reanimator", {
		name = "Re-Animator", //name that displays next to AAT icon on some HUDs
		chance = 0.15, //0.10 would be 10% proc chance on every shot
		cooldown = 15, //cooldown in seconds
		color = Color(255, 144, 71), //color of AAT text on some HUDs
		ent = "reanimator_effect", //***REQUIRES*** a NetworkVar Entity 'Attacker' and 'Inflictor', Entity is parented to zombie on proc
		flash = Material("vgui/wavy_hud_cp_aat_reanimtor.png", "smooth unlitgeneric"),
		icon = Material("vgui/wavy_hud_wpn_aat_reanimator.png", "smooth unlitgeneric"),
		desc = "Proc to turn a zombie into a fed."
	})
	end)
end

if nzombies then
    hook.Add("InitPostEntity", "Wavy_NZ_GrenadesTHROWITBACKPRIVATESIRYESSIR", function()
		nzSpecialWeapons:AddGrenade("nz_waw_stickgrenade", 4, false, 0.6, false, 0.4)
		nzSpecialWeapons:AddGrenade("nz_bo3_grenade", 4, false, 0.6, false, 0.4)
		nzSpecialWeapons:AddGrenade("nz_waw_mk2", 4, false, 0.6, false, 0.4)
		nzSpecialWeapons:AddGrenade("nz_bo3_semtex", 4, false, 0.6, false, 0.4)
		nzSpecialWeapons:AddGrenade("nz_iw_grenade", 4, false, 0.6, false, 0.4)
    end)
end

--custom trials
if nzombies then 
	hook.Add("PostGamemodeLoaded", "Wavy_NZ_CustomTrialsMyPeePeeBurns", function()
	nzTrials:NewTrial("wavytrial_1", {
		name = "Kill 40 zombies with melee while Insta-Kill is active",
		start = function()
			if CLIENT then return end
			hook.Add("OnZombieKilled", "nz.wavytrial_1", function(ent, dmginfo)
				local ply = dmginfo:GetAttacker()
				if not (IsValid(ply) and ply:IsPlayer() and ply:HasTrial("wavytrial_1") and not ply:GetTrialCompleted("wavytrial_1")) then return end
	
				if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_SLASH, DMG_CLUB, DMG_CRUSH, DMG_GENERIC)) ~= 0 and nzPowerUps:IsPowerupActive("insta") then
					if not ply.wavy_trial1kills then ply.wavy_trial1kills = 0 end
					ply.wavy_trial1kills = ply.wavy_trial1kills + 1
	
					if ply.wavy_trial1kills >= 40 then
						ply:SetTrialCompleted("wavytrial_1")
					end
				end
			end)

			return true
		end,
		reset = function()
			if CLIENT then return end
			hook.Remove("OnZombieKilled", "nz.wavytrial_1")
			for _, ply in ipairs(player.GetAll()) do
				ply.wavy_trial1kills = 0
			end

			return true
		end,
		text = function(self)
			return "Kill 40 zombies with melee while Insta-Kill is active"
		end,
	})
	nzTrials:NewTrial("wavytrial_2", {
		name = "Spin the mystery box 20 times",
		default = true,
		start = function()
			if CLIENT then return end
		
			hook.Add( "OnPlayerBuyBox", "nz.wavytrial_2", function(ply, gun)
		
				if not (IsValid(ply) and ply:IsPlayer() and ply:HasTrial("wavytrial_2") and not ply:GetTrialCompleted("wavytrial_2")) then return end
				if not ply.wavy_trial2spins then ply.wavy_trial2spins = 0 end
					ply.wavy_trial2spins = ply.wavy_trial2spins + 1
				
				if ply.wavy_trial2spins >= 20 then
					ply:SetTrialCompleted("wavytrial_2")
				end
		
			end)
	
			return true
		end,
		reset = function()
			if CLIENT then return end
		
			hook.Remove("OnPlayerBuyBox", "nz.wavytrial_2")
			for _, ply in ipairs(player.GetAll()) do
				ply.wavy_trial2spins = 0
			end

			return true
		end,
		text = function(self)
			return "Spin the Mystery Box 20 times"
		end,
	})
	nzTrials:NewTrial("wavytrial_3", {
		name = "Survive one round past round 20 without having juggernog",
		default = true,
		start = function()
			if CLIENT then return end
			
			hook.Add( "OnPlayerGetPerk", "nz.wavytrial_3", function( ply, id )
				if nzRound:GetNumber() > 19 and id == "jugg" and ply:HasTrial("wavytrial_3") and not ply:GetTrialCompleted("wavytrial_3") then
					ply:EmitSound("nzr/2023/trials/failed.wav", 75, 100, 1, CHAN_STATIC)
				end
			end)
			
			hook.Add("PlayerDowned", "nz.wavytrial_3", function(ply)
				if ply:HasTrial("wavytrial_3") and not ply:GetTrialCompleted("wavytrial_3") then
					ply.wavytrial3round = 0
				end
			end)
		
			hook.Add("OnRoundStart", "nz.wavytrial_3", function()
		
				if nzRound:GetNumber() <= 19 then return end
				
			for _, ply in ipairs(player.GetAll()) do
				if ply:HasTrial("wavytrial_3") and not ply:GetTrialCompleted("wavytrial_3") then
				if not (IsValid(ply) and ply:IsPlayer() and ply:HasTrial("wavytrial_3") and not ply:GetTrialCompleted("wavytrial_3")) then continue end
				if ply:HasPerk("jugg") then
					ply:EmitSound("nzr/2023/trials/failed.wav", 75, 100, 1, CHAN_STATIC)
				continue end
				if ply.wavytrial3round and ply.wavytrial3round >= 1 then
					ply:SetTrialCompleted("wavytrial_3")
				end
					if not ply.wavytrial3round then ply.wavytrial3round = 0 end
					ply.wavytrial3round = ply.wavytrial3round + 1
				end
			end
			end)
	
			return true
		end,
		reset = function()
			if CLIENT then return end
		
			hook.Remove("OnPlayerGetPerk", "nz.wavytrial_3")
			hook.Remove("OnRoundStart", "nz.wavytrial_3")
			hook.Remove("PlayerDowned", "nz.wavytrial_3")
			for _, ply in ipairs(player.GetAll()) do
				ply.wavytrial3round = 0
			end

			return true
		end,
		text = function(self)
			return "Survive one round past Round 20 without having Juggernog"
		end,
	})
	nzTrials:NewTrial("wavytrial_4", {
		name = "Avoid getting hit by a zombie for one round after round 16",
		default = true,
		start = function()
			if CLIENT then return end
			
		hook.Add("PlayerDowned", "nz.wavytrial_4", function(ply)
			if ply:HasTrial("wavytrial_4") and not ply:GetTrialCompleted("wavytrial_4") and ply.wavytrial4round and ply.wavytrial4round > 0 and nzRound:GetNumber() > 16 then
				ply.wavytrial4round = 0
				ply:EmitSound("nzr/2023/trials/failed.wav", 75, 100, 1, CHAN_STATIC)
			end
		end)
			
		hook.Add("PostEntityTakeDamage", "nz.wavytrial_4", function(ply, dmginfo, took)
			if took and ply:IsPlayer() and ply:HasTrial("wavytrial_4") and not ply:GetTrialCompleted("wavytrial_4") and ply.wavytrial4round and ply.wavytrial4round > 0 and nzRound:GetNumber() > 16 then
				local ent = dmginfo:GetAttacker()
				if IsValid(ent) and ent:IsValidZombie() then
					ply.wavytrial4round = 0
					ply:EmitSound("nzr/2023/trials/failed.wav", 75, 100, 1, CHAN_STATIC)
				end
			end
		end)
		
		hook.Add("OnRoundStart", "nz.wavytrial_4", function()
		
			if nzRound:GetNumber() <= 16 then return end
			
			for _, ply in ipairs(player.GetAll()) do
			if ply:HasTrial("wavytrial_4") and not ply:GetTrialCompleted("wavytrial_4") then
			if ply.wavytrial4round and ply.wavytrial4round >= 1 then
				ply:SetTrialCompleted("wavytrial_4")
			end
				if not ply.wavytrial4round then ply.wavytrial4round = 0 end
				ply.wavytrial4round = ply.wavytrial4round + 1
			end	
			end
		end)
	
			return true
		end,
		reset = function()
			if CLIENT then return end
		
			hook.Remove("PostEntityTakeDamage", "nz.wavytrial_4")
			hook.Remove("OnRoundStart", "nz.wavytrial_4")
			hook.Remove("PlayerDowned", "nz.wavytrial_4")
			for _, ply in ipairs(player.GetAll()) do
				ply.wavytrial4round = 0
			end

			return true
		end,
		text = function(self)
			return "Avoid getting hit by a zombie for one round after Round 16"
		end,
	})
	end)
end

--sounds lol

TFA.AddSound("NZ.ShatterBlast.Exp", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "wavy_fx/wpn_frag_exp.wav",")")
TFA.AddSound("NZ.ShatterBlast.Deep", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "wavy_fx/wpn_frag_exp_deep_01.wav",")")
TFA.AddSound("NZ.ShatterBlast.Low", CHAN_STATIC, 1, SNDLVL_GUNFIRE, 100, "wavy_fx/wpn_frag_exp_low_04.wav",")")

TFA.AddWeaponSound("TFA_BO3.SEMTEX.PULLPIN", "weapons/bo3/semtex/semtex_pin_pull.wav")

TFA.AddWeaponSound("TFA_BO3.IW_FRAG.PIN", {"weapons/bo3/mw_frag/h1_wpn_frag_pinpull_01.mp3","weapons/bo3/mw_frag/h1_wpn_frag_pinpull_02.mp3","weapons/bo3/mw_frag/h1_wpn_frag_pinpull_03.mp3"})
TFA.AddWeaponSound("TFA_BO3.IW_FRAG.THROW", {"weapons/bo3/mw_frag/h1_wpn_frag_throw_01.mp3","weapons/bo3/mw_frag/h1_wpn_frag_throw_02.mp3"})

TFA.AddWeaponSound("TFA_RD.SWAT_KNIFE.SWING", {"weapons/rainy_death/swat_knife/fly_knife_swing_00.mp3","weapons/rainy_death/swat_knife/fly_knife_swing_01.mp3","weapons/rainy_death/swat_knife/fly_knife_swing_02.mp3"})
TFA.AddWeaponSound("TFA_RD.SWAT_KNIFE.STAB", {"weapons/rainy_death/swat_knife/wpn_knife_blade_stab_00.mp3","weapons/rainy_death/swat_knife/wpn_knife_blade_stab_01.mp3","weapons/rainy_death/swat_knife/wpn_knife_blade_stab_02.mp3","weapons/rainy_death/swat_knife/wpn_knife_blade_stab_03.mp3"})