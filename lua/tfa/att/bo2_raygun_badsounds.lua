if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Classic Sound Effects"
ATTACHMENT.Description = {}
ATTACHMENT.Icon = "vgui/icon/bad_sound_.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "SFX"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Sound"] = function(wep,stat) return "TFA_BO2_RAYGUN.Shoot" or stat end,
		["SoundLyr1"] = function(wep,stat) return "TFA_BO2_RAYGUN.Act" or stat end,
		["SoundLyr2"] = function(wep,stat) return "TFA_BO2_RAYGUN.Flux" or stat end,
	},
}

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end