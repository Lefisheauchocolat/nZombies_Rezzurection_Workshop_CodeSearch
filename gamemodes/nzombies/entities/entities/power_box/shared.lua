AddCSLuaFile( )

ENT.Type = "anim"
 
ENT.PrintName		= "Zombies Power"
ENT.Author			= "Zet0r"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Switch")
	self:NetworkVar("Bool", 1, "Limited")
	self:NetworkVar("Bool", 2, "RequireAll")
	self:NetworkVar("Bool", 3, "DoReset")

	self:NetworkVar("Entity", 0, "PowerHandle")

	self:NetworkVar("Int", 0, "AOE")
	self:NetworkVar("Int", 1, "PowerSwitchModel")
	self:NetworkVar("Int", 2, "ActivationType")
	self:NetworkVar("Int", 3, "DmgType")

	self:NetworkVar("Float", 0, "ResetTime")
end

function ENT:Initialize()
	if SERVER then
		self.AutomaticFrameAdvance = true

		self:SetSolid( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetUseType( ONOFF_USE )
		self:SetSwitch(false)
		
		local tbl = {
			[0] = {
				panelmodel       	= {"models/zmb/bo2/power/build_power_body.mdl"},
				switchmodel       	= {"models/zmb/bo2/power/build_power_lever.mdl"},
				activatesnd 		= {"nz_moo/effects/switch_flip_flux.mp3"},
				pos 				= self:GetPos() + self:GetAngles():Up()*46.25 + self:GetAngles():Forward()*9,
				angle 				= Angle(90,0,0),
			},
			[1] = {
				panelmodel       	= {"models/moo/_codz_ports_props/t10/t10_zm_power_switch/moo_codz_t10_zm_power_switch.mdl"},
				switchmodel       	= {"models/moo/_codz_ports_props/t10/t10_zm_power_switch_handle/moo_codz_t10_zm_power_switch_handle.mdl"},
				activatesnd 		= {"nz_moo/effects/switch_flip_flux.mp3"},
				pos 				= self:GetPos() + self:GetAngles():Up()*46.25 + self:GetAngles():Forward()*7.5,
				angle 				= Angle(0,0,0),
			},
			[2] = {
				panelmodel       	= {"models/moo/_codz_ports_props/t4/zombie/zombie_power_lever/moo_codz_zm_power_switch.mdl"},
				switchmodel       	= {"models/moo/_codz_ports_props/t4/zombie/zombie_power_lever_handle/moo_codz_zm_power_switch_handle.mdl"},
				activatesnd 		= {"nz_moo/effects/switch_flip_flux.mp3"},
				pos 				= self:GetPos() + self:GetAngles():Up()*46.25 + self:GetAngles():Forward()*7.5,
				angle 				= Angle(0,0,0),
			},
			[3] = {
				panelmodel       	= {"models/moo/_codz_ports_props/t4/zombie/zombie_power_lever_short/moo_codz_zm_power_switch_short.mdl"},
				switchmodel       	= {"models/moo/_codz_ports_props/t4/zombie/zombie_power_lever_handle/moo_codz_zm_power_switch_handle.mdl"},
				activatesnd 		= {"nz_moo/effects/switch_flip_flux.mp3"},
				pos 				= self:GetPos() + self:GetAngles():Up()*46.25 + self:GetAngles():Forward()*7.5,
				angle 				= Angle(0,0,0),
			},
			[4] = {
				panelmodel       	= {"models/moo/_codz_ports_props/s2/zmb/zmb_circuit_breaker_02/moo_codz_s2_zmb_circuit_breaker_02.mdl"},
				switchmodel       	= {nil},
				activatesnd 		= {"nz_moo/effects/zmb_switch_on.mp3"},
				pos 				= self:GetPos(),
				angle 				= Angle(0,0,0),
			},
			[5] = {
				panelmodel       	= {"models/moo/_codz_ports_props/iw7/zmb/icbm_electricpanel9/moo_codz_iw7_icbm_electricpanel9.mdl"},
				switchmodel       	= {"models/moo/_codz_ports_props/iw7/zmb/icbm_electricpanel_switch_02/moo_codz_iw7_icbm_electricpanel_switch_02.mdl"},
				activatesnd 		= {"nz_moo/effects/switch_flip_flux.mp3"},
				pos 				= self:GetPos() + self:GetAngles():Right()*5.05 + self:GetAngles():Up()*1 + self:GetAngles():Forward()*4.5,
				angle 				= Angle(45,0,0),
			},
			[6] = {
				panelmodel       	= {"models/moo/_codz_ports_props/t6/alcatraz/p6_zm_al_shock_box/moo_codz_p6_zm_al_shock_box.mdl"},
				switchmodel       	= {nil},
				activatesnd 		= {"nz_moo/effects/afterlife/after_panel_on.mp3"},
				pos 				= self:GetPos(),
				angle 				= Angle(0,0,0),
			},
		}

		local selection = tbl[self:GetPowerSwitchModel()]

		self:SetModel(selection.panelmodel[1])
		self.ActivationSound = selection.activatesnd[1]

		if selection.switchmodel[1] ~= nil then
			self.Handle = ents.Create("nz_prop_effect_attachment")
			self.Handle:SetModel(selection.switchmodel[1])
			self.Handle:SetAngles( self:GetAngles() + selection.angle )
			self.Handle:SetPos( selection.pos )

			self.Handle:Spawn()

			self.Handle:SetParent(self,1)
			self:SetPowerHandle(self.Handle)
			
			self:DeleteOnRemove( self.Handle )
		end

		if self:LookupSequence("off") > 0 then self:ResetSequence("off") end
	else
		self.Switched = false
	end
end

function ENT:Use( activator )
	local onanim = self:LookupSequence("on")
	local offanim = self:LookupSequence("off")

	if self:GetActivationType() == 0 or self:GetActivationType() == 1 and self.ShotSwitch then
		if ( !activator:IsPlayer() ) then return end
		if nzRound:InState(ROUND_CREATE) and activator:IsInCreative() then
			if self.NextUse and self.NextUse > CurTime() then return end
			self.NextUse = CurTime() + 2

			self:SetSwitch(true)
			self:EmitSound(self.ActivationSound, 90, math.random(95,105))

			if onanim > 0 then self:ResetSequence(onanim) end

			timer.Simple(1, function()
				if not IsValid(self) then return end
				self:SetSwitch(false)
				self.ShotSwitch = false

				if offanim > 0 then self:ResetSequence(offanim) end
			end)
			return
		end
		if !nzRound:InProgress() then return end

		if self:GetLimited() == true and self:GetAOE() > 0 then
			net.Start("nz.nzElec.Sound")
				net.WriteBool(true)
			net.SendPAS(self:GetPos()) //send to players in 'Potentially Audible Set' (pvs for sound)

			if onanim > 0 then self:ResetSequence(onanim) end

			self:EmitSound(self.ActivationSound, 90, math.random(95,105))
			self:SetSwitch(true)

			hook.Run("PowerSwitchLimitedActivate", nil, activator, self)
			//self.Switched = 0

			local weball = false
			for k, v in pairs(ents.FindByClass("wunderfizz_machine")) do
				if v:IsOn() then 
					weball = true
					break
				end
			end

			-- Open all doors with no price and electricity requirement
			for k, v in pairs(ents.FindInSphere(self:GetPos(), self:GetAOE())) do
				if v:GetClass() == "wunderfizz_machine" and !weball then 
					v:TurnOn()
				end

				if v:GetClass() == "perk_machine" and !v:IsOn() then 
					v:TurnOn()
				end

				if v:GetClass() == "nz_teleporter" then 
					v:TurnOn()
				end

				if v:GetClass() == "nz_soulbox" then 
					v:TurnOn()
				end

				if v:GetClass() == "nz_launchpad" then 
					v:TurnOn()
				end

				if v:GetClass() == "nz_button" or v:GetClass() == "nz_activatable" then
					v:Ready() 
					v.LocalPower = true -- Give it a new variable so it knows to turn on.
				end

				if v:IsBuyableEntity() then
					local data = v:GetDoorData()
					if data then
						if tonumber(data.price) == 0 and tobool(data.elec) == true then
							nzDoors:OpenDoor( v )
						end
					end
				end
			end
		else
			if self:GetDoReset() then
				timer.Simple(self:GetResetTime(), function()
					if not IsValid(self) then return end
					if nzElec:IsOn() then return end
					if !self:GetSwitch() then return end

					hook.Run("PowerSwitchReset", nil, activator, self)

					self.ShotSwitch = false
					self:SetSwitch(false)
					if offanim > 0 then self:ResetSequence(offanim) end
				end)
			end

			if self:GetRequireAll() then
				local b_allon = true
				for k, v in pairs(ents.FindByClass("power_box")) do
					if !v:GetSwitch() and !v:GetLimited() and v ~= self then 
						b_allon = false
						break
					end
				end

				if !b_allon then
					if !self:GetSwitch() then
						if onanim > 0 then self:ResetSequence(onanim) end

						hook.Run("PowerSwitchActivate", nil, activator, self)

						self:EmitSound(self.ActivationSound, 90, math.random(95,105))
						self:SetSwitch(true)
					end
					return false
				end
			end

			if !IsElec() then
				self:SetSwitch(true)
				//self.Switched = 0
				self:EmitSound(self.ActivationSound, 90, math.random(95,105))
				nzElec:Activate()

				hook.Run("PowerSwitchActivate", nil, activator, self)
				if onanim > 0 then self:ResetSequence(onanim) end
			end
		end
	end
end

function ENT:Think()
	if CLIENT then
		local handle = self:GetPowerHandle()

		-- I LOVE TABLES@#&(^$*#$%^&)
		local tbl = {
			[0] = {
				offrot 				= Angle(90,0,0),
				onrot 				= Angle(0,0,0),
			},
			[1] = {
				offrot 				= Angle(0,0,0),
				onrot 				= Angle(-90,0,0),
			},
			[2] = {
				offrot 				= Angle(0,0,0),
				onrot 				= Angle(-90,0,0),
			},
			[3] = {
				offrot 				= Angle(0,0,0),
				onrot 				= Angle(-90,0,0),
			},
			[4] = {
				offrot 				= nil,
				onrot 				= nil,
			},
			[5] = {
				offrot 				= Angle(45,0,0),
				onrot 				= Angle(-45,0,0),
			},
			[6] = {
				offrot 				= nil,
				onrot 				= nil,
			},
		}

		local offang = tbl[self:GetPowerSwitchModel()].offrot
		local onang = tbl[self:GetPowerSwitchModel()].onrot


		if handle and self:GetSwitch() != self.Switched then
			self.Switching = math.Approach( self.Switching or 0, 1, FrameTime() * 1.75 )
			local ang = self:GetAngles()
			if self:GetSwitch() then
				self:SetSkin(1)
				if isangle(offang) and isangle(onang) then
					handle:SetRenderAngles(LerpAngle(self.Switching, self:LocalToWorldAngles(offang), self:LocalToWorldAngles(onang)))
				end
			else
				self:SetSkin(0)
				if isangle(offang) and isangle(onang) then
					handle:SetRenderAngles(LerpAngle(self.Switching, self:LocalToWorldAngles(onang), self:LocalToWorldAngles(offang)))
				end
			end
				
			if self.Switching >= 1 then
				self.Switched = self:GetSwitch()
				self.Switching = nil
			end
		end
	end

	self:NextThink( CurTime() )
	return true
end

local testtime = 0
function ENT:OnTakeDamage(dmginfo)
	if self:GetActivationType() == 1 then
		if self:GetSwitch() then return end
		if nzRound:InState(ROUND_CREATE) and testtime > CurTime() then return end

		local ply = dmginfo:GetAttacker()
		local wep = dmginfo:GetInflictor()

		if not IsValid(ply) then return end
		if not IsValid(wep) then return end
		if not ply:IsPlayer() then return end

		local dmgtype = dmginfo:GetDamageType()
		local meleedamage = bit.band(dmgtype, bit.bor(DMG_CLUB, DMG_SLASH, DMG_CRUSH)) ~= 0
		local burndamage = bit.band(dmgtype, bit.bor(DMG_BURN, DMG_SLOWBURN)) ~= 0
		local shockdamage = bit.band(dmgtype, bit.bor(DMG_SHOCK, DMG_ENERGYBEAM)) ~= 0
		local blastdamage = dmginfo:IsExplosionDamage()
		local bulletdamage = dmginfo:IsBulletDamage()

		if (self:GetDmgType() == 1 and meleedamage) or (self:GetDmgType() == 2 and blastdamage) or (self:GetDmgType() == 3 and burndamage) or (self:GetDmgType() == 4 and bulletdamage) or (self:GetDmgType() == 5 and shockdamage) then
			--[[if nzRound:InState(ROUND_CREATE) then
				ply:ChatPrint('Test activated '..self:GetClass()..'['..self:EntIndex()..']')
			return end]]

			testtime = CurTime() + 2
			self.ShotSwitch = true
			self:Use(ply)
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()

		if ConVarExists("nz_creative_preview") and !GetConVar("nz_creative_preview"):GetBool() and nzRound:InState( ROUND_CREATE ) then		
			render.SetColorMaterial()
			render.DrawSphere(self:GetPos(), self:GetAOE(), 50, 50, Color(200, 200, 0, 35))
		end	
	end
end