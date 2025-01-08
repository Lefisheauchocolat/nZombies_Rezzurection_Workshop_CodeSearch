-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("exfilradioeditor", {
	displayname = "Exfil Radio Placer",
	desc = "LMB: Add Position, RMB: Remove Position",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:ExfilRadioPos(tr.HitPos, Angle(0,ply:GetAngles().y-180,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "bo6_exfil_radio" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)

	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Exfil Radio Placer",
	desc = "LMB: Add Position, RMB: Remove Position",
	icon = "icon16/door_in.png",
	weight = 5.5,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		local Row1 = DProperties:CreateRow("Config Settings", "Enable Exfil?")
		Row1:Setup("Boolean")
		Row1:SetValue(nzSettings:GetSimpleSetting("ExfilEnabled", true))
		Row1:SetToolTip("If you want disable exfil without removing positions on map, just disable this.")
		nzSettings:SyncValueToElement("ExfilEnabled", Row1)
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ExfilEnabled", tobool(val))
		end

		local Row2 = DProperties:CreateRow("Config Settings", "Max Zombies")
		Row2:Setup("Generic")
		Row2:SetValue(nzSettings:GetSimpleSetting("ExfilMaxZombies", 84))
		nzSettings:SyncValueToElement("ExfilMaxZombies", Row2)
		Row2.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ExfilMaxZombies", tonumber(val) or 84)
		end

		local Row3 = DProperties:CreateRow("Config Settings", "Time Before Losing")
		Row3:Setup("Generic")
		Row3:SetValue(nzSettings:GetSimpleSetting("ExfilTime", 90))
		nzSettings:SyncValueToElement("ExfilTime", Row3)
		Row3.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ExfilTime", tonumber(val) or 90)
		end

		local Row4 = DProperties:CreateRow("Config Settings", "Available First Round")
		Row4:Setup("Generic")
		Row4:SetValue(nzSettings:GetSimpleSetting("ExfilFirstRound", 11))
		nzSettings:SyncValueToElement("ExfilFirstRound", Row4)
		Row4.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ExfilFirstRound", tonumber(val) or 11)
		end

		local Row5 = DProperties:CreateRow("Config Settings", "Available Every Round")
		Row5:Setup("Generic")
		Row5:SetValue(nzSettings:GetSimpleSetting("ExfilEveryRound", 5))
		nzSettings:SyncValueToElement("ExfilEveryRound", Row5)
		Row5.DataChanged = function( s, val ) 
			nzSettings:SetSimpleSetting("ExfilEveryRound", tonumber(val) or 5)
		end

		local Row6 = DProperties:CreateRow("Config Settings", "Background Music")
		Row6:Setup("Generic")
		Row6:SetValue(nzSettings:GetSimpleSetting("ExfilMusic", "bo6/exfil/music.mp3"))
		nzSettings:SyncValueToElement("ExfilMusic", Row6)
		Row6.DataChanged = function( s, val ) 
			nzSettings:SetSimpleSetting("ExfilMusic", val)
		end

		local Row7 = DProperties:CreateRow("Config Settings", "Spawn Boss")
		Row7:Setup("Boolean")
		Row7:SetValue(nzSettings:GetSimpleSetting("ExfilBossEnabled", true))
		nzSettings:SyncValueToElement("ExfilBossEnabled", Row7)
		Row7.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ExfilBossEnabled", tobool(val))
		end

		local Row8 = DProperties:CreateRow("Config Settings", "Boss Unlock Round")
		Row8:Setup("Generic")
		Row8:SetValue(nzSettings:GetSimpleSetting("ExfilBossRound", 21))
		nzSettings:SyncValueToElement("ExfilBossRound", Row8)
		Row8.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ExfilBossRound", tonumber(val) or 21)
		end
		
		local Row9 = DProperties:CreateRow("Config Settings", "Delay Boss Spawn")
		Row9:Setup("Generic")
		Row9:SetValue(nzSettings:GetSimpleSetting("ExfilBossDelay", 10))
		nzSettings:SyncValueToElement("ExfilBossDelay", Row9)
		Row9.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ExfilBossDelay", tonumber(val) or 10)
		end

		local Row10 = DProperties:CreateRow("Config Settings", "Pilot VOX and Model")
		Row10:Setup( "Combo" )
		Row10:AddChoice("1. Terminus - Raptor One", "raptor")
		Row10:AddChoice("2. Liberty Falls - Blanchard & Exfil Pilot", "blanchard")
		Row10:AddChoice("3. Citadelle Des Morts - Strauss & Raptor One", "citadelle")
		Row10:AddChoice("4. No VOX - Custom Model", "none")
		local str = nzSettings:GetSimpleSetting("ExfilPilotType", "raptor")
		if str == "blanchard" then
			Row10:SetSelected(2)
		elseif str == "citadelle" then
			Row10:SetSelected(3)
		elseif str == "none" then
			Row10:SetSelected(4)
		else
			Row10:SetSelected(1)
		end
		Row10.DataChanged = function( _, val )
			nzSettings:SetSimpleSetting("ExfilPilotType", val)
		end

		local Row11 = DProperties:CreateRow("Config Settings", "Custom Pilot Model (If selected)")
		Row11:Setup("Generic")
		Row11:SetValue(nzSettings:GetSimpleSetting("ExfilCustomPilotModel", "models/player/riot.mdl"))
		nzSettings:SyncValueToElement("ExfilCustomPilotModel", Row11)
		Row11.DataChanged = function( s, val ) 
			nzSettings:SetSimpleSetting("ExfilCustomPilotModel", val)
		end

		local Row12 = DProperties:CreateRow("Config Settings", "Enable Liberty Falls Exfil Fail Animation?")
		Row12:Setup("Boolean")
		Row12:SetValue(nzSettings:GetSimpleSetting("ExfilLiberty", false))
		nzSettings:SyncValueToElement("ExfilLiberty", Row12)
		Row12.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("ExfilLiberty", tobool(val))
		end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Tip: Place your position far away from walls to prevent bugs.\nYou can have only one radio on map!")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 300)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Exfil Module made by Hari")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 400)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		return DProperties
	end,
	--defaultdata = {}
})

if SERVER then	
	nzMapping:AddSaveModule("ExfilPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_exfil_point")) do
				table.insert(tab_pos, {type = "point", pos = v:GetPos(), ang = v:GetAngles()})
			end
			local r = ents.FindByClass("bo6_exfil_radio")[1]
			if IsValid(r) then
				table.insert(tab_pos, {type = "radio", pos = r:GetPos(), ang = r:GetAngles()})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				if v.type == "radio" then
					nzMapping:ExfilRadioPos(v.pos, v.ang)
				else
					nzMapping:ExfilLandingPos(v.pos, v.ang)
				end
			end
		end,
		cleanents = {"bo6_exfil_point", "bo6_exfil_radio"},
	})
end