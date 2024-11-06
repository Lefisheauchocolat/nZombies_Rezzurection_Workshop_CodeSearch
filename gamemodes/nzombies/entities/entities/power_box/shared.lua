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

	self:NetworkVar("Float", 0, "ResetTime")
end

function ENT:Initialize()
	if SERVER then
		self:SetModel( "models/zmb/bo2/power/build_power_body.mdl" )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_NONE )
		self:SetUseType( ONOFF_USE )
		self:SetSwitch(false)
		
		self.Handle = ents.Create("nz_prop_effect_attachment")
		self.Handle:SetModel("models/zmb/bo2/power/build_power_lever.mdl")
		self.Handle:SetAngles( self:GetAngles() + Angle(90,0,0) )
		self.Handle:SetPos(self:GetPos() + self:GetAngles():Up()*46.25 + self:GetAngles():Forward()*9)
		self.Handle:Spawn()
		self.Handle:SetParent(self)
		self:SetPowerHandle(self.Handle)
		
		self:DeleteOnRemove( self.Handle )
	else
		self.Switched = false
	end
end

function ENT:Use( activator )
	if ( !activator:IsPlayer() ) then return end
	if nzRound:InState(ROUND_CREATE) and activator:IsInCreative() then
		if self.NextUse and self.NextUse > CurTime() then return end
		self.NextUse = CurTime() + 2

		self:SetSwitch(true)
		self:EmitSound("nz_moo/effects/switch_flip_flux.mp3", 90, math.random(95,105))
		timer.Simple(1, function()
			if not IsValid(self) then return end
			self:SetSwitch(false)
		end)
		return
	end
	if !nzRound:InProgress() then return end

	if self:GetLimited() == true and self:GetAOE() > 0 then
		net.Start("nz.nzElec.Sound")
			net.WriteBool(true)
		net.SendPAS(self:GetPos()) //send to players in 'Potentially Audible Set' (pvs for sound)

		self:EmitSound("nz_moo/effects/switch_flip_flux.mp3", 90, math.random(95,105))
		self:SetSwitch(true)
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

				self:SetSwitch(false)
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
					self:EmitSound("nz_moo/effects/switch_flip_flux.mp3", 90, math.random(95,105))
					self:SetSwitch(true)
				end
				return false
			end
		end

		if !IsElec() then
			self:SetSwitch(true)
			//self.Switched = 0
			self:EmitSound("nz_moo/effects/switch_flip_flux.mp3", 90, math.random(95,105))
			nzElec:Activate()
		end
	end
end

if CLIENT then
	local offang = Angle(90,0,0)
	local onang = Angle(0,0,0)

	function ENT:Think()
		local handle = self:GetPowerHandle()
		if self:GetSwitch() != self.Switched then
			self.Switching = math.Approach( self.Switching or 0, 1, FrameTime() * 1.75 )
			local ang = self:GetAngles()
			if self:GetSwitch() then
				handle:SetRenderAngles(LerpAngle(self.Switching, self:LocalToWorldAngles(offang), self:LocalToWorldAngles(onang)))
			else
				handle:SetRenderAngles(LerpAngle(self.Switching, self:LocalToWorldAngles(onang), self:LocalToWorldAngles(offang)))
			end
			
			if self.Switching >= 1 then
				self.Switched = self:GetSwitch()
				self.Switching = nil
			end
		end
	end

	function ENT:Draw()
		self:DrawModel()
	end
end