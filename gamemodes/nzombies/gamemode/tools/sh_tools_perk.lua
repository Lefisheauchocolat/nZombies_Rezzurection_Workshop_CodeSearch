nzTools:CreateTool("perk", {
	displayname = "Perk Machine Placer",
	desc = "LMB: Place Perk Machine, RMB: Remove Perk Machine, C: Change Perk",
	condition = function(wep, ply)
		return true
	end,

	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "perk_machine" or ent:GetClass() == "wunderfizz_machine" then
			nzMapping:PerkMachine(ent:GetPos(), ent:GetAngles(), data, ply) -- Hitting a perk, replace it
			ent:Remove()
		else
			nzMapping:PerkMachine(tr.HitPos, Angle(0,(ply:GetPos() - tr.HitPos):Angle()[2],0), data, ply)
		end
	end,

	SecondaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		if IsValid(ent) and ent:GetClass() == "perk_machine" or ent:GetClass() == "wunderfizz_machine" then
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
	displayname = "Perk Machine Placer",
	desc = "LMB: Place Perk Machine, RMB: Remove Perk Machine, C: Change Perk",
	icon = "icon16/drink.png",
	weight = 6,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data, context)
		local valz = {}
		valz["Row1"] = tostring(data.id)
		valz["Row2"] = tobool(data.random)
		valz["Row3"] = tobool(data.fizzlist)
		valz["Row4"] = tobool(data.randomround)
		valz["Row5"] = tonumber(data.roundnum)
		valz["Row6"] = tobool(data.door)
		valz["Row7"] = tostring(data.doorflag)
		valz["Row8"] = tostring(data.doorflag2)
		valz["Row9"] = tostring(data.doorflag3)

		local DProperties = vgui.Create( "DProperties", frame )
		DProperties:SetSize( 500, 480 )
		DProperties:SetPos( 0, 0 )

		function DProperties.CompileData()
			data.id = tostring(valz["Row1"])
			data.random = tobool(valz["Row2"])
			data.fizzlist = tobool(valz["Row3"])
			data.randomround = tobool(valz["Row4"])
			data.roundnum = tonumber(valz["Row5"])
			data.door = tobool(valz["Row6"])
			data.doorflag = tostring(valz["Row7"])
			data.doorflag2 = tostring(valz["Row8"])
			data.doorflag3 = tostring(valz["Row9"])

			return data
		end

		function DProperties.UpdateData(data)
			nzTools:SendData(data, "perk")
		end

		local Row1 = DProperties:CreateRow("Settings", "Perk")
		Row1:Setup( "Combo" )
		Row1:SetPos( 10, 10 )
		Row1:SetSize( 450, 30 )
		for k, v in pairs(nzPerks:GetList()) do
			Row1:AddChoice(v, k, k == valz["Row1"])
		end
		Row1.DataChanged = function( _, val ) valz["Row1"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row2 = DProperties:CreateRow("Settings", "Randomize Perk")
		Row2:Setup("Boolean")
		Row2:SetValue(valz["Row2"])
		Row2.DataChanged = function( _, val) valz["Row2"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row2:SetTooltip("Enable for perk machine to randomize on game start (Default Off).")

		local Row3 = DProperties:CreateRow("Settings", "Randomization Uses Wunderfizz List")
		Row3:Setup("Boolean")
		Row3:SetValue(valz["Row3"])
		Row3.DataChanged = function( _, val) valz["Row3"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row3:SetTooltip("Enable for perk machine to use wunderfizz list instead of randomizing with other machines on the map (Default Off).")

		local Row4 = DProperties:CreateRow("Round Settings", "Randomize On Round Start")
		Row4:Setup("Boolean")
		Row4:SetValue(valz["Row4"])
		Row4.DataChanged = function( _, val) valz["Row4"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row4:SetTooltip("Enable for perk machine to randomize every x amount of rounds (Default Off).")

		local Row5 = DProperties:CreateRow("Round Settings", "Round Interval")
		Row5:Setup("Generic")
		Row5:SetValue(valz["Row5"])
		Row5.DataChanged = function( _, val) valz["Row5"] = math.max(tonumber(val), 1) DProperties.UpdateData(DProperties.CompileData()) end

		local Row6 = DProperties:CreateRow("Door Settings", "Reveal On Door Open")
		Row6:Setup("Boolean")
		Row6:SetValue(valz["Row6"])
		Row6.DataChanged = function( _, val) valz["Row6"] = tobool(val) DProperties.UpdateData(DProperties.CompileData()) end
		Row6:SetTooltip("Enable for perk machine to reveal when door is opened (Default Off).")

		local Row7 = DProperties:CreateRow("Door Settings", "Door Flag")
		Row7:Setup("Generic")
		Row7:SetValue(valz["Row7"])
		Row7.DataChanged = function( _, val) valz["Row7"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row8 = DProperties:CreateRow("Door Settings", "Door Flag 2")
		Row8:Setup("Generic")
		Row8:SetValue(valz["Row8"])
		Row8.DataChanged = function( _, val) valz["Row8"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local Row9 = DProperties:CreateRow("Door Settings", "Door Flag 3")
		Row9:Setup("Generic")
		Row9:SetValue(valz["Row9"])
		Row9.DataChanged = function( _, val) valz["Row9"] = val DProperties.UpdateData(DProperties.CompileData()) end

		local color_red = Color(150, 50, 50)

		local textw1 = vgui.Create("DLabel", DProperties)
		textw1:SetText("There must be at least 2 perk machines with 'randomize' enabled for it to work.")
		textw1:SetFont("Trebuchet18")
		textw1:SetTextColor(color_red)
		textw1:SizeToContents()
		textw1:SetPos(0, 280)
		textw1:CenterHorizontal()

		local textw2 = vgui.Create("DLabel", DProperties)
		textw2:SetText("Map Setting PaP randomization overrides PaP machines with the 'randomize' bool.")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(0, 300)
		textw2:CenterHorizontal()

		local textw3 = vgui.Create("DLabel", DProperties)
		textw3:SetText("Randomizing perks are not require to be tied to a door.")
		textw3:SetFont("Trebuchet18")
		textw3:SetTextColor(color_red)
		textw3:SizeToContents()
		textw3:SetPos(0, 320)
		textw3:CenterHorizontal()

		local textw4 = vgui.Create("DLabel", DProperties)
		textw4:SetText("Perks hidden behind a door are not required to be randomized.")
		textw4:SetFont("Trebuchet18")
		textw4:SetTextColor(color_red)
		textw4:SizeToContents()
		textw4:SetPos(0, 340)
		textw4:CenterHorizontal()

		local textw5 = vgui.Create("DLabel", DProperties)
		textw5:SetText("Only perks with the same round randomize interval will swap with eachother.")
		textw5:SetFont("Trebuchet18")
		textw5:SetTextColor(color_red)
		textw5:SizeToContents()
		textw5:SetPos(0, 360)
		textw5:CenterHorizontal()

		local textw6 = vgui.Create("DLabel", DProperties)
		textw6:SetText("Randomizing perks not tied to a door will still randomize,")
		textw6:SetFont("Trebuchet18")
		textw6:SetTextColor(color_red)
		textw6:SizeToContents()
		textw6:SetPos(0, 380)
		textw6:CenterHorizontal()

		local textw7 = vgui.Create("DLabel", DProperties)
		textw7:SetText("with other perks that are locked behind a door!")
		textw7:SetFont("Trebuchet18")
		textw7:SetTextColor(color_red)
		textw7:SizeToContents()
		textw7:SetPos(0, 400)
		textw7:CenterHorizontal()

		local textw8 = vgui.Create("DLabel", DProperties)
		textw8:SetText("Randomized perk machines that use the wunderfizz list are seperate.")
		textw8:SetFont("Trebuchet18")
		textw8:SetTextColor(color_red)
		textw8:SizeToContents()
		textw8:SetPos(0, 420)
		textw8:CenterHorizontal()

		return DProperties
	end,
	defaultdata = {
		id = "jugg",
		random = false,
		fizzlist = false,
		randomround = false,
		roundnum = 2,
		door = false,
		doorflag = "",
		doorflag2 = "",
		doorflag3 = "",
	},
})

nzTools:EnableProperties("perk", "Edit Perk...", "icon16/tag_blue_edit.png", 9005, true, function( self, ent, ply )
	if ( !IsValid( ent ) or !IsValid(ply) ) then return false end
	if ( ent:GetClass() != "perk_machine" ) then return false end
	if !nzRound:InState( ROUND_CREATE ) then return false end
	if ( ent:IsPlayer() ) then return false end
	if ( !ply:IsInCreative() ) then return false end

	return true

end, function(ent)
	return {
		id = ent:GetPerkID()
	}
end)

if SERVER then
	hook.Add("OnGameBegin", "nz.PerkMachineRolling", function()
		timer.Simple(0, function()
			local machines = ents.FindByClass("perk_machine")
			if nzMapping.Settings.randompap then
				for k, v in pairs(machines) do
					if v:GetPerkID() == "pap" then
						v:SetSelected(false)
					end
				end

				for k, v in RandomPairs(machines) do
					if v:GetPerkID() == "pap" and !v:GetSelected() then
						v:SetSelected(true)
						if (!v.HideBehindDoor or v.DoorRevealed) then
							v:ShowMachine()
						end
						break
					end
				end
			end

			for _, v in pairs(machines) do
				if v.HideBehindDoor then
					v:HideMachine()
					continue
				end
				if v.Randomize then
					v:StartRolling()
				end
			end
		end)
	end)

	hook.Add("OnRoundPreparation", "nz.PerkMachineRolling", function(round)
		local machines = ents.FindByClass("perk_machine")
		if round <= 1 then return end

		if nzMapping.Settings.randompap and nzMapping.Settings.randompapinterval > 0 and round%(nzMapping.Settings.randompapinterval) == 0 then
			for k, v in pairs(machines) do
				if v:GetSelected() then
					nzPerks.LastPaPMachine = v
					v.MarkedForRemoval = true
				end
			end

			for k, v in RandomPairs(machines) do
				if v:GetPerkID() == "pap" then
					if nzPerks.LastPaPMachine and nzPerks.LastPaPMachine == v then continue end

					v:SetSelected(true)

					ParticleEffect("driese_tp_arrival_phase2", v:GetPos(), Angle(0,0,0))
					v:EmitSound("amb/weather/lightning/lightning_flash_0"..math.random(0,3)..".wav", 511, 100, 1, CHAN_STATIC)

					if (!v.HideBehindDoor or v.DoorRevealed) then
						v:ShowMachine()
					end
					break
				end
			end
		end

		for k, v in pairs(machines) do
			if v.Randomize and (!v.HideBehindDoor or v.DoorRevealed) and v.RandomizeRoundStart and v.RandomizeRoundInterval then
				if round%(v.RandomizeRoundInterval) == 0 and round ~= 1 then
					v:StartRolling(true)
				end
			end
		end
	end)

	hook.Add("OnDoorUnlocked", "NZ.PerkMachineRolling", function(ent, link, rebuyable, ply)
		for _, v in pairs(ents.FindByClass("perk_machine")) do
			if v.HideBehindDoor and !v.DoorRevealed then
				local door_flags = {}
				if v.DoorFlag then
					door_flags[v.DoorFlag] = true
				end
				if v.DoorFlag2 then
					door_flags[v.DoorFlag2] = true
				end
				if v.DoorFlag3 then
					door_flags[v.DoorFlag3] = true
				end

				if door_flags[tostring(link)] then
					if v:GetPerkID() == "pap" then
						if nzMapping.Settings.randompap and (nzPowerUps:IsPowerupActive("bonfiresale") or v:GetSelected()) then
							v:ShowMachine(true)
						else
							v.DoorRevealed = true
						end
					else
						v:ShowMachine(true)
					end

					if v.Randomize then
						v:StartRolling()
					end
				end
			end
		end
	end)

	hook.Add("OnRoundInit", "nz.PerkMachineRolling", function()
		for _, v in pairs(ents.FindByClass("perk_machine")) do
			v:Reset()
		end
	end)

	hook.Add("OnRoundEnd", "nz.PerkMachineRolling", function()
		nzPerks.LastPaPMachine = nil
		for _, v in pairs(ents.FindByClass("perk_machine")) do
			v:Reset()
		end
	end)
end
