include("shared.lua")

local onlight = Material( "sprites/glow04_noz" )

function ENT:Draw()
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if self:GetDoSprite() and !self:GetActivated() then
		render.SetMaterial(onlight)

		local our_color = self:GetGlowColor():ToColor()
		render.DrawSprite(self:WorldSpaceCenter(), math.Rand(7,8), math.Rand(7,8), our_color)
	end

	if !ply:IsInCreative() then return end

	local num = render.GetBlend()
	render.SetBlend(math.Rand(0.4,0.55))
	self:DrawModel()
	render.SetBlend(num)
end

function ENT:GetNZTargetText()
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	if nzRound:InState(ROUND_CREATE) or ply:IsInCreative() then
		local elecdata = self:GetElectric() and " | Requires Electricity" or ""
		local pricedata = self:GetPrice() > 0 and " | Price "..self:GetPrice() or ""
		local hidedata = self:GetDoHide() and " | Reveal Flag '"..self:GetDoorFlag().."'" or ""
		return  "Hacking Time "..self:GetTime().."s | Flag '"..self:GetFlag().."'"..pricedata..elecdata..hidedata
	end

	return ""
end

function ENT:IsTranslucent()
	return true
end