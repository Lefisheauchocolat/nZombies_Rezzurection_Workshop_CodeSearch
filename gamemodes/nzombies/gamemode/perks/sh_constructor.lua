-- Main Tables
nzPerks = nzPerks or AddNZModule("Perks")
nzPerks.Data = nzPerks.Data or {}

-- Variables
nzPerks.Players = nzPerks.Players or {}
nzPerks.PlayerUpgrades = nzPerks.PlayerUpgrades or {}

nzPerks.NextNukedRound = 0

nzPerks.EPoPIcons = {
	[1] = Material("vgui/aat/t7_hud_cp_aat_blastfurnace.png", "smooth unlitgeneric"),
	[2] = Material("vgui/aat/t7_hud_cp_aat_deadwire.png", "smooth unlitgeneric"),
	[3] = Material("vgui/aat/t7_hud_cp_aat_fireworks.png", "smooth unlitgeneric"),
	[4] = Material("vgui/aat/t7_hud_cp_aat_thunderwall.png", "smooth unlitgeneric"),
	[5] = Material("vgui/aat/t7_hud_cp_aat_cryofreeze.png", "smooth unlitgeneric"),
	[6] = Material("vgui/aat/t7_hud_cp_aat_turned.png", "smooth unlitgeneric"),
	[7] = Material("vgui/aat/t7_hud_cp_aat_bhole.png", "smooth unlitgeneric"),
	[8] = Material("vgui/aat/t7_hud_cp_aat_wonder.png", "smooth unlitgeneric"),
}

nzPerks.oldturnedlist = {
	["Odious Individual"] = true,
	["Laby after Taco Bell"] = true,
	["Fucker.lua"] = true,
	["Turned"] = true,
	["Shitass"] = true,
	["Miscellaneous Intent"] = true,
	["The Imposter"] = true,
	["Zobie"] = true,
	["Creeper, aww man"] = true,
	["Herbin"] = true,
	["Category Five"] = true,
	["TheRelaxingEnd"] = true,
	["Zet0r"] = true,
	["Dead By Daylight"] = true,
	["Cave Johnson"] = true,
	["Vinny Vincesauce"] = true,
	["Who's Who?"] = true,
	["MR ELECTRIC, KILL HIM!"] = true,
	["Jerma985"] = true,
	["Steve Jobs"] = true,
	["BRAAAINS..."] = true,
	["The False Shepherd"] = true,
	["Timer Failed!"] = true,
	["r_flushlod"] = true,
	["Doctor Robotnik"] = true,
	["Clown"] = true,
	["Left 4 Dead 2"] = true,
	["Squidward Tortellini"] = true,
	["Five Nights at FNAF"] = true,
	["Minecraft Steve"] = true,
	["Wowee Zowee"] = true,
	["Gorgeous Freeman"] = true,
	["fog rolling in"] = true,
	["Exotic Butters"] = true,
	["Brain Rot"] = true,
	["Team Fortress 2"] = true,
	["Roblox"] = true,
	["Cave1.ogg"] = true,
	["Fin Fin"] = true,
	["Jimmy Gibbs Jr."] = true,
	["Brain Blast"] = true,
	["Sheen"] = true
}

if SERVER then
	function nzPerks:UpdatePerkMachines()
		for k, v in pairs(ents.FindByClass("perk_machine")) do
			if v.Update then
				v:Update()
			end
		end
		for k, v in pairs(ents.FindByClass("wunderfizz_machine")) do
			if v.Update then
				v:Update()
			end
		end
	end

	function nzPerks:RebuildPaPCount()
		local machines = ents.FindByClass("perk_machine")

		nzPerks.PackAPunchCount = 0
		for _, e in pairs(machines) do
			if e.GetPerkID and e:GetPerkID() == "pap" then
				nzPerks.PackAPunchCount = nzPerks.PackAPunchCount + 1
			end
		end
	end

	if game.SinglePlayer() or (IsValid(Entity(1)) and Entity(1):IsListenServerHost()) then
		nzPerks:RebuildPaPCount()
	end
end
