local mapscript = {}
mapscript.soulcatchers = {}

-- Zetsubō no shinden --

local keyobject = nzItemCarry:CreateCategory("pap_key")
keyobject:SetIcon("icon16/key.png")
keyobject:SetText("Press Use to pick up Key")
keyobject:SetDropOnDowned(false)
keyobject:SetResetFunction( function(self)
	local key = ents.Create("nz_prop_effect")
	key:SetModel("models/props/objectives/key_old.mdl")
	key:SetPos(Vector(-351.456, -1225.4622, -518.9122))
	key:SetAngles(Angle(20.6155, -170.8776, -4.7427))
	key:Spawn()
	self:RegisterEntity(key)
end)
keyobject:Update()

local pap_gate
local pap_lock
local skull_prop

function mapscript.RemoveSoulCatchers()
    for _,catcher in pairs(mapscript.soulcatchers) do
        if IsValid(catcher) then
            catcher:Remove()
        end
    end
end

local PaP = 0
function mapscript.SpawnSoulCatchers()
    mapscript.RemoveSoulCatchers()

    local positions = {
        Vector(1746.9918, 1228.7607, -468.0333),
        Vector(195.1973, -993.623, -187.8736),
        Vector(-3018.5505, 176.4828, -248.6905)
    }

    for _,pos in pairs(positions) do
        local collector = ents.Create("nz_script_soulcatcher")
        mapscript.soulcatchers[#mapscript.soulcatchers + 1] = collector


		collector:SetNWString("NZText", "The Skull demands sacrifices...")
        collector:SetPos(pos)
        collector:SetModel("models/Gibs/HGIBS.mdl")
        collector:Spawn()
        collector:SetTargetAmount(48)
        collector:SetRange(600)
		collector:SetReleaseOverride( function(self, z)
			if self.CurrentAmount >= self.TargetAmount then return end
			
			local e = EffectData()
			e:SetOrigin(self:GetPos())
			e:SetStart(z:GetPos())
			e:SetMagnitude(0.3)
			util.Effect("lightning_strike", e)
			self.CurrentAmount = self.CurrentAmount + 1
			self:CollectSoul()
		end)

        collector:SetCompleteFunction(function(self)
            PaP = PaP + 1
            if PaP == 3 then
                nzDoors:OpenLinkedDoors("keeper_skull")
	            nzNotifications:PlaySound("nz_moo/maps/templeofdespair/skulls_area_v1_mas2.mp3", 0) --This sound is global and everyone would hear it!
            end
            self:Remove()
        end)
    end 
end

--Buildtable 2

local kt4 = {
	[1] = { -- Gunbody
		{pos = Vector(-940.7678, 874.6311, -185.1617), ang = Angle(1.5399, 2.854, -50.4612)}, -- In the same room as it's buildable table.
	},
	[2] = { -- Vial
		{pos = Vector(536.2645, -1458.1903, -155.1342), ang = Angle(21.7392, -78.3027, 99.822)}, -- On a barrel next to SpeedCola
		{pos = Vector(-418.4221, -1322.0897, -181.573), ang = Angle(-0.0128, 45.0067, -90.0174)}, -- On a barrel next to Bomb Site B
	},
	[3] = { -- Fertilizer
		{pos = Vector(21.0858, 873.9038, -501.9681), ang = Angle(1.7781, -23.757, 2.3871)}, -- Along the same wall as the Spas/Gallo Wallbuy
		{pos = Vector(-753.1533, 62.154, -512.6804), ang = Angle(-1.8984, 76.6128, -0.1142)}, -- Along the same wall as Double Tap to the Right
	},
	[4] = { -- Fluids
		{pos = Vector(-2452.3, 87.568, -274.9564), ang = Angle(90, 90.0266, 180)}, -- Across from 3rd Skull Podium
		{pos = Vector(-2560.9648, -800.3007, -183.6882), ang = Angle(45, 44.9712, -90)}, -- On a barrel next to IronHide Wallbuy
	}
}

local kt4gunpart1 = nzItemCarry:CreateCategory("kt4gunpart1")
kt4gunpart1:SetIcon("spawnicons/models/weapons/tfa_bo3/mirg2000/w_mirg2000.png")
kt4gunpart1:SetText("Press Use to pick up Weapon frame")
kt4gunpart1:SetDropOnDowned(false)

kt4gunpart1:SetResetFunction( function(self)
	local poss = kt4[1]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/weapons/tfa_bo3/mirg2000/w_mirg2000.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
kt4gunpart1:Update()

local kt4gunpart2 = nzItemCarry:CreateCategory("kt4gunpart2")
kt4gunpart2:SetIcon("spawnicons/models/healthvial.png")
kt4gunpart2:SetText("Press Use to pick up Vial")
kt4gunpart2:SetDropOnDowned(false)

kt4gunpart2:SetResetFunction( function(self)
	local poss = kt4[2]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/healthvial.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
kt4gunpart2:Update()

local kt4gunpart3 = nzItemCarry:CreateCategory("kt4gunpart3")
kt4gunpart3:SetIcon("spawnicons/models/props_lab/crematorcase.png")
kt4gunpart3:SetText("Press E to pick up Plant Fertilizer")
kt4gunpart3:SetDropOnDowned(false)

kt4gunpart3:SetResetFunction( function(self)
	local poss = kt4[3]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/props_lab/crematorcase.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
kt4gunpart3:Update()

local kt4gunpart4 = nzItemCarry:CreateCategory("kt4gunpart4")
kt4gunpart4:SetIcon("spawnicons/models/props/army/glowstick.png")
kt4gunpart4:SetText("Press Use to pick up Fluids")
kt4gunpart4:SetDropOnDowned(false)

kt4gunpart4:SetResetFunction( function(self)
	local poss = kt4[4]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/props/army/glowstick.mdl") -- This is actually a rp_necro_junction model... FUCKING CHANGE IT!!!
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
kt4gunpart4:Update()

local buildabletbl2 = {
	model = "models/weapons/tfa_bo3/mirg2000/w_mirg2000.mdl", -- Buildable model path
	pos = Vector(0, 0, 50), -- (Relative to table's own pos)
	ang = Angle(0, 90, 0), -- (Relative too)
	parts = {
		["kt4gunpart1"] = {0,1}, -- Submaterials to "unhide" when this part is added
		["kt4gunpart2"] = {2}, -- id's are ItemCarry object IDs
		["kt4gunpart3"] = {3},
		["kt4gunpart4"] = {4},
		-- You can have as many as you want
	},
	usefunc = function(self, ply) -- When it's completed and a player presses E (optional)
		if not ply:HasWeapon("tfa_bo3_mirg2000") then
			ply:Give("tfa_bo3_mirg2000")
			nzNotifications:PlaySound("nz_moo/maps/templeofdespair/lab_a_v1_mas.mp3", 0)
			self:Remove()
		end
	end,
	text = "Press Use to Take KT4(Only one person can take it!)"
}

function mapscript.OnGameBegin()

	nzNotifications:PlaySound("nz_moo/maps/templeofdespair/outside_underscore_v2_mas.mp3", 0)

    mapscript.SpawnSoulCatchers()

	local tbl2 = ents.Create("buildable_table")
	tbl2:AddValidCraft("KT4", buildabletbl2)
	tbl2:SetPos(Vector(-1122.1146, 221.1057, -191.9688))
	tbl2:SetAngles(Angle(0, 0, 0))
	tbl2:Spawn()

	keyobject:Reset()
	
	pap_gate = ents.Create("nz_script_prop")
	pap_gate:SetModel("models/props_c17/gate_door02a.mdl")
	pap_gate:SetPos(Vector(-798.7649, 708.2723, -138.4491))
	pap_gate:SetAngles(Angle(0, 0, 0))
	pap_gate:Spawn()
	
	pap_lock = ents.Create("nz_script_prop")
	pap_lock:SetModel("models/props_wasteland/prison_padlock001a.mdl")
	pap_lock:SetPos(Vector(-798.8436, 726.1462, -150.9067))
	pap_lock:SetAngles(Angle(3.1083, 76.5662, 2.7951))
	pap_lock:SetNWString("NZText", "This door appears to be locked...")
	pap_lock:SetNWString("NZRequiredItem", "pap_key")
	pap_lock:SetNWString("NZHasText", "Press Use to Unlock")
	pap_lock.OnUsed = function(self, ply)
		if ply:HasCarryItem("pap_key") then
			ply:RemoveCarryItem("pap_key")
			pap_gate:EmitSound("doors/door_chainlink_close1.wav", 100)
			pap_gate:Remove()
			pap_lock:Remove()
		end
	end
	pap_lock:Spawn()

	skull_prop = ents.Create("nz_script_prop")
	skull_prop:SetModel("models/weapons/tfa_bo3/skullgun/w_skullgun.mdl")
	skull_prop:SetPos(Vector(-1087.5808, -947.0298, -179.1641))
	skull_prop:SetAngles(Angle(0, 89.9657, 0))
	skull_prop:SetNWString("NZText", "Press Use for Skull of Nan Sapwe(Replaces current Gun!")
	skull_prop.OnUsed = function(self, ply)
		if not ply:HasWeapon("tfa_bo3_skullgun") then
			ply:Give("tfa_bo3_skullgun")
		end
	end
	skull_prop:Spawn()

	kt4gunpart1:Reset()
	kt4gunpart2:Reset()
	kt4gunpart3:Reset()
	kt4gunpart4:Reset()

end

--PrintMessage( HUD_PRINTTALK, "Updated Version 1.1" )

hook.Add("OnRoundStart", "nZunderscore", function()

end)

function mapscript.ScriptUnload()
    mapscript.RemoveSoulCatchers()
end

function mapscript.PostCleanupMap()
    mapscript.RemoveSoulCatchers()
end

-- Always return the mapscript table. This gives it on to the gamemode so it can use it.
return mapscript