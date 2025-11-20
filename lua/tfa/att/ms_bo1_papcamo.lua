if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "PaP Camo"
ATTACHMENT.Description = {
}
ATTACHMENT.Icon = "entities/wall_buys.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "Camo"

ATTACHMENT.WeaponTable = {
	["UsePapCamo"] = true,
}

function ATTACHMENT:Attach(wep)
	wep:ResetFirstDeploy()
	if game.SinglePlayer() then
		wep:CallOnClient("ResetFirstDeploy", "")
	end
	wep:Deploy()
	wep.UsePapCamo = true
end

function ATTACHMENT:Detach(wep)
	wep:Deploy()
	wep.UsePapCamo = false
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end