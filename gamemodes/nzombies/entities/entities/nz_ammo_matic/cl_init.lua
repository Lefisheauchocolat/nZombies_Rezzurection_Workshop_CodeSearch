include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local view_cvar = GetConVar("nz_creative_preview")

function ENT:Draw()
	self:DrawModel()

	if self:GetActive() then
		if !self.NextLight or CurTime() > self.NextLight then
			local dlight = DynamicLight(self:EntIndex(), true)
			local center = self:OBBCenter() * 0.5
			local fwd = self:GetForward()*12

			if ( dlight ) then
				dlight.pos = self:WorldSpaceCenter() + center + fwd
				dlight.r = 6
				dlight.g = 80
				dlight.b = 224
				dlight.brightness = 1
				dlight.Decay = 1000
				dlight.Size = 256
				dlight.DieTime = CurTime() + 1
			end
			if math.random(300) == 1 then self.NextLight = CurTime() + 0.05 end
		end

		 if !self.IdleAmbience then
			self.IdleAmbience = "nz_moo/perkacolas/hum_loop.wav"
			self:EmitSound(self.IdleAmbience, 65, 100, 1, 3)
		end
	end
end

function ENT:OnRemove()
	if self.IdleAmbience then
		self:StopSound(self.IdleAmbience)
	end
end

function ENT:GetNZTargetText()
	if (not view_cvar:GetBool()) and nzRound:InState(ROUND_CREATE) then
		return "Amm-O-Matic | "..self:GetTotalCooldown().."s Cooldown | "..string.Comma(self:GetPrice()).." Price"
	end

	if self:GetActive() then
		if self:IsCoolingDown() then
			/*local time = 1 - math.Clamp((self:GetNextCooldown() - CurTime()) / self:GetTotalCooldown(), 0, 1)
			time = math.Round(time, 2)
			time = time*100
			return "Cooling Down ["..time.."%]"*/
			local time = math.Round(self:GetNextCooldown() - CurTime())
			return "Cooling Down ["..time.."s]"
		else
			return "Press "..string.upper(input.LookupBinding("+USE")).." - Purchase Max Ammo [Cost: "..string.Comma(self:GetPrice()).."]"
		end
	else
		return "You must turn on the electricity first!"
	end
end

function ENT:IsTranslucent()
	return true
end