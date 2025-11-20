local nzombies = engine.ActiveGamemode() == "nzombies"

local DontBleed = {
	[BLOOD_COLOR_MECH] = true,
	[DONT_BLEED] = true,
}

if not TFA.Enum.STATUS_OVERHEAT then
	TFA.AddStatus("OVERHEAT")

	TFA.Enum.HUDDisabledStatus[TFA.Enum.STATUS_OVERHEAT] = true
end

if not TFA.Enum.STATUS_C4_DETONATE then
	TFA.AddStatus("C4_DETONATE")
end

if not TFA.Enum.STATUS_SWORD_SLAM_IN then
	TFA.AddStatus("SWORD_SLAM_IN")
end

if not TFA.Enum.STATUS_SWORD_SLAM_OUT then
	TFA.AddStatus("SWORD_SLAM_OUT")
end

if not TFA.Enum.ChargeStatus then
	TFA.Enum.ChargeStatus = {}
end

if not TFA.Enum.STATUS_CHARGE_UP then
	TFA.AddStatus("CHARGE_UP")

	TFA.Enum.ChargeStatus[TFA.Enum.STATUS_CHARGE_UP] = true
	TFA.Enum.ReadyStatus[TFA.Enum.STATUS_CHARGE_UP] = true
	TFA.Enum.IronStatus[TFA.Enum.STATUS_CHARGE_UP] = true
end

if not TFA.Enum.STATUS_CHARGE_DOWN then
	TFA.AddStatus("CHARGE_DOWN")

	TFA.Enum.ChargeStatus[TFA.Enum.STATUS_CHARGE_DOWN] = true
	TFA.Enum.IronStatus[TFA.Enum.STATUS_CHARGE_DOWN] = true
end

if matproxy then
	local paralyzerVec = Vector(0.3, 0.3, 1)
	local paralyzer2Vec = Vector(0.15, 1, 0.2)
	local overheatVec = Vector(1, 0.05, 0.05)

	matproxy.Add({
		name = "ParalyzerGlow",
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
		end,
		bind = function(self, mat, ent)
			local owner

			if (IsValid(ent)) then
				owner = ent:GetOwner()

				if not IsValid(owner) then
					owner = ent:GetParent()
				end

				if IsValid(owner) and owner:IsWeapon() then
					owner = owner:GetOwner() or owner:GetOwner()
				end

				if not (IsValid(owner) and owner:IsPlayer()) then
					owner = GetViewEntity()
				end
			else
				owner = GetViewEntity()
			end
			if (not IsValid(owner) or not owner:IsPlayer()) then return end

			local wep = owner:GetActiveWeapon()
			if not IsValid(wep) or not wep.GetGlowRatio then return end

			mat:SetVector(self.ResultTo, LerpVector(wep:GetGlowRatio(), (wep.Ispackapunched and (wep.UpgradedGlow or paralyzer2Vec) or (wep.DefaultGlow or paralyzerVec)), overheatVec))
		end
	})

	matproxy.Add({
		name = "CauterizerFin1",
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
		end,
		bind = function(self, mat, ent)
			local owner

			if (IsValid(ent)) then
				owner = ent:GetOwner()

				if not IsValid(owner) then
					owner = ent:GetParent()
				end

				if IsValid(owner) and owner:IsWeapon() then
					owner = owner:GetOwner() or owner:GetOwner()
				end

				if not (IsValid(owner) and owner:IsPlayer()) then
					owner = GetViewEntity()
				end
			else
				owner = GetViewEntity()
			end
			if (not IsValid(owner) or not owner:IsPlayer()) then return end

			local wep = owner:GetActiveWeapon()
			if not IsValid(ent) or not wep.glow1 then return end

			mat:SetFloat(self.ResultTo, wep.glow1)
		end
	})

	matproxy.Add({
		name = "CauterizerFin2",
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
		end,
		bind = function(self, mat, ent)
			local owner

			if (IsValid(ent)) then
				owner = ent:GetOwner()

				if not IsValid(owner) then
					owner = ent:GetParent()
				end

				if IsValid(owner) and owner:IsWeapon() then
					owner = owner:GetOwner() or owner:GetOwner()
				end

				if not (IsValid(owner) and owner:IsPlayer()) then
					owner = GetViewEntity()
				end
			else
				owner = GetViewEntity()
			end
			if (not IsValid(owner) or not owner:IsPlayer()) then return end

			local wep = owner:GetActiveWeapon()
			if not IsValid(ent) or not wep.glow2 then return end

			mat:SetFloat(self.ResultTo, wep.glow2)
		end
	})

	matproxy.Add({
		name = "CauterizerFin3",
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
		end,
		bind = function(self, mat, ent)
			local owner

			if (IsValid(ent)) then
				owner = ent:GetOwner()

				if not IsValid(owner) then
					owner = ent:GetParent()
				end

				if IsValid(owner) and owner:IsWeapon() then
					owner = owner:GetOwner() or owner:GetOwner()
				end

				if not (IsValid(owner) and owner:IsPlayer()) then
					owner = GetViewEntity()
				end
			else
				owner = GetViewEntity()
			end
			if (not IsValid(owner) or not owner:IsPlayer()) then return end

			local wep = owner:GetActiveWeapon()
			if not IsValid(wep) or not wep.glow3 then return end

			mat:SetFloat(self.ResultTo, wep.glow3)
		end
	})

	matproxy.Add({
		name = "CauterizerFin4",
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
		end,
		bind = function(self, mat, ent)
			local owner

			if (IsValid(ent)) then
				owner = ent:GetOwner()

				if not IsValid(owner) then
					owner = ent:GetParent()
				end

				if IsValid(owner) and owner:IsWeapon() then
					owner = owner:GetOwner() or owner:GetOwner()
				end

				if not (IsValid(owner) and owner:IsPlayer()) then
					owner = GetViewEntity()
				end
			else
				owner = GetViewEntity()
			end
			if (not IsValid(owner) or not owner:IsPlayer()) then return end

			local wep = owner:GetActiveWeapon()
			if not IsValid(wep) or not wep.glow4 then return end

			mat:SetFloat(self.ResultTo, wep.glow4)
		end
	})

	matproxy.Add({
		name = "CauterizerGlow",
		init = function(self, mat, values)
			self.ResultTo = values.resultvar
		end,
		bind = function(self, mat, ent)
			local owner

			if (IsValid(ent)) then
				owner = ent:GetOwner()

				if not IsValid(owner) then
					owner = ent:GetParent()
				end

				if IsValid(owner) and owner:IsWeapon() then
					owner = owner:GetOwner() or owner:GetOwner()
				end

				if not (IsValid(owner) and owner:IsPlayer()) then
					owner = GetViewEntity()
				end
			else
				owner = GetViewEntity()
			end
			if (not IsValid(owner) or not owner:IsPlayer()) then return end

			local wep = owner:GetActiveWeapon()
			if not IsValid(wep) or not wep.GetGlowRatio then return end
			
			mat:SetFloat(self.ResultTo, wep:GetGlowRatio())
		end
	})
end

local function CreateReplConVar(cvarname, cvarvalue, description, ...)
	return CreateConVar(cvarname, cvarvalue, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, description, ...)
end -- replicated only on clients, archive/notify on server

if GetConVar("sv_waw_crossbow_pin_duration") == nil then
	CreateReplConVar("sv_waw_crossbow_pin_duration", 0.25, "How long, in seconds, pinned ragdolls will stay attached to the crossbow bolt mid flight if the bolt doesn't hit a wall. Absolutely tanks performance with serverside ragdolls the longer they stay attached, Default is 0.25", 0, 10)
end

if GetConVar("sv_waw_crossbow_pinning") == nil then
	CreateReplConVar("sv_waw_crossbow_pinning", 1, "Enable or disable pinning serverside ragdolls. Default is 1", 0, 1)
end

if GetConVar("cl_waw_crossbow_pin_duration") == nil then
	CreateClientConVar("cl_waw_crossbow_pin_duration", 0.25, true, false, "How long, in seconds, pinned ragdolls will stay attached to the crossbow bolt mid flight if the bolt doesn't hit a wall. Looks bad and jank the longer the ragdoll stays attached, Default is 0.25", 0, 10)
end

if GetConVar("cl_waw_crossbow_pinning") == nil then
	CreateClientConVar("cl_waw_crossbow_pinning", 1, true, false, "Enable or disable pinning clientside ragdolls. Default is 1", 0, 1)
end

if SERVER then
	hook.Add("EntityTakeDamage", "FOXMISC.TFA.WW.TakeDamage", function(ent, dmginfo)
		local attacker = dmginfo:GetAttacker()
		if not IsValid(attacker) then return end

		if attacker:IsPlayer() and not ent:IsPlayer() then
			local changed = attacker:BO3IsTransfurPAP()
			if changed and not (ent.NZBossType or ent.IsMooBossZombie) then
				dmginfo:SetDamage(ent:Health() + 666)
				dmginfo:SetMaxDamage(ent:Health() + 666)
			end

			if nzombies and IsValid(attacker:GetNW2Entity("BO3.VrillLogic")) then
				local assist = attacker:GetNW2Entity("BO3.VrillLogic"):GetAssist()
				if IsValid(assist) and assist:IsPlayer() then
					assist:GivePoints(changed and 30 or 5, nil, true)
				end
			end
		end

		if ent:IsPlayer() and ent:WAWIsPlasmaEnraged() then
			if not attacker:IsPlayer() and dmginfo:IsDamageType(DMG_CRUSH + DMG_SLASH + DMG_CLUB) and ent:GetPos():DistToSqr(attacker:GetPos()) <= 6400 then
				local domechsparks = false
				if attacker.GetBloodColor then
					attacker.BloodColor = attacker:GetBloodColor()
					if attacker.BloodColor == DONT_BLEED then
						attacker.b_stopdontbleed = true
					elseif attacker.BloodColor == BLOOD_COLOR_MECH then
						domechsparks = true
					end
				end

				local fx = EffectData()
				fx:SetEntity(attacker)
				fx:SetOrigin(attacker:GetPos())
				util.Effect("HelicopterMegaBomb", fx)

				if domechsparks then
					fx:SetOrigin(attacker:WorldSpaceCenter())
					fx:SetScale(24)
					util.Effect("cball_explode", fx)
				end

				attacker:EmitSound("TFA_WAW_PLASMANADE.ZombExpl")

				local damage = attacker:Health() + 666
				if nzombies and (attacker.NZBossType or attacker.IsMooBossZombie or string.find(attacker:GetClass(), "zombie_boss")) then
					damage = math.max(1200, attacker:GetMaxHealth()/6)
					dmginfo:SetDamagePosition(ent:EyePos())
				else
					if not attacker.b_stopdontbleed then
						ParticleEffect(attacker.BloodColor and TFA.BO3BloodColor[attacker.BloodColor] or "bo3_annihilator_blood", attacker:WorldSpaceCenter(), angle_zero)
					end
					attacker:EmitSound("TFA_BO3_ANNIHILATOR.Gib")
					attacker:SetHealth(1)
				end

				if nzombies and attacker:IsValidZombie() then
					dmginfo:SetDamage(damage)
					dmginfo:SetAttacker(ent)
					dmginfo:SetDamageForce((attacker:GetPos() - ent:GetPos())*24000)
					dmginfo:SetDamageType(DMG_MISSILEDEFENSE)

					attacker:TakeDamageInfo(dmginfo)
				else
					attacker:TakeDamage(damage, ent)
				end

				util.Decal("Scorch", attacker:GetPos() - vector_up, attacker:GetPos() + vector_up)
			end

			local hitpos = dmginfo:GetDamagePosition()
			if hitpos == vector_origin then
				hitpos = attacker:WorldSpaceCenter()
			end

			ParticleEffect("waw_plasmanade_hit", hitpos, angle_zero)

			dmginfo:SetDamage(0)
			dmginfo:ScaleDamage(0)
			return true
		end
	end)

	hook.Add("CreateEntityRagdoll", "FOXMISC.TFA.WW.RagdollServer", function(ent, ragdoll)
		if not IsValid(ent) or not IsValid(ragdoll) then return end

		if ent.SpikemoreSpikes and not table.IsEmpty(ent.SpikemoreSpikes) then
			for k, v in pairs(ent.SpikemoreSpikes) do
				if v.TargetEnt then
					v:SetOwner(ragdoll)
					v:TargetEnt(false)
				end
			end
		end

		if IsValid(ragdoll) and ent.CrossbowKilled then
			ent.RagdollEntity = ragdoll
		end

		if ent:GetNW2Bool("JetgunShreaded", false) then
			local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
			ParticleEffect(cyborg and "bo2_jetgun_shread_blue" or "bo2_jetgun_shread", ent:WorldSpaceCenter(), Angle(0,0,0))
			ent:EmitSound("TFA_BO2_JETGUN.Gib")
			if ent:IsPlayer() then
				ragdoll = ent:GetRagdollEntity()
			end
			SafeRemoveEntity(ragdoll)
		end

		if ent:GetNW2Int("Cel3Killed", 0) > 0 then
			ParticleEffectAttach(ent:GetNW2Int("Cel3Killed", 0) > 1 and "aw_cel3_shock_2" or "aw_cel3_shock", PATTACH_ABSORIGIN, ragdoll, 0)
		end

		if ent:GetNW2Int("PumpkinKilled", 0) > 0 then
			ParticleEffectAttach(ent:GetNW2Int("PumpkinKilled", 0) > 1 and "waw_pumpkingun_pop_2" or "waw_pumpkingun_pop", PATTACH_POINT_FOLLOW, ragdoll, 2)
			SafeRemoveEntityDelayed(ragdoll, engine.TickInterval())
		end

		if ent:GetNW2Bool("IceLazerPop", false) then
			ent:StopParticles()
			local num = math.random(5)
			timer.Simple(engine.TickInterval()*num, function()
				if not IsValid(ent) then return end
				ent:EmitSound("TFA_BO3_GENERIC.Gib")
				ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
			end)
			ParticleEffectAttach("bo1_icelazer_pop", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
		end

		if ent:GetNW2Int("Vapor1zed", 0) > 0 then
			ParticleEffect(ent:GetNW2Int("Vapor1zed") > 1 and "waw_v11_vaporize_2" or "waw_v11_vaporize", (ent:WorldSpaceCenter() + ent:OBBCenter()*0.2), angle_zero)
			if ent:IsPlayer() then
				ragdoll = ent:GetRagdollEntity()
			end
			SafeRemoveEntity(ragdoll)
		end

		if ent:GetNW2Int("NukeBurning", 0) > 0 then
			ParticleEffectAttach(ent:GetNW2Int("NukeBurning", 0) > 1 and "bo3_cng_zomb_2" or "bo3_cng_zomb", PATTACH_POINT_FOLLOW, ragdoll, 0)
			timer.Simple(math.Rand(4,8), function()
				if not IsValid(ragdoll) then return end
				ragdoll:StopParticles()
			end)
		end

		if ent:GetNW2Bool("HellfireKilled") then
			ParticleEffectAttach("bo1_hellfire_volcano", PATTACH_POINT_FOLLOW, ragdoll, 2)
		end

		if ent:GetNW2String("C4KillEffect", "") ~= "" then
			ParticleEffectAttach(ent:GetNW2String("C4KillEffect"), PATTACH_POINT_FOLLOW, ragdoll, 2)
		end

		if ent:GetNW2Bool("TeslaGatKilled") then
			ParticleEffectAttach("bo2_teslagat_shock", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
		end

		if ent:WAWIsXrayInfected() or ent:WAWIsXmasInfected() then
			ragdoll:Remove()
		end

		if ent:GetNW2Int("MolotovKilld", 0) > 0 then
			ent:StopParticles()
			ParticleEffectAttach(ent:GetNW2Int("MolotovKilld", 0) > 1 and "bo1_molotov_zomb_2" or "bo1_molotov_zomb", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
			timer.Simple(12, function()
				if not IsValid(ragdoll) then return end
				ragdoll:StopParticles()
			end)
		end
	end)

	hook.Add("PlayerSpawn", "FOXMISC.TFA.WW.PlayerSpawn", function(ply, trans)
		if not IsValid(ply) then return end

		if ply:GetNW2String("C4KillEffect", "") ~= "" then
			ply:SetNW2String("C4KillEffect", "")
		end
		if ply:GetNW2Bool("JetgunShreaded") then
			ply:SetNW2Bool("JetgunShreaded", false)
		end
		if ply:GetNW2Bool("IceLazerPop") then
			ply:SetNW2Bool("IceLazerPop", false)
		end
		if ply:GetNW2Bool("HellfireKilled") then
			ply:SetNW2Bool("HellfireKilled", false)
		end
		if ply:GetNW2Bool("TeslaGatKilled") then
			ply:SetNW2Bool("TeslaGatKilled", false)
		end
		if ply:GetNW2Int("Cel3Killed", 0) > 0 then
			ply:SetNW2Int("Cel3Killed", 0)
		end
		if ply:GetNW2Int("PumpkinKilled", 0) > 0 then
			ply:SetNW2Int("PumpkinKilled", 0)
		end
		if ply:GetNW2Int("Vapor1zed", 0) > 0 then
			ply:SetNW2Int("Vapor1zed", 0)
		end
		if ply.NukeGunShocked then
			ply.NukeGunShocked = nil
		end
	end)

	hook.Add("OnNPCKilled", "FOXMISC.TFA.WW.KillBool", function(ent, attacker, inflictor)
		if not IsValid(ent) then return end
		if not IsValid(inflictor) then return end

		// Achievement
		if IsValid(attacker) and attacker:IsPlayer() and inflictor:GetClass() == "tfa_aw_3prong" then
			local vecToPlayer = (ent:GetPos() - attacker:GetPos()):GetNormalized()

			// check if entity is outside player fov, thank you roblox dev forum
			if math.deg(math.acos(attacker:GetAimVector():Dot(vecToPlayer))) > attacker:GetFOV() then
				if not attacker.level_trident_backshots then attacker.level_trident_backshots = 0 end

				attacker.level_trident_backshots = attacker.level_trident_backshots + 1
				if attacker.level_trident_backshots == 100 then
					if not attacker.awtridentachievement then
						TFA.BO3GiveAchievement("Trick Shot", "vgui/overlay/achievment/Trick_Shot_aw.png", attacker, 3)
						attacker.awtridentachievement = true
					end
				end
			end
		end

		if ent.CrossbowAttacker and IsValid(ent.CrossbowAttacker) then
			ent.CrossbowKilled = true
		end

		if ent.GravitySpiked and IsValid(attacker) and ent:GetPos():DistToSqr(attacker:GetPos()) < 100^2 then
			ent:SetNW2Bool("AnniKilled", true)
		end

		if inflictor:GetClass() == "tfa_aw_cel3" then
			ent:SetNW2Int("Cel3Killed", inflictor.Ispackapunched and 2 or 1)
		end

		if inflictor:GetClass() == "tfa_bo2_teslagat" then
			ent:SetNW2Bool("TeslaGatKilled", true)
		end

		if inflictor:GetClass() == "tfa_waw_pumpkingun" then
			ent:SetNW2Int("PumpkinKilled", inflictor.Ispackapunched and 2 or 1)
		end

		if inflictor.C4KillEffect and inflictor.Ispackapunched then
			ent:SetNW2String("C4KillEffect", inflictor.C4KillEffect)
		end

		if inflictor:GetClass() == "tfa_waw_handcannon" then
			if ent.GetBloodColor then
				if !DontBleed[ent:GetBloodColor()] then
					ent:SetNW2Bool("AnniKilled", true)
				end
			else
				ent:SetNW2Bool("AnniKilled", true)
			end
		end

		if inflictor:GetClass() == "tfa_bo3_hype" then
			ent:SetNW2Bool("JetgunShreaded", true)
		end

		if ent.NukeGunShocked and !ent.NukeGunTossed then
			ent:StopParticles()
			ent:EmitSound("TFA_BO3_WAFFE.Zap")
			ent:SetNW2Int("WunderWaffeld", 1)
		end

		if inflictor:GetClass() == "tfa_bo2_jetgun" then
			local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
			if cyborg then
				inflictor:CallOnClient("RenderGrindParticles", "true")
			else
				inflictor:CallOnClient("RenderGrindParticles", "false")
			end

			local fx = EffectData()
			fx:SetEntity(inflictor)
			fx:SetAttachment(2)
			fx:SetFlags(cyborg and 1 or 0)

			local filter = RecipientFilter()
			filter:AddPVS(attacker:GetShootPos())
			if IsValid(attacker) then
				filter:RemovePlayer(attacker)
			end

			if filter:GetCount() > 0 then
				util.Effect("tfa_bo2_jetgun_grind", fx, true, filter)
			end
			ent:SetNW2Bool("JetgunShreaded", true)
		end
	end)

	hook.Add("PlayerDeath", "FOXMISC.TFA.WW.KillBool", function(ent, inflictor, attacker)
		if not IsValid(ent) then return end
		if not IsValid(inflictor) then return end

		if inflictor:GetClass() == "tfa_aw_cel3" then
			ent:SetNW2Int("Cel3Killed", inflictor.Ispackapunched and 2 or 1)
		end
		if inflictor:GetClass() == "tfa_bo2_teslagat" then
			ent:SetNW2Bool("TeslaGatKilled", true)
		end
		if inflictor:GetClass() == "tfa_waw_pumpkingun" then
			ent:SetNW2Int("PumpkinKilled", inflictor.Ispackapunched and 2 or 1)
		end
		if inflictor.C4KillEffect and inflictor.Ispackapunched then
			ent:SetNW2String("C4KillEffect", inflictor.C4KillEffect)
		end
		if inflictor:GetClass() == "tfa_waw_handcannon" then
			if ent.GetBloodColor then
				if !DontBleed[ent:GetBloodColor()] then
					ent:SetNW2Bool("AnniKilled", true)
				end
			else
				ent:SetNW2Bool("AnniKilled", true)
			end
		end
		if inflictor:GetClass() == "tfa_bo3_hype" then
			ent:SetNW2Bool("JetgunShreaded", true)
		end
		if inflictor:GetClass() == "tfa_bo2_jetgun" then
			local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
			if cyborg then
				inflictor:CallOnClient("RenderGrindParticles", "true")
			else
				inflictor:CallOnClient("RenderGrindParticles", "false")
			end

			local fx = EffectData()
			fx:SetEntity(inflictor)
			fx:SetAttachment(2)
			fx:SetFlags(cyborg and 1 or 0)

			local filter = RecipientFilter()
			filter:AddPVS(attacker:GetShootPos())
			if IsValid(attacker) then
				filter:RemovePlayer(attacker)
			end

			if filter:GetCount() > 0 then
				util.Effect("tfa_bo2_jetgun_grind", fx, true, filter)
			end
			ent:SetNW2Bool("JetgunShreaded", true)
		end
	end)
end

hook.Add("SetupMove", "FOXMISC.TFA.WW.SetupMove", function(ply, mv, cmd)
	if not nzombies or (nzombies and ply:GetNotDowned()) then
		local wep = ply:GetActiveWeapon()

		if ply:BO3IsFlying() and mv:KeyDown(IN_JUMP) and not ply:IsOnGround() then
			mv:SetVelocity(mv:GetVelocity() + vector_up*8)
		end
	end
end)

if nzombies then
	if SERVER then
		util.AddNetworkString("nz_c4_detonate")

		local function DetonateC4(ply)
			if not IsValid(ply) then return end

			local gun = ply:GetSpecialWeaponFromCategory("trap")
			if not IsValid(gun) or not gun.IsC4 then return end

			timer.Simple(0.1, function()
				if not IsValid(ply) then return end
				if not ply.ActiveC4s then return end

				for k, v in pairs(ply.ActiveC4s) do
					timer.Simple(.05 * k, function()
						if IsValid(v) then
							v:Explode()
						end
					end)
				end
			end)

			if gun.NZDisplayDeploy then
				local wep = ply:GetActiveWeapon()
				if IsValid(wep) and wep.IsTFAWeapon and (!TFA.Enum.ReadyStatus[wep:GetStatus()] or wep:GetSprinting()) then
					return
				end

				ply:Give(gun.NZDisplayDeploy)
			end
		end

		net.Receive("nz_c4_detonate", function(len, ply)
			DetonateC4(ply)
		end)
	end

	hook.Add("KeyRelease", "FOXMISC.NZ.WW.DetonateCL", function(ply, key)
		if not IsValid(ply) then return end

		if key == IN_USE then
			if not ply.ActiveC4s or table.IsEmpty(ply.ActiveC4s) then return end

			local gun = ply:GetSpecialWeaponFromCategory("trap")
			if not IsValid(gun) or not gun.IsC4 then return end

			if ply.LastUsePressed and ply.LastUsePressed + 0.3 > CurTime() then
				local wep = ply:GetActiveWeapon()
				if IsValid(wep) and wep == gun then
					if game.SinglePlayer() or IsFirstTimePredicted() then
						wep:SecondaryAttack()
					end
					return
				end

				if CLIENT and not game.SinglePlayer() then
					net.Start("nz_c4_detonate")
					net.SendToServer()
				elseif SERVER and game.SinglePlayer() then
					ply:EmitSound("TFA_BO1_C4.Trigger")
					timer.Simple(0.1, function()
						if not IsValid(ply) then return end
						if not ply.ActiveC4s then return end

						for k, v in pairs(ply.ActiveC4s) do
							timer.Simple(.05 * k, function()
								if IsValid(v) then
									v:Explode()
								end
							end)
						end
					end)

					if gun.NZDisplayDeploy then
						if IsValid(wep) then
							if wep.IsTFAWeapon and (!TFA.Enum.ReadyStatus[wep:GetStatus()] or wep:GetSprinting()) then
								return
							end
							if wep:IsSpecial() then
								return
							end
						end

						ply:Give(gun.NZDisplayDeploy)
					end
				end
			end
			ply.LastUsePressed = CurTime()
		end
	end)
end

hook.Add("StartCommand", "FOXMISC.TFA.WW.StartCMD", function(ply, cmd)
	if not nzombies or (nzombies and ply:GetNotDowned()) then
		if ply:BO3IsFlying() and not ply:IsOnGround() then
			cmd:RemoveKey(IN_SPEED)
			cmd:RemoveKey(IN_DUCK)
		end
	end
end)

if nzombies then
	hook.Add("PlayerSwitchWeapon", "FOXMISC.NZ.SWITCH_WEP", function(ply, oldWep, newWep)
		if not IsValid(ply) or not IsValid(oldWep) then return end

		if newWep.IsTFAWeapon and newWep.NZSpecialCategory == "trap" and newWep:GetPrimaryAmmoType() > 0 and not newWep.NZTrapSwitchEmpty then
			if newWep:Clip1() < newWep:GetStatL("Primary.ClipSize") and ply:GetAmmoCount(newWep:GetPrimaryAmmoType()) <= 0 then
				return true
			end
		end
	end)

	/*hook.Add("OnPlayerBuy", "FOXMISC.NZ.WW.NoPap", function(ply, amount, ent, _)
		if not nZSTORM and IsValid(ply) and IsValid(ent) and ent:GetClass() == "perk_machine" and ent:GetPerkID() == "pap" then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep.NZNoPap then
				return true
			end
		end
	end)*/

	if GetConVar("nz_difficulty_max_placeables") == nil then
		CreateReplConVar("nz_difficulty_max_placeables", "8", "Max amount of placed explosives (Bouncing Betty, Claymore, etc.) a player can have down. Default is 8.", 1, 1024)
	end

	hook.Add("InitPostEntity", "FOXMISC.NZ.WW.RegisterSpecials", function()
		nzSpecialWeapons:AddGrenade("tfa_waw_ubernade", 4, false, 0.6, false, 0.4)
		nzSpecialWeapons:AddGrenade("tfa_waw_abnade", 4, false, 0.6, false, 0.4)
		nzSpecialWeapons:AddGrenade("tfa_waw_mortar", 4, false, 0.6, false, 0.4)

		nzSpecialWeapons:AddSpecialGrenade("tfa_bo1_spikemore", 2, false, 1.7, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_waw_bbetty", 2, false, 1.2, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_bo2_beartrap", 3, false, 1.7, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_bo1_molotov", 3, false, 1.65, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_bo2_tomahawk", 1, false, 0.4, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_bo2_hunterkiller", 3, false, 1.2, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_waw_teslanade", 3, false, 1.2, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_waw_plasmanade", 1, false, 0.6, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_waw_hamrhead", 3, false, 1.2, false, 0.4)

		nzSpecialWeapons:AddSpecialGrenade("tfa_aw_distraction_drone", 2, false, 0.4, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_aw_porternade", 2, false, 0.4, false, 0.4)
		nzSpecialWeapons:AddSpecialGrenade("tfa_aw_nanoswarm", 2, false, 0.4, false, 0.4)

		nzSpecialWeapons:AddDisplay("nz_bo2_tomahawk_flourish", false, function(wep)
			return SERVER and (wep.nzDeployTime + 1.34 < CurTime())
		end)
		nzSpecialWeapons:AddDisplay("nz_bo1_c4_detonate", false, function(wep)
			return SERVER and (wep.nzDeployTime + 0.84 < CurTime())
		end)
		nzSpecialWeapons:AddDisplay("nz_bo2_c4_detonate", false, function(wep)
			return SERVER and (wep.nzDeployTime + 0.54 < CurTime())
		end)

		nzBuilds:NewBuildable("waw_hl2crossbow", {
			name = "Resistance Crossbow",
			model = "models/weapons/w_crossbow.mdl",
			weapon = "tfa_waw_hl2crossbow",
			boxweapon = true,
			hudicon = Material("vgui/icon/W_crossbow.png", "smooth unlitgeneric"),
			pos = Vector(6,0,46),
			ang = Angle(0,90,0),
			parts = {
				[1] = {
					id = "Crossbow Bolt", 
					mdl = "models/weapons/tfa_waw/hl2_crossbow/crossbow_part_01.mdl"
				},
				[2] = {
					id = "Crossbow Limb", 
					mdl = "models/weapons/tfa_waw/hl2_crossbow/crossbow_part_02.mdl"
				},
				[3] = {
					id = "Crossbow Barrel", 
					mdl = "models/weapons/tfa_waw/hl2_crossbow/crossbow_part_03.mdl"
				},
			},
		})
	end)

	if SERVER then
		hook.Add("FindUseEntity", "FOXMISC.NZ.WW.FakeUser", function(ply, ent)
			if nzEnemies and nzEnemies.Updated then
				hook.Remove("FindUseEntity", "FOXMISC.NZ.WW.FakeUser")
			end

			if IsValid(ent) and ent:GetClass() == "perk_machine" and ent:GetPerkID() == "pap" and ply:GetShootPos():DistToSqr(ply:GetEyeTrace().HitPos) < 10000 then
				local wep = ply:GetActiveWeapon()
				if wep:IsSpecial() and wep.NZSpecialPAP then
					if wep:HasNZModifier("pap") then
						ply.LastEquipmentClip1 = wep:Clip1()
						ply.LastEquipmentClip2 = wep:Clip2()
						ply.LastEquipmentAmmo = ply:GetAmmoCount(wep:GetPrimaryAmmoType())
					end
					ent:Use(ply, ply)
				end
			end
		end)

		hook.Add("OnZombieKilled", "FOXMISC.NZ.WW.KillBool", function(ent, dmginfo)
			if not IsValid(ent) then return end
			local inflictor = dmginfo:GetInflictor()
			local attacker = dmginfo:GetAttacker()

			if ent.BO1IsBurning and ent:BO1IsBurning() then
				ent:SetNW2Int("MolotovKilld", ent:GetNW2Entity("BO1.MolotovLogic"):GetUpgraded() and 2 or 1)
			end

			if not IsValid(inflictor) then return end

			if ent.GravitySpiked and IsValid(attacker) and ent:GetPos():DistToSqr(attacker) < 100^2 then
				ent:SetNW2Bool("AnniKilled", true)
			end

			// Achievement
			if IsValid(attacker) and attacker:IsPlayer() and inflictor:GetClass() == "tfa_aw_3prong" then
				local vecToPlayer = (ent:GetPos() - attacker:GetPos()):GetNormalized()

				// check if entity is outside player fov, thank you roblox dev forum
				if math.deg(math.acos(attacker:GetAimVector():Dot(vecToPlayer))) > attacker:GetFOV() then
					if not attacker.level_trident_backshots then attacker.level_trident_backshots = 0 end

					attacker.level_trident_backshots = attacker.level_trident_backshots + 1
					if attacker.level_trident_backshots == 100 then
						if not attacker.awtridentachievement then
							TFA.BO3GiveAchievement("Trick Shot", "vgui/overlay/achievment/Trick_Shot_aw.png", attacker, 3)
							attacker.awtridentachievement = true
						end
					end
				end
			end

			if ent.NukeGunShocked and !ent.NukeGunTossed then
				if bit.band(dmginfo:GetDamageType(), bit.bor(DMG_ENERGYBEAM, DMG_MISSILEDEFENSE)) ~= 0 then
					ent:StopParticles()
					ent:EmitSound("TFA_BO3_WAFFE.Zap")
					ent:SetNW2Int("WunderWaffeld", 1)
				else
					timer.Simple(0, function()
						if not IsValid(ent) then return end
						ent.NukeGunShocked = true
					end)
					ent:EmitSound("TFA_BO3_WAFFE.Zap")

					ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ent, 2)
					if ent:OnGround() then
						ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
					end
					if not ent.IsMooSpecial and not ent.IsMooBossZombie then
						ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, ent, 3)
						ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, ent, 4)
					end
				end
			end

			if inflictor:GetClass() == "tfa_bo2_teslagat" then
				ent:SetNW2Bool("TeslaGatKilled", true)
			end

			if inflictor:GetClass() == "tfa_waw_pumpkingun" then
				ent:SetNW2Int("PumpkinKilled", inflictor.Ispackapunched and 2 or 1)
			end

			if inflictor:GetClass() == "tfa_aw_cel3" then
				ent:SetNW2Int("Cel3Killed", inflictor.Ispackapunched and 2 or 1)
			end

			if inflictor:GetClass() == "tfa_waw_handcannon" then
				if ent.GetBloodColor then
					if !DontBleed[ent:GetBloodColor()] then
						ent:SetNW2Bool("AnniKilled", true)
					end
				else
					ent:SetNW2Bool("AnniKilled", true)
				end
			end

			if inflictor:GetClass() == "tfa_bo1_molotov" then
				ent:SetNW2Int("MolotovKilld", inflictor.Ispackapunched and 2 or 1)
			end

			if inflictor:GetClass() == "tfa_bo3_hype" then
				ent:SetNW2Bool("JetgunShreaded", true)
			end

			if inflictor:GetClass() == "tfa_waw_teslanade" then
				ent:SetNW2Bool("NZNoRagdoll", true)
			end

			if inflictor:GetClass() == "tfa_bo2_jetgun" and IsValid(attacker) then
				local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
				if cyborg then
					inflictor:CallOnClient("RenderGrindParticles", "true")
				else
					inflictor:CallOnClient("RenderGrindParticles", "false")
				end

				local fx = EffectData()
				fx:SetEntity(inflictor)
				fx:SetAttachment(2)
				fx:SetFlags(cyborg and 1 or 0)

				local filter = RecipientFilter()
				filter:AddPVS(attacker:GetShootPos())
				if IsValid(attacker) then
					filter:RemovePlayer(attacker)
				end

				if filter:GetCount() > 0 then
					util.Effect("tfa_bo2_jetgun_grind", fx, true, filter)
				end
				ent:SetNW2Bool("JetgunShreaded", true)
			end
		end)
	end
else
	if GetConVar("sv_tfa_miscww_max_placeables") == nil then
		CreateReplConVar("sv_tfa_miscww_max_placeables", "12", "Max amount of placed explosives a player can have active at a time. Default is 12.", 1, 1024)
	end
end

if CLIENT then
	local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")

	hook.Add("CreateClientsideRagdoll", "FOXMISC.TFA.WW.RagdollClient", function(ent, ragdoll)
		if not IsValid(ent) or not IsValid(ragdoll) then return end

		/*local ply = LocalPlayer()
		if IsValid(ply) then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep:GetClass() == "tfa_waw_hl2crossbow" and GetConVar("developer"):GetBool() then
				local mins, maxs = ragdoll:GetModelBounds()
				debugoverlay.Box(ragdoll:GetPos(), mins, maxs, 10, Color( 255, 255, 255, 10 ), true )
			end
		end*/

		if nzombies and ent:GetNW2Bool("NZNoRagdoll", false) then
			SafeRemoveEntity(ragdoll)
		end

		/*if ent.SpikemoreSpikes and not table.IsEmpty(ent.SpikemoreSpikes) then
			for k, v in pairs(ent.SpikemoreSpikes) do
				if IsValid(v) and v:GetClass() == "bo1_spikemore_spike" and v.targbone and v.posoff and v.angoff then
					local c_Model = ents.CreateClientProp()
					c_Model:SetModel("models/weapons/tfa_bo1/spikemore/spikemore_projectile.mdl")

					c_Model:SetLocalPos(v:LocalToWorld(v.posoff))
					c_Model:SetLocalAngles(v:LocalToWorldAngles(v.angoff))
					c_Model:FollowBone(ragdoll, v.targbone)

					c_Model:Spawn()

					SafeRemoveEntityDelayed(c_Model, 8)
					timer.Simple(8, function()
						if not IsValid(c_Model) then return end
						c_Model:Remove()
					end)
				end
			end
		end*/

		if ent:GetNW2Bool("JetgunShreaded", false) then
			local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
			ParticleEffect(cyborg and "bo2_jetgun_shread_blue" or "bo2_jetgun_shread", ent:WorldSpaceCenter(), Angle(0,0,0))
			ent:EmitSound("TFA_BO2_JETGUN.Gib")
			if dlight_cvar:GetBool() and DynamicLight then
				local DLight = DynamicLight(ent:EntIndex(), false)
				if DLight then
					DLight.pos = ent:WorldSpaceCenter()
					DLight.r = 255
					DLight.g = 40
					DLight.b = 30
					DLight.decay = 2000
					DLight.brightness = 2.5
					DLight.size = 300
					DLight.dietime = CurTime() + 0.2
				end
			end

			if ent:IsPlayer() then
				net.Start("TFA.BO3.REMOVERAG")
					net.WriteEntity(ent)
				net.SendToServer()
			else
				SafeRemoveEntity(ragdoll)
			end
		end

		if ent:GetNW2Bool("IceLazerPop", false) then
			ent:StopParticles()
			local num = math.random(6)
			timer.Simple(engine.TickInterval()*num, function()
				if not IsValid(ent) then return end
				ent:EmitSound("TFA_BO3_GENERIC.Gib")
				ent:EmitSound("TFA_BO3_WAFFE.Sizzle")
			end)
			ParticleEffectAttach("bo1_icelazer_pop", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
		end

		if ent:GetNW2Int("Cel3Killed", 0) > 0 then
			ParticleEffectAttach(ent:GetNW2Int("Cel3Killed", 0) > 1 and "aw_cel3_shock_2" or "aw_cel3_shock", PATTACH_ABSORIGIN, ragdoll, 0)
		end

		if ent:GetNW2Int("PumpkinKilled", 0) > 0 then
			ParticleEffectAttach(ent:GetNW2Int("PumpkinKilled", 0) > 1 and "waw_pumpkingun_pop_2" or "waw_pumpkingun_pop", PATTACH_POINT_FOLLOW, ragdoll, 2)
			if ent:IsPlayer() then
				net.Start("TFA.BO3.REMOVERAG")
					net.WriteEntity(ent)
				net.SendToServer()
			else
				SafeRemoveEntityDelayed(ragdoll, engine.TickInterval())
			end
		end

		if ent:GetNW2Int("NukeBurning", 0) > 0 then
			if nzombies and ent:IsValidZombie() then
				ent:StopParticles()
			end
			ParticleEffectAttach(ent:GetNW2Int("NukeBurning", 0) > 1 and "bo3_cng_zomb_2" or "bo3_cng_zomb", PATTACH_POINT_FOLLOW, ragdoll, 0)
			timer.Simple(math.Rand(4,8), function()
				if not IsValid(ragdoll) then return end
				ragdoll:StopParticles()
			end)
		end

		if ent:GetNW2Bool("HellfireKilled") then
			ParticleEffectAttach("bo1_hellfire_volcano", PATTACH_POINT_FOLLOW, ragdoll, 2)
		end

		if ent:GetNW2Bool("TeslaGatKilled") then
			ParticleEffectAttach("bo2_teslagat_shock", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
		end

		if ent:GetNW2String("C4KillEffect", "") ~= "" then
			ParticleEffectAttach(ent:GetNW2String("C4KillEffect"), PATTACH_POINT_FOLLOW, ragdoll, 2)
		end

		if ent:GetNW2Int("Vapor1zed", 0) > 0 then
			ParticleEffect(ent:GetNW2Int("Vapor1zed") > 1 and "waw_v11_vaporize_2" or "waw_v11_vaporize", (ent:WorldSpaceCenter() + ent:OBBCenter()*0.2), Angle(0,0,0))

			if ent:IsPlayer() then
				net.Start("TFA.BO3.REMOVERAG")
					net.WriteEntity(ent)
				net.SendToServer()
			else
				SafeRemoveEntity(ragdoll)
			end
		end

		if ent:WAWIsXrayInfected() or ent:WAWIsXmasInfected() then
			if ent:IsPlayer() then
				net.Start("TFA.BO3.REMOVERAG")
					net.WriteEntity(ent)
				net.SendToServer()
			else
				SafeRemoveEntity(ragdoll)
			end
		end

		if ent:GetNW2Int("MolotovKilld", 0) > 0 then
			ent:StopParticles()
			ParticleEffectAttach(ent:GetNW2Int("MolotovKilld", 0) > 1 and "bo1_molotov_zomb_2" or "bo1_molotov_zomb", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
			timer.Simple(12, function()
				if not IsValid(ragdoll) then return end
				ragdoll:StopParticles()
			end)
		end
	end)

	local tab = {
		["$pp_colour_addr"] = 0.2,
		["$pp_colour_addg"] = 0.05,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0.0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1.2,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}

	local redtab = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0.0,
		["$pp_colour_contrast"] = 1.0,
		["$pp_colour_colour"] = 1.0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	local blutab = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_brightness"] = 0.0,
		["$pp_colour_contrast"] = 1.0,
		["$pp_colour_colour"] = 1.0,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	local function IceLazerIntensity(ply)
		local time = ply:GetNW2Float("TFA.IceLazerFade", 0)
		local intensity = math.Clamp(time - CurTime(), 0, 1)

		return intensity
	end

	local function PorternadeIntensity(ply)
		local time = ply:GetNW2Float("TFA.PorternadeFade", 0)
		local intensity = math.Clamp((time - CurTime()) / ply:GetNW2Float("TFA.PorternadeDuration", 1), 0, 1)

		return intensity
	end

	local blur_mat = Material("pp/bokehblur")
	local function MyDrawBokehDOF(fac)
		render.UpdateScreenEffectTexture()
		render.UpdateFullScreenDepthTexture()
		blur_mat:SetTexture("$BASETEXTURE", render.GetScreenEffectTexture())
		blur_mat:SetTexture("$DEPTHTEXTURE", render.GetResolvedFullFrameDepth())
		blur_mat:SetFloat("$size", 2*fac)
		blur_mat:SetFloat("$focus", 2*fac)
		blur_mat:SetFloat("$focusradius", 1*fac)
		render.SetMaterial(blur_mat)
		render.DrawScreenQuad()
	end

	hook.Add("RenderScreenspaceEffects", "FOXMISC.TFA.WW.Overlay",function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if ply:BO3IsTransfur() then
			DrawColorModify(tab)
		end

		if ply:WAWIsPlasmaEnraged() then
			DrawMaterialOverlay("effects/overlay/inv_overlay_white", -0.06)
		end

		if ply:GetNW2Float("pbokefade", 0) + 1 > CurTime() then
			MyDrawBokehDOF(ply:GetNW2Float("pbokefade", 0) + 1 - CurTime())
		end

		local intensity = IceLazerIntensity(ply)
		if intensity > 0.005 then
			redtab["$pp_colour_addr"] = intensity * 0.8
			redtab["$pp_colour_contrast"] = 1 + intensity * 0.4
			redtab["$pp_colour_colour"] = 1 - intensity * 0.4
			redtab["$pp_colour_brightness"] = 0 - intensity * 0.4
			DrawColorModify(redtab)
		end

		local tpintensity = PorternadeIntensity(ply)
		if tpintensity > 0.005 and not ply:ShouldDrawLocalPlayer() then
			blutab["$pp_colour_addr"] = tpintensity * 0.5
			blutab["$pp_colour_addg"] = tpintensity * 0.9
			blutab["$pp_colour_addb"] = tpintensity * 1
			blutab["$pp_colour_contrast"] = 1 + tpintensity * 0.4
			blutab["$pp_colour_colour"] = 1 - tpintensity * 0.4
			blutab["$pp_colour_brightness"] = 0 - tpintensity * 0.4
			DrawColorModify(blutab)
		end
	end)
end