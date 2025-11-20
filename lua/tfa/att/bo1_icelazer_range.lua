if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Spartan Laser"
ATTACHMENT.Description = {
	TFA.AttachmentColors["+"], "Infinite range",
	TFA.AttachmentColors["-"], "Incredibly small cylinder range",
}
ATTACHMENT.Icon = "vgui/icon/icon_h3_spartan_laser.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "MOD"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["ChargeTime"] = function(wep, stat) return 2.5 end,
		["CylinderRange"] = function(wep,stat) return 4096*8 end,
		["CylinderKillRange"] = function(wep,stat) return 4096 end,
		["CylinderRadius"] = function(wep,stat) return 32 end,
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end