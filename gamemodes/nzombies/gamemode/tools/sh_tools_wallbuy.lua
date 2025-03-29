nzTools:CreateTool("wallbuy", {
	displayname = "Weapon Buy Placer",
	desc = "LMB: Place Weapon Buy, RMB: Remove Weapon Buy, R: Rotate, C: Change Properties",
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "wall_buys" then
			nzMapping:WallBuy(ent:GetPos(), data.class, data.price, ent:GetAngles(), nil, ply, nil, data.showmodel)
			ent:Remove()
		else
			local ang = tr.HitNormal:Angle()
			ang:RotateAroundAxis(tr.HitNormal:Angle():Up()*-1, 90)
			nzMapping:WallBuy(tr.HitPos + tr.HitNormal*0.5, data.class, data.price, ang, nil, ply, nil, data.showmodel)
		end
	end,

	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "wall_buys" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "wall_buys" then
			tr.Entity:ToggleRotate()
		end
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Weapon Buy Placer",
	desc = "LMB: Place Weapon Buy, RMB: Remove Weapon Buy, R: Rotate, C: Change Properties",
	icon = "icon16/cart.png",
	weight = 5,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.class)
		valz["Row2"] = tonumber(data.price)
		valz["Row4"] = tobool(data.showmodel)
		valz["name"] = tostring(data.name) or "Select" //cheating to store swep name

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 400, 200 )
		DProperties:SetPos( 10, 10 )

		function DProperties.CompileData()
			if weapons.Get( valz["Row1"] ) then
				data.class = tostring(valz["Row1"])
				data.price = tonumber(valz["Row2"])
				data.showmodel = tobool(valz["Row4"])
				data.name = tostring(valz["name"])
			else
				ErrorNoHalt("NZ: This weapon class is not valid!")
			end
			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "wallbuy")
		end

		local Row1 = DProperties:CreateRow("Options", "Select Weapon")
		local Row3 = DProperties:CreateRow("Options", "Weapon Class")
		local Row2 = DProperties:CreateRow("Options", "Price")
		local Row4 = DProperties:CreateRow("Options", "Show Model")

		local wepentry = vgui.Create("DButton", Row1)
		wepentry:SetPos(173, 0)
		wepentry:SetSize(210, 20)
		wepentry:SetText(valz["name"] or "Weapon ...")
		wepentry.DoClick = function(panel, index, value)
			nzTools:OpenWeaponSelectMenu(Row1, Row1)
		end

		Row1:Setup("Generic")
		Row1.Think = function(self)
			if nzTools.WeaponSelectMenu and self:IsEnabled() then
				self:SetEnabled(false)
			end
			if !self:IsEnabled() and !nzTools.WeaponSelectMenu then
				self:SetEnabled(true)
			end
		end
		Row1.DoClick = function()
			if Row1.optionData then
				valz["Row1"] = Row1.optionData
				Row3:SetValue(valz["Row1"])

				local wepdata = weapons.Get(Row1.optionData)
				if wepdata and IsValid(wepentry) then
					local special = wepdata.NZSpecialCategory and " ("..wepdata.NZSpecialCategory..")" or ""
					wepentry:SetText((wepdata.PrintName or wepdata.ClassName)..special)
					valz["name"] = wepentry:GetText()
				end

				DProperties.UpdateData(DProperties.CompileData())
			end
		end

		Row3:Setup("Generic")
		Row3:SetValue(valz["Row1"])
		Row3.DataChanged = function( _, val )
			valz["Row1"] = val

			local wepdata = weapons.Get(val)
			if wepdata and wepdata.Base and IsValid(wepentry) then
				local special = wepdata.NZSpecialCategory and " ("..wepdata.NZSpecialCategory..")" or ""
				wepentry:SetText((wepdata.PrintName or wepdata.ClassName)..special)
				valz["name"] = wepentry:GetText()
			end

			DProperties.UpdateData(DProperties.CompileData())
		end
		Row3:SetToolTip("use this instead of scrolling through the list.")

		Row2:Setup( "Generic" )
		Row2:SetValue( valz["Row2"] )
		Row2.DataChanged = function( _, val ) valz["Row2"] = math.Round(tonumber(val)) DProperties.UpdateData(DProperties.CompileData()) end

		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("uh oh stinky.")

		return DProperties
	end,
	defaultdata = {
		class = "weapon_stunstick",
		price = 500,
		showmodel = false,
		name = "Select",
	}
})


nzTools:EnableProperties("wallbuy", "Edit Wallbuy...", "icon16/cart_edit.png", 9004, true, function( self, ent, ply )
	if ( !IsValid( ent ) or !IsValid(ply) ) then return false end
	if ( ent:GetClass() != "wall_buys" ) then return false end
	if !nzRound:InState( ROUND_CREATE ) then return false end
	if ( ent:IsPlayer() ) then return false end
	if ( !ply:IsInCreative() ) then return false end

	return true

end, function(ent)
	return {class = ent:GetWepClass(), price = ent:GetPrice()}
end)