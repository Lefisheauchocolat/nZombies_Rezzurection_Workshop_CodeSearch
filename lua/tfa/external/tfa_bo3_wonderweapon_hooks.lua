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

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0.0,
	["$pp_colour_contrast"] = 1.0,
	["$pp_colour_colour"] = 1.0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
}

if SERVER then
	hook.Add("EntityTakeDamage", "BO3.TFA.WW.TakeDamage", function(ent, dmginfo)
		if ent:IsPlayer() then
			local pwep = ent:GetActiveWeapon()
			if IsValid(pwep) and pwep.BO3PESEnabled and not pwep.TakingOff then
				local mask = pwep.DamageTypes
				if bit.band(dmginfo:GetDamageType(), bit.bnot(mask)) <= 0 then
					return true
				end
			end

			if ent:GetNW2Bool("PESEnabled", false) then
				local wep = ent:GetWeapon("tfa_bo3_pes")
				if IsValid(wep) then //credit to hidden for damagetype code
					local mask = wep.DamageTypes
					if bit.band(dmginfo:GetDamageType(), bit.bnot(mask)) <= 0 then
						if wep.LastChatter and wep.LastChatter < CurTime() and math.random(10) == 1 then
							wep:EmitSound("TFA_BO3_PES.Chatter")
							wep.LastChatter = CurTime() + (math.random(5,12)*10)
						end

						return true
					end
				end
			end
		end

		local attacker = dmginfo:GetAttacker()
		if not IsValid(attacker) then return end

		if nzombies and ent:IsPlayer() then
			local wep = ent:GetActiveWeapon()
			if IsValid(wep) and wep.BO3CanSlam and wep:GetDG4Slamming() and not ent:IsOnGround() and attacker:IsValidZombie() then
				return true
			end
		end

		if attacker:BO3IsShrunk() then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.2)
		end
	end)

	hook.Add("AllowPlayerPickup", "BO3.TFA.WW.AllowPickup", function(ply, ent)
		local wep = ply:GetActiveWeapon()

		if IsValid(wep) and wep.IsTFAWeapon and wep.BO3CanHack then
			return false
		end
	end)

	hook.Add("OnPlayerHitGround", "BO3.TFA.WW.HitGround", function(ply, inWater, onFloater, speed)
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep.BO3CanSlam and wep:GetDG4Slamming() then
			wep:SetSlamNormal(vector_origin)
			wep:SetDG4Slamming(false)
			return true
		end
	end)

	hook.Add("PlayerSpawn", "BO3.TFA.WW.PlayerSpawn", function(ply, trans)
		if not IsValid(ply) then return end

		if ply:GetNW2Bool("DG4Killed") then
			ply:SetNW2Bool("DG4Killed", false)
		end
		if ply:GetNW2Bool("OctoBombed") then
			ply:SetNW2Bool("OctoBombed", false)
		end
		if ply:GetNW2Bool("AnniKilled") then
			ply:SetNW2Bool("AnniKilled", false)
		end
		if ply:GetNW2Bool("WavePopKilled") then
			ply:SetNW2Bool("WavePopKilled", false)
		end
		if ply:GetNW2Bool("RemoveRagdoll") then
			ply:SetNW2Bool("RemoveRagdoll", false)
		end
	end)

	hook.Add("OnNPCKilled", "BO3.TFA.WW.SpecialistKill", function(npc, attacker, inflictor)
		TFA.SpecialistAmmoRefil(npc, attacker, inflictor)
		if !nzombies and IsValid(inflictor) and inflictor:GetClass() == "tfa_bo3_wunderwaffe" then
			npc:StopParticles()
			npc:SetNW2Int("WunderWaffeld", inflictor.Ispackapunched and 2 or 1)
		end
	end)

	hook.Add("CreateEntityRagdoll", "1BO3.TFA.WW.Ragdoll_Server", function(ent, ragdoll)
		if not IsValid(ent) or not IsValid(ragdoll) then return end

		if !nzombies and ent:GetNW2Int("WunderWaffeld", 0) > 0 then
			ParticleEffectAttach(ent:GetNW2Int("WunderWaffeld", 0) > 1 and "bo3_waffe_electrocute_2" or "bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ragdoll, 2)
			if ent:OnGround() then
				ParticleEffectAttach(ent:GetNW2Int("WunderWaffeld", 0) > 1 and "bo3_waffe_ground_2" or "bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
			end
		end

		if ent:GetNW2Bool("OctoBombed") then
			ParticleEffectAttach("bo3_lilarnie_zomb", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
		end

		if ent:GetNW2Bool("DG4Killed") then
			ParticleEffectAttach("bo3_dg4_zomb", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
		end

		if ent:GetNW2Bool("GerschSuckd") then
			ParticleEffect("bo3_gersch_kill", ent:WorldSpaceCenter(), angle_zero)
			ent:EmitSound("TFA_BO3_GERSCH.Suck")
			SafeRemoveEntity(ragdoll)
		end

		if ent:GetNW2Bool("WavePopKilled") then
			local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
			ParticleEffectAttach(cyborg and "bo3_wavegun_pop_blue" or "bo3_wavegun_pop", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
			if ent:IsPlayer() then
				ragdoll = ent:GetRagdollEntity()
			end
			timer.Simple(engine.TickInterval(), function() SafeRemoveEntity(ragdoll) end)
		end

		if ent:GetNW2Bool("RemoveRagdoll") then
			if ent:IsPlayer() then
				ragdoll = ent:GetRagdollEntity()
			end
			timer.Simple(engine.TickInterval(), function() SafeRemoveEntity(ragdoll) end)
		end

		if ent:GetNW2Bool("WolfBowKilled") then
			local function BlendGhost(self)
				local num = render.GetBlend()

				render.MaterialOverride(Material("models/zmb/ghost/ghost_glow.vmt"))
				render.SetBlend(0.1)
				self:DrawModel()
				render.SetBlend(num)
				render.MaterialOverride(nil)
			end

			ragdoll.RenderOverride = BlendGhost
			ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			timer.Simple(math.Rand(0.5, 1), function()
				if IsValid(ragdoll) then
					ParticleEffect("bo3_qed_explode_1", ragdoll:GetPos(), angle_zero)

					if ent:IsPlayer() then
						net.Start("TFA.BO3.REMOVERAG")
							net.WriteEntity(ent)
						net.SendToServer()
					else
						SafeRemoveEntity(ragdoll)
					end
				end
			end)
		end

		if ent:GetNW2Bool("AnniKilled") then
			ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			for i=0, ragdoll:GetPhysicsObjectCount()-1 do
				construct.SetPhysProp( nil, ragdoll, i, nil, { GravityToggle = false } )
			end

			if ent.GetBloodColor then
				ragdoll.BloodColor = ent:GetBloodColor()
			end

			timer.Simple(math.Rand(0.1,0.3), function()
				if ragdoll:IsValid() then
					ParticleEffect(ragdoll.BloodColor and TFA.BO3BloodColor[ragdoll.BloodColor] or "bo3_annihilator_blood",ragdoll:GetPos(),Angle(0,0,0))

					ragdoll:EmitSound("TFA_BO3_ANNIHILATOR.Gib")
					ragdoll:EmitSound("TFA_BO3_ANNIHILATOR.Exp")

					if ent:IsPlayer() then
						net.Start("TFA.BO3.REMOVERAG")
							net.WriteEntity(ent)
						net.SendToServer()
					else
						SafeRemoveEntity(ragdoll)
					end
				end
			end)
		end

		if ent:BO3IsCooking() then
			ent:StopParticles()
			local bonescale = 1
			local inflatetimer = tostring("BO3Inflate"..ent:EntIndex())

			ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			for i=0, ragdoll:GetPhysicsObjectCount()-1 do
				construct.SetPhysProp( nil, ragdoll, i, nil, { GravityToggle = false } )
			end

			timer.Create(inflatetimer, engine.TickInterval(), 0, function()
				if not IsValid(ragdoll) then timer.Remove(inflatetimer) return end

				for i = 0, ragdoll:GetBoneCount(), 1 do
					ragdoll:ManipulateBoneScale(i,Vector(bonescale,bonescale,bonescale))
				end

				bonescale = bonescale + (engine.TickInterval()/2)
			end)

			timer.Simple(math.Rand(1.5,2), function()
				if not IsValid(ragdoll) then timer.Remove(inflatetimer) return end

				ParticleEffectAttach("bo3_wavegun_pop", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 1)
				ragdoll:EmitSound("TFA_BO3_WAVEGUN.Microwave.Ding")
				ragdoll:EmitSound("TFA_BO3_GENERIC.Gib")
				timer.Simple(engine.TickInterval(), function() SafeRemoveEntity(ragdoll) end)
			end)
		end
	end)

	hook.Add("PlayerUse", "BO3.TFA.WW.Use", function(ply, ent)
		if not IsValid(ply) or not IsValid(ent) then return end
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end

		if IsValid(wep) and wep.IsTFAWeapon and wep.BO3CanHack then
			return false
		end
	end)
end

hook.Add("EntityEmitSound", "BO3.TFA.WW.EmitSound", function(data)
	if IsValid(data.Entity) and data.Entity:BO3IsShrunk() and not TFA.BO3NoModSound[data.OriginalSoundName] then
		data.Pitch = 168
		return true
	end
end)

hook.Add("PlayerSwitchWeapon", "BO3.TFA.WW.SwitchWep", function(ply, oldWep, newWep)
	if not IsValid(ply) or not IsValid(oldWep) then return end

	if oldWep:GetClass() == "tfa_bo3_wepsteal" and oldWep:GetStatus() == TFA.Enum.STATUS_DRAW then
		return true
	end
end)

local vector_down_250 = Vector(0,0,250)
local vector_down_1000 = Vector(0,0,1000)

hook.Add("SetupMove", "BO3.TFA.WW.SetupMove", function(ply, mv, cmd)
	if not nzombies or (nzombies and ply:GetNotDowned()) then
		if ply:GetMoveType() ~= MOVETYPE_NOCLIP then
			local wep = ply:GetActiveWeapon()

			if IsValid(wep) and wep.IsTFAWeapon and wep.BO3CanDash then
				if ply:IsOnGround() and wep:GetDashing() then
					local ang = mv:GetAngles()
					local fwd = Angle(0, ang.yaw, ang.roll):Forward()

					local mult = wep.BO3DashMult or 1.5
					local speed = wep.BO3DashSpeed or 1000
					local delta = math.Clamp(wep:GetStatusProgress() * mult, 0, 1)

					mv:SetVelocity(fwd * (speed * delta))
				end
			end

			if IsValid(wep) and wep.IsTFAWeapon and wep.BO3CanSlam then
				local status = wep:GetStatus()

				if status == TFA.Enum.STATUS_GRENADE_PULL then
					ply:SetGroundEntity(nil)
					mv:SetVelocity(wep:GetSlamNormal() * (wep.DG4SlamFwd or 350) + (wep.DG4SlamUp or vector_down_250))
				end

				if status == TFA.Enum.STATUS_GRENADE_PULL and CurTime() >= wep:GetStatusEnd() then
					mv:SetVelocity(mv:GetVelocity() - vector_down_1000)
				end

				if status == TFA.Enum.STATUS_GRENADE_THROW then
					mv:SetVelocity(vector_origin)
				end
			end
		end
	end
end)

hook.Add("StartCommand", "BO3.TFA.WW.StartCMD", function(ply, cmd)
	if not nzombies or (nzombies and ply:GetNotDowned()) then
		if ply:GetMoveType() ~= MOVETYPE_NOCLIP then
			local wep = ply:GetActiveWeapon()

			if IsValid(wep) and wep.IsTFAWeapon and wep.BO3CanDash then
				if ply:IsOnGround() and wep:GetDashing() then
					cmd:RemoveKey(IN_SPEED)
					cmd:RemoveKey(IN_JUMP)
					cmd:RemoveKey(IN_DUCK)
					cmd:ClearMovement()
				end
			end

			if IsValid(wep) and wep.IsTFAWeapon and wep.BO3CanSlam then
				if wep:GetDG4Slamming() then
					cmd:RemoveKey(IN_SPEED)
					cmd:RemoveKey(IN_JUMP)
					cmd:RemoveKey(IN_DUCK)
					cmd:ClearMovement()
				end
			end

			if IsValid(wep) and wep.IsTFAWeapon and wep.BO3CanHack then
				local ent = ply:GetEyeTrace().Entity
				local targ = wep:GetHackerTarget()

				if cmd:KeyDown(IN_USE) then
					if IsValid(ent) and not IsValid(targ) then
						wep:SetHackerTarget(ent)
					end
				elseif IsValid(targ) then
					wep:SetHackerTarget(nil)
				end
			end
		end
	end
end)

if CLIENT then
	local ents = ents
	local ents_FindInSphere = ents.FindInSphere

	hook.Add("RenderScreenspaceEffects", "BO3.TFA.WW.FadeEffect", function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local InRange = false
		local FadeAmount = 0
		local EntClass
		local EntList = TFA.BO3VisionEnts

		local dents = {}
		local pos = ply:GetPos()
		local upgraded = false

		for _, ent in pairs(ents_FindInSphere(pos, 1000)) do
			if EntList[ent:GetClass()] then
				table.insert(dents, ent)
			end
		end

		if next(dents) ~= nil then
			for _, ent in ipairs(dents) do
				local dist = pos:Distance(ent:GetPos())
				local class = ent:GetClass()
				if dist <= EntList[class].range and ent:GetActivated() then
					InRange = true
					EntClass = class
					FadeAmount = FadeAmount + (EntList[class].range - dist)*2
					if EntList[EntClass].upgrade and ent.GetUpgraded and ent:GetUpgraded() then
						upgraded = true
					end
				end
			end
		end

		if InRange then
			local ModAmount = math.Clamp(FadeAmount / EntList[EntClass].range, 0, 1)
			tab["$pp_colour_addr"] = ModAmount * EntList[EntClass].red
			tab["$pp_colour_addg"] = ModAmount * EntList[EntClass].grn
			tab["$pp_colour_addb"] = ModAmount * EntList[EntClass].blu
			tab["$pp_colour_contrast"] = 1 - math.Clamp(ModAmount * 0.2, 0, 0.2)
			tab["$pp_colour_colour"] = math.Clamp(ModAmount * 1.3, 1, 1.3)
			if upgraded then
				tab["$pp_colour_addr"] = ModAmount * 0.25
				tab["$pp_colour_addg"] = ModAmount * 0
				tab["$pp_colour_addb"] = ModAmount * 0
			end

			DrawColorModify(tab)
			if EntList[EntClass].blur then
				DrawMotionBlur(0.1, ModAmount * EntList[EntClass].blurMul, EntList[EntClass].blurDelay)
			end
		end
	end)

	hook.Add("PostDrawTranslucentRenderables", "BO3.TFA.WW.3P_FX", function(bDepth, bSkybox)
		if ( bSkybox ) then return end

		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		--[[if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end]]

		local wep = ply:GetActiveWeapon()
		if not (IsValid(wep) and wep.IsTFAWeapon) then return end

		if wep:IsFirstPerson() and wep.CL_3PDrawFX and wep.CL_3PDrawFX:IsValid() then
			wep.CL_3PDrawFX:StopEmissionAndDestroyImmediately()

			if wep.WW3P_REMOVECALLBACK then
				wep:WW3P_REMOVECALLBACK(wep, ply)
			end
		end
	end)

	local tpfx_cvar = GetConVar("cl_tfa_fx_wonderweapon_3p")
	/*hook.Add("PrePlayerDraw", "BO3.TFA.WW.3P_FX", function(ply, flags)
		if !tpfx_cvar:GetBool() then return end
		if not IsValid(ply) then return end
		local wep = ply:GetActiveWeapon()
		if not (IsValid(wep) and wep.IsTFAWeapon) then return end
		if not (wep.WW3P_FX and wep.WW3P_ATT) then return end
		if ply:EntIndex() == LocalPlayer():EntIndex() and wep:IsFirstPerson() then return end

		if !wep.CL_3PDrawFX or !wep.CL_3PDrawFX:IsValid() then
			wep.CL_3PDrawFX = CreateParticleSystem(wep, tostring(wep.WW3P_FX), PATTACH_POINT_FOLLOW, tonumber(wep.WW3P_ATT))
		end

		if wep.WW3P_CALLBACK then
			wep:WW3P_CALLBACK(wep, ply)
		end
	end)*/

	local crosshair_cvar = GetConVar("cl_tfa_bo3ww_crosshair")
	hook.Add("TFA_DrawCrosshair", "BO3.TFA.WW.Crosshair", function(wep)
		if not IsValid(wep) or not wep.WWCrosshairEnabled then return end
		if crosshair_cvar:GetBool() then
			return true
		end
	end)

	hook.Add("HUDWeaponPickedUp", "BO3.TFA.WW.HudPickup", function(wep)
		if not IsValid(wep) then return end
		if wep:GetClass() == "tfa_bo3_wepsteal" then
			return true
		end
	end)

	hook.Add("CreateClientsideRagdoll", "1BO3.TFA.WW.Ragdoll_Client", function(ent, ragdoll)
		if not IsValid(ent) or not IsValid(ragdoll) then return end

		if !nzombies and ent:GetNW2Int("WunderWaffeld", 0) > 0 then
			ParticleEffectAttach(ent:GetNW2Int("WunderWaffeld", 0) > 1 and "bo3_waffe_electrocute_2" or "bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, ragdoll, 2)
			if ent:OnGround() then
				ParticleEffectAttach(ent:GetNW2Int("WunderWaffeld", 0) > 1 and "bo3_waffe_ground_2" or "bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
			end

			ent:StopSound("TFA_BO3_WAFFE.Sizzle")
			ragdoll:EmitSound("TFA_BO3_WAFFE.Sizzle")
		end

		if ent:GetNW2Bool("OctoBombed") then
			ParticleEffectAttach("bo3_lilarnie_zomb", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
		end

		if ent:GetNW2Bool("DG4Killed") then
			ParticleEffectAttach("bo3_dg4_zomb", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
		end

		if ent:GetNW2Bool("GerschSuckd") then
			ParticleEffect("bo3_gersch_kill", ent:WorldSpaceCenter(), angle_zero)
			ent:EmitSound("TFA_BO3_GERSCH.Suck")
			if ent:IsPlayer() then
				net.Start("TFA.BO3.REMOVERAG")
					net.WriteEntity(ent)
				net.SendToServer()
			else
				SafeRemoveEntity(ragdoll)
			end
		end

		if ent:GetNW2Bool("WavePopKilled") then
			local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
			ParticleEffectAttach(cyborg and "bo3_wavegun_pop_blue" or "bo3_wavegun_pop", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 0)
			if ent:IsPlayer() then
				net.Start("TFA.BO3.REMOVERAG")
					net.WriteEntity(ent)
				net.SendToServer()
			else
				timer.Simple(engine.TickInterval(), function() SafeRemoveEntity(ragdoll) end)
			end
		end

		if ent:GetNW2Bool("RemoveRagdoll") then
			if ent:IsPlayer() then
				net.Start("TFA.BO3.REMOVERAG")
					net.WriteEntity(ent)
				net.SendToServer()
			else
				timer.Simple(engine.TickInterval(), function() SafeRemoveEntity(ragdoll) end)
			end
		end

		if ent:GetNW2Bool("WolfBowKilled") then
			local function BlendGhost(self)
				local num = render.GetBlend()

				render.SuppressEngineLighting(false)
				render.MaterialOverride(Material("models/zmb/ghost/ghost_glow.vmt"))
				render.SetBlend(0.1)
				self:DrawModel()
				render.SetBlend(num)
				render.MaterialOverride(nil)
				render.SuppressEngineLighting(false)
			end

			ragdoll.RenderOverride = BlendGhost
			ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			timer.Simple(math.Rand(0.5, 1), function()
				if ragdoll:IsValid() then
					ParticleEffect("bo3_qed_explode_1", ragdoll:GetPos(), Angle(0,0,0))

					if ent:IsPlayer() then
						net.Start("TFA.BO3.REMOVERAG")
							net.WriteEntity(ent)
						net.SendToServer()
					else
						SafeRemoveEntity(ragdoll)
					end
				end
			end)
		end

		if ent:GetNW2Bool("AnniKilled") then
			ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			for i=0, ragdoll:GetPhysicsObjectCount()-1 do
				local phys = ragdoll:GetPhysicsObjectNum(i)
				phys:EnableGravity(false)
			end

			if ent.GetBloodColor then
				ragdoll.BloodColor = ent:GetBloodColor()
			end

			timer.Simple(nzombies and math.Rand(0.1,0.25) or math.Rand(0.1,0.35), function()
				if ragdoll:IsValid() then
					ParticleEffect(ragdoll.BloodColor and TFA.BO3BloodColor[ragdoll.BloodColor] or "bo3_annihilator_blood", ragdoll:GetPos(), Angle(0,0,0))

					ragdoll:EmitSound("TFA_BO3_ANNIHILATOR.Gib")
					ragdoll:EmitSound("TFA_BO3_ANNIHILATOR.Exp")

					if ent:IsPlayer() then
						net.Start("TFA.BO3.REMOVERAG")
							net.WriteEntity(ent)
						net.SendToServer()
					else
						SafeRemoveEntity(ragdoll)
					end
				end
			end)
		end

		if ent:BO3IsCooking() then
			ent:StopParticles()
			local cyborg = (ent.BloodType and ent.BloodType == "Robot") or ent:GetClass() == "nz_zombie_walker_cyborg"
			local bonescale = 1
			local inflatetimer = tostring("BO3Inflate"..ent:EntIndex())

			ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

			for i=0, ragdoll:GetPhysicsObjectCount()-1 do
				local phys = ragdoll:GetPhysicsObjectNum(i)
				phys:EnableGravity(false)
			end

			timer.Create(inflatetimer, engine.TickInterval(), 0, function()
				if not IsValid(ragdoll) then timer.Remove(inflatetimer) return end

				for i = 0, ragdoll:GetBoneCount(), 1 do
					ragdoll:ManipulateBoneScale(i,Vector(bonescale,bonescale,bonescale))
				end

				bonescale = bonescale + (engine.TickInterval()/2)
			end)

			timer.Simple(math.Rand(1.5,2), function()
				if not IsValid(ragdoll) then timer.Remove(inflatetimer) return end

				ParticleEffectAttach(tobool(cyborg) and "bo3_wavegun_pop_blue" or "bo3_wavegun_pop", PATTACH_ABSORIGIN_FOLLOW, ragdoll, 1)
				ragdoll:EmitSound("TFA_BO3_WAVEGUN.Microwave.Ding")
				ragdoll:EmitSound("TFA_BO3_GENERIC.Gib")
				timer.Simple(engine.TickInterval(), function() SafeRemoveEntity(ragdoll) end)
			end)
		end
	end)

	hook.Add("GetMotionBlurValues", "BO3.TFA.WW.MotionBlur", function(horizontal, vertical, forward, roll)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end

		if wep.BO3CanSlam and wep:GetDG4Slamming() then
			local mult = ply:GetVelocity():Length()
			mult = math.Clamp(mult/300, 0, 1)
			return horizontal, vertical + 0.005 * mult, forward + 0.05 * mult, roll
		end

		if wep.BO3CanDash and wep:GetDashing() then
			local mult = ply:GetVelocity():Length()
			mult = math.Clamp(mult/750, 0, 1)
			return horizontal, vertical, forward + 0.1 * mult, roll
		end
	end)

	if !nzombies then
		hook.Add("HUDPaint", "BO3.TFA.WW.HudPaint", function()
			local ply = LocalPlayer()
			if not IsValid(ply) then return end

			local dents = {}
			local pos = ply:GetPos()
			local Indicators = TFA.BO3Indicators

			for _, ent in pairs(ents_FindInSphere(pos, 350)) do
				if Indicators[ent:GetClass()] then
					local dir = ply:EyeAngles():Forward()
					local facing = (pos - ent:GetPos()):GetNormalized()
					if (facing:Dot(dir) + 1) / 2 > 0.45 then
						table.insert(dents, ent)
					end
				end
			end

			for _, ent in ipairs(dents) do
				local totaldist = 350^2
				local distfade = 250^2
				local playerpos = pos:DistToSqr(ent:GetPos())
				local fadefac = 1 - math.Clamp((playerpos - totaldist + distfade) / distfade, 0, 1)

				local dir = (ent:GetPos() - ply:GetShootPos()):Angle()
				dir = dir - EyeAngles()
				local angle = dir.y + 90

				local x = (math.cos(math.rad(angle)) * ScreenScale(90)) + ScrW() / 2
				local y = (math.sin(math.rad(angle)) * -ScreenScale(90)) + ScrH() / 2

				surface.SetMaterial(Indicators[ent:GetClass()])
				surface.SetDrawColor(ColorAlpha(color_white, 255*fadefac))
				surface.DrawTexturedRect(x, y, ScreenScale(24), ScreenScale(24))
			end
		end)
	end

	hook.Add("RenderScreenspaceEffects","BO3.TFA.WW.Overlays",function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if ply:GetNW2Bool("PESEnabled", false) and ply:HasWeapon('tfa_bo3_pes') then
			DrawMaterialOverlay("vgui/overlay/pes_overlay", 1)
		end
	end)
end
