AddCSLuaFile()

ENT.Type			= "anim"

ENT.PrintName		= "perk_machine"
ENT.Author			= "Alig96"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "PerkID")
	self:NetworkVar("String", 1, "PapWeapon")

	self:NetworkVar("Bool", 0, "Active")
	self:NetworkVar("Bool", 1, "BeingUsed")

	self:NetworkVar("Int", 0, "Price")
	
	self:NetworkVar("Bool", 2, "LooseChange")
	self:NetworkVar("Bool", 3, "BrutusLocked")
	self:NetworkVar("Bool", 4, "HasPapGun")
end

function ENT:Initialize()
	if SERVER then
		self:SetBeingUsed(false)
		self:SetLooseChange(true)
		self:SetBrutusLocked(false)
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_VPHYSICS )
		self:DrawShadow( false )
		self:SetUseType( SIMPLE_USE )

		self.AutomaticFrameAdvance = true

		self:SetColor(Color(255, 255, 255, 255))
		self:SetRenderMode(RENDERMODE_NORMAL)
		self:SetRenderFX(0)

		self:SetTargetPriority(TARGET_PRIORITY_MONSTERINTERACT) -- This inserts the it into the target array.

		local phys = self:GetPhysicsObject()
		if IsValid(phys) then
			phys:EnableMotion(false)
			phys:Sleep()
		end

		local PerkData = nzPerks:Get(self:GetPerkID())
		if nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "IW" then
			self:SetPrice(PerkData.price_skin)
		else
			self:SetPrice(PerkData.price)
		end

		if offmodel then
			self:SetModel(offmodel)
		end

		if self:GetPerkID() == "gum" then
			self:SetModelScale(self:GetModelScale() * 0.5, 0)
		end

		self.NextRand = CurTime() + 5

		self.NextJingle = 0
		self.WaitforJingle = 0
		self.PlayingJingle = false
		self.Jingle = false
		self.HasJingle = true
		self.NextBump = CurTime() + 1

		self.PerkUseCoolDown = CurTime() + 1

		self.PerkTime = false
	end
end

function ENT:TurnOn()
	self:SetActive(true)
	self:EmitSound("effects/perk_turn_on.ogg",80,math.random(95,105))
	self:Update()

	self.NextJingle = CurTime() + math.random(0,600) -- Have a slightly shorter time for inital tune.

	if self:GetPerkID() == "deadshot" then
		self:SetBodygroup(3,2)
	elseif self:GetPerkID() == "phd" then
		self:SetBodygroup(4,1)
	elseif self:GetPerkID() == "pop" then
		self:SetBodygroup(5,1)
	end

	if self:LookupSequence("perk_power_on") > 0 then
		self:ResetSequence("perk_power_on")
	end
end

function ENT:TurnOff()
	self:SetActive(false)
	self:Update()

	if self:GetPerkID() == "deadshot" then
		self:SetBodygroup(3,0)
	elseif self:GetPerkID() == "phd" then
		self:SetBodygroup(4,0)
	elseif self:GetPerkID() == "pop" then
		self:SetBodygroup(5,0)
	end
end

function ENT:Update()
	local PerkData = nzPerks:Get(self:GetPerkID())
	local skinmodel = PerkData.model
	local iwskin = PerkData.skin
	local classicskin = PerkData.model_classic
	local cwskin = PerkData.model_cw

	self.Jingle = PerkData.jingle
	self.Sting = PerkData.sting

	if self:GetPerkID() == "pap"  then
		self:SetModel(nzRound:GetPackType(nzMapping.Settings.PAPtype))
	end

	if nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "IW" then
	else
		local offmodel = PerkData.model_off
	end

	if skinmodel then
		if offmodel then
			if self:IsOn() then
				self:SetModel(skinmodel)
			else
				self:SetModel(offmodel)
			end
		else
			if nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "CLASSIC" and classicskin then
				self:SetModel(classicskin)
			elseif nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "IW" and iwskin then
				self:SetModel(iwskin)
			elseif nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "CW" and cwskin then
				self:SetModel(cwskin)
			else
				self:SetModel(skinmodel)
			end
		
			if self:IsOn() then
				self:SetSkin(PerkData.on_skin or 0)
			else
				self:SetSkin(PerkData.off_skin or 1)
			end
		end
	else
		self:SetModel(PerkData and (self:IsOn() and PerkData.on_model or PerkData.off_model) or "")
	end

	if self:GetPerkID() == "pap" then
		local bocwmodel = PerkData.model_bocw
		local nz_tomb = PerkData.model_origins
		local ww2model = PerkData.model_ww2
		local bo2model = PerkData.model_bo2

		if nzPerks:GetPAPType(nzMapping.Settings.PAPtype) == "bocw" then
			self:SetModel(bocwmodel)
		end
		if nzPerks:GetPAPType(nzMapping.Settings.PAPtype) == "nz_tomb" then
			self:SetModel(nz_tomb)
		end
		if nzPerks:GetPAPType(nzMapping.Settings.PAPtype) == "ww2" then
			self:SetModel(ww2model)
		end
		if nzPerks:GetPAPType(nzMapping.Settings.PAPtype) == "bo2" then
			self:SetModel(bo2model)
		end
	end
end

function ENT:IsOn()
	return self:GetActive()
end

local MachinesNoDrink = {
	["pap"] = true,
}

function ENT:Use(activator, caller)
	if CurTime() < self.PerkUseCoolDown then return end

	local PerkData = nzPerks:Get(self:GetPerkID())

	if IsValid(self.PapWpn) and self.PapWpn.CanTake then
		self.PapWpn:Use(activator, caller)
		self.PerkUseCoolDown = CurTime() + 1
		return
	end 

	if self:IsOn() and !self:BrutusLocked() then
		local price = self:GetPrice()

		local func = function()
			local id = self:GetPerkID()
			if !activator:HasPerk(id) then
				local given = true

				if PerkData.condition then
					given = PerkData.condition(id, activator, self)
				end

				local hookblock = hook.Call("OnPlayerBuyPerkMachine", nil, activator, self)
				if hookblock != nil then -- Only if the hook returned true/false
					given = hookblock
				end

				if given then
					if !PerkData.specialmachine then
						local wep = activator:Give(nzMapping.Settings.bottle or "tfa_perk_bottle")
						if IsValid(wep) then wep:SetPerk(id) end

						timer.Simple(2.15, function()
							if IsValid(activator) and activator:GetNotDowned() then
								activator:GivePerk(id, self)
							end
						end)
					else
						activator:GivePerk(id, self)
					end

					if !self.PlayingJingle then
						if nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "IW" then
							self:EmitSound("nz/machines/jingle/IW/"..id.."_get.wav", 75, math.random(97, 103))
						else
							self:EmitSound("perkyworky/"..id.."_sting.mp3", 75, math.random(97, 103))
						end
					end

					if self:GetPerkID() == "pap" then
						if activator:HasPerk("time") then
							self.UsingTimeSlip = true
							self:EmitSound("nz_moo/effects/pap_timeslip.mp3", 90, math.random(97, 103))
						else
							self:EmitSound("nz_moo/perkacolas/pap/upgrade.mp3", 90, math.random(97, 103))
							self:EmitSound("nz_moo/perkacolas/pap/pap_crunch.mp3", 90, math.random(97, 103))
						end

	            		-- Glow Effect
	            		local bone = self:LookupBone("j_rollers_large")
	            		if bone then
							local effect = EffectData()
							effect:SetOrigin(self:GetBonePosition(bone))
							effect:SetEntity(self)
							effect:SetMagnitude(3)
							util.Effect("pap_glow", effect, true, true)
						end

						self:PapAction(activator)


						if self:LookupSequence("rotation_rings&thing") > 0 then
							self:ResetSequence("rotation_rings&thing")
						end
        			else
						if self:LookupSequence("perk_use") > 0 then
            				self:ResetSequence("perk_use")
        				end
        			end

					self.PerkInUse = true

					self:EmitSound("nz_moo/perkacolas/dispense_00.mp3", SNDLVL_TALKING, math.random(97, 103))

					return true
				else
					if self:GetPerkID() == "pap" and !self:GetBeingUsed() then
						self:EmitSound("nz_moo/perkacolas/pap/deny.mp3", 90, math.random(97, 103))
					end
				end
			else
				return false
			end
		end

		local upgradefunc = function()
			local id = self:GetPerkID()
			if not activator:HasUpgrade(id) then
				local given = true
				local hookblock = hook.Call("OnPlayerBuyPerkMachine", nil, activator, self)
				if hookblock != nil then
					given = hookblock
				end

				if given then
					if !PerkData.specialmachine then
						local wep = activator:Give(nzMapping.Settings.bottle or "tfa_perk_bottle")
						if IsValid(wep) then wep:SetPerk(id) end

						timer.Simple(3, function()
							if IsValid(activator) and activator:GetNotDowned() then
								activator:GiveUpgrade(id, self)
							end
						end)
					else
						activator:GiveUpgrade(id, self)
					end

					if !self.PlayingJingle then
						if nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype) == "IW" then
							self:EmitSound(self.Sting, 75, math.random(97, 103))
						else
							self:EmitSound("perkyworky/"..id.."_sting.mp3", 75, math.random(97, 103))
						end
					end

					return true
				end
			else
				return false
			end
		end

		local id = self:GetPerkID()
		if not PerkData.nobuy then
			if not activator:HasPerk(id) then
				if #activator:GetPerks() < GetConVar("nz_difficulty_perks_max"):GetInt() or self:GetPerkID() == "pap" then
					activator:Buy(price, self, func)
				end
			else
				if tobool(nzMapping.Settings.perkupgrades) then
					activator:Buy((price*2), self, upgradefunc)
				end
			end
		else
			func()
		end

		if self:GetPerkID() ~= "pap" and !self:GetBeingUsed() and self:IsOn() and !activator:CanAfford(price) then
			self:EmitSound("nz_moo/perkacolas/deny_00.mp3", 90, math.random(97, 103))
		end

	elseif self:IsOn() and self:BrutusLocked() then
		activator:Buy(2000, self, function()
			self:SetBrutusLocked(false)
			self:SetColor(Color(255, 255, 255, 255))
			self:SetRenderMode(RENDERMODE_NORMAL)
			self:SetRenderFX(0)
			return true
		end)
	end

	self.PerkUseCoolDown = CurTime() + 1
end

function ENT:LooseChange()
	return self:GetLooseChange()
end

function ENT:BrutusLocked()
	return self:GetBrutusLocked()
end

function ENT:OnBrutusLocked()
	if !self:BrutusLocked() then
		self:SetBrutusLocked(true)
		self:SetColor(Color(255, 255, 255, 127))
		self:SetRenderMode(RENDERMODE_GLOW)
		self:SetRenderFX(15)
	end
end

function ENT:PapAction(activator)
	-- Shit
	self:SetHasPapGun(false)

	local wep = activator:GetActiveWeapon()
	if not IsValid(wep) then return end
	if not wep:IsWeapon() then return end

	local class = wep:GetClass()

	local lastcamo = false
	if wep:GetNW2String("nzPaPCamo", "") ~= "" then
		lastcamo = wep:GetNW2String("nzPaPCamo")
	end

	local reroll = false
	if wep:HasNZModifier("pap") and wep:CanRerollPaP() then
		reroll = true
	end

	-- Buy the Pap
	local cost = reroll and nzPowerUps:IsPowerupActive("bonfiresale") and 500 or reroll and 2500 or nzPowerUps:IsPowerupActive("bonfiresale") and 1000 or 5000

	activator:Buy(cost, machine, function()
		hook.Call("OnPlayerBuyPackAPunch", nil, activator, wep, machine)

		activator:Give(nzMapping.Settings.paparms or "tfa_paparms")
		activator:StripWeapon(class)

		local fuckinator = true
		for k, v in ipairs(activator:GetWeapons()) do //disease
			if v:GetNWInt("SwitchSlot", 0) > 0 then
				fuckinator = false
				break
			end
		end

		if fuckinator and nzMapping.Settings.startwep and not activator:IsInCreative() then
			local waw = activator:Give(nzMapping.Settings.startwep)
			activator.PAPBackupWeapon = waw
		end

		self.PapWpn = ents.Create("pap_weapon_fly")
		self.PapWpn:SetAngles(self:GetAngles())
		self.PapWpn:SetPos(self:GetPos())

		self.PapWpn.WepClass = class
		self.PapWpn.LastCamo = lastcamo
		self.PapWpn.Pap = self
		self.PapWpn.CanReroll = reroll
		self.PapWpn:SetPaPOwner(activator)

		self.PapWpn:Spawn()
		self.PapWpn:SetParent(self)

		self:SetPapWeapon(class)
		self.PapWpn:CreatePapWeapon()

		-- Fuck you
		timer.Simple(2, function() activator:RemovePerk("pap") end)
		return true
	end)
end

function ENT:Think()
	if SERVER then
		if self:GetPerkID() == "revive" and self:IsOn() and CurTime() > self.NextRand then
			self:EmitSound("nz_moo/perkacolas/broken_rands/random_0"..math.random(0,4)..".mp3", 75, math.random(95,105))
			self.NextRand = CurTime() + math.random(30,90)
		end
		if self:IsOn() and CurTime() > self.NextJingle and !self.PlayingJingle and !self.NoJingle then
		
			local NJ = CurTime() + math.random(300,900)
			local WFJ = CurTime() + 55

			if self.Jingle then
				self.PlayingJingle = true

				self.NextJingle = NJ
				self.WaitforJingle = WFJ

				self:EmitSound(self.Jingle, 75, math.random(97, 103))
			else
				self.NoJingle = true
			end
		end
		if CurTime() > self.WaitforJingle and self.PlayingJingle then
			self.PlayingJingle = false -- This is just because mp3s don't work with getting their duration.
		end

		if CurTime() > self.NextBump and self.Bumped then
			self.Bumped = false
		end

		-- Machine Animation
		if self.PerkInUse then
			self:SetBeingUsed(true)

			local seq, dur 

			local use 		= self:LookupSequence("perk_use")
			local loop 		= self:LookupSequence("perk_use_loop")
			local finish 	= self:LookupSequence("perk_use_finish")

			if self.UsingTimeSlip then
				loop = 0
			end

			if use > 0 and !self.PerkUse then
				self.PerkUse = true

            	self:ResetSequence(use)
            	seq, dur = self:LookupSequence("perk_use")
            	self.PerkTime = CurTime() + dur
			elseif use < 1 then
				if !self.PerkUse then
					self.PerkUse = true
            		self.PerkTime = CurTime() + 2
            		print("use")
            	end
        	end

        	if loop > 0 then
        		if CurTime() > self.PerkTime and self.PerkUse and !self.PerkLoop then
					self.PerkLoop = true

        			self:ResetSequence(loop)
					if self.UsingTimeSlip then
            			seq, dur = self:LookupSequence("perk_use_loop_fast")
					else
            			seq, dur = self:LookupSequence("perk_use_loop")
					end
            		self.PerkTime = CurTime() + dur
        		end
        	else
        		if CurTime() > self.PerkTime and self.PerkUse and !self.PerkLoop and !self.UsingTimeSlip then
					self.PerkLoop = true
            		self.PerkTime = CurTime() + 1
            	elseif self.UsingTimeSlip and !self.PerkLoop then
					self.PerkLoop = true
        		end
        	end

        	if finish > 0 then
        		if CurTime() > self.PerkTime and self.PerkLoop and !self.PerkFinish then
        			self.PerkFinish = true

					if self:GetPerkID() == "pap" then
						self.PapWpn:WeaponEject()
						self:SetHasPapGun(true)
					end

        			self:StopParticles()
	        		self:ResetSequence(finish)
	            	seq, dur = self:LookupSequence("perk_use_finish")
            		self.PerkTime = CurTime() + dur
        		end
        	else
        		if CurTime() > self.PerkTime and self.PerkLoop and !self.PerkFinish then
        			self.PerkFinish = true
					if self:GetPerkID() == "pap" then
						self.PapWpn:WeaponEject()
						self:SetHasPapGun(true)
					end

        			self:StopParticles()
            		self.PerkTime = 1
        		end
        	end

        	if !isnumber(self.PerkTime) or (CurTime() > self.PerkTime and self.PerkFinish and self.PerkInUse) then
				self.PerkInUse 		= false
				self.PerkUse 		= false
				self.PerkLoop 		= false
				self.PerkFinish 	= false
				self.PerkTime		= false
				self:SetBeingUsed(false)
				if self.UsingTimeSlip then
					self.UsingTimeSlip = false
				end
        	end
		end
	end

	self:NextThink(CurTime())
	return true
end

-- Funny Spare Change Code: By GhostlyMoo
function ENT:Touch(entity)
	if entity:IsPlayer() and entity:Crouching() and self:LooseChange() and self:GetPerkID() ~= "pap" then
		self:SetLooseChange(false)
		entity:GivePoints(100, false, true)
		--print("Found bubblegum under the table.")
	end
end

function ENT:StartTouch(entity)
	if entity:IsPlayer() and !self.Bumped then
		self:EmitSound("nz_moo/perkacolas/bump/vend_0"..math.random(0,2)..".mp3", SNDLVL_TALKING)
		self.Bumped = true
		self.NextBump = CurTime() + 1
	end
end

if CLIENT then
    local usedcolor = Color(255,255,255)
    
    function ENT:Draw()
        self:DrawModel()
        if self:GetActive() then
            if !self.NextLight or CurTime() > self.NextLight then
                local dlight = DynamicLight(self:EntIndex(), true)
                local center = self:OBBCenter() * 0.25
                local fwd = self:GetForward() * 35

                if self:GetPerkID() == "pap" then
	            	local bone = self:LookupBone("j_rollers_large")
	            	if bone then
                		center = self:GetBonePosition(bone)
	            	end
                	fwd = self:GetForward()
                end

                if ( dlight ) then
                    local col = nzPerks:Get(self:GetPerkID()).color or usedcolor
                    if self:GetPerkID() == "pap" then
                    	dlight.pos = center + fwd
                    else
                    	dlight.pos = self:WorldSpaceCenter() + center + fwd
                    end
                    dlight.r = col.r
                    dlight.g = col.g
                    dlight.b = col.b
                    dlight.brightness = 2
                    dlight.Decay = 1000
                    dlight.Size = 256
                    dlight.DieTime = CurTime() + 1
                end
                if math.random(300) == 1 then self.NextLight = CurTime() + 0.05 end
            end

            if !IsValid(self) then return end
            if (!self.IdleAmbience or !IsValid(self.IdleAmbience)) then
            	if self:GetPerkID() == "pap" then
					self.IdleAmbience = "nz_moo/perkacolas/pap/pap_loop.wav"
            	else
					self.IdleAmbience = "nz_moo/perkacolas/hum_loop.wav"
            	end
				self:EmitSound(self.IdleAmbience, 65, 100, 1, 3)
			end
        end
    end
end

function ENT:OnRemove()
	if CLIENT then
		if self.IdleAmbience or IsValid(self.IdleAmbience) then
			self:StopSound(self.IdleAmbience)
		end
	end
end