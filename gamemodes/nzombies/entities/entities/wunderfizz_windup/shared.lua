AddCSLuaFile()

ENT.Type = "anim"
 
ENT.PrintName		= "wunderfizz_windup"
ENT.Author			= "Zet0r"
ENT.Contact			= "youtube.com/Zet0r"
ENT.Purpose			= ""
ENT.Instructions	= ""

local teddymat = "models/perk_bottle/c_perk_bottle_teddy"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Winding")
	self:NetworkVar("Bool", 1, "Sharing")
	self:NetworkVar("String", 0, "Perk")

	if (CLIENT) then
		self:NetworkVarNotify("Sharing", function(ent)
			if ent.LightningEffects1 and IsValid(ent.LightningEffects1) then
				ent.LightningEffects1:StopEmissionAndDestroyImmediately()
			end
		end)
	end
end

function ENT:RandomizeSkin()
	local perk
	local available = {}
	local bottle = nzMapping.Settings.bottle
	local fizzlist = nzMapping.Settings.wunderfizzperklist
	local blockedperks = {
		["wunderfizz"] = true,
		["pap"] = true,
		["gum"] = true,
	}

	local machine = self.WMachine
	local ply = IsValid(machine) and machine:GetUser() or nil

	for perk, _ in pairs(nzPerks:GetList()) do
		if blockedperks[perk] then continue end
		if fizzlist and fizzlist[perk] and not fizzlist[perk][1] then continue end
		if IsValid(ply) and ply:IsPlayer() and ply:HasPerk(perk) then continue end
		if self.last_perk and self.last_perk == perk then continue end

		table.insert(available, perk)
	end

	if table.IsEmpty(available) then return end
	perk = available[math.random(#available)]

	if perk and perk ~= "" then
		self.last_perk = perk

		local mattable = nzPerks:GetBottleTextures(bottle)
		if mattable then
			for id, mat in pairs(mattable) do
				self:SetSubMaterial(id, mat..perk)
			end
		else
			local skinid = nzPerks:Get(perk).material
			if skinid then
				self:SetSkin(skinid)
			end
		end
	end
end

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_OBB)
	self:DrawShadow(false)
	self:SetWinding(true)

	local model = nzPerks:GetFizzBottle(nzMapping.Settings.bottle)
	if model and util.IsValidModel(model) then
		self:SetModel(model)
	else
		self:SetModel("models/nzr/2022/perks/w_perk_bottle.mdl")
	end

	local machine = self:GetParent()
	if IsValid(machine) then
		self:SetAngles(machine:GetAngles())
		if machine.GetUser then
			local ply = machine:GetUser()
			if IsValid(ply) and ply:IsPlayer() and ply:HasPerk("time") then
				self.TimeSlipped = true
			end
		end
	end

	if CLIENT then return end

	self:RandomizeSkin()

	self:EmitSound("nz_moo/perks/wonderfizz/vortex_loop.wav", SNDLVL_NORM, math.random(97, 103), 0.4, CHAN_ITEM)

	timer.Simple(self.TimeSlipped and 2 or 4, function()
		self:SetWinding(false)
		timer.Simple(8, function()
			if IsValid(self) and IsValid(self.WMachine) and !self:GetSharing() then
				self.WMachine:SetSharing(true)
				self:SetSharing(true)
			end
		end)

		self:EmitSound("nz_moo/perks/wonderfizz/elec/hit/random_perk_imp_0"..math.random(0, 2)..".mp3", SNDLVL_TALKING, math.random(97, 103), 1, CHAN_STATIC)

		local machine = self.WMachine
		if self:GetPerk() == "teddy" then
			local mattable = nzPerks:GetBottleTextures(nzMapping.Settings.bottle)
			if mattable then
				for id, mat in pairs(mattable) do
					self:SetSubMaterial(id, mat.."wunderfizz")
				end
			else
				self:SetSkin(30)
			end

			machine:SetIsTeddy(true)
			machine:GetUser():GivePoints(machine:GetPrice())
			timer.Simple(5, function() 
				if IsValid(self) and IsValid(machine) then
					self:Remove()
					machine:MoveLocation()
				end
			end)
		else
			local mattable = nzPerks:GetBottleTextures(nzMapping.Settings.bottle)
			if mattable then
				for id, mat in pairs(mattable) do
					self:SetSubMaterial(id, mat..self:GetPerk())
				end
			else
				local skinid = nzPerks:Get(self:GetPerk()).material
				if skinid then
					self:SetSkin(skinid)
				end
			end
		end

		machine:SetPerkID(self:GetPerk())

		local idle = machine:LookupSequence("idle")
		machine:SetCycle(0)
		machine:ResetSequence(idle)
	end)

	SafeRemoveEntityDelayed(self, 15)
end

function ENT:WindUp()
	self:RandomizeSkin()
end

function ENT:TeddyFlyUp()
end

function ENT:Think()
	if SERVER then
		if self:GetWinding() then
			self:WindUp()
		end
	end

	self:NextThink(CurTime() + 0.0666)
	return true
end

function ENT:OnRemove()
	self:StopSound("nz_moo/perks/wonderfizz/vortex_loop.wav")

	local machine = self.WMachine
	if IsValid(machine) then
		machine:Reset()
	end
end

function ENT:Draw()
	self:DrawModel()
	if !self.LightningEffects1 or !IsValid(self.LightningEffects1) then
		self.LightningEffects1 = CreateParticleSystem(self, self:GetSharing() and "bo3_vending_wonder_perk_share" or "bo3_vending_wonder_perk", PATTACH_POINT_FOLLOW, 0)
	end
	if self:GetWinding() then
		if !self:GetRenderAngles() then
			local ang = self:GetAngles()
			ang:RotateAroundAxis(self:GetForward(), 20)
			self:SetRenderAngles(ang)
		end

		local ang = self:GetRenderAngles()
		ang:RotateAroundAxis(self:GetUp(), (self.TimeSlipped and 220 or 110)*FrameTime())
		self:SetRenderAngles(ang)
	elseif !self.Stopped and IsValid(self:GetParent()) then
		local fpos, fang = nzPerks:GetFizzPosition(nzMapping.Settings.bottle)
		local ang = self:GetParent():GetAngles()
		if fang then
			ang:RotateAroundAxis(self:GetParent():GetForward(), fang[1])
			ang:RotateAroundAxis(self:GetParent():GetUp(), fang[2])
			ang:RotateAroundAxis(self:GetParent():GetRight(), fang[3])
		else
			ang:RotateAroundAxis(self:GetParent():GetUp(), 140)
		end

		self:SetRenderAngles(ang)
		self.Stopped = true
	end
end
