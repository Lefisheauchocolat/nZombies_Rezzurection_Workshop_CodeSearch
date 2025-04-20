AddCSLuaFile( )

ENT.Type = "anim"
 
ENT.PrintName		= "random_box_spawns"
ENT.Author			= "Zet0r"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "BoxType")
end

function ENT:Initialize()

	self.AutomaticFrameAdvance = true

	self.PlatformModel = {
		["UGX Coffin"] = {
			PLATFORM = "models/wavy_ports/ugx/ugx_coffin_teddy_platform.mdl",	
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Right()*7,
		},
		["Present Box"] = { 
			PLATFORM = "models/wavy_ports/ugx/present_platform.mdl",
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Right()*7,
		},
		["Cold War"] = { 
			PLATFORM = "models/moo/_codz_ports_props/s4/zm/zod/s4_magic_box_pile/moo_codz_s4_magic_box_pile.mdl",	
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Up()*10 + self:GetAngles():Right()*7,
		},
		["Black Ops 3"] = { 
			PLATFORM = "models/moo/_codz_ports_props/t7/_der/p7_zm_der_magic_box_fake/moo_codz_p7_der_magic_box_platform.mdl",	
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Up()*10 + self:GetAngles():Right()*7,
		},
		["Black Ops 3(Quiet Cosmos)"] = { 
			PLATFORM = "models/moo/_codz_ports_props/t7/_der/p7_zm_der_magic_box_fake/moo_codz_p7_der_magic_box_platform.mdl",	
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Up()*10 + self:GetAngles():Right()*7,
		},
		["Mob of the Dead"] = { 
			PLATFORM = "models/moo/_codz_ports_props/t6/alcatraz/p6_anim_zm_al_magic_box/moo_codz_t6_al_magic_box_platform.mdl",
			SKIN = 0,	
			BOXPOS = self:GetPos() + self:GetAngles():Right()*7 ,
		},
		["Origins"] = { 
			PLATFORM = "models/moo/_codz_ports_props/t6/zm/p6_zm_tm_magic_box/moo_codz_p6_zm_tm_magic_box_base.mdl",
			SKIN = 0,	
			BOXPOS = self:GetPos() + self:GetAngles():Right()*7,
		},
		["Leviathan"] = { 
			PLATFORM = "models/moo/_codz_ports_props/t7/zm_leviathan/futureistic_mysterybox/moo_codz_p7_futureistic_mysterybox_platform.mdl",	
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Up()*10 + self:GetAngles():Right()*7,
		},
		["Verruckt"] = { 
			PLATFORM = "models/moo/_codz_ports_props/t4/zombie/zombie_treasure_box_rubble/p4_zombie_treasure_box_rubble.mdl",	
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Right()*7,
		},
		["Nacht Der Untoten"] = { 
			PLATFORM = "models/moo/_codz_ports_props/t6/global/p6_anim_zm_magic_box_fake/moo_codz_p6_magic_box_pile_noplank.mdl",	
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Right()*7,
		},
		["Original"] = { 
			PLATFORM = "models/moo/_codz_ports_props/t6/global/p6_anim_zm_magic_box_fake/moo_codz_p6_magic_box_pile.mdl",	
			SKIN = 0,
			BOXPOS = self:GetPos() + self:GetAngles():Up()*10 + self:GetAngles():Right()*7,
		},
	}

	local selection = self.PlatformModel[self:GetBoxType()]

	self:SetModel(selection.PLATFORM)
	self:SetSkin(selection.SKIN)
	self.BoxPosition = selection.BOXPOS

	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)

	self.BoxLeft = false
	self.BoxArrived = false

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep()
	end

	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if !IsValid(self.Box) and nzPowerUps:IsPowerupActive("firesale") then
			self:SpawnBox(true)
		end

		if !IsValid(self.Box) then
			if self:LookupSequence("leave") > 0 and !self.BoxLeft then
				self.BoxLeft = true
				self.BoxArrived = false
				self:ResetSequence("leave")
			end
		end

		if IsValid(self.Box) then
			if self:LookupSequence("arrive") > 0 and !self.BoxArrived then
				self.BoxLeft = false
				self.BoxArrived = true
				self:ResetSequence("arrive")
			end
		end
	end

	self:NextThink( CurTime() )
	return true
end

function ENT:SpawnBox(firesale)
	local selection = self.PlatformModel[self:GetBoxType()]
	
	if isstring(nzMapping.Settings.boxtype) then selection = self.PlatformModel[nzMapping.Settings.boxtype] end

	local box = ents.Create( "random_box" )
	local pos = self:GetPos()
	local ang = self:GetAngles()
		
	box.SpawnPoint = self
	self.Box = box

	if firesale then box.FireSaleBox = true end

	box:SetPos( self.BoxPosition )
	box:SetAngles( ang )
	box:Spawn()
		
	self:SetBodygroup(1,1)

	local phys = box:GetPhysicsObject()
	if phys:IsValid() then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end

function ENT:PhysicsCollide(data, phys)
	self:SetMoveType(MOVETYPE_NONE)
end

if CLIENT then 
	function ENT:Draw()
		self:DrawModel()
			
		self:EffectsAndSounds()
	end

	function ENT:EffectsAndSounds()
			-- Credit: FlamingFox for Code and fighting the PVS monster -- 
			if !IsValid(self) then return end
			if (!self.Draw_FX or !IsValid(self.Draw_FX)) and self:GetModel() == "models/wavy_ports/ugx/ugx_coffin_teddy_platform.mdl" then -- PVS will no longer eat the particle effect.
				self.Draw_FX = CreateParticleSystem(self, "zmb_zct_fire_yellow", PATTACH_POINT_FOLLOW, 1)
			end
		end
	return 
end
