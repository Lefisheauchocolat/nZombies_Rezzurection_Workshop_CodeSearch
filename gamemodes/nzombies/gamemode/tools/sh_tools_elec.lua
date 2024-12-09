nzTools:CreateTool("elec", {
	displayname = "Electricity Switch Placer",
	desc = "LMB: Place Electricity Switch, RMB: Remove Switch",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:Electric(tr.HitPos + tr.HitNormal*5, tr.HitNormal:Angle(), data, ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "power_box" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		-- Nothing
	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Electricity Switch Placer",
	desc = "LMB: Place Electricity Switch, RMB: Remove Switch",
	icon = "icon16/lightning.png",
	weight = 8,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["PowerSwitchModel"] = data.model
		valz["Row1"] = data.limited
		valz["Row2"] = data.aoe
		valz["Row3"] = data.requireall
		valz["Row4"] = data.reset
		valz["Row5"] = data.resettime

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		function DProperties.CompileData()
			data.model = tonumber(valz["PowerSwitchModel"])
			data.limited = tobool(valz["Row1"])
			data.aoe = tostring(valz["Row2"])
			data.requireall = tobool(valz["Row3"])
			data.reset = tobool(valz["Row4"])
			data.resettime = tonumber(valz["Row5"])
			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "elec")
		end

		local PowerSwitchModel = DProperties:CreateRow( "Power Switch", "Model" )
		PowerSwitchModel:Setup( "Combo" )
		PowerSwitchModel:AddChoice("Small Switch(BO2)",0)
        PowerSwitchModel:AddChoice("Modern Switch(BO3+)",1)
        PowerSwitchModel:AddChoice("Classic Switch(W@W-BO1)",2)
        PowerSwitchModel:AddChoice("Classic Switch Short(BO1)",3)
        PowerSwitchModel:AddChoice("Circuit Breaker(WWII)",4)
        PowerSwitchModel:AddChoice("Electric Panel(IW)",5)
		PowerSwitchModel.DataChanged = function( _, val ) valz["PowerSwitchModel"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row1 = DProperties:CreateRow("Power Switch", "Limit Area of Effect?")
		Row1:Setup("Boolean")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow("Power Switch", "Area of Effect")
		Row2:Setup("Generic")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = tonumber(val) DProperties.UpdateData(DProperties.CompileData()) end

		local Row3 = DProperties:CreateRow("Power Switch", "Require all switches active")
		Row3:Setup("Boolean")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetTooltip("Shangri-La style power switches. Incompatible with limited AOE switches (they are ignored).")

		local Row4 = DProperties:CreateRow("Power Switch", "Reset switch if not all are activated")
		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetTooltip("Requires 'activate all' to be enabled to function.")

		local Row5 = DProperties:CreateRow("Power Switch", "Time before switch is reset")
		Row5:Setup("Generic")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = tonumber(val) DProperties.UpdateData(DProperties.CompileData()) end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Power Switch, what the fuck do you want me to put here")
		text:SetFont("Trebuchet18")
		text:SetTextColor( Color(50, 50, 50) )
		text:SizeToContents()
		text:Center()

		return DProperties

	end,
	defaultdata = {
		model = 0,
		limited = 0,
		aoe = 0,
		requireall = false,
		reset = false,
		resettime = 3,
	}
})