local white = Color(100,0,200,30)
local point1, point2, height

if SERVER then
	util.AddNetworkString("nz_DamageIgnoreWall")
	
	net.Receive("nz_DamageIgnoreWall", function(len, ply)
		if !ply:IsInCreative() then return end
		local vec1 = net.ReadVector()
		local vec2 = net.ReadVector()

		local tooldata = ply.NZToolData
		local data = {
			dmg1 = tooldata.dmg1,
			dmg2 = tooldata.dmg2,
			dmg3 = tooldata.dmg3,
		}
		nzMapping:CreateDamageIgnoreWall(vec1, vec2, data, ply)
	end)
end

nzTools:CreateTool("damageignorewall", {
	displayname = "Damage Ignore Trigger",
	desc = "LMB: Set Corners, RMB: Remove Invisible Wall at spot, R: Reset corners",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local walls = ents.FindInSphere(tr.HitPos, 5)
		for k, v in pairs(walls) do
			if v:GetClass() == "damage_ignore_wall" then v:Remove() end
		end
	end,
	Reload = function(wep, ply, tr, data)

	end,
	OnEquip = function(wep, ply, data)

	end,
	OnHolster = function(wep, ply, data)

	end
}, {
	displayname = "Damage Ignore Trigger",
	desc = "LMB: Set Corners, RMB: Remove Trigger at spot, R: Reset corners",
	icon = "icon16/shape_handles.png",
	weight = 16,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local pos = tr.HitPos
		if !pos then return end
		
		if !point1 then
			point1 = pos
		elseif !point2 then
			point2 = Vector(pos.x - point1.x, pos.y - point1.y, point1.z)
		elseif !height then
			height = pos.z - point1.z
			net.Start("nz_DamageIgnoreWall")
				net.WriteVector(point1)
				net.WriteVector(Vector(point2.x, point2.y, height))
			net.SendToServer()
			point1 = nil
			point2 = nil
			height = nil
		end
	end,
	Reload = function()
		point1 = nil
		point2 = nil
		height = nil
	end,
	interface = function(frame, data)
		local pnl = vgui.Create("DPanel", frame)
		pnl:Dock(FILL)

		local valz = {}
		valz["dmg1"] = tonumber(data.dmg1)
		valz["dmg2"] = tonumber(data.dmg2)
		valz["dmg3"] = tonumber(data.dmg3)

		function pnl.CompileData()
			data.dmg1 = tonumber(valz["dmg1"])
			data.dmg2 = tonumber(valz["dmg2"])
			data.dmg3 = tonumber(valz["dmg3"])
			return data
		end

		function pnl.UpdateData(data)
			nzTools:SendData(data, "damageignorewall")
		end

		local chk = vgui.Create("DCheckBoxLabel", pnl)
		chk:SetPos( 100, 20 )
		chk:SetText( "Preview Config" )
		chk:SetTextColor( Color(50,50,50) )
		chk:SetConVar( "nz_creative_preview" )
		chk:SetValue( GetConVar("nz_creative_preview"):GetBool() )
		chk:SizeToContents()

		local properties = vgui.Create("DProperties", pnl)
		properties:SetPos(5, 50)
		properties:SetSize(480, 450)

		local thetypes = {
			["Generic"] = 0,
			["Crush"] = 1,
			["Bullet"] = 2,
			["Slash"] = 4,
			["Burn"] = 8,
			["Vehicle"] = 16,
			["Fall"] = 32,
			["Blast"] = 64,
			["Club"] = 128,
			["Shock"] = 256,
			["Sonic"] = 512,
			["Energybeam"] = 1024,
			["NeverGib"] = 4096,
			["AlwaysGib"] = 8192,
			["Drown"] = 16384,
			["Paralyze"] = 32768,
			["Nervegas"] = 65536,
			["Poison"] = 131072,
			["Radiation"] = 262144,
			["DrownRecover"] = 524288,
			["Acid"] = 1048576,
			["Slowburn"] = 2097152,
			["Physgun"] = 8388608,
			["Plasma"] = 16777216,
			["Airboat"] = 33554432,
			["Dissolve"] = 67108864,
			["BlastSurface"] = 134217728,
			["Direct"] = 268435456,
			["Buckshot"] = 536870912,
			["Sniper"] = 1073741824,
			["MissileDefense"] = 2147483648,
		}

		local dmgtype1 = properties:CreateRow( "Options", "Damage Type 1" )
		dmgtype1:Setup("Combo", {text = "Select type ..."})
		for k, v in pairs(thetypes) do
			dmgtype1:AddChoice(k, v, valz["dmg1"] == v)
		end
		dmgtype1.DataChanged = function( _, val ) valz["dmg1"] = val pnl.UpdateData(pnl.CompileData()) end

		local dmgtype2 = properties:CreateRow( "Options", "Damage Type 2" )
		dmgtype2:Setup("Combo", {text = "Select type ..."})
		for k, v in pairs(thetypes) do
			dmgtype2:AddChoice(k, v, valz["dmg2"] == v)
		end
		dmgtype2.DataChanged = function( _, val ) valz["dmg2"] = val pnl.UpdateData(pnl.CompileData()) end

		local dmgtype3 = properties:CreateRow( "Options", "Damage Type 3" )
		dmgtype3:Setup("Combo", {text = "Select type ..."})
		for k, v in pairs(thetypes) do
			dmgtype3:AddChoice(k, v, valz["dmg3"] == v)
		end
		dmgtype3.DataChanged = function( _, val ) valz["dmg3"] = val pnl.UpdateData(pnl.CompileData()) end

		local color_red = Color(150, 50, 50)

		local textw1 = vgui.Create("DLabel", pnl)
		textw1:SetText("When creating a fall damage trigger for very tall maps")
		textw1:SetFont("Trebuchet18")
		textw1:SetTextColor(color_red)
		textw1:SizeToContents()
		textw1:SetPos(50, 160)
		//textw1:CenterHorizontal()

		local textw2 = vgui.Create("DLabel", pnl)
		textw2:SetText("The box should be at least half the height of the player for best results")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor(color_red)
		textw2:SizeToContents()
		textw2:SetPos(50, 180)
		//textw2:CenterHorizontal()

		return pnl
	end,
	defaultdata = {
		dmg1 = 32,
		dmg2 = 32,
		dmg3 = 32,
	},
	drawhud = function()
		cam.Start3D()
			render.SetColorMaterial()
			local x = point1 or nil
			local y
			if x then
				if point2 then
					if height then
						y = Vector(point2.x, point2.y, height)
					else
						y = Vector(point2.x, point2.y, LocalPlayer():GetEyeTrace().HitPos.z - point1.z)
					end
				else
					y = Vector(LocalPlayer():GetEyeTrace().HitPos.x - point1.x, LocalPlayer():GetEyeTrace().HitPos.y - point1.y, 0)
				end
			end
			if x and y then
				render.DrawBox(x, Angle(0,0,0), Vector(0,0,0), y, white, true)
			end
		cam.End3D()
	end,
})

if SERVER then
	nzMapping:AddSaveModule("DamageIgnoreWalls", {
		savefunc = function()
			local wallsz = {}
			for k, v in pairs(ents.FindByClass("damage_ignore_wall")) do
				table.insert(wallsz, {
					pos = v:GetPos(),
					maxbound = v:GetMaxBound(),
					tab = {
						dmg1 = v:GetDamage(),
						dmg2 = v:GetDamage2(),
						dmg3 = v:GetDamage3(),
					}
				})
			end

			return wallsz
		end,
		loadfunc = function(data)
			for k, v in pairs(data) do
				nzMapping:CreateDamageIgnoreWall(v.pos, v.maxbound, v.tab, nil)
			end
		end,
		cleanents = {"damage_ignore_wall"}
	})
end
