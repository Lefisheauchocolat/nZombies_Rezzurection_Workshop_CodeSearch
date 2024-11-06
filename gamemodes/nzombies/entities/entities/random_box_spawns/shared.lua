AddCSLuaFile( )

ENT.Type = "anim"
 
ENT.PrintName		= "random_box_spawns"
ENT.Author			= "Zet0r"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:Initialize()

	self.AutomaticFrameAdvance = true

	local nzmapsettings = nzMapping.Settings.boxtype
	local platform = "models/moo/_codz_ports_props/t6/global/p6_anim_zm_magic_box_fake/moo_codz_p6_magic_box_pile.mdl"
	local result

	local boxmdl = {
		["UGX Coffin"] = function() 
			platform = "models/wavy_ports/ugx/ugx_coffin_teddy_platform.mdl"
			return platform
		end,
		["Cold War"] = function() 
			platform = "models/moo/_codz_ports_props/s4/zm/zod/s4_magic_box_pile/moo_codz_s4_magic_box_pile.mdl"
			return platform
		end,
		["Black Ops 3"] = function() 
			platform = "models/moo/_codz_ports_props/t7/_der/p7_zm_der_magic_box_fake/moo_codz_p7_der_magic_box_platform.mdl"
			return platform
		end,
		["Black Ops 3(Quiet Cosmos)"] = function() 
			platform = "models/moo/_codz_ports_props/t7/_der/p7_zm_der_magic_box_fake/moo_codz_p7_der_magic_box_platform.mdl"
			return platform
		end,
		["Mob of the Dead"] = function() 
			platform = "models/moo/_codz_ports_props/t6/alcatraz/p6_anim_zm_al_magic_box/moo_codz_t6_al_magic_box_platform.mdl"
			return platform
		end,
		["Leviathan"] = function() 
			platform = "models/moo/_codz_ports_props/t7/zm_leviathan/futureistic_mysterybox/moo_codz_p7_futureistic_mysterybox_platform.mdl"
			return platform
		end,
		["Verruckt"] = function() 
			platform = "models/moo/_codz_ports_props/t4/zombie/zombie_treasure_box_rubble/p4_zombie_treasure_box_rubble.mdl"
			return platform
		end,
		["Nacht Der Untoten"] = function() 
			platform = "models/moo/_codz_ports_props/t6/global/p6_anim_zm_magic_box_fake/moo_codz_p6_magic_box_pile_noplank.mdl"
			return platform
		end,
		["Original"] = function() 
			platform = "models/moo/_codz_ports_props/t6/global/p6_anim_zm_magic_box_fake/moo_codz_p6_magic_box_pile.mdl"
			return platform
		end,
	}

	if isstring(nzmapsettings) then
		result = boxmdl[nzmapsettings](platform)
	end

	if isstring(result) then
		platform = result
	end

	self:SetModel(platform)

	self:PhysicsInit(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	
	if CLIENT then return end
	self:SetTrigger(true)
end

function ENT:Think()
	if SERVER then
		if !IsValid(self.Box) and nzPowerUps:IsPowerupActive("firesale") then
			local box = ents.Create( "random_box" )
			local pos = self:GetPos()
			local ang = self:GetAngles()
			
			if (nzMapping.Settings.boxtype == "Original" or nzMapping.Settings.boxtype == "Black Ops 3" or nzMapping.Settings.boxtype == "Black Ops 3(Quiet Cosmos)" or nzMapping.Settings.boxtype == "Leviathan" or nzMapping.Settings.boxtype == "Cold War") then
				box:SetPos( pos + ang:Up()*10 + ang:Right()*7 )
			else
				box:SetPos( pos + ang:Right()*7 )
			end

			box:SetAngles( ang )
			box:Spawn()
			box.SpawnPoint = self
			box.FireSaleBox = true

			self:SetBodygroup(1,1)
			self.Box = box

			local phys = box:GetPhysicsObject()
			if phys:IsValid() then
				phys:EnableMotion(false)
			end
		end
	end

	self:NextThink(CurTime() + 0.25)
	return true
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
