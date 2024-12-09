-- Main Tables
nzCamos = nzCamos or AddNZModule("Camos")
nzCamos.Data = nzCamos.Data or {}

if CLIENT then
	nzCamos.ViewmodelsToUpdate = {}
end

CreateClientConVar("nz_papcamo", 1, true, false, "Sets whether Pack-a-Punch applies a camo to viewmodels")
CreateClientConVar("nz_papcamo_3p", 1, true, false, "Sets whether Pack-a-Punch applies a camo to worldmodels")
CreateClientConVar("nz_papcamo_ww", 1, true, false, "Sets whether Pack-a-Punch applies a camo to wonder weapons")

function nzCamos:RandomizeCamo(wep, lastcamo)
	if not nzMapping.Settings.PAPcamo or not nzCamos:Get(nzMapping.Settings.PAPcamo) then
		print('[NZ] current map setting Pack a Punch camo is invalid! please update in map settings!')
		return
	end

	local camos = nzCamos:GetCamos(nzMapping.Settings.PAPcamo)
	if not camos then return end

	local ignorecamo = lastcamo or wep:GetNW2String("nzPapCamo", "")
	local camostring = ""

	for _, camo in RandomPairs(camos) do
		if camo ~= ignorecamo then
			camostring = camo
			break
		end
	end

	if camostring == "" then
		camostring = camos[1]
	end

	wep:SetNW2String("nzPaPCamo", camostring)
	wep.nzPaPCamo = camostring
end