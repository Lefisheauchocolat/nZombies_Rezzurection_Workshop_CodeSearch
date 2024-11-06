include("shared.lua")
	
local ourcolor = Color(235, 235, 255, 255)
function ENT:Draw()
	local p = self:GetParent()
	if not IsValid(p) then return end

	if !self.loopeffect or !IsValid(self.loopeffect) then
		self.loopeffect = CreateParticleSystemNoEntity("nz_hbarrier_loop", p:GetPos() + vector_up, p:GetAngles() - (Angle(0,90,0)))
		self:EmitSound("nz_moo/powerups/security/zct_recharge.wav", 55, math.random(97,103), 1, CHAN_ITEM)
	end
end

function ENT:IsTranslucent()
	return true
end