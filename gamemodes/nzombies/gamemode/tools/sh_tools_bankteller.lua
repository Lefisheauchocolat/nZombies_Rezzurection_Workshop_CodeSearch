nzTools:CreateTool("bankteller", {
	displayname = "Bank Placer",
	desc = "LMB: Place/Update Bank, RMB: Remove Bank",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "nz_launchpad" and data then
			if data.model and util.IsValidModel(data.model) then
				ent:SetModel(tostring(data.model))
			end
			if data.fee then
				ent:SetPointFee(tonumber(data.fee))
			end
			if data.limit then
				ent:SetPointLimit(tonumber(data.limit))
			end
			if data.elec ~= nil then
				ent.Elec = tobool(data.elec)
				ent:SetElectric(tobool(data.elec))
			end
			if data.sound1 and file.Exists("sound/"..data.sound1, "GAME") then
				ent.TakeSound = Sound(data.sound1)
			end
			if data.sound2 and file.Exists("sound/"..data.sound2, "GAME") then
				ent.GiveSound = Sound(data.sound2)
			end
			return
		end

		local bank = ents.FindByClass("nz_bankteller")[1]
		if IsValid(bank) then return end

		nzMapping:SpawnBankTeller(tr.HitPos, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), ply, data)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		if IsValid(tr.Entity) and tr.Entity:GetClass() == "nz_bankteller" then
			tr.Entity:Remove()
			return
		end
	end,
	Reload = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ply) and IsValid(ent) and ent:GetClass() == "nz_bankteller" then
			if ply:KeyDown(IN_SPEED) then
				local ang = ent:GetAngles()
				ang:RotateAroundAxis(ent:GetForward(), ply:KeyDown(IN_DUCK) and 5 or 45)
				ent:SetAngles(ang)
			else
				local ang = ent:GetAngles()
				ang:RotateAroundAxis(ent:GetForward(), ply:KeyDown(IN_DUCK) and -5 or -45)
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
	displayname = "Bank Placer",
	desc = "LMB: Place Bank, RMB: Remove Bank",
	icon = "icon16/money.png",
	weight = 22,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local valz = {}
		valz["Row1"] = tonumber(data.fee)
		valz["Row2"] = tonumber(data.limit)
		valz["Row3"] = tobool(data.elec)
		valz["Row4"] = tostring(data.sound1)
		valz["Row5"] = tostring(data.sound2)
		valz["Row6"] = tostring(data.model)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize(500, 480)
		DProperties:SetPos(0, 0)

		function DProperties.CompileData()
			data.fee = tonumber(valz["Row1"])
			data.limit = tonumber(valz["Row2"])
			data.elec = tobool(valz["Row3"])
			data.sound1 = tostring(valz["Row4"])
			data.sound2 = tostring(valz["Row5"])
			data.model = tostring(valz["Row6"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "bankteller")
		end

		local Row1 = DProperties:CreateRow("Options", "Withdraw fee")
		local Row2 = DProperties:CreateRow("Options", "Deposit limit")
		local Row3 = DProperties:CreateRow("Options", "Require electricity")
		local Row4 = DProperties:CreateRow("Sound", "Deposit sound path")
		local Row5 = DProperties:CreateRow("Sound", "Withdraw sound path")
		local Row6 = DProperties:CreateRow("Model", "Model path")

		Row1:Setup("Int", { min = 0, max = 900 })
		Row1:SetValue(valz["Row1"])
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row1:SetToolTip("Fee taken when withdrawing points from the bank.")

		Row2:Setup("Int", { min = 1000, max = 30000 })
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val ) valz["Row2"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetToolTip("Maximum amount of points that can be deposited within the bank in total.")

		Row3:Setup("Boolean")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val ) valz["Row3"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetToolTip("Bank cannot be used until power is on.")

		Row4:Setup("Generic")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val ) valz["Row4"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetToolTip("Defaults to 'zmb/tranzit/bank/bank_deposit.wav'")

		Row5:Setup("Generic")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val ) valz["Row5"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row5:SetToolTip("Defaults to 'zmb/tranzit/bank/bank_withdraw.wav'")

		Row6:Setup("Generic")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val ) valz["Row6"] = val DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetToolTip("Defaults to 'models/zmb/bo2/tranzit/com_cash_register_gstation.mdl'")

		local color_red = Color(150, 50, 50)

		local textw = vgui.Create("DLabel", DProperties)
		textw:SetText("Press ["..string.upper(input.LookupBinding("+USE")).."] to deposit money into the Bank.")
		textw:SetFont("Trebuchet18")
		textw:SetTextColor(color_red)
		textw:SizeToContents()
		textw:SetPos(0, 195)
		textw:CenterHorizontal()

		local textw1 = vgui.Create("DLabel", DProperties)
		textw1:SetText("Hold ["..string.upper(input.LookupBinding("+SPEED")).."] & Press ["..string.upper(input.LookupBinding("+USE")).."] to withdraw money from the Bank.")
		textw1:SetFont("Trebuchet18")
		textw1:SetTextColor(color_red)
		textw1:SizeToContents()
		textw1:SetPos(0, 215)
		textw1:CenterHorizontal()

		local textw2 = vgui.Create("DLabel", DProperties)
		textw2:SetText("Bank is shared between all players and does not persist through games.")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(0, 235)
		textw2:CenterHorizontal()

		local Butn = DProperties:Add("DButton")
		Butn:SetText("print assets to console")
		Butn:SetPos(0, 255)
		Butn:SetSize(120, 30)
		Butn:CenterHorizontal()
		Butn.DoClick = function()
			print("-------------------------------------------")
			print("zmb/tranzit/bank/bank_deposit.wav")
			print("zmb/tranzit/bank/bank_withdraw.wav")
			print("-------------------------------------------")
			print("models/zmb/bo2/buried/zm_bu_cash_register.mdl")
			print("models/zmb/bo2/tranzit/zm_keys.mdl")
			print("models/zmb/bo2/tranzit/com_cash_register_gstation.mdl")
			print("-------------------------------------------")
		end

		return DProperties
	end,

	defaultdata = {
		fee = 100,
		limit = 30000,
		elec = false,
		sound1 = "zmb/tranzit/bank/bank_deposit.wav",
		sound2 = "zmb/tranzit/bank/bank_withdraw.wav",
		model = "models/zmb/bo2/tranzit/com_cash_register_gstation.mdl",
	},
})

if SERVER then
	nzMapping:AddSaveModule("BankTellerSpawns", {
		savefunc = function()
			local bank_spawns = {}
			for k, v in pairs(ents.FindByClass("nz_bankteller")) do
				table.insert(bank_spawns, {
					pos = v:GetPos(),
					angle = v:GetAngles(),
					tab = {
						fee = v:GetPointFee(),
						limit = v:GetPointLimit(),
						elec = v:GetElectric(),
						sound1 = v.TakeSound,
						sound2 = v.GiveSound,
						model = v:GetModel(),
					}
				})
			end

			return bank_spawns
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:SpawnBankTeller(v.pos, v.angle, nil, v.tab)
			end
		end,
		cleanents = {"nz_bankteller"}
	})

	hook.Add("OnRoundEnd", "NZ.Reset.Bank", function()
		if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
			for k, v in pairs(ents.FindByClass("nz_bankteller")) do
				v:Reset()
			end
		end

		for i=1, player.GetCount() do
			local ply = Entity(i)
			if not IsValid(ply) or not ply:IsPlayer() then continue end
			if ply:GetNW2Bool("nzBankDeposit", false) then
				ply:SetNW2Bool("nzBankDeposit", false)
			end
		end
	end)
end
