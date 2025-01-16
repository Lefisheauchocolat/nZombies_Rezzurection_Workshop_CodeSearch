-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("deathanimpos", {
	displayname = "Player Death Anim Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:DeathAnimPos(tr.HitPos, Angle(0,ply:GetAngles().y-180,0), ply)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "bo6_deathanim_point" then
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
	displayname = "Player Death Anim Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	icon = "icon16/tag_red.png",
	weight = 5.8,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 480, 450 )
		DProperties:SetPos( 10, 10 )

		local Row1 = DProperties:CreateRow("Config Settings", "Enable Death Animations?")
		Row1:Setup("Boolean")
		Row1:SetValue(nzSettings:GetSimpleSetting("DeathAnim_Enable", true))
		nzSettings:SyncValueToElement("DeathAnim_Enable", Row1)
		Row1:SetToolTip("If you want disable death animations without removing positions on map, just disable this.")
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("DeathAnim_Enable", tobool(val))
		end

		local Row1 = DProperties:CreateRow("Config Settings", "Enable Announcer Laugh?")
		Row1:Setup("Boolean")
		Row1:SetValue(nzSettings:GetSimpleSetting("DeathAnim_Laugh", false))
		Row1:SetToolTip("You can add your sounds in Mystery Box category.")
		nzSettings:SyncValueToElement("DeathAnim_Laugh", Row1)
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("DeathAnim_Laugh", tobool(val))
		end

		local Row10 = DProperties:CreateRow("Preview Anims", "Select Anim to look at nearest position")
		Row10:Setup( "Combo" )
		for k, v in pairs(nZr_Death_Animations_Effects) do
			for k2, v2 in pairs(v) do
				Row10:AddChoice(k.." | "..k2, k.." | "..k2)
			end
		end
		Row10.DataChanged = function( _, val )
			net.Start("nzPreviewDeathAnim")
			net.WriteString(val)
			net.SendToServer()
		end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Tip: Place your position away from walls to prevent bugs.\nThe cutscene starts at a random angle.\n\nList of supported special enemies:")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 160)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 100)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText([[
		- Disciple        - Mangler           - Nova Crawler
		- Hellhound       - Plaguehound       - Mimic
		- Brutus     	  - Abomination       - Vermin
		- Parasite        - Doppelghast       - Amalgam]])
		text:SetFont("Trebuchet18")
		text:SetPos(0, 90)
		text:SetTextColor( Color(200, 50, 50) )
		text:SetSize(400, 390)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Death Animations Module made by Hari")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 420)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 30)
		text:CenterHorizontal()
		text:SetWrap(true)

		return DProperties
	end,
	--defaultdata = {}
})

if SERVER then
	util.AddNetworkString("nzPreviewDeathAnim")	
	nzMapping:AddSaveModule("PlayerDeathPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_deathanim_point")) do
				table.insert(tab_pos, {v:GetPos(), v:GetAngles()})
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				if isvector(v) then
					nzMapping:DeathAnimPos(v)
				else
					nzMapping:DeathAnimPos(v[1], v[2])
				end
			end
		end,
		cleanents = {"bo6_deathanim_point"},
	})
end