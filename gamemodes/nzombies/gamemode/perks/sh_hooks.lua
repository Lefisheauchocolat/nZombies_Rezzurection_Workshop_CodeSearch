if SERVER then
	local boobookeys = {
		[IN_RELOAD] = true,
		[IN_ATTACK] = true,
	}

	hook.Add("KeyPress", "nzPolitanEffects", function(ply, key)
		if not IsValid(ply) then return end
		if not ply:HasPerk("politan") then return end
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) or wep.NZSpecialCategory or not wep.IsTFAWeapon then return end

		if boobookeys[key] and (wep.Primary.ClipSize > 0 and wep:Clip1() == 0 or ply:GetAmmoCount(wep:GetPrimaryAmmoType()) == 0) then
			if ply:HasPerk("cherry") then
				ply:SetNW2Bool("nz.CherryBool", false)
			end

			for k, v in RandomPairs(nzMapping.Settings.rboxweps) do
				if ply:HasWeapon(k) then continue end
				local gun = weapons.Get(k)
				if not gun then continue end

				local guntogive = k
				local fucker = true

				if gun.NZSpecialCategory then
					fucker = false
				end
				if gun.NZPaPReplacement and ply:HasWeapon(gun.NZPaPReplacement) then
					fucker = false
				end
				if not gun.NZPaPReplacement and not gun.OnPaP then
					fucker = false
				end
				if gun.NZPaPReplacement then
					guntogive = gun.NZPaPReplacement
				end

				if fucker then
					ply:StripWeapon(wep:GetClass())

					if not ply:HasUpgrade("politan") and not ply:HasPerk("wall") then
						ply:Give(guntogive)
					else
						local wep2 = ply:Give(guntogive)
						timer.Simple(0, function()
							if not IsValid(ply) or not IsValid(wep2) then return end
							wep2:ApplyNZModifier("pap")
						end)
					end

					break
				end
			end
		end
	end)

	hook.Add("PlayerPostThink", "nzSpeedColaMod", function(ply)
		if not ply:HasUpgrade("speed") then return end

		for _, wep in ipairs(ply:GetWeapons()) do
			if wep:IsSpecial() then continue end
			if wep.NZDontRegen then continue end

			if wep.IsTFAWeapon and (wep:GetStatus() == TFA.Enum.STATUS_SHOOTING or TFA.Enum.ReloadStatus[wep:GetStatus()]) then
				if wep.NZLastSpeedRegen then
					local time = math.Clamp(10/wep.Primary.ClipSize, 0.1, 1) + 1
					wep.NZLastSpeedRegen = math.Max(wep.NZLastSpeedRegen, CurTime() + time)
				end
				continue
			end

			if wep.NZLastSpeedRegen and wep.NZLastSpeedRegen > CurTime() then continue end
			if not wep.Primary or not wep.Primary.ClipSize then continue end
			if wep.Primary.ClipSize <= 0 then continue end

			local ammo1 = wep:GetPrimaryAmmoType()
			if ammo1 > 0 then
				local clip1 = wep:Clip1()
				local ammo1count = ply:GetAmmoCount(ammo1)
				if clip1 > 0 and clip1 < wep.Primary.ClipSize and ammo1count > 0 then
					ply:RemoveAmmo(1, ammo1)
					wep.NZSpeedRegenerating = true
					wep:SetClip1(math.min(clip1 + 1, wep.Primary.ClipSize))
					wep.NZSpeedRegenerating = nil
				end
			end

			if wep.Akimbo then
				if ammo1 > 0 and wep.Secondary and wep.Secondary.ClipSize then
					local clip2 = wep:Clip2()
					local ammo1count = ply:GetAmmoCount(ammo1)
					if clip2 > 0 and clip2 < wep.Secondary.ClipSize and ammo1count > 0 then
						ply:RemoveAmmo(1, ammo1)
						wep.NZSpeedRegenerating = true
						wep:SetClip2(math.min(clip2 + 1, wep.Secondary.ClipSize))
						wep.NZSpeedRegenerating = nil
					end
				end
			else
				local ammo2 = wep:GetSecondaryAmmoType()
				if ammo2 > 0 and wep.Secondary and wep.Secondary.ClipSize then
					local ammo2count = ply:GetAmmoCount(ammo2)
					local clip2 = wep:Clip2()
					if clip2 > 0 and clip2 < wep.Secondary.ClipSize and ammo2count > 0 then
						ply:RemoveAmmo(1, ammo2)
						wep.NZSpeedRegenerating = true
						wep:SetClip2(math.min(clip2 + 1, wep.Secondary.ClipSize))
						wep.NZSpeedRegenerating = nil
					end
				end
			end

			local active = ply:GetActiveWeapon()
			if wep == active then
				local time = 10/wep.Primary.ClipSize
				wep.NZLastSpeedRegen = CurTime() + math.Clamp(time, 0.2, 2)
			else
				local time = 10/wep.Primary.ClipSize
				wep.NZLastSpeedRegen = CurTime() + math.Clamp(time, 0.1, 2)
			end
		end
	end)

	hook.Add("TFA_PostPrimaryAttack", "nzCherryMod", function(wep)
		local ply = wep:GetOwner()
		if not IsValid(ply) or not ply:IsPlayer() then return end

		local fuck = false
		if wep:GetStatL("Primary.ClipSize") <= 0 and wep:Ammo1() < wep:GetStatL("Primary.AmmoConsumption") then
			fuck = true
		end
		if wep:GetPrimaryClipSize(true) > 0 and wep:Clip1() < wep:GetStatL("Primary.AmmoConsumption") then
			fuck = true
		end

		if ply:HasUpgrade("cherry") and fuck and ply:GetNW2Float("nz.CherryWaffe", 0) < CurTime() then
			wep:EmitGunfireSound("TFA_BO3_WAFFE.Shoot")

			local arc = ents.Create("bo3_ww_wunderwaffe")
			if not IsValid(arc) then return end

			arc:SetModel("models/dav0r/hoverball.mdl")
			arc:SetPos(ply:GetShootPos())
			arc:SetAngles(wep:GetAimVector():Angle())

			arc:SetOwner(ply)
			arc:SetNoDraw(true)

			arc.MaxChain = math.random(4, 6)
			arc.ZapRange = 300 * (1 - math.Clamp(ply:GetNW2Int("nz.CherryCount", 0) / 10, 0, 0.9))
			arc.ArcDelay = 0.2

			arc:Spawn()

			arc:SetOwner(ply)
			arc.Inflictor = wep

			local dir = wep:GetAimVector()
			dir:Mul(2000)

			arc:SetVelocity(dir)
			local phys = arc:GetPhysicsObject()
			if IsValid(phys) then
				phys:SetVelocity(dir)
			end

			ply:SetNW2Float("nz.CherryWaffe", CurTime() + 10)
		end
	end)
end

local PLAYER = FindMetaTable("Player")
if PLAYER then
	function PLAYER:GetPHDJumped()
		return self:GetNW2Bool("nz.PHDJumpd", false)
	end
	function PLAYER:SetPHDJumped(bool)
		return self:SetNW2Bool("nz.PHDJumpd", bool)
	end
	function PLAYER:GetPHDDelay()
		return self:GetNW2Float("nz.PHDDelay", 0)
	end
	function PLAYER:SetPHDDelay(float)
		return self:SetNW2Float("nz.PHDDelay", float)
	end
end

local function GetMoveVector(mv) //from willox's double jump
	local ang = mv:GetAngles()

	local max_speed = mv:GetMaxSpeed()

	local forward = math.Clamp(mv:GetForwardSpeed(), -max_speed, max_speed)
	local side = math.Clamp(mv:GetSideSpeed(), -max_speed, max_speed)

	local abs_xy_move = math.abs(forward) + math.abs(side)

	if abs_xy_move == 0 then
		return vector_origin
	end

	local mul = max_speed / abs_xy_move

	local vec = Vector()

	vec:Add(ang:Forward() * forward)
	vec:Add(ang:Right() * side)

	vec:Mul(mul)

	return vec
end

hook.Add("SetupMove", "nzPHDEffects", function(ply, mv, cmd)
	if ply:HasUpgrade("phd") and (not ply:InVehicle()) and ply:GetMoveType() ~= MOVETYPE_NOCLIP then
		if (nzMapping.Settings.ac and nzMapping.Settings.acpreventcjump and !ply:IsInCreative()) then return end

		local onground = ply:IsOnGround()
		if onground and ply:GetPHDJumped() then
			ply:SetPHDJumped(false)
		end

		if not onground and mv:KeyPressed(IN_JUMP) and not ply:GetPHDJumped() then
			ply:SetPHDJumped(true)

			local vel = GetMoveVector(mv)
			vel.z = ply:GetJumpPower()

			local max = mv:GetMaxSpeed()
			local fwd = math.Clamp(mv:GetForwardSpeed(), -max, max)
			local side = math.Clamp(mv:GetSideSpeed(), -max, max)

			mv:SetVelocity(vel)

			ply:DoCustomAnimEvent(PLAYERANIMEVENT_JUMP , -1)

			local sidesway = side / max
			local fwdsway = fwd / max

			ply:ViewPunch(Angle(fwdsway*2, 0, sidesway*3))
			if IsFirstTimePredicted() then
				local fx = EffectData()
				fx:SetOrigin(ply:GetPos())
				fx:SetEntity(ply)
				fx:SetScale(120)
				util.Effect("ThumperDust", fx)
				ply:EmitSound("NZ.PHD.Jump")
			end
		end

		if not onground and ply:GetPHDJumped() and mv:KeyReleased(IN_DUCK) and ply:GetPHDDelay() < CurTime() then
			ply:SetPHDDelay(CurTime() + 7)
			mv:SetVelocity(mv:GetVelocity() - (vector_up*1000))
		end
	end
end)

hook.Add("EntityTakeDamage", "nzTortoiseBuildables", function(ent, dmginfo)
	if ent.GetTrapClass and not ent.NZIgnoreTortoiseBuff then
		local ply = ent:GetOwner()
		if IsValid(ply) and ply:IsPlayer() and ply:HasPerk("tortoise") then
			dmginfo:SetDamage(dmginfo:GetDamage() * 0.5)
		end
	end
end)

hook.Add("OnZombieKilled", "nzTombstoneModifierWavy", function(ent, dmginfo)
	local ply = dmginfo:GetAttacker()
	if IsValid(ply) and ply:IsPlayer() and ply.FightersFizz and !ply:GetNotDowned() then
		if not IsValid(ent) or not ent:IsValidZombie() then return end
		ply:RevivePlayer(ply)
	end
end)

//removed, but the code for finding head pos is usefull for reference
/*hook.Add("TFA_SecondaryAttack", "nzDeadshotMod", function(wep)
	local ply = wep:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end

	if ply:HasUpgrade("deadshot") then
		local tr = ply:GetEyeTrace()
		local ent = tr.Entity
		if IsValid(ent) and ent:IsValidZombie() and ent:Health() > 0 then
			local head
			for i = 0, ent:GetHitBoxCount(0) do
				if ent:GetHitBoxHitGroup(i,0) == HITGROUP_HEAD then
					head = ent:GetHitBoxBone(i, 0)
					break
				end
			end

			if not head then
				for i = 0, ent:GetHitBoxCount(0) do
					if ent:GetHitBoxHitGroup(i,0) == HITGROUP_GENERIC then
						head = ent:GetHitBoxBone(i, 0)
						break
					end
				end
			end

			if head then
				local headpos, headang = ent:GetBonePosition(head)
				headpos = ply:KeyDown(IN_ATTACK) and (headpos - Vector(0,0,8)) or headpos
				ply:SetEyeAngles((headpos - ply:GetShootPos()):Angle())
			end
		end
	end
end)*/

hook.Add("TFA_CompleteReload", "nzCherryBool", function(wep)
	if wep.NZSpecialCategory then return end
	local ply = wep:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end

	if ply:HasPerk("cherry") then
		ply:SetNW2Bool("nz.CherryBool", false)
	end
end)

hook.Add("TFA_LoadShell", "nzCherryBool2", function(wep)
	if wep.NZSpecialCategory then return end
	local ply = wep:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end

	if ply:HasPerk("cherry") then
		ply:SetNW2Bool("nz.CherryBool", false)
	end
end)

hook.Add("TFA_Reload", "nzCherryEffects", function(wep)
	local ply = wep:GetOwner()
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if wep.NZSpecialCategory then return end

	if ply:HasPerk("cherry") and not ply:GetNW2Bool("nz.CherryBool") and ply:GetAmmoCount(wep:GetPrimaryAmmoType()) > 0 then
		ply:SetNW2Bool("nz.CherryBool", true)

		local round = nzRound:GetNumber() > 0 and nzRound:GetNumber() or 1

		if ply:GetNW2Float("nz.CherryDelay", 0) < CurTime() and ply:GetNW2Int("nz.CherryCount", 0) > 0 then
			ply:SetNW2Int("nz.CherryCount", 0)
		end

		local scale = 1 - math.Clamp(ply:GetNW2Int("nz.CherryCount", 0) / 10, 0, 0.9)
		local proc = 1 - math.Clamp(wep:Clip1() / wep.Primary.ClipSize, 0, 1)
		local dmg = (320 * math.pow(1.1, math.floor(round/2) - 1)) * proc
		local count = 0

		local damage = DamageInfo()
		damage:SetDamage(dmg * scale)
		damage:SetDamageType(DMG_SHOCK)
		damage:SetAttacker(ply)
		damage:SetInflictor(wep)
		damage:SetDamageForce(vector_up)

		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 160 * proc)) do
			if ((v:IsNPC() or v:IsNextBot()) and v:Health() > 0) or v.DoCherryShock then
				damage:SetDamagePosition(v:WorldSpaceCenter())	

				if ply:HasUpgrade("cherry") and !v.IsMooBossZombie then
					damage:SetDamage(v:Health() + 666)
				end

				if damage:GetDamage() > v:Health() and IsFirstTimePredicted() and !v.DoCherryShock then
					ParticleEffectAttach("bo3_waffe_electrocute", PATTACH_POINT_FOLLOW, v, 2)
					if v:OnGround() then
						ParticleEffectAttach("bo3_waffe_ground", PATTACH_ABSORIGIN_FOLLOW, v, 0)
					end
					if v:IsValidZombie() and not v.IsMooSpecial then
						ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, v, 3)
						ParticleEffectAttach("bo3_waffe_eyes", PATTACH_POINT_FOLLOW, v, 4)
					end
				end

				if SERVER then
					if v.TempBehaveThread and v.SparkySequences then
						if v.PlaySound and v.ElecSounds then
							v:PlaySound(v.ElecSounds[math.random(#v.ElecSounds)], v.SoundVolume or SNDLVL_NORM, math.random(v.MinSoundPitch, v.MaxSoundPitch), 1, 2)
						end

						v:TempBehaveThread(function(v)
							local seq = v.SparkySequences[math.random(#v.SparkySequences)]
							local id, time = v:LookupSequence(seq)
							v:PlaySequenceAndWait(seq)
						end)
					end

					v.MarkedByCherry = true
					v:TakeDamageInfo(damage)

					if damage:GetDamage() > v:Health() then
						count = count + 1
					end
				end
			end
		end

		ply:SetNW2Int("nz.CherryCount", ply:GetNW2Int("nz.CherryCount", 0) + 1)
		ply:SetNW2Float("nz.CherryDelay", CurTime() + 10)

		if IsFirstTimePredicted() then
			ParticleEffectAttach("nz_perks_cherry", PATTACH_ABSORIGIN_FOLLOW, ply, 0)
			ply:EmitSound("NZ.Cherry.Shock")
			if ply:HasUpgrade("cherry") or proc >= 1 then
				ply:EmitSound("NZ.Cherry.Sweet")
			end
		end

		if SERVER then
			timer.Simple(scale, function()
				if not IsValid(ply) then return end
				ply:StopParticles()

				if count and count >= 12 then
					if not ply.bo3cherryachv and TFA.BO3GiveAchievement then
						TFA.BO3GiveAchievement("A Burst of Flavor", "vgui/overlay/achievment/cherry.png", ply)
						ply.bo3cherryachv = true
					end
				end
			end)
		end
	end
end)

if CLIENT then
	local zmhud_icon_headshot = Material("nz_moo/icons/hud_headshoticon.png", "smooth unlitgeneric")
	local zmhud_icon_marker = Material("nz_moo/icons/marker.png", "smooth unlitgeneric")

	local blur_mat = Material("pp/bokehblur")
	local function MyDrawBokehDOF(fac)
		render.UpdateScreenEffectTexture()
		render.UpdateFullScreenDepthTexture()
		blur_mat:SetTexture("$BASETEXTURE", render.GetScreenEffectTexture())
		blur_mat:SetTexture("$DEPTHTEXTURE", render.GetResolvedFullFrameDepth())
		blur_mat:SetFloat("$size", fac * 4)
		blur_mat:SetFloat("$focus", 1)
		blur_mat:SetFloat("$focusradius", 10*fac)
		render.SetMaterial(blur_mat)
		render.DrawScreenQuad()
	end

	local tab = {
		["$pp_colour_addr"] = 0.05,
		["$pp_colour_addg"] = 0.2,
		["$pp_colour_addb"] = 0.0,
		["$pp_colour_brightness"] = 0.0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1.1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0,
	}

	local function ScreenEffects()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if ply:HasVultureStink() then
			DrawColorModify(tab)
		end
		if ply:HasPerkBlur() then
			MyDrawBokehDOF(ply:PerkBlurIntensity())
		end
	end

	local function ElementalHUD()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if ply:HasPerk("pop") then
			local fadefac = 0
			local PopDelay = ply:GetNW2Float("nz.EPopDecay", 0)
			local PopEffect = ply:GetNW2Int("nz.EPopEffect", 1)

			if PopDelay > CurTime() then
				fadefac = PopDelay - CurTime()
				fadefac = math.Clamp(fadefac / 2, 0, 1)
			end

			if fadefac > 0 then
				surface.SetMaterial(nzPerks.EPoPIcons[PopEffect])
				surface.SetDrawColor(ColorAlpha(color_white, 300*fadefac))
				surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 128)
			end
		end

		if ply:HasPerk("deadshot") then
			local fadefac = 0
			local notifdelay = ply:GetNW2Float("nz.DeadshotDecay", 0)
			if notifdelay > CurTime() then
				fadefac = notifdelay - CurTime()
				fadefac = math.Clamp(fadefac / 1, 0, 1)
			end

			if fadefac > 0 then
				surface.SetMaterial(zmhud_icon_headshot)
				surface.SetDrawColor(ColorAlpha(color_white, 300*fadefac))
				surface.DrawTexturedRect(ScrW() / 2 - 32, ScrH() / 2 - 32, 64, 128)
			end
		end
	end

	local PixVis = {}
	hook.Add('OnEntityCreated', 'nzSetupDeathVis', function(ent)
		if IsValid(ent) and ent:IsValidZombie() then
			PixVis[ent] = util.GetPixelVisibleHandle()
		end
	end)

	local color_red = Color(255, 0, 0, 255)
	local dim = Material( "sprites/splodesprite" )

	local function DeathHalo()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if not ply:HasPerk("death") then return end

		local pos = ply:GetPos()
		local range = 160000 //400^2
		local tooclose = 784 //28^2

		for i, ent in nzLevel.GetZombieArray() do
			if not IsValid(ent) then continue end
			if ent:IsValidZombie() and ent:Alive() and ent:GetCreationTime() + engine.TickInterval() < CurTime() then
				local epos = ent:GetPos()
				local dist = pos:DistToSqr(epos)
				if dist > range then continue end
				if dist < 784 then continue end

				local ang = ply:EyeAngles()
				local dir = Angle(0,ang.yaw,ang.roll):Forward()
				local facing = (epos - pos):GetNormalized()

				if facing:Dot(dir) > 0.45 then
					local fac = 1 - math.Clamp(dist / range, 0, 1)
					local visible = util.PixelVisible(ent:WorldSpaceCenter(), 26, PixVis[ent])

					if visible <= 0 then
						if not ent.pixrendertime then //this is hacky
							ent.pixrendertime = CurTime() + 0.1
							continue
						end

						if ent.pixrendertime and ent.pixrendertime > CurTime() then continue end

						halo.Add({[1] = ent}, ColorAlpha(color_red, 300*fac), 2*fac, 2*fac, 2, true, true)
					end
				end
			end
		end
	end

	/*local function DeathLungeHUD(bdepth, bskybox)
		//if not cl_drawhud:GetBool() then return end
		if bskybox then return end

		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if not ply:HasPerk("death") then return end
		if not ply.GetKnifingTarget then return end

		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) or not wep.CanKnifeLunge then return end

		local ent = ply:GetKnifingTarget()
		if not IsValid(ent) then return end

		if ent:IsValidZombie() and ent:Alive() then
			local render_ang = EyeAngles()
			render_ang:RotateAroundAxis(render_ang:Right(), 90)
			render_ang:RotateAroundAxis(-render_ang:Up(), 90)

			local size = ScreenScale(24)
			local pos = ent:WorldSpaceCenter()
			local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
			if !headbone then headbone = ent:LookupBone("j_neck") end
			if headbone then
				pos = ent:GetBonePosition(headbone)
			end

			cam.Start3D2D(pos, render_ang, 0.24)
				cam.IgnoreZ(true)
				surface.SetMaterial(zmhud_icon_marker)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(-(size)/2, -(size)/2, size, size)
				cam.IgnoreZ(false)
			cam.End3D2D()
		end
	end*/

	hook.Add("PreDrawHalos", "nzDeathHalo", DeathHalo ) 
	hook.Add("RenderScreenspaceEffects", "nzscreeneffectsHUD", ScreenEffects )
	//hook.Add("PostDrawTranslucentRenderables", "nzDeathKnifeHUD", DeathLungeHUD )
	hook.Add("HUDPaint", "elementalHUD", ElementalHUD)
end
