AddCSLuaFile( )

ENT.Type = "anim"
 
ENT.PrintName		= "Launcher Perk Machine"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:Initialize()
	if SERVER then
		self:SetMoveType( MOVETYPE_NONE )
		self:SetSolid( SOLID_NONE )
		self:DrawShadow( true )
		self:CreateRocketTrail()
		self.TravelDistance = self:GetPos():Distance(self:GetOwner():GetPos())
	end
end

if SERVER then
	function ENT:CreateRocketTrail()
		local rockettrail = ents.Create("env_rockettrail")
		rockettrail:DeleteOnRemove(self)

		rockettrail:SetPos(self:GetPos())
		rockettrail:SetAngles(vector_up:Angle())
		rockettrail:SetParent(self)
		rockettrail:SetMoveType(MOVETYPE_NONE)
		rockettrail:AddSolidFlags(FSOLID_NOT_SOLID)

		rockettrail:SetSaveValue("m_Opacity", 0.6)
		rockettrail:SetSaveValue("m_SpawnRate", 200)
		rockettrail:SetSaveValue("m_ParticleLifetime", 1)
		rockettrail:SetSaveValue("m_StartColor", Vector(0.1, 0.1, 0.1))
		rockettrail:SetSaveValue("m_EndColor", Vector(1, 1, 1))
		rockettrail:SetSaveValue("m_StartSize", 24)
		rockettrail:SetSaveValue("m_EndSize", 64)
		rockettrail:SetSaveValue("m_SpawnRadius", 4)
		rockettrail:SetSaveValue("m_MinSpeed", 16)
		rockettrail:SetSaveValue("m_MaxSpeed", 32)
		rockettrail:SetSaveValue("m_nAttachment", 1)
		rockettrail:SetSaveValue("m_flDeathTime", CurTime() + 5)

		rockettrail:Activate()
		rockettrail:Spawn()
	end

	function ENT:UpdateTransmitState()
		return TRANSMIT_ALWAYS
	end
end

function ENT:Think()
	if SERVER then
		local machine = self:GetOwner()
		if IsValid(machine) and self:GetCreationTime() + (3 - engine.TickInterval()) < CurTime() then
			if self:GetNoDraw() then
				self:SetNoDraw(false)
			end

			local direction = (self:GetPos() - machine:GetPos()):GetNormalized()
			self:SetPos(self:GetPos() - (direction*self.TravelDistance/(2/engine.TickInterval())))
		end
	end

	self:NextThink(CurTime())
	return true
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end