AddCSLuaFile()

ENT.Type			= "anim"

ENT.PrintName		= "Der Wunderfizz"
ENT.Author			= "Zet0r"
ENT.Contact			= "youtube.com/Zet0r"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Bool", 0, "Active")
	self:NetworkVar("Bool", 1, "BeingUsed")
	self:NetworkVar("Entity", 0, "User")

	self:NetworkVar("String", 0, "PerkID")
	self:NetworkVar("Bool", 2, "IsTeddy" )
	self:NetworkVar("Bool", 3, "Sharing" )
end

local blockedperks = {
	["wunderfizz"] = true,
	["pap"] = true,
}

function ENT:DecideOutcomePerk(ply, specific)
	if specific then self:SetPerkID(specific) return end

	if self.TimesUsed > self.MaxUses and #ents.FindByClass("wunderfizz_machine") > 1 then
		return hook.Call("OnPlayerBuyWunderfizz", nil, ply, "teddy") or "teddy"
	else
		local wunderfizzlist = {}
		for k,v in pairs(nzPerks:GetList()) do
			if blockedperks[k] then
				wunderfizzlist[k] = {true, v}
			end
		end

		local available = nzMapping.Settings.wunderfizzperklist or wunderfizzlist

		local tbl = {}
		for k,v in pairs(available) do
			if !self:GetUser():HasPerk(k) and !blockedperks[k] then
				if v[1] then
					table.insert(tbl, k)
				end
			end
		end

		-- Teddy bear for no more perks D:
		if #tbl <= 0 then
			return hook.Call("OnPlayerBuyWunderfizz", nil, ply, "teddy") or "teddy"
		end

		local outcome = tbl[math.random(#tbl)]
		return hook.Call("OnPlayerBuyWunderfizz", nil, ply, outcome) or outcome
	end
end

function ENT:Initialize()
	if SERVER then
		if nzMapping.Settings.cwfizz then
			self:SetModel("models/moo/_codz_ports_props/t10/jup_zm_machine_wunderfizz/moo_codz_jup_zm_machine_wunderfizz.mdl")
		else
			local perktype = nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype)
			if perktype == "CLASSIC" then
				self:SetModel("models/nzr/2022/machines/wonder/vending_wonder.mdl")
			else
				self:SetModel("models/perks/machines/wonder/vending_wunderfizz.mdl")
			end
		end

		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_VPHYSICS )
		--self:DrawShadow( false )
		self:SetUseType( SIMPLE_USE )
		self:SetBeingUsed(false)
		self:SetIsTeddy(false)
		self:SetPrice(self.PriceOverride or nzMapping.Settings.fizzprice or 1500)

		self:SetSharing(false)

		self.NextLightning = CurTime() + math.random(10)
		self:SetAutomaticFrameAdvance(true)
		self:TurnOff(true)
		self.TimesUsed = 0
		self.MaxUses = math.random(nzMapping.Settings.minfizzuses or 4, nzMapping.Settings.maxfizzuses or 7)
	end
end

function ENT:Update()
	if nzMapping.Settings.cwfizz then
		self:SetModel("models/moo/_codz_ports_props/t10/jup_zm_machine_wunderfizz/moo_codz_jup_zm_machine_wunderfizz.mdl")
	else
		local perktype = nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype)
		if perktype == "CLASSIC" then
			self:SetModel("models/nzr/2022/machines/wonder/vending_wonder.mdl")
		else
			self:SetModel("models/perks/machines/wonder/vending_wunderfizz.mdl")
		end

		if self:GetActive() then
			local idle = self:LookupSequence("idle")
			if idle > 0 then
				self:SetCycle(0)
				self:ResetSequence(idle)
			end
		else
			local turnoff, dur = self:LookupSequence("turn_off")
			if turnoff > 0 then
				self:ResetSequence(turnoff)
				self:SetCycle(1)
			end
		end
	end
	self:StopSound("nz_moo/perkacolas/hum_loop.wav", 65, 100, 1, 3)
	self.MaxUses = math.random(nzMapping.Settings.minfizzuses or 4, nzMapping.Settings.maxfizzuses or 7)
end

function ENT:TurnOn()
	if nzMapping.Settings.cwfizz then
		self:SetActive(true)
		return
	end

	local turnon, dur = self:LookupSequence("turn_on")
	if turnon > 0 then
		self:SetCycle(0)
		self:ResetSequence(turnon)
	end
	self.GoIdle = CurTime() + dur -- Delay when to go idle (after turn on animation)
	self:EmitSound("nz_moo/perks/wonderfizz/ball_drop.mp3", 100)
	self.TimesUsed = 0
	self.MaxUses = math.random(nzMapping.Settings.minfizzuses or 4, nzMapping.Settings.maxfizzuses or 7)
end

function ENT:TurnOff(spawn)
	self:SetActive(false)

	if nzMapping.Settings.cwfizz then
		return
	end

	local turnoff, dur = self:LookupSequence("turn_off")
	if turnoff > 0 then
		self:ResetSequence(turnoff)
	end
	self.TimesUsed = 0
	self.GoIdle = nil
	self:EmitSound("nz_moo/perks/wonderfizz/rand_perk_mach_leave.mp3", 100)
	if spawn then self:SetCycle(1) else self:SetCycle(0) end
end

function ENT:IsOn()
	return self:GetActive()
end

function ENT:Think()
	if SERVER then
		if self.GoIdle and self.GoIdle < CurTime() and !nzMapping.Settings.cwfizz then
			local idle = self:LookupSequence("idle")
			self:SetCycle(0)
			self:ResetSequence(idle)
			self:SetActive(true)
			self.GoIdle = nil
		end
		if self:IsOn() and CurTime() > self.NextLightning and !nzMapping.Settings.cwfizz then
			ParticleEffect("driese_tp_arrival_phase2", self:GetAttachment(1).Pos, Angle(0,0,0))
			self:EmitSound("amb/weather/lightning/lightning_flash_0"..math.random(0,3)..".wav",511)

			self.NextLightning = CurTime() + math.random(30)
		end
		self:NextThink(CurTime())
		return true
	end
end

function ENT:Use(activator, caller)
	if activator.NextUse and activator.NextUse > CurTime() then return end

	if self:IsOn() and !self.GoIdle then -- Only after fully arriving
		if nzMapping.Settings.cwfizz then
			local fizzround = nzMapping.Settings.cwfizzround
			if fizzround and nzRound:GetNumber() < fizzround and !nzRound:InState(ROUND_CREATE) then
				return
			end

			net.Start("nzColdWarFizzMenu")
			net.Send(activator)
			return
		end

		local b_no_perks = true
		for k, v in pairs(nzMapping.Settings.wunderfizzperklist) do
			if !blockedperks[k] and v[1] and !activator:HasPerk(k) then
				b_no_perks = false
				break
			end
		end

		if b_no_perks then
			activator:Buy(math.huge, self, function()
				return false
			end)
			return false
		end

		if !IsValid(self.Bottle) and !self:GetBeingUsed() then
			-- Can only be bought if you have free perk slots
			if #activator:GetPerks() < activator:GetMaxPerks() then
				-- If they have enough money
				local price = activator:IsInCreative() and 0 or self:GetPrice()
				activator:Buy(price, self, function()
					self:StopSound("nz_moo/perks/wonderfizz/rand_perk_mach_stop.wav")
					self:EmitSound("nz_moo/perks/wonderfizz/rand_perk_mach_start.mp3", SNDLVL_TALKING, math.random(97, 103), 1, CHAN_STATIC)
					self:EmitSound("nz_moo/perks/wonderfizz/rand_perk_mach_loop.wav", SNDLVL_NORM, math.random(97, 103), 0.5, CHAN_ITEM)
					self:SetBeingUsed(true)
					self:SetUser(activator)

					self.OutcomePerk = self:DecideOutcomePerk(activator)
					self.Bottle = ents.Create("wunderfizz_windup")

					local bpos, bang = nzPerks:GetFizzPosition(nzMapping.Settings.bottle)
					if bpos and bang then
						self.Bottle:SetPos(self:GetPos() + (self:GetUp()*bpos[3]))

						local ang = self:GetAngles()
						ang:RotateAroundAxis(self:GetUp(), bang[1])
						ang:RotateAroundAxis(self:GetRight(), bang[2])
						ang:RotateAroundAxis(self:GetForward(), bang[3])
						self.Bottle:SetAngles(ang)
					else
						self.Bottle:SetPos(self:GetPos() + (self:GetUp()*50))

						local ang = self:GetAngles()
						ang:RotateAroundAxis(self:GetRight(), 140)
						self.Bottle:SetAngles(ang)
					end

					self.Bottle.WMachine = self
					self.Bottle:SetPerkID(self.OutcomePerk)
					self.Bottle:SetParent(self)
					self.Bottle:Spawn()

					self.TimesUsed = self.TimesUsed + 1

					local id = self:LookupSequence("vend")
					if id > 0 then
						self:SetCycle(0)
						self:ResetSequence(id)
					end

					activator.NextUse = CurTime() + 0.25
					return true
				end)
			end
		elseif !self.Bottle:GetWinding() and !self:GetIsTeddy() and (activator == self:GetUser() or (self:GetSharing() and #activator:GetPerks() < activator:GetMaxPerks())) then
			activator.NextUse = CurTime() + 0.25
			if #activator:GetPerks() >= activator:GetMaxPerks() then
				activator:PrintMessage(HUD_PRINTTALK, "[NZ] You have outsmarted the system.")
			end

			local perk = self:GetPerkID()
			local wep = activator:Give(nzMapping.Settings.bottle or "tfa_perk_bottle")
			if IsValid(wep) then
				wep:SetPerk(perk)
			end
			activator:GivePerk(perk)
			self:EmitSound("nz_moo/perkacolas/wonderfizz_sting_1.mp3", 75, math.random(97, 103), 1, CHAN_STATIC)

			self:Reset()
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	local ply = dmginfo:GetAttacker()
	if not IsValid(ply) or not ply:IsPlayer() or self:GetSharing() or !self:GetBeingUsed() then return end
	if !self.Bottle or !IsValid(self.Bottle) or self.Bottle:GetWinding() then return end

	if ply == self:GetUser() and bit.band(dmginfo:GetDamageType(), bit.bor(DMG_SLASH, DMG_CLUB, DMG_CRUSH)) ~= 0 then
		self:SetSharing(true)
		if self.Bottle and IsValid(self.Bottle) then
			self.Bottle:SetSharing(true)
		end
	end
end

function ENT:Reset()
	self:SetBeingUsed(false)
	self:SetPerkID("")
	self:SetUser(nil)
	self:SetSharing(false)

	if self.Bottle and IsValid(self.Bottle) then
		self.Bottle:Remove()
	end

	self:StopSound("nz_moo/perks/wonderfizz/rand_perk_mach_loop.wav")
	self:EmitSound("nz_moo/perks/wonderfizz/rand_perk_mach_stop.mp3", SNDLVL_TALKING, math.random(97, 103), 1, CHAN_ITEM)
end

function ENT:OnRemove()
	if IsValid(self.Bottle) then
		self.Bottle:Remove()
	end
end

function ENT:MoveLocation()
	if (#ents.FindByClass("wunderfizz_machine") == 1) then return end -- NO! Don't move if there's nowhere to go

	self:TurnOff()
	self:SetPerkID("")
	self:SetUser(nil)
	self:SetIsTeddy(false)

	local tbl = {}
	for k,v in pairs(ents.FindByClass("wunderfizz_machine")) do
		if !v:IsOn() and v != self then
			table.insert(tbl, v)
		end
	end
	local target = tbl[math.random(#tbl)]
	if IsValid(target) then
		target:TurnOn()
	end
end

local color_red = Color(255,0,0)
local color_green = Color(0,255,0)
local onlight = Material( "sprites/physg_glow1" )
local usedcolor = Color(255,240,225)

if CLIENT then
	function ENT:Draw()
		self:DrawModel()

		if nzMapping.Settings.cwfizz then
			if self.VendingEffects1 and IsValid(self.VendingEffects1) then
				self.VendingEffects1:StopEmission()
			end
			if self.VendingEffects2 and IsValid(self.VendingEffects2) then
				self.VendingEffects2:StopEmission()
			end
			if self.VendingEffects3 and IsValid(self.VendingEffects3) then
				self.VendingEffects3:StopEmission()
			end
			if self.LightningEffects1 and IsValid(self.LightningEffects1) then
				self.LightningEffects1:StopEmission()
			end
			if self.LightningEffects2 and IsValid(self.LightningEffects2) then
				self.LightningEffects2:StopEmission()
			end
			if self.LightningEffects3 and IsValid(self.LightningEffects3) then
				self.LightningEffects3:StopEmission()
			end
			if self.LightningEffects4 and IsValid(self.LightningEffects4) then
				self.LightningEffects4:StopEmission()
			end

			if self:IsOn() then
				if !self.NextLight or CurTime() > self.NextLight then
					local dlight = DynamicLight(self:EntIndex(), true)
					local center = self:OBBCenter() * 0.25
					local fwd = self:GetForward() * 35

					if ( dlight ) then
						dlight.pos = self:WorldSpaceCenter() + center + fwd
						dlight.r = usedcolor.r
						dlight.g = usedcolor.g
						dlight.b = usedcolor.b
						dlight.brightness = 1
						dlight.Decay = 1000
						dlight.Size = 256
						dlight.DieTime = CurTime() + 1
					end
					if math.random(300) == 1 then self.NextLight = CurTime() + 0.05 end
				end

				self:EmitSound("nz_moo/perkacolas/hum_loop.wav", 65, 100, 1, 3)
			end
			return
		end

		if self:IsOn() then
			local being_used = self:GetBeingUsed()

			local dlight2 = DynamicLight(self:EntIndex(), false)
			if (dlight2) then
				local attpos = self:GetAttachment(1)

				dlight2.pos = (attpos and attpos.Pos) and attpos.Pos or self:GetPos()
				dlight2.r = 100
				dlight2.g = 120
				dlight2.b = 255
				dlight2.brightness = 0.5
				dlight2.Decay = 2000
				dlight2.Size = 160
				dlight2.DieTime = CurTime() + 0.5
			end

			if being_used then
				if !self.VendingEffects1 or !IsValid(self.VendingEffects1) then
					self.VendingEffects1 = CreateParticleSystem(self, "bo3_vending_wonder_vend", PATTACH_POINT_FOLLOW, 2)
				end
				if !self.VendingEffects2 or !IsValid(self.VendingEffects2) then
					self.VendingEffects2 = CreateParticleSystem(self, "bo3_vending_wonder_halo", PATTACH_POINT_FOLLOW, 3)
				end
				if !self.VendingEffects3 or !IsValid(self.VendingEffects3) then
					self.VendingEffects3 = CreateParticleSystem(self, "bo3_vending_wonder_halo", PATTACH_POINT_FOLLOW, 4)
				end
			else
				if self.VendingEffects1 and IsValid(self.VendingEffects1) then
					self.VendingEffects1:StopEmission()
				end
				if self.VendingEffects2 and IsValid(self.VendingEffects2) then
					self.VendingEffects2:StopEmission()
				end
				if self.VendingEffects3 and IsValid(self.VendingEffects3) then
					self.VendingEffects3:StopEmission()
				end
			end

			if !self.LightningEffects1 or !IsValid(self.LightningEffects1) then
				self.LightningEffects1 = CreateParticleSystem(self, "bo3_vending_wonder_ball", PATTACH_POINT_FOLLOW, 1)
			end
			if !self.LightningEffects2 or !IsValid(self.LightningEffects2) then
				self.LightningEffects2 = CreateParticleSystem(self, "bo3_vending_wonder_light", PATTACH_POINT_FOLLOW, 6)
			end
			if !self.LightningEffects3 or !IsValid(self.LightningEffects3) then
				self.LightningEffects3 = CreateParticleSystem(self, "bo3_vending_wonder_light", PATTACH_POINT_FOLLOW, 7)
			end
			if !self.LightningEffects4 or !IsValid(self.LightningEffects4) then
				self.LightningEffects4 = CreateParticleSystem(self, "bo3_vending_wonder_idle", PATTACH_POINT_FOLLOW, 0)
			end

			render.SetMaterial(onlight)
			render.DrawSprite((being_used and self:GetAttachment(9).Pos or self:GetAttachment(8).Pos), math.Rand(7,8), math.Rand(7,8), being_used and color_red or color_green)
		else
			if self.VendingEffects1 and IsValid(self.VendingEffects1) then
				self.VendingEffects1:StopEmission()
			end
			if self.VendingEffects2 and IsValid(self.VendingEffects2) then
				self.VendingEffects2:StopEmission()
			end
			if self.VendingEffects3 and IsValid(self.VendingEffects3) then
				self.VendingEffects3:StopEmission()
			end
			if self.LightningEffects1 and IsValid(self.LightningEffects1) then
				self.LightningEffects1:StopEmission()
			end
			if self.LightningEffects2 and IsValid(self.LightningEffects2) then
				self.LightningEffects2:StopEmission()
			end
			if self.LightningEffects3 and IsValid(self.LightningEffects3) then
				self.LightningEffects3:StopEmission()
			end
			if self.LightningEffects4 and IsValid(self.LightningEffects4) then
				self.LightningEffects4:StopEmission()
			end

			local point = self:GetAttachment(9)
			render.SetMaterial(onlight)

			if point then
				render.DrawSprite(point.Pos, math.Rand(7,8), math.Rand(7,8), color_red)
			end
		end
	end
end