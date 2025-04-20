
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

include("shared.lua")

local mat = Material("cable/chain")
local nz_preview = GetConVar("nz_creative_preview")
local developer = GetConVar("developer")
local color_red = Color(255,0,0,255)
local flymins, flymaxs = Vector(-6.211900, -6.091400, -6.534200), Vector(6.211900, 5.972800, 5.708400)

function ENT:Initialize()
	local name = "nzJumpDisplay"..self:EntIndex()
	hook.Add("PostDrawTranslucentRenderables", name, function(bDepth, bSkybox)
		if ( bSkybox ) then return end
		if LocalPlayer():IsInCreative() and (nz_preview and !nz_preview:GetBool()) then
			if not IsValid(self) then hook.Remove("PostDrawTranslucentRenderables", name) return end
			self:DrawTrajectory()
		end
	end)
end

function ENT:Draw()
	self:DrawModel()
end

local drawline = GetConVar("nz_jumppad_preview")
function ENT:DrawTrajectory()
	local ply = LocalPlayer()
	if !drawline or !drawline:GetBool() then return end

	local ent = nzJumps:GetLandingPadByFlag(self:GetFlag())
	if not IsValid(ent) then return end

	local spos = self:GetPos() + vector_up
	local ppos = ply:GetPos()
	local epos = ent:GetPos() + ent:OBBCenter()

	local start, height, endpos = spos, self:GetAirTime(), epos

	if ply:KeyDown(IN_WALK) and ppos:DistToSqr(spos) <= (80*self:GetModelScale())^2 then
		ppos[3] = spos[3]
		local dir = (ppos - spos):GetNormalized()
		local offset = ppos:Distance(spos)*0.8

		start = ply:GetPos() + vector_up
		endpos = epos + (dir*offset)
	end

	local segs = math.Clamp(math.Round(endpos:Distance(start)/40), 8, 64)
	local scroll = (CurTime() * -2.2)
	local color = color_white

	render.SetMaterial(mat)
	render.StartBeam(segs + 1)

	local lastpos = start
	for i = 0, segs, 1 do
		local frac = i/segs
		local pos = self:LaunchArc(endpos, start, height, height*frac)
		scroll = scroll + (lastpos:Distance(pos))/64

		if i <= segs - 1 then
			local mins, maxs = ply:GetCollisionBounds()
			mins[3] = maxs[3]/2
			if util.TraceHull({start = lastpos, endpos = pos, filter = {ply, self}, mins = mins, maxs = maxs}).HitWorld then
				color = color_red
			end
			if util.TraceHull({start = lastpos, endpos = pos, filter = {ply, self}, mins = flymins, maxs = flymaxs}).HitWorld then
				color = color_red
			end
		end

		lastpos = pos
		render.AddBeam(pos, 6, scroll, color)
	end

	render.EndBeam()
end

function ENT:GetNZTargetText()
	local ent = nzJumps:GetLandingPadByFlag(self:GetFlag())
	if not IsValid(ent) then
		return "Landing Pad required to function!"
	end

	if nzRound:InState(ROUND_CREATE) then
		local pricedata = self:GetPrice() > 0 and " | Price "..self:GetPrice() or ""
		local elecdata = self:GetElectric() and " | Requires Electricity" or ""
		local landdata = self:GetRequireActive() and " | Activate Landing Pad" or ""
		return "Press "..string.upper(input.LookupBinding("+USE")).." - Test | "..self:GetCooldown().."s Cooldown | Flag "..self:GetFlag().." | "..math.Round(self:GetAirTime(), 4).."s Air time"..pricedata..elecdata..landdata
	end

	if (self:GetElectric() and not nzElec:IsOn()) then
		return "You must turn on the electricity first!"
	end

	if self:GetNextUse() > CurTime() then
		local time = self:GetNextUse() - CurTime()
		if time > (self:GetCooldown() - 2) then return end

		return "Cooling Down ["..math.Round(time).."s]"
	end

	if self:GetRequireActive() and IsValid(ent) and not ent:GetActivated() then
		return "Landing Pad not active"
	end

	local price = self:GetPrice()
	if price > 0 then
		return "Press "..string.upper(input.LookupBinding("+USE")).." - activate Pad [Cost: "..price.."]"
	else
		return "Press "..string.upper(input.LookupBinding("+USE")).." - activate Pad"
	end
end

function ENT:IsTranslucent()
	return true
end