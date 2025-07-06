
local meta = FindMetaTable("Player")

function meta:GetKnifing()
	return self:GetNW2Bool("TFA.QK.Active", false)
end

function meta:SetKnifing(bool)
	return self:SetNW2Bool("TFA.QK.Active", bool)
end

function meta:GetKnifeBackup()
    return self:GetNW2Entity("TFA.QK.Wep")
end

function meta:SetKnifeBackup(ent)
    return self:SetNW2Entity("TFA.QK.Wep", ent)
end

function meta:GetKnifeTarget()
    return self:GetNW2Entity("TFA.QK.Enemy")
end

function meta:SetKnifeTarget(ent)
	return self:SetNW2Entity("TFA.QK.Enemy", ent)
end

function meta:GetKnifingCooldown()
	return self:GetNW2Float("TFA.QK.Wait", 0)
end

function meta:SetKnifingCooldown(time)
	return self:SetNW2Float("TFA.QK.Wait", time)
end