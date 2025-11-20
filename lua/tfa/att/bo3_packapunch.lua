if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Pack a' Punch"
ATTACHMENT.Description = {}
ATTACHMENT.Icon = "entities/bonfire.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "PAP"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Sound"] = function(wep,stat) return wep.Primary.SoundPAP or stat end,
		["Damage"] = function(wep,stat) return wep.Primary.DamagePAP or stat end,
		["ClipSize"] = function(wep,stat) return wep.Primary.ClipSizePAP or stat end,
		["MaxAmmo"] = function(wep,stat) return wep.Primary.MaxAmmoPAP or stat end,
	},
	["Secondary"] = {
		["Sound"] = function(wep,stat) return wep.Secondary.SoundPAP or stat end,
		["Damage"] = function(wep,stat) return wep.Secondary.DamagePAP or stat end,
		["ClipSize"] = function(wep,stat) return wep.Secondary.ClipSizePAP or stat end,
		["MaxAmmo"] = function(wep,stat) return wep.Secondary.MaxAmmoPAP or stat end,
	},
	["Ispackapunched"] = true,
	["MoveSpeed"] = function(wep, stat) return wep.MoveSpeedPAP or stat end,
	["PrintName"] = function(wep, stat) return wep.NZPaPName or stat end,
	["MuzzleFlashEffect"] = function(wep, stat) return wep.MuzzleFlashEffectPAP or stat end,
	["TracerName"] = function(wep, stat) return wep.TracerNamePAP or stat end,
	["IronSightsPos"] = function(wep, stat) return wep.IronSightsPos_PAP or stat end,
	["IronSightsAng"] = function(wep, stat) return wep.IronSightsAng_PAP or stat end,
}

function ATTACHMENT:Attach(wep)
	if wep:GetOwner():IsPlayer() then
		wep:ResetFirstDeploy()
		if game.SinglePlayer() then
			wep:CallOnClient("ResetFirstDeploy", "")
		end
		wep:Deploy()
	end
	wep.Ispackapunched = true
end

function ATTACHMENT:Detach(wep)
	wep:Unload()
	wep:Unload2()
	wep:Deploy()
	wep.Ispackapunched = false
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end