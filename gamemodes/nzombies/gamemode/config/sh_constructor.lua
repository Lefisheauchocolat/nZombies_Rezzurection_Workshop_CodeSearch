-- Main Tables
nzConfig = nzConfig or AddNZModule("Config")

--  Defaults

if not ConVarExists("nz_randombox_whitelist") then CreateConVar("nz_randombox_whitelist", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end
if not ConVarExists("nz_downtime") then CreateConVar("nz_downtime", 45, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_GAMEDLL}) end
if not ConVarExists("nz_revivetime") then CreateConVar("nz_revivetime", 4, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_GAMEDLL}) end
if not ConVarExists("nz_nav_grouptargeting") then CreateConVar("nz_nav_grouptargeting", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
if not ConVarExists("nz_round_special_interval") then CreateConVar("nz_round_special_interval", 6, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
if not ConVarExists("nz_round_prep_time") then CreateConVar("nz_round_prep_time", 10, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
if not ConVarExists("nz_randombox_maplist") then CreateConVar("nz_randombox_maplist", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
if not ConVarExists("nz_round_dropins_allow") then CreateConVar("nz_round_dropins_allow", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
 -- Modified in configs now:
--if not ConVarExists("nz_difficulty_max_zombies_alive") then CreateConVar("nz_difficulty_max_zombies_alive", 35, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
if not ConVarExists("nz_difficulty_barricade_planks_max") then CreateConVar("nz_difficulty_barricade_planks_max", 6, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
if not ConVarExists("nz_difficulty_powerup_chance") then CreateConVar("nz_difficulty_powerup_chance", 2, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
if not ConVarExists("nz_difficulty_perks_max") then CreateConVar("nz_difficulty_perks_max", 4, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_GAMEDLL}) end
if not ConVarExists("nz_difficulty_respawn_on_players") then CreateConVar("nz_difficulty_respawn_on_players", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_GAMEDLL}, "Enable or disable players respawning on other players in co-op. PLEASE HAVE A DISABLED PLAYER COLLISIONS MOD. (0 Disable, 1 Enabled)", 0, 1) end
if not ConVarExists("nz_point_notification_clientside") then CreateConVar("nz_point_notification_clientside", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}) end
if not ConVarExists("nz_zombie_lagcompensated") then CreateConVar("nz_zombie_lagcompensated", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end
if not ConVarExists("nz_spawnpoint_update_rate") then CreateConVar("nz_spawnpoint_update_rate", 4, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end
if not ConVarExists("nz_rtv_time") then CreateConVar("nz_rtv_time", 45, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end
if not ConVarExists("nz_rtv_enabled") then CreateConVar("nz_rtv_enabled", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end

if not ConVarExists("nz_oldwallbuys") then CreateConVar("nz_oldwallbuys", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end
if not ConVarExists("nz_weapon_auto_reload") then CreateConVar("nz_weapon_auto_reload", 1, {FCVAR_USERINFO, FCVAR_ARCHIVE}) end

if not ConVarExists("nz_zombie_eye_trails") then CreateConVar("nz_zombie_eye_trails", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end
if not ConVarExists("nz_oldtunes") then CreateConVar("nz_oldtunes", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end
if not ConVarExists("nz_difficulty_zombie_stumble") then CreateConVar("nz_difficulty_zombie_stumble", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE}) end
if not ConVarExists("nz_rounds_survived_classic") then CreateConVar("nz_rounds_survived_classic", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Enable for the game over 'Rounds Survived' amount to count the current round, like in classic zombies. (0 Disable, 1 Enabled)", 0, 1) end
if not ConVarExists("nz_sky_intro_always") then CreateClientConVar("nz_sky_intro_always", 0, true, true, "Enable for the MW3 Survival intro to always play when spawning, regardless of map setting. This only applies to your client! (0 false, 1 true), Default is 0.", 0, 1) end
if not ConVarExists("nz_sky_intro_bloom") then CreateClientConVar("nz_sky_intro_bloom", 1, true, true, "Enable or disable bloom effect when MW3 Survival intro finishes playing. (0 false, 1 true), Default is 1.", 0, 1) end
if not ConVarExists("nz_sky_intro_viewpunch") then CreateClientConVar("nz_sky_intro_viewpunch", 1, true, true, "Enable or disable viewpunch applied to player when MW3 Survival intro finishes playing. Default is 1.", 0, 1) end
if not ConVarExists("nz_sky_intro_server_allow") then CreateConVar("nz_sky_intro_server_allow", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Enable or disable allowing clients to always play the MW3 Survival intro on your server (0 false, 1 true), Default is 1.", 0, 1) end

if not ConVarExists("nz_clan_tag") then CreateClientConVar("nz_clan_tag", "", true, true, "Clan tag, default only your friends can see your clan tag, set to nothing to disable. (LIMITED TO 5 CHARACTERS)") end
if not ConVarExists("nz_clan_icon") then CreateClientConVar("nz_clan_icon", "", true, true, "Clan icon, path/to/icon.png, appears next to your name plate in thirdperson, default only your friends can see your clan icon. (LIMITED TO 61 CHARACTERS)") end

cvars.AddChangeCallback("nz_downtime", function(name, old, new)
	for _, ply in pairs(player.GetAll()) do
		local gum = nzGum:GetActiveGum(ply)
		if gum and gum == "coagulant" then
			ply:SetBleedoutTime(tonumber(new) + 120)
		else
			ply:SetBleedoutTime(tonumber(new))
		end
	end
end)

cvars.AddChangeCallback("nz_revivetime", function(name, old, new)
	for _, ply in pairs(player.GetAll()) do
		ply:SetReviveTime(tonumber(new))
	end
end)

local zombieconfig = {
	"walker",
	"walker_anchovy",
	"walker_buried",
	"walker_five",
	"walker_haus",
	"walker_hazmat",
	"walker_jup",
	"walker_jup_charred",
	"walker_jup_heavy",
	"walker_escape",
	"walker_hellcatraz",
	"walker_moon",
	"walker_moon_guard",
	"walker_moon_tech",
	"walker_eisendrache",
	"walker_exo",
	"walker_exo_brg",
	"walker_origins",
	"walker_origins_classic",
	"walker_origins_soldier",
	"walker_origins_templar",
	"walker_origins_templar_classic",
	"walker_outbreak",
	"walker_shangrila",
	"walker_shangrila_classic",
	"walker_sumpf",
	"walker_sumpf_classic",
	"walker_ascension",
	"walker_cotd",
	"walker_nuketown",
	"walker_clown",
	"walker_greenrun",
	"walker_deathtrooper",
	"walker_skeleton",
	"walker_genesis",
	"walker_gorodkrovi",
	"walker_zod",
	"walker_zetsubou",
	"walker_necromorph",
	"walker_xeno",
	"walker_fredricks",
	"walker_fredricks_canon",
	"walker_former",
	"walker_kleiner",
	"walker_cheaple",
	"walker_mansion",
	"walker_titanic",
	"walker_ix",
	"walker_greenflu_airport",
	"walker_greenflu_military",
	"walker_greenflu_hospital",
	"walker_greenflu_riot",
	"walker_greenflu",
	"walker_greenflu_c_ci",
	"walker_greenflu_c_ci_hospital",
	"walker_greenflu_c_ci_airport",
	"walker_dierise",
	"walker_prototype",
	"walker_derriese",
	"walker_prototype_enhanced",
	"walker_derriese_enhanced",
	"walker_ascension_classic",
	"walker_classic",
	"walker_classic_wii",
	"walker_moon_classic",
	"walker_moon_classic_guard",
	"walker_five_classic",
	"walker_orange",
	"walker_diemachine",
	"walker_gold",
	"walker_sentinel",
	"walker_ww2",
	"walker_ww2_3arc",
	"walker_griddy",
	"walker_mannequin",
	"walker_leviathan",
	"walker_armoredheavy",
	"walker_park_3arc",
	"walker_park_cop",
	"walker_park",
	"walker_blud",
	"walker_elf",
	"walker_headcrab",
	"walker_nut",
	"walker_quartz_lab",
	"walker_quartz_hazmat",
	"walker_seal",
	"walker_lmghost",
	"walker_poolday",
	"walker_cyborg",

	"special_alien_scout",
	"special_alien_scorpion",
	"special_alien_seeker",
	"walker_floodbrute",
	"walker_floodunsc",
	"walker_floodunsc3",
	"walker_floodelite",
	"walker_floodelite3",
	"special_bomba",
	"special_bot",
	--"special_cosmo_monkey",
	"special_catalyst_electric",
	"special_catalyst_decay",
	"special_catalyst_plasma",
	"special_catalyst_water",
	"special_chestburster",
	"special_cloaker",
	"special_crawler",
	"special_disciple",
	"special_dog",
	"special_dog_zhd",
	"special_dog_gas",
	"special_dog_fire",
	"special_dog_jup",
	"special_dog_cyborg",
	"special_elf_bomber",
	"special_facehugger",
	"special_follower",
	"special_frog",
	"special_fury",
	"special_grenade",
	"special_hunterbeta",
	"special_husk",
	"special_keeper",
	"special_licker",
	"special_leaper",
	"special_l4d_hunter",
	"special_l4d_smoker",
	"special_mimic",
	"special_nemacyte",
	"special_nova",
	"special_nova_moon",
	"special_nova_electric",
	"special_nova_bomber",
	"special_pack",
	"special_raptor",
	"special_roach",
	"special_screamer",
	"special_spooder",
	"special_sprinter",
	"special_sire",
	"special_siz",
	"special_ss_fire",
	"special_terrorist",
	"special_tempest",
	"special_tormentor",
	"special_ticker",
	"special_wildticker",
	"special_wretch",
	"special_xeno_runner",
	"special_xeno_spitter",
	"special_xeno_brute",
	"special_clown",
	"special_deathclaw",
	"special_glowingone",
	"special_electrician",
	"special_ghost",
	"special_spook",
	"special_juggernaut",
	"special_cloverfield",
	"special_l4d_charger",
	"special_toxic_hazmat",
	"special_toxic_hazmat_codol",
	"special_toxic_hazmat_zhd",
	"special_scrake",
	"special_goliathcodol",
	"special_snowman",
	
	"special_raz",
	"special_raz_jup",
	"special_raz_t10",
}


-- Zombie table - Moved to shared area for client collision prediction (barricades)
nzConfig.ValidEnemies = {}

for k, v in pairs(zombieconfig) do
	nzConfig.ValidEnemies["nz_zombie_" .. v] = {
		-- Set to false to disable the spawning of this zombie
		Valid = true,
		-- Allow you to scale damage on a per-hitgroup basis
		--[[ScaleDMG = function(zombie, hitgroup, dmginfo)
			-- Headshots for double damage
			if hitgroup == HITGROUP_HEAD and v != "walker_necromorph" and v != "special_bot" and v != "walker_xeno" then dmginfo:ScaleDamage(2.5) end
		end,]]
		-- Function runs whenever the zombie is damaged (NOT when killed)
		--[[OnHit = function(zombie, dmginfo, hitgroup)
			local attacker = dmginfo:GetAttacker()
			-- If player is playing and is not downed, give points
			if attacker:IsPlayer() and attacker:GetNotDowned() then
				attacker:GivePoints(10)
			end
		end,]]
		-- Function is run whenever the zombie is killed
		--[[OnKilled = function(zombie, dmginfo, hitgroup)
			local attacker = dmginfo:GetAttacker()

			if attacker:IsPlayer() and attacker:GetNotDowned() then
				if dmginfo:GetDamageType() == DMG_CLUB or dmginfo:GetDamageType() == DMG_SLASH then
					attacker:GivePoints(130)
				elseif (zombie.GetDecapitated and zombie:GetDecapitated()) then -- It shouldn't matter if the hitgroup was the head, if the zombie was decapitated period, it should count as a headshot.
					attacker:GivePoints(100)
				else
					attacker:GivePoints(60)
				end
			end
		end]]
	}
end

-- Random Box

nzConfig.WeaponBlackList = {}
function nzConfig.AddWeaponToBlacklist( class, remove )
	nzConfig.WeaponBlackList[class] = remove and nil or true
end

nzConfig.AddWeaponToBlacklist( "weapon_base" )
nzConfig.AddWeaponToBlacklist( "weapon_fists" )
nzConfig.AddWeaponToBlacklist( "weapon_flechettegun" )
nzConfig.AddWeaponToBlacklist( "weapon_medkit" )
nzConfig.AddWeaponToBlacklist( "weapon_dod_sim_base" )
nzConfig.AddWeaponToBlacklist( "weapon_dod_sim_base_shot" )
nzConfig.AddWeaponToBlacklist( "weapon_dod_sim_base_snip" )
nzConfig.AddWeaponToBlacklist( "weapon_sim_admin" )
nzConfig.AddWeaponToBlacklist( "weapon_sim_spade" )
nzConfig.AddWeaponToBlacklist( "fas2_base" )
nzConfig.AddWeaponToBlacklist( "fas2_ammobox" )
nzConfig.AddWeaponToBlacklist( "fas2_ifak" )
nzConfig.AddWeaponToBlacklist( "nz_multi_tool" )
nzConfig.AddWeaponToBlacklist( "nz_grenade" )
nzConfig.AddWeaponToBlacklist( "nz_perk_bottle" )
nzConfig.AddWeaponToBlacklist( "nz_quickknife_crowbar" )
nzConfig.AddWeaponToBlacklist( "nz_knife_butterfly" )
nzConfig.AddWeaponToBlacklist( "nz_knife_boring" )
nzConfig.AddWeaponToBlacklist( "nz_knife_lukewarmconflict" )
nzConfig.AddWeaponToBlacklist( "nz_knife_wrench" )
nzConfig.AddWeaponToBlacklist( "nz_tool_base" )
nzConfig.AddWeaponToBlacklist( "nz_one_inch_punch" ) -- Nope! You gotta give this with special map scripts

nzConfig.AddWeaponToBlacklist( "cw_base" )

nzConfig.WeaponWhiteList = {
	"fas2_", "m9k_", "tfa_",
}


