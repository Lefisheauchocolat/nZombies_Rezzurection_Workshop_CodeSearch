local blacklistguns = {}

nzTools:CreateTool("weaponlocker", {
	displayname = "Weapon Locker Placer",
	desc = "LMB: Place/Update Weapon Locker, RMB: Remove Weapon Locker",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_weaponlocker" and data then
			if data.price ~= nil then
				ent:SetPrice(tonumber(data.price))
			end
			if data.boxlist ~= nil then
				ent:SetUseBoxList(tobool(data.boxlist))
			end
			if data.elec ~= nil then
				ent.Elec = tobool(data.elec)
				ent:SetElectric(tobool(data.elec))
			end
			if data.sound1 and file.Exists("sound/"..data.sound1, "GAME") then
				ent.OpenSound = Sound(data.sound1)
			else
				ent.OpenSound = Sound("zmb/tranzit/locker/fridge_locker_open.wav")
			end
			if data.sound2 and file.Exists("sound/"..data.sound2, "GAME") then
				ent.CloseSound = Sound(data.sound2)
			else
				ent.CloseSound = Sound("zmb/tranzit/locker/fridge_locker_close.wav")
			end
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			if data.blacklist ~= nil then
				ent.BlacklistWeapons = data.blacklist
			end
			if data.collision ~= nil then
				if data.collision then
					ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
				else
					ent:SetCollisionGroup(COLLISION_GROUP_NONE)
				end
			end
			return
		end

		if IsValid(ents.FindByClass('nz_weaponlocker')[1]) then return end

		local ang = tr.HitNormal:Angle()
		nzMapping:SpawnWeaponLocker(tr.HitPos, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_weaponlocker" then
			tr.Entity:Remove()
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ply) and IsValid(ent) and ent:GetClass() == "nz_weaponlocker" then
			if ply:KeyDown(IN_SPEED) then
				local ang = ent:GetAngles()
				ang:RotateAroundAxis(ent:GetUp(), ply:KeyDown(IN_DUCK) and 5 or 45)
				ent:SetAngles(ang)
			else
				local ang = ent:GetAngles()
				ang:RotateAroundAxis(ent:GetUp(), ply:KeyDown(IN_DUCK) and -5 or -45)
				ent:SetAngles(ang)
			end
			return
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Weapon Locker Placer",
	desc = "LMB: Place/Update Weapon Locker, RMB: Remove Weapon Locker",
	icon = "icon16/page_white_zip.png",
	weight = 21,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.price)
		valz["Row2"] = tobool(data.boxlist)
		valz["Row3"] = tobool(data.elec)
		valz["Row4"] = tostring(data.sound1)
		valz["Row5"] = tostring(data.sound2)
		valz["Row6"] = tostring(data.model)
		valz["Row7"] = tobool(data.collision)
		valz["Blacklist"] = data.blacklist or blacklistguns

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize(500, 480)
		DProperties:SetPos(0, 0)

		function DProperties.CompileData()
			data.price = tonumber(valz["Row1"])
			data.boxlist = tobool(valz["Row2"])
			data.elec = tobool(valz["Row3"])
			data.sound1 = tostring(valz["Row4"])
			data.sound2 = tostring(valz["Row5"])
			data.model = tostring(valz["Row6"])
			data.collision = tobool(valz["Row7"])
			data.blacklist = valz["Blacklist"] or blacklistguns

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "weaponlocker")
		end

		local Row1 = DProperties:CreateRow("Options", "Price")
		local Row2 = DProperties:CreateRow("Options", "Boxlist weapons only")
		local Row3 = DProperties:CreateRow("Options", "Require electricy")
		local Row4 = DProperties:CreateRow("Other", "Open sound")
		local Row5 = DProperties:CreateRow("Other", "Close sound")
		local Row6 = DProperties:CreateRow("Other", "Model path")

		local blacklist = vgui.Create("DScrollPanel", DProperties)

		Row1:Setup("Int", { min = 0, max = 30000 })
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Price to pickup stowed weapon from Locker, SET TO 0 TO DISSABLE!")

		Row2:Setup("Boolean")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Only allow weapons from the Mystery Box list to be stowed or retrieved.")

		Row3:Setup("Boolean")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Require electricity activated to stow or retrieve weapon.")

		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Defaults to 'zmb/tranzit/locker/fridge_locker_open.wav'")

		Row5:Setup("Generic")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Defaults to 'zmb/tranzit/locker/fridge_locker_close.wav'")

		Row6:Setup("Generic")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Defaults to 'models/zmb/bo2/tranzit/zm_weapon_locker.mdl'")

		local color_grey_50 = Color(50, 50, 50)
		local color_grey_200 = Color(200, 200, 200)
		local color_red = Color(150, 50, 50)
		local weplist = {}
		local numweplist = 0

		blacklist:SetPos(15, 235)
		blacklist:SetSize(470, 165)
		blacklist:SetPaintBackground(true)
		blacklist:SetBackgroundColor(color_grey_200)

		local function InsertWeaponToList(name, class)
			if IsValid(weplist[class]) then return end
			weplist[class] = vgui.Create("DPanel", blacklist)
			weplist[class]:SetSize(460, 16)
			weplist[class]:SetPos(5, 10 + (numweplist*18))

			blacklistguns[class] = name
			valz["Blacklist"][class] = true

			local dname = vgui.Create("DLabel", weplist[class])
			dname:SetText(name)
			dname:SetTextColor(color_grey_50)
			dname:SetPos(15, 0)
			dname:SetSize(380, 16)

			local ddelete = vgui.Create("DImageButton", weplist[class])
			ddelete:SetImage("icon16/delete.png")
			ddelete:SetPos(435, 0)
			ddelete:SetSize(16, 16)
			ddelete.DoClick = function()
				valz["Blacklist"][class] = nil

				weplist[class]:Remove()
				weplist[class] = nil
				blacklistguns[class] = nil

				local num = 0
				for k, v in pairs(weplist) do
					v:SetPos(5, 10 + (num*18))
					num = num + 1
				end

				numweplist = numweplist - 1

				DProperties.UpdateData(DProperties.CompileData())
			end

			numweplist = numweplist + 1

			DProperties.UpdateData(DProperties.CompileData())
		end

		local weptext = vgui.Create("DTextEntry", DProperties)

		local wepentry = vgui.Create("DComboBox", DProperties)
		local catentry = vgui.Create("DComboBox", DProperties)

		local wepadd = vgui.Create("DButton", DProperties)
		local catadd = vgui.Create("DButton", DProperties)
		local catdel = vgui.Create("DButton", DProperties)

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
						InsertWeaponToList(v.PrintName != "" and v.Category.." | "..v.PrintName.." | "..v.ClassName or v.ClassName, v.ClassName)
					end
				end

				local shit = {}
				for k, v in pairs(blacklistguns) do
					shit[#shit + 1] = k
				end
				PrintTable(shit)

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
						valz["Blacklist"][k] = nil

						weplist[k]:Remove()
						weplist[k] = nil
						blacklistguns[k] = nil

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
					InsertWeaponToList(wep.PrintName != "" and wep.Category.." | "..wep.PrintName.." | "..wep.ClassName or wep.ClassName, wep.ClassName)
				else
					InsertWeaponToList(wep.PrintName != "" and wep.PrintName.." | "..wep.ClassName or wep.ClassName, wep.ClassName)
				end

				local shit = {}
				for k, v in pairs(blacklistguns) do
					shit[#shit + 1] = k
				end
				PrintTable(shit)
			end

			wepentry:SetValue("Weapon ...")
			weptext:SetText("")
		end

		for k, v in pairs(blacklistguns) do
			if k and v then
				InsertWeaponToList(v, k)
			end
		end

		local textw = vgui.Create("DLabel", DProperties)
		textw:SetText("Weapon data is saved per config using the config name and map name.")
		textw:SetFont("Trebuchet18")
		textw:SetTextColor(color_red)
		textw:SizeToContents()
		textw:SetPos(0, 170)
		textw:CenterHorizontal()

		local textw2 = vgui.Create("DLabel", DProperties)
		textw2:SetText("Changing the config's name will cause it to create a new data file,")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(0, 185)
		textw2:CenterHorizontal()

		local textw3 = vgui.Create("DLabel", DProperties)
		textw3:SetText("and previously stored weapon data will become unused.")
		textw3:SetFont("Trebuchet18")
		textw3:SetTextColor(color_red)
		textw3:SizeToContents()
		textw3:SetPos(0, 200)
		textw3:CenterHorizontal()

		local textw4 = vgui.Create("DLabel", DProperties)
		textw4:SetText("Data is stored on the host's machine inside 'data/nz/weaponlocker'")
		textw4:SetFont("Trebuchet18")
		textw4:SetTextColor(color_red)
		textw4:SizeToContents()
		textw4:SetPos(0, 215)
		textw4:CenterHorizontal()

		local textw5 = vgui.Create("DLabel", DProperties)
		textw5:SetText("^^^^^^^")
		textw5:SetFont("Trebuchet18")
		textw5:SetTextColor(color_red)
		textw5:SizeToContents()
		textw5:SetPos(430, 400)

		local textw6 = vgui.Create("DLabel", DProperties)
		textw6:SetText("Weapons")
		textw6:SetFont("Trebuchet18")
		textw6:SetTextColor(color_red)
		textw6:SizeToContents()
		textw6:SetPos(430, 410)

		local textw7 = vgui.Create("DLabel", DProperties)
		textw7:SetText("Blacklist")
		textw7:SetFont("Trebuchet18")
		textw7:SetTextColor(color_red)
		textw7:SizeToContents()
		textw7:SetPos(430, 425)

		local Butn = DProperties:Add("DButton")
		Butn:SetText("print assets")
		Butn:SetPos(355, 405)
		Butn:SetSize(65, 20)
		Butn.DoClick = function()
			print("-------------------------------------------")
			print("zmb/tranzit/locker/fridge_locker_open.wav")
			print("zmb/tranzit/locker/fridge_locker_close.wav")
			print("zmb/buried/locker/takeout.wav")
			print("zmb/buried/locker/putin.wav")
			print("-------------------------------------------")
			print("models/zmb/bo2/tranzit/zm_weapon_locker.mdl")
			print("models/zmb/bo2/buried/zm_bu_weapon_locker.mdl")
			print("models/zmb/bo2/highrise/afr_refrigerator2.mdl")
			print("-------------------------------------------")
		end

		return DProperties
	end,

	defaultdata = {
		price = 0,
		boxlist = true,
		elec = false,
		sound1 = "zmb/tranzit/locker/fridge_locker_open.wav",
		sound2 = "zmb/tranzit/locker/fridge_locker_close.wav",
		model = "models/zmb/bo2/tranzit/zm_weapon_locker.mdl",
		blacklist = {},
		collision = false,
	},
})

if SERVER then
	nzMapping:AddSaveModule("WeaponLockerSpawns", {
		savefunc = function()
			local locker_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_weaponlocker")) do
				table.insert(locker_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						price = v:GetPrice(),
						elec = v:GetElectric(),
						boxlist = v:GetUseBoxList(),
						sound1 = v.OpenSound,
						sound2 = v.CloseSound,
						model = v:GetModel(),
						blacklist = v.BlacklistWeapons or {},
						collision = (v:GetCollisionGroup() == COLLISION_GROUP_WORLD),
					}
				})
			end

			return locker_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnWeaponLocker(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_weaponlocker"}
	})

	hook.Add("ShutDown", "NZ.Sync.WepLocker", function()
		nzFridge:StoreWeapons()
	end)

	hook.Add("PlayerSpawn", "NZ.Sync.WepLocker", function(ply)
		if nzRound:InState(ROUND_CREATE) then return end

		local data = nzFridge:PlayerData(ply)
		if data and data.name and ply:GetNW2String("nzFridgeWep", "") ~= tostring(data.name) then
			ply:SetNW2String("nzFridgeWep", tostring(data.name))
		end
    end)

	hook.Add("OnRoundInit", "NZ.Start.WepLocker", function()
		nzFridge:BuildWeapons()
		timer.Simple(0, function()
			for _, ply in ipairs(player.GetAll()) do
				local data = nzFridge:PlayerData(ply)
				if data and data.name then
					ply:SetNW2String("nzFridgeWep", tostring(data.name))
				end
			end
		end)
	end)

	hook.Add("OnRoundEnd", "NZ.Save.WepLocker", function()
		if nzRound:InState(ROUND_CREATE) or nzRound:InState(ROUND_GO) then
			nzFridge:StoreWeapons()
		end
	end)
end
