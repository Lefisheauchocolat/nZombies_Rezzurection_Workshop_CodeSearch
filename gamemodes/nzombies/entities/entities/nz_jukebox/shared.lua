ENT.Type = "anim"

ENT.PrintName		= "nz_jukebox"
ENT.Author			= "Alig96"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.bPhysgunNoCollide = true

AddCSLuaFile()

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel( "models/zmb/ugx/jukebox.mdl" )
	end
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_NONE )
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use( activator, caller )
	if nzRound:InProgress() then
		PrintMessage( HUD_PRINTTALK,"Assume all songs are copyrighted!")
		nzSounds:Play("Music")
	end
end

function ENT:GetNZTargetText()
		return "Press E to Jam Out!"
end

function ENT:Think()
	if CLIENT and DynamicLight then
		local dlight = DynamicLight(self:EntIndex(), false)
		if (dlight) then
			local color = nzMapping.Settings.boxlightcolor or Color(40, 255, 60, 255)
			dlight.pos = self:WorldSpaceCenter()
			dlight.r = color.r
			dlight.g = color.g
			dlight.b = color.b
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 128
			dlight.DieTime = CurTime() + 1
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Draw()
	self:DrawModel()
end