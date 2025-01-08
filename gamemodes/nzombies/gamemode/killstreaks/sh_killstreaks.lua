-- Made by Hari exclusive for nZombies Rezzurection. Copying this code is prohibited!

nzKillstreak = nzKillstreak or {}
nzKillstreak.List = {
    ["Armor Plate"] = {
        cost = 50,
        desc = "Reduces incoming damage. Destroyed after it absorbs too much damage.",
        icon = Material("bo6/hud/plate.png"),
        check = function(ply)
            return ply:GetNWInt("ArmorPlates") < nzSettings:GetSimpleSetting("BO6_Armor_MaxPlates", 3)
        end,
        buy = function(ply)
            if ply:GetNWInt("ArmorPlates") < nzSettings:GetSimpleSetting("BO6_Armor_MaxPlates", 3) then
                ply:SetNWInt("ArmorPlates", ply:GetNWInt("ArmorPlates")+1)
                ply:EmitSound("bo6/other/armorplate_pickup.wav", 60)
            end
        end,
    },
    ["Hand Cannon"] = {
        cost = 1250,
        desc = "Gold plated semi-automatic with high power. Effective at close range.",
        icon = Material("bo6/hud/pistol.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_cannon"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_cannon")
        end,
    },
    ["LDBR"] = {
        cost = 1250,
        desc = "Launch a missile bombardment in a targeted area for a duration.",
        icon = Material("bo6/hud/ldbr.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_ldbr"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_ldbr")
        end,
    },
    ["Mangler Injection"] = {
        cost = 2500,
        desc = "Temporarily transforms you into a Mangler… with all the bells and whistles.",
        icon = Material("bo6/hud/injection.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_mangler"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_mangler")
        end,
    },
    ["Napalm Strike"] = {
        cost = 1250,
        desc = "Launch a targeted strike of explosive napalm.",
        icon = Material("bo6/hud/napalm.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_napalm"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_napalm")
        end,
    },
    ["Sentry Turret"] = {
        cost = 1500,
        desc = "Automated turret that scans for and attacks nearby enemies in a forward facing cone.",
        icon = Material("bo6/hud/sentry.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_sentry"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_sentry")
        end,
    },
    ["Death Machine"] = {
        cost = 1500,
        desc = "Deadly machine gun with high damage rounds that suppress enemies in the line of fire.",
        icon = Material("bo6/hud/death.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_death"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_death")
        end,
    },
    ["VTOL Jet"] = {
        cost = 1500,
        desc = "Releases a pair of precision bombs before circling back and guarding a location.",
        icon = Material("bo6/hud/vtol.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_vtol"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_vtol")
        end,
    },
    ["ARC-XD"] = {
        cost = 1000,
        desc = "Deploys a small remote controlled, remote detonated explosive vehicle.",
        icon = Material("bo6/hud/rcxd.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_rcxd"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_rcxd")
        end,
    },
    ["DNA Bomb"] = {
        cost = 5000,
        desc = "A missile will fly into the map and explode in the air. All zombies, except bosses will killed.",
        icon = Material("bo6/hud/dna.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_dna"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_dna")
        end,
    },
    ["Chopper Gunner"] = {
        cost = 2500,
        desc = "Take control of the door gun turret on an assault chopper.",
        icon = Material("bo6/hud/chopper.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_chopper"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_chopper")
        end,
    },
    ["Hellstorm"] = {
        cost = 1250,
        desc = "Control a long range missile with brake and boost capabilities and secondary missiles.",
        icon = Material("bo6/hud/hellstorm.png"),
        check = function(ply)
            return ply:HaveKillstreak() != "bo6_killstreak_hellstorm"
        end,
        buy = function(ply)
            ply:GiveKillstreak("bo6_killstreak_hellstorm")
        end,
    },
}
nzKillstreak.ClassToIcon = {
    ["bo6_killstreak_cannon"] = Material("bo6/hud/pistol.png", "mips"),
    ["bo6_killstreak_ldbr"] = Material("bo6/hud/ldbr.png", "mips"),
    ["bo6_killstreak_mangler"] = Material("bo6/hud/injection.png", "mips"),
    ["bo6_killstreak_chopper"] = Material("bo6/hud/chopper.png", "mips"),
    ["bo6_killstreak_hellstorm"] = Material("bo6/hud/hellstorm.png", "mips"),
    ["bo6_killstreak_dna"] = Material("bo6/hud/dna.png", "mips"),
    ["bo6_killstreak_rcxd"] = Material("bo6/hud/rcxd.png", "mips"),
    ["bo6_killstreak_napalm"] = Material("bo6/hud/napalm.png", "mips"),
    ["bo6_killstreak_death"] = Material("bo6/hud/death.png", "mips"),
    ["bo6_killstreak_vtol"] = Material("bo6/hud/vtol.png", "mips"),
    ["bo6_killstreak_sentry"] = Material("bo6/hud/sentry.png", "mips"),
}
nzKillstreak.Specials = {
    "nz_zombie_special_disciple",
    "nz_zombie_special_mimic",
    "nz_zombie_special_raz",
    "nz_zombie_special_raz_jup",
    "nz_zombie_special_raz_t10",
    "nz_zombie_special_juggernaut",
    "nz_zombie_special_goliathcodol",
}

local pl = FindMetaTable("Player")
    
function pl:GetSVAnim()
    return self:GetNWString('SVAnim', '')
end

function pl:HaveKillstreak()
    for _, w in pairs(self:GetWeapons()) do
        if string.match(w:GetClass(), "bo6_killstreak_") then
            return w:GetClass()
        end
    end
    return false
end

function nzKillstreak:CheckLimit(type)
    local count = 0
    local max, class = 0, ""
    if type == "chopper" then
        max, class = 1, "bo6_choppergunner"
    elseif type == "vtol" then
        max, class = 1, "bo6_vtol"
    elseif type == "sentry" then
        max, class = 2, "bo6_sentry"
    end
    for _, ent in pairs(ents.FindByClass("bo6_*")) do
        if ent:GetClass() == class then
            count = count + 1
        end
    end
    return max > count
end

---------------MANGLER-----------

local speedTab = {
    ["nz_base_zmb_raz_attack_shoot_02"] = 25,
    ["nz_base_zmb_raz_attack_sickle_swing_down"] = 20,
    ["nz_base_zmb_raz_attack_sickle_swing_l_to_r"] = 20,
    ["nz_base_zmb_raz_attack_sickle_swing_r_to_l"] = 20,
    ["nz_base_zmb_raz_attack_sickle_swing_uppercut"] = 20,
    ["nz_base_zmb_raz_attack_swing_l_to_r"] = 20,
    ["nz_base_zmb_raz_attack_swing_r_to_l"] = 20,
    ["nz_base_zmb_raz_attack_sickle_double_swing_1"] = 20,
    ["nz_base_zmb_raz_attack_sickle_double_swing_2"] = 20,
    ["nz_base_zmb_raz_attack_sickle_double_swing_3"] = 20,
    ["nz_base_zmb_raz_enrage"] = 15,
    ["nz_base_zmb_raz_stun_in"] = 1,
}
hook.Add("SetupMove", "nzrKillstreaks", function( ply, mv, cmd )
    if ply:GetModel() == "models/moo/_codz_ports/t10/zm/moo_codz_t10_mangler.mdl" then
        local speed = speedTab[ply:GetSVAnim()]
        if speed then
            mv:SetMaxSpeed(speed)
            mv:SetMaxClientSpeed(speed)
        else
            mv:SetMaxSpeed(200)
            mv:SetMaxClientSpeed(200)
        end
    end
end)

hook.Add("CalcMainActivity", "!nzrAnims", function(ply, vel)
	local str = ply:GetNWString('SVAnim')
	local num = ply:GetNWFloat('SVAnimDelay')
	local st = ply:GetNWFloat('SVAnimStartTime')

	if str ~= "" then
		ply:SetCycle((CurTime() - st) / num)
		return -1, ply:LookupSequence(str)
	end
end)

-----------------------------