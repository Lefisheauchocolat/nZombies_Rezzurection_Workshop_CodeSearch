ENT.Type = "anim"

ENT.PrintName		= "buyable_ending"
ENT.Author			= "Laby"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.bPhysgunNoCollide = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
end


AddCSLuaFile()



function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel( "models/hoff/props/teddy_bear/teddy_bear.mdl" )
	end
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	self.Used = false
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use( activator, caller )
	if nzRound:InProgress() then
	local price = self:GetPrice()
	if activator:GetPoints() >=  price then
	activator:TakePoints(price)
		 nzRound:Win()
	end
end
end

function ENT:Think()
	if CLIENT and DynamicLight then
		local dlight = DynamicLight(self:EntIndex(), false)
		if (dlight) then
			local color = nzMapping.Settings.zombieeyecolor or Color(40, 255, 60, 255)
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

