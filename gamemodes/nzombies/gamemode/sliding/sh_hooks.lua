local nzslide_duration = .6
local nzslide_speedmult = 1.2
local nzslide_cooldown = 1

local slide_sounds = {
	[MAT_GRASS] = {"nz_moo/player/slide/slide_grass_c.wav"},
	[MAT_SNOW] = {"nz_moo/player/slide/slide_snow.wav"},
	[MAT_METAL] = {"nz_moo/player/slide/slide_metal_b.wav"},
	[MAT_SLOSH] = {"nz_moo/player/slide/slide_water.wav"},
	[0] = {"nz_moo/player/slide/slide_00.wav"}
}

slide_sounds[MAT_VENT] = slide_sounds[MAT_METAL]
slide_sounds[MAT_GRATE] = slide_sounds[MAT_METAL]

local end_sounds = {
	[MAT_GRASS] = {"nz_moo/player/slide/end/slide_grass_c_end.wav"},
	[MAT_METAL] = {"nz_moo/player/slide/end/slide_metal_b_end.wav"},
	[0] = {"nz_moo/player/slide/end/slide_00_end.wav"}
}

end_sounds[MAT_VENT] = end_sounds[MAT_METAL]
end_sounds[MAT_GRATE] = end_sounds[MAT_METAL]

local function CreateReplConVar(cvarname, cvarvalue, description, ...)
	return CreateConVar(cvarname, cvarvalue, CLIENT and {FCVAR_REPLICATED} or {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY}, description, ...)
end

if not ConVarExists("nz_difficulty_slide_jumping") then
	CreateReplConVar("nz_difficulty_slide_jumping", "0", "Enable to override map setting and always have slide jumping enabled.", 0, 1)
end
if not ConVarExists("nz_difficulty_slide_stamina") then
	CreateReplConVar("nz_difficulty_slide_stamina", "1", "Enable or disable the stamina system for sliding. Similar to Black Ops 4.", 0, 1)
end

if game.SinglePlayer() then
	if SERVER then
		util.AddNetworkString("nz_sliding_spfix")
	else
		net.Receive("nz_sliding_spfix", function()
			if VManip then
				VManip:PlayAnim("vault")
			end

			local ply = LocalPlayer()
			ply.SlidingAngle = ply:GetVelocity():Angle()
		end)
	end
end

local meta = FindMetaTable("Player")

function meta:GetSliding()
	return self:GetNW2Bool("nzSliding", false)
end

function meta:SetSliding(value)
	return self:SetNW2Bool("nzSliding", value)
end

function meta:GetSlidingTime()
	return self:GetNW2Float("nzSlidingTime")
end

function meta:SetSlidingTime(value)
	return self:SetNW2Float("nzSlidingTime", value)
end

function meta:GetSlidingSpeed()
	local val = self:GetNW2Float("nzSlideSpeed", nzMapping.Settings.slidespeed)
	return val > 0 and val or nzMapping.Settings.slidespeed
end

function meta:SetSlidingSpeed(value)
	return self:SetNW2Float("nzSlideSpeed", value)
end

function meta:GetSlidingStamina()
	return self:GetNW2Float("nzSlideStam", 1)
end

function meta:SetSlidingStamina(value)
	return self:SetNW2Float("nzSlideStam", math.max(value, 0.5)) //this is pretty fucked ngl
end

local nz_bo3slide = GetConVar("nz_difficulty_slide_jumping")
local nz_bo4slide = GetConVar("nz_difficulty_slide_stamina")
local slidepunch = Angle(-1, 0, -2.5)
local trace_down = Vector(0, 0, 32)
local trace_up = Vector(0, 0, 32)
local trace_tbl = {}
local next_banana = 0

local function SlideSurfaceSound(ply, pos)
	trace_tbl.start = pos
	trace_tbl.endpos = pos - trace_down
	trace_tbl.filter = ply
	local tr = util.TraceLine(trace_tbl)
	local sndtable = slide_sounds[tr.MatType] or slide_sounds[0]
	ply:EmitSound(sndtable[math.random(#sndtable)], 75, math.random(97,103))

	if ply:WaterLevel() > 0 then
		sndtable = slide_sounds[MAT_SLOSH]
		ply:EmitSound(sndtable[math.random(#sndtable)])
	end
end

local function PHDExplode(ply, pos)
	ply:ViewPunch(Angle(10, math.random(-5,5), math.random(-5,5)))
	ParticleEffect("nz_perks_phd", pos + vector_up*2, angle_zero)

	if SERVER then
		ply:EmitSound("NZ.PHD.Wubz")
		ply:EmitSound("NZ.PHD.Impact")
		local slidetime = math.max(0.1, nzMapping.Settings.slideduration) * ((bananad and ply:GetNW2Int("nz.BananaCount", 0) > 0) and 1.2 or 1)
		local mult = math.Clamp(1 - (ply:GetSlidingTime() - CurTime()) / (slidetime*ply:GetSlidingStamina()), 0, 1)

		util.BlastDamage(ply:GetActiveWeapon(), ply, pos + vector_up, math.max(300*mult, 150), 4000)
		util.ScreenShake(pos, 5, 5, math.max(2*mult, 1), math.max(500*mult, 150))
	end
end

hook.Add("SetupMove", "nzslide", function(ply, mv, cmd)
	local cansliding = nzMapping.Settings.movement
	if cansliding and (cansliding == 1 or cansliding > 2) then
		if not ply.OldDuckSpeed then
			ply.OldDuckSpeed = ply:GetDuckSpeed()
			ply.OldUnDuckSpeed = ply:GetUnDuckSpeed()
		end

		local flopper = ply:HasPerk("phd")
		local bananad = ply:HasPerk("banana")
		local blackops3 = nz_bo3slide:GetBool() or nzMapping.Settings.slidejump
		local blackops4 = nz_bo4slide:GetBool()

		local speed = mv:GetVelocity():Length()
		local runspeed = ply:GetMaxRunSpeed() or ply:GetRunSpeed()
		local slidetime = math.max(0.1, nzMapping.Settings.slideduration) * ((bananad and ply:GetNW2Int("nz.BananaCount", 0) > 0) and 1.2 or 1)
		local speedmult = ply:GetSlidingSpeed() * (flopper and 1.4 or 1)

		local sliding = ply:GetSliding()
		local ducking = mv:KeyDown(IN_DUCK)
		local crouching = ply:Crouching()
		local sprinting = mv:KeyDown(IN_SPEED)
		local onground = ply:OnGround()

		local CT = CurTime()

		if (!ply.SlidingCooldown or ply.SlidingCooldown < CT) and
		ducking and sprinting and onground and not sliding and (!blackops3 and not crouching or blackops3) and speed > runspeed * 0.5 then
			if blackops4 then
				local mult = math.Remap(math.Clamp(1 - ply:GetSlidingStamina(), 0, 1), 0, 0.5, 0.4, 1)
				if !ply.nz_lastslide or ply.nz_lastslide + (2.2 * mult) < CurTime() then
					ply:SetSlidingStamina(1)
				end
			end

			ply:SetSliding(true)
			ply:SetSlidingTime(CT + slidetime * ply:GetSlidingStamina())
			ply:ViewPunch(slidepunch)
			ply:SetDuckSpeed(0.2)
			ply:SetUnDuckSpeed(0.3)
			ply.SlidingAngle = mv:GetVelocity():Angle()
			ply.SlidingCooldown = CT + nzMapping.Settings.slidecooldown

			if blackops4 then
				ply.nz_lastslide = CT
			end

			if bananad and ply:GetNW2Int("nz.BananaCount", 0) > 0 then
				if SERVER then
					ply:SetNW2Float("nz.BananaDelay", CT + 10)
					ply:EmitSound("nz_moo/effects/banana/slide_squish.wav", 75, math.random(97,103), 1, CHAN_STATIC)
				end
			elseif flopper then
				local fx = EffectData()
				fx:SetEntity(ply)
				fx:SetScale(slidetime * ply:GetSlidingStamina())
				util.Effect("nz_phd_slide", fx)

				if SERVER then
					ply:EmitSound("nz_moo/effects/ignite_00.wav", 75, math.random(97,103), 1, CHAN_STATIC)
				end
			end

			if SERVER then
				local pos = mv:GetOrigin()
				SlideSurfaceSound(ply, pos)

				if game.SinglePlayer() then
					net.Start("nz_sliding_spfix")
					net.Send(ply)
				end
			elseif VManip then
				VManip:PlayAnim("vault")
			end
		elseif (not ducking or not onground) and sliding then
			if bananad then
				ply:SetNW2Int("nz.BananaCount", math.max(ply:GetNW2Int("nz.BananaCount", 0) - 1, 0))
			end
			if blackops4 then
				ply:SetSlidingStamina(ply:GetSlidingStamina() - 0.1)
			end
			ply:SetSliding(false)
			ply:SetSlidingTime(0)
		end

		sliding = ply:GetSliding()

		if sliding and mv:KeyDown(IN_DUCK) then
			local slidedelta = (ply:GetSlidingTime() - CT) / slidetime
			local speed = ((runspeed) * math.min(1, ((ply:GetSlidingTime() - CT + 0.4) / slidetime)) * (1 / engine.TickInterval()) * engine.TickInterval()) * (speedmult * math.Remap(ply:GetSlidingStamina(), 0.5, 1, 0.7, 1))
			mv:SetVelocity(ply.SlidingAngle:Forward() * speed)
			local pos = mv:GetOrigin()

			if not ply.SlidingLastPos then
				ply.SlidingLastPos = pos
			end

			if pos.z > ply.SlidingLastPos.z + 1 then
				ply:SetSlidingTime(ply:GetSlidingTime() - 0.025)
			elseif slidedelta < 0.5 and pos.z < ply.SlidingLastPos.z - 1 then
				ply:SetSlidingTime(CT + slidetime * 0.5)
			end

			if flopper and ply:GetNW2Float("nz.PHDDelay", 0) < CurTime() then
				for k, v in pairs(ents.FindInSphere(pos, 32)) do
					if (v:IsNPC() or v:IsNextBot()) and v:Health() > 0 then
						ply:SetNW2Float("nz.PHDDelay", CurTime() + 7)
						PHDExplode(ply, pos)
						break
					end
				end
			end

			if bananad and ply:GetNW2Int("nz.BananaCount", 0) > 0 and (!next_banana or next_banana < CurTime()) then
				if SERVER then
					local slip = ents.Create("perk_powerup_banana_slide")
					slip:SetPos(pos + vector_up*math.Rand(0,1))
					slip:SetAngles(mv:GetAngles())
					slip:SetOwner(ply)
					slip:SetUpgraded(ply:HasUpgrade("banana"))
					slip:Spawn()
				end

				ParticleEffect("nz_perks_banana_impact", pos + vector_up + (mv:GetVelocity():GetNormalized()*24), vector_up:Angle())
				next_banana = CurTime() + 0.075
			end

			ply.SlidingLastPos = pos

			if CT > ply:GetSlidingTime() then
				if bananad then
					ply:SetNW2Int("nz.BananaCount", math.max(ply:GetNW2Int("nz.BananaCount", 0) - 1, 0))
				end
				if blackops4 then
					ply:SetSlidingStamina(ply:GetSlidingStamina() - 0.1)
				end
				ply:SetSliding(false)
				ply:SetSlidingTime(0)
				ply.SlidingCooldown = CT + nzMapping.Settings.slidecooldown
			end
		end

		sliding = ply:GetSliding()

		if not crouching and not sliding then
			ply:SetDuckSpeed(ply.OldDuckSpeed)
			ply:SetUnDuckSpeed(ply.OldUnDuckSpeed)
		end
	end
end)

hook.Add("PlayerFootstep", "nzslidestep", function(ply)
	if ply:GetSliding() then return true end
end)

hook.Add("StartCommand", "nzslidespeed", function(ply, cmd)
	if ply:GetSliding() then
		local slidetime = math.max(0.1, nzMapping.Settings.slideduration) * ((bananad and ply:GetNW2Int("nz.BananaCount", 0) > 0) and 1.2 or 1)
		local time_remain_frac = (ply:GetSlidingTime() - CurTime()) / (slidetime*ply:GetSlidingStamina())

		local blackops3 = nz_bo3slide:GetBool() or nzMapping.Settings.slidejump
		if !blackops3 or (blackops3 and time_remain_frac > 0.8) then
			cmd:RemoveKey(IN_JUMP)
		elseif ply:KeyPressed(IN_JUMP) then
			if IsFirstTimePredicted() then
				ply:EmitSound("bhop.mp3", 75, math.random(97,103), 1, CHAN_WEAPON)
			end
		end
		cmd:RemoveKey(IN_SPEED)
		cmd:ClearMovement()

		local slidetime = math.max(0.1, nzMapping.Settings.slideduration) + ((bananad and ply:GetNW2Int("nz.BananaCount", 0) > 0) and 0.15 or 0)
		local time_remain_frac = (ply:GetSlidingTime() - CurTime()) / (slidetime*ply:GetSlidingStamina())

		if blackops3 and time_remain_frac > 0.8 then
			cmd:RemoveKey(IN_JUMP)
		end
		if time_remain_frac > 0.2*ply:GetSlidingStamina() then
			cmd:SetButtons(bit.bor(cmd:GetButtons(), IN_DUCK))
		end
	end
end)

if CLIENT then
	local view = {}
	local lastz = 0
	local t = 0.05
	local nzslide_view = CreateClientConVar("cl_nzslide_view", 1)

	hook.Add("CalcView", "nzslideView", function(ply, origin, angles, fov)
		if not nzslide_view:GetBool() then return end
		local sliding = ply:GetSliding()

		if not ply:ShouldDrawLocalPlayer() and sliding or lastz ~= 0 then
			if not sliding then
				t = t + (2 * FrameTime())
			else
				t = 0.05
			end

			if ply.SlidingAngle then
				local z

				if sliding then
					local slidetime = math.max(0.1, nzMapping.Settings.slideduration)
					z = (ply.SlidingAngle:Right():Dot(angles:Forward()) * 15) * ((ply:GetSlidingTime() - CurTime()) / slidetime*ply:GetSlidingStamina())
				else
					z = 0
				end

				lastz = Lerp(t, lastz, z)
				angles.z = lastz
			end
		end
	end)

	hook.Add("GetMotionBlurValues", "nzslideBlur", function(h, v, f, r)
		local ply = LocalPlayer()

		if ply:GetSliding() then
			local slidetime = math.max(0.1, nzMapping.Settings.slideduration)
			local t = (ply:GetSlidingTime() - CurTime()) / slidetime*ply:GetSlidingStamina()

			return h, v, f + 0.05 * t, r
		end
	end)
end