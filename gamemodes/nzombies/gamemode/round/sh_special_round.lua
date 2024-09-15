if SERVER then
	function nzRound:SetNextSpecialRound( num )
		self.NextSpecialRound = num
	end

	function nzRound:GetNextSpecialRound()
		return self.NextSpecialRound
	end

	function nzRound:MarkedForSpecial( num )
		return ((self.NextSpecialRound == num and self.SpecialRoundType and self.SpecialData[self.SpecialRoundType] and true) or (nzConfig.RoundData[ num ] and nzConfig.RoundData[ num ].special)) or false
	end
	
	function nzRound:SetSpecialRoundType(id)
		if id == "None" then
			self.SpecialRoundType = nil -- "None" makes a nil key
		else
			self.SpecialRoundType = id or "Hellhounds" -- A nil id defaults to "Hellhounds", otherwise id
		end
	end
	
	function nzRound:GetSpecialRoundType(id)
		return self.SpecialRoundType
	end
	
	function nzRound:GetSpecialRoundData()
		if !self.SpecialRoundType then return nil end
		return self.SpecialData[self.SpecialRoundType]
	end

	util.AddNetworkString("nz_hellhoundround")
	function nzRound:CallHellhoundRound()
		net.Start("nz_hellhoundround")
			net.WriteBool(true)
		net.Broadcast()
	end
end


nzRound.PerkSelectData = nzRound.PerkSelectData or {}
function nzRound:AddMachineType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.PerkSelectData[id] = data
		else
			nzRound.PerkSelectData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.PerkSelectData[id] = class
	end
end

nzRound:AddMachineType("Original", 				"", {}) 
nzRound:AddMachineType("Infinite Warfare", 		"", {}) 
nzRound:AddMachineType("Classic", 			"", {}) 
nzRound:AddMachineType("Cold Snore", 			"", {}) 
nzRound:AddMachineType("Bo3", 					"", {}) 


-- [[ EE Song Model ]] --
nzRound.eemodel = nzRound.eemodel or {}
function nzRound:AddSongType(id, class)
	if class then
		local data = {}
		-- Which entity to spawn
		data.class = class
		nzRound.eemodel[id] = data
	else
		nzRound.eemodel[id] = nil -- Remove it if no valid class was added
	end
end

-- [[ Pack-a-Punch Model ]] --
nzRound.PAPSelectData = nzRound.PAPSelectData or {}
function nzRound:AddPAPType(id, class)
	if class then
		local data = {}
		-- Which entity to spawn
		data.class = class
		nzRound.PAPSelectData[id] = data
	else
		nzRound.PAPSelectData[id] = nil -- Remove it if no valid class was added
	end
end

nzRound:AddPAPType("Original", 				"models/moo/_codz_ports_props/t7/zm/p7_zm_vending_packapunch/moo_codz_p7_zm_vending_packapunch.mdl", {}) 
nzRound:AddPAPType("Tranzit", 				"models/nzr/2022/machines/pap/vending_pap.mdl", {}) 
nzRound:AddPAPType("Black Ops Cold War", 	"models/codmw2023/other/pack-a-punch.mdl", {}) 
nzRound:AddPAPType("World War II", 			"models/perks/SHperks/ww2.mdl", {})
nzRound:AddPAPType("Classic", 				"models/wavy_ports/waw/packapunch_machine.mdl", {})
nzRound:AddPAPType("Halloween", 			"models/wavy_ports/waw/packapunch_machine_halloween.mdl", {})
nzRound:AddPAPType("Origins", 				"models/moo/_codz_ports_props/t6/zm/p6_zm_tm_packapunch/moo_codz_p6_zm_tm_packapunch.mdl", {}) 
nzRound:AddPAPType("Origins Red", 			"models/moo/_codz_ports_props/t6/zm/p6_zm_tm_packapunch_red/moo_codz_p6_zm_tm_packapunch_red.mdl", {}) 

function nzRound:GetPackType(id)
	if id == nil then 
		return "models/moo/_codz_ports_props/t7/zm/p7_zm_vending_packapunch/moo_codz_p7_zm_vending_packapunch.mdl"
	else
		local check = nzRound.PAPSelectData[id].class
		return check
	end
end
-- [[ Pack-a-Punch Model ]] --

nzRound.IconSelectData = nzRound.IconSelectData or {}
function nzRound:AddIconType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.IconSelectData[id] = data
		else
			nzRound.IconSelectData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.IconSelectData[id] = class
	end
end

nzRound:AddIconType("Rezzurrection", 				"Rezzurrection", {}) 
nzRound:AddIconType("World at War/ Black Ops 1", 	"World at War/ Black Ops 1", {}) 
nzRound:AddIconType("Black Ops 2", 					"Black Ops 2", {}) 
nzRound:AddIconType("Black Ops 3", 					"Black Ops 3", {}) 
nzRound:AddIconType("Black Ops 4", 					"Black Ops 4", {}) 
nzRound:AddIconType("Infinite Warfare", 			"Infinite Warfare", {}) 
nzRound:AddIconType("Modern Warfare", 				"Modern Warfare", {}) 
nzRound:AddIconType("Cold War", 					"Cold War", {}) 
nzRound:AddIconType("Vanguard", 					"Vanguard", {}) 
nzRound:AddIconType("April Fools", 					"April Fools", {}) 
nzRound:AddIconType("No Background", 				"No Background", {}) 
nzRound:AddIconType("Hololive", 					"Hololive", {}) 
nzRound:AddIconType("Shadows of Evil", 				"Shadows of Evil", {})
nzRound:AddIconType("WW2", 							"WW2", {})
nzRound:AddIconType("Halloween", 					"Halloween", {}) 
nzRound:AddIconType("Christmas", 					"Christmas", {}) 
nzRound:AddIconType("Neon", 						"Neon", {}) 
nzRound:AddIconType("Overgrown", 					"Overgrown", {}) 
nzRound:AddIconType("MW3 Zombies", 					"MW3 Zombies", {}) 
nzRound:AddIconType("Frosted Flakes", 				"Frosted Flakes", {}) 
nzRound:AddIconType("Pickle Glow", 					"Pickle Glow", {}) 
nzRound:AddIconType("Herrenhaus", 					"Herrenhaus", {}) 
nzRound:AddIconType("Cheese Cube", 					"Cheese Cube", {}) 
nzRound:AddIconType("Paper", 						"Paper", {}) 
nzRound:AddIconType("Charred", 						"Charred", {}) 
nzRound:AddIconType("Ragnarok", 					"Ragnarok", {}) 

function nzRound:GetIconType(id)
	if id == nil then 
		return "World at War/ Black Ops 1"
	else
		local check = nzRound.IconSelectData[id].class
		return check
	end
end

nzRound.FontSelection = nzRound.FontSelection or {}
function nzRound:AddFontType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.FontSelection[id] = data
		else
			nzRound.FontSelection[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.FontSelection[id] = class
	end
end

nzRound:AddFontType("Classic NZ", 				"Classic NZ", {}) 
nzRound:AddFontType("Old Treyarch", 			"Old Treyarch", {}) 
nzRound:AddFontType("BO2/3", 					"BO2/3", {})  
nzRound:AddFontType("BO4", 						"BO4", {}) 
nzRound:AddFontType("Comic Sans", 				"Comic Sans", {}) 
nzRound:AddFontType("Warprint", 				"Warprint", {}) 
nzRound:AddFontType("Road Rage", 				"Road Rage", {}) 
nzRound:AddFontType("Black Rose", 				"Black Rose", {})  
nzRound:AddFontType("Reborn", 					"Reborn", {}) 
nzRound:AddFontType("Rio Grande", 				"Rio Grande", {}) 
nzRound:AddFontType("Bad Signal", 				"Bad Signal", {}) 
nzRound:AddFontType("Infection", 				"Infection", {}) 
nzRound:AddFontType("Brutal World", 			"Brutal World", {}) 
nzRound:AddFontType("Generic Scifi", 			"Generic Scifi", {}) 
nzRound:AddFontType("Tech", 					"Tech", {}) 
nzRound:AddFontType("Krabby", 					"Krabby", {}) 
nzRound:AddFontType("Black Ops 1", 				"Black Ops 1", {}) 
nzRound:AddFontType("Default NZR", 				"Default NZR", {}) 

nzRound.BoxSkinData = nzRound.BoxSkinData or {}
function nzRound:AddBoxType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.BoxSkinData[id] = data
		else
			nzRound.BoxSkinData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.BoxSkinData[id] = class
	end
end

nzRound:AddBoxType("Original", 			"", {}) 
nzRound:AddBoxType("Black Ops 3", 		"", {}) 
nzRound:AddBoxType("Black Ops 3(Quiet Cosmos)", "", {}) 
nzRound:AddBoxType("Leviathan", 		"", {}) 
nzRound:AddBoxType("Mob of the Dead", 	"", {}) 
nzRound:AddBoxType("Nacht Der Untoten", "", {}) 
nzRound:AddBoxType("Verruckt", 			"", {})
nzRound:AddBoxType("UGX Coffin", 		"", {})

nzRound.HudSelectData = nzRound.HudSelectData or {}
function nzRound:AddHUDType(id, class)
	if class then
		local data = {}
		-- Which entity to spawn
		data.class = class
		nzRound.HudSelectData[id] = data
	else
		nzRound.HudSelectData[id] = nil -- Remove it if no valid class was added
	end
end

nzRound:AddHUDType("Black Ops 4", 				"nz_moo/huds/_nzr/bo4.png", {}) 
nzRound:AddHUDType("Spongebob", 				"nz_moo/huds/_nzr/buttkicking.png", {}) 
nzRound:AddHUDType("Demonic Chains", 			"nz_moo/huds/_nzr/chains.png", {}) 
nzRound:AddHUDType("Demonic Flames", 			"nz_moo/huds/_nzr/flames.png", {}) 
nzRound:AddHUDType("Hazard", 					"nz_moo/huds/_nzr/hazard.png", {}) 
nzRound:AddHUDType("Ratchet Deadlocked", 		"nz_moo/huds/_nzr/ratchet.png", {}) 
nzRound:AddHUDType("Industrial Estate", 		"nz_moo/huds/_nzr/estate.png", {}) 
nzRound:AddHUDType("Origins (HD)", 				"nz_moo/huds/_nzr/origins_hd.png", {}) 
nzRound:AddHUDType("Jack-O-Lantern", 			"nz_moo/huds/_nzr/halloween.png", {}) 
nzRound:AddHUDType("Infinite Warfare", 			"nz_moo/huds/_nzr/mathhugewarfare.png", {}) 

nzRound:AddHUDType("Black Ops 3", 				"b03_hud.png", {}) 
nzRound:AddHUDType("Cold War", 					"cw_hud.png", {}) 
nzRound:AddHUDType("Division 9", 				"D9.png", {}) 
nzRound:AddHUDType("Mob of the Dead", 			"motd.png", {}) 
nzRound:AddHUDType("Fade", 						"fade.png", {}) 
nzRound:AddHUDType("Shadows of Evil", 			"SOE_HUD_NEW.png", {}) 
nzRound:AddHUDType("Black Ops 1", 				"bo1.png", {}) 
nzRound:AddHUDType("Buried", 					"buried_hud.png", {}) 
nzRound:AddHUDType("Origins (Black Ops 2)", 	"origins_hud.png", {}) 
nzRound:AddHUDType("Tranzit (Black Ops 2)", 	"Tranzit (Black Ops 2)", {}) 
nzRound:AddHUDType("nZombies Classic(HD)", 		"HD_hud.png", {}) 
nzRound:AddHUDType("Covenant", 					"covenant_hud.png", {}) 
nzRound:AddHUDType("UNSC", 						"Halo_hud.png", {}) 
nzRound:AddHUDType("Dead Space", 				"deadspace_hud.png", {}) 
nzRound:AddHUDType("Devil May Cry - Dante", 	"DMC_Dante__hud.png", {}) 
nzRound:AddHUDType("Devil May Cry - Nero", 		"DMC_Nero__hud.png", {}) 
nzRound:AddHUDType("Devil May Cry - V", 		"DMC_V__hud.png", {}) 
nzRound:AddHUDType("Devil May Cry - Vergil", 	"DMC_Vergil__hud.png", {}) 
nzRound:AddHUDType("Gears of War", 				"gears_hud.png", {}) 
nzRound:AddHUDType("Killing Floor 2", 			"KF2__hud.png", {}) 
nzRound:AddHUDType("Resident Evil", 			"RE_hud.png", {}) 
nzRound:AddHUDType("Simple (Black)", 			"simple_hud.png", {}) 
nzRound:AddHUDType("Simple (Outline)", 			"simple_hud.png", {}) 
nzRound:AddHUDType("Breen Desk", 				"BREEN.png", {}) 
nzRound:AddHUDType("Castle", 					"bloxo_big.png", {}) 
nzRound:AddHUDType("Sus", 						"kawaii_hud.png", {}) 
nzRound:AddHUDType("Snowglobe",                 "simple_hud2.png", {})
nzRound:AddHUDType("Encampment", 				"simple_hud.png", {}) 
nzRound:AddHUDType("World at War", 				"simple_hud.png", {}) 
nzRound:AddHUDType("Fallout", 					"fallout.png", {}) 
nzRound:AddHUDType("Miku", 						"miku_hud.png", {}) 
nzRound:AddHUDType("BSAA", 						"bsaa_hud.png", {}) 
nzRound:AddHUDType("Deep Rock Galactic", 		"DRG_hud.png", {}) 
nzRound:AddHUDType("Kell", 		"Kell_hud.png", {}) 

function nzRound:GetHUDType(id)
	if id == nil then 
		return "HD_hud.png"
	else
		local check = nzRound.HudSelectData[id].class
		if check then
			return check
		else
			return "HD_hud.png"
		end
	end
end



nzRound.ZombieSkinData = nzRound.ZombieSkinData or {}
function nzRound:AddZombieType(id, class)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.ZombieSkinData[id] = data
		else
			nzRound.ZombieSkinData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.ZombieSkinData[id] = class
	end
end


nzRound:AddZombieType("Ascension", 					"nz_zombie_walker_ascension", {}) 
nzRound:AddZombieType("Anchovies", 					"nz_zombie_walker_anchovy", {})
nzRound:AddZombieType("Ascension(Classic)", 		"nz_zombie_walker_ascension_classic", {})
nzRound:AddZombieType("Armored Zombies(CW)",		"nz_zombie_walker_armoredheavy", {})
nzRound:AddZombieType("Area 51 Guard", 				"nz_zombie_walker_moon_guard", {}) 
nzRound:AddZombieType("Blood of the Dead", 			"nz_zombie_walker_escape", {})														
nzRound:AddZombieType("Bluds", 						"nz_zombie_walker_blud", {})  
nzRound:AddZombieType("Buried", 					"nz_zombie_walker_buried", {}) 
nzRound:AddZombieType("Call of the Dead", 			"nz_zombie_walker_cotd", {}) 
nzRound:AddZombieType("Cheaple", 					"nz_zombie_walker_cheaple", {}) 
nzRound:AddZombieType("Crusader Zombies", 			"nz_zombie_walker_origins_templar", {}) 
nzRound:AddZombieType("Crusader Zombies(Classic)", 	"nz_zombie_walker_origins_templar_classic", {}) 
nzRound:AddZombieType("Das Herrenhaus", 			"nz_zombie_walker_haus", {}) 
nzRound:AddZombieType("Deadbolt", 					"nz_zombie_walker_jup", {}) 
nzRound:AddZombieType("Deadbolt(Charred)", 			"nz_zombie_walker_jup_charred", {}) 
nzRound:AddZombieType("Deadbolt(Armored Heavy)", 	"nz_zombie_walker_jup_heavy", {}) 
nzRound:AddZombieType("Der Eisendrache", 			"nz_zombie_walker_eisendrache", {}) 
nzRound:AddZombieType("Der Riese", 					"nz_zombie_walker_derriese", {}) 
nzRound:AddZombieType("Der Riese(Enhanced)", 		"nz_zombie_walker_derriese_enhanced", {}) 
nzRound:AddZombieType("Dead of the Night", 			"nz_zombie_walker_mansion", {}) 
nzRound:AddZombieType("Die Machine", 				"nz_zombie_walker_diemachine", {}) 
--nzRound:AddZombieType("Die Rise", 					"nz_zombie_walker_dierise", {})
nzRound:AddZombieType("Elves", 						"nz_zombie_walker_elf", {}) 
nzRound:AddZombieType("Minimum Wage",	 			"nz_zombie_walker_exo_brg", {}) 																		  
nzRound:AddZombieType("FIVE", 						"nz_zombie_walker_five", {}) 
nzRound:AddZombieType("FIVE(Classic)", 				"nz_zombie_walker_five_classic", {}) 
nzRound:AddZombieType("Former", 					"nz_zombie_walker_former", {})
nzRound:AddZombieType("Green Flu(Airport)", 		"nz_zombie_walker_greenflu_airport", {})
nzRound:AddZombieType("Green Flu(Military)", 		"nz_zombie_walker_greenflu_military", {})
nzRound:AddZombieType("Green Flu(Hospital)", 		"nz_zombie_walker_greenflu_hospital", {})
nzRound:AddZombieType("Green Flu", 					"nz_zombie_walker_greenflu", {})
nzRound:AddZombieType("Gorod Krovi", 				"nz_zombie_walker_gorodkrovi", {}) 
nzRound:AddZombieType("Headcrab Zombies", 			"nz_zombie_walker_headcrab", {}) 																			  
--nzRound:AddZombieType("Humorous Eves at Fredricks", "nz_zombie_walker_fredricks", {}) 
nzRound:AddZombieType("IX", 						"nz_zombie_walker_ix", {}) 
nzRound:AddZombieType("Kino der Toten", 			"nz_zombie_walker", {}) 
nzRound:AddZombieType("Kino der Toten(Classic)", 	"nz_zombie_walker_classic", {}) 
nzRound:AddZombieType("Leviathan", 					"nz_zombie_walker_leviathan", {})
nzRound:AddZombieType("Mannequins", 				"nz_zombie_walker_mannequin", {})
nzRound:AddZombieType("Mob of the Dead", 			"nz_zombie_walker_hellcatraz", {})
nzRound:AddZombieType("Moon", 						"nz_zombie_walker_moon", {}) 
nzRound:AddZombieType("Moon Tech", 					"nz_zombie_walker_moon_tech", {}) 
nzRound:AddZombieType("Moon(Classic)", 				"nz_zombie_walker_moon_classic", {}) 
nzRound:AddZombieType("Moon MP(Classic)", 			"nz_zombie_walker_moon_classic_guard", {}) 
nzRound:AddZombieType("Nacht Der Untoten", 			"nz_zombie_walker_prototype", {}) 
nzRound:AddZombieType("Nacht Der Untoten(Enhanced)","nz_zombie_walker_prototype_enhanced", {}) 
nzRound:AddZombieType("Nuketown", 					"nz_zombie_walker_nuketown", {}) 
nzRound:AddZombieType("Necromorph", 				"nz_zombie_walker_necromorph", {}) 
nzRound:AddZombieType("Omega Gold", 				"nz_zombie_walker_gold", {}) 
nzRound:AddZombieType("Origins", 					"nz_zombie_walker_origins", {}) 
nzRound:AddZombieType("Origins(Classic)", 			"nz_zombie_walker_origins_classic", {}) 
nzRound:AddZombieType("Outbreak", 					"nz_zombie_walker_outbreak", {}) 
nzRound:AddZombieType("Police Zombies(IW)",			"nz_zombie_walker_park_cop", {})
nzRound:AddZombieType("Revelations", 				"nz_zombie_walker_genesis", {}) 
nzRound:AddZombieType("Science Team", 				"nz_zombie_walker_kleiner", {})  
nzRound:AddZombieType("Sentinel Zombies", 			"nz_zombie_walker_sentinel", {})
nzRound:AddZombieType("Shadows of Evil", 			"nz_zombie_walker_zod", {}) 
nzRound:AddZombieType("Shangri-La", 				"nz_zombie_walker_shangrila", {}) 
nzRound:AddZombieType("Shangri-La(Classic)", 		"nz_zombie_walker_shangrila_classic", {}) 
nzRound:AddZombieType("Shi no Numa", 				"nz_zombie_walker_sumpf", {}) 
nzRound:AddZombieType("Shi no Numa(Classic)", 		"nz_zombie_walker_sumpf_classic", {}) 
nzRound:AddZombieType("Spaceland Zombies",			"nz_zombie_walker_park", {})
nzRound:AddZombieType("Skeleton", 					"nz_zombie_walker_skeleton", {}) 
nzRound:AddZombieType("Tag Der Toten", 				"nz_zombie_walker_orange", {}) 
nzRound:AddZombieType("Tranzit", 					"nz_zombie_walker_greenrun", {}) 
nzRound:AddZombieType("Vanguard Zombies", 			"nz_zombie_walker_griddy", {})
nzRound:AddZombieType("Voyage of Despair", 			"nz_zombie_walker_titanic", {}) 
nzRound:AddZombieType("WWII Zombies", 				"nz_zombie_walker_ww2", {})
nzRound:AddZombieType("WWII Zombies(3arc Styled)", 	"nz_zombie_walker_ww2_3arc", {})
nzRound:AddZombieType("Xenomorph", 					"nz_zombie_walker_xeno", {}) 
nzRound:AddZombieType("Zetsubou no Shima", 			"nz_zombie_walker_zetsubou", {}) 
nzRound:AddZombieType("Zombies in Spaceland", 		"nz_zombie_walker_clown", {}) 
nzRound:AddZombieType("Flood (Classic Elite)", 		"nz_zombie_walker_floodelite", {}) 
nzRound:AddZombieType("Flood (Elite)", 		"nz_zombie_walker_floodelite3", {}) 
nzRound:AddZombieType("Flood (Classic Marine)", 		"nz_zombie_walker_floodunsc", {}) 
nzRound:AddZombieType("Flood (Marine)", 		"nz_zombie_walker_floodunsc3", {}) 
nzRound:AddZombieType("Flood (Brute)", 		"nz_zombie_walker_floodbrute",   {}) 

function nzRound:GetZombieType(id)
	if id == nil then 
		return "nz_zombie_walker"
	else
		local check = nzRound.ZombieSkinData[id].class
		return check
	end
end


-- Moo Mark. I refuse to touch anything below this point. It is absolutely hideous


nzRound.SpecialData = nzRound.SpecialData or {}
function nzRound:AddSpecialRoundType(id, data, spawnfunc, roundfunc, endfunc)
	if SERVER then
		nzRound.SpecialData[id] = {}
		-- Zombie data, like those in the configuration files
		nzRound.SpecialData[id].data = data
		-- Optional spawn function, runs when a zombie spawns (can be used to set health, speed, etc)
		if spawnfunc then nzRound.SpecialData[id].spawnfunc = spawnfunc end
		-- Optional round function, runs when the round starts (can be used to set amount, sounds, fog, etc)
		if roundfunc then nzRound.SpecialData[id].roundfunc = roundfunc end
		-- Optional end function, runs when the special round ends (can be used to clean up changes)
		if endfunc then nzRound.SpecialData[id].endfunc = endfunc end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.SpecialData[id] = (data and true or nil)
	end
end

nzRound:AddSpecialRoundType("Frogs", {
	specialTypes = {
		["nz_zombie_special_frog"] = {chance = 100}
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
	}, 
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(120, 1200))
		else
			local hp = 80
			for i=1,nzRound:GetNumber() do 
			hp = hp* 1.3
			end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Hunter Beta", {
	specialTypes = {
		["nz_zombie_special_hunterbeta"] = {chance = 100}
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
	}, 
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(120, 1200))
		else
			local hp = 54
			for i=1,nzRound:GetNumber() do 
			hp = hp* 1.15

			if hp > 750 then
				hp = 750
			end
		end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

--[[
nzRound:AddSpecialRoundType("Cosmic Monkies", {	specialTypes = {
		["nz_zombie_special_cosmo_monkey"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 100
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 7500 then
				hp = 7500
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func
]]

nzRound:AddSpecialRoundType("Cryptids", {
	specialTypes = {
		["nz_zombie_special_alien_scout"] = {chance = 100},
		["nz_zombie_special_alien_scorpion"] = {chance = 100},
		["nz_zombie_special_alien_seeker"] = {chance = 100},
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.15, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function(original) return math.floor(original * 0.5) end, -- Modify the count
	},
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(50,250))
		else
			local hp = 15
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 5000 then
				hp = 5000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Cryptids(Scouts)", {
	specialTypes = {
		["nz_zombie_special_alien_scout"] = {chance = 100},
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.15, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function(original) return math.floor(original * 0.5) end, -- Modify the count
	},
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(50,250))
		else
			local hp = 15
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 5000 then
				hp = 5000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Cryptids(Scorpions)", {
	specialTypes = {
		["nz_zombie_special_alien_scorpion"] = {chance = 100},
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.15, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function(original) return math.floor(original * 0.5) end, -- Modify the count
	},
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(50,250))
		else
			local hp = 15
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 5000 then
				hp = 5000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Cryptids(Seekers)", {
	specialTypes = {
		["nz_zombie_special_alien_seeker"] = {chance = 100},
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.15, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function(original) return math.floor(original * 0.5) end, -- Modify the count
	},
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(50,250))
		else
			local hp = 15
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 5000 then
				hp = 5000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Boom Schreiers", {
	specialTypes = {
		["nz_zombie_special_screamer"] = {chance = 100}
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.15, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function(original) return math.floor(original * 0.5) end, -- Modify the count
	},
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(50,250))
		else
			local hp = 75
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 2000 then
				hp = 2000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("PD2 Cloakers", {
	specialTypes = {
		["nz_zombie_special_spook"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 12) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 500
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 1500 then
				hp = 1500
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Juggernauts", {
	specialTypes = {
		["nz_zombie_special_juggernaut"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 18) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 1500
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 5000 then
				hp = 5000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func
nzRound:AddSpecialRoundType("Sizzlers", {
	specialTypes = {
		["nz_zombie_special_siz"] = {chance = 100}
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.15, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function(original) return math.floor(original * 0.5) end, -- Modify the count
	},
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(50,250))
		else
			local hp = 50
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 1000 then
				hp = 1000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Pest Zombies", {
	specialTypes = {
		["nz_zombie_special_sprinter"] = {chance = 100}
	},
		specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
		specialCountMod = function(original) return math.floor(original * 0.5) end, -- Modify the count
	},
	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(50,250))
		else
			local hp = 50
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 200 then
				hp = 200
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Radroaches", {
	specialTypes = {
		["nz_zombie_special_roach"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 30
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func
nzRound:AddSpecialRoundType("Sentinel Bots", {
	specialTypes = {
		["nz_zombie_special_bot"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 100
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Bomber Zombies", {
	specialTypes = {
		["nz_zombie_special_bomba"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 75
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Terrorist Zombies", {
	specialTypes = {
		["nz_zombie_special_terrorist"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 12, 96) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(150,500))
		else
			local hp = 150
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.15
			if hp > 1200 then
				hp = 1200
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Grenade Zombies", {
	specialTypes = {
		["nz_zombie_special_grenade"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 12, 96) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(150,500))
		else
			local hp = 150
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.15
			if hp > 1200 then
				hp = 1200
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Task Force", {
	specialTypes = {
		["nz_zombie_special_grenade"] = {chance = 100},
		["nz_zombie_special_terrorist"] = {chance = 100},
		["nz_zombie_special_juggernaut"] = {chance = 15},
		["nz_zombie_special_spook"] = {chance = 1},
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 12, 96) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(150,500))
		else
			local hp = 150
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.15
			if hp > 1200 then
				hp = 1200
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Cloakers", {
	specialTypes = {
		["nz_zombie_special_cloaker"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 12, 96) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 100
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 900 then
				hp = 900
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Spider Crawlers", {
	specialTypes = {
		["nz_zombie_special_crawler"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 100
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 900 then
				hp = 900
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func


nzRound:AddSpecialRoundType("Cloverfield Parasites", {
	specialTypes = {
		["nz_zombie_special_cloverfield"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 90
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.2
			if hp > 900 then
				hp = 850
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Xenomorphs", {
	specialTypes = {
		["nz_zombie_special_xeno_runner"] = {chance = 100},
		["nz_zombie_special_xeno_spitter"] = {chance = 75},
		["nz_zombie_special_xeno_brute"] = {chance = 50}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 100
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 900 then
				hp = 900
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("SS Fire Skeletons", {
	specialTypes = {
		["nz_zombie_special_ss_fire"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 48) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(1000,2000))
		else
			local hp = 500
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 2000 then
				hp = 2000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("IW Clowns", {
	specialTypes = {
		["nz_zombie_special_clown"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 12, 96) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(500,1000))
		else
			local hp = 100
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.15
			if hp > 1500 then
				hp = 1500
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Apothicon Furies", {
	specialTypes = {
		["nz_zombie_special_fury"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 12, 96) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(500,1000))
		else
			local hp = 100
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.15
			if hp > 1500 then
				hp = 1500
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Hellhounds", {
	specialTypes = {
		["nz_zombie_special_dog"] = {chance = 100}
	},												-- Moo Mark. Changed this cause the numbers were way too low and resulted in spamming of dogs.
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
		local hp = 50
		for i=1,nzRound:GetNumber() do 
			hp = hp * 1.10
		end
		if hp <= 400 then
			dog:SetHealth(hp)
		else
			dog:SetHealth(400)
		end
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Hellhounds(BO4)", {
	specialTypes = {
		["nz_zombie_special_dog_zhd"] = {chance = 100}
	},												-- Moo Mark. Changed this cause the numbers were way too low and resulted in spamming of dogs.
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
		local hp = 50
		for i=1,nzRound:GetNumber() do 
			hp = hp * 1.10
		end
		if hp <= 400 then
			dog:SetHealth(hp)
		else
			dog:SetHealth(400)
		end
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Plaguehounds", {
	specialTypes = {
		["nz_zombie_special_dog_gas"] = {chance = 100}
	},												-- Moo Mark. Changed this cause the numbers were way too low and resulted in spamming of dogs.
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
		local hp = 50
		for i=1,nzRound:GetNumber() do 
			hp = hp * 1.10
		end
		if hp <= 400 then
			dog:SetHealth(hp)
		else
			dog:SetHealth(400)
		end
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Hellhounds(Cold War)", {
	specialTypes = {
		["nz_zombie_special_dog_fire"] = {chance = 100}
	},												-- Moo Mark. Changed this cause the numbers were way too low and resulted in spamming of dogs.
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
		local hp = 50
		for i=1,nzRound:GetNumber() do 
			hp = hp * 1.10
		end
		if hp <= 400 then
			dog:SetHealth(hp)
		else
			dog:SetHealth(400)
		end
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("RELEASE THE DOGS", {
	specialTypes = {
		["nz_zombie_special_dog"] = {chance = 100},
		["nz_zombie_special_dog_zhd"] = {chance = 100},
		["nz_zombie_special_dog_gas"] = {chance = 100},
		["nz_zombie_special_dog_fire"] = {chance = 100},
	},												-- Moo Mark. Changed this cause the numbers were way too low and resulted in spamming of dogs.
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
		local hp = 50
		for i=1,nzRound:GetNumber() do 
			hp = hp * 1.10
		end
		if hp <= 400 then
			dog:SetHealth(hp)
		else
			dog:SetHealth(400)
		end
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Helldonkeys", {
	specialTypes = {
		["nz_zombie_special_donkey"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 55
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.13
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Keepers", {
	specialTypes = {
		["nz_zombie_special_keeper"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 50
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.05
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Tempests", {
	specialTypes = {
		["nz_zombie_special_tempest"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 50
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.05
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Nova Crawlers", {
	specialTypes = {
		["nz_zombie_special_nova"] = {chance = 100},
		["nz_zombie_special_nova_bomber"] = {chance = 75},
		["nz_zombie_special_nova_electric"] = {chance = 50}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 40
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Lickers", {
	specialTypes = {
		["nz_zombie_special_licker"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 54
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.17
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Raptors", {
	specialTypes = {
		["nz_zombie_special_raptor"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 70
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.05
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Facehuggers", {
	specialTypes = {
		["nz_zombie_special_facehugger"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(50)
	else
	local hp = 32
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("The Pack (Dead Space)", {
	specialTypes = {
		["nz_zombie_special_pack"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 50
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Spiders", {
	specialTypes = {
		["nz_zombie_special_spooder"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, function(dog) -- We want to modify health
	local round = nzRound:GetNumber()
	if round == -1 then
		dog:SetHealth(math.random(120, 1200))
	else
	local hp = 48
	for i=1,nzRound:GetNumber() do 
	hp = hp* 1.1
								end 
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Tickers", {
	specialTypes = {
		["nz_zombie_special_ticker"] = {chance = 100},
		["nz_zombie_special_wildticker"] = {chance = 35}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 300
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.2
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Wretch", {
	specialTypes = {
		["nz_zombie_special_wretch"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 450
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.2
			if hp > 2000 then
				hp = 2000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Sire", {
	specialTypes = {
		["nz_zombie_special_sire"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 666
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.2
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Nemacyte", {
	specialTypes = {
		["nz_zombie_special_nemacyte"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 150
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.2
			if hp > 1000 then
				hp = 1000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Run Yo Pockets", {
	specialTypes = {
		["nz_zombie_special_wildticker"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 9, 72) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
			local hp = 450
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.2
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Deathclaw", {
	specialTypes = {
		["nz_zombie_special_deathclaw"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(500,1500))
		else
			local hp = 500
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 2000 then
				hp = 2000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func
	
nzRound:AddSpecialRoundType("Pentagon Thief", {
	specialTypes = {
		["nz_zombie_special_electrician"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return 1 end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		local count = #player.GetAllPlaying()
		if round == -1 then
			dog:SetHealth(10000)
		else
		dog:SetHealth(math.Clamp(round * 2000 + (4000 * count), 10000, 60000))
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Glowing Ghouls", {
	specialTypes = {
		["nz_zombie_special_glowingone"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 24) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(500,1500))
		else
			local hp = 100
			for i = 1, nzRound:GetNumber() do 
			hp = hp * 1.1
			if hp > 2000 then
				hp = 2000
			end
		end
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Buried Witches", {
	specialTypes = {
		["nz_zombie_special_ghost"] = {chance = 100}
	},
	specialDelayMod = function() return math.Clamp(2 - #player.GetAllPlaying()*0.5, 0.5, 2) end, -- Dynamically change spawn speed depending on player count
	specialCountMod = function() return math.Clamp(nzRound:GetNumber() * #player.GetAllPlaying(), 6, 30) end, -- Modify the count
}, 	function(dog) -- We want to modify health
		local round = nzRound:GetNumber()
		if round == -1 then
			dog:SetHealth(math.random(100,500))
		else
		local hp = math.random(100,500)
		dog:SetHealth(hp)
	end
end) -- No round func or end func

nzRound:AddSpecialRoundType("Catalyst Zombies", {
	normalTypes = {
		["nz_zombie_special_catalyst_plasma"] = {chance = 100},
		["nz_zombie_special_catalyst_water"] = {chance = 100},
		["nz_zombie_special_catalyst_decay"] = {chance = 100},
		["nz_zombie_special_catalyst_electric"] = {chance = 100}
	},
	normalDelay = 0.75,
	normalCountMod = function(original) return math.floor(original * 0.5) end,
})

function nzRound:GetSpecialType(id)
	if SERVER then
		if class then
			local data = {}
			-- Which entity to spawn
			data.class = class
			nzRound.AdditionalZombieData[id] = data
		else
			nzRound.AdditionalZombieData[id] = nil -- Remove it if no valid class was added
		end
	else
		-- Clients only need it for the dropdown, no need to actually know the data and such
		nzRound.AdditionalZombieData[id] = class
	end
end
