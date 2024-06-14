AddCSLuaFile()

ENT.Type = "anim"
 
ENT.PrintName		= "drop_powerups"
ENT.Author			= "Alig96"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.LoopSound = Sound("nz_moo/powerups/powerup_lp_zhd.mp3")

function ENT:SetupDataTables()

	self:NetworkVar( "String", 0, "Points" )
	
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/nzpowerups/bloodmoney.mdl")

		self:PhysicsInitSphere(60, "default_silent")
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)

		self:SetTrigger(true)
		self:SetUseType(SIMPLE_USE)

		self:UseTriggerBounds(true, 30)

		-- Move up from ground
		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() - Vector(0,0,40),
			filter = self,
			mask = MASK_SOLID_BRUSHONLY,
		})
		if tr.Hit then
			self:SetPos(tr.HitPos + Vector(0,0,40))
		end
	else
		self.NextParticle = CurTime()
		self.ParticleEmitter = ParticleEmitter(self:GetPos())
		self.ParticleEmitter:SetNoDraw(true) -- We draw them manually
	end
		self:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")
		self.RemoveTime = CurTime() + 30
		self.SoundPlayer = CreateSound(self, self.LoopSound)
    	if (self.SoundPlayer) then
        	self.SoundPlayer:Play()
    	end
end

if SERVER then
	function ENT:StartTouch(hitEnt)
		if (hitEnt:IsValid() and hitEnt:IsPlayer()) then
			nzPowerUps:Activate(self:GetPowerUp(), hitEnt, self)
			self:Remove()
		end
	end
	
	function ENT:Think()
		if self.RemoveTime and CurTime() > self.RemoveTime then
			self:Remove()
		end
	end

		function ENT:OnRemove()
		if (self.SoundPlayer) then
    		self.SoundPlayer:Stop()
   		end
    end
end

if CLIENT then
	local mats = {
		"nzombies-unlimited/particle/powerup_glow_09",
		--"particle/particle_glow_05",
		--"nzombies-unlimited/particle/powerup_wave_5",
		"particle/particle_glow_03"
	}
	local mat = Material(mats[1])
	function ENT:Draw()
		if not self.NextParticle or self.NextParticle < CurTime() then
			local r,g,b = 100,255,50
			for k,v in pairs(mats) do
				local p = self.ParticleEmitter:Add(v, self:GetPos())
				p:SetDieTime(0.5)
				p:SetStartAlpha(255)
				p:SetEndAlpha(0)
				p:SetStartSize(15)
				p:SetEndSize(35)
				p:SetRoll(math.random()*2)
				p:SetColor(r,g,b)
				p:SetLighting(false)
			end
			self.NextParticle = CurTime() + 0.2
		end

		self.ParticleEmitter:Draw()
		self:DrawModel()
	end
	ENT.DrawTranslucent = ENT.Draw

	function ENT:OnRemove()
		if IsValid(self.ParticleEmitter) then self.ParticleEmitter:Finish() end
	end

	local rotang = Angle(2,50,2)
	function ENT:Think()
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles()+(Angle(0,50,0)*FrameTime()))
	end
end