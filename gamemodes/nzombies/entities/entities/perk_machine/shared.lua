AddCSLuaFile()

ENT.Type			= "anim"

ENT.PrintName		= "perk_machine"
ENT.Author			= "Alig96"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

local cvar_developer = GetConVar("developer")

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "LastUser")

	self:NetworkVar("String", 0, "PerkID")
	self:NetworkVar("String", 1, "PapWeapon")
	self:NetworkVar("String", 2, "LoopingSound")

	self:NetworkVar("Bool", 0, "Active")
	self:NetworkVar("Bool", 1, "BeingUsed")
	self:NetworkVar("Bool", 2, "LooseChange")
	self:NetworkVar("Bool", 3, "BrutusLocked")
	self:NetworkVar("Bool", 4, "HasPapGun")

	self:NetworkVar("Bool", 5, "Winding")
	self:NetworkVar("Bool", 6, "Selected")

	self:NetworkVar("Bool", 7, "Randomize")
	self:NetworkVar("Bool", 8, "RandomizeFizz")
	self:NetworkVar("Bool", 9, "RandomizeRounds")
	self:NetworkVar("Bool", 10, "DoorActivated")

	self:NetworkVar("Int", 2, "RandomizeInterval")

	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Int", 1, "UpgradePrice")

	if (CLIENT) then
		self:NetworkVarNotify("Winding", function(ent, name, old, new)
			if tobool(old) and !tobool(new) then
				local dlight = DynamicLight(self:EntIndex(), false)
				if ( dlight ) then
					dlight.pos = self:GetPos() + vector_up
					dlight.r = 255
					dlight.g = 255
					dlight.b = 255
					dlight.brightness = 4
					dlight.Decay = 5000
					dlight.Size = 512
					dlight.DieTime = CurTime() + 0.5
				end
			end
		end)
		self:NetworkVarNotify("Selected", function(ent)
			if ent.Beam and IsValid(ent.Beam) then
				ent.Beam:StopEmissionAndDestroyImmediately()
			end
		end)
	end
	if (SERVER) then
		self:NetworkVarNotify("PerkID", function(ent, name, old, new)
			if ((tostring(old) == "pap") or (tostring(new) == "pap")) then
				timer.Simple(0, function()
					nzPerks:RebuildPaPCount()
				end)
			end
		end)
	end
end

function ENT:Initialize()
	if SERVER then
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_VPHYSICS )
		self:DrawShadow( true )
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

		self.NextBump = CurTime() + 1
		self.PerkUseCoolDown = CurTime() + 1
		self.PerkTime = false

		-- For Selectable Machines
		self.UseMist = false
		self.UseJingle = false
		self.PowSnd = false

		//for randomization
		self.RisingDistance = 32
		self.RandomizationTime = 5
		self.RisingTime = 4.85
		self.FallingTime = 0.15 //these two should equal randomization time
	end

	self:SetBeingUsed(false)
	self:SetLooseChange(true)
	self:SetBrutusLocked(false)
	self:SetWinding(false)
	self:SetSelected(false)
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

	if self:GetNoDraw() then return end

	self:EmitSound(self.PowSnd, 90, math.random(95,105))
end

function ENT:TurnOff()
	self:SetActive(false)
	self:ToggleSmoke(false)
	self:Update()

	self.PlayPowerOffAnim = false
end

function ENT:HideMachine()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		ParticleEffect("nz_perkmachine_warp_end", self:GetPos() + vector_up, angle_zero)
		self:EmitSound("nz_moo/perkacola/beam_fx.wav", SNDLVL_TALKING, math.random(97,103), 1, CHAN_STATIC)
	end)

	self:ToggleSmoke(false)
	self:StopSound(self:GetLoopingSound())
	if self.Jingle then
		self:StopSound(self.Jingle)
	end

	self:SetTrigger(false)
	self:SetNoDraw(true)
	self:SetSolid(SOLID_NONE)
end

local bloat = Vector(1,1,0)
function ENT:ShowMachine(revealed)
	self:SetNoDraw(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetTrigger(true)

	local mins, maxs = self:GetCollisionBounds()
	for _, ply in pairs(ents.FindInBox(self:LocalToWorld(mins - bloat), self:LocalToWorld(maxs + bloat))) do
		if IsValid(ply) and ply:IsPlayer() then
			self:WarpPlayer(ply)
		end
	end

	if revealed then
		timer.Simple(0, function()
			if not IsValid(self) then return end
			ParticleEffect("nz_perkmachine_warp_end", self:GetPos() + vector_up, angle_zero)
			if !self:GetRandomize() then
				self:EmitSound("nz_moo/perkacola/beam_fx.wav", SNDLVL_TALKING, math.random(97,103), 1, CHAN_STATIC)
			end
		end)

		self.DoorRevealed = true
	end

	if self:GetActive() then
		self:ToggleSmoke(true)
		self.NextJingle = CurTime() + math.random(0,600)

		local seq, dur = self:LookupSequence("perk_power_on")
		if seq > 0 then
			self.FinishPowerOnSequence = CurTime() + dur
			self:ResetSequence(seq)
		else
			self.FinishPowerOnSequence = CurTime() + 1
		end
	end
end

function ENT:StartRolling(reroll)
	if self:GetPerkID() == "pap" and nzMapping.Settings.randompap then return end
	if self:GetWinding() then return end

	self:SetSolid(SOLID_NONE)
	if self:GetActive() then
		self:ToggleSmoke(false)
	end

	if !self.StoredPerkID then
		self.StoredPerkID = self:GetPerkID()
	end

	if !self.StoredReroll and reroll then
		self.StoredReroll = self.RolledPerk

		if cvar_developer:GetBool() then
			print("current roll "..self.StoredReroll)
		end
	end

	self.ReturnPos = self:GetPos()
	self.RolledPerk = nzRound:InState(ROUND_CREATE) and self:GetPerkID() or self:GetRandomPerk(reroll)
	self:SetWinding(true)
	self.RandomizeStart = CurTime()
	self.FinishPowerOnSequence = CurTime() + self.RandomizationTime + engine.TickInterval()
	self.NextRandomize = CurTime() + math.Rand(0,0.25)

	//the sin
	self.GlowFucker = ents.Create("nz_script_prop")
	self.GlowFucker:SetPos(self:GetPos())
	self.GlowFucker:SetNoDraw(true)
	self.GlowFucker:AddEFlags(EFL_IN_SKYBOX)
	self.GlowFucker:Spawn()
	self.GlowFucker:SetSolid(SOLID_NONE)

	timer.Simple(0, function()
		if not IsValid(self) or not IsValid(self.GlowFucker) then return end
		ParticleEffectAttach("nz_perkmachine_warp", PATTACH_ABSORIGIN_FOLLOW, self.GlowFucker, 1)

		self:StopSound(self:GetLoopingSound())
		if self.Jingle then
			self:StopSound(self.Jingle)
		end
	end)

	self:StopSound(self:GetLoopingSound())
	if self.Jingle then
		self:StopSound(self.Jingle)
	end

	self:EmitSound("nz_moo/perkacola/rando_start_b.wav", SNDLVL_TALKING, 100, 1, CHAN_STATIC)
	self:EmitSound("nz_moo/perkacola/slot_machine.wav", SNDLVL_TALKING, 100, 1, CHAN_STATIC)

	util.ScreenShake(self:GetPos(), 5, 2, 1.5, 512)
end

function ENT:StopRolling()
	self:SetSolid(SOLID_VPHYSICS)
	self:SetPos(self.ReturnPos)
	self:SetPerkID(self.RolledPerk or self:GetPerkID())
	self:SetWinding(false)
	self:Update()

	timer.Simple(0, function()
		if not IsValid(self) then return end
		if self:GetActive() then
			self:ToggleSmoke(true)
		end
	end)

	self.ReturnPos = nil
	self.RandomizeStart = nil
	self.NextRandomize = nil
	self.NextJingle = CurTime() + math.random(0,300)
	self.LastRandomPerk = nil
	if self.GlowFucker then
		self.GlowFucker:StopParticles()
		self.GlowFucker:Remove()
		self.GlowFucker = nil
	end

	local mins, maxs = self:GetCollisionBounds()
	for _, ply in pairs(ents.FindInBox(self:LocalToWorld(mins - bloat), self:LocalToWorld(maxs + bloat))) do
		if IsValid(ply) and ply:IsPlayer() then
			self:WarpPlayer(ply)
		end
	end

	self:EmitSound("nz_moo/perkacolas/bump/vend_0"..math.random(0,2)..".mp3", SNDLVL_TALKING, 100, 1, CHAN_STATIC)
	ParticleEffect("nz_perkmachine_warp_end", self:GetPos() + vector_up, angle_zero)

	if self.StoredReroll then
		self.StoredReroll = nil
	end

	util.ScreenShake(self:GetPos(), 5, 5, 0.5, 512)
end

function ENT:Reset()
	self:TurnOff()

	self.StoredPrice = nil
	self.StoredPriceUpgrade = nil

	if self.StoredPerkID then
		self:SetPerkID(self.StoredPerkID)
		self:Update()
		self.StoredPerkID = nil
	end

	if self.SpawnPos then
		self:SetPos(self.SpawnPos)
	end

	self:SetNoDraw(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)
	self:SetTrigger(true)

	self:SetColor(color_white)
	self:SetRenderMode(RENDERMODE_NORMAL)
	self:SetRenderFX(0)

	self.ReturnPos = nil
	self.RandomizeStart = nil
	self.NextRandomize = nil
	self.LastRandomPerk = nil
	self.RolledPerk = nil
	self.MarkedForRemoval = nil
	self.DoorRevealed = nil
	self:SetSelected(false)
	self:SetLastUser(nil)

	if self.GlowFucker and IsValid(self.GlowFucker) then
		self.GlowFucker:StopParticles()
		self.GlowFucker:Remove()
		self.GlowFucker = nil
	end

	self:SetBrutusLocked(false)
end

function ENT:ToggleSmoke(toggle)
	if self:GetNoDraw() then return end

	local smoketab = nzPerks:Get(self:GetPerkID()).smokeparticles
	if !self.UseMist or !smoketab then return end

	if toggle then
		for k, v in pairs(smoketab) do
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
			PowerOnSnd 		= {"nz_moo/perkacolas/fountain/zmb_fntn_zm_blood_on.mp3"},
			AmbSnd 			= {"nz_moo/perkacolas/fountain/zmb_fntn_main_lp.wav"},
			AllowJingle 	= {false},
			AllowMist 		= {false},
		},
		["RZ"] = {
			PerkModel       = {PerkData.model_rz},
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

	if GetConVar("nz_oldtunes"):GetInt() == 1 and isstring(PerkData.old_jingle) and isstring(PerkData.old_sting) then
		self.Jingle = PerkData.old_jingle
		self.Sting = PerkData.old_sting
	end

	self:PhysicsDestroy()

	if self.PerkTbl[perktype].PerkModel[1] then
		self:SetModel(self.PerkTbl[perktype].PerkModel[1])
	else
		self:SetModel(PerkData.model or "")
	end

	self:SetMoveType(MOVETYPE_NONE)

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
			["xmas"] = {
				PapModel       	= {PerkData.model_xmas},
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

	local price = self.PerkTbl[perktype].Price[1]
	local billnye = self.PerkTbl[perktype].UpgradePrice[1]
	if self:GetPerkID() == "pap" then
		price = 5000
		billnye = 2500
	end

	self:SetPrice(self.StoredPrice or self.PriceOverride or price)
	self:SetUpgradePrice(self.StoredPriceUpgrade or self.PriceOverrideUpgrade or billnye)

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
	if self:GetWinding() then return end
	if nzRound:InProgress() and nzMapping.Settings.randompap and self:GetPerkID() == "pap" and (!self:GetSelected() and !nzPowerUps:IsPowerupActive("bonfiresale") and !IsValid(self.PapWpn)) then
		return
	end
	if self:GetBeingUsed() and self:IsOn() and activator == self:GetLastUser() then return end
	if activator.NextUse and activator.NextUse > CurTime() then return end

	if CurTime() < self.PerkUseCoolDown then return end

	local PerkData = nzPerks:Get(self:GetPerkID())

	if IsValid(self.PapWpn) and self.PapWpn.CanTake then
		self.PapWpn:Use(activator, caller)
		self.PerkUseCoolDown = CurTime() + 1
		return
	end 

	if self:IsOn() and !self:BrutusLocked() then
		local price = activator:IsInCreative() and 0 or self:GetPrice()

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
						activator:SetUsingSpecialWeapon(true)
						local wep = activator:Give(nzMapping.Settings.bottle or "tfa_perk_bottle")
						if IsValid(wep) then wep:SetPerk(id) end

						timer.Simple(2.15, function()
							if IsValid(activator) and activator:GetNotDowned() then
								activator:GivePerk(id, self)
							end
						end)

						self:SetLastUser(activator)
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
						activator:SetUsingSpecialWeapon(true)
						local wep = activator:Give(nzMapping.Settings.bottle or "tfa_perk_bottle")
						if IsValid(wep) then wep:SetPerk(id) end

						if IsValid(activator) and activator:GetNotDowned() then
							activator:GiveUpgrade(id, self)
						end

						self:SetLastUser(activator)
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
				if #activator:GetPerks() < activator:GetMaxPerks() or self:GetPerkID() == "pap" or (activator:IsInCreative() and nzRound:InState(ROUND_CREATE)) then
					activator:Buy(price, self, func)
				end
			else
				if tobool(nzMapping.Settings.perkupgrades) then
					activator:Buy(activator:IsInCreative() and 0 or self:GetUpgradePrice(), self, upgradefunc)
				end
			end
		else
			func()
		end

		if self:GetPerkID() ~= "pap" and !activator:CanAfford(price) and self.UseJingle and !activator:IsInCreative() then
			self:EmitSound("nz_moo/perkacolas/deny_00.mp3", 90, math.random(97, 103))
		end

		activator.NextUse = CurTime() + 0.25
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

	/*
		.--'''''''''--.
     .'      .---.      '.
    /    .-----------.    \
   /        .-----.        \
   |       .-.   .-.       |
   |      /   \ /   \      |
    \    | .-. | .-. |    /
     '-._| | | | | | |_.-'
         | '-' | '-' |
          \___/ \___/
       _.-'  /   \  `-._
     .' _.--|     |--._ '.
     ' _...-|     |-..._ '
            |     |
            '.___.'
              | |
             _| |_
            /\( )/\
           /  ` '  \
          | |     | |
          '-'     '-'
          | |     | |
          | |     | |
          | |-----| |
       .`/  |     | |/`.
       |    |     |    |
       '._.'| .-. |'._.'
             \ | /
             | | |
             | | |
             | | |
            /| | |\
          .'_| | |_`.
          `. | | | .'
       .    /  |  \    .
      /o`.-'  / \  `-.`o\
     /o  o\ .'   `. /o  o\
     `.___.'       `.___.'
	*/

	local cost = self:GetPrice()
	if reroll then
		cost = self:GetUpgradePrice()
	end
	if nzPowerUps:IsPowerupActive("bonfiresale") then
		cost = math.Round(cost/5)
	end
	if nzRound:InState(ROUND_CREATE) and activator:IsInCreative() then
		cost = 0
	end

	activator:Buy(cost, machine, function()
		hook.Call("OnPlayerBuyPackAPunch", nil, activator, wep, machine)

		activator:SetUsingSpecialWeapon(true)
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
		if self:GetWinding() and self.RandomizeStart then
			if self.RandomizeStart + self.RisingTime > CurTime() then
				self:SetPos(self:GetPos() + vector_up*(self.RisingDistance/(self.RisingTime/engine.TickInterval())))

				if !self.NextRandomize or self.NextRandomize < CurTime() then
					local perk = self:GetRandomPerk() or self:GetPerkID()
					self:SetPerkID(perk)
					self:Update()
					self.LastRandomPerk = perk

					self.NextRandomize = CurTime() + math.Rand(0.2,0.3)

					local seq = self:LookupSequence("perk_power_on")
					if seq > 0 then
						self:ResetSequence(seq)
					end

					util.ScreenShake(self:GetPos(), 5, 5, 2, 32)
				end
			else
				if self.NextRandomize then
					self.NextRandomize = nil

					self:SetPerkID(self.RolledPerk)
					self:Update()

					local seq = self:LookupSequence("perk_power_on")
					if seq > 0 then
						self:ResetSequence(seq)
					end

					self:EmitSound("nz_moo/perkacola/beam_fx.wav", SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
					util.ScreenShake(self.SpawnPos or self:GetPos(), 5, 5, 2, 32)
				end

				self:SetPos(self:GetPos() - vector_up*(self.RisingDistance/(self.FallingTime/engine.TickInterval())))
			end

			if self.RandomizeStart + self.RandomizationTime < CurTime() then
				self:StopRolling()
			end
		end

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

		if self:IsOn() and !self:GetNoDraw() and CurTime() > self.NextJingle and !self.PlayingJingle and self.UseJingle then
			local NJ = CurTime() + math.random(300,900)
			local WFJ = CurTime() + 55

			if self.Jingle then
				self.PlayingJingle = true

				self.NextJingle = NJ
				self.WaitforJingle = WFJ

				self:EmitSound(self.Jingle, 75, math.random(97, 103))
			end
		end

		if CurTime() > self.WaitforJingle and self.PlayingJingle then
			self.PlayingJingle = false -- This is just because mp3s don't work with getting their duration.
		end

		if self.MarkedForRemoval and (!self.PapWpn or !IsValid(self.PapWpn)) then
			self.MarkedForRemoval = nil
			self:SetSelected(false)

			self:StopSound(self:GetLoopingSound())
			if self.Jingle then
				self:StopSound(self.Jingle)
			end
			self:HideMachine()
		end

		if nzMapping.Settings.randompap and self:GetPerkID() == "pap" and nzRound:InProgress() then
			if self:IsOn() and nzPowerUps:IsPowerupActive("bonfiresale") then
				if (!self:GetDoorActivated() or self.DoorRevealed) and self:GetNoDraw() then
					self:ShowMachine()
				end
			elseif !self:GetSelected() and !self:GetNoDraw() then
				self.MarkedForRemoval = true
			end
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

//fuck you sincerely
function ENT:GetRandomPerk(reroll)
	local next_roll
	local fizz_list = nzMapping.Settings.wunderfizzperklist
	local machines = ents.FindByClass("perk_machine")

	local map_perks = {}
	local random_perks = {}
	local illegal_perks = {
		["wunderfizz"] = true,
		["pap"] = true,
	}

	if self.StoredPerkID and !reroll then
		random_perks[self.StoredPerkID] = true
	end

	for _, ent in pairs(machines) do
		if ent:GetRandomize() and !ent:GetRandomizeFizz() then
			if reroll and self:GetRandomizeRounds() then
				if (ent:GetRandomizeRounds() and ent:GetRandomizeInterval() == self:GetRandomizeInterval()) or (ent:GetDoorActivated() and !ent.DoorRevealed) then
					random_perks[ent.StoredReroll or ent.RolledPerk or ent:GetPerkID()] = true
				end
			else
				random_perks[ent.StoredPerkID or ent:GetPerkID()] = true
			end
		end
	end

	if !self:GetWinding() then
		//this code is run on first call only, to determine actual perk
		if reroll then
			for _, ent in pairs(machines) do
				if ent.StoredReroll and random_perks[ent.RolledPerk] and !ent:GetRandomizeFizz() then
					random_perks[ent.RolledPerk] = nil
				end
			end
		else
			for _, ent in pairs(machines) do
				if ent.RolledPerk and random_perks[ent.RolledPerk] then
					random_perks[ent.RolledPerk] = nil
				end
			end
		end
	else
		if self.StoredReroll and self:GetRandomizeRounds() then
			for _, ent in pairs(machines) do
				if (!ent:GetRandomizeRounds() or ent:GetRandomizeInterval() ~= self:GetRandomizeInterval()) then
					if random_perks[ent.RolledPerk or ent:GetPerkID()] and !ent:GetRandomizeFizz() then
						random_perks[ent.RolledPerk or ent:GetPerkID()] = nil
					end
				end
			end
		end
	end

	//why would you do that :(
	if random_perks["pap"] and nzMapping.Settings.randompap then
		random_perks["pap"] = nil
	end

	if self.StoredReroll and reroll and table.IsEmpty(random_perks) then
		if cvar_developer:GetBool() then
			print("machine taken")
		end
		random_perks[self.StoredReroll] = true
	end

	for _, ent in pairs(machines) do
		if ent.GetPerkID then
			if ent:GetRandomizeFizz() then
				map_perks[ent.RolledPerk or ent:GetPerkID()] = true
			else
				map_perks[ent.StoredPerkID or ent:GetPerkID()] = true
			end
		end
	end

	if self:GetRandomizeFizz() then
		for perk, _ in RandomPairs(nzPerks:GetList()) do
			if illegal_perks[perk] then continue end
			if fizz_list and (!fizz_list[perk] or !fizz_list[perk][1]) then continue end
			if map_perks[perk] then continue end
			if self.LastRandomPerk and perk == self.LastRandomPerk then continue end

			next_roll = perk
			break
		end
	else
		for perk, _ in RandomPairs(random_perks) do
			if perk == "wunderfizz" then continue end
			if self.LastRandomPerk and perk == self.LastRandomPerk then continue end

			next_roll = perk
			break
		end
	end

	if next_roll then
		if !self:GetWinding() then
			if !self:GetRandomizeFizz() then
				for _, ent in pairs(machines) do
					if ent:GetRandomize() and ent:GetPerkID() == next_roll then
						local b_machinefound = false

						if (ent.StoredPrice or ent.PriceOverride) then
							if reroll then
								self.StoredPrice = ent.StoredPrice or ent.PriceOverride
							else
								self.StoredPrice = ent.PriceOverride
							end

							b_machinefound = true
						end
						if (ent.StoredPriceUpgrade or ent.PriceOverrideUpgrade) then
							if reroll then
								self.StoredPriceUpgrade = ent.StoredPriceUpgrade or ent.PriceOverrideUpgrade
							else
								self.StoredPriceUpgrade = ent.PriceOverrideUpgrade
							end

							b_machinefound = true
						end

						if b_machinefound then
							break
						end
					end
				end
			end

			if cvar_developer:GetBool() then
				print("next roll "..next_roll)
				PrintTable(random_perks)
			end
		end
	elseif cvar_developer:GetBool() then
		print("nothing to roll!")
	end

	return next_roll
end

function ENT:WarpPlayer(ply)
	local pspawns = ents.FindByClass("player_spawns")
	local pos = ply:GetPos()

	if IsValid(pspawns[1]) then
		pos = pspawns[math.random(#pspawns)]:GetPos()
	else
		ply:ChatPrint("[NZ] No player spawns to teleport to, failed.")
	end

	sound.Play("nzr/2022/perks/chuggabud/teleport_out_0"..math.random(0,1)..".wav", ply:EyePos(), SNDLVL_GUNFIRE, math.random(97,103), 1)

	ply:SetLocalVelocity(vector_origin)
	ply:SetPos(pos)

	ply:StopSound("nz_moo/effects/out_of_play_area.wav")
	ply:EmitSound("nz_moo/effects/out_of_play_area.wav", SNDLVL_IDLE, math.random(97, 103), 1, CHAN_STATIC)

	ParticleEffect("nz_perks_chuggabud_tp", pos + vector_up, angle_zero)
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
	if entity:IsPlayer() and (!self.NextBump or self.NextBump < CurTime()) and self.UseJingle then
		self:EmitSound("nz_moo/perkacolas/bump/vend_0"..math.random(0,2)..".mp3", SNDLVL_TALKING)
		self.NextBump = CurTime() + 1
	end
end

if CLIENT then
	local usedcolor = Color(255,250,245)
	local nz_preview = GetConVar("nz_creative_preview")
	local displayfont = "ChatFont"
	local outline = Color(0,0,0,59)
	local drawdistance = 400^2
	local size = 0.25

	function ENT:Draw()
		self:DrawModel()

		local perk = self:GetPerkID()
		if self:GetWinding() then
			local dlight = DynamicLight(self:EntIndex(), false)
			if ( dlight ) then
				dlight.pos = self:GetPos() + vector_up
				dlight.r = 255
				dlight.g = 255
				dlight.b = 255
				dlight.brightness = 2
				dlight.Decay = 2000
				dlight.Size = 256
				dlight.DieTime = CurTime() + 0.5
			end
		elseif self:GetActive() then
			if nzMapping.Settings.papbeam and perk == "pap" and (!nzMapping.Settings.randompap or (nzPowerUps:IsPowerupActive("bonfiresale") or self:GetSelected()) or !nzRound:InProgress()) then
				if (!self.Beam or !IsValid(self.Beam)) then
					self.Beam = CreateParticleSystem(self, "mysterybox_beam", PATTACH_ABSORIGIN_FOLLOW)
				elseif IsValid(self.Beam) then
					local beamcolor = nzMapping.Settings.paplightcolor
					self.Beam:SetControlPoint(2, Vector(beamcolor.r, beamcolor.g, beamcolor.b):GetNormalized()) -- Color
					self.Beam:SetControlPoint(0, self:GetPos() + vector_up*35) -- Bottom position
					self.Beam:SetControlPoint(1, self:GetPos() + vector_up*4000) -- Top position
				end
			elseif self.Beam and IsValid(self.Beam) then
				self.Beam:StopEmissionAndDestroyImmediately()
			end

			if !self.NextLight or CurTime() > self.NextLight then
				local dlight = DynamicLight(self:EntIndex(), true)
				local center = self:OBBCenter() * 0.25
				local fwd = self:GetForward() * 35
				local mymodel = self:GetModel()

				if perk == "pap" then
					center = self:GetPos() + self:GetUp() * 35
					fwd = self:GetForward()
				end

				if ( dlight ) then
					-- NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE NIGHTMARE 

					local PerkData = nzPerks:Get(self:GetPerkID())
					local col = PerkData.color or usedcolor

					local perk_color_by_model = {
						[tostring(PerkData.model_cw)] = PerkData.color_cw,
						[tostring(PerkData.model_vg)] = PerkData.color_vg,
						[tostring(PerkData.model_spooky)] = PerkData.color_spooky,
						[tostring(PerkData.model_xmas)] = PerkData.color_xmas,
						[tostring(PerkData.model_origins_red)] = PerkData.color_redtomb,
						[tostring(PerkData.model_classic)] = PerkData.color_classic,
					}

					if mymodel and perk_color_by_model[mymodel] then
						col = perk_color_by_model[mymodel]
					end
					if !col or !IsColor(col) then
						col = (PerkData.color or usedcolor)
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

			if self:GetLoopingSound() ~= "" then
				self:EmitSound(self:GetLoopingSound(), 65, 100, 1, 3)
			end
		elseif self.Beam and IsValid(self.Beam) then
			self.Beam:StopEmissionAndDestroyImmediately()
		end
	end
end

function ENT:OnRemove()
	if CLIENT then
		self:StopSound(self:GetLoopingSound())
		if self.Beam and IsValid(self.Beam) then
			self.Beam:StopEmissionAndDestroyImmediately()
		end
	end

	if SERVER and self:GetPerkID() == "pap" then
		timer.Simple(0, function()
			nzPerks:RebuildPaPCount()
		end)
	end
end