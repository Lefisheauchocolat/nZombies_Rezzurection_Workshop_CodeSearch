ENT.Type = "anim"

ENT.PrintName		= "easter_egg"
ENT.Author			= "Alig96"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

AddCSLuaFile()

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
end

function ENT:Initialize()

	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel( "models/props_lab/huladoll.mdl" )
	end
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	self.Used = false
	self:SetActivated(false)

	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use( activator, caller )
	self:MeteorAffirm()
end

function ENT:MeteorAffirm()
	if !self.Used then
		self:EmitSound("nz_moo/ee/affirm.mp3",85,math.random(95, 105))

		self.Used = true
		nzEE:ActivateEgg( self, activator )
	end
end

function ENT:OnRemove()
	if CLIENT then
		if self.IdleAmbience or IsValid(self.IdleAmbience) then
			self:StopSound(self.IdleAmbience)
		end
	end
end

function ENT:Think()

	if SERVER then
		if self.Used then
			self:SetActivated(true)
		else
			self:SetActivated(false)
		end
	end

	self:NextThink( CurTime() )

	return true
end

if CLIENT then
	function ENT:MeteorSound()
		if !IsValid(self) then return end
	    if (!self.IdleAmbience or !IsValid(self.IdleAmbience)) and !self:GetActivated() then
			self.IdleAmbience = "nz_moo/ee/loop_00.wav"
			if !self:GetActivated() then
				self:EmitSound(self.IdleAmbience, 60, 100, 1, 3)
			end
		end
		if (self.IdleAmbience or IsValid(self.IdleAmbience)) and self:GetActivated() then
			self:StopSound(self.IdleAmbience)
			self.IdleAmbience = false
		end
	end

	function ENT:Draw()
		self:DrawModel()
		self:MeteorSound()
	end
end
