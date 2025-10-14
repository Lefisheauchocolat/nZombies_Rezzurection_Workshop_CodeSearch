include("shared.lua")

local qmark = Material("models/zmb/bo2/buried/fxt_zmb_question_mark")
local glow = Material("sprites/wallbuy_light") --"sprites/light_ignorez"
local glowcolor = Color(0, 200, 255, 20)
local chalkcol = color_white
local glowsizew, glowsizeh, alpha = 128, 42, 30

function ENT:Draw()
	if self:GetUsed() then return end

	local fwrd = self:GetForward()

	if nzMapping.Settings.wallbuydata and nzMapping.Settings.wallbuydata["glow"] ~= glowcolor then
		local glow_path = nzMapping.Settings.wallbuydata["material"]
		if glow_path and file.Exists("materials/"..glow_path, "GAME") then
			glow = Material(glow_path)
		end

		chalkcol = nzMapping.Settings.wallbuydata["chalk"]
		glowsizew = nzMapping.Settings.wallbuydata["sizew"]
		glowsizeh = nzMapping.Settings.wallbuydata["sizeh"]
		glowcolor = nzMapping.Settings.wallbuydata["glow"]
		alpha = nzMapping.Settings.wallbuydata["alpha"]

		if glow:IsError() then
			glow = Material("sprites/wallbuy_light")
		end
	end

	render.SetMaterial(qmark)
	render.DrawQuadEasy(self:GetPos() + fwrd, fwrd, 22, 22, chalkcol, 180)

	render.SetMaterial(glow)
	render.DrawQuadEasy(self:GetPos() + fwrd, fwrd, glowsizew, glowsizeh, ColorAlpha(glowcolor, alpha))
end

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		local fucker = self:GetNoChalk() and " | NoChalk enabled" or ""
		return "Blank Chalk"..fucker
	end

	if self:GetUsed() then return end
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then
		ply = ply:GetObserverTarget()
	end

	local data = nzChalks.Players[ply:EntIndex()]
	if data then
		if data.name then
			return "Press & Hold "..string.upper(input.LookupBinding("+USE")).." - draw "..data.name.." wallbuy"
		else
			return "Press & Hold "..string.upper(input.LookupBinding("+USE")).." - draw wallbuy"
		end
	end
end

function ENT:Flashbangg()
	if DynamicLight then
		local dlight = DynamicLight(self:EntIndex(), false)
		if (dlight) then
			local color = nzMapping.Settings.boxlightcolor or Color(40, 255, 60, 255)
			dlight.pos = self:GetPos()
			dlight.r = color.r
			dlight.g = color.g
			dlight.b = color.b
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 64
			dlight.DieTime = CurTime() + 0.5
		end
	end
end

function ENT:IsTranslucent()
	return true
end
