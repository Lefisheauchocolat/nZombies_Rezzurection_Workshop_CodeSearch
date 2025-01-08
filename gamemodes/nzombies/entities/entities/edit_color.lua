
AddCSLuaFile()
DEFINE_BASECLASS( "base_edit" )

ENT.Spawnable			= true
ENT.AdminOnly			= true

ENT.PrintName			= "Fog and Color Correction Editor"
ENT.Category			= "Editors"

ENT.NZOnlyVisibleInCreative = true

function ENT:Initialize()

	BaseClass.Initialize( self )

	self.TransferFogStart 			= nil
	self.TransferFogEnd 			= nil
	self.TransferFogDensity 		= nil
	self.TransferFogColor 			= nil

	self.TransferSpecialFogStart 	= nil
	self.TransferSpecialFogEnd 		= nil
	self.TransferSpecialFogDensity 	= nil
	self.TransferSpecialFogColor 	= nil

	self.FogController 				= nil

	-- There can only be one!
	if IsValid(ents.FindByClass("edit_color")[1]) and ents.FindByClass("edit_color")[1] != self then 
		ents.FindByClass("edit_color")[1]:Remove() 
	end

	if ( CLIENT ) then
		hook.Add( "RenderScreenspaceEffects", self, self.DrawColorCorretion )
	end
	
	-- Recreate the fog controller. I think nZ removes this in it's creation of the Fog Hooks, but this is needed so the FarZ can be modified.
	if SERVER then
		if !IsValid(ents.FindByClass("env_fog_controller")) then
			self.FogController = ents.Create("env_fog_controller")
		end
	end
end

function ENT:SetupDataTables()

	self:NetworkVar( "Float",	0, "AddRed", { KeyName = "addred", Edit = { type = "Float", min = -1, max = 1, order = 1 } }  );
	self:NetworkVar( "Float",	1, "AddGreen", { KeyName = "addgreen", Edit = { type = "Float", min = -1, max = 1, order = 2 } }  );
	self:NetworkVar( "Float",	2, "AddBlue", { KeyName = "addblue", Edit = { type = "Float", min = -1, max = 1, order = 3 } }  );
	
	self:NetworkVar( "Float",	3, "Brightness", { KeyName = "brightness", Edit = { type = "Float", min = -2, max = 2, order = 4 } }  );
	self:NetworkVar( "Float",	4, "Contrast", { KeyName = "contrast", Edit = { type = "Float", min = 0, max = 2, order = 5 } }  );
	self:NetworkVar( "Float",	5, "Colour", { KeyName = "colour", Edit = { type = "Float", min = -10, max = 10, order = 6 } }  );
	
	self:NetworkVar( "Float",	6, "MulRed", { KeyName = "mulred", Edit = { type = "Float", min = -1, max = 1, order = 7 } }  );
	self:NetworkVar( "Float",	7, "MulGreen", { KeyName = "mulgreen", Edit = { type = "Float", min = -1, max = 1, order = 8 } }  );
	self:NetworkVar( "Float",	8, "MulBlue", { KeyName = "mulblue", Edit = { type = "Float", min = -1, max = 1, order = 9 } }  );

	-- 3/7/24: Fog Editors are now combined with the color editor for ease of access.

	self:NetworkVar( "Float",	9, "FogStart", { KeyName = "fogstart", Edit = { type = "Float", min = 0, max = 100000, order = 10 } }  );
	self:NetworkVar( "Float",	10, "FogEnd", { KeyName = "fogend", Edit = { type = "Float", min = 0, max = 100000, order = 11 } }  );
	self:NetworkVar( "Float",	11, "Density", { KeyName = "density", Edit = { type = "Float", min = 0, max = 1, order = 12 } }  );

	self:NetworkVar( "Vector",	0, "FogColor", { KeyName = "fogcolor", Edit = { type = "VectorColor", order = 13 } }  );

	self:NetworkVar( "Float",	12, "SpecialFogStart", { KeyName = "specialfogstart", Edit = { type = "Float", min = 0, max = 100000, order = 14 } }  );
	self:NetworkVar( "Float",	13, "SpecialFogEnd", { KeyName = "specialfogend", Edit = { type = "Float", min = 0, max = 100000, order = 15 } }  );
	self:NetworkVar( "Float",	14, "SpecialDensity", { KeyName = "specialdensity", Edit = { type = "Float", min = 0, max = 1, order = 16 } }  );

	self:NetworkVar( "Vector",	1, "SpecialFogColor", { KeyName = "specialfogcolor", Edit = { type = "VectorColor", order = 17 } }  );

	-- Moo Mark 7/7/24: FINALLY found out how the FarZ is modified. So now you can change that and make maps that run horribly, possibly run better!
	self:NetworkVar( "Float",	15, "ClipPlane", { KeyName = "clipplane", Edit = { type = "Float", min = 0, max = 100000, order = 18 } }  );

	--
	-- TODO: Should skybox fog be edited seperately?
	--

	if ( SERVER ) then

		-- defaults
		self:SetAddRed( 0.0 )
		self:SetAddGreen( 0.0 )
		self:SetAddBlue( 0.0 )
		
		self:SetBrightness( 0 )
		self:SetContrast( 1 )
		self:SetColour( 1 )
		
		self:SetMulRed( 0 )
		self:SetMulGreen( 0 )
		self:SetMulBlue( 0 )

		
		-- fog defaults

		-- Remove the two existing fog ents since the fog editing is done here now.
		local fog = ents.FindByClass("edit_fog")[1]
		local specialfog = ents.FindByClass("edit_fog_special")[1]

		-- If theres a fog or special fog entity, this one will remove those and inherit their settings. 

		if IsValid(fog) then
			--print("fog")
			if !self.HasFogEntity then
				self.TransferFogStart 		= fog:GetFogStart()
				self.TransferFogEnd 		= fog:GetFogEnd()
				self.TransferFogDensity 	= fog:GetDensity()
				self.TransferFogColor 		= fog:GetFogColor()
				self.HasFogEntity 			= true
			end
			fog:Remove() 
		end

		if IsValid(specialfog) then 
			--print("specialfog")
			if !self.HasSpecialFogEntity then
				self.TransferSpecialFogStart 		= specialfog:GetFogStart()
				self.TransferSpecialFogEnd 			= specialfog:GetFogEnd()
				self.TransferSpecialFogDensity 		= specialfog:GetDensity()
				self.TransferSpecialFogColor 		= specialfog:GetFogColor()
				self.HasSpecialFogEntity 			= true
			end
			specialfog:Remove() 
		end


		if self.HasFogEntity then
			--print("inherit fog")
			self:SetFogStart( self.TransferFogStart )
			self:SetFogEnd( self.TransferFogEnd )
			self:SetDensity( self.TransferFogDensity )
			self:SetFogColor( self.TransferFogColor )
		else
			local fogCntrl = ents.FindByClass( "env_fog_controller" )[ 1 ];
			if ( !IsValid( fogCntrl ) ) then return end

			self:SetFogStart( fogCntrl:GetInternalVariable( "fogstart" ) )
			self:SetFogEnd( fogCntrl:GetInternalVariable( "fogend" ) )
			self:SetDensity( fogCntrl:GetInternalVariable( "fogmaxdensity" ) )
			self:SetFogColor( Vector( fogCntrl:GetInternalVariable( "fogcolor" ) ) / 255 )
		end

		if self.HasSpecialFogEntity then
			--print("inherit special fog")
			self:SetSpecialFogStart( self.TransferSpecialFogStart )
			self:SetSpecialFogEnd( self.TransferSpecialFogEnd )
			self:SetSpecialDensity( self.TransferSpecialFogDensity )
			self:SetSpecialFogColor( self.TransferSpecialFogColor )
		else
			self:SetSpecialFogStart( 0.0 )
			self:SetSpecialFogEnd( 10000 )
			self:SetSpecialDensity( 0.9 )
			self:SetSpecialFogColor( Vector( 0.6, 0.7, 0.8 ) )
		end
	end

end

function ENT:DrawColorCorretion()
	local tbl = {
		[ "$pp_colour_addr" ] = self:GetAddRed(),
		[ "$pp_colour_addg" ] = self:GetAddGreen(),
		[ "$pp_colour_addb" ] = self:GetAddBlue(),
		[ "$pp_colour_brightness" ] = self:GetBrightness(),
		[ "$pp_colour_contrast" ] = self:GetContrast(),
		[ "$pp_colour_colour" ] = self:GetColour(),
		[ "$pp_colour_mulr" ] = self:GetMulRed(),
		[ "$pp_colour_mulg" ] = self:GetMulGreen(),
		[ "$pp_colour_mulb" ] = self:GetMulBlue()
	}
	
	DrawColorModify(tbl)
end

function ENT:Think()

	if SERVER then 
		if IsValid(ents.FindByClass("env_fog_controller")) then
			for k, v in pairs(ents.FindByClass("env_fog_controller")) do
				v:SetKeyValue("farz", self:GetClipPlane())
			end
		end
	end

	self:NextThink( CurTime() )

	return true
end

--[[
hook.Add("SetupSkyboxFog", "Wedoinitherenow", function(scale)

		local fog = ents.FindByClass("edit_color")

		if !IsValid(fog) then return end


		local fogend = fog:GetFogEnd()
		local fogstart = fogend - fogend * (fog:GetFogStart() / 100)
		local fogcolor = fog:GetFogColor()

		render.FogMode(1)
		render.FogColor( fogcolor.r, fogcolor.g, fogcolor.b )
		render.FogMaxDensity(1)
		render.FogStart(fogstart * scale)
		render.FogEnd(fogend * scale)

		print("Skybox Fog SETUP!")
		
		return true
end)


function ENT:OnRemove()
	hook.Remove("SetupSkyboxFog", "Wedoinitherenow")
end
]]

--
-- This edits something global - so always network - even when not in PVS
--
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
