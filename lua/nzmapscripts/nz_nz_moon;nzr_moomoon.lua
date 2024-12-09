local mapscript = {}
 
local zombies = ents.FindByClass( "nz_zombie_walker" )
local earth_arrive = ents.FindByName("earth_door_trig")[1] -- trigger_gravity
local moon_arrive = ents.FindByName("moon_arrive_trg")[1] -- trigger_gravity
 
local soultube1 = ents.FindByName("soul1")[1]
soultube1:SetNWInt("MPDTubes", 0)
 
richtofen = player.GetHumans()[1]
dempsey = player.GetHumans()[2]
nikolai = player.GetHumans()[3]
takeo = player.GetHumans()[4]
 
local rod1 = nzItemCarry:CreateCategory("goldenrod1")
rod1:SetModel("models/props_boz/golden_rod.mdl")
rod1:SetDropOnDowned(false)

local hackerlocations = {
	{pos = Vector(-2855, 2001, -172.8), ang = Angle(90, 130, 0)},
	{pos = Vector(-2448, 1466, -181.7), ang = Angle(90,325,0)},
	{pos = Vector(-1841, 2306, -339.7), ang = Angle(90,205,0)},
	{pos = Vector(-1307, 1982, -339.7), ang = Angle(90,78,0)},
	{pos = Vector(-1482, 1601, -419.6), ang = Angle(90,295,0)},
	{pos = Vector(-1252, 1272, -419.6), ang = Angle(90,325,0)}
}

local function SpawnHacker()
	print("Spawning hacker device")
	local hacker = ents.Create("nz_script_prop")
	local ran = hackerlocations[math.random(1,6)]
	hacker:SetModel("models/weapons/bo3/w_bo3_hacker.mdl")
	hacker:SetPos(ran.pos)
	hacker:SetAngles(ran.ang)
	hacker:Spawn()
	hacker.OnUsed = function(self, ply)
		ply:Give("nz_hacker")
		self:Remove()
	end
end

SpawnHacker()
hook.Add("nzHackerDropped", "NoPlayerHasTheHacker", function()
	print("The hacker has been removed from the game. Spawning it again.")
	local hacker = ents.Create("nz_script_prop")
	local ran = hackerlocations[math.random(1,6)]
	hacker:SetModel("models/weapons/bo3/w_bo3_hacker.mdl")
	hacker:SetPos(ran.pos)
	hacker:SetAngles(ran.ang)
	hacker:Spawn()
	hacker.OnUsed = function(self, ply)
		ply:Give("nz_hacker")
		self:Remove()
	end
end)

local cablelocations = {
	{pos = Vector(-2319.5, 1773.3, -179), ang = Angle(-0.4, -2, 90)},
	{pos = Vector(-2172, 2001, -221.5), ang = Angle(0, -8.2, 90)},
	{pos = Vector(-1711, 1256, -258), ang = Angle(-75, 123.5, -36)},
	{pos = Vector(-1727.3, 2227.3, -379.6), ang = Angle(-51, 1, 0.9)},
	{pos = Vector(-2448, 1443, -206), ang = Angle(-0.4, 79, 90)}
}

local cable = nzItemCarry:CreateCategory("cable")
cable:SetModel("models/props_pipes/pipeset32d_bend256u_001a.mdl")
--cable:SetModelScale(0.12)
cable:SetText("Press E to pick up the cable.")
cable:SetDropOnDowned(true)
--cable:SetShared(true)

cable:SetResetFunction( function(self)
    local ran = cablelocations[math.random(table.Count(cablelocations))]
    if ran and ran.pos and ran.ang then
        local part = ents.Create("nz_script_prop")
        part:SetModel("models/props_pipes/pipeset32d_bend256u_001a.mdl")
		part:SetModelScale(0.12)
        part:SetPos(ran.pos)
        part:SetAngles(ran.ang)
        part:Spawn()
        self:RegisterEntity( part )
		part:DrawShadow( false )
		part:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
		part.OnUsed = function(self, ply)
			ply:GiveCarryItem("cable")
			self:Remove()
		end
    end
end)
cable:Update()
cable:Reset()

local cable_place = ents.Create("nz_script_prop")
cable_place:SetModel("models/items/car_battery01.mdl")
cable_place:SetPos(Vector(1551.75, 716, -7.75)) --change
cable_place:SetAngles(Angle(0, 180, -180))
cable_place:SetName("rodstep_cable_placer")
cable_place.OnUsed = function(self, ply)
	if ply:HasCarryItem("cable") then
		ply:RemoveCarryItem("cable")
		self:SetModel("models/props_pipes/pipeset32d_bend256u_001a.mdl")
		cable_place:SetModelScale(0.12)
		self:SetNoDraw(false)
		self:DrawShadow( false )
		local rodstep = ents.FindByName("rod_step")[1]
		timer.Simple(1, function()
			rodstep:Fire("RunCode")
		end)
	end
end
cable_place:Spawn()
cable_place:SetNoDraw(true)
 
hook.Add( "ElectricityOn", "Power_Check", function()
    local powerbutton = ents.FindByName("power_btn")[1]
    local pi = ents.FindByName("pitest")[1]
    local omicron = ents.FindByName("omicrontest")[1]
    local epsilon = ents.FindByName("epsilontest")[1]
    powerbutton:Fire("Press")
end )

hook.Add( "PlayerSpawn", "SetPlayermodels", function(ply)
    if SERVER then
		if IsValid(richtofen) and ply == richtofen then
			ply:SetNWString("nzcharname", "richtofen")
			ply:SetModel("models/player/hidden/pes_characters/richtofen.mdl")
			ply:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
		end
		if IsValid(dempsey) and ply == dempsey then
			ply:SetNWString("nzcharname", "dempsey")
			ply:SetModel("models/player/hidden/pes_characters/dempsey.mdl")
			ply:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
		end
		if IsValid(nikolai) and ply == nikolai then
			ply:SetNWString("nzcharname", "nikolai")
			ply:SetModel("models/player/hidden/pes_characters/nikolai.mdl")
			ply:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
		end
		if IsValid(takeo) and ply == takeo then
			ply:SetNWString("nzcharname", "takeo")
			ply:SetModel("models/player/hidden/pes_characters/takeo.mdl")
			ply:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
		end
	end
end )

function mapscript.OnGameBegin()

	local perkson = {"pap", "jugg", "speed"}
	for k,v in pairs(ents.FindByClass("perk_machine")) do
		if table.HasValue(perkson, v:GetPerkID()) then
			v:TurnOn()
		end
	end
	
	local starta51 = ents.FindByName("starta51")[1]
	starta51:Fire("RunCode")
	if SERVER then
		if IsValid(richtofen) then
			richtofen:SetNWString("nzcharname", "richtofen")
			richtofen:SetModel("models/player/hidden/pes_characters/richtofen.mdl")
			richtofen:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
			richtofen:SetGravity(1)
		end
		if IsValid(dempsey) then
			dempsey:SetNWString("nzcharname", "dempsey")
			dempsey:SetModel("models/player/hidden/pes_characters/dempsey.mdl")
			dempsey:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
			dempsey:SetGravity(1)
		end
		if IsValid(nikolai) then
			nikolai:SetNWString("nzcharname", "nikolai")
			nikolai:SetModel("models/player/hidden/pes_characters/nikolai.mdl")
			nikolai:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
			nikolai:SetGravity(1)
		end
		if IsValid(takeo) then
			takeo:SetNWString("nzcharname", "takeo")
			takeo:SetModel("models/player/hidden/pes_characters/takeo.mdl")
			takeo:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
			takeo:SetGravity(1)
		end
	end
	rod1:Update()
	richtofen:GiveCarryItem("goldenrod1")
	
	
	mapscript.ExcavatorLogic = {}
	mapscript.ExcavatorLogic.PowerOn = false
	--mapscript.ExcavatorLogic.RoundWait = { math.random( 2, 4 ), math.random( 3, 5 ), math.random( 3, 5 ) }
	mapscript.ExcavatorLogic.RoundWait = math.random( 3, 5 )
	
	timer.Simple(0.1, function()
	if SERVER then
	richtofen:SetModel("models/player/hidden/pes_characters/richtofen.mdl")
    richtofen:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
    if IsValid(dempsey) then
        dempsey:SetModel("models/player/hidden/pes_characters/dempsey.mdl")
        dempsey:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
    end
    if IsValid(nikolai) then
        nikolai:SetModel("models/player/hidden/pes_characters/nikolai.mdl")
        nikolai:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
    end
    if IsValid(takeo) then
        takeo:SetModel("models/player/hidden/pes_characters/takeo.mdl")
        takeo:GetHands():SetModel("models/weapons/c_arms_codpressuresuit.mdl")
    end
	end
	end)
end

local picons = ents.FindByName("piconsb")[1]
local omicroncons = ents.FindByName("omicronconsb")[1]
local epsiloncons = ents.FindByName("epsilonconsb")[1]

picons:SetKeyValue("spawnflags", "2049")
omicroncons:SetKeyValue("spawnflags", "2049")
epsiloncons:SetKeyValue("spawnflags", "2049")

local piconsole = ents.FindByName("piconsb")[1]
local omicronconsole = ents.FindByName("omicronconsb")[1]
local epsilonconsole = ents.FindByName("epsilonconsb")[1]

piconsole:SetFinishedFunction(function() hook.Call("ExcavatorPiEnabled") end)
omicronconsole:SetFinishedFunction(function() hook.Call("ExcavatorOmicronEnabled") end)
epsilonconsole:SetFinishedFunction(function() hook.Call("ExcavatorEpsilonEnabled") end)

function mapscript.OnRoundStart( roundNumber )
	local pi = ents.FindByName("pitest")[1]
	local omicron = ents.FindByName("omicrontest")[1]
	local epsilon = ents.FindByName("epsilontest")[1]
	
	local PossibleExcavators = { pi, omicron, epsilon }
	local selectedExcavator
	
	hook.Add("ExcavatorPiEnabled", "ReintroducePi", function() table.insert(PossibleExcavators, 3, pi) print("adding excavator PI back to the roster") end)
	hook.Add("ExcavatorOmicronEnabled", "ReintroduceOmicron", function() table.insert(PossibleExcavators, 3, omicron) print("adding excavator OMICRON back to the roster") end)
	hook.Add("ExcavatorEpsilonEnabled", "ReintroduceEpsilon", function() table.insert(PossibleExcavators, 3, epsilon) print("adding excavator EPSILON back to the roster") end)
	
	if nzElec.IsOn() then
		if mapscript.ExcavatorLogic.PowerOn == false then --If we have yet to start a round where the power was already turned on, mark that round for later logic
			mapscript.ExcavatorLogic.PowerOn = true
			mapscript.ExcavatorLogic.FirstRoundWithPower = roundNumber
		end
		--print("=============EXCAVATOR LOGIC=============")
		--PrintTable(mapscript.ExcavatorLogic)
		if PossibleExcavators[1] == nil then return end
		--if roundNumber == (mapscript.ExcavatorLogic.FirstRoundWithPower + mapscript.ExcavatorLogic.RoundWait[1]) then --We've hit the round to turn an excavator on for
		if roundNumber == (mapscript.ExcavatorLogic.FirstRoundWithPower + mapscript.ExcavatorLogic.RoundWait) then
			local num = math.random( 1, #PossibleExcavators )
			selectedExcavator = PossibleExcavators[ num ]
			selectedExcavator:Fire("Press")
			
            --table.remove(mapscript.ExcavatorLogic.RoundWait, 1)
			table.remove(PossibleExcavators, num)
			mapscript.ExcavatorLogic.RoundWait = roundNumber - mapscript.ExcavatorLogic.FirstRoundWithPower + math.random( 3, 5 )
		end
	end
end
 
return mapscript