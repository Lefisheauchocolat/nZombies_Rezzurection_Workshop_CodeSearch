
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

	-- There can only be one!
	if IsValid(ents.FindByClass("edit_color")[1]) and ents.FindByClass("edit_color")[1] != self then 
		ents.FindByClass("edit_color")[1]:Remove() 
	end

	if ( CLIENT ) then
		hook.Add( "RenderScreenspaceEffects", self, self.DrawColorCorretion )
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
			self:SetFogStart( 0.0 )
			self:SetFogEnd( 10000 )
			self:SetDensity( 0.9 )
			self:SetFogColor( Vector( 0.6, 0.7, 0.8 ) )
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
		[ "$pp_colour_addb" ] = self:GetAddGreen(),
		[ "$pp_colour_brightness" ] = self:GetBrightness(),
		[ "$pp_colour_contrast" ] = self:GetContrast(),
		[ "$pp_colour_colour" ] = self:GetColour(),
		[ "$pp_colour_mulr" ] = self:GetMulRed(),
		[ "$pp_colour_mulg" ] = self:GetMulGreen(),
		[ "$pp_colour_mulb" ] = self:GetMulBlue()
	}
	
	DrawColorModify(tbl)
end

--
-- This edits something global - so always network - even when not in PVS
--
function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
