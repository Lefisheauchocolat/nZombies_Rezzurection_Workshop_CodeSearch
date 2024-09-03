AddCSLuaFile()
ENT.Spawnable = true
ENT.Category = "nz TEST"
ENT.PrintName = "Bubblegum Machine"
ENT.Author = "sky"

ENT.Base = "base_entity"
ENT.Type = "anim"

ENT.next_lightsound = 0
ENT.next_turnofflights = false

ENT.idle_time = CurTime() + math.random(15,120)
ENT.idle_flourish = math.random(3)

ENT.use_cooldown = CurTime() + 0

local _sp = game.SinglePlayer()

local cooldowns = {
	.9,
	.4,
	.4,
	.4,
	.4,
	.9,
	.9
}
local cooldowns_lights = {
	[2] = 4,
	[3] = 5,
	[4] = 6,
	[5] = 7,
	[6] = 6,
	[7] = 5,
}

local gumball_joints = {
	[nzGum.RareTypes.DEFAULT] = {
		[nzGum.Types.USABLE] = "tag_gumball_activated_base",
		[nzGum.Types.USABLE_WITH_TIMER] = "tag_gumball_activated_base",
		[nzGum.Types.TIME] = "tag_gumball_time_base",
		[nzGum.Types.ROUNDS] = "tag_gumball_rounds_base",
		[nzGum.Types.SPECIAL] = "tag_gumball_event_base",
	},
	[nzGum.RareTypes.MEGA] = {
		[nzGum.Types.USABLE] = "tag_gumball_activated_speckled",
		[nzGum.Types.USABLE_WITH_TIMER] = "tag_gumball_activated_speckled",
		[nzGum.Types.TIME] = "tag_gumball_time_speckled",
		[nzGum.Types.ROUNDS] = "tag_gumball_rounds_speckled",
		[nzGum.Types.SPECIAL] = "tag_gumball_event_speckled",
	},
	[nzGum.RareTypes.RAREMEGA] = {
		[nzGum.Types.USABLE] = "tag_gumball_activated_shiny",
		[nzGum.Types.USABLE_WITH_TIMER] = "tag_gumball_activated_shiny",
		[nzGum.Types.TIME] = "tag_gumball_time_shiny",
		[nzGum.Types.ROUNDS] = "tag_gumball_rounds_shiny",
		[nzGum.Types.SPECIAL] = "tag_gumball_event_shiny",
	},
	[nzGum.RareTypes.ULTRARAREMEGA] = {
		[nzGum.Types.USABLE] = "tag_gumball_activated_swirl",
		[nzGum.Types.USABLE_WITH_TIMER] = "tag_gumball_activated_swirl",
		[nzGum.Types.TIME] = "tag_gumball_time_swirl",
		[nzGum.Types.ROUNDS] = "tag_gumball_rounds_swirl",
		[nzGum.Types.SPECIAL] = "tag_gumball_event_swirl",
	},
	[nzGum.RareTypes.PINWHEEL] = {
		[nzGum.Types.USABLE] = "tag_gumball_activated_pinwheel",
		[nzGum.Types.USABLE_WITH_TIMER] = "tag_gumball_activated_pinwheel",
		[nzGum.Types.TIME] = "tag_gumball_time_pinwheel",
		[nzGum.Types.ROUNDS] = "tag_gumball_rounds_pinwheel",
		[nzGum.Types.SPECIAL] = "tag_gumball_event_pinwheel",
	},
}
local spinball_joins = {
	[nzGum.Types.USABLE] = "tag_gumball_activated_",
	[nzGum.Types.USABLE_WITH_TIMER] = "tag_gumball_activated_",
	[nzGum.Types.TIME] = "tag_gumball_time_",
	[nzGum.Types.ROUNDS] = "tag_gumball_rounds_",
	[nzGum.Types.SPECIAL] = "tag_gumball_event_",
}

function ENT:Initialize()
	self.AutomaticFrameAdvance = true

	self:SetModel("models/bo3/gobblegum/gobblegum_machine.mdl")
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )

	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:UseTriggerBounds(true, 4)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion( false )
		phys:AddGameFlag(FVPHYSICS_NO_IMPACT_DMG)
		phys:Wake()
	end

	self:ResetSequence(self:LookupSequence("idle"))
	self:ManipulateBoneScale(self:LookupBone("tag_gumball_ghost"), Vector(0.0001, 0.0001, 0.0001))
	
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:ResetGumBones()
	end)

	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "CurrentUser")
	self:NetworkVar("String", 0, "CurrentGum")
	self:NetworkVar("Float", 0, "NextUse")
	self:NetworkVar("Bool", 0, "LightFlash")
	self:NetworkVar("Bool", 1, "LightsOn")
	self:NetworkVar("Bool", 2, "AllLightsOn")
	self:NetworkVar("Bool", 3, "Sharing")
	self:NetworkVar("Int", 0, "LightsStage")
end

function ENT:GetPrice(ply)
	local price = nzGum:GetCost(ply)
	return price
end

function ENT:GetIsRolling()
	local ct = CurTime()
	return ct < self:GetNextUse()
end

function ENT:Think()
	if SERVER then
		local ct = CurTime()
		if self.next_turnofflights and self.next_turnofflights < ct then
			self:TurnLightsOff()
			self.next_turnofflights = false
		end
		local isrolling = self:GetIsRolling()
		if isrolling then
			return
		end
		local gum = self:GetCurrentGum()
		if gum and gum != "" then
			return
		end

		if ct > self.next_lightsound then
			cooldowns_stage = self:GetLightsStage() + 1
			if cooldowns_stage > #cooldowns then
				cooldowns_stage = 1
			end
			self:SetLightsStage(cooldowns_stage)

			if cooldowns_stage == #cooldowns or cooldowns_stage == 1 then
				self:TurnLightsOn()
				self.next_turnofflights = ct + .5
			elseif cooldowns_lights[cooldowns_stage] then
				self:SetLightsOn(true)

				local lights_off = {5, 6, 7}
				table.RemoveByValue(lights_off, cooldowns_lights[cooldowns_stage])
				self:SetSubMaterial(cooldowns_lights[cooldowns_stage], "gummachine/mtl_p7_zm_zod_bubblegum_machine_light_bulb_on.vmt")

				for k, v in pairs(lights_off) do
					self:SetSubMaterial(v, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb.vmt")
				end

				if cooldowns_stage == 6 then
					self.next_turnofflights = ct + .5
				end
			end

			self.next_lightsound = ct + cooldowns[cooldowns_stage]
			self:EmitSound("bo3/gobblegum/machine/machine_light_on.mp3")
		end

		if ct > self.idle_time and ct > self.use_cooldown and !isrolling and !isflashing then
			local seq = {
				[1] = "Gumball_Growl",
				[2] = "Gumball_Yawn",
				[3] = "Gumball_Clean",
			}

			local lookup = self:LookupSequence(seq[self.idle_flourish])

			self.idle_time = ct + math.random(15,120)
			self.idle_flourish = math.random(3)

			self:SetCycle(0)
			self:ResetSequence(lookup)
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:ResetGumBones()
	for k, v in pairs(gumball_joints) do
		for k2, v2 in pairs(v) do
			local bone = self:LookupBone(v2)
			if bone and self:GetManipulateBoneScale(bone) == Vector(1,1,1) then
				self:ManipulateBoneScale(bone, Vector(0.000001, 0.000001, 0.000001))
			end
		end
	end

	for i=1, 10 do
		for k, v in pairs(spinball_joins) do
			local bone = self:LookupBone(v..(i-1))
			if bone and self:GetManipulateBoneScale(bone) == Vector(1,1,1) then
				self:ManipulateBoneScale(bone, Vector(0.0001, 0.0001, 0.0001))
			end
		end
	end
end

function ENT:TurnLightsOn(noskin)
	local gumdata = nzGum:GetData(self:GetCurrentGum())
	if !noskin and gumdata and gumdata.type then
		self:SetSkin(self:GetSharing() and 5 or gumdata.type)
	end

	self:SetAllLightsOn(true)
	self:SetLightsOn(true)
	self:SetSubMaterial(4, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb_top.vmt")
	self:SetSubMaterial(5, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb_row1.vmt")
	self:SetSubMaterial(6, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb_row2.vmt")
	self:SetSubMaterial(7, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb_row3.vmt")
end

function ENT:TurnLightsOff()
	self:SetSkin(0)

	self:SetAllLightsOn(false)
	self:SetLightsOn(false)
	self:SetSubMaterial(4, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb.vmt")
	self:SetSubMaterial(5, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb.vmt")
	self:SetSubMaterial(6, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb.vmt")
	self:SetSubMaterial(7, "models/bo3/gobblegum/mtl_p7_zm_zod_bubblegum_machine_light_bulb.vmt")
end

function ENT:GumDissapier()
	self:StopParticles()
	self:SetSkin(0)
	self:SetCurrentUser(nil)

	timer.Remove("nzGumMachine" .. self:EntIndex())
	timer.Remove("nzGumMachineEnd" .. self:EntIndex())

	self:SetCurrentGum("")
	self.next_lightsound = CurTime() + 2
	self:TurnLightsOff()
	self:SetLightFlash(false)
	self:SetSharing(false)
end

function ENT:RollRandomGum(ply)
	if nzRound:InState(ROUND_CREATE) or ply:IsInCreative() then
		local choices = {}
		for id, data in pairs(nzGum.Gums) do
			if nzMapping.Settings.gumlist and (!nzMapping.Settings.gumlist[id] or !nzMapping.Settings.gumlist[id][1]) then continue end
			if IsValid(ply) then
				if data.canroll and !data.canroll(ply, self) then continue end
				local pgum = nzGum:GetActiveGum(ply)
				if pgum and pgum == id then continue end
			end

			choices[id] = 1
		end

		return nzMisc.WeightedRandom(choices)
	end

	local choices = {}
	for id, data in pairs(nzGum.Gums) do
		if nzMapping.Settings.gumlist and (!nzMapping.Settings.gumlist[id] or !nzMapping.Settings.gumlist[id][1]) then continue end
		if data.multiplayer and (#player.GetAllPlaying() <= 1) then continue end
		if IsValid(ply) then
			if data.canroll and !data.canroll(ply, self) then continue end
			local pgum = nzGum:GetActiveGum(ply)
			if pgum and pgum == id then continue end
		end

		local rarity = data.rare or nzGum.RareTypes.DEFAULT
		local rolldata = nzGum.RollData[id]

		local count = nzGum.RollCounts[rarity]
		if rolldata and rolldata.count then
			count = rolldata.count
		end

		if count <= 0 then continue end

		local chance = nzGum.RollChance
		if rolldata and rolldata.chance then
			chance = rolldata.chance
		end

		local mult = nzGum.ChanceMultiplier[rarity]
		if nzMapping.Settings.gummultipliers and nzMapping.Settings.gummultipliers[rarity] then
			mult = nzMapping.Settings.gummultipliers[rarity]
		end

		choices[id] = chance * mult
	end

	if table.IsEmpty(choices) then
		return false
	end

	return nzMisc.WeightedRandom(choices)
end

function ENT:StartRolling(ply)
	local gum = self:RollRandomGum(ply)
	if !gum then return false end

	nzGum:SetPlayerPriceMultiplayer(ply, math.min(2, ply:GetNWInt("nzGumPriceMultiplier", 0) + 1))

	self:SetNextUse(CurTime() + 2.8)
	self:TurnLightsOff()
	self.next_turnofflights = false
	self.next_lightsound = 0
	self.cooldowns_stage = 0
	self:SetCurrentGum(gum)

	self:SetSkin(0)
	self:SetCycle(0)
	self:ResetSequence("Gumball_Flying"..math.random(2))
	self:ManipulateBoneScale(self:LookupBone("tag_gumball_ghost"), Vector(0.0001, 0.0001, 0.0001))
	self:ResetGumBones()

	local gumdata = nzGum:GetData(self:GetCurrentGum())
	if gumdata and gumdata.type and spinball_joins[gumdata.type] then
		local boner = self:LookupBone(spinball_joins[gumdata.type].."0")
		if boner then
			self:ManipulateBoneScale(boner, Vector(1, 1, 1))
		end
	end

	for i=1, 9 do
		for k, v in RandomPairs(spinball_joins) do
			local bone = self:LookupBone(v..(i))
			if bone then
				self:ManipulateBoneScale(bone, Vector(1, 1, 1))
				break
			end
		end
	end

	self:SetCurrentUser(ply)

	self:EmitSound("bo3/gobblegum/machine/machine_light_on.mp3")
	self:TurnLightsOn(true)
	self.next_turnofflights = CurTime() + .1
	local timername = "nzGumMachine" .. self:EntIndex()
	timer.Create(timername, .4, 0, function()
		if IsValid(self) then
			self:EmitSound("bo3/gobblegum/machine/machine_light_on.mp3")
			self:TurnLightsOn(true)
			self.next_turnofflights = CurTime() + .1
		else
			timer.Remove(timername)
		end
	end)

	timer.Simple(2.0, function()
		if !IsValid(self) then return end

		self:SetCycle(0)
		self:ResetSequence("Gumball_Leave")

		local gumdata = nzGum:GetData(self:GetCurrentGum())
		if gumdata then
			local gumtype = gumdata.type
			local gumrare = gumdata.rare or nzGum.RareTypes.DEFAULT

			for k, v in pairs(gumball_joints) do
				if k ~= gumrare then continue end

				for k2, v2 in pairs(v) do
					if k2 ~= gumtype then continue end

					local bone = self:LookupBone(v2)
					if bone then
						self:ManipulateBoneScale(bone, Vector(1,1,1))
					end
				end
			end
		end

		timer.Simple(0.8, function()
			if !IsValid(self) then return end

			self:SetLightFlash(true)
			self:EmitSound("bo3/gobblegum/machine/bgb_light_ready.mp3")
			self:TurnLightsOn()

			local ct = CurTime()
			self.next_turnofflights = ct + .2
			local timername = "nzGumMachine" .. self:EntIndex()
			timer.Create(timername, .8, 0, function()
				if IsValid(self) then
					ct = CurTime()
					self:EmitSound("bo3/gobblegum/machine/bgb_light_ready.mp3")
					self:TurnLightsOn()

					self.next_turnofflights = ct + .2
				else
					timer.Remove(timername)
				end
			end)

			local timernametwo = "nzGumMachineEnd"..self:EntIndex()
			timer.Create(timernametwo, 5.5, 1, function()
				if not IsValid(self) then return end
				
				self.idle_time = CurTime() + math.random(15,35)
				self:GumDissapier()
				self:SetNextUse(CurTime() + 2)

				timer.Simple(2, function()
					if not IsValid(self) then return end
					self:ResetGumBones()
				end)
			end)
		end)
	end)

	return true
end

function ENT:OnTakeDamage(dmginfo)
	local ply = dmginfo:GetAttacker()
	if not IsValid(ply) or not ply:IsPlayer() or !self:GetLightFlash() or self:GetIsRolling() or self:GetSharing() then return end

	if ply == self:GetCurrentUser() and bit.band(dmginfo:GetDamageType(), bit.bor(DMG_SLASH, DMG_CLUB, DMG_CRUSH)) ~= 0 then
		self:EmitSound("bo3/gobblegum/machine/bgb_light_ready.mp3")
		self:TurnLightsOn()

		local ct = CurTime()
		self.next_turnofflights = ct + .1
		local timername = "nzGumMachine" .. self:EntIndex()
		if timer.Exists(timername) then timer.Remove(timername) end

		timer.Create(timername, .4, 0, function()
			if IsValid(self) then
				ct = CurTime()
				self:EmitSound("bo3/gobblegum/machine/bgb_light_ready.mp3")
				self:TurnLightsOn()

				self.next_turnofflights = ct + .1
			else
				timer.Remove(timername)
			end
		end)

		self:SetSkin(5)
		self:SetSharing(true)
	end
end

function ENT:Use(activator, caller)
	if nzGum:GetMaxBuysPerRound(activator) >= 3 then return end
	if activator:GetUsingSpecialWeapon() then return end
	if self:GetIsRolling() then return end
	if GetGlobal2Bool("nzGumsEmpty", false) then return end
	if CurTime() < self.use_cooldown then return end

	self.use_cooldown = CurTime() + 2

	local gum = self:GetCurrentGum()
	if !gum or gum == "" then
		local price = self:GetPrice(activator)
		if nzRound:InState(ROUND_CREATE) or activator:IsInCreative() then
			price = 0
		end

		activator:Buy(price, self, function()
			if self:StartRolling(activator) then
				return true
			else
				activator:Buy(math.huge, self, function() return false end)
			end
			return false
		end)
		return
	end

	if IsValid(self:GetCurrentUser()) and self:GetCurrentUser() != activator and !self:GetSharing() then
		activator:Buy(math.huge, self, function() return false end)
		return
	end

	self:GumDissapier()
	self:ResetGumBones()

	nzGum:SetActiveGum(activator, gum)

	local rolldata = nzGum.RollData[gum]
	if rolldata then
		local gumdata = nzGum:GetData(gum)
		if !rolldata.roundgotin or (rolldata.roundgotin == 0) then
			rolldata.roundgotin = nzRound:GetNumber()
		end

		rolldata.chance = math.max((rolldata.chance or nzGum.RollChance) - 1, 1)
		rolldata.count = math.max((rolldata.count or nzGum.RollCounts[gumdata and (gumdata.rare or nzGum.RareTypes.DEFAULT)]) - 1, 0)

		local empty = true
		for i, data in pairs(nzGum.RollData) do
			if data.count and data.count > 0 then
				empty = false
				break
			end
		end

		if empty and !GetGlobal2Bool("nzGumsEmpty", false) then
			SetGlobal2Bool("nzGumsEmpty", true)
		end
	end

	if !nzRound:InState(ROUND_CREATE) then
		nzGum:AddToTotalBuys(activator)
	end

	local wep = activator:Give("tfa_nz_gum")
	wep:SetGum(gum)

	self.next_lightsound = CurTime() + 2

	self:SetCycle(0)
	self:ResetSequence("Gumball_Take")
end

function ENT:OnRemove()
	for _, ply in pairs(player.GetAll()) do
		nzGum:ResetTotalBuys(ply)
	end
end

if CLIENT then
	local nz_betterscaling = GetConVar("nz_hud_better_scaling")
	local usekey = "" .. string.upper(input.LookupBinding( "+use", true )) .. " - "

	local glowmat = Material("sprites/wallbuy_light.vmt")
	local color_lights = Color(255, 190, 95, 120)
	local color_red = Color(255, 0, 0, 255)
	local color_share = Color(120, 190, 20, 200)

	local fuckoff_lights = {
		[2] = 7,
		[3] = 3,
		[4] = 2,
		[5] = 1,
		[6] = 2,
		[7] = 3,
	}

	local fuckoff_dists = {
		[2] = 66,
		[3] = 32,
		[4] = 24,
		[5] = 12,
		[6] = 24,
		[7] = 32,
	}

	function ENT:GetNZTargetText()
		if self:GetIsRolling() then
			return ""
		end

		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if nzGum:GetMaxBuysPerRound(ply) >= 3 then
			return "Come back next round!"
		end

		if GetGlobal2Bool("nzGumsEmpty", false) then
			return "Out of gums!"
		end

		local gum = self:GetCurrentGum()
		if gum and gum != "" and !ply:GetUsingSpecialWeapon() then
			local gumdata = nzGum:GetData(gum) or {}

			local text = "Press "..usekey..""..(gumdata.name or "error")
			if IsValid(self:GetCurrentUser()) and self:GetCurrentUser() ~= ply then
				text = self:GetCurrentUser():Nick().."'s "..gumdata.name
			end

			if gumdata.icon then
				local size = 100
				local scw = ScrW()
				local sch = ScrH()

				local pscale = 1
				if nz_betterscaling:GetBool() then
					pscale = (scw/1920 + 1)/2
					size = size*pscale
				end

				local font = ("nz.small."..GetFontType(nzMapping.Settings.smallfont))
				local font2 = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))
				if pscale < 0.96 then
					font = ("nz.points."..GetFontType(nzMapping.Settings.smallfont))
					font2 = ("nz.ammo."..GetFontType(nzMapping.Settings.ammofont))
				end

				surface.SetFont(font)
				local tw, th = surface.GetTextSize(text)

				surface.SetMaterial(gumdata.icon)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect(scw / 2 - size / 2, sch - 280*pscale - (th+(size*0.75)), size, size)
			end

			return text
		end

		if nzRound:InState(ROUND_CREATE) then
			return "Press "..usekey.."Roll Gobblegum"
		end

		return "Press "..usekey.."Gobblegum [Cost: "..string.Comma(self:GetPrice(ply)).."]"
	end

	function ENT:Draw()
		self:DrawModel()

		local isrolling = self:GetIsRolling()
		local playerrolling = (isrolling and IsValid(self:GetCurrentUser()))
		local glowpos = (self:GetPos() + vector_up*(42)) + self:GetForward() * 14
		local glowcol, glowcol2 = color_lights, color_lights

		local gumdata = nzGum:GetData(self:GetCurrentGum())
		if gumdata and gumdata.type and (self:GetLightFlash() or playerrolling) then
			glowcol = nzGum.TypeColors[gumdata.type]
			glowcol2 = glowcol
		end

		if self:GetSharing() then
			glowcol = color_share
		end

		render.SetMaterial(glowmat)

		local eyesize = (!isrolling and IsValid(self:GetCurrentUser())) and 4.5 or 2.5
		render.DrawSprite(self:GetAttachment(8).Pos + self:GetForward()*0.5, eyesize, eyesize, color_red)
		render.DrawSprite(self:GetAttachment(9).Pos + self:GetForward()*0.5, eyesize, eyesize, color_red)

		//stylized blinking
		if !self:GetLightFlash() and !isrolling and self:GetLightsOn() then
			local cooldowns_stage = self:GetLightsStage()
			if cooldowns_stage == #cooldowns or cooldowns_stage == 1 then
				local rsize1 = math.Rand(12,14)
				local rsize2 = math.Rand(12,14)
				local rsize3 = math.Rand(12,14)
				render.DrawSprite(self:GetAttachment(1).Pos, rsize1, rsize1, glowcol)
				render.DrawSprite(self:GetAttachment(2).Pos, rsize2, rsize2, glowcol)
				render.DrawSprite(self:GetAttachment(3).Pos, rsize3, rsize3, glowcol)
				render.DrawSprite(self:GetAttachment(4).Pos, rsize1, rsize1, glowcol)
				render.DrawSprite(self:GetAttachment(5).Pos, rsize2, rsize2, glowcol)
				render.DrawSprite(self:GetAttachment(6).Pos, rsize3, rsize3, glowcol)
				render.DrawSprite(self:GetAttachment(7).Pos, rsize1, rsize1, glowcol)
			elseif fuckoff_lights[cooldowns_stage] then
				glowpos = (self:GetPos() + vector_up*(fuckoff_dists[cooldowns_stage])) + self:GetForward() * 14

				local lights_off = {1, 2, 3}
				table.RemoveByValue(lights_off, fuckoff_lights[cooldowns_stage])

				local rsize = math.Rand(12,14)
				render.DrawSprite(self:GetAttachment(7).Pos, rsize, rsize, glowcol)
				if cooldowns_stage > 2 then
					render.DrawSprite(self:GetAttachment(fuckoff_lights[cooldowns_stage]).Pos, rsize, rsize, glowcol)
					render.DrawSprite(self:GetAttachment(fuckoff_lights[cooldowns_stage] + 3).Pos, rsize, rsize, glowcol)
				end
			end
		end

		//glow for rolled gum and gum spinning in the machine
		if self:GetLightFlash() or playerrolling then
			local rsize = math.Rand(18,22)
			render.DrawSprite(self:GetAttachment(10).Pos, rsize, rsize, glowcol2)
			render.DrawSprite(self:GetAttachment(12).Pos, rsize, rsize, glowcol2)
		end

		//dlight and flashing lights for rolled gum
		if self:GetLightsOn() or playerrolling then
			if playerrolling then
				glowpos = self:GetAttachment(11).Pos
			end
			if !isrolling and IsValid(self:GetCurrentUser()) then
				glowpos = self:GetAttachment(12).Pos
			end

			if self:GetLightFlash() or (self:GetLightsOn() and playerrolling) then
				local rsize1 = math.Rand(16,18) * (playerrolling and 0.77777 or 1)
				local rsize2 = math.Rand(16,18) * (playerrolling and 0.77777 or 1)
				local rsize3 = math.Rand(16,18) * (playerrolling and 0.77777 or 1)
				local ourcol = playerrolling and color_lights or glowcol

				render.DrawSprite(self:GetAttachment(1).Pos, rsize1, rsize1, ourcol)
				render.DrawSprite(self:GetAttachment(2).Pos, rsize2, rsize2, ourcol)
				render.DrawSprite(self:GetAttachment(3).Pos, rsize3, rsize3, ourcol)
				render.DrawSprite(self:GetAttachment(4).Pos, rsize1, rsize1, ourcol)
				render.DrawSprite(self:GetAttachment(5).Pos, rsize2, rsize2, ourcol)
				render.DrawSprite(self:GetAttachment(6).Pos, rsize3, rsize3, ourcol)
				render.DrawSprite(self:GetAttachment(7).Pos, rsize1, rsize1, ourcol)
			end

			local dlight = DynamicLight(self:EntIndex(), true)
			if (dlight) then
				dlight.pos = glowpos
				dlight.r = glowcol2.r
				dlight.g = glowcol2.g
				dlight.b = glowcol2.b
				dlight.brightness = self:GetAllLightsOn() and 1 or 0.5
				dlight.Decay = 1000
				dlight.Size = 128
				dlight.DieTime = CurTime() + .2
			end
		end
	end
end
