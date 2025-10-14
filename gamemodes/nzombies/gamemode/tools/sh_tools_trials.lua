nzTools:CreateTool("trials", {
	displayname = "Trial Placer",
	desc = "LMB: Place/Update Trial, RMB: Remove Trial",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_scriptedtrial" and data then
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			if data.class and data.class ~= "" then
				ent:SetScriptedTrial(tostring(data.class))
			else
				ent:SetScriptedTrial("random")
			end
			if data.sound and file.Exists("sound/"..data.sound, "GAME") then
				ent.CompleteSound = Sound(data.sound)
			end
			if data.fizzlist ~= nil then
				ent.UseFizzlist = tobool(data.fizzlist)
			end
			if data.trialslist then
				ent.TrialsList = data.trialslist
			end
			if data.pressuse ~= nil then
				ent:SetPressUse(tobool(data.pressuse))
			end

			return
		end

		local trials = ents.FindByClass("nz_scriptedtrial")
		if data and data.trialslist then
			local num = 0
			for k, v in pairs(data.trialslist) do
				if v then
					num = num + 1
				end
			end

			if #trials >= num then return end
		end

		if data and data.class and !data.random then
			for k, v in pairs(trials) do
				if not v:GetUseRandom() and v:GetScriptedTrial() == tostring(data.class) then return end
			end
		end

		nzMapping:SpawnTrial(tr.HitPos + tr.HitNormal, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_scriptedtrial" then
			ent:Remove()
			return
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_scriptedtrial"then
			if ply:KeyDown(IN_SPEED) then
				ent:SetAngles(ent:GetAngles() - Angle(0,ply:KeyDown(IN_DUCK) and 5 or 45,0))
			else
				ent:SetAngles(ent:GetAngles() + Angle(0,ply:KeyDown(IN_DUCK) and 5 or 45,0))
			end
			return
		end
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Trial Placer",
	desc = "LMB: Place/Update Trial, RMB: Remove Trial",
	icon = "icon16/rosette.png",
	weight = 20,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tostring(data.model)
		valz["Row2"] = tostring(data.class)
		valz["Row3"] = tostring(data.sound)
		valz["Row4"] = tobool(data.fizzlist)
		valz["Row5"] = tobool(data.pressuse)

		local trialslist = {}
		for k, v in pairs(nzTrials.Data) do
			if v.default then
				trialslist[k] = true
			else
				trialslist[k] = false
			end
		end

		valz["TrialsList"] = data.trialslist or trialslist

		local sheet = vgui.Create( "DPropertySheet", frame )
		sheet:SetSize( 480, 450 )
		sheet:SetPos( 0, 0 )

		local DProperties = vgui.Create( "DProperties", sheet )
		DProperties:SetSize( 280, 480 )
		DProperties:SetPos( 0, 0 )
		sheet:AddSheet("Settings", DProperties, "icon16/cog.png", false, false, "General settings for Trials tool")

		function DProperties.CompileData()
			data.model = tostring(valz["Row1"])
			data.class = tostring(valz["Row2"])
			data.sound = tostring(valz["Row3"])
			data.fizzlist = tobool(valz["Row4"])
			data.pressuse = tobool(valz["Row5"])
			data.trialslist = valz["TrialsList"] or trialslist

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "trials")
		end

		local Row1 = DProperties:CreateRow("Settings", "Model path")
		Row1:Setup("Generic")
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Defaults to 'models/zmb/bo2/alcatraz/zm_al_skull.mdl'")

		local Row2 = DProperties:CreateRow("Settings", "Selected Trial")
		Row2:Setup("Combo")
		for i, tab in pairs(nzTrials.Data) do Row2:AddChoice(tab.name, i) end
		Row2:AddChoice("Use Random Trials list (Default)", "random")
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Select a specific trial to be given. Defaults to Randomizing")

		local Row3 = DProperties:CreateRow("Settings", "Trial Complete Sound path")
		Row3:Setup("Generic")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Defaults to 'zmb/tomb/challenge_medal_r3.wav'")

		local Row4 = DProperties:CreateRow("Settings", "Use Wunderfizz list for Perk Rewards")
		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("When selecting your Perk reward, limit options to whats in the Wunderfizz list")

		local Row5 = DProperties:CreateRow("Settings", "Require Pressing USE to Start Trial")
		Row5:Setup("Boolean")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Players must press +USE key on trial entity to begin their trial")

		local trialpanel = vgui.Create("DPanel", sheet)
		sheet:AddSheet( "Random Trials list", trialpanel, "icon16/rosette.png", false, false, "Set which trials are possible on your config.")
		trialpanel.Paint = function() return end

		local triallistpnl = vgui.Create("DScrollPanel", trialpanel)
		triallistpnl:SetPos(0, 0)
		triallistpnl:SetSize(465, 380)
		triallistpnl:SetPaintBackground(true)
		triallistpnl:SetBackgroundColor( Color(200, 200, 200) )

		local trailistcheck = vgui.Create( "DIconLayout", triallistpnl )
		trailistcheck:SetSize( 465, 380 )
		trailistcheck:SetPos( 35, 10 )
		trailistcheck:SetSpaceY( 5 )
		trailistcheck:SetSpaceX( 5 )

		for k, v in pairs(nzTrials.Data) do
			local trial = trailistcheck:Add( "DPanel" )
			trial:SetSize( 380, 20 )

			local check = trial:Add("DCheckBox")
			check:SetPos(2,2)

			if trialslist then
				check:SetValue(valz["TrialsList"][k])
			end

			check.OnChange = function(self, val)
				valz["TrialsList"][k] = val
				DProperties.UpdateData(DProperties.CompileData())
			end

			local name = trial:Add("DLabel")
			name:SetTextColor(Color(80,80,80))
			name:SetSize(360, 20)
			name:SetPos(20,1)
			name:SetText(v.name)
		end

		if not data.trialslist then
			DProperties.UpdateData(DProperties.CompileData())
		end

		local UpdateButn = sheet:Add("DButton")
		UpdateButn:SetText( "Update All Scripted Trials 'Random Trials List'" )
		UpdateButn:SetPos( 0, 420 )
		UpdateButn:SetSize( 480, 30 )
		UpdateButn.DoClick = function()
			nzTools:UpdateTrials(DProperties.CompileData().trialslist)
		end

		local color_red = Color(150, 50, 50)

		local textw = vgui.Create("DLabel", sheet)
		textw:SetText("models/zmb/bo2/alcatraz/zm_al_skull.mdl")
		textw:SetFont("Trebuchet18")
		textw:SetTextColor(color_red)
		textw:SizeToContents()
		textw:SetPos(240, 150)
		textw:CenterHorizontal()

		local textw2 = vgui.Create("DLabel", sheet)
		textw2:SetText("models/zmb/bo2/alcatraz/zm_al_skull_afterlife.mdl")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(240, 170)
		textw2:CenterHorizontal()

		local textw3 = vgui.Create("DLabel", sheet)
		textw3:SetText("zmb/alcatraz/tomahawk_4.wav")
		textw3:SetFont("Trebuchet18")
		textw3:SetTextColor(color_red)
		textw3:SizeToContents()
		textw3:SetPos(240, 210)
		textw3:CenterHorizontal()

		local textw4 = vgui.Create("DLabel", sheet)
		textw4:SetText("zmb/tomb/challenge_medal_r3.wav")
		textw4:SetFont("Trebuchet18")
		textw4:SetTextColor(color_red)
		textw4:SizeToContents()
		textw4:SetPos(240, 230)
		textw4:CenterHorizontal()

		local textw5 = vgui.Create("DLabel", sheet)
		textw5:SetText("zmb/stringer/afterlife_add.wav")
		textw5:SetFont("Trebuchet18")
		textw5:SetTextColor(color_red)
		textw5:SizeToContents()
		textw5:SetPos(240, 250)
		textw5:CenterHorizontal()

		local textw6 = vgui.Create("DLabel", sheet)
		textw6:SetText("Hold ["..string.upper(input.LookupBinding("+speed")).."] & Press ["..string.upper(input.LookupBinding("+use")).."] while looking at a scripted trial ent")
		textw6:SetFont("Trebuchet18")
		textw6:SetTextColor(color_red)
		textw6:SizeToContents()
		textw6:SetPos(240, 290)
		textw6:CenterHorizontal()

		local textw7 = vgui.Create("DLabel", sheet)
		textw7:SetText("to view its random trials list and to test the 'Trial Complete' sound")
		textw7:SetFont("Trebuchet18")
		textw7:SetTextColor(color_red)
		textw7:SizeToContents()
		textw7:SetPos(240, 310)
		textw7:CenterHorizontal()

		local Butn = DProperties:Add("DButton")
		Butn:SetText( "print models to console" )
		Butn:SetPos( 120, 300 )
		Butn:SetSize( 240, 30 )
		//Butn:CenterHorizontal()
		Butn.DoClick = function()
			print("-------------------------------------------")
			print("models/zmb/bo2/alcatraz/zm_al_skull.mdl")
			print("models/zmb/bo2/alcatraz/zm_al_skull_afterlife.mdl")
			print("-------------------------------------------")
		end

		local Butn2 = DProperties:Add("DButton")
		Butn2:SetText( "print sounds to console" )
		Butn2:SetPos( 120, 335 )
		Butn2:SetSize( 240, 30 )
		//Butn2:CenterHorizontal()
		Butn2.DoClick = function()
			print("-------------------------------------------")
			print("zmb/tomb/challenge_medal_r3.wav")
			print("zmb/alcatraz/tomahawk_4.wav")
			print("zmb/stringer/afterlife_add.wav")
			print("-------------------------------------------")
		end

		return sheet
	end,

	defaultdata = {
		model = "models/zmb/bo2/alcatraz/zm_al_skull.mdl",
		class = "random",
		sound = "zmb/tomb/challenge_medal_r3.wav",
		fizzlist = true,
		pressuse = false,
	},
})

if SERVER then
	nzMapping:AddSaveModule("Trials", {
		savefunc = function()
			local trial_spawn = {}
			for k, v in pairs(ents.FindByClass("nz_scriptedtrial")) do
				table.insert(trial_spawn, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						model = v:GetModel(),
						class = v:GetScriptedTrial(),
						sound = v.CompleteSound,
						fizzlist = v.UseFizzlist,
						trialslist = v.TrialsList,
						pressuse = v:GetPressUse(),
					}
				})
			end

			return trial_spawn
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnTrial(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_scriptedtrial"}
	})
end

if SERVER then
	hook.Add("OnRoundInit", "NZ.Start.Trials", function()
		for k, v in pairs(ents.FindByClass("nz_scriptedtrial")) do
			v:StartTrial()
		end
	end)

	hook.Add("OnRoundEnd", "NZ.Reset.Trials", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_scriptedtrial")) do
				v:Reset()
			end
			nzTrials:ResetTrials()
		end
	end)

	hook.Add("PlayerFullyInitialized", "NZ.Start.Trial", function(ply)
		if nzRound:InProgress() and not ply:Alive() then
			for k, v in pairs(ents.FindByClass("nz_scriptedtrial")) do
				if v:GetPressUse() then continue end

				if v:GetUseRandom() then
					v:AssignRandomTrial(ply)
				else
					v:AssignTrial(ply)
				end
			end
		end
	end)

	util.AddNetworkString( "nzTrialsUpdate" )

	local function ReceiveData(len, ply)
		local data = net.ReadTable()
		for k, v in pairs(ents.FindByClass("nz_scriptedtrial")) do
			v.TrialsList = data
		end
	end
	net.Receive( "nzTrialsUpdate", ReceiveData )
end

if CLIENT then
	function nzTools:UpdateTrials(data)
		if data then
			net.Start("nzTrialsUpdate")
				net.WriteTable(data)
			net.SendToServer()
		end
	end
end