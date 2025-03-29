-- Main Tables
nzElec = nzElec or AddNZModule("Elec")

-- Variables
nzElec.Active = false

nzElec.ValidEntities = nzElec.ValidEntities or {}

function nzElec:RegisterEntity(class, data)
	nzElec.ValidEntities[class] = (data == nil and true or data)
end

function nzElec:IsValidEntity(class)
	return nzElec.ValidEntities[class] or false
end

function nzElec:ShouldTurnOn(ent)
	local bool_or_data = nzElec.ValidEntities[ent:GetClass()]
	if !bool_or_data then
		return false
	end

	if IsValid(ent) and ent.ShouldTurnOn and isfunction(ent.ShouldTurnOn) then
		return tobool(ent:ShouldTurnOn())
	elseif isbool(bool_or_data) then
		return bool_or_data
	elseif istable(bool_or_data) and bool_or_data.can_on then
		return bool_or_data.can_on(ent)
	end

	return tobool(bool_or_data)
end

function nzElec:ShouldTurnOff(ent)
	local bool_or_data = nzElec.ValidEntities[ent:GetClass()]
	if !bool_or_data then
		return false
	end

	if IsValid(ent) and ent.ShouldTurnOff and isfunction(ent.ShouldTurnOff) then
		return tobool(ent:ShouldTurnOff())
	elseif isbool(bool_or_data) then
		return bool_or_data
	elseif istable(bool_or_data) and bool_or_data.can_off then
		return bool_or_data.can_off(ent)
	end

	return tobool(bool_or_data)
end

nzElec:RegisterEntity("perk_machine")
nzElec:RegisterEntity("nz_ammo_matic")
nzElec:RegisterEntity("nz_teleporter")
nzElec:RegisterEntity("nz_funnybutton")
nzElec:RegisterEntity("nz_launchpad")
nzElec:RegisterEntity("nz_soulbox")
nzElec:RegisterEntity("wunderfizz_machine", {
	can_on = function(ent)
		if nzMapping.Settings.cwfizz then
			return true
		else
			local b_ballin = true
			for k, v in pairs(ents.FindByClass("wunderfizz_machine")) do
				if v:IsOn() then 
					b_ballin = false
					break
				end
			end

			return b_ballin
		end
	end,
	can_off = function(ent)
		if nzMapping.Settings.cwfizz then
			return true
		else
			local b_ballin = false
			for _, baller in pairs(ents.FindByClass("wunderfizz_machine")) do
				if baller:IsOn() and baller:EntIndex() ~= ent:EntIndex() then 
					b_ballin = true
					break
				end
			end

			return b_ballin
		end
	end,
})

function nzElec.IsOn()
	return nzElec.Active
end

IsElec = nzElec.IsOn
