nzTools:CreateTool("colorsettings", {
	displayname = "Map Color Settings",
	desc = "Use the Tool Interface and press Submit to save changes",
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
	end,
	Reload = function(wep, ply, tr, data)
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Map Color Settings",
	desc = "Use the Tool Interface and press Submit to save changes",
	icon = "icon16/palette.png",
	weight = 25,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, tooldata)
		local data = table.Copy(nzMapping.Settings)
		local valz = {}
		valz["Row1"] = data.zombieeyecolor == nil and Color(0, 255, 255, 255) or data.zombieeyecolor
		valz["Row2"] = data.boxlightcolor == nil and Color(0, 150, 200, 255) or data.boxlightcolor
		valz["Row3"] = data.textcolor == nil and Color(255, 255, 255, 255) or data.textcolor
		valz["Row4"] = data.paplightcolor == nil and Color(156, 81, 182, 255) or data.paplightcolor
		valz["PowerupColors"] = data.powerupcol or {
			["global"] = {
				[1] = Vector(0.196,1,0),
				[2] = Vector(0.568,1,0.29),
				[3] = Vector(0.262,0.666,0),
			},
			["local"] = {
				[1] = Vector(0.372,1,0.951),
				[2] = Vector(0.556,1,0.99),
				[3] = Vector(0,0.64,0.666),
			},
			["mini"] = {
				[1] = Vector(1,0.823,0),
				[2] = Vector(1,0.854,0.549),
				[3] = Vector(0.627,0.431,0),
			},
			["anti"] = {
				[1] = Vector(1,0.156,0.156),
				[2] = Vector(1,0.392,0.392),
				[3] = Vector(0.705,0,0),
			},
			["tombstone"] = {
				[1] = Vector(0.568,0,1),
				[2] = Vector(0.705,0.392,1),
				[3] = Vector(0.431,0,0.784),
			},
			["treasure"] = {
				[1] = Vector(1,0.475,0),
				[2] = Vector(1,0.705,0.184),
				[3] = Vector(0.785,0.38,0),
			}
		}
		valz["PAPMuzzle"] = data.papmuzzlecol or {
			[1] = Vector(0.470,0,1),
			[2] = Vector(0.431,0.156,1),
			[3] = Vector(0.647,0.549,1),
			[4] = Vector(0.196,0.078,0.431),
			[5] = Vector(0.235,0.078,0.705),
		}
		valz["WallbuyColors"] = data.wallbuydata or {
			["glow"] = (nzMapping.Settings.boxlightcolor or valz["Row2"] or Color(0,150,200,255)),
			["chalk"] = Color(255,255,255,255),
			["alpha"] = 30,
			["material"] = "sprites/wallbuy_light.vmt",
			["sizew"] = 128,
			["sizeh"] = 42,
		}
		valz["Row5"] = data.zombieeyecolor2 == nil and Color(255, 0, 0, 255) or data.zombieeyecolor2
		valz["Row6"] = data.zombieeyechange or false
		valz["Row7"] = data.zombieeyeround or 25
		valz["Row8"] = data.zombieeyetime or 30

		local sheet = vgui.Create( "DPropertySheet", frame )
		sheet:SetSize( 495, 430 )
		sheet:SetPos( 5, 5 )

		local function UpdateData() -- Will remain a local function here. There is no need for the context menu to intercept
			if !istable(valz["Row1"]) then data.zombieeyecolor = Color(0, 255, 255, 255) else data.zombieeyecolor = valz["Row1"] end
			if !istable(valz["Row2"]) then data.boxlightcolor = Color(0, 150,200,255) else data.boxlightcolor = valz["Row2"] end
			if !istable(valz["Row3"]) then data.textcolor = Color(0, 255, 255, 255) else data.textcolor = valz["Row3"] end
			if !istable(valz["Row4"]) then data.paplightcolor = Color(156, 81, 182, 255) else data.paplightcolor = valz["Row4"] end
			if !istable(valz["Row5"]) then data.zombieeyecolor2 = Color(255, 0, 0, 255) else data.zombieeyecolor2 = valz["Row5"] end
			if valz["Row6"] == nil then data.zombieeyechange = false else data.zombieeyechange = tobool(valz["Row6"]) end
			if valz["Row7"] == nil then data.zombieeyeround = 25 else data.zombieeyeround = tonumber(valz["Row7"]) end
			if valz["Row8"] == nil then data.zombieeyetime = 30 else data.zombieeyetime = tonumber(valz["Row8"]) end
			if !valz["PowerupColors"] then
				data.powerupcol = {
					["global"] = {
						[1] = Vector(0.196,1,0),
						[2] = Vector(0.568,1,0.29),
						[3] = Vector(0.262,0.666,0),
					},
					["local"] = {
						[1] = Vector(0.372,1,0.951),
						[2] = Vector(0.556,1,0.99),
						[3] = Vector(0,0.64,0.666),
					},
					["mini"] = {
						[1] = Vector(1,0.823,0),
						[2] = Vector(1,0.854,0.549),
						[3] = Vector(0.627,0.431,0),
					},
					["anti"] = {
						[1] = Vector(1,0.156,0.156),
						[2] = Vector(1,0.392,0.392),
						[3] = Vector(0.705,0,0),
					},
					["tombstone"] = {
						[1] = Vector(0.568,0,1),
						[2] = Vector(0.705,0.392,1),
						[3] = Vector(0.431,0,0.784),
					},
					["treasure"] = {
						[1] = Vector(1,0.475,0),
						[2] = Vector(1,0.705,0.184),
						[3] = Vector(0.785,0.38,0),
					}
				}
			else
				data.powerupcol = valz["PowerupColors"]
			end
			if !valz["PAPMuzzle"] then
				data.papmuzzlecol = {
					[1] = Vector(0.470,0,1),
					[2] = Vector(0.431,0.156,1),
					[3] = Vector(0.647,0.549,1),
					[4] = Vector(0.196,0.078,0.431),
					[5] = Vector(0.235,0.078,0.705),
				}
			else
				data.papmuzzlecol = valz["PAPMuzzle"]
			end
			if !valz["WallbuyColors"] then
				data.wallbuydata = {
					["glow"] = (nzMapping.Settings.boxlightcolor or valz["Row2"] or Color(0,150,200,255)),
					["chalk"] = Color(255,255,255,255),
					["alpha"] = 30,
					["material"] = "sprites/wallbuy_light.vmt",
					["sizew"] = 128,
					["sizeh"] = 42,
				}
			else
				data.wallbuydata = valz["WallbuyColors"]
			end

			nzMapping:SendMapData( data )
		end

		local color_grey_50 = Color(50, 50, 50)
		local color_grey_200 = Color(200, 200, 200)
		local color_red = Color(150, 50, 50)

		if (MapSDermaButton != nil) then
			MapSDermaButton:Remove()
		end

		MapSDermaButton = vgui.Create( "DButton", frame )
		MapSDermaButton:SetText( "Submit" )
		MapSDermaButton:SetPos( 10, 435 )
		MapSDermaButton:SetSize( 480, 30 )
		MapSDermaButton.DoClick = UpdateData
		
		local function AddEyeStuff()
			local eyePanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Eye Color", eyePanel, "icon16/palette.png", false, false, "Set the eye glow color the zombies have.")
			eyePanel:DockPadding(5, 5, 5, 5)

			local colorChoose = vgui.Create("DColorMixer", eyePanel)
			colorChoose:SetColor(valz["Row1"])
			colorChoose:SetPalette(false)
			colorChoose:SetAlphaBar(false)
			colorChoose:Dock(TOP)
			colorChoose:SetSize(150, 120)

			local colorChoose2 = vgui.Create("DColorMixer", eyePanel)
			colorChoose2:SetColor(valz["Row5"])
			colorChoose2:SetPalette(false)
			colorChoose2:SetAlphaBar(false)
			colorChoose2:SetPos(5, 155)
			colorChoose2:SetSize(470, 120)

			local uhhproperties = vgui.Create( "DProperties", eyePanel )
			uhhproperties:SetSize(455, 120)
			uhhproperties:SetPos(0, 285)

			local uhhsetting1 = uhhproperties:CreateRow("Options", "Change eye color mid game" )
			uhhsetting1:Setup("Boolean")
			uhhsetting1:SetValue(valz["Row6"])
			uhhsetting1.DataChanged = function( _, val ) valz["Row6"] = tobool(val) end
			uhhsetting1:SetTooltip("Nuketown?")

			local uhhsetting2 = uhhproperties:CreateRow("Options", "Round to change eye color" )
			uhhsetting2:Setup("Generic")
			uhhsetting2:SetValue(valz["Row7"])
			uhhsetting2.DataChanged = function( _, val ) valz["Row7"] = math.Round(tonumber(val)) end
			uhhsetting2:SetTooltip("What round eye color should change.")

			local uhhsetting3 = uhhproperties:CreateRow("Options", "Delay after round start")
			uhhsetting3:Setup("Generic")
			uhhsetting3:SetValue(valz["Row8"])
			uhhsetting3.DataChanged = function( _, val ) valz["Row8"] = tonumber(val) end
			uhhsetting3:SetTooltip("How many seconds after round start to change eye color.")

			local presets = vgui.Create("DComboBox", eyePanel)
			presets:SetSize(455, 20)
			presets:SetPos(5, 130)
			presets:AddChoice("Richtofen")
			presets:AddChoice("Samantha")
			presets:AddChoice("Avogadro")
			presets:AddChoice("Warden")
			presets:AddChoice("Laby")
			presets:AddChoice("Ghostlymoo")
			presets:AddChoice("Meme Demon")
			presets:AddChoice("Rainbow Bot")
			presets:AddChoice("Deep Orange")
			presets:AddChoice("Afton")
			presets:AddChoice("Loonicity")
			presets.OnSelect = function(self, index, value)
				if (value == "Richtofen") then
					colorChoose:SetColor(Color(0, 255, 255))
				elseif (value == "Samantha") then
					colorChoose:SetColor(Color(255, 145, 0))
				elseif (value == "Avogadro") then
					colorChoose:SetColor(Color(255, 255, 255))
				elseif (value == "Laby") then
					colorChoose:SetColor(Color(34, 177, 76))
				elseif (value == "Ghostlymoo") then
					colorChoose:SetColor(Color(73, 20, 207))
				elseif (value == "Meme Demon") then
					colorChoose:SetColor(Color(241, 224, 75))
				elseif (value == "Rainbow Bot") then
					colorChoose:SetColor(Color(241, 75, 238))	
				elseif (value == "Deep Orange") then
					colorChoose:SetColor(Color(255, 102, 0))
				elseif (value == "Afton") then
					colorChoose:SetColor(Color(182, 231, 35))	
				elseif (value == "Loonicity") then
					colorChoose:SetColor(Color(188, 21, 85))							
				elseif (value == "Warden") then
					colorChoose:SetColor(Color(255, 0, 0))	
				end

				colorChoose:ValueChanged(nil)
			end

			colorChoose.ValueChanged = function(col)
				valz["Row1"] = colorChoose:GetColor()
			end

			colorChoose2.ValueChanged = function(col)
				valz["Row5"] = colorChoose2:GetColor()
			end
		end
		
		local function AddBoxStuff()
			local boxlightPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Box Color", boxlightPanel, "icon16/palette.png", false, false, "Set the color of the Mystery Box light.")
			boxlightPanel:DockPadding(5, 5, 5, 5)
			local colorChoose2 = vgui.Create("DColorMixer", boxlightPanel)
			colorChoose2:SetColor(valz["Row2"])
			colorChoose2:SetPalette(false)
			colorChoose2:SetAlphaBar(false)
			colorChoose2:Dock(TOP)
			colorChoose2:SetSize(150, 220)
			
			local presets = vgui.Create("DComboBox", boxlightPanel)
			presets:SetSize(60, 20)
			presets:Dock(BOTTOM)
			presets:AddChoice("Default")
			presets:AddChoice("Mob of the Dead")
			presets:AddChoice("Shi No Numa")
			presets:AddChoice("Revelations")
			presets:AddChoice("Halloween")
			presets:AddChoice("UGX 1.1")
			presets:AddChoice("Infinite Warfare")
			presets:AddChoice("WW2")
			presets:AddChoice("Pink")
			presets:AddChoice("No Light")
			presets.OnSelect = function(self, index, value)
				if (value == "Default") then
					colorChoose2:SetColor(Color(150,200,255))
				elseif (value == "Shi No Numa") then
					colorChoose2:SetColor(Color(185, 255, 35))	
				elseif (value == "Revelations") then
					colorChoose2:SetColor(Color(42, 249, 31))	
				elseif (value == "Halloween") then
					colorChoose2:SetColor(Color(217, 37, 9))	
				elseif (value == "UGX 1.1") then
					colorChoose2:SetColor(Color(255, 0, 0))	
				elseif (value == "Infinite Warfare") then
					colorChoose2:SetColor(Color(54, 15, 132))	
				elseif (value == "WW2") then
					colorChoose2:SetColor(Color(59, 0, 0))	
				elseif (value == "Mob of the Dead") then
					colorChoose2:SetColor(Color(204, 102, 0))	
				elseif (value == "Pink") then
                    colorChoose2:SetColor(Color(246, 0, 255))    
                elseif (value == "No Light") then
					colorChoose2:SetColor(Color(0, 0, 0))	
				end

				colorChoose2:ValueChanged(nil)
			end

			colorChoose2.ValueChanged = function(col)
				valz["Row2"] = colorChoose2:GetColor()
			end
		end

		local function AddPaPStuff()
			local paplightPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("PaP Color", paplightPanel, "icon16/palette.png", false, false, "Set the color of the Mystery Box light.")
			paplightPanel:DockPadding(5, 5, 5, 5)

			local colorChooses = vgui.Create("DColorMixer", paplightPanel)
			colorChooses:SetColor(valz["Row4"])
			colorChooses:SetPalette(false)
			colorChooses:SetAlphaBar(false)
			colorChooses:Dock(TOP)
			colorChooses:SetSize(150, 220)
			
			local presets = vgui.Create("DComboBox", paplightPanel)
			presets:SetSize(60, 20)
			presets:Dock(BOTTOM)
			presets:AddChoice("Default")
			presets:AddChoice("No Light")
			presets.OnSelect = function(self, index, value)
				if (value == "Default") then
					colorChooses:SetColor(Color(156, 81, 182, 255))
				elseif (value == "No Light") then
					colorChooses:SetColor(Color(0, 0, 0, 255))	
				end

				colorChooses:ValueChanged(nil)
			end

			colorChooses.ValueChanged = function(col)
				valz["Row4"] = colorChooses:GetColor()
			end
		end
		
		local function AddFontColor()
			local fontPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Font Color", fontPanel, "icon16/palette.png", false, false, "Set the color of the various fonts.")
			fontPanel:DockPadding(5, 5, 5, 5)
			local fontColorChoice = vgui.Create("DColorMixer", fontPanel)
			fontColorChoice:SetColor(valz["Row3"])
			fontColorChoice:SetPalette(false)
			fontColorChoice:SetAlphaBar(false)
			fontColorChoice:Dock(TOP)
			fontColorChoice:SetSize(150, 220)
			
			local presets = vgui.Create("DComboBox", fontPanel)
			presets:SetSize(60, 20)
			presets:Dock(BOTTOM)
			presets:AddChoice("Default")
			presets.OnSelect = function(self, index, value)
				if (value == "Default") then
					fontColorChoice:SetColor(Color(255,255,255))
				end

				fontColorChoice:ValueChanged(nil)
			end

			fontColorChoice.ValueChanged = function(col)
				valz["Row3"] = fontColorChoice:GetColor()
			end
		end

		local function AddWallbuyColors()
			local wallbuyPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Wallbuy Colors", wallbuyPanel, "icon16/palette.png", false, false, "Set the colors for wallbuy chalk outlines, and the wallbuy glow.")
			wallbuyPanel:DockPadding(5, 5, 5, 5)

			local textw1 = vgui.Create("DLabel", wallbuyPanel)
			local textw2 = vgui.Create("DLabel", wallbuyPanel)
			
			local wallbuyColorGlow = vgui.Create("DColorMixer", wallbuyPanel)
			local wallbuyColorChalk = vgui.Create("DColorMixer", wallbuyPanel)
			local wallbuyColorAlpha = vgui.Create("DNumSlider", wallbuyPanel)
			
			local wallbuybar1 = vgui.Create("DImage", wallbuyPanel)
			local wallbuyresetcol = vgui.Create("DButton", wallbuyPanel)
			local wallbuyresetmat = vgui.Create("DButton", wallbuyPanel)
			local wallbuybar2 = vgui.Create("DImage", wallbuyPanel)

			local textw3 = vgui.Create("DLabel", wallbuyPanel)

			local wallbuyColorSizeX = vgui.Create("DNumberWang", wallbuyPanel)
			local wallbuyColorSizeY = vgui.Create("DNumberWang", wallbuyPanel)
			local wallbuyColorMat = vgui.Create("DTextEntry", wallbuyPanel)

			local textw = vgui.Create("DLabel", wallbuyColorSizeX)
			local texth = vgui.Create("DLabel", wallbuyColorSizeY)

			local wallbuyBack = vgui.Create("DImage", wallbuyPanel)
			local wallbuyImage = vgui.Create("DImage", wallbuyPanel)
			local wallbuyDrag = vgui.Create("DImage", wallbuyPanel)
			local textw4 = vgui.Create("DLabel", wallbuyImage)

			textw1:SetText("Wallbuy Glow Color")
			textw1:SetFont("Trebuchet18")
			textw1:SetTextColor(color_red)
			textw1:SizeToContents()
			textw1:SetPos(15, 0)

			wallbuyColorGlow:SetColor(valz["WallbuyColors"]["glow"])
			wallbuyColorGlow:SetPalette(false)
			wallbuyColorGlow:SetAlphaBar(false)
			wallbuyColorGlow:SetPos(10, 15)
			wallbuyColorGlow:SetSize(200, 150)
			wallbuyColorGlow.ValueChanged = function(col)
				timer.Simple(0, function()
					valz["WallbuyColors"]["glow"] = wallbuyColorGlow:GetColor()
				end)
			end

			textw2:SetText("Wallbuy Chalk Color")
			textw2:SetFont("Trebuchet18")
			textw2:SetTextColor(color_red)
			textw2:SizeToContents()
			textw2:SetPos(260, 0)

			wallbuyColorChalk:SetColor(valz["WallbuyColors"]["chalk"])
			wallbuyColorChalk:SetPalette(false)
			wallbuyColorChalk:SetAlphaBar(false)
			wallbuyColorChalk:SetPos(255, 15)
			wallbuyColorChalk:SetSize(200, 150)
			wallbuyColorChalk.ValueChanged = function(col)
				timer.Simple(0, function()
					valz["WallbuyColors"]["chalk"] = wallbuyColorChalk:GetColor()
				end)
			end

			wallbuyColorAlpha:SetText("Glow Alpha")
			wallbuyColorAlpha:SetPos(10, 165)
			wallbuyColorAlpha:SetSize(460, 30)
			wallbuyColorAlpha.Label:SetTextColor(color_black)
			wallbuyColorAlpha:SetMin(0)
			wallbuyColorAlpha:SetMax(255)
			wallbuyColorAlpha:SetDecimals(0)
			wallbuyColorAlpha:SetValue(valz["WallbuyColors"]["alpha"])
			wallbuyColorAlpha.OnValueChanged = function(val)
				timer.Simple(0, function()
					valz["WallbuyColors"]["alpha"] = wallbuyColorAlpha:GetValue()
				end)
			end

			wallbuybar1:SetPos(0, 195)
			wallbuybar1:SetImage("color")
			wallbuybar1:SetImageColor(Color(200,200,200,255))
			wallbuybar1:SetSize(470, 5)
			
			wallbuybar2:SetPos(0, 240)
			wallbuybar2:SetImage("color")
			wallbuybar2:SetImageColor(Color(200,200,200,255))
			wallbuybar2:SetSize(470, 5)
			
			textw3:SetText("Wallbuy Glow Texture")
			textw3:SetFont("Trebuchet18")
			textw3:SetTextColor(color_red)
			textw3:SizeToContents()
			textw3:SetPos(150, 335)

			wallbuyBack:SetPos(10, 250)
			wallbuyBack:SetImage("color")
			wallbuyBack:SetImageColor(color_black)
			wallbuyBack:SetSize(96, 96)

			wallbuyImage:SetPos(10, 250)
			wallbuyImage:SetSize(96, 96)
			wallbuyImage:SetImage(string.StripExtension(valz["WallbuyColors"]["material"]))

			textw4:SetText("Previvew")
			textw4:SetFont("Trebuchet18")
			textw4:SetTextColor(color_red)
			textw4:SizeToContents()
			textw4:CenterHorizontal()

			wallbuyDrag:SetMouseInputEnabled(true)
			wallbuyDrag:Droppable("godhelpwhatfuck")
			wallbuyDrag:SetPos(10, 250)
			wallbuyDrag:SetImage("color")
			wallbuyDrag:SetImageColor(color_transparent)
			wallbuyDrag:SetSize(96, 96)
			wallbuyDrag.Think = function()
				if wallbuyDrag:IsDragging() then
					local x, y = DProperties:CursorPos()
					local maxx, maxy = sheet:GetSize()
					x = math.Clamp(x, 0, maxx)
					y = math.Clamp(y, 0, maxy-30)
					x = x - 48
					y = y - 48

					wallbuyDrag:SetPos(x, y)
					wallbuyImage:SetPos(x, y)
					wallbuyBack:SetPos(x, y)
					textw4:CenterHorizontal()
				end
			end

			wallbuyColorSizeX:SetPos(10, 350)
			wallbuyColorSizeX:SetSize(60, 30)
			wallbuyColorSizeX:SetMin(0)
			wallbuyColorSizeX:SetMax(512)
			wallbuyColorSizeX:SetDecimals(0)
			wallbuyColorSizeX:SetValue(valz["WallbuyColors"]["sizew"])
			wallbuyColorSizeX.OnValueChanged = function(val)
				timer.Simple(0, function()
					valz["WallbuyColors"]["sizew"] = wallbuyColorSizeX:GetValue()
				end)
			end

			wallbuyColorSizeY:SetPos(80, 350)
			wallbuyColorSizeY:SetSize(60, 30)
			wallbuyColorSizeY:SetMin(0)
			wallbuyColorSizeY:SetMax(512)
			wallbuyColorSizeY:SetDecimals(0)
			wallbuyColorSizeY:SetValue(valz["WallbuyColors"]["sizeh"])
			wallbuyColorSizeY.OnValueChanged = function(val)
				timer.Simple(0, function()
					valz["WallbuyColors"]["sizeh"] = wallbuyColorSizeY:GetValue()
				end)
			end

			textw:SetText("(W)")
			textw:SetFont("Trebuchet18")
			textw:SetTextColor(color_red)
			textw:SizeToContents()
			textw:AlignRight(20)

			texth:SetText("(H)")
			texth:SetFont("Trebuchet18")
			texth:SetTextColor(color_red)
			texth:SizeToContents()
			texth:AlignRight(20)

			wallbuyColorMat:SetPlaceholderText("Glow Texture (VMT ONLY!!!!)")
			wallbuyColorMat:SetPos(150, 350)
			wallbuyColorMat:SetSize(255, 30)
			wallbuyColorMat:SetValue(valz["WallbuyColors"]["material"])
			wallbuyColorMat.OnTextChanged = function(val)
				local cheatingtime = "nz-wallbuy_Colorer_"
				local ourval = wallbuyColorMat:GetValue()
				if ourval == "" then return end
				if timer.Exists(cheatingtime) then timer.Remove(cheatingtime) end
				timer.Create(cheatingtime, 0.65, 1, function()
					if file.Exists("materials/"..ourval, "GAME") then
						valz["WallbuyColors"]["material"] = ourval
						wallbuyImage:SetImage(string.StripExtension(ourval))
					end
				end)
			end

			wallbuyresetcol:SetText("Reset Colors to Default")
			wallbuyresetcol:SetPos(45, 205)
			wallbuyresetcol:SetSize(180, 30)
			wallbuyresetcol.DoClick = function()
				valz["WallbuyColors"]["glow"] = nzMapping.Settings.boxlightcolor or Color(0,150,200,255)
				valz["WallbuyColors"]["chalk"] = Color(255,255,255,255)
				valz["WallbuyColors"]["alpha"] = 30
				wallbuyColorGlow:SetColor(valz["WallbuyColors"]["glow"])
				wallbuyColorChalk:SetColor(valz["WallbuyColors"]["chalk"])
				wallbuyColorAlpha:SetValue(valz["WallbuyColors"]["alpha"])
			end

			wallbuyresetmat:SetText("Reset Material to Default")
			wallbuyresetmat:SetPos(240, 205)
			wallbuyresetmat:SetSize(180, 30)
			wallbuyresetmat.DoClick = function()
				valz["WallbuyColors"]["material"] = "sprites/wallbuy_light.vmt"
				valz["WallbuyColors"]["sizew"] = 128
				valz["WallbuyColors"]["sizeh"] = 42
				wallbuyColorMat:SetValue(valz["WallbuyColors"]["material"])
				wallbuyColorSizeX:SetValue(valz["WallbuyColors"]["sizew"])
				wallbuyColorSizeY:SetValue(valz["WallbuyColors"]["sizeh"])
			end
		end

		local function AddPowerupColors()
			local powColPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("Powerup Colors", powColPanel, "icon16/palette.png", false, false, "Set the different glow colors for Powerups.")
			powColPanel:DockPadding(5, 5, 5, 5)

			local thefuckening = vgui.Create("DScrollPanel", powColPanel)
			thefuckening:SetPos(0, 15)
			thefuckening:SetSize(464, 376)
			thefuckening:SetPaintBackground(true)
			thefuckening:SetBackgroundColor(Color(225, 225, 225))

			local textw1 = vgui.Create("DLabel", powColPanel)
			textw1:SetText("Main")
			textw1:SetFont("Trebuchet18")
			textw1:SetTextColor(color_red)
			textw1:SizeToContents()
			textw1:SetPos(10, 0)

			local textw2 = vgui.Create("DLabel", powColPanel)
			textw2:SetText("Accent")
			textw2:SetFont("Trebuchet18")
			textw2:SetTextColor(color_red)
			textw2:SizeToContents()
			textw2:SetPos(165, 0)

			local textw3 = vgui.Create("DLabel", powColPanel)
			textw3:SetText("Extra")
			textw3:SetFont("Trebuchet18")
			textw3:SetTextColor(color_red)
			textw3:SizeToContents()
			textw3:SetPos(320, 0)

			local globalstored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["global"][1] or valz["PowerupColors"]["global"][1]
			local colorChooseGlobal = vgui.Create("DColorMixer", thefuckening)
			colorChooseGlobal:SetColor(Color(math.Round(globalstored[1]*255),math.Round(globalstored[2]*255),math.Round(globalstored[3]*255), 255))
			colorChooseGlobal:SetPalette(false)
			colorChooseGlobal:SetAlphaBar(false)
			colorChooseGlobal:SetWangs(true)
			colorChooseGlobal:SetPos(5, 30)
			colorChooseGlobal:SetSize(150, 120)

			colorChooseGlobal.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseGlobal:GetColor()
					valz["PowerupColors"]["global"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local globalstored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["global"][2] or valz["PowerupColors"]["global"][2]
			local colorChooseGlobal2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseGlobal2:SetColor(Color(math.Round(globalstored2[1]*255),math.Round(globalstored2[2]*255),math.Round(globalstored2[3]*255), 255))
			colorChooseGlobal2:SetPalette(false)
			colorChooseGlobal2:SetAlphaBar(false)
			colorChooseGlobal2:SetWangs(true)
			colorChooseGlobal2:SetPos(160, 30)
			colorChooseGlobal2:SetSize(150, 120)

			colorChooseGlobal2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseGlobal2:GetColor()
					valz["PowerupColors"]["global"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local globalstored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["global"][3] or valz["PowerupColors"]["global"][3]
			local colorChooseGlobal3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseGlobal3:SetColor(Color(math.Round(globalstored3[1]*255),math.Round(globalstored3[2]*255),math.Round(globalstored3[3]*255), 255))
			colorChooseGlobal3:SetPalette(false)
			colorChooseGlobal3:SetAlphaBar(false)
			colorChooseGlobal3:SetWangs(true)
			colorChooseGlobal3:SetPos(315, 30)
			colorChooseGlobal3:SetSize(150, 120)

			colorChooseGlobal3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseGlobal3:GetColor()
					valz["PowerupColors"]["global"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype1 = vgui.Create("DLabel", thefuckening)
			ptype1:SetText("Global Powerups")
			ptype1:SetFont("Trebuchet18")
			ptype1:SetTextColor(color_red)
			ptype1:SizeToContents()
			ptype1:SetPos(180, 15)

			local globalreset = vgui.Create("DButton", thefuckening)
			globalreset:SetText("Reset Global Colors")
			globalreset:SetPos(5, 10)
			globalreset:SizeToContents()
			globalreset.DoClick = function()
				colorChooseGlobal:SetColor(Color(math.Round(0.196*255),math.Round(1*255),0,255))
				colorChooseGlobal2:SetColor(Color(math.Round(0.568*255),math.Round(1*255),math.Round(0.29*255),255))
				colorChooseGlobal3:SetColor(Color(math.Round(0.262*255),math.Round(0.666*255),0,255))
				valz["PowerupColors"]["global"][1] = Vector(0.196,1,0)
				valz["PowerupColors"]["global"][2] = Vector(0.568,1,0.29)
				valz["PowerupColors"]["global"][3] = Vector(0.262,0.666,0)
			end

			local localstored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["local"][1] or valz["PowerupColors"]["local"][1]
			local colorChooseLocal = vgui.Create("DColorMixer", thefuckening)
			colorChooseLocal:SetColor(Color(math.Round(localstored[1]*255),math.Round(localstored[2]*255),math.Round(localstored[3]*255), 255))
			colorChooseLocal:SetPalette(false)
			colorChooseLocal:SetAlphaBar(false)
			colorChooseLocal:SetPos(5, 180)
			colorChooseLocal:SetSize(150, 120)

			colorChooseLocal.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseLocal:GetColor()
					valz["PowerupColors"]["local"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local localstored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["local"][2] or valz["PowerupColors"]["local"][2]
			local colorChooseLocal2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseLocal2:SetColor(Color(math.Round(localstored2[1]*255),math.Round(localstored2[2]*255),math.Round(localstored2[3]*255), 255))
			colorChooseLocal2:SetPalette(false)
			colorChooseLocal2:SetAlphaBar(false)
			colorChooseLocal2:SetPos(160, 180)
			colorChooseLocal2:SetSize(150, 120)

			colorChooseLocal2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseLocal2:GetColor()
					valz["PowerupColors"]["local"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local localstored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["local"][3] or valz["PowerupColors"]["local"][3]
			local colorChooseLocal3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseLocal3:SetColor(Color(math.Round(localstored3[1]*255),math.Round(localstored3[2]*255),math.Round(localstored3[3]*255), 255))
			colorChooseLocal3:SetPalette(false)
			colorChooseLocal3:SetAlphaBar(false)
			colorChooseLocal3:SetPos(315, 180)
			colorChooseLocal3:SetSize(150, 120)

			colorChooseLocal3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseLocal3:GetColor()
					valz["PowerupColors"]["local"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype2 = vgui.Create("DLabel", thefuckening)
			ptype2:SetText("Local Powerups")
			ptype2:SetFont("Trebuchet18")
			ptype2:SetTextColor(color_red)
			ptype2:SizeToContents()
			ptype2:SetPos(180, 165)

			local localreset = vgui.Create("DButton", thefuckening)
			localreset:SetText("Reset Local Colors")
			localreset:SetPos(5, 160)
			localreset:SizeToContents()
			localreset.DoClick = function()
				colorChooseLocal:SetColor(Color(math.Round(0.372*255),math.Round(1*255),math.Round(0.951*255),255))
				colorChooseLocal2:SetColor(Color(math.Round(0.556*255),math.Round(1*255),math.Round(0.99*255),255))
				colorChooseLocal3:SetColor(Color(math.Round(0*255),math.Round(0.64*255),math.Round(0.666*255),255))
				valz["PowerupColors"]["local"][1] = Vector(0.372,1,0.951)
				valz["PowerupColors"]["local"][2] = Vector(0.556,1,0.99)
				valz["PowerupColors"]["local"][3] = Vector(0,0.64,0.666)
			end

			local ministored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["mini"][1] or valz["PowerupColors"]["mini"][1]
			local colorChooseMini = vgui.Create("DColorMixer", thefuckening)
			colorChooseMini:SetColor(Color(math.Round(ministored[1]*255),math.Round(ministored[2]*255),math.Round(ministored[3]*255), 255))
			colorChooseMini:SetPalette(false)
			colorChooseMini:SetAlphaBar(false)
			colorChooseMini:SetPos(5, 330)
			colorChooseMini:SetSize(150, 120)

			colorChooseMini.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseMini:GetColor()
					valz["PowerupColors"]["mini"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ministored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["mini"][2] or valz["PowerupColors"]["mini"][2]
			local colorChooseMini2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseMini2:SetColor(Color(math.Round(ministored2[1]*255),math.Round(ministored2[2]*255),math.Round(ministored2[3]*255), 255))
			colorChooseMini2:SetPalette(false)
			colorChooseMini2:SetAlphaBar(false)
			colorChooseMini2:SetPos(160, 330)
			colorChooseMini2:SetSize(150, 120)

			colorChooseMini2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseMini2:GetColor()
					valz["PowerupColors"]["mini"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ministored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["mini"][3] or valz["PowerupColors"]["mini"][3]
			local colorChooseMini3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseMini3:SetColor(Color(math.Round(ministored3[1]*255),math.Round(ministored3[2]*255),math.Round(ministored3[3]*255), 255))
			colorChooseMini3:SetPalette(false)
			colorChooseMini3:SetAlphaBar(false)
			colorChooseMini3:SetPos(315, 330)
			colorChooseMini3:SetSize(150, 120)

			colorChooseMini3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseMini3:GetColor()
					valz["PowerupColors"]["mini"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype3 = vgui.Create("DLabel", thefuckening)
			ptype3:SetText("Mini Powerups")
			ptype3:SetFont("Trebuchet18")
			ptype3:SetTextColor(color_red)
			ptype3:SizeToContents()
			ptype3:SetPos(180, 315)

			local minireset = vgui.Create("DButton", thefuckening)
			minireset:SetText("Reset Mini Colors")
			minireset:SetPos(5, 310)
			minireset:SizeToContents()
			minireset.DoClick = function()
				colorChooseMini:SetColor(Color(math.Round(1*255),math.Round(0.823*255),math.Round(0*255),255))
				colorChooseMini2:SetColor(Color(math.Round(1*255),math.Round(0.854*255),math.Round(0.549*255),255))
				colorChooseMini3:SetColor(Color(math.Round(0.627*255),math.Round(0.431*255),math.Round(0*255),255))
				valz["PowerupColors"]["mini"][1] = Vector(1,0.823,0)
				valz["PowerupColors"]["mini"][2] = Vector(1,0.854,0.549)
				valz["PowerupColors"]["mini"][3] = Vector(0.627,0.431,0)
			end

			local antistored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["anti"][1] or valz["PowerupColors"]["anti"][1]
			local colorChooseAnti = vgui.Create("DColorMixer", thefuckening)
			colorChooseAnti:SetColor(Color(math.Round(antistored[1]*255),math.Round(antistored[2]*255),math.Round(antistored[3]*255), 255))
			colorChooseAnti:SetPalette(false)
			colorChooseAnti:SetAlphaBar(false)
			colorChooseAnti:SetPos(5, 480)
			colorChooseAnti:SetSize(150, 120)

			colorChooseAnti.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseAnti:GetColor()
					valz["PowerupColors"]["anti"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local antistored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["anti"][2] or valz["PowerupColors"]["anti"][2]
			local colorChooseAnti2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseAnti2:SetColor(Color(math.Round(antistored2[1]*255),math.Round(antistored2[2]*255),math.Round(antistored2[3]*255), 255))
			colorChooseAnti2:SetPalette(false)
			colorChooseAnti2:SetAlphaBar(false)
			colorChooseAnti2:SetPos(160, 480)
			colorChooseAnti2:SetSize(150, 120)

			colorChooseAnti2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseAnti2:GetColor()
					valz["PowerupColors"]["anti"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local antistored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["anti"][3] or valz["PowerupColors"]["anti"][3]
			local colorChooseAnti3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseAnti3:SetColor(Color(math.Round(antistored3[1]*255),math.Round(antistored3[2]*255),math.Round(antistored3[3]*255), 255))
			colorChooseAnti3:SetPalette(false)
			colorChooseAnti3:SetAlphaBar(false)
			colorChooseAnti3:SetPos(315, 480)
			colorChooseAnti3:SetSize(150, 120)

			colorChooseAnti3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseAnti3:GetColor()
					valz["PowerupColors"]["anti"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype4 = vgui.Create("DLabel", thefuckening)
			ptype4:SetText("Anti Powerups")
			ptype4:SetFont("Trebuchet18")
			ptype4:SetTextColor(color_red)
			ptype4:SizeToContents()
			ptype4:SetPos(180, 465)

			local antireset = vgui.Create("DButton", thefuckening)
			antireset:SetText("Reset Anti Colors")
			antireset:SetPos(5, 460)
			antireset:SizeToContents()
			antireset.DoClick = function()
				colorChooseAnti:SetColor(Color(math.Round(1*255),math.Round(0.156*255),math.Round(0.156*255), 255))
				colorChooseAnti2:SetColor(Color(math.Round(1*255),math.Round(0.392*255),math.Round(0.392*255), 255))
				colorChooseAnti3:SetColor(Color(math.Round(0.705*255),math.Round(0*255),math.Round(0*255), 255))
				valz["PowerupColors"]["anti"][1] = Vector(1,0.156,0.156)
				valz["PowerupColors"]["anti"][2] = Vector(1,0.392,0.392)
				valz["PowerupColors"]["anti"][3] = Vector(0.705,0,0)
			end

			local tombstonestored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["tombstone"][1] or valz["PowerupColors"]["tombstone"][1]
			local colorChooseTomb = vgui.Create("DColorMixer", thefuckening)
			colorChooseTomb:SetColor(Color(math.Round(tombstonestored[1]*255),math.Round(tombstonestored[2]*255),math.Round(tombstonestored[3]*255), 255))
			colorChooseTomb:SetPalette(false)
			colorChooseTomb:SetAlphaBar(false)
			colorChooseTomb:SetPos(5, 630)
			colorChooseTomb:SetSize(150, 120)

			colorChooseTomb.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseTomb:GetColor()
					valz["PowerupColors"]["tombstone"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local tombstonestored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["tombstone"][2] or valz["PowerupColors"]["tombstone"][2]
			local colorChooseTomb2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseTomb2:SetColor(Color(math.Round(tombstonestored2[1]*255),math.Round(tombstonestored2[2]*255),math.Round(tombstonestored2[3]*255), 255))
			colorChooseTomb2:SetPalette(false)
			colorChooseTomb2:SetAlphaBar(false)
			colorChooseTomb2:SetPos(160, 630)
			colorChooseTomb2:SetSize(150, 120)

			colorChooseTomb2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseTomb2:GetColor()
					valz["PowerupColors"]["tombstone"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local tombstonestored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["tombstone"][3] or valz["PowerupColors"]["tombstone"][3]
			local colorChooseTomb3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseTomb3:SetColor(Color(math.Round(tombstonestored3[1]*255),math.Round(tombstonestored3[2]*255),math.Round(tombstonestored3[3]*255), 255))
			colorChooseTomb3:SetPalette(false)
			colorChooseTomb3:SetAlphaBar(false)
			colorChooseTomb3:SetPos(315, 630)
			colorChooseTomb3:SetSize(150, 120)

			colorChooseTomb3.ValueChanged = function(col)
				timer.Simple(0, function()	
					local cum = colorChooseTomb3:GetColor()
					valz["PowerupColors"]["tombstone"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype5 = vgui.Create("DLabel", thefuckening)
			ptype5:SetText("Tombstone")
			ptype5:SetFont("Trebuchet18")
			ptype5:SetTextColor(color_red)
			ptype5:SizeToContents()
			ptype5:SetPos(180, 615)

			local tombreset = vgui.Create("DButton", thefuckening)
			tombreset:SetText("Reset Tombstone Colors")
			tombreset:SetPos(5, 610)
			tombreset:SizeToContents()
			tombreset.DoClick = function()
				colorChooseTomb:SetColor(Color(math.Round(0.568*255),math.Round(0*255),math.Round(1*255), 255))
				colorChooseTomb2:SetColor(Color(math.Round(0.705*255),math.Round(0.392*255),math.Round(1*255), 255))
				colorChooseTomb3:SetColor(Color(math.Round(0.431*255),math.Round(0*255),math.Round(0.784*255), 255))
				valz["PowerupColors"]["tombstone"][1] = Vector(0.568,0,1)
				valz["PowerupColors"]["tombstone"][2] = Vector(0.705,0.392,1)
				valz["PowerupColors"]["tombstone"][3] = Vector(0.431,0,0.784)
			end

			local treasurestored = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["treasure"][1] or valz["PowerupColors"]["treasure"][1]
			local colorChooseTrzr = vgui.Create("DColorMixer", thefuckening)
			colorChooseTrzr:SetColor(Color(math.Round(treasurestored[1]*255),math.Round(treasurestored[2]*255),math.Round(treasurestored[3]*255), 255))
			colorChooseTrzr:SetPalette(false)
			colorChooseTrzr:SetAlphaBar(false)
			colorChooseTrzr:SetPos(5, 780)
			colorChooseTrzr:SetSize(150, 120)

			colorChooseTrzr.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseTrzr:GetColor()
					valz["PowerupColors"]["treasure"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local treasurestored2 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["treasure"][2] or valz["PowerupColors"]["treasure"][2]
			local colorChooseTrzr2 = vgui.Create("DColorMixer", thefuckening)
			colorChooseTrzr2:SetColor(Color(math.Round(treasurestored2[1]*255),math.Round(treasurestored2[2]*255),math.Round(treasurestored2[3]*255), 255))
			colorChooseTrzr2:SetPalette(false)
			colorChooseTrzr2:SetAlphaBar(false)
			colorChooseTrzr2:SetPos(160, 780)
			colorChooseTrzr2:SetSize(150, 120)

			colorChooseTrzr2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChooseTrzr2:GetColor()
					valz["PowerupColors"]["treasure"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local treasurestored3 = nzMapping.Settings.powerupcol and nzMapping.Settings.powerupcol["treasure"][3] or valz["PowerupColors"]["treasure"][3]
			local colorChooseTrzr3 = vgui.Create("DColorMixer", thefuckening)
			colorChooseTrzr3:SetColor(Color(math.Round(treasurestored3[1]*255),math.Round(treasurestored3[2]*255),math.Round(treasurestored3[3]*255), 255))
			colorChooseTrzr3:SetPalette(false)
			colorChooseTrzr3:SetAlphaBar(false)
			colorChooseTrzr3:SetPos(315, 780)
			colorChooseTrzr3:SetSize(150, 120)

			colorChooseTrzr3.ValueChanged = function(col)
				timer.Simple(0, function()	
					local cum = colorChooseTrzr3:GetColor()
					valz["PowerupColors"]["treasure"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local ptype6 = vgui.Create("DLabel", thefuckening)
			ptype6:SetText("Treasure")
			ptype6:SetFont("Trebuchet18")
			ptype6:SetTextColor(color_red)
			ptype6:SizeToContents()
			ptype6:SetPos(180, 765)

			local treasurereset = vgui.Create("DButton", thefuckening)
			treasurereset:SetText("Reset Treasure Colors")
			treasurereset:SetPos(5, 760)
			treasurereset:SizeToContents()
			treasurereset.DoClick = function()
				colorChooseTrzr:SetColor(Color(math.Round(1*255),math.Round(0.475*255),0, 255))
				colorChooseTrzr2:SetColor(Color(math.Round(1*255),math.Round(0.705*255),math.Round(0.184*255), 255))
				colorChooseTrzr3:SetColor(Color(math.Round(0.785*255),math.Round(0.38*255),0, 255))
				valz["PowerupColors"]["treasure"][1] = Vector(1,0.475,0)
				valz["PowerupColors"]["treasure"][2] = Vector(1,0.705,0.184)
				valz["PowerupColors"]["treasure"][3] = Vector(0.785,0.38,0)
			end
		end

		local function AddMuzzleflashColors()
			local papflashColPanel = vgui.Create("DPanel", sheet)
			sheet:AddSheet("PaP Muzzleflash Colors", papflashColPanel, "icon16/palette.png", false, false, "Sets the muzzleflash colors for weapons that use the 'muz_pap' effect.")
			papflashColPanel:DockPadding(5, 5, 5, 5)

			local textw1 = vgui.Create("DLabel", papflashColPanel)
			textw1:SetText("Core")
			textw1:SetFont("Trebuchet18")
			textw1:SetTextColor(color_red)
			textw1:SizeToContents()
			textw1:SetPos(10, 0)

			local textw2 = vgui.Create("DLabel", papflashColPanel)
			textw2:SetText("Cross")
			textw2:SetFont("Trebuchet18")
			textw2:SetTextColor(color_red)
			textw2:SizeToContents()
			textw2:SetPos(165, 0)

			local textw3 = vgui.Create("DLabel", papflashColPanel)
			textw3:SetText("Sparks")
			textw3:SetFont("Trebuchet18")
			textw3:SetTextColor(color_red)
			textw3:SizeToContents()
			textw3:SetPos(320, 0)

			local textw4 = vgui.Create("DLabel", papflashColPanel)
			textw4:SetText("Glow A")
			textw4:SetFont("Trebuchet18")
			textw4:SetTextColor(color_red)
			textw4:SizeToContents()
			textw4:SetPos(95, 145)

			local textw5 = vgui.Create("DLabel", papflashColPanel)
			textw5:SetText("Glow B")
			textw5:SetFont("Trebuchet18")
			textw5:SetTextColor(color_red)
			textw5:SizeToContents()
			textw5:SetPos(250, 145)

			local papcolstored = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[1] or valz["PAPMuzzle"][1]
			local colorChoosePAP1 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP1:SetColor(Color(math.Round(papcolstored[1]*255),math.Round(papcolstored[2]*255),math.Round(papcolstored[3]*255), 255))
			colorChoosePAP1:SetPalette(false)
			colorChoosePAP1:SetAlphaBar(false)
			colorChoosePAP1:SetWangs(true)
			colorChoosePAP1:SetPos(5, 15)
			colorChoosePAP1:SetSize(150, 120)

			colorChoosePAP1.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP1:GetColor()
					valz["PAPMuzzle"][1] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papcolstored2 = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[2] or valz["PAPMuzzle"][2]
			local colorChoosePAP2 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP2:SetColor(Color(math.Round(papcolstored2[1]*255),math.Round(papcolstored2[2]*255),math.Round(papcolstored2[3]*255), 255))
			colorChoosePAP2:SetPalette(false)
			colorChoosePAP2:SetAlphaBar(false)
			colorChoosePAP2:SetWangs(true)
			colorChoosePAP2:SetPos(160, 15)
			colorChoosePAP2:SetSize(150, 120)

			colorChoosePAP2.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP2:GetColor()
					valz["PAPMuzzle"][2] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papcolstored3 = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[3] or valz["PAPMuzzle"][3]
			local colorChoosePAP3 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP3:SetColor(Color(math.Round(papcolstored3[1]*255),math.Round(papcolstored3[2]*255),math.Round(papcolstored3[3]*255), 255))
			colorChoosePAP3:SetPalette(false)
			colorChoosePAP3:SetAlphaBar(false)
			colorChoosePAP3:SetWangs(true)
			colorChoosePAP3:SetPos(315, 15)
			colorChoosePAP3:SetSize(150, 120)

			colorChoosePAP3.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP3:GetColor()
					valz["PAPMuzzle"][3] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papcolstored4 = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[4] or valz["PAPMuzzle"][4]
			local colorChoosePAP4 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP4:SetColor(Color(math.Round(papcolstored4[1]*255),math.Round(papcolstored4[2]*255),math.Round(papcolstored4[3]*255), 255))
			colorChoosePAP4:SetPalette(false)
			colorChoosePAP4:SetAlphaBar(false)
			colorChoosePAP4:SetWangs(true)
			colorChoosePAP4:SetPos(90, 160)
			colorChoosePAP4:SetSize(150, 120)

			colorChoosePAP4.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP4:GetColor()
					valz["PAPMuzzle"][4] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papcolstored5 = nzMapping.Settings.papmuzzlecol and nzMapping.Settings.papmuzzlecol[5] or valz["PAPMuzzle"][5]
			local colorChoosePAP5 = vgui.Create("DColorMixer", papflashColPanel)
			colorChoosePAP5:SetColor(Color(math.Round(papcolstored5[1]*255),math.Round(papcolstored5[2]*255),math.Round(papcolstored5[3]*255), 255))
			colorChoosePAP5:SetPalette(false)
			colorChoosePAP5:SetAlphaBar(false)
			colorChoosePAP5:SetWangs(true)
			colorChoosePAP5:SetPos(245, 160)
			colorChoosePAP5:SetSize(150, 120)

			colorChoosePAP5.ValueChanged = function(col)
				timer.Simple(0, function()
					local cum = colorChoosePAP5:GetColor()
					valz["PAPMuzzle"][5] = Vector(cum.r/255, cum.g/255, cum.b/255)
				end)
			end

			local papreset = vgui.Create("DButton", papflashColPanel)
			papreset:SetText("Reset Colors to Default")
			papreset:SetPos(160, 290)
			papreset:SizeToContents()
			papreset.DoClick = function()
				colorChoosePAP1:SetColor(Color(math.Round(0.470*255), 0, 255, 255))
				colorChoosePAP2:SetColor(Color(math.Round(0.431*255), math.Round(0.156*255), 255, 255))
				colorChoosePAP3:SetColor(Color(math.Round(0.647*255), math.Round(0.549*255), 255, 255))
				colorChoosePAP4:SetColor(Color(math.Round(0.196*255), math.Round(0.078*255), math.Round(0.431*255), 255))
				colorChoosePAP5:SetColor(Color(math.Round(0.235*255), math.Round(0.078*255), math.Round(0.705*255), 255))
				valz["PAPMuzzle"][1] = Vector(0.470,0,1)
				valz["PAPMuzzle"][2] = Vector(0.431,0.156,1)
				valz["PAPMuzzle"][3] = Vector(0.647,0.549,1)
				valz["PAPMuzzle"][4] = Vector(0.196,0.078,0.431)
				valz["PAPMuzzle"][5] = Vector(0.235,0.078,0.705)
			end
		end

		AddBoxStuff()
		AddPaPStuff()
		AddEyeStuff()
		AddFontColor()
		AddPowerupColors()
		AddWallbuyColors()
		AddMuzzleflashColors()

		return sheet
	end,
	-- defaultdata = {}
})

if SERVER then
	hook.Add("OnRoundStart", "nz.RichtofenEyes", function(round)
		if !nzMapping.Settings.zombieeyechange then return end

		if round >= nzMapping.Settings.zombieeyeround and !nzRound.StoredEyeColor then
			nzRound.StoredEyeColor = nzMapping.Settings.zombieeyecolor
			timer.Simple(nzMapping.Settings.zombieeyetime, function()
				nzMapping.Settings.zombieeyecolor = nzMapping.Settings.zombieeyecolor2
				nzMapping:SendMapDataSingle("zombieeyecolor", nzMapping.Settings.zombieeyecolor2)
			end)
		end
	end)

	hook.Add("OnRoundEnd", "nz.RichtofenEyes", function()
		local ourcolor = nzRound.StoredEyeColor
		nzRound.StoredEyeColor = nil
		timer.Simple(10 - engine.TickInterval(), function()
			if ourcolor and nzMapping.Settings.zombieeyecolor ~= ourcolor then
				nzMapping.Settings.zombieeyecolor = ourcolor
				nzMapping:SendMapDataSingle("zombieeyecolor", ourcolor)
			end
		end)
	end)
end