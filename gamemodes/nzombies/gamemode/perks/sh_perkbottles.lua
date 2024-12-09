function nzPerks:RegisterBottle(class, name, materialtable, model, vector, angle)
	nzPerks.Bottles = nzPerks.Bottles or {}

	nzPerks.Bottles[class] = {
		class = class,
		name = name,
		materials = materialtable,
		fizzmdl = model,
		fizzpos = vector,
		fizzang = angle,
	}
end

-- local legacy_fizz_models = {
-- 	["tfa_perk_can"] = {fizzmdl = "models/nz/perks/wm_t9_can.mdl", fizzpos = Vector(0,0,50), fizzang = Angle(0,180,0)},
-- 	["tfa_bo1_bottle"] = {fizzmdl = "models/nz/perks/wm_t5_perk_bottle.mdl", fizzpos = Vector(0,0,50), fizzang = Angle(0,90,0)},
-- 	["tfa_bo2_bottle"] = {fizzmdl = "models/nz/perks/wm_t6_perk_bottle.mdl", fizzpos = Vector(0,0,50), fizzang = Angle(0,90,0)},
-- 	["tfa_perk_gum"] = {fizzmdl = "models/nz/perks/w_wpn_t7_zmb_bubblegum_view_lod4.mdl", fizzpos = Vector(0,0,55), fizzang = Angle(0,180,0)},
-- 	["tfa_bo3_nana"] = {fizzmdl = "models/nz/perks/wm_perk_nana.mdl", fizzpos = Vector(0,0,55), fizzang = Angle(0,-90,0)},
-- 	["tfa_perk_candy"] = {fizzmdl = "models/nz/perks/wm_iw8_candy.mdl", fizzpos = Vector(0,0,50), fizzang = Angle(0,0,0)},
-- 	["tfa_perk_goblet"] = {fizzmdl = "models/nz/perks/wm_s4_goblet.mdl", fizzpos = Vector(0,0,50), fizzang = Angle(0,140,0)},
-- }

function nzPerks:GetFizzPosition(class)
	if !nzPerks.Bottles or !class then return end
	local data = nzPerks.Bottles[class]
	if !data or !data.fizzpos then
		data = legacy_fizz_models[class]
		if !data or !data.fizzpos then return end
	end

	return data.fizzpos, data.fizzang
end

function nzPerks:GetFizzBottle(class)
	if !nzPerks.Bottles or !class then return end
	local data = nzPerks.Bottles[class]
	if !data or !data.fizzpos then
		data = legacy_fizz_models[class]
		if !data or !data.fizzpos then return end
	end

	return data.fizzmdl
end

function nzPerks:GetBottleTextures(class)
	if !nzPerks.Bottles or !class then return end
	local data = nzPerks.Bottles[class]
	if !data then return end
	return data.materials or {}
end

/*Example
//class being the swep file name for the perk
//name being the game it comes from with maybe a descriptor
//each index is the submaterial group for that specific texture to be replaced
//the file path should cut off just before the perk names SEE 'models/nzr/perk_bottles/bo3/'
//the perk name is used in code to identify what texture to use
//the world model is for the der wunderfizz machine
//along with the bottle's position offset and angle offset from the fizz

nzPerks:RegisterBottle("class", "Name", {
	[index] = "path/to/material_",
}, "path/to/world_model.mdl", Vector(0,0,0), Angle(0,0,0))
*/

nzPerks:RegisterBottle("tfa_perk_bottle", "Black Ops 3 Bottle", {
	[0] = "models/nz/perks/bo3/metal_",
	[1] = "models/nz/perks/bo3/bottle_",
	[2] = "models/nz/perks/bo3/logo_"
}, "models/nzr/2022/perks/w_perk_bottle.mdl", Vector(0,0,50), Angle(0,140,0))
