local mapscript = {}

-- Summer Offices --

local shieldparts = {
	[1] = { -- Tanks
		{pos = Vector(-95.016, -1831.284, -301.522), ang = Angle(89.995, 152.853, -301.522)}, -- On a small box near the Power Switch.
	},
	[2] = { -- Window
		{pos = Vector(1607.943, 683.776, -127.939), ang = Angle(-27.625, -158.884, -2.944)}, -- On a couch next to the M1927 WallBuy.
	},
	[3] = { -- Eagle
		{pos = Vector(-1029.937, 784.826, -205.914), ang = Angle(-16.331, -92.104, 0.143)}, -- On top of some crates by Jugg leaned up on some sandbags.
	}
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

local shield3 = nzItemCarry:CreateCategory("shield3")
shield3:SetIcon("spawnicons/models/weapons/tfa_bo3/rocketshield/build_rocketshield_eagle.png")
shield3:SetText("Press Use to pick up Part")
shield3:SetDropOnDowned(false)
shield3:SetShared(false)

shield3:SetResetFunction( function(self)
	local poss = shieldparts[3]
	local ran = poss[math.random(table.Count(poss))]
	if ran and ran.pos and ran.ang then
		local part = ents.Create("nz_script_prop")
		part:SetModel("models/weapons/tfa_bo3/rocketshield/build_rocketshield_eagle.mdl")
		part:SetPos(ran.pos)
		part:SetAngles(ran.ang)
		part:Spawn()
		self:RegisterEntity( part )
	end
end)
shield3:Update()

local buildabletbl = {
	model = "models/weapons/tfa_bo3/rocketshield/w_rocketshield.mdl",
	pos = Vector(0,0,70), -- (Relative to tables own pos)
	ang = Angle(0, 90, 0), -- (Relative too)
	parts = {
		["shield1"] = {0,1}, -- Submaterials to "unhide" when this part is added
		["shield2"] = {2}, -- id's are ItemCarry object IDs
		["shield3"] = {3},
		-- You can have as many as you want
	},
	usefunc = function(self, ply) -- When it's completed and a player presses E (optional)
		if !ply:HasWeapon("tfa_bo3_rocketshield") then
			ply:Give("tfa_bo3_rocketshield")
		end
	end,
	text = "Press Use to take Rocket Shield"
}


local shootable_ents = {}
local shootables = {
	{pos = Vector(-763.680, -943.326, -137.904), ang = Angle(0, 109.649, 0)},
	{pos = Vector(-1622.882, -600.178, -176.424), ang = Angle(0, 0, 0)},
	{pos = Vector(-1356.577, 1851.092, -343.949), ang = Angle(0, -44.967, 0)},
	{pos = Vector(-1796.808, -1398.451, -328.831), ang = Angle(0, -30.943, 0)},
	{pos = Vector(-901.478, -44.547, -96.778), ang = Angle(0, 24.340, 0)},
	{pos = Vector(518.805, 680.598, -160.549), ang = Angle(0, -44.967, 0)},
	{pos = Vector(1771.054, 787.789, -137.727), ang = Angle(0, -134.984, 0)},
	{pos = Vector(1373.680, -88.628, -148.340), ang = Angle(0, -44.967, 0)},
	{pos = Vector(2330.564, -325.673, -160.467), ang = Angle(0, 124.008, 0)},
	{pos = Vector(413.771, -405.918, -161.493), ang = Angle(0, -66.544, 0)},
	{pos = Vector(1771.564, -1687.775, -320.824), ang = Angle(0, 166.399, 0)},
	{pos = Vector(284.288, -1498.223, -172.975), ang = Angle(0, 44.967, 0)},
}

function mapscript.shootable()
	
	--local ShootableCount = 0
	
	for k,v in pairs(shootables) do
		local shootable
		if IsValid(shootable_ents[k]) then
			shootable = shootable_ents[k]
		else
			shootable = ents.Create("nz_script_prop")
		end
		
		shootable:SetPos(v.pos)
		shootable:SetAngles(v.ang)
		shootable:SetModel("models/nzu/mysterybox/teddybear_sitting.mdl")
		shootable:Spawn()
		shootable.OnTakeDamage = function(self, dmginfo)
			local attacker = dmginfo:GetAttacker()
			if attacker:IsPlayer() then
				--ShootableCount = ShootableCount + 1
				attacker:GivePoints(150) -- Since theres 12 Teddys... You can get up to 3000 points.
				self:Remove()
				attacker:SendLua( "surface.PlaySound( \"nz_moo/effects/buy_t9.mp3\" ) " )
				--[[for k, v in pairs( player.GetAll() ) do
					--v:ChatPrint( "- "..ShootableCount.."/ 9 -" )
				end]]
			end
		end
	end

end

function mapscript.OnGameBegin()

	--nzNotifications:PlaySound("sheppowed_fnaf/intro.wav", 0) -- Plays upon game starting

	PrintMessage( HUD_PRINTTALK, "Update: Version 1.1" )

	local tbl = ents.Create("buildable_table")
	tbl:AddValidCraft("Zombie Shield", buildabletbl)
	tbl:SetPos(Vector(-366.491, 273.506, -159.905)) -- In Juicer's Gin Room.
	tbl:SetAngles(Angle(0,0,0))
	tbl:Spawn()
	
	shield1:Reset()
	shield2:Reset()
	shield3:Reset()

	mapscript.shootable()
	
end


hook.Add("OnRoundStart", "nZunderscore", function()

end)

function mapscript.ScriptUnload()
end

function mapscript.PostCleanupMap()
end

-- Always return the mapscript table. This gives it on to the gamemode so it can use it.
return mapscript