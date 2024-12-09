local mapscript = {}

local shieldparts = {
	[1] = { -- Fence
		{pos = Vector(-1798.1919, -3046.7742, 305.2274), ang = Angle(15,-45,0)},
	},
	[2] = { -- Radiator
		{pos = Vector(-1841.6146, -3045.3674, 289.1857), ang = Angle(0,43,0)},
	},
	[3] = { -- Posts
		{pos = Vector(-1882.4246, -3047.3267, 255.9243), ang = Angle(0,0,0)},
	}
}

local shield1 = nzItemCarry:CreateCategory("shield1")
shield1:SetIcon("spawnicons/models/props_c17/fence01b.png")
shield1:SetText("Press E to pick up part.")
shield1:SetDropOnDowned(false)
shield1:SetShared(false)

shield1:SetResetFunction( function(self)
	local poss = shieldparts[1]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/props_c17/fence01b.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield1:Update()

local shield2 = nzItemCarry:CreateCategory("shield2")
shield2:SetIcon("spawnicons/models/props_c17/furnitureradiator001a.png")
shield2:SetText("Press E to pick up part.")
shield2:SetDropOnDowned(false)
shield2:SetShared(false)

shield2:SetResetFunction( function(self)
	local poss = shieldparts[2]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/props_c17/furnitureradiator001a.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield2:Update()

local shield3 = nzItemCarry:CreateCategory("shield3")
shield3:SetIcon("spawnicons/models/props_c17/playgroundtick-tack-toe_post01.png")
shield3:SetText("Press E to pick up part.")
shield3:SetDropOnDowned(false)
shield3:SetShared(false)

shield3:SetResetFunction( function(self)
	local poss = shieldparts[3]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/props_c17/playgroundtick-tack-toe_post01.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield3:Update()

local buildabletbl = {
	model = "models/weapons/w_zombieshield.mdl",
	pos = Vector(0,0,60), -- (Relative to tables own pos)
	ang = Angle(0,180,90), -- (Relative too)
	parts = {
		["shield1"] = {0,1}, -- Submaterials to "unhide" when this part is added
		["shield2"] = {2}, -- id's are ItemCarry object IDs
		["shield3"] = {3},
		-- You can have as many as you want
	},
	usefunc = function(self, ply) -- When it's completed and a player presses E (optional)
		if !ply:HasWeapon("nz_zombieshield") then
			ply:Give("nz_zombieshield")
		end
	end,
	text = "Press E to pick up Zombie Shield"
}


function mapscript.OnGameBegin()
	local tbl = ents.Create("buildable_table")
	tbl:AddValidCraft("Zombie Shield", buildabletbl)
	tbl:SetPos(Vector(-1744.0367, -2989.6267, 255.1382))
	tbl:SetAngles(Angle(0,90,0))
	tbl:Spawn()
	
	shield1:Reset()
	shield2:Reset()
	shield3:Reset()
	
end

function mapscript.ScriptUnload()

end

function mapscript.PostCleanupMap()
	
end

-- Always return the mapscript table. This gives it on to the gamemode so it can use it.
return mapscript
