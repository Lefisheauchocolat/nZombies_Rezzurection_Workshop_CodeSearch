local mapscript = {}

-- FNaF at Freddy's --

local shieldparts = {
	[1] = { -- Frame
		{pos = Vector(-989.6205, 2527.2842, 13.4664), ang = Angle(-89.9987, 134.9763, 180)}, -- At the Prize Counter on the bottom row of the plushie shelf
	},
	[2] = { -- Window
		{pos = Vector(440.6078, 777.374, 20.3219), ang = Angle(-22.7945, 41.4197, -89.4598)}, -- Leaned up against a shelf/wall in the manager's office
	},
	[3] = { -- Door
		{pos = Vector(-60.3656, 1727.6064, 277.636), ang = Angle(-17.836, -44.212, 1.124)}, -- Leaned up a pile of pallets and crates on the roof
	}
}

local shield1 = nzItemCarry:CreateCategory("shield1")
shield1:SetIcon("spawnicons/models/weapons/tfa_bo3/tombshield/build_tombshield_frame.png")
shield1:SetText("Press Use to pick up Part")
shield1:SetDropOnDowned(false)
shield1:SetShared(false)

shield1:SetResetFunction( function(self)
	local poss = shieldparts[1]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/weapons/tfa_bo3/tombshield/build_tombshield_frame.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield1:Update()

local shield2 = nzItemCarry:CreateCategory("shield2")
shield2:SetIcon("spawnicons/models/weapons/tfa_bo3/tombshield/build_tombshield_window.png")
shield2:SetText("Press Use to pick up Part")
shield2:SetDropOnDowned(false)
shield2:SetShared(false)

shield2:SetResetFunction( function(self)
	local poss = shieldparts[2]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/weapons/tfa_bo3/tombshield/build_tombshield_window.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield2:Update()

local shield3 = nzItemCarry:CreateCategory("shield3")
shield3:SetIcon("spawnicons/models/weapons/tfa_bo3/tombshield/build_tombshield_door.png")
shield3:SetText("Press Use to pick up Part")
shield3:SetDropOnDowned(false)
shield3:SetShared(false)

shield3:SetResetFunction( function(self)
	local poss = shieldparts[3]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/weapons/tfa_bo3/tombshield/build_tombshield_door.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield3:Update()

local buildabletbl = {
	model = "models/weapons/tfa_bo3/tombshield/w_tombshield.mdl",
	pos = Vector(0,0,70), -- (Relative to tables own pos)
	ang = Angle(0, 0, 0), -- (Relative too)
	parts = {
		["shield1"] = {0,1}, -- Submaterials to "unhide" when this part is added
		["shield2"] = {2}, -- id's are ItemCarry object IDs
		["shield3"] = {3},
		-- You can have as many as you want
	},
	usefunc = function(self, ply) -- When it's completed and a player presses E (optional)
		if !ply:HasWeapon("tfa_bo3_tombshield") then
			ply:Give("tfa_bo3_tombshield")
		end
	end,
	text = "Press Use to take Zombie Shield(Press N to Equip)"
}


function mapscript.OnGameBegin()

	nzNotifications:PlaySound("sheppowed_fnaf/intro.wav", 0) -- Plays upon game starting

	PrintMessage( HUD_PRINTTALK, "Update: Version 1.1" )

	local tbl = ents.Create("buildable_table")
	tbl:AddValidCraft("Zombie Shield", buildabletbl)
	tbl:SetPos(Vector(75.1153, 632.0005, 0.0313))
	tbl:SetAngles(Angle(0,0,0))
	tbl:Spawn()
	
	shield1:Reset()
	shield2:Reset()
	shield3:Reset()
	
end


hook.Add("OnRoundStart", "nZunderscore", function()

end)

function mapscript.ScriptUnload()
end

function mapscript.PostCleanupMap()
end

-- Always return the mapscript table. This gives it on to the gamemode so it can use it.
return mapscript