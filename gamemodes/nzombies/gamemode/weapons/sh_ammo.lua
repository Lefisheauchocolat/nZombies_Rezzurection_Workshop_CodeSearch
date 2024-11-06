-- Create new ammo types for each weapon slot; that way all 3 weapons have seperate ammo even if they share type
game.AddAmmoType({
	name = "nz_weapon_ammo_1",
	dmgtype = DMG_BULLET,
	tracer = TRACER_LINE,
	plydmg = 0,
	npcdmg = 0,
	force = 2000,
	minsplash = 10,
	maxsplash = 5
})

game.AddAmmoType({
	name = "nz_weapon_ammo_2",
	dmgtype = DMG_BULLET,
	tracer = TRACER_LINE,
	plydmg = 0,
	npcdmg = 0,
	force = 2000,
	minsplash = 10,
	maxsplash = 5
})

game.AddAmmoType({
	name = "nz_weapon_ammo_3",
	dmgtype = DMG_BULLET,
	tracer = TRACER_LINE,
	plydmg = 0,
	npcdmg = 0,
	force = 2000,
	minsplash = 10,
	maxsplash = 5
})

game.AddAmmoType({
	name = "nz_grenade",
})

game.AddAmmoType({
	name = "nz_specialgrenade",
})

game.AddAmmoType({
	name = "nz_equipment",
})

//all of this breaks the ammo system clientside, please fix me

NZAmmoIDs = NZAmmoIDs or {} -- It needs to be global to pass through lua refresh
local ammoids = NZAmmoIDs -- Localize it for optimization

function GetNZAmmoID( id )
	return ammoids[id]
end

hook.Add("InitPostEntity", "nzRegisterAmmoIDs", function()
	local id
	for i = 1, 3 do
		id = game.GetAmmoID("nz_weapon_ammo_"..i)
		if id and id != -1 then
			ammoids[i] = id
		end
	end

	id = game.GetAmmoID("nz_grenade")
	if id and id != -1 then
		ammoids["grenade"] = id
	else
		ammoids["grenade"] = 1 -- Default to AR2 ammo
	end

	id = game.GetAmmoID("nz_specialgrenade")
	if id and id != -1 then
		ammoids["specialgrenade"] = id
	else
		ammoids["specialgrenade"] = 2 -- Default to AR2 alt ammo (combine balls)
	end

	id = game.GetAmmoID("nz_equipment")
	if id and id != -1 then
		ammoids["equipment"] = id
	else
		ammoids["equipment"] = 30 -- GrenadeHL1
	end
end)

if CLIENT then
	net.Receive("nzAmmoTypeSync", function()
		ammoids = net.ReadTable()
		//PrintTable(ammoids)
	end)
else
	util.AddNetworkString("nzAmmoTypeSync")

	FullSyncModules["AmmoTypes"] = function(ply)
		net.Start("nzAmmoTypeSync")
			net.WriteTable(ammoids)
		net.Broadcast()
	end
end

local usesammo = {
	["grenade"] = "grenade",
	["specialgrenade"] = "specialgrenade",
	["trap"] = "equipment",
}

local wepMeta = FindMetaTable("Weapon")

local oldammotype = wepMeta.GetPrimaryAmmoType
function wepMeta:GetPrimaryAmmoType()
	local id = self:GetNWInt("SwitchSlot", -1)
	if id == -1 and self.NZSpecialCategory == "trap" and oldammotype(self) > 0 then
		id = "equipment"
	end

	if ammoids[id] then
		return ammoids[id]
	end

	local oldammo = oldammotype(self)
	if SERVER and oldammo and oldammo != -1 and id != -1 then
		ammoids[id] = oldammo

		net.Start("nzAmmoTypeSync")
			net.WriteTable(ammoids) -- Resync new ammo types
		net.Broadcast()
	end

	return oldammo
end