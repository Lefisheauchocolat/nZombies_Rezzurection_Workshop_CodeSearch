if SERVER then
	-- Scroll down to the functions you can use
	-- This here is so that the server can follow (for PVS etc)

	nzEE.Cam = nzEE.Cam or {}
	util.AddNetworkString("nzEECamera")
	util.AddNetworkString("nzEECameraData")

	local queue = queue or {}
	local playerqueue = playerqueue or {}

	local nextqueuetime

	local curqueueinsert = 0
	local curplayerqueinsert = 0

	local function NextCamQueue(ply)
		local q = IsValid(ply) and playerqueue[ply][1] or queue[1]
		if !q then
			hook.Remove("Think", "nzEECameraThink")
			return
		end

		nextqueuetime = CurTime() + q.time

		local time = nextqueuetime
		local camtime = q.time
		local startpos = q.startpos
		local endpos = q.endpos
		local queplayer = q.player
		local follower = q.followplayer

		if startpos and endpos then
			local dir = endpos - startpos
			hook.Add("SetupPlayerVisibility", "nzEndCameraPVS", function(ply, viewEnt)
				if !IsValid(queplayer) or queplayer == ply then
					local delta = math.Clamp((time-CurTime())/camtime, 0, 1)
					if follower and IsValid(queplayer) then
						endpos = queplayer:EyePos()
						dir = endpos - startpos
					end

					local pos = endpos - dir*delta

					if viewEnt:IsValid() then
						if !viewEnt:TestPVS(pos) then
							AddOriginToPVS(pos)
						end
					elseif !ply:TestPVS(pos) then
						AddOriginToPVS(pos)
					end
				end

				if time < CurTime() then
					hook.Remove("SetupPlayerVisibility", "nzEndCameraPVS")
				end
			end)
		end

		if q.func then q.func() end
	end

	local function StartCamQueue(ply)
		local start = IsValid(ply) and playerqueue[ply][1] or queue[1]
		if !start then return end

		nextqueuetime = CurTime() + start.time
		NextCamQueue()

		hook.Add("Think", "nzEECameraThink", function()
			if CurTime() >= nextqueuetime then
				
				if ply then
					table.remove(playerqueue, 1)
					curplayerqueinsert = curplayerqueinsert - 1
				else
					table.remove(queue, 1)
					curqueueinsert = curqueueinsert - 1
				end

				if start.viewpunch and start.viewpunch ~= angle_zero and IsValid(start.player) and start.player:GetInfoNum("nz_sky_intro_viewpunch", 1) > 0 then
					start.player:ViewPunch(start.viewpunch)
				end

				NextCamQueue()
			end
		end)
	end

	--[[ Functions in here can be queued clientside by running them along QueueView
	E.g. doing this:
		nzEE.Cam:QueueView(10)
		nzEE.Cam:Text("Hey")
		nzEE.Cam:QueueView(10)
		nzEE.Cam:Text("Hello")
	would display "Hey" for 10 seconds and then "Hello" for 10 seconds after a 10 second queue

	If QueueView is called with positional arguements, it will render a moving camera between these positions for this duration
	Each view is transitioned by a fade-to-black. If called without positions, just renders from eyes (can be used to queue)

	All other functions run along the previously called QueueView and will be drawn under the fade-to-black

	ply is optional and will run the cameras only on that player - Leave it empty for all players (default)
	
	//replaced scoreboard variable with viewpunch angle as we use the NZU scoreboard and it previously did nothing
	]]

	function nzEE.Cam:QueueView(time, pos1, pos2, angle, fade, viewpunch, ply)
		net.Start("nzEECamera")
			net.WriteUInt(0, 4) -- Indicates which function is called
			net.WriteFloat(math.min(time, 255))

			if pos1 then
				net.WriteBool(true)
				net.WriteVector(pos1)

				if pos2 then
					net.WriteBool(true)
					net.WriteVector(pos2)
				else
					net.WriteBool(false)
				end

				if angle then
					net.WriteBool(true)
					net.WriteAngle(angle)
				else
					net.WriteBool(false)
				end
			else
				net.WriteBool(false)
			end

			//fade screen to black after 75% of camera time passes
			if fade then
				net.WriteBool(true)
			else
				net.WriteBool(false)
			end

			if IsValid(ply) then
				if not playerqueue[ply] then playerqueue[ply] = {} end
				curplayerqueinsert = curplayerqueinsert + 1
				playerqueue[ply][curplayerqueinsert] = {time = time}
			else
				curqueueinsert = curqueueinsert + 1
				queue[curqueueinsert] = {time = time}
			end

			local q = queue[curqueueinsert]
			if IsValid(ply) then
				q = playerqueue[ply][curplayerqueinsert]
			end

			if pos1 then
				q.startpos = pos1
				q.endpos = pos2 or pos1
			end

			//added to differentiate between players (previously applied PVS changes to all players)
			if ply then
				q.player = ply
			end

			//viewpunch called serverside after current camera queue ends
			if viewpunch and isangle(viewpunch) and viewpunch ~= angle_zero then
				q.viewpunch = viewpunch
			end
		return ply and net.Send(ply) or net.Broadcast()
	end

	//use this for more fine tunining with camera data
	//see sh_player_create.lua for example
	function nzEE.Cam:QueueViewData(data, ply)
		if not data then return end

		net.Start("nzEECameraData")
			if IsValid(ply) then
				if not playerqueue[ply] then playerqueue[ply] = {} end

				curplayerqueinsert = curplayerqueinsert + 1
				playerqueue[ply][curplayerqueinsert] = {time = data.time}
			else
				curqueueinsert = curqueueinsert + 1
				queue[curqueueinsert] = {time = data.time}
			end

			local queuedata = queue[curqueueinsert]
			if IsValid(ply) then
				queuedata = playerqueue[ply][curplayerqueinsert]
			end

			if data.start then
				queuedata.startpos = data.start
				queuedata.endpos = data.endpos or data.start
			end
			if IsValid(ply) then
				queuedata.player = ply
			end
			if data.viewpunch then
				if data.viewpunch ~= angle_zero then
					queuedata.viewpunch = data.viewpunch
				end
				table.RemoveByValue(data, data.viewpunch)
			end
			if data.followplayer then
				queuedata.followplayer = data.followplayer
			end

			net.WriteTable(data)
		return ply and net.Send(ply) or net.Broadcast()
	end

	function nzEE.Cam:Text(msg, ply)
		if !msg then return end
		net.Start("nzEECamera")
			net.WriteUInt(1, 4) -- Text
			net.WriteString(msg)
		return ply and net.Send(ply) or net.Broadcast()
	end

	function nzEE.Cam:Music(path, ply)
		if !path then return end
		net.Start("nzEECamera")
			net.WriteUInt(2, 4) -- Music
			net.WriteString(path)
		return ply and net.Send(ply) or net.Broadcast()
	end

	function nzEE.Cam:Begin(ply)
		net.Start("nzEECamera")
			net.WriteUInt(3, 4) -- Start
			StartCamQueue(ply) -- Server needs to follow to add PVS' and run functions
		return ply and net.Send(ply) or net.Broadcast()
	end

	-- You can use this to set a function to run with this queue
	function nzEE.Cam:Function(func, ply)
		local q = queue[curqueueinsert]
		if IsValid(ply) then
			q = playerqueue[ply][curplayerqueinsert]
		end

		q.func = func
	end
end

if CLIENT then
	local cvar_bloom = GetConVar("nz_sky_intro_bloom")

	local musicchannel = nil
	local queue = queue or {}
	local nextqueuetime
	local curqueueinsert = 0

	local function FadeCam(fadetime)
		local fade = 0
		local fadeup = true
		local startfade = CurTime()
		hook.Add("HUDPaint", "nzEECameraFade", function()
			fade = fadeup and 255*(1 - math.Clamp(((startfade + fadetime) - CurTime())/fadetime, 0, 1)) or math.max(fade - 255*RealFrameTime(), 0)
			if fade >= 255 then
				fadeup = false
			end

			surface.SetDrawColor(ColorAlpha(color_black, fade))
			surface.DrawRect(0, 0, ScrW(), ScrH())

			if fade <= 0 and !fadeup then
				hook.Remove("HUDPaint", "nzEECameraFade")
			end
		end)
	end

	local function BloomCam(fadetime)
		if !cvar_bloom:GetBool() then return end

		local fade = 0
		local fadeup = true
		local startfade = CurTime()
		hook.Add("RenderScreenspaceEffects", "nzEECameraBloom", function()
			fade = fadeup and (1 - math.Clamp(((startfade + fadetime) - CurTime())/fadetime, 0, 1)) or math.max(fade - 2*RealFrameTime(), 0)
			if fade >= 1 then
				fadeup = false
			end

			DrawBloom(1*(math.Clamp(1 - fade, 0, 1)), 2.5*fade, 10*fade, 10*fade, 2*fade, 1*fade, 1, 1, 1)

			if fade <= 0 and !fadeup then
				hook.Remove("RenderScreenspaceEffects", "nzEECameraBloom")
			end
		end)
	end

	local function NextCamQueue()
		local q = queue[1]
		if !q then
			hook.Remove("Think", "nzEECameraThink")
			return
		end

		nextqueuetime = CurTime() + q.time

		local time = nextqueuetime
		local camtime = q.time
		local startpos = q.startpos
		local endpos = q.endpos

		if startpos and endpos then
			local dir = endpos - startpos
			local ang = q.ang or dir:Angle()

			local rot = q.rotation or false
			local timetorotate = (q.time*(q.rotateratio or 1))
			local rotstart = q.rotation and nextqueuetime - timetorotate or math.huge

			local follower = q.followplayer

			if not q.allowmove then
				hook.Add("CreateMove", "nzEECamera", function(cmd)
					if time < CurTime() then
						hook.Remove("CreateMove", "nzEECamera")
					end

					cmd:ClearButtons()
					cmd:ClearMovement()
				end)
			end

			hook.Add("PlayerSwitchWeapon", "nzEECamera", function(ply, oldwep, newwep)
				if time < CurTime() then
					hook.Remove("PlayerSwitchWeapon", "nzEECamera")
				end

				if IsValid(newwep) and newwep.NZSpecialCategory then
					return true //block using special weapons during animation even if movement allowed
				end
			end)

			hook.Add("CalcView", "nzEECamera", function(ply, origin, angles, fov, znear, zfar)
				if time < CurTime() then
					hook.Remove("CalcView", "nzEECamera")
				end

				local delta = math.Clamp((time-CurTime())/camtime, 0, 1)
				if follower and IsValid(ply) then
					endpos = ply:EyePos()
					dir = endpos - startpos
				end
				local pos = endpos - dir*delta

				//rotate screen mid camera queue
				local finalang = ang
				if rot and rotstart < CurTime() then
					local rotratio = (1 - math.Clamp((nextqueuetime - CurTime())/timetorotate, 0, 1))
					finalang = LerpAngle(rotratio, ang, rot)
				end

				//surface.PlaySound stopped syncing with the player view when overriden by calcview
				if musicchannel and IsValid(musicchannel) then
					musicchannel:Play()
					musicchannel:SetPos(pos)
				end

				return {origin = pos, angles = finalang, drawviewer = (delta > 0)}
			end)

			hook.Add("CalcViewModelView", "nzEECamera", function(wep, vm, oldpos, oldang, pos, ang)
				if time < CurTime() then
					hook.Remove("CalcViewModelView", "nzEECamera")
				end

				return pos, ang
			end)
		end

		if q.fade then
			local fadetime = (q.time*(q.faderatio or 0.25))
			local fadestart = nextqueuetime - fadetime

			hook.Add("Think", "nzEECamera", function()
				if fadestart < CurTime() then
					FadeCam(fadetime)
					hook.Remove("Think", "nzEECamera")
				end
			end)
		end

		if q.bloom then
			local fadetime = (q.time*(q.faderatio or 0.25))
			local fadestart = nextqueuetime - fadetime

			hook.Add("Think", "nzEECameraBloom", function()
				if fadestart < CurTime() then
					BloomCam(fadetime)
					hook.Remove("Think", "nzEECameraBloom")
				end
			end)
		end

		local text = q.text
		if text then
			local w, h = ScrW(), ScrH()
			local scale = (ScrW()/1920 + 1)/2
			local wscale = w/1920*scale

			local font = "nz.main."..GetFontType(nzMapping.Settings.mainfont)
			local fontColor = !IsColor(nzMapping.Settings.textcolor) and color_white or nzMapping.Settings.textcolor

			local n_starttime = CurTime()
			hook.Add("HUDPaint", "nzEECamera", function()
				local fade = 1 - math.Clamp(((n_starttime + math.min(camtime*0.5, 1)) - CurTime())/math.min(camtime*0.5, 1), 0, 1)

				draw.SimpleTextOutlined(text, font, w/2, 285*scale, ColorAlpha(fontColor, 255*fade), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM, (nzMapping.Settings.fontthicc or 2), ColorAlpha(color_black, 100*fade))

				if time < CurTime() then
					hook.Remove("HUDPaint", "nzEECamera")
				end
			end)
		end

		local music = q.music
		if music then
			hook.Add("Think", "nzEEMusic", function()
				hook.Remove("Think", "nzEEMusic")

				sound.PlayFile("sound/"..music, "noplay", function(station, errCode, errStr)
					if (IsValid(station)) then
						station:Set3DEnabled(true)
						station:SetPlaybackRate(GetConVar("host_timescale"):GetFloat())
						musicchannel = station
					else
						print("Error playing easter egg camera music!", errCode, errStr)
					end
				end)
			end)
		end
	end

	local function StartCamQueue()
		local start = queue[1]
		if !start then return end

		if musicchannel and IsValid(musicchannel) then
			musicchannel:Stop()
		end
		musicchannel = nil
		nextqueuetime = CurTime() + start.time
		NextCamQueue()

		hook.Add("Think", "nzEECameraThink", function()
			if CurTime() > nextqueuetime then
				table.remove(queue, 1)
				curqueueinsert = curqueueinsert - 1
				NextCamQueue()
			end
		end)
	end

	local queuefunctions = {
		[0] = function() -- QueueView
			local time = net.ReadFloat()

			curqueueinsert = curqueueinsert + 1
			queue[curqueueinsert] = {time = time}
			local q = queue[curqueueinsert]

			if net.ReadBool() then
				local pos1 = net.ReadVector()
				local pos2 = nil

				if net.ReadBool() then
					pos2 = net.ReadVector()
				end
				pos2 = pos2 or pos1

				if net.ReadBool() then
					ang = net.ReadAngle()
				else
					ang = (pos2 - pos1):Angle()
				end				

				q.startpos = pos1
				q.endpos = pos2
				q.ang = ang
			end

			if net.ReadBool() then
				q.fade = true
				q.faderatio = 0.25
			end
		end,
		[1] = function() -- Text
			local msg = net.ReadString()
			
			local q = queue[curqueueinsert]
			q.text = msg
		end,
		[2] = function() -- Music
			local path = net.ReadString()
			
			local q = queue[curqueueinsert]
			q.music = path
		end,
		[3] = function() -- Start queue
			StartCamQueue()
		end,
		[4] = function(data) --Custom structured queue data
			curqueueinsert = curqueueinsert + 1
			queue[curqueueinsert] = {time = data.time}
			local q = queue[curqueueinsert]

			if data.start then
				q.startpos = data.start
				q.endpos = data.endpos or data.start
				q.ang = data.angle or ((data.endpos or data.start) - data.start):Angle()
			end

			if data.fade then
				q.fade = true
				if data.faderatio then
					q.faderatio = data.faderatio
				end
			end

			if data.rotation then
				q.rotation = data.rotation
				if data.rotateratio then
					q.rotateratio = data.rotateratio
				end
			end

			if data.followplayer then
				q.followplayer = data.followplayer
			end

			if data.allowmove then
				q.allowmove = data.allowmove
			end

			if data.bloom then
				q.bloom = data.bloom
			end
		end,
	}

	//new easter egg camera system
	local function ReceiveQueuedCam()
		local func = net.ReadUInt(4)
		queuefunctions[func]()
	end
	net.Receive("nzEECamera", ReceiveQueuedCam)

	//use this for more fine tuning
	local function ReceiveQueuedCamData()
		queuefunctions[4](net.ReadTable())
	end
	net.Receive("nzEECameraData", ReceiveQueuedCamData)

	//legacy game over camera system
	local function ShowWinScreen()
		local easteregg = net.ReadBool()
		local win = net.ReadBool()
		local msg = net.ReadString()
		local camtime = net.ReadFloat()
		local time = CurTime() + camtime
		local endcam = net.ReadBool()
		
		local startpos, endpos
		if endcam then
			startpos = net.ReadVector()
			endpos = net.ReadVector()
		end
		
		local w = ScrW() / 2
		local h = ScrH() / 2
		local font = "DermaLarge"
		
		if endcam and startpos and endpos and time then
			local dir = endpos - startpos
			local ang = dir:Angle()
			hook.Add("CalcView", "nzCalcEndCameraView", function(ply, origin, angles, fov, znear, zfar)
				if time < CurTime() then
					hook.Remove("CalcView", "nzCalcEndCameraView")
				end

				local delta = math.Clamp((time-CurTime())/camtime, 0, 1)
				local pos = endpos - dir*delta

				return {origin = pos, angles = ang, drawviewer = true}
			end)
			hook.Add("CalcViewModelView", "nzCalcEndCameraView", function(wep, vm, oldpos, oldang, pos, ang)
				if time < CurTime() then
					hook.Remove("CalcViewModelView", "nzCalcEndCameraView")
				end

				return oldpos - ang:Forward()*50, ang
			end)
		end

		hook.Add("HUDPaint", "nzDrawEEEndScreen", function()
			draw.SimpleText(msg, font, w, h, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			if time < CurTime() then
				hook.Remove("HUDPaint", "nzDrawEEEndScreen")
			end
		end)

		if easteregg then
			if win then
				surface.PlaySound(GetGlobalString("winmusic", "nz/easteregg/motd_standard.wav"))
			else
				surface.PlaySound(GetGlobalString("losemusic", "nz/round/game_over_4.mp3"))
			end
		end
	end

	net.Receive("nzMajorEEEndScreen", ShowWinScreen)
end
