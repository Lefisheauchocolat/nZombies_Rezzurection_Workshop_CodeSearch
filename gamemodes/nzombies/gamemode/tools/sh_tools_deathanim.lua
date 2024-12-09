-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzTools:CreateTool("deathanimpos", {
	displayname = "Player Death Anim Position",
	desc = "LMB: Add Position, RMB: Remove Position",
	condition = function(wep, ply)
		return true
	end,
	
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:DeathAnimPos(tr.HitPos, ply)
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

		local Row1 = DProperties:CreateRow("Config Settings", "Enable Black Ops 6 Game Over Screen?")
		Row1:Setup("Boolean")
		Row1:SetValue(nzSettings:GetSimpleSetting("DeathAnim_BO6_GO", false))
		nzSettings:SyncValueToElement("DeathAnim_BO6_GO", Row1)
		Row1.DataChanged = function( _, val ) 
			nzSettings:SetSimpleSetting("DeathAnim_BO6_GO", tobool(val))
		end

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Tip: Place your position away from walls to prevent bugs.\nThe cutscene starts at a random angle.\n\nList of supported special enemies:")
		text:SetFont("Trebuchet18")
		text:SetPos(0, 120)
		text:SetTextColor( Color(50, 50, 50) )
		text:SetSize(400, 100)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText([[
		- Disciple        - Mangler           - Nova Crawler
		- Hellhound       - Plaguehound       - Mimic]])
		text:SetFont("Trebuchet18")
		text:SetPos(0, 80)
		text:SetTextColor( Color(200, 50, 50) )
		text:SetSize(400, 300)
		text:CenterHorizontal()
		text:SetWrap(true)

		local text = vgui.Create("DLabel", DProperties)
		text:SetText("Death Animations Module made by Hari")
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
	nzMapping:AddSaveModule("PlayerDeathPos", {
		savefunc = function()
			local tab_pos = {}
			for _, v in pairs(ents.FindByClass("bo6_deathanim_point")) do
				table.insert(tab_pos, v:GetPos())
			end
			return tab_pos
		end,
		loadfunc = function(data)
			for k,v in pairs(data) do
				nzMapping:DeathAnimPos(v)
			end
		end,
		cleanents = {"bo6_deathanim_point"},
	})
end