ENT.Type = "anim"

ENT.PrintName		= "buyable_ending"
ENT.Author			= "Laby"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.bPhysgunNoCollide = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Bool", 0, "KeepPlaying")
	self:NetworkVar("Bool", 1, "RewardPerks")
	self:NetworkVar("Bool", 2, "PermaPerks")
	self:NetworkVar("String", 0, "HintString")
	self:NetworkVar("String", 1, "CustomText")
end

AddCSLuaFile()

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel( "models/hoff/props/teddy_bear/teddy_bear.mdl" )
	end
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	self.Used = false
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use( activator, caller )
	if nzRound:Victory() then return end

	if nzRound:InState(ROUND_CREATE) and activator:IsInCreative() then
		nzRound:SetVictory(true)

		self:EmitSound("nz_moo/ee/affirm.mp3", SNDLVL_NORM, math.random(95, 105))

		local time = nzRound:GameOverDuration()
		local mapcamtime = nzMapping.Settings.gocamerawait
		local mapcamstart = nzMapping.Settings.gocamerastart
		local mapcamend = nzMapping.Settings.gocameraend
		local mytext = self:GetCustomText()

		if !self:GetKeepPlaying() then
			if !mapcamstart or table.IsEmpty(mapcamstart) then
				local spawns = ents.FindByClass("player_spawns")
				local zspawns = ents.FindByClass("nz_spawn_zombie_normal")
				if not IsValid(spawns[1]) then return end
				if not IsValid(zspawns[1]) then return end

				local poses = {}
				local zposes = {}
				for k, v in pairs(spawns) do
					poses[#poses + 1] = v:GetPos()
				end
				for k, v in pairs(zspawns) do
					zposes[#zposes + 1] = v:GetPos()
				end

				local sum = Vector(0,0,0)
				for _, v3 in pairs(poses) do
					sum = sum + v3
				end
				local startpos = (sum / #poses) + vector_up*72

				local zsum = Vector(0,0,0)
				for _, v3 in pairs(zposes) do
					zsum = zsum + v3
				end
				local endpos = (zsum / #zposes) + vector_up*72

				local size = Vector(5,5,5)
				debugoverlay.Box(startpos , -size, size, time*2, color_white)
				debugoverlay.Line(startpos, endpos, time*2, color_white, true)
				debugoverlay.Box(endpos, -size, size, time*2, color_white)

				timer.Simple(mapcamtime, function()
					activator:ScreenFade(SCREENFADE.IN, color_black, 2, engine.TickInterval())

					nzEE.Cam:QueueView(time - mapcamtime, startpos, endpos, nil, true, nil, activator)
					nzEE.Cam:Begin(activator)
				end)
			elseif mapcamstart and mapcamend then
				timer.Simple(mapcamtime, function()
					activator:ScreenFade(SCREENFADE.IN, color_black, 2, engine.TickInterval())

					local ourtime = (time - mapcamtime)*(1/#mapcamstart)
					for id, pos in pairs(mapcamstart) do
						nzEE.Cam:QueueView(ourtime, pos, mapcamend[id], nil, true, nil, activator)
					end

					nzEE.Cam:Begin(activator)
				end)
			end

			activator:Freeze(true)
			timer.Simple(time, function()
				if not IsValid(activator) then return end
				activator:Freeze(false)
			end)
		end

		local gameovertext = (activator:KeyDown(IN_SPEED) or activator:KeyDown(IN_WALK)) and nzMapping.Settings.gameovertext or nzMapping.Settings.gamewintext
		local survivedtext = (activator:KeyDown(IN_WALK) and nzMapping.Settings.infinitytext) or (activator:KeyDown(IN_SPEED) and nzMapping.Settings.survivedtext) or nzMapping.Settings.escapedtext
		if mytext ~= "" then
			survivedtext = mytext
		end

		net.Start("nz_game_end_notif")
			net.WriteString(tostring(gameovertext))
			net.WriteString(tostring(survivedtext))
		net.Broadcast()

		nzSounds:Play("GameEnd", activator)

		nzRound:SetVictory(false)
		return
	end

	if nzRound:InProgress() and activator:CanAfford(self:GetPrice()) then
		self:EmitSound("nz_moo/ee/affirm.mp3", 511, math.random(95, 105))
		activator:TakePoints(self:GetPrice())

		nzRound:Win(self:GetCustomText(), self:GetKeepPlaying())

		local plys = player.GetAll()
		if self:GetPermaPerks() and nzRound:InProgress() then
			for _, ply in pairs(plys) do
				ply:SetPreventPerkLoss(true)
			end
		end
		if self:GetRewardPerks() and nzRound:InProgress() then
			for _, ply in pairs(plys) do
				ply:GiveAllPerks()
			end
		end
	end
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end

if CLIENT then
	function ENT:GetNZTargetText()
		if nzRound:Victory() then return end

		if !LocalPlayer():KeyDown(IN_WALK) and nzRound:InState(ROUND_CREATE) then
			local keepplaying = self:GetKeepPlaying() and " | Keep Playing" or ""
			local giveperks = self:GetRewardPerks() and " | Reward Perks" or ""
			local permaperks = self:GetPermaPerks() and " | Perma Perks" or ""
			local customtext = self:GetCustomText() ~= "" and " | '"..self:GetCustomText().."'" or ""
			return "Buyable Ending | '"..self:GetHintString().."'' | "..string.Comma(self:GetPrice()).." Price"..keepplaying..giveperks..permaperks..customtext
		end

		local price = self:GetPrice() > 0 and " [Cost: "..string.Comma(self:GetPrice()).."]" or ""
		local myhint = self:GetHintString() ~= "" and self:GetHintString() or "End game"
		return "Press "..string.upper(input.LookupBinding("+USE")).." - "..myhint..price
	end

	function ENT:Draw()
		if DynamicLight then
			local dlight = DynamicLight(self:EntIndex(), false)
			if (dlight) then
				local color = nzMapping.Settings.zombieeyecolor or Color(40, 255, 60, 255)
				dlight.pos = self:WorldSpaceCenter()
				dlight.r = color.r
				dlight.g = color.g
				dlight.b = color.b
				dlight.brightness = 1
				dlight.Decay = 1000
				dlight.Size = 128
				dlight.DieTime = CurTime() + 0.5
			end
		end

		self:DrawModel()
	end
end
