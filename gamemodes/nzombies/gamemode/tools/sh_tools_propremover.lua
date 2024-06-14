-- ENHANCED PROP REMOVER by jenwalter666#5947

if SERVER then
	if !nzMapping then nzMapping = {} end
	
	function nzMapping:MarkEntity(id)
		if nzRound:InState(ROUND_CREATE) then
			local k = ents.GetMapCreatedEntity(id)
			if IsValid(k) and k != Entity(0) then
				if !nzMapping.MarkedProps[id] then
					PrintMessage(HUD_PRINTTALK, "Marked map entity #" .. id .." ["..k:GetClass()..", Index " .. k:EntIndex() .. "] for removal")
					k:SetColor(Color(200,0,0))
					nzMapping.MarkedProps[id] = true
				end
			end
		end
	end
	function nzMapping:UnmarkEntity(id)
		if nzRound:InState(ROUND_CREATE) then
			local k = ents.GetMapCreatedEntity(id)
			if IsValid(k) and k != Entity(0) then
				if nzMapping.MarkedProps[id] then
					PrintMessage(HUD_PRINTTALK, "Unmarked map entity #" .. id .." ["..k:GetClass()..", Index " .. k:EntIndex() .. "] for removal")
					k:SetColor(Color(255,255,255))
					nzMapping.MarkedProps[id] = nil
				end
			end
		end
	end
	concommand.Add("nz_mapents", function(ply, cmd, args)
		if ply:IsInCreative() then
			local filter = tonumber(args[1]) or 0
			for k, v in pairs(ents.GetAll()) do
				if IsValid(v) then
					local id = v:MapCreationID()
					if id > -1 then
						if filter == 0 or (filter == 1 and !nzMapping.MarkedProps[id]) or (filter == 2 and nzMapping.MarkedProps[id]) then
							ply:PrintMessage(HUD_PRINTCONSOLE, "ID " .. v:MapCreationID() .. " : " .. v:GetClass() .. (filter != 0 and "" or (" : " .. (nzMapping.MarkedProps[id] and " Marked" or " Not marked"))) .. " : Index " .. v:EntIndex())
						end
					end
				end
			end
		end
	end)
	concommand.Add("nz_mark", function(ply, cmd, args)
		if ply:IsInCreative() then
			if !tostring(args[1]) and !tonumber(args[1]) then return end
			local id = tonumber(args[1])
			if id then
				local target = ents.GetMapCreatedEntity(id)
				if IsValid(target) then
					nzMapping:MarkEntity(id)
				end
			else
				for k, v in pairs(ents.FindByClass(string.lower(tostring(args[1])))) do
					if IsValid(v) and v:MapCreationID() > -1 then nzMapping:MarkEntity(v:MapCreationID()) end
				end
			end
		end
	end)
	concommand.Add("nz_unmark", function(ply, cmd, args)
		if ply:IsInCreative() then
			if !tostring(args[1]) and !tonumber(args[1]) then return end
			local id = tonumber(args[1])
			if id then
				local target = ents.GetMapCreatedEntity(id)
				if IsValid(target) then
					nzMapping:UnmarkEntity(id)
				end
			else
				for k, v in pairs(ents.FindByClass(string.lower(tostring(args[1])))) do
					if IsValid(v) and v:MapCreationID() > -1 then nzMapping:UnmarkEntity(v:MapCreationID()) end
				end
			end
		end
	end)
	util.AddNetworkString("nzPropRemoverSearch")
	
	net.Receive("nzPropRemoverSearch", function(len, ply)
		if ply:IsInCreative() then
			local tbl = net.ReadTable()
			for k,v in pairs(tbl) do
				local id = k:MapCreationID()
				if IsValid(k) and k != Entity(0) and id != -1 then
					if v and !nzMapping.MarkedProps[id] then
						nzMapping:MarkEntity(id)
					elseif !v and nzMapping.MarkedProps[id] then
						nzMapping:UnmarkEntity(id)
					end
				end
			end
		end
	end)
else

	local function CreateWindowEntityList()
		local tbl = net.ReadTable()
		local tbl2 = net.ReadTable()
		
		local frame = vgui.Create("DFrame")
		frame:SetSize(ScrW()/2, ScrH()/2)
		frame:SetTitle("Mark entities for removal")
		frame:Center()
		frame:MakePopup()
		
		local entlist = vgui.Create("DScrollPanel", frame)
		entlist:SetPos(10, 30)
		entlist:SetSize(ScrW()/2 - 20, ScrH() / 2 - 100)
		entlist:SetPaintBackground(true)
		entlist:SetBackgroundColor( Color(200, 200, 200) )
		
		local entchecklist = vgui.Create( "DIconLayout", entlist )
		entchecklist:SetSize(ScrW()/2 - 30, ScrH() / 2 - 100)
		entchecklist:SetPos( 5, 5 )
		entchecklist:SetSpaceY( 5 )
		entchecklist:SetSpaceX( 5 )
		
		for k,v in pairs(tbl) do
			if IsValid(k) then
				local entity = entchecklist:Add( "DPanel" )
				entity:SetSize((ScrW()/2 - 30)/6 - 5, 20 )
				
				local check = entity:Add("DCheckBox")
				check:SetPos(2,2)
				check:SetValue(v)
				check.OnChange = function(self, val)
					tbl[k] = val
				end
				check:SetTooltip(tostring(tbl2[k] or k))
				
				local name = entity:Add("DLabel")
				name:SetTextColor(Color(50,50,50))
				name:SetSize((ScrW()/2 - 30)/6 - 5, 20)
				name:SetPos(20,1)
				name:SetText(k:EntIndex() .. ":" .. tostring(tbl2[k] or k:GetClass()))
				name:SetTooltip(tostring(tbl2[k] or k))
			end
		end
		
		local submit4 = vgui.Create("DTextEntry", frame)
		
		local submit = vgui.Create("DButton", frame)
		submit:SetSize((ScrW()/2 - 30)/3 - 10, 60)
		submit:SetText("Submit")
		submit:SetPos(10, ScrH() / 2 - 65)
		submit.DoClick = function(self)
			net.Start("nzPropRemoverSearch")
				net.WriteTable(tbl)
			net.SendToServer()
		end
		
		local submit2 = vgui.Create("DButton", frame)
		submit2:SetSize((ScrW()/2 - 30)/3, 30)
		submit2:SetText("Mark all entities")
		submit2:SetPos((ScrW()/2 - 30)/3 + 5, ScrH() / 2 - 65)
		submit2.DoClick = function(self)
			local search = string.lower(submit4:GetValue() or "")
			for k, v in pairs(tbl) do
				if IsValid(k) then
					if search == "" or search == tostring(tbl2[k]) or search == k:GetClass() then
						tbl[k] = true
					end
				end
			end
			net.Start("nzPropRemoverSearch")
				net.WriteTable(tbl)
			net.SendToServer()
		end
		
		local submit3 = vgui.Create("DButton", frame)
		submit3:SetSize((ScrW()/2 - 30)/3 + 10, 30)
		submit3:SetText("Unmark all entities")
		submit3:SetPos((ScrW()/2 - 30)/3 * 2 + 10, ScrH() / 2 - 65)
		submit3.DoClick = function(self)
			local search = string.lower(submit4:GetValue() or "")
			for k, v in pairs(tbl) do
				if IsValid(k) then
					if search == "" or search == tostring(tbl2[k]) or search == k:GetClass() then
						tbl[k] = false
					end
				end
			end
			net.Start("nzPropRemoverSearch")
				net.WriteTable(tbl)
			net.SendToServer()
		end
		submit4:SetSize((((ScrW()/2 - 30)/3) * 2) + 15, 20)
		submit4:SetPlaceholderText("Class name to mark/unmark...")
		submit4:SetPos((ScrW()/2 - 30)/3 + 5, ScrH() / 2 - 25)
		submit4.OnChange = function()
			if submit4:GetValue() == "" then
				submit2:SetText("Mark all entities")
				submit3:SetText("Unmark all entities")
			else
				submit2:SetText("Mark entities of matching class")
				submit3:SetText("Unmark entities of matching class")
			end
		end
	end
	net.Receive("nzPropRemoverSearch", CreateWindowEntityList)

end

local searchradius = CreateConVar("nz_creative_propremover_radius", 500, bit.bor(FCVAR_ARCHIVE, FCVAR_REPLICATED), "Search radius of the prop remover's reload function, in inches.", 1)

nzTools:CreateTool("propremover", {
	displayname = "Prop Remover Tool",
	desc = "[LMB] Mark : [RMB] Unmark : [R] Search (" .. string.Comma(searchradius:GetInt()) .. " in. radius) : [CTRL+R] Search All",
	condition = function(wep, ply)
		return true
	end,
	PrimaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		local id = ent:MapCreationID()
		nzMapping:MarkEntity(id)
	end,
	SecondaryAttack = function(wep, ply, tr, data)
		local ent = tr.Entity
		local id = ent:MapCreationID()
		nzMapping:UnmarkEntity(id)
	end,
	Reload = function(wep, ply, tr, data)
		local tbl = ply:KeyDown(IN_DUCK) and ents.GetAll() or ents.FindInSphere(tr.HitPos, searchradius:GetInt())
		local send = {}
		local names = {}
		for k,v in ipairs(tbl) do
			if IsValid(v) then
				local id = v:MapCreationID()
				if IsValid(v) and v != Entity(0) and id != -1 and string.sub(v:GetClass(), 1, 5) != "class" then
					send[v] = nzMapping.MarkedProps[id] or false
					names[v] = v:GetClass()
				end
			end
		end
		net.Start("nzPropRemoverSearch")
			net.WriteTable(send)
			net.WriteTable(names)
		net.Send(ply)
	end,
	OnEquip = function(wep, ply, data)
	end,
	OnHolster = function(wep, ply, data)
	end
}, {
	displayname = "Prop Remover Tool",
	desc = "[LMB] Mark : [RMB] Unmark : [R] Search (" .. string.Comma(searchradius:GetInt()) .. " in. radius) : [CTRL+R] Search All",
	icon = "icon16/cancel.png",
	weight = 35,
	condition = function(wep, ply)
		return true
	end,
	interface = function(frame, data)
		local panel = vgui.Create("DPanel", frame)
		panel:SetSize(frame:GetSize())

		local textw = vgui.Create("DLabel", panel)
		textw:SetText("This tool marks props to be removed in-game.")
		textw:SetFont("Trebuchet18")
		textw:SetTextColor( Color(50, 50, 50) )
		textw:SizeToContents()
		textw:SetPos(0, 80)
		textw:CenterHorizontal()

		local textw2 = vgui.Create("DLabel", panel)
		textw2:SetText("It will only apply once a game begins")
		textw2:SetFont("Trebuchet18")
		textw2:SetTextColor( Color(50, 50, 50) )
		textw2:SizeToContents()
		textw2:SetPos(0, 100)
		textw2:CenterHorizontal()

		local textw3 = vgui.Create("DLabel", panel)
		textw3:SetText("and will reset when entering Creative Mode.")
		textw3:SetFont("Trebuchet18")
		textw3:SetTextColor( Color(50, 50, 50) )
		textw3:SizeToContents()
		textw3:SetPos(0, 110)
		textw3:CenterHorizontal()

		return panel
	end
})
