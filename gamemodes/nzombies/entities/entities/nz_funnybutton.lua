AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Funny Button"
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.GlowMat = Material("models/zmb/bo2/highrise/red_glow")

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Int", 1, "TimeLimit")

	self:NetworkVar("String", 0, "DoorFlag")
	self:NetworkVar("String", 1, "PickupHint")

	self:NetworkVar("Bool", 0, "Glow")
	self:NetworkVar("Bool", 1, "Electric")
	self:NetworkVar("Bool", 2, "Used")
	self:NetworkVar("Bool", 3, "Timed")
	self:NetworkVar("Bool", 4, "HideOnUse")

	self:NetworkVar("Vector", 0, "GlowColor")
end

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/zmb/bo2/highrise/p6_zm_hr_key_console.mdl")
	end

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetAutomaticFrameAdvance(true)

	if CLIENT then return end
	if self:GetPickupHint() == "" then
		self:SetPickupHint("Activate")
	end
	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end

function ENT:Reset()
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUsed(false)
	self:ResetSequence("close")
	self:SetNoDraw(false)

	if self.Elec then
		self:TurnOff()
	end

	for k, v in ipairs(player.GetAll()) do
		if v:GetNW2String("nzButonFlag", "") ~= "" and v:GetNW2String("nzButonFlag", "") == self:GetDoorFlag() then
			v:SetNW2Float("nzStopWatch", 0)
			v:SetNW2String("nzButonFlag", nil)
		end
	end
end

function ENT:Use(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 0.25

	if (nzRound:InState(ROUND_CREATE) or ply:IsInCreative()) then
		ply.NextUse = CurTime() + 1.5
		self:EmitSound(self.ActivateSound or Sound("zmb/moon/comp_activate.wav"), 75, math.random(97,103), 1, CHAN_ITEM)
		ply:ChatPrint((self.CompletedText or "All buttons pressed!").." "..(self.DoorOpenText or "A door somewhere has opened..."))
		return
	end

	if ply:GetNW2String("nzButonFlag", "") ~= "" and ply:GetNW2String("nzButonFlag", "") ~= self:GetDoorFlag() then return end
	if self:GetUsed() then return end
	if self:GetElectric() and not nzElec:IsOn() then return end

	local price = self:GetPrice()
	if price > 0 and not ply:IsInCreative() then
		ply:Buy(price, self, function()
			self:Trigger(ply)
			return true
		end)
	else
		self:Trigger(ply)
	end
end

function ENT:GetButtonsLeft()
	local count = 0
	for k, v in pairs(ents.FindByClass("nz_funnybutton")) do
		if not v:GetUsed() and v:GetDoorFlag() == self:GetDoorFlag() then count = count + 1 end
	end
	return count
end

function ENT:Trigger(ply)
	if self:GetTimed() then
		local name = "nzButonTimer"..self:GetDoorFlag()
		if not timer.Exists(name) then
			if IsValid(ply) then
				ply:SetNW2String("nzButonFlag", self:GetDoorFlag())
				ply:SetNW2Float("nzStopWatch", CurTime() + self:GetTimeLimit())
			end
			timer.Create(name, self:GetTimeLimit(), 1, function()
				if not IsValid(self) then return end
				if self:GetButtonsLeft() < 1 then return end
				for k, v in pairs(ents.FindByClass("nz_funnybutton")) do
					if v:GetDoorFlag() == self:GetDoorFlag() then
						v:Reset()
					end
				end
			end)
		else
			if IsValid(ply) and not ply.nzbutond then
				ply:SetNW2String("nzButonFlag", self:GetDoorFlag())
				ply:SetNW2Float("nzStopWatch", CurTime() + timer.TimeLeft(name))
			end
		end
	end

	self:EmitSound(self.ActivateSound or Sound("zmb/moon/comp_activate.wav"), 80, math.random(97,103), 1, CHAN_ITEM)

	self:SetSolid(SOLID_NONE)
	self:SetUsed(true)
	self:ResetSequence("open")
	if self:GetHideOnUse() then
		self:SetNoDraw(true)
	end

	if self:GetButtonsLeft() < 1 then
		PrintMessage(HUD_PRINTTALK, (self.CompletedText or "All buttons pressed!").." "..(self.DoorOpenText or "A door somewhere has opened..."))
		nzDoors:OpenLinkedDoors(self:GetDoorFlag())
		for k, v in ipairs(player.GetAll()) do
			if v:GetNW2String("nzButonFlag", "") ~= "" and v:GetNW2String("nzButonFlag", "") == self:GetDoorFlag() then
				v:SetNW2Float("nzStopWatch", 0)
				v:SetNW2String("nzButonFlag", nil)
			end
		end
	end
end

if CLIENT then
	function ENT:Draw()
		local ply = LocalPlayer()
		self:DrawModel()
		if self:GetGlow() and not self:GetUsed() then
			if !nzRound:InState(ROUND_CREATE) and self:GetElectric() and not nzElec:IsOn() then return end
			if self:GetTimed() and ply:GetNW2String("nzButonFlag", "") ~= "" and ply:GetNW2String("nzButonFlag", "") ~= self:GetDoorFlag() then return end

			local num = render.GetBlend()
			local r, g, b = render.GetColorModulation()
			local col = self:GetGlowColor()

			render.SuppressEngineLighting(false)
			render.MaterialOverride(self.GlowMat)
			render.SetBlend(0.1)
			render.SetColorModulation(col[1], col[2], col[3])
			self:DrawModel()
			render.SetColorModulation(r,g,b)
			render.SetBlend(num)
			render.MaterialOverride(nil)
			render.SuppressEngineLighting(false)
		end
	end

	function ENT:GetNZTargetText()
		local ply = LocalPlayer()

		local price = self:GetPrice()
		if nzRound:InState(ROUND_CREATE) or ply:IsInCreative() then
			local num = 0
			for k, v in pairs(ents.FindByClass("nz_funnybutton")) do
				if v:GetDoorFlag() ~= self:GetDoorFlag() then continue end
				num = num + 1
				if v == self then break end
			end

			local pricedata = price > 0 and " | Price "..price or ""
			local elecdata = self:GetElectric() and " | Requires Electricity" or ""
			local timedata = self:GetTimed() and " | Timed "..self:GetTimeLimit().."s" or ""
			return "Button "..num.." | Door Flag '"..self:GetDoorFlag().."'"..pricedata..elecdata..timedata.." | '"..self:GetPickupHint().."'"
		end

		if self:GetElectric() and not nzElec:IsOn() then
			return ""
		end

		if self:GetTimed() and ply:GetNW2String("nzButonFlag", "") ~= "" and ply:GetNW2String("nzButonFlag", "") ~= self:GetDoorFlag() then
			return ""
		end

		local time = self:GetTimed() and " ["..self:GetTimeLimit().."s]" or ""
		if price > 0 then
			return "Press "..string.upper(input.LookupBinding("+USE")).." - "..self:GetPickupHint()..time.." [Cost: "..price.."]"
		else
			return "Press "..string.upper(input.LookupBinding("+USE")).." - "..self:GetPickupHint()..time
		end
	end
end

if SERVER then
	function ENT:TurnOn()
		if not self.Elec then return end
		self:SetElectric(false)
	end

	function ENT:TurnOff()
		if not self.Elec then return end
		self:SetElectric(true)
	end
end
