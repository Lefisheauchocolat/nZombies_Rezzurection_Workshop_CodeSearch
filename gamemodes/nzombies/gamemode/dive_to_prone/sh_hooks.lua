TFA.AddSound ("NZ.D2P.Launch", CHAN_STATIC, 1, SNDLVL_NORM, 100, "player/dive_to_prone/foley/fly_launch_00.wav",")")
TFA.AddSound ("NZ.D2P.Collide", CHAN_STATIC, 1, SNDLVL_NORM, 100, "player/dive_to_prone/collide/collide_00.wav",")")
TFA.AddSound ("NZ.D2P.Slide", CHAN_STATIC, 1, SNDLVL_IDLE, 100, "player/dive_to_prone/slide/concrete/concrete_slide_stop.wav",")")

local landing_sound = {
	[MAT_CONCRETE] = "player/dive_to_prone/land/concrete/land_concrete_00.wav",
	[MAT_DIRT] = "player/dive_to_prone/land/dirt/land_dirt.wav",
	[MAT_SNOW] = "player/dive_to_prone/land/snow/land_snow.wav",
	[MAT_METAL] = "player/dive_to_prone/land/metal/land_metal.wav",
	[MAT_WOOD] = "player/dive_to_prone/land/wood/land_wood.wav",

	[0] = "player/dive_to_prone/land/concrete/land_concrete_00.wav"
}

landing_sound[MAT_GRASS] = landing_sound[MAT_DIRT]
landing_sound[MAT_SAND] = landing_sound[MAT_SNOW]
landing_sound[MAT_PLASTIC] = landing_sound[MAT_WOOD]
landing_sound[MAT_VENT] = landing_sound[MAT_METAL]
landing_sound[MAT_GRATE] = landing_sound[MAT_METAL]

local meta = FindMetaTable("Player")

function meta:GetDiving()
	return self:GetNWBool("Diving", false)
end

function meta:SetDiving(bool)
	return self:SetNWBool("Diving", bool)
end

function meta:GetDivingReset()
	return self:GetNW2Bool("Diving.Reset", false)
end

function meta:SetDivingReset(bool)
	return self:SetNW2Bool("Diving.Reset", bool)
end

function meta:GetLandingTime()
	return self:GetNW2Float("Diving.Time", 0)
end

function meta:SetLandingTime(float)
	return self:SetNW2Float("Diving.Time", float)
end

local up = Vector(0, 0, 150)

local down = Vector(0, 0, 32)
local trace = {}

local function LandingSurfaceSound(ply, pos, filter)
	trace.start = pos
	trace.endpos = pos - down
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local sndtable = landing_sound[tr.MatType] or landing_sound[0]
	local finalsnd = sndtable[math.random(#sndtable)]

	if filter then
		local receipts = RecipientFilter()
		receipts:AddPAS(ply:GetPos())
		receipts:RemovePlayer(ply)

		ply:EmitSound(finalsnd, SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC, 0, 0, receipts)

		ply:EmitSound("player/dive_to_prone/collide/collide_00.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC, 0, 0, receipts)
		ply:EmitSound("player/dive_to_prone/slide/concrete/concrete_slide_stop.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC, 0, 0, receipts)
	else
		ply:EmitSound(finalsnd, SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)

		ply:EmitSound("NZ.D2P.Collide")
		ply:EmitSound("NZ.D2P.Slide")
	end
end

if CLIENT then
	CreateClientConVar("nz_key_dtp", KEY_LALT, true, true, "Sets the key for dolphin diving. Uses numbers from gmod's KEY_ enums: http://wiki.garrysmod.com/page/Enums/KEY")
end

hook.Add("PlayerButtonDown", "dive_to_prone.button", function(ply, but)
	local candiving = nzMapping.Settings.movement
	if candiving == nil or (candiving ~= 2 and candiving < 3) then return end
	if but ~= ply:GetInfoNum("nz_key_dtp", KEY_LALT) then return end

	local cosmo = ply:HasPerk('cosmo')
	local issprinting = ply:GetSprinting()
	local ang = ply:GetAngles()
	local view_fwd = Angle(0, ang.yaw, ang.roll):Forward()
	local vel_fwd = ply:GetVelocity():GetNormalized()
	local dot = view_fwd:Dot(vel_fwd)

	if issprinting and ply:GetLandingTime() < CurTime() and !ply.DiveAttempting and (dot > 0.6 or cosmo or nzMapping.Settings.divingomnidirection) then
		if ply.GetUsingSpecialWeapon and ply:GetUsingSpecialWeapon() and !cosmo then return end

		ply.DiveAttempting = true

		local diving = ply:GetDiving()
		local speed = ply:GetVelocity():Length()
		local runspeed = ply:GetMaxRunSpeed() or ply:GetRunSpeed()
		local crouching = ply:Crouching()
		local onground = ply:OnGround()
		local landingtime = ply:GetLandingTime()
		local CT = CurTime()

		if onground and not diving and not crouching and speed >= (runspeed * 0.85) then
			if SERVER and !game.SinglePlayer() then
				local filter = RecipientFilter()
				filter:AddPAS(ply:GetPos())
				filter:RemovePlayer(ply)

				ply:EmitSound("player/dive_to_prone/foley/fly_launch_00.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC, 0, 0, filter)
			end
			if IsFirstTimePredicted() and (game.SinglePlayer() or CLIENT) then
				ply:EmitSound("NZ.D2P.Launch")
			end

			local fwd = ply:KeyDown(IN_FORWARD) and runspeed or ply:KeyDown(IN_BACK) and -runspeed or 0
			local side = ply:KeyDown(IN_MOVELEFT) and runspeed or ply:KeyDown(IN_MOVERIGHT) and -runspeed or 0
			local sidesway = side / runspeed
			local fwdsway = fwd / runspeed

			ply:ViewPunch(Angle(-math.abs(fwdsway*2), 0, side == 0 and 1 or -sidesway*4))

			if SERVER and ply.TFAVOX_Sounds then
				local sndtbl = ply.TFAVOX_Sounds['main']
				if sndtbl then
					TFAVOX_PlayVoicePriority(ply, sndtbl['jump'], 99, true)
				end
			end
		end
	end
end)

hook.Add("OnPlayerHitGround", "dive_to_prone.land", function(ply, inWater, onFloater, speed)
	local candiving = nzMapping.Settings.movement
	if candiving == nil or (candiving ~= 2 and candiving < 3) then return end

	local diving = ply:GetDiving()
	local onground = ply:OnGround()
	local landingtime = ply:GetLandingTime()
	local CT = CurTime()

	if IsFirstTimePredicted() and diving and onground and landingtime < CT then
		local direction = math.random(2) == 1 and -1 or 1
		local mult = math.Clamp(math.floor(speed/400), 1, 3)
		if ply:HasPerk('cosmo') then
			ply:ViewPunch(Angle(3*mult,math.Rand(-0.5,0.5),math.Rand(1,2)*direction))
		else
			ply:ViewPunch(Angle(5*mult,math.Rand(-1,1),math.Rand(1,2)*2*direction))
		end
	end
end)

hook.Add("SetupMove", "dive_to_prone", function(ply, mv, cmd)
	local candiving = nzMapping.Settings.movement
	if candiving == nil or (candiving ~= 2 and candiving < 3) then return end

	local cosmo = ply:HasPerk("cosmo")
	local diving = ply:GetDiving()
	local speed = mv:GetVelocity():Length()
	local runspeed = ply:GetMaxRunSpeed() or ply:GetRunSpeed()
	local issprinting = ply:GetSprinting()
	local crouching = ply:Crouching()
	local onground = ply:OnGround()
	local landingtime = ply:GetLandingTime()
	local CT = CurTime()

	if ply.DiveAttempting and (ply.GetUsingSpecialWeapon and (!ply:GetUsingSpecialWeapon() or cosmo)) and issprinting and onground and not diving and not crouching and speed >= (runspeed * 0.85) then
		local ang = mv:GetAngles()
		local view_fwd = Angle(0, ang.yaw, ang.roll):Forward()
		local vel_fwd = mv:GetVelocity():GetNormalized()
		local dot = view_fwd:Dot(vel_fwd)

		if dot > 0.6 or cosmo or nzMapping.Settings.divingomnidirection then
			if SERVER then
				if !cosmo and !nzMapping.Settings.divingallowweapon then
					ply:Give('tfa_dive_to_prone')
					ply:SelectWeapon('tfa_dive_to_prone')
				end

				if ply:HasUpgrade('cosmo') then
					local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1
					local health = tonumber(nzCurves.GenerateHealthCurve(round))

					local damage = DamageInfo()
					damage:SetAttacker(ply)
					damage:SetDamageType(DMG_MISSILEDEFENSE)
					damage:SetDamage((health/10) + 300)

					for k, v in pairs(ents.FindInSphere(ply:GetPos(), 270)) do
						if v:IsValidZombie() then
							if v.PainSequences then
								if !v:Alive() then continue end
								if v:GetSpecialAnimation() or
								v:GetCrawler() or v:GetIsBusy() or
								v.ShouldCrawl or v.IsBeingStunned or
								v.Dying or v:IsAATTurned() then
									continue
								end

								if v.PainSounds and !v:GetDecapitated() then
									v:EmitSound(v.PainSounds[math.random(#v.PainSounds)], 100, math.random(85, 105), 1, 2)
									v.NextSound = CurTime() + v.SoundDelayMax
								end

								v.IsBeingStunned = true
								v:DoSpecialAnimation(v.PainSequences[math.random(#v.PainSequences)], false, true)
								v.IsBeingStunned = false
								v.LastStun = CurTime() + 8
								v:ResetMovementSequence()
							end

							if v:VisibleVec(ply:EyePos()) and v:Health() > 0 then
								damage:SetDamageForce(v:GetUp()*22000 + (v:GetPos() - ply:GetPos()):GetNormalized() * math.random(12000,18000))
								damage:SetDamagePosition(v:EyePos())
								v:TakeDamageInfo(damage)
							end
						end
					end

					ParticleEffect("bo3_astronaut_pulse", ply:LocalToWorld(vector_up*48), angle_zero)

					if !game.SinglePlayer() then
						local filter = RecipientFilter()
						filter:AddPAS(ply:GetPos())
						filter:RemovePlayer(ply)

						ply:EmitSound("nz_moo/zombies/vox/_astro/death/astro_pop.mp3", SNDLVL_GUNFIRE, math.random(95, 105), 1, CHAN_STATIC, 0, 0, filter)
						ply:EmitSound("nz_moo/zombies/vox/_astro/death/astro_flux.mp3", SNDLVL_GUNFIRE, math.random(95, 105), 1, CHAN_STATIC, 0, 0, filter)
					end
				end
			end

			if ply:HasUpgrade("cosmo") and IsFirstTimePredicted() and (game.SinglePlayer() or CLIENT) then
				ParticleEffect("bo3_astronaut_pulse", ply:LocalToWorld(vector_up*48), angle_zero)
				ply:EmitSound("nz_moo/zombies/vox/_astro/death/astro_pop.mp3", SNDLVL_GUNFIRE, math.random(95, 105), 1, CHAN_STATIC)
				ply:EmitSound("nz_moo/zombies/vox/_astro/death/astro_flux.mp3", SNDLVL_GUNFIRE, math.random(95, 105), 1, CHAN_STATIC)
			end

			if !ply.DivingUnDuckSpeed then
				ply.DivingUnDuckSpeed = ply:GetUnDuckSpeed()
			end

			if !ply.DivingGroundZ then
				ply.DivingGroundZ = mv:GetOrigin().z + 8
			end

			ply:SetDiving(true)
			ply:SetUnDuckSpeed(0.4)
			ply:SetGroundEntity(nil)
			mv:SetVelocity((vel_fwd * runspeed) * nzMapping.Settings.divingspeed + Vector(0, 0, nzMapping.Settings.divingheight))

			if cosmo then
				ply:SetGravity(0.37)
			end
		end
	elseif ply.DiveAttempting then
		ply.DiveAttempting = false
	end

	diving = ply:GetDiving()
	onground = ply:OnGround()

	if diving and onground and landingtime < CT then
		ply:SetLandingTime(CT + (nzMapping.Settings.divingwait or 0.2))
		ply:SetDiving(false)

		if IsFirstTimePredicted() and (game.SinglePlayer() or CLIENT) then
			local pos = ply:GetPos()
			LandingSurfaceSound(ply, pos)
		end

		if SERVER then
			if !game.SinglePlayer() then
				local pos = ply:GetPos()
				LandingSurfaceSound(ply, pos, true)
			end
			if cosmo then
				ply:SetGravity(1)

				if ply:HasUpgrade("everclear") then
					local fire = ents.Create("elemental_pop_effect_1")
					fire:SetPos(ply:GetPos())
					fire:SetParent(ply)
					fire:SetOwner(ply)
					fire:SetAttacker(ply)
					fire:SetInflictor(ply)
					fire:SetAngles(angle_zero)

					fire.Delay = 1
					fire.Range = 300
					fire:Spawn()
				end
			end

			if ply.TFAVOX_Sounds then
				local sndtbl = ply.TFAVOX_Sounds['damage']
				if sndtbl then
					TFAVOX_PlayVoicePriority(ply, sndtbl[HITGROUP_GENERIC], 99, true)
				end
			end
		end
	end

	diving = ply:GetDiving()
	onground = ply:OnGround()
	landingtime = ply:GetLandingTime()

	if not diving and not onground and landingtime > CT and not ply:GetDivingReset() then
		ply.DivingGroundZ = mv:GetOrigin().z + 8
		ply:SetDiving(true)
		ply:SetDivingReset(true)
	end

	diving = ply:GetDiving()

	if not crouching and not diving and CT > landingtime and ply.DivingUnDuckSpeed then
		ply.DivingGroundZ = nil
		ply:SetDivingReset(false)
		ply:SetUnDuckSpeed(ply.DivingUnDuckSpeed)
		ply.DivingUnDuckSpeed = nil
	end
end)

hook.Add("PlayerFootstep", "dive_to_prone.step", function(ply)
	if ply:GetDiving() then return true end
end)

hook.Add("StartCommand", "dive_to_prone.command", function(ply, cmd)
	local diving = ply:GetDiving()
	local onground = ply:OnGround()
	local landingtime = ply:GetLandingTime()
	local offset = 0.1
	local CT = CurTime()

	if diving or (onground and (landingtime - offset) > CT) then
		cmd:RemoveKey(IN_SPEED)
		cmd:RemoveKey(IN_JUMP)
		if not ply:HasPerk("cosmo") then
			cmd:ClearMovement()
		end
		cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_DUCK))
	end
end)

if SERVER then
	hook.Add("OnEntityWaterLevelChanged", "dive_to_prone.fix", function(ply, old, new)
		if not IsValid(ply) or not ply:IsPlayer() then return end

		local candiving = nzMapping.Settings.movement
		if candiving == nil or (candiving ~= 2 and candiving < 3) then return end

		if ply:GetDiving() and new > 2 then
			ply:SetLandingTime(CurTime())
			ply:SetDiving(false)
		end
	end)
end

if CLIENT then
	hook.Add("HUDWeaponPickedUp", "dive_to_prone.hud", function(weapon)
		if not IsValid(weapon) then return end
		if weapon:GetClass() == "tfa_dive_to_prone" then
			return true
		end
	end)

	hook.Add("AdjustMouseSensitivity", "dive_to_prone.mousemod", function(default_sensitivity)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		local diving = ply:GetDiving()
		local onground = ply:OnGround()
		local landingtime = ply:GetLandingTime()
		local CT = CurTime()

		if diving then
			if ply:HasPerk("cosmo") then
				return 0.5
			else
				return nzMapping.Settings.divingallowweapon and 0.2 or 0.05
			end
		elseif onground and landingtime > CT then
			local ratio = (1 - math.Remap(math.Clamp((landingtime - CT) / 0.2, 0, 1), 0, 1, 0, (ply:HasPerk("cosmo") and 0.5 or 0.8)))
			return ratio
		else
			return nil
		end
	end)
end