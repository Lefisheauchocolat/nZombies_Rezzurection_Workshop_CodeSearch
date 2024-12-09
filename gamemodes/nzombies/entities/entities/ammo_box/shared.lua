AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName		= "ammo_box"
ENT.Author			= "Laby and Ghostlymoo"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Int", 1, "PapPrice")
	self:NetworkVar("Int", 2, "WonderPrice")
end

function ENT:Initialize()
	self:SetModel( "models/moo/_codz_ports_props/t10/t10_zm_large_ammo_crate_01/moo_codz_t10_zm_large_ammo_crate_01.mdl" )
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use( activator, caller )
	-- Changed to have separate prices for normal, pap, and wonder weapons.
	local currentWep = activator:GetActiveWeapon()
	local price = self:GetPrice()

	if currentWep.Ispackapunched then
		price = self:GetPapPrice()
	end

	if currentWep.NZWonderWeapon then
		price = self:GetWonderPrice()
	end

	local ammo_type = IsValid(currentWep) and currentWep:GetPrimaryAmmoType() or currentWep.Primary.Ammo
	local max_ammo = currentWep.Primary.MaxAmmo or nzWeps:CalculateMaxAmmo(self.WeaponGive)
	local curr_ammo = activator:GetAmmoCount(ammo_type)
	local give_ammo = max_ammo - curr_ammo

	if give_ammo <= 0 then
		activator:EmitSound("nz_moo/effects/purchases/deny.wav")
		return 
	end

	activator:Buy(price, self, function()
		activator:TakePoints(price, true)
		self:EmitSound("effects/ammobox.ogg")
		currentWep:GiveMaxAmmo() 
	end)
end

function ENT:AmmoPrice(ply)
	if !IsValid(ply) then return "fuck" end

	local currentWep = ply:GetActiveWeapon()
	local price = self:GetPrice()

	if currentWep.Ispackapunched then
		price = self:GetPapPrice()
	end

	if currentWep.NZWonderWeapon then
		price = self:GetWonderPrice()
	end

	price = tostring(price)

	return price
end

function ENT:Draw()
	self:DrawModel()
end
