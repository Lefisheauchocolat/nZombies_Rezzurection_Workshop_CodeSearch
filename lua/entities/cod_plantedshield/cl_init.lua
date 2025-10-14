
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

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Draw()
	self:DrawModel()
	if self:GetElectrified() then
		if !self.CL_3PDrawFX or !self.CL_3PDrawFX:IsValid() then
			self.CL_3PDrawFX = CreateParticleSystem(self, "bo3_shield_electrify", PATTACH_ABSORIGIN_FOLLOW, 0)
		end
	elseif self.CL_3PDrawFX and self.CL_3PDrawFX:IsValid() then
		self.CL_3PDrawFX:StopEmissionAndDestroyImmediately()
	end
end

local MyFriendsNames = {
	["76561198271714696"] = "The Artist's Shield", //baiwar, https://steamcommunity.com/profiles/76561198271714696
	["76561198162014458"] = "FNAF Lore Master's Shield", //moo, https://steamcommunity.com/id/timetocommitselfdelete/
	["76561198323645982"] = "Die Rise Enjoyer's Shield", //owlie, https://steamcommunity.com/profiles/76561198323645982
	["76561198333241317"] = "Plants VS Scorpions' Shield", //killa, https://steamcommunity.com/profiles/76561198333241317
	["76561199125716810"] = "Lean Machine's Shield", //bloxo, https://steamcommunity.com/id/timetocommitselfdelete/
	["76561198319835463"] = "Anime Enjoyer's Shield", //vibes, https://steamcommunity.com/profiles/76561198319835463
	["76561198051349043"] = "Category 5 Stinker's Shield", //laboratory, https://steamcommunity.com/profiles/76561198051349043
	["76561198095518682"] = "Bad Bitches' Shield", //kate, https://steamcommunity.com/id/QueenKaiju420
	["76561198832629371"] = "Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin Kevin", //kevin, https://steamcommunity.com/profiles/76561198832629371
	["76561198104503130"] = "Dangerous Puerto Rican's Shield", //wavo, https://steamcommunity.com/id/wavymelon
	["76561198147354618"] = "Platy's Shield", //platy, https://steamcommunity.com/profiles/76561198147354618
	["76561198107702313"] = "Scary Whip Lady's Shield", //self, https://steamcommunity.com/id/FlamingFox5
}

function ENT:GetNZTargetText()
	local ply = self:GetOwner()

	if IsValid(ply) and ply:IsPlayer() then
		if LocalPlayer() == ply then
			return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup Shield"
		else
			return /*MyFriendsNames[ply:SteamID64()] or*/ ply:Nick().."'s Shield"
		end
	end
end

function ENT:IsTranslucent()
	return true
end