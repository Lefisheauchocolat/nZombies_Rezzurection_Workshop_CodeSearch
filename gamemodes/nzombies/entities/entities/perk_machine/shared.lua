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
	self:NetworkVar("String", 2, "LoopingSound")

	self:NetworkVar("Bool", 0, "Active")
	self:NetworkVar("Bool", 1, "BeingUsed")

	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Int", 1, "UpgradePrice")
	
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

		self.NextRand = CurTime() + 5

		self.NextJingle = 0
		self.WaitforJingle = 0
		self.PlayingJingle = false
		self.Jingle = false
		self.HasJingle = true
		self.NextBump = CurTime() + 1

		self.PerkUseCoolDown = CurTime() + 1

		self.PerkTime = false

		-- For Selectable Machines
		self.UseMist = false
		self.UseJingle = false
		self.PowSnd = false
	end
end

function ENT:TurnOn()
	local seq, dur 
    seq, dur = self:LookupSequence("perk_power_on")

	self:SetActive(true)
	self:ToggleSmoke(true)
	self:Update()

	self.NextJingle = CurTime() + math.random(0,600) -- Have a slightly shorter time for inital tune.

	if seq > 0 then
    	self.FinishPowerOnSequence = CurTime() + dur
		self:ResetSequence(seq)
	else
    	self.FinishPowerOnSequence = CurTime() + 1
	end

	self:EmitSound(self.PowSnd, 90, math.random(95,105))
end

function ENT:TurnOff()
	self:SetActive(false)
	self:ToggleSmoke(false)
	self:Update()

	self.PlayPowerOffAnim = false
end

function ENT:ToggleSmoke(toggle)
  
    if !self.UseMist or !nzPerks:Get(self:GetPerkID()).smokeparticles then return end

    if toggle then
        for k,v in pairs(nzPerks:Get(self:GetPerkID()).smokeparticles) do
            --print("spawn",v.pos,v.ang)
            local emitter = ents.Create("env_smokestack")
            emitter:SetParent(self)
            emitter:SetLocalPos(v.pos)
            emitter:SetAngles(self:GetAngles() + v.ang)
            emitter:SetKeyValue("InitialState", "1")
            emitter:SetKeyValue("BaseSpread", v.spread)
            emitter:SetKeyValue("SpreadSpeed", "0")
            emitter:SetKeyValue("Speed", "7")
            emitter:SetKeyValue("StartSize", "3")
            emitter:SetKeyValue("EndSize", "15")
            emitter:SetKeyValue("Rate", "3")
            emitter:SetKeyValue("JetLength", "30")
            emitter:SetKeyValue("SmokeMaterial", "particle/smokesprites_0004.vmt")
            emitter:SetKeyValue("rendercolor", "225 255 255")
            emitter:SetKeyValue("renderamt", "35")
            emitter:Spawn()
        end
    else
        for k,v in pairs(ents.FindByClass("env_smokestack")) do
            if IsValid(v) and v:GetParent() == self then
                v:Remove()
            end
        end
    end
    
end

function ENT:Update()
	local PerkData = nzPerks:Get(self:GetPerkID())
	local perktype = nzPerks:GetMachineType(nzMapping.Settings.perkmachinetype)

	self.PerkTbl = {
	    ["OG"] = {
	        PerkModel       = {PerkData.model},
	        Price 			= {PerkData.price},
	        UpgradePrice 	= {PerkData.upgradeprice},
	        Jingle 			= {PerkData.jingle},
	        Sting 			= {PerkData.sting},
	        PowerOnSnd 		= {"effects/perk_turn_on.ogg"},
	        AmbSnd 			= {"nz_moo/perkacolas/hum_loop.wav"},
	        AllowJingle 	= {true},
	        AllowMist 		= {true},
        },
	    ["CLASSIC"] = {
	        PerkModel       = {PerkData.model_classic},
	        Price 			= {PerkData.price},
	        UpgradePrice 	= {PerkData.upgradeprice},
	        Jingle 			= {PerkData.jingle},
	        Sting 			= {PerkData.sting},
	        PowerOnSnd 		= {"effects/perk_turn_on.ogg"},
	        AmbSnd 			= {"nz_moo/perkacolas/hum_loop.wav"},
	        AllowJingle 	= {true},
	        AllowMist 		= {true},
        },
	    ["IW"] = {
	        PerkModel       = {PerkData.skin},
	        Price 			= {PerkData.price},
	        UpgradePrice 	= {PerkData.upgradeprice},
	        Jingle 			= {PerkData.jingle},
	        Sting 			= {PerkData.sting},
	        PowerOnSnd 		= {"effects/perk_turn_on.ogg"},
	        AmbSnd 			= {"nz_moo/perkacolas/hum_loop.wav"},
	        AllowJingle 	= {true},
	        AllowMist 		= {true},
        },
	    ["CW"] = {
	        PerkModel       = {PerkData.model_cw},
	        Price 			= {PerkData.price},
	        UpgradePrice 	= {PerkData.upgradeprice},
	        Jingle 			= {PerkData.jingle},
	        Sting 			= {PerkData.sting},
	        PowerOnSnd 		= {"effects/perk_turn_on.ogg"},
	        AmbSnd 			= {"nz_moo/perkacolas/hum_loop.wav"},
	        AllowJingle 	= {true},
	        AllowMist 		= {true},
        },
	    ["VG"] = {
	        PerkModel       = {PerkData.model_vg},
	        Price 			= {PerkData.price},
	        UpgradePrice 	= {PerkData.upgradeprice},
	        Jingle 			= {PerkData.jingle},
	        Sting 			= {PerkData.sting},
	        PowerOnSnd 		= {"effects/perk_turn_on.ogg"},
	        AmbSnd 			= {"nz_moo/perkacolas/hum_loop.wav"},
	        AllowJingle 	= {true},
	        AllowMist 		= {true},
        },
	}

	self.Jingle 		= self.PerkTbl[perktype].Jingle[1]
	self.Sting 			= self.PerkTbl[perktype].Sting[1]
	self.UseJingle 		= self.PerkTbl[perktype].AllowJingle[1]
	self.UseMist 		= self.PerkTbl[perktype].AllowMist[1]
	self.PowSnd 		= self.PerkTbl[perktype].PowerOnSnd[1]

	if self:GetPerkID() ~= "pap" then
		self:SetLoopingSound(self.PerkTbl[perktype].AmbSnd[1])
	end

	if self.PerkTbl[perktype].PerkModel[1] then
		self:SetModel(self.PerkTbl[perktype].PerkModel[1])
	else
		self:SetModel(PerkData.model or "")
	end

	if self:IsOn() then
		self:SetSkin(PerkData.on_skin or 0)
	else
		self:SetSkin(PerkData.off_skin or 1)
	end

	if self:GetPerkID() == "pap" then
		local paptype = nzPerks:GetPAPType(nzMapping.Settings.PAPtype)
		local tbl = {
	        ["og"] = {
	            PapModel       	= {PerkData.model},
	        	AmbSnd 			= {"nz_moo/perkacolas/pap/pap_loop.wav"},
	        	Stinger 		= {PerkData.sting},
	        	Jingle 			= {PerkData.jingle},
        	},
	        ["bocw"] = {
	            PapModel       	= {PerkData.model_bocw},
	        	AmbSnd 			= {"nz_moo/perkacolas/new_pap/pap_idle_lp.wav"},
	        	Stinger 		= {PerkData.sting},
	        	Jingle 			= {PerkData.jingle},
        	},
	        ["nz_tomb"] = {
	            PapModel       	= {PerkData.model_origins},
	        	AmbSnd 			= {"nz_moo/perkacolas/tomb_pap/packa_loop.wav"},
	        	Stinger 		= {PerkData.sting_tomb},
	        	Jingle 			= {PerkData.jingle_tomb},
        	},
        	  ["nz_tomb_red"] = {
	            PapModel       	= {PerkData.model_origins_red},
	        	AmbSnd 			= {"nz_moo/perkacolas/tomb_pap/packa_loop.wav"},
	        	Stinger 		= {PerkData.sting_tomb},
	        	Jingle 			= {PerkData.jingle_tomb},
        	},
	        ["ww2"] = {
	            PapModel       	= {PerkData.model_ww2},
	        	AmbSnd 			= {"nz_moo/perkacolas/pap/pap_loop.wav"},
	        	Stinger 		= {PerkData.sting},
	        	Jingle 			= {PerkData.jingle},
        	},
	        ["bo2"] = {
	            PapModel       	= {PerkData.model_bo2},
	        	AmbSnd 			= {"nz_moo/perkacolas/pap/pap_loop.wav"},
	        	Stinger 		= {PerkData.sting},
	        	Jingle 			= {PerkData.jingle},
        	},
	        ["waw"] = {
	            PapModel       	= {PerkData.model_waw},
	        	AmbSnd 			= {"nz_moo/perkacolas/pap/pap_loop.wav"},
	        	Stinger 		= {PerkData.sting},
	        	Jingle 			= {PerkData.jingle},
        	},
	        ["spooky"] = {
	            PapModel       	= {PerkData.model_spooky},
	        	AmbSnd 			= {"nz_moo/perkacolas/pap/pap_loop.wav"},
	        	Stinger 		= {PerkData.sting},
	        	Jingle 			= {PerkData.jingle},
        	},
		}
		self:SetModel(tbl[paptype].PapModel[1])
		self:SetLoopingSound(tbl[paptype].AmbSnd[1])

		self.Jingle 		= tbl[paptype].Jingle[1]
		self.Sting 			= tbl[paptype].Stinger[1]
	end

	self:SetPrice(self.PerkTbl[perktype].Price[1])
	self:SetUpgradePrice(self.PerkTbl[perktype].UpgradePrice[1])

	local maxrevives = (nzMapping.Settings.solorevive or 3)

	if self:GetPerkID() == "revive" and #player.GetAllPlaying() <= 1 and maxrevives > 0 then
		self:SetPrice(500)
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

					if !self.PlayingJingle and self.UseJingle then
						self:EmitSound(self.Sting, 75, math.random(97, 103))
					end

					if self:GetPerkID() == "pap" then
						if activator:HasPerk("time") then
							self.UsingTimeSlip = true
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

					if !self.PlayingJingle and self.UseJingle then
						self:EmitSound(self.Sting, 75, math.random(97, 103))
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
        			activator:Buy(self:GetUpgradePrice(), self, upgradefunc)
				end
			end
		else
			func()
		end

		if self:GetPerkID() ~= "pap" and !self:GetBeingUsed() and self:IsOn() and !activator:CanAfford(price) and self.UseJingle then
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

		local pos = self:GetPos()
		local lookup_gun_attach = self:LookupAttachment("gun_insert")

		if lookup_gun_attach == 2 then
			local attach = self:GetAttachment(lookup_gun_attach)
			pos = attach.Pos
		end

		self.PapWpn = ents.Create("pap_weapon_fly")
		self.PapWpn:SetAngles(self:GetAngles())
		self.PapWpn:SetPos(pos)

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
		if self:GetPerkID() == "revive" and self:IsOn() and CurTime() > self.NextRand and self.UseJingle then
			self:EmitSound("nz_moo/perkacolas/broken_rands/random_0"..math.random(0,4)..".mp3", 75, math.random(95,105))
			self.NextRand = CurTime() + math.random(30,90)
		end
		
		if self:IsOn() and CurTime() > self.FinishPowerOnSequence and !self.PerkInUse and (!self.StartPerkLoop or !IsValid(self.StartPerkLoop)) then
			self.StartPerkLoop = "perk_loop"
			if self:LookupSequence(self.StartPerkLoop) > 0 then
				self:ResetSequence(self.StartPerkLoop)
			end
		end

		if !self:IsOn() and !self.PlayPowerOffAnim then
			self.PlayPowerOffAnim = true

			local seq, dur 
		    seq, dur = self:LookupSequence("perk_power_off")
			if seq > 0 then
		    	self.FinishPowerOffSequence = CurTime() + dur
				self:ResetSequence("perk_power_off")
			else
		    	self.FinishPowerOffSequence = CurTime() + 1
			end

		end

		if self:IsOn() and CurTime() > self.NextJingle and !self.PlayingJingle and !self.NoJingle then
		
			local NJ = CurTime() + math.random(300,900)
			local WFJ = CurTime() + 55

			if self.Jingle and self.UseJingle then
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

			local use 			= self:LookupSequence("use")
			local use_fast 		= self:LookupSequence("use_fast")

			if self.UsingTimeSlip then
				use = use_fast
			end

			if !self.PerkUse then
				self.PerkUse = true

				if use > 0 then
					self:SetCycle(0)
	            	self:ResetSequence(use)
	        	end

				if self.UsingTimeSlip then
		            self.PerkTime = CurTime() + 1.75
		        else
		            self.PerkTime = CurTime() + 3.5
				end
	        end

        	if CurTime() > self.PerkTime and !self.PerkFinish then
        		self.PerkFinish = true

				if self:GetPerkID() == "pap" then
					self.PapWpn:WeaponEject()
					self:SetHasPapGun(true)
				end

        		self:StopParticles()
            	self.PerkTime = CurTime() + 1
        	end

        	if CurTime() > self.PerkTime and self.PerkInUse and self.PerkFinish then
				self.PerkInUse 		= false
				self.PerkUse 		= false
				self.PerkTime		= false
        		self.PerkFinish 	= false
				self:SetBeingUsed(false)
				self.StartPerkLoop 	= false
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
	if entity:IsPlayer() and !self.Bumped and self.UseJingle then
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
                	center = self:GetPos() + self:GetUp() * 35
                	fwd = self:GetForward()
                end

                if ( dlight ) then
                	-- NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE 

					local PerkData = nzPerks:Get(self:GetPerkID())
                    local col = PerkData.color or usedcolor
                    local col_cw = PerkData.color_cw or col
					local col_spooky = PerkData.color_spooky or col
					local col_origins_red = PerkData.color_redtomb or col
                    local col_classic = PerkData.color_classic or col

					local cwskin = PerkData.model_cw
					local spookyskin = PerkData.model_spooky
					local redtombskin = PerkData.model_origins_red
					local classicskin = PerkData.model_classic

					if self:GetModel() == cwskin then
						col = col_cw
					end
					
					if self:GetModel() == classicskin then
						col = col_classic
					end
					
					if self:GetModel() == spookyskin then
						col = col_spooky
					end

					if self:GetModel() == redtombskin then
						col = col_origins_red
					end

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
            if (!self.IdleAmbience or !IsValid(self.IdleAmbience)) and isstring(self:GetLoopingSound()) then
            	self.IdleAmbience = self:GetLoopingSound()
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