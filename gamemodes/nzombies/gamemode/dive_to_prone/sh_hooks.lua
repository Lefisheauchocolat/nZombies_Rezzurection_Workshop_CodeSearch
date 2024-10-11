local diving_launchmult = CreateConVar("sv_dive_to_prone_launchmult", 1, {FCVAR_REPLICATED, FCVAR_ARCHIVE})

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
	return self:GetNW2Bool("Diving", false)
end

function meta:SetDiving(bool)
	return self:SetNW2Bool("Diving", bool)
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

local function LandingSurfaceSound(ply, pos)
	trace.start = pos
	trace.endpos = pos - down
	trace.filter = ply
	local tr = util.TraceLine(trace)
	local sndtable = landing_sound[tr.MatType] or landing_sound[0]

	ply:EmitSound(sndtable[math.random(#sndtable)], SNDLVL_NORM, 100 + math.random(-4, 4))
	ply:EmitSound("NZ.D2P.Collide")
	ply:EmitSound("NZ.D2P.Slide")
end

if SERVER then
	net.Receive("nzDiveAttempt", function(len, ply)
		if ply:GetSprinting() then
			ply.DiveAttempting = true
		end
	end)
	util.AddNetworkString("nzDiveAttempt")
else
	CreateClientConVar("nz_key_dtp", KEY_LALT, true, true, "Sets the key for dolphin diving. Uses numbers from gmod's KEY_ enums: http://wiki.garrysmod.com/page/Enums/KEY")

	local is_z_pressed = false
	hook.Add("Think", "nzDiveAttempt", function()
		local ply = LocalPlayer()

		if input.IsKeyDown(ply:GetInfoNum("nz_key_dtp", KEY_LALT)) then
			local candiving = nzMapping.Settings.movement
			if candiving == nil or (candiving ~= 2 and candiving <3) then return end

			if !is_z_pressed and ply:GetSprinting() then
				ply.DiveAttempting = true
				net.Start("nzDiveAttempt")
				net.SendToServer()
			end
			is_z_pressed = true
		else
			is_z_pressed = false
		end
	end)
end

hook.Add("InitPostEntity", "dive_to_prone.display", function()
	nzSpecialWeapons:AddDisplay("tfa_dive_to_prone", false, function(wep)
		local ply = wep:GetOwner()
		return SERVER and (not ply:GetDiving() and ply:OnGround() and ply:GetLandingTime() < CurTime())
	end)
end)

hook.Add("SetupMove", "dive_to_prone", function(ply, mv, cmd)
	local candiving = nzMapping.Settings.movement
	if candiving == nil or (candiving ~= 2 and candiving <3) then return end

	if not ply.OldUnDuckSpeed then
		ply.OldUnDuckSpeed = ply:GetUnDuckSpeed()
	end

	local diving = ply:GetDiving()
	local speed = mv:GetVelocity():Length()
	local runspeed = ply:GetRunSpeed()
	//local jumping = mv:KeyDown(IN_JUMP)
	//local ducking = mv:KeyDown(IN_DUCK)
	local issprinting = ply:GetSprinting()
	local crouching = ply:Crouching()
	local onground = ply:OnGround()
	local landingtime = ply:GetLandingTime()
	local CT = CurTime()

	if (ply.GetUsingSpecialWeapon and not ply:GetUsingSpecialWeapon()) and issprinting and ply.DiveAttempting and onground and not diving and not crouching and speed >= (runspeed * 0.85) then
		local ang = mv:GetAngles()
		local view_fwd = Angle(0, ang.yaw, ang.roll):Forward()
		local vel_fwd = mv:GetVelocity():GetNormalized()
		local dot = view_fwd:Dot(vel_fwd)

		if dot > 0.6 or ply:HasPerk("cosmo") then
			if SERVER then
				if !ply:HasPerk("cosmo") then
					ply:Give('tfa_dive_to_prone')
					ply:SelectWeapon('tfa_dive_to_prone')
				end

				if ply:HasUpgrade("cosmo") then
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
					ply:EmitSound("nz_moo/zombies/vox/_astro/death/astro_pop.mp3", SNDLVL_GUNFIRE, math.random(95, 105), 1, CHAN_STATIC)
					ply:EmitSound("nz_moo/zombies/vox/_astro/death/astro_flux.mp3", SNDLVL_GUNFIRE, math.random(95, 105), 1, CHAN_STATIC)
				end

				ply:EmitSound("NZ.D2P.Launch")
			end

			ply:SetDiving(true)
			ply:SetUnDuckSpeed(0.5)
			ply:SetGroundEntity(nil)
			mv:SetVelocity((vel_fwd * runspeed + up) * diving_launchmult:GetInt())

			if ply:HasPerk("cosmo") then
				ply:SetGravity(0.37)
			end
		end
	elseif ply.DiveAttempting then
		ply.DiveAttempting = false
	end

	diving = ply:GetDiving()
	onground = ply:OnGround()

	if diving and onground and landingtime < CT then
		ply:SetLandingTime(CT + 0.2)
		ply:SetDiving(false)

		if SERVER then
			local pos = mv:GetOrigin()
			LandingSurfaceSound(ply, pos)

			if ply:HasPerk("cosmo") then
				ply:SetGravity(1)

				if ply:HasUpgrade("everclear") then
					local fire = ents.Create("elemental_pop_effect_1")
					fire:SetPos(ply:GetPos())
					fire:SetParent(ply)
					fire:SetOwner(ply)
					fire:SetAttacker(ply)
					fire:SetInflictor(ply)
					fire:SetAngles(angle_zero)

					fire.Delay = 2
					fire.Range = 300
					fire:Spawn()
				end
			end

			if ply.TFAVOX_Sounds then
				local sndtbl = ply.TFAVOX_Sounds['damage']
				if sndtbl then
					TFAVOX_PlayVoicePriority(ply, sndtbl[HITGROUP_GENERIC], 99)
				end
			end
		end
	end

	diving = ply:GetDiving()
	landingtime = ply:GetLandingTime()

	if not diving and not onground and landingtime > CT and not ply:GetDivingReset() then
		ply:SetDiving(true)
		ply:SetDivingReset(true)
	end

	diving = ply:GetDiving()

	if not crouching and not diving and CT > landingtime then
		ply:SetDivingReset(false)
		ply:SetUnDuckSpeed(ply.OldUnDuckSpeed)
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
				return 0.05
			end
		elseif onground and landingtime > CT then
			ply:SetGravity(1)
			return (1 - math.Clamp((ply:GetLandingTime() - CT) / 0.5, 0, 0.9)) * 0.85
		else
			return nil
		end
	end)
end