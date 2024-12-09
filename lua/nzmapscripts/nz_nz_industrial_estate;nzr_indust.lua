local mapscript = {}

-- Summer Offices --

local shieldparts = {
	[1] = { -- Tanks
		{pos = Vector(-95.016, -1831.284, -301.522), ang = Angle(89.995, 152.853, -301.522)}, -- On a small box near the Power Switch.
	},
	[2] = { -- Window
		{pos = Vector(1607.943, 683.776, -127.939), ang = Angle(-27.625, -158.884, -2.944)}, -- On a couch next to the M1927 WallBuy.
	},
}

local shield1 = nzItemCarry:CreateCategory("shield1")
shield1:SetIcon("spawnicons/models/weapons/tfa_bo3/rocketshield/build_rocketshield_tanks.png")
shield1:SetText("Press Use to pick up Part")
shield1:SetDropOnDowned(false)
shield1:SetShared(false)

shield1:SetResetFunction( function(self)
	local poss = shieldparts[1]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/weapons/tfa_bo3/rocketshield/build_rocketshield_tanks.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield1:Update()

local shield2 = nzItemCarry:CreateCategory("shield2")
shield2:SetIcon("spawnicons/models/weapons/tfa_bo3/rocketshield/build_rocketshield_window.png")
shield2:SetText("Press Use to pick up Part")
shield2:SetDropOnDowned(false)
shield2:SetShared(false)

shield2:SetResetFunction( function(self)
	local poss = shieldparts[2]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/weapons/tfa_bo3/rocketshield/build_rocketshield_window.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield2:Update()

local buildabletbl = {
	model = "models/weapons/tfa_bo3/rocketshield/w_rocketshield.mdl",
	pos = Vector(0,0,70), -- (Relative to tables own pos)
	ang = Angle(0, 90, 0), -- (Relative too)
	parts = {
		["shield1"] = {0,1}, -- Submaterials to "unhide" when this part is added
		["shield2"] = {2}, -- id's are ItemCarry object IDs
		-- You can have as many as you want
	},
	usefunc = function(self, ply) -- When it's completed and a player presses E (optional)
		if !ply:HasWeapon("tfa_bo3_rocketshield") then
			ply:Give("tfa_bo3_rocketshield")
		end
	end,
	text = "Press Use to take Zombie Shield"
}

function mapscript.OnGameBegin()

	PrintMessage( HUD_PRINTTALK, "Version 1.0" )

	local tbl = ents.Create("buildable_table")
	tbl:AddValidCraft("Zombie Shield", buildabletbl)
	tbl:SetPos(Vector(-366.491, 273.506, -159.905))
	tbl:SetAngles(Angle(0,0,0))
	tbl:Spawn()
	
	shield1:Reset()
	shield2:Reset()
	
end


hook.Add("OnRoundStart", "nZBitchtheyapproachin", function()

end)

function mapscript.ScriptUnload()
end

function mapscript.PostCleanupMap()
end

-- Always return the mapscript table. This gives it on to the gamemode so it can use it.
return mapscript