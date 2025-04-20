function EFFECT:Init( data )
	self.Start = data:GetOrigin()
	self.Catcher = data:GetEntity()
	self.ParticleDelay = 0.025
	self.MoveSpeed = 150
	self.DistToCatch = 100

	self.NextParticle = CurTime()
	self.Emitter = ParticleEmitter( self.Start )
	self.color = nzMapping.Settings.zombieeyecolor or Color(220, 120, 100)
end

function EFFECT:Think( )
	if CurTime() >= self.NextParticle then
		local particle = self.Emitter:Add("sprites/glow04_noz", self.Emitter:GetPos())
		if (particle) then		
			particle:SetVelocity(vector_origin)
			particle:SetColor(self.color.r * math.Rand(.9,1), self.color.g * math.Rand(.9,1), self.color.b * math.Rand(.9,1))
			particle:SetLifeTime(0)
			particle:SetDieTime(0.65)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(4)
			particle:SetEndSize(22)
			particle:SetRoll(math.random(0, 36)*10)
			particle:SetAirResistance(400)
			particle:SetGravity(vector_origin)

			self.NextParticle = CurTime() + self.ParticleDelay
		end
	end

	if self.Catcher:IsValid() and self.Catcher:GetOpen() then
	    self.Emitter:SetPos((self.Catcher:WorldSpaceCenter()-self.Emitter:GetPos()):GetNormal() * self.MoveSpeed * FrameTime() + self.Emitter:GetPos())

		if self.Emitter:GetPos():DistToSqr(self.Catcher:WorldSpaceCenter()) <= self.DistToCatch then
			self.Catcher:EmitSound("NZ.BO2.SoulBox.Fill")
			if self.Catcher:LookupSequence("catch") > 0 then
				self.Catcher:ResetSequence("catch")
				timer.Simple(self.Catcher:SequenceDuration("catch"), function()
					if not (IsValid(self) and IsValid(self.Catcher)) then return end
					if not self.Catcher:GetOpen() then return end
					self.Catcher:ResetSequence("loop")
				end)
			end

			if CLIENT and DynamicLight then
				self.Dlight = self.Dlight or DynamicLight(self:EntIndex())
				if self.Dlight then
					self.Dlight.pos = self.Catcher:WorldSpaceCenter()
					self.Dlight.r = self.color.r
					self.Dlight.g = self.color.g
					self.Dlight.b = self.color.b
					self.Dlight.brightness = 2
					self.Dlight.Decay = 1000
					self.Dlight.Size = 400
					self.Dlight.DieTime = CurTime() + 1
				end
			end
			return false
	    else
		    return true
	    end
    end
end

function EFFECT:Render()
end
