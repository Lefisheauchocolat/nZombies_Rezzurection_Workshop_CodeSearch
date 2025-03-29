//Main Tables
nzTools = nzTools or AddNZModule("Tools")
nzTools.ToolData = nzTools.ToolData or {}

//Variables
if CLIENT then
	nzTools.Advanced = nzTools.Advanced or false
	nzTools.SavedData = nzTools.SavedData or {}
	nzTools.WeaponSelectMenu = nil

	function nzTools:OpenWeaponSelectMenu(entry, button, isbox)
		local frame = vgui.Create("DFrame")
		frame:SetSize(740, 550)
		frame:Center()
		frame:SetTitle("Select Weapon")
		frame:MakePopup()

		frame.OnRemove = function()
			nzTools.WeaponSelectMenu = nil
		end

		nzTools.WeaponSelectMenu = frame

		local ListPanel = vgui.Create("DPanel", frame)
		ListPanel:Dock(LEFT)
		ListPanel:SetWidth(185)

		local ListPanelScroll = vgui.Create("DTree", ListPanel)
		ListPanelScroll:Dock(FILL)

		local OptionPanel = vgui.Create("DPanel", frame)
		OptionPanel:Dock(RIGHT)
		OptionPanel:SetWidth(540)

		local OptionPanelScroll = vgui.Create("DScrollPanel", OptionPanel)
		OptionPanelScroll:Dock(FILL)

		local WeaponList = weapons.GetList()
		local WeaponCategoryList = {}

		for _, _wep in pairs(WeaponList) do
			if _wep.Base and not table.HasValue(WeaponCategoryList, _wep.Category) then
				table.insert(WeaponCategoryList, _wep.Category)
			end
		end
		table.sort(WeaponCategoryList)

		local grid = vgui.Create("DGrid", OptionPanelScroll)
		grid:SetPos(0, 0)
		grid:SetCols(4)
		grid:SetColWide(130)
		grid:SetRowHeight(135)

		for _, category in ipairs(WeaponCategoryList) do
			local Node = ListPanelScroll:AddNode(category, "icon16/gun.png")

			Node.DoClick = function()
				grid:Clear()

				local categorizedWeapons = {}
				local uncategorizedWeapons = {}

				for _, _wep in pairs(WeaponList) do
					if _wep.Category == category then
						if not (nzConfig.WeaponBlackList[_wep.ClassName] or _wep.PrintName == "Scripted Weapon" or (isbox and _wep.NZPreventBox) or _wep.NZTotalBlacklist) then
							if _wep.SubCategory then
								categorizedWeapons[_wep.SubCategory] = categorizedWeapons[_wep.SubCategory] or {}
								table.insert(categorizedWeapons[_wep.SubCategory], _wep)
							else
								table.insert(uncategorizedWeapons, _wep)
							end
						end
					end
				end

				table.sort(weapons, function(a, b)
					return (a.PrintName or "") < (b.PrintName or "")
				end)

				for subCategory, weapons in SortedPairs(categorizedWeapons) do
					for _, wep in ipairs(weapons) do
						local icon = vgui.Create("ContentIcon", grid)
						local iconPath = "entities/" .. wep.ClassName .. ".png"

						if not Material(iconPath):IsError() then
							icon:SetMaterial(iconPath)
						end

						icon.Label:SetText(wep.PrintName or wep.ClassName)
						grid:AddItem(icon)

						icon.DoClick = function()
							nzTools.WeaponSelectMenu = nil
							frame:Close()

							if entry and IsValid(entry) then
								entry.optionData = wep.ClassName

								if entry.SetText then
									local special = wep.NZSpecialCategory and " (" .. wep.NZSpecialCategory .. ")" or ""
									entry:SetText((wep.PrintName or wep.ClassName) .. special)
								end
							end

							if button and IsValid(button) then
								button.optionData = wep.ClassName
								button:DoClick()
							end
						end
					end
				end

				table.sort(uncategorizedWeapons, function(a, b)
					return (a.PrintName or "") < (b.PrintName or "")
				end)

				for _, wep in ipairs(uncategorizedWeapons) do
					local icon = vgui.Create("ContentIcon", grid)
					local iconPath = "entities/" .. wep.ClassName .. ".png"

					if not Material(iconPath):IsError() then
						icon:SetMaterial(iconPath)
					end

					icon.Label:SetText(wep.PrintName or wep.ClassName)
					grid:AddItem(icon)

					icon.DoClick = function()
						nzTools.WeaponSelectMenu = nil
						frame:Close()

						if entry and IsValid(entry) then
							entry.optionData = wep.ClassName

							if entry.SetText then
								local special = wep.NZSpecialCategory and " (" .. wep.NZSpecialCategory .. ")" or ""
								entry:SetText((wep.PrintName or wep.ClassName) .. special)
							end
						end

						if button and IsValid(button) then
							button.optionData = wep.ClassName
							button:DoClick()
						end
					end
				end
			end
		end
	end
end