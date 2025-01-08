AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName		= "ammo_mod"
ENT.Author			= "Laby and Ghostlymoo"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
	--self:NetworkVar("Bool", 1, "Scrap")
end

function ENT:Initialize()
    
	self:SetModel( "models/nzr/2025/ammo_mod.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use( activator, caller )
	-- Randomized because modern call of duty bad, gambling good - Labert
	-- May add ability to use scrap instead of points in the future. It was causing freaky shit to happen so i commented its goofy ass out. thank you wario
	local currentWep = activator:GetActiveWeapon()
	local price = self:GetPrice()
	--local scrap = self:GetScrap()

	--if scrap then
	--local salvage = activator:GetNWInt("Salvage")
	--if salvage > price then
	--activator:SetNWInt("Salvage", activator:GetNWInt("Salvage")-price)
	--self:EmitSound("nz/machines/pap_ready.ogg")
		--currentWep:RandomizeAAT()
		--end
		--else
	activator:Buy(price, self, function()
		activator:TakePoints(price, true)
		self:EmitSound("nz/machines/pap_ready.ogg")
		currentWep:RandomizeAAT()
	end)
	--end
end

function ENT:Draw()
	self:DrawModel()
end
