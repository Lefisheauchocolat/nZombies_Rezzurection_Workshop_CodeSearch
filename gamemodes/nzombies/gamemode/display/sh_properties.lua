--[[
	Properties added in here are added manually because they share tools and/or use specialized means of updating and fetching data
	If you want to add a quick Properties for your tool, look at nzTools:EnableProperties() function.
	(gamemode/tools/sh_tools.lua)
]]

properties.Add( "nz_remove", {
	MenuLabel = "Remove",
	Order = 1000,
	MenuIcon = "icon16/delete.png",

	Filter = function( self, ent, ply ) -- A function that determines whether an entity is valid for this property
		if !nzRound:InState( ROUND_CREATE ) then return false end
		if ( ent:IsPlayer() ) then return false end
		if ( !ply:IsAdmin() ) then return false end

		return true
	end,
	Action = function( self, ent )

		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()

	end,

	Receive = function( self, length, player )
		local ent = net.ReadEntity()

		if ( !IsValid( ent ) ) then return false end
		if ( !IsValid( player ) ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		if ( !player:IsAdmin() ) then return false end
		if ( ent:IsPlayer() ) then return false end
		if ( !self:Filter( ent, player ) ) then return false end

		-- Remove all constraints (this stops ropes from hanging around)
		constraint.RemoveAll( ent )

		-- Remove it properly in 1 second
		timer.Simple( 1, function() if ( IsValid( ent ) ) then ent:Remove() print("Removed", ent) end end )

		-- Make it non solid
		ent:SetNotSolid( true )
		ent:SetMoveType( MOVETYPE_NONE )
		ent:SetNoDraw( true )

		-- Send Effect
		local ed = EffectData()
		ed:SetEntity( ent )
		util.Effect( "entity_remove", ed, true, true )
	end
} )

properties.Add( "nz_editentity", {
	MenuLabel = "Edit Properties...",
	Order = 90010,
	PrependSpacer = true,
	MenuIcon = "icon16/pencil.png",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) ) then return false end
		if ( !ent.Editable ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		if ( ent:IsPlayer() ) then return false end
		if ( !ply:IsAdmin() ) then return false end

		return true

	end,

	Action = function( self, ent )

		local window = g_ContextMenu:Add( "DFrame" )
		window:SetSize( 320, 400 )
		window:SetTitle( tostring( ent ) )
		window:Center()
		window:SetSizable( true )

		local control = window:Add( "DEntityProperties" )
		control:SetEntity( ent )
		control:Dock( FILL )

		control.OnEntityLost = function()

			window:Remove()

		end
	end
} )

properties.Add( "nz_lock", {
	MenuLabel = "Edit Lock...",
	Order = 9001,
	PrependSpacer = true,
	MenuIcon = "icon16/lock_edit.png",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) or !IsValid(ply) ) then return false end
		if !( ent:IsDoor() or ent:IsButton() or ent:IsBuyableProp() ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		if ( !ply:IsInCreative() ) then return false end

		return true

	end,

	Action = function( self, ent )
		local frame = vgui.Create("DFrame")
		frame:SetPos( 100, 100 )
		frame:SetSize( 300, 280 )
		frame:SetTitle( "Edit Lock..." )
		frame:SetVisible( true )
		frame:SetDraggable( true )
		frame:ShowCloseButton( true )
		frame:MakePopup()
		frame:Center()
		
		local door = ent:GetDoorData()
		if !door then door = {} end
		
		door.flag = door.flag or 0
		door.link = door.link or 1
		door.price = door.price or 1000
		door.elec = door.elec or 0
		door.buyable = door.buyable or 1
		door.rebuyable = door.rebuyable or 0
		
		
		
		local panel = nzTools.ToolData["door"].interface(frame, door, true)
		panel:SetPos(10, 40)
		
		local data2 = panel.CompileData()
		panel.UpdateData = function(data)
			data2 = data
		end
		
		local submit = vgui.Create("DButton", frame)
		submit:SetText("Submit")
		submit:SetPos(50, 245)
		submit:SetSize(200, 25)
		submit.DoClick = function(self2)
			self:MsgStart()
				net.WriteEntity( ent )
				net.WriteTable( data2 )
			self:MsgEnd()
		end
	end,
	
	Receive = function( self, length, ply )
		local ent = net.ReadEntity()
		local data = net.ReadTable()
		if ( !self:Filter( ent, ply ) ) then return false end
		
		nzTools.ToolData["door"].PrimaryAttack(nil, ply, {Entity = ent}, data)
	end
} )

properties.Add( "nz_unlock", {
	MenuLabel = "Unlock",
	Order = 9002,
	PrependSpacer = false,
	MenuIcon = "icon16/lock_delete.png",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) or !IsValid(ply) ) then return false end
		if !( ent:IsDoor() or ent:IsButton() or ent:IsBuyableProp() ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		if ( !ply:IsInCreative() ) then return false end
		if ent:IsBuyableProp() then
			if ( !nzDoors.PropDoors[ent:EntIndex()] ) then return false end
		else
			if ( !nzDoors.MapDoors[ent:DoorIndex()] ) then return false end
		end

		return true

	end,

	Action = function( self, ent )

		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()

	end,

	Receive = function( self, length, player )
		local ent = net.ReadEntity()
		if ( !self:Filter( ent, player ) ) then return false end

		nzDoors:RemoveLink( ent )

	end
} )

properties.Add( "nz_editzspawn", {
	MenuLabel = "Edit Spawnpoint...",
	Order = 9003,
	PrependSpacer = true,
	MenuIcon = "icon16/link_edit.png",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) or !IsValid(ply) ) then return false end
		if ( ent:GetClass() != "nz_spawn_zombie_normal" and ent:GetClass() != "nz_spawn_zombie_special" and ent:GetClass() != "nz_spawn_zombie_boss"  and ent:GetClass() != "nz_spawn_zombie_extra1"  and ent:GetClass() != "nz_spawn_zombie_extra2"  and ent:GetClass() != "nz_spawn_zombie_extra3"  and ent:GetClass() != "nz_spawn_zombie_extra4")  then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		if ( !ply:IsInCreative() ) then return false end

		return true

	end,

	Action = function( self, ent )
		local frame = vgui.Create("DFrame")
		frame:SetPos( 100, 100 )
		frame:SetSize( 300, 280 )
		frame:SetTitle( "Edit Spawnpoint..." )
		frame:SetVisible( true )
		frame:SetDraggable( true )
		frame:ShowCloseButton( true )
		frame:MakePopup()
		frame:Center()
		
		local ztype = ent:GetClass() == "nz_spawn_zombie_normal" and "zspawn" or "zspecialspawn"
		
		local spawndata = {}
		if ent:GetLink() then
			spawndata.flag = 1
			spawndata.link = ent:GetLink()
		else
			spawndata.flag = 0
			spawndata.link = ""
		end
		
		local panel = nzTools.ToolData[ztype].interface(frame, spawndata, true)
		panel:SetPos(10, 40)
		
		local data2 = panel.CompileData()
		panel.UpdateData = function(data)
			data2 = data
		end
		
		local submit = vgui.Create("DButton", frame)
		submit:SetText("Submit")
		submit:SetPos(50, 245)
		submit:SetSize(200, 25)
		submit.DoClick = function(self2)
			self:MsgStart()
				net.WriteEntity( ent )
				net.WriteTable( data2 )
			self:MsgEnd()
		end
	end,

	Receive = function( self, length, player )
		local ent = net.ReadEntity()
		local data = net.ReadTable()
		if ( !self:Filter( ent, player ) ) then return false end
		
		local ztype = ent:GetClass() == "nz_spawn_zombie_normal" and "zspawn" or "zspecialspawn"

		nzTools.ToolData[ztype].PrimaryAttack(nil, ply, {Entity = ent}, data)
	end
} )

properties.Add( "nz_nocollide_on", {
	MenuLabel = "Disable Collisions",
	Order = 9006,
	PrependSpacer = true,
	MenuIcon = "icon16/collision_off.png",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) ) then return false end
		if ( ent:GetClass() != "prop_buys" ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		if ( !ply:IsAdmin() ) then return false end
		if ( ent:GetCollisionGroup() == COLLISION_GROUP_WORLD ) then return false end

		return true

	end,

	Action = function( self, ent )
		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()
	end,

	Receive = function( self, length, player )
		local ent = net.ReadEntity()
		if ( !self:Filter( ent, player ) ) then return false end

		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)

	end
} )

properties.Add( "nz_nocollide_off", {
	MenuLabel = "Enable Collisions",
	Order = 9007,
	PrependSpacer = true,
	MenuIcon = "icon16/collision_on.png",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) ) then return false end
		if ( ent:GetClass() != "prop_buys" ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		if ( !ply:IsAdmin() ) then return false end

		return ( ent:GetCollisionGroup() == COLLISION_GROUP_WORLD )

	end,

	Action = function( self, ent )
		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()
	end,

	Receive = function( self, length, player )
		local ent = net.ReadEntity()
		if ( !self:Filter( ent, player ) ) then return false end
		ent:SetCollisionGroup(COLLISION_GROUP_NONE)

	end
} )

properties.Add( "nz_skin", {
	MenuLabel = "#skin",
	Order = 9008,
	MenuIcon = "icon16/picture_edit.png",

	Filter = function( self, ent, ply )
		if ( !IsValid( ent ) ) then return false end
		if ( ent:IsPlayer() ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		--if ( !gamemode.Call( "CanProperty", ply, "nz_skin", ent ) ) then return false end
		if ( IsValid( ent.AttachedEntity ) ) then ent = ent.AttachedEntity end  -- If our ent has an attached entity, we want to modify its skin instead
		if ( !ent:SkinCount() ) then return false end

		return ent:SkinCount() > 1
	end,

	MenuOpen = function( self, option, ent, tr )
		--
		-- Add a submenu to our automatically created menu option
		--
		local submenu = option:AddSubMenu()
		--
		-- Create a check item for each skin
		--
		local target = IsValid( ent.AttachedEntity ) and ent.AttachedEntity or ent

		local num = target:SkinCount()

		for i = 0, num - 1 do
			local option = submenu:AddOption( "Skin " .. i, function() self:SetSkin( ent, i ) end )
			if ( target:GetSkin() == i ) then
				option:SetChecked( true )
			end
		end
	end,

	Action = function( self, ent )
		-- Nothing - we use SetSkin below
	end,

	SetSkin = function( self, ent, id )
		self:MsgStart()
			net.WriteEntity( ent )
			net.WriteUInt( id, 8 )
		self:MsgEnd()
	end,

	Receive = function( self, length, ply )
		local ent = net.ReadEntity()
		local skinid = net.ReadUInt( 8 )

		if ( !properties.CanBeTargeted( ent, ply ) ) then return end
		if ( !self:Filter( ent, ply ) ) then return end

		ent = IsValid( ent.AttachedEntity ) and ent.AttachedEntity or ent
		ent:SetSkin( skinid )
	end
} )


-- These are VERY important that they be added to nZombies.

local function CanEntityBeSetOnFire( ent )

	-- func_pushable, func_breakable & func_physbox cannot be ignited
	if ( ent:GetClass() == "item_item_crate" ) then return true end
	if ( ent:GetClass() == "simple_physics_prop" ) then return true end
	if ( ent:GetClass():match( "prop_physics*" ) ) then return true end
	if ( ent:GetClass():match( "prop_ragdoll*" ) ) then return true end
	if ( ent:GetClass():match( "prop_buys*" ) ) then return true end
	if ( ent:IsNPC() ) then return true end

	return false

end

properties.Add( "ignite", {
	MenuLabel = "#ignite",
	Order = 9009,
	MenuIcon = "icon16/fire.png",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) ) then return false end
		if ( ent:IsPlayer() ) then return false end
		if ( !CanEntityBeSetOnFire( ent ) ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		--if ( !gamemode.Call( "CanProperty", ply, "ignite", ent ) ) then return false end

		return !ent:IsOnFire()
	end,

	Action = function( self, ent )

		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()

	end,

	Receive = function( self, length, ply )

		local ent = net.ReadEntity()

		if ( !properties.CanBeTargeted( ent, ply ) ) then return end
		if ( !self:Filter( ent, ply ) ) then return end

		ent:Ignite( 360 )

	end

} )

properties.Add( "extinguish", {
	MenuLabel = "#extinguish",
	Order = 9009,
	MenuIcon = "icon16/water.png",

	Filter = function( self, ent, ply )

		if ( !IsValid( ent ) ) then return false end
		if ( ent:IsPlayer() ) then return false end
		--if ( !gamemode.Call( "CanProperty", ply, "extinguish", ent ) ) then return false end

		return ent:IsOnFire()
	end,

	Action = function( self, ent )

		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()

	end,

	Receive = function( self, length, ply )

		local ent = net.ReadEntity()

		if ( !properties.CanBeTargeted( ent, ply ) ) then return end
		if ( !self:Filter( ent, ply ) ) then return end

		ent:Extinguish()

	end

} )


local e = 0
local dissolver
local function nz_rb655_dissolve( ent )
	local phys = ent:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:EnableGravity( false ) end

	ent:SetName( "nz_rb655_dissolve" .. e )

	if ( !IsValid( dissolver ) ) then
		dissolver = ents.Create( "env_entity_dissolver" )
		dissolver:SetPos( ent:GetPos() )
		dissolver:Spawn()
		dissolver:Activate()
		dissolver:SetKeyValue( "magnitude", 100 )
		dissolver:SetKeyValue( "dissolvetype", 0 )
	end
	dissolver:Fire( "Dissolve", "nz_rb655_dissolve" .. e )

	timer.Create( "nz_rb655_ep_cleanupDissolved", 60, 1, function()
		if ( IsValid( dissolver ) ) then dissolver:Remove() end
	end )

	e = e + 1
end


properties.Add( "Disintegrate", {
	MenuLabel = "#Disintegrate",
	Order = 9010,
	MenuIcon = "icon16/wand.png",

	Filter = function( self, ent, ply )

		if ( ent:GetModel() && ent:GetModel():StartWith( "*" ) ) then return false end
		if ( !IsValid( ent ) ) then return false end
		if ( ent:IsPlayer() ) then return false end
		if !nzRound:InState( ROUND_CREATE ) then return false end
		--if ( !gamemode.Call( "CanProperty", ply, "ignite", ent ) ) then return false end

		return true
	end,

	Action = function( self, ent )

		self:MsgStart()
			net.WriteEntity( ent )
		self:MsgEnd()

	end,

	Receive = function( self, length, ply )

		local ent = net.ReadEntity()

		if ( !properties.CanBeTargeted( ent, ply ) ) then return end
		if ( !self:Filter( ent, ply ) ) then return end

		nz_rb655_dissolve( ent )

	end

} )
