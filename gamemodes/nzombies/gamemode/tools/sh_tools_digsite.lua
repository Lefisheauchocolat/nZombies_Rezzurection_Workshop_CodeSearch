local generator1 = 1
local function nextKey(class)
	local i = #nzBuilds:GetBuildParts(class)
	generator1 = generator1 + 1

	if generator1 > i then
		generator1 = 1
	end

	return generator1
end

nzTools:CreateTool("digsite", {
	displayname = "Dig Site Placer",
	desc = "LMB: Place Shovel Spawn, RMB: Place Dig Site Spawn, Reload: Change Select Part",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		nzMapping:SpawnShovel(tr.HitPos + tr.HitNormal, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local toolclasses = {
			["nz_digsite"] = true,
			["nz_tool_shovel"] = true,
		}

		if IsValid(tr.Entity) and toolclasses[tr.Entity:GetClass()] then
			tr.Entity:Remove()
			return
		end

		if data and tobool(data.override) and data.class and data.part then
			local corrected = math.Clamp(tonumber(data.part), 1, #nzBuilds:GetBuildParts(tostring(data.class)))
			for k, v in ipairs(ents.FindByClass("nz_digsite")) do
				if v:GetOverride() and v:GetBuildable() == tostring(data.class) and v:GetPartID() == tonumber(corrected) then return end
			end
		end

		nzMapping:SpawnDigSite(tr.HitPos + Vector(0,0,0.25), Angle(0,math.random(-180,180),0), ply, data)
	end,
	Reload = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_digsite" then
			tr.Entity:SetAngles(Angle(0,math.random(-180,180),0))
			return
		end

		if not data then return end
		if not data.override then return end

		data.part = nextKey(data.class)

		if IsValid(ply) then
			local name = nzBuilds:GetBuildParts(data.class)[data.part].id
			ply:ChatPrint("Currently selected part - "..tostring(name))
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Dig Site Placer",
	desc = "LMB: Place Shovel Spawn, RMB: Place Dig Site Spawn, Reload: Change Select Part",
	icon = "icon16/anchor.png",
	weight = 23,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tobool(data.override)
		valz["Row2"] = tostring(data.class)
		valz["Row4"] = tostring(data.model)
		valz["Whitelist"] = data.whitelist or {}

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.override = tobool(valz["Row1"])
			data.class = tostring(valz["Row2"])
			data.model = tostring(valz["Row4"])
			data.whitelist = valz["Whitelist"] or {}

			return data
		end

		function DProperties.UpdateData(data)
			nzDigs:UpdateSettings(data)
			nzTools:SendData(data, "digsite")
		end

		local Row1 = DProperties:CreateRow("Override", "Enable Buildable as reward")
		local Row2 = DProperties:CreateRow("Override", "Buildable Class")
		local Row4 = DProperties:CreateRow("Model", "Model path")

		local whitelist = vgui.Create("DScrollPanel", DProperties)
		
		Row1:Setup("Boolean")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("This will override the function of the digsite to work with buildable tables instead.")

		Row2:Setup("Combo")
		for i, tab in pairs(nzBuilds.Data) do Row2:AddChoice(tab.name, i, i == valz["Row2"]) end
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("SWITCH TO THE BUILDABLE PLACER TOOL AND PLACE DOWN THE CORRESPONDING TABLE (WITHOUT ANY PARTS).")

		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Defaults to 'models/zmb/bo2/tomb/zm_tm_dig_mound.mdl'")

		local color_grey_50 = Color(50, 50, 50)
		local color_grey_200 = Color(200, 200, 200)
		local color_red = Color(150, 50, 50)
		local weplist = {}
		local numweplist = 0

		whitelist:SetPos(15, 150)
		whitelist:SetSize(470, 240)
		whitelist:SetPaintBackground(true)
		whitelist:SetBackgroundColor(color_grey_200)

		local function InsertWeaponToList(name, class, weight)
			if IsValid(weplist[class]) then return end
			weight = weight or 10

			weplist[class] = vgui.Create("DPanel", whitelist)
			weplist[class]:SetSize(460, 16)
			weplist[class]:SetPos(5, 10 + (numweplist*18))

			valz["Whitelist"][class] = weight

			local dname = vgui.Create("DLabel", weplist[class])
			dname:SetText(name)
			dname:SetTextColor(color_grey_50)
			dname:SetPos(15, 0)
			dname:SetSize(380, 16)

			local dweight = vgui.Create("DNumberWang", weplist[class])
			dweight:SetPos(385, 1)
			dweight:SetSize(40, 14)
			dweight:SetTooltip("The chance of digging the weapon up")
			dweight:SetMinMax(1, 100)
			dweight:SetValue(valz["Whitelist"][class])
			function dweight:OnValueChanged(val)
				valz["Whitelist"][class] = val

				local data = DProperties.CompileData()
				nzDigs:UpdateSettings(data)
			end

			local ddelete = vgui.Create("DImageButton", weplist[class])
			ddelete:SetImage("icon16/delete.png")
			ddelete:SetPos(435, 0)
			ddelete:SetSize(16, 16)
			ddelete.DoClick = function()
				valz["Whitelist"][class] = nil

				weplist[class]:Remove()
				weplist[class] = nil

				local num = 0
				for k, v in pairs(weplist) do
					v:SetPos(5, 10 + (num*18))
					num = num + 1
				end

				numweplist = numweplist - 1

				local data = DProperties.CompileData()
				nzDigs:UpdateSettings(data)
			end

			numweplist = numweplist + 1

			local data = DProperties.CompileData()
			nzDigs:UpdateSettings(data)
		end

		local weptext = vgui.Create("DTextEntry", DProperties)

		local wepentry = vgui.Create("DComboBox", DProperties)
		local catentry = vgui.Create("DComboBox", DProperties)

		local wepadd = vgui.Create("DButton", DProperties)
		local catadd = vgui.Create("DButton", DProperties)
		local catdel = vgui.Create("DButton", DProperties)
		local boxlist = vgui.Create("DButton", DProperties)

		catentry:SetPos(15, 405)
		catentry:SetSize(180, 20)
		catentry:SetValue("Category ...")
		local cattbl = {}
		for k,v in SortedPairsByMemberValue(weapons.GetList(), "PrintName") do
			if v.Category and v.Category != "" then
				if !cattbl[v.Category] then
					catentry:AddChoice(v.Category, v.Category, false)
					cattbl[v.Category] = true
				end
			end
		end

		catadd:SetText("Add all")
		catadd:SetPos(205, 405)
		catadd:SetSize(65, 20)
		catadd.DoClick = function()
			local cat = catentry:GetOptionData(catentry:GetSelectedID())
			if cat and cat != "" then
				for k,v in SortedPairsByMemberValue(weapons.GetList(), "PrintName") do
					if v.Category and v.Category == cat and !nzConfig.WeaponBlackList[v.ClassName] and !v.NZPreventBox and !v.NZTotalBlacklist then
						InsertWeaponToList(v.PrintName != "" and v.Category.." | "..v.PrintName.." | "..v.ClassName or v.ClassName, v.ClassName, 10)
					end
				end

				catentry:SetValue("Category ...")
			end
		end

		catdel:SetText("Remove all")
		catdel:SetPos(280, 405)
		catdel:SetSize(65, 20)
		catdel.DoClick = function()
			local cat = catentry:GetOptionData(catentry:GetSelectedID())
			if cat and cat != "" then
				for k, v in pairs(weplist) do
					local wep = weapons.Get(k)
					if wep and wep.Category and wep.Category == cat then
						valz["Whitelist"][k] = nil

						weplist[k]:Remove()
						weplist[k] = nil

						local num = 0
						for k, v in pairs(weplist) do
							v:SetPos(5, 10 + (num*18))
							num = num + 1
						end

						numweplist = numweplist - 1
					end
				end

				catentry:SetValue("Category ...")
				DProperties.UpdateData(DProperties.CompileData())
			end
		end

		wepentry:SetPos(15, 430)
		wepentry:SetSize(180, 20)
		wepentry:SetValue("Weapon ...")
		for k, v in pairs(weapons.GetList()) do
			if !v.NZTotalBlacklist and !v.NZPreventBox then
				if v.Category and v.Category != "" then
					wepentry:AddChoice(v.PrintName and v.PrintName != "" and v.Category.. " - "..v.PrintName or v.ClassName, v.ClassName, false)
				else
					wepentry:AddChoice(v.PrintName and v.PrintName != "" and v.PrintName or v.ClassName, v.ClassName, false)
				end
			end
		end

		function wepentry:OnSelect(index, value, data)
			weptext:SetValue(data)
		end

		weptext:SetPos(205, 430)
		weptext:SetSize(140, 20)
		weptext:SetText("")
		weptext:SetEditable(true)

		wepadd:SetText("Add")
		wepadd:SetPos(355, 430)
		wepadd:SetSize(65, 20)
		wepadd.DoClick = function()
			local wep = weapons.Get(weptext:GetText())
			if not wep then
				wep = weapons.Get(wepentry:GetOptionData(wepentry:GetSelectedID()))
			end

			if wep then
				if wep.Category and wep.Category != "" then
					InsertWeaponToList(wep.PrintName != "" and wep.Category.." | "..wep.PrintName.." | "..wep.ClassName or wep.ClassName, wep.ClassName, 10)
				else
					InsertWeaponToList(wep.PrintName != "" and wep.PrintName.." | "..wep.ClassName or wep.ClassName, wep.ClassName, 10)
				end
			end

			wepentry:SetValue("Weapon ...")
			weptext:SetText("")
		end

		if nzDigs.weapons_dig_list and next(nzDigs.weapons_dig_list) ~= nil then
			for k, v in pairs(nzDigs.weapons_dig_list) do
				local wep = weapons.Get(k)
				if wep then
					if wep.Category and wep.Category != "" then
						InsertWeaponToList(wep.PrintName != "" and wep.Category.." | "..wep.PrintName.." | "..wep.ClassName or wep.ClassName, wep.ClassName, v or 10)
					else
						InsertWeaponToList(wep.PrintName != "" and wep.PrintName.." | "..wep.ClassName or wep.ClassName, wep.ClassName, v or 10)
					end
				end
			end
		end

		boxlist:SetText("Import Box Weapons")
		boxlist:SetPos(355, 405)
		boxlist:SetSize(110, 20)
		boxlist.DoClick = function()
			if not nzMapping.Settings.rboxweps then return end
			for k, v in pairs(nzMapping.Settings.rboxweps) do
				local wep = weapons.Get(k)
				if wep then
					if wep.Category and wep.Category != "" then
						InsertWeaponToList(wep.PrintName != "" and wep.Category.." | "..wep.PrintName.." | "..wep.ClassName or wep.ClassName, wep.ClassName, v or 10)
					else
						InsertWeaponToList(wep.PrintName != "" and wep.PrintName.." | "..wep.ClassName or wep.ClassName, wep.ClassName, v or 10)
					end
				end
			end
		end

		local textw = vgui.Create("DLabel", DProperties)
		textw:SetText("Whitelist what weapons can be dug up from digsites.")
		textw:SetFont("Trebuchet18")
		textw:SetTextColor(color_red)
		textw:SizeToContents()
		textw:SetPos(0, 110)
		textw:CenterHorizontal()

		local textw2 = vgui.Create("DLabel", DProperties)
		textw2:SetText("If left empty, digsites will use random box list instead.")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(0, 125)
		textw2:CenterHorizontal()

		return DProperties
	end,

	defaultdata = {
		override = false,
		class = "bo2_tranzitshield",
		part = 1,
		model = "models/zmb/bo2/tomb/zm_tm_dig_mound.mdl",
		whitelist = {},
	},
})

if SERVER then
	nzMapping:AddSaveModule("DigSite", {
		savefunc = function()
			local digsite_spawn = {}
			for k, v in pairs(ents.FindByClass("nz_digsite")) do
				table.insert(digsite_spawn, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						override = v:GetOverride(),
						class = v:GetBuildable(),
						part = v:GetPartID(),
						model = v:GetModel(),
					}
				})
			end

			return digsite_spawn
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnDigSite(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_digsite", "nz_digholo"}
	})
	nzMapping:AddSaveModule("ShovelSpawn", {
		savefunc = function()
			local build_parts = {}
			for k, v in pairs(ents.FindByClass("nz_tool_shovel")) do
				table.insert(build_parts, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
				})
			end

			return build_parts
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnShovel(v.pos, v.angle, nil)
			end
		end,
		cleanents = {"nz_tool_shovel"}
	})
	nzMapping:AddSaveModule("DigsiteSettings", {
		savefunc = function()
			local data = {
				whitelist = nzDigs.weapons_dig_list
			}
			return data
		end,
		loadfunc = function(data)
			nzDigs:UpdateSettings(data)
		end,
	})
end

if SERVER then
	hook.Add("PlayerDeath", "NZ.Reset.Shovel", function(ply, wep, ent)
		if ply.GetShovel and IsValid(ply:GetShovel()) then
			ply:GetShovel():Reset()
		end
	end)

	hook.Add("EntityRemoved", "NZ.Reset.Shovel", function(ply)
		if ply:IsPlayer() and ply.GetShovel and IsValid(ply:GetShovel()) then
			ply:GetShovel():Reset()
		end
	end)

	hook.Add("OnRoundInit", "NZ.Start.DigSites", function()
		nzDigs.n_dig_spots_cur = 0
		nzDigs.n_dig_spots_max = 15

		local a_dig_spots = ents.FindByClass("nz_digsite")

		for k, v in ipairs(a_dig_spots) do
			v:Trigger()
		end

		for k, v in ipairs(a_dig_spots) do
			if v:GetOverride() then
				v:Reset()
			end

			if not v:GetOverride() and nzDigs.n_dig_spots_cur < nzDigs.n_dig_spots_max then
				v:Reset()
			end
		end

		for k, v in ipairs(ents.FindByClass("nz_tool_shovel")) do
			v:Reset()
		end
	end)

	hook.Add("OnRoundStart", "NZ.Respawn.DigSites", function()
		nzDigs.dig_n_zombie_bloods_spawned = 0

		local round = tonumber(nzRound:GetNumber())
		local a_dig_spots = ents.FindByClass("nz_digsite")
		local n_respawned = 0
		local n_respawned_max = 3

		if round%3 == 0 then //simulate rain rounds
			n_respawned_max = 5
		end
		if not game.SinglePlayer() then
			n_respawned_max = n_respawned_max + math.random(player.GetCount())
		end

		if round%5 == 0 then //fuck the bo2 blood mound system, were doing this instead
			local fuck = false
			for _, ply in ipairs(player.GetAllPlaying()) do
				local shovel = ply:GetShovel()
				if IsValid(shovel) and shovel:IsGolden() then
					fuck = true
					break
				end
			end

			if fuck then
				print('comically large golden spoon')
				for k, v in RandomPairs(a_dig_spots) do
					if not v:GetOverride() and v:GetActivated() then
						v:BloodMound()
						break
					end
				end
			end
		end

		for k, v in RandomPairs(a_dig_spots) do //normal digsite respawn
			if not v:GetOverride() and v:GetActivated() and n_respawned < n_respawned_max and nzDigs.n_dig_spots_cur < nzDigs.n_dig_spots_max then
				v:Reset()
				n_respawned = n_respawned + 1
			end
		end
	end)

	local DigSiteResets = {
		["nz_digsite"] = true,
		["nz_tool_shovel"] = true,
	}

	hook.Add("OnRoundEnd", "NZ.Reset.DigSites", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in ipairs(ents.GetAll()) do
				local class = v:GetClass()
				if DigSiteResets[class] then
					v:Reset()
				end
				if class == "nz_buildable" and v.DigsiteBuildable then
					v:Remove()
				end
			end

			nzDigs.n_dig_spots_cur = 0
			nzDigs.dig_n_zombie_bloods_spawned = 0
		end
	end)
end