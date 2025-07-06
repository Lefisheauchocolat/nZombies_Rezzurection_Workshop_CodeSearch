AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "pap_weapon_fly"
ENT.Author			= "Zet0r(Fuck you DBD man)"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "WeaponReady")
	self:NetworkVar( "String", 0, "WeaponClass")
	self:NetworkVar("Entity", 0, "PaPOwner")
end

function ENT:Initialize()
		self:SetModel("models/moo/_codz_ports_props/t7/zm/p7_zm_vending_packapunch/moo_codz_p7_zm_vending_packapunch_weapon.mdl")
		--self:SetMaterial("blue_wave")

		self:SetSolid( SOLID_OBB )
		self:SetMoveType( MOVETYPE_FLY )

		self:PhysicsInitBox(Vector(-5, -10, -3), Vector(5, 10, 3))
		self:SetNotSolid(true)
		self:DrawShadow( false )
		self.TriggerPos = self:GetPos()
	
		self.AutomaticFrameAdvance = true
		self:ResetSequence("take_gun")

		self.RemoveTime = false

	if SERVER then
		self:SetUseType( SIMPLE_USE )
		self:SetWeaponClass(self.WepClass)
	else
		local wep = weapons.Get(self:GetWeaponClass())
		if wep and wep.DrawWorldModel then self.WorldModelFunc = wep.DrawWorldModel end
	end
end

function ENT:CreatePapWeapon()
	local ass = weapons.Get(self:GetWeaponClass())

	local pos = self:GetPos()
	local ang = self:GetAngles()

	if self.Pap:GetModel() == "models/moo/_codz_ports_props/t10/jup_zm_pap_fxanim/moo_codz_jup_zm_vending_packapunch.mdl" then
		pos = self:GetPos() + self:GetRight() * 1.5
		ang = self:GetAngles() + Angle(0,-90,0)
	end

	local model = (ass and ass.WM or ass.WorldModel) or "models/weapons/w_rif_ak47.mdl"
	if !util.IsValidModel(model) then model = "models/weapons/w_rif_ak47.mdl" end

	-- Seeing if delaying the fake weapon model makes the rotation be correct more consistently.(Most weapons face the wrong way like its nZ Classic.)
	timer.Simple(engine.TickInterval(), function()
		self.GunEnt = ents.Create("nz_prop_effect_attachment")
		self.GunEnt:SetModel(model)
		self.GunEnt:SetAngles(ang)
		self.GunEnt:SetPos(pos)
		self.GunEnt:Spawn()
		self.GunEnt:SetParent(self)

		self.GunEnt:FollowBone(self, 1)
		self.GunEnt:DeleteOnRemove(self)
		self.GunEnt:SetAngles(ang)
	end)
end

function ENT:WeaponEject()	
	self:ResetSequence("eject_gun")
	--self:EmitSound("nz_moo/perkacolas/pap/ready.mp3", 90, math.random(97, 103))

	local assreplacement = weapons.Get(self:GetWeaponClass())

	if assreplacement and assreplacement.NZPaPReplacement and weapons.Get(assreplacement.NZPaPReplacement) then			
		local replacewep = weapons.Get(assreplacement.NZPaPReplacement)
		local model = (replacewep and replacewep.WM or replacewep.WorldModel) or "models/weapons/w_rif_ak47.mdl"
		if !util.IsValidModel(model) then model = "models/weapons/w_rif_ak47.mdl" end

		self.GunEnt:SetModel(model)

		self:SetWeaponClass(assreplacement.NZPaPReplacement)
		self.Pap:SetPapWeapon(assreplacement.NZPaPReplacement)
	end

	self:SetWeaponReady(true)

	self.TakeDelay = CurTime() + 1

	self.RemoveTime = CurTime() + self:SequenceDuration("eject_gun")
end

function ENT:Think()
	if self.RemoveTime then
		if CurTime() > self.RemoveTime then
			SafeRemoveEntity(self)
		end
	end
	if self.TakeDelay then
		if CurTime() > self.TakeDelay then
			self.CanTake = true
		end
	end
	self:NextThink(CurTime())
	return true
end

function ENT:SetWepClass(class)
	if IsValid(self.button) then
		self.button:SetWepClass(class)
	end
	self:SetWeaponClass(class)
end

function ENT:Use(ply, caller)
	if ply == self:GetPaPOwner() and self.CanTake then
		nzPowerUps.HasPaped = true

		if ply.PAPBackupWeapon and IsValid(ply.PAPBackupWeapon) then
			ply:StripWeapon(ply.PAPBackupWeapon:GetClass())
		end

		local class = self:GetWeaponClass()
		local wep

		if self.CanReroll then
			wep = ply:GiveNoAmmo(class)
		else
			wep = ply:Give(class)
		end
		
		wep.NZPaPME = true

		if self.LastCamo then
			wep.LastCamo = self.LastCamo
		end

		timer.Simple(0, function()
			if not IsValid(ply) or not IsValid(wep) then return end

			--wep:ApplyNZModifier("pap")
			if self.CanReroll then
				wep:ApplyNZModifier("repap")
			end

			if wep.IsTFAWeapon then
				wep:SetClip1(wep.Primary_TFA.ClipSize)
				if wep.Secondary_TFA and wep.Secondary_TFA.ClipSize and wep.Secondary_TFA.ClipSize > 0 then
					wep:SetClip2(wep.Secondary_TFA.ClipSize)
				end
				if wep.Tertiary and wep.SetClip3 and wep.Tertiary.ClipSize and wep.Tertiary.ClipSize > 0 then
					wep:SetClip3(wep.Tertiary.ClipSize)
				end
			else
				wep:SetClip1(wep.Primary.ClipSize)
				if wep.Secondary and wep.Secondary.ClipSize > 0 then
					wep:SetClip2(wep.Secondary.ClipSize)
				end
			end

			self:Remove()
		end)
	else
		if IsValid(self:GetPaPOwner()) then
			ply:PrintMessage( HUD_PRINTTALK, "This is " .. self:GetPaPOwner():Nick() .. "'s gun. You cannot take it." )
		end
	end
end

function ENT:OnRemove()

	if CLIENT then
		if self.IdleAmbience or IsValid(self.IdleAmbience) then
			self:StopSound(self.IdleAmbience)
		end
	end

	if IsValid(self.Pap) then
		self.Pap:SetBeingUsed(false)
		self.Pap:SetHasPapGun(false)
	end
	if IsValid(self.button) then self.button:Remove() end
end

if CLIENT then
	function ENT:Draw()
		-- We can use the stored world model draw function from the original weapon, but if it doesn't exist or errors, then just draw model
		if !self.WorldModelFunc or !pcall(self.WorldModelFunc, self) then self:DrawModel() end
	

        if !IsValid(self) then return end
        if self:GetWeaponReady() and (!self.IdleAmbience or !IsValid(self.IdleAmbience)) then
			self.IdleAmbience = "nz_moo/perkacolas/pap/loop.wav"
			self:EmitSound(self.IdleAmbience, 70, 100, 1, 3)
		end
	end
end
