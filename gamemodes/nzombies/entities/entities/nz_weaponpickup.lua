AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Weapon Pickup"
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = false
ENT.bPhysgunNoCollide = true

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "GiveType")
	self:NetworkVar("String", 0, "Gun")
	self:NetworkVar("String", 1, "RequiredGun")
	self:NetworkVar("String", 2, "DoorFlag")
	self:NetworkVar("Bool", 0, "BoxWeapon")
	self:NetworkVar("Bool", 1, "Doored")
	self:NetworkVar("Bool", 2, "DoHide")

	if SERVER then
		self:NetworkVarNotify("Doored", function(ent, name, old, new)
			if new and ent:GetDoHide() then
				ent:SetSolid(SOLID_OBB)
				ent:SetNoDraw(false)
			end
		end)
	end
end

function ENT:Initialize()
	/*local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/dav0r/hoverball.mdl")
	end*/
	local wep = weapons.Get(self:GetGun())
	self:SetModel(wep.WM or wep.WorldModel)

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_OBB)
	self:SetSolid(SOLID_OBB)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:UseTriggerBounds(true, 2)

	self.GiveTypes = {
		[1] = self.GiveRemove,
		[2] = self.GiveSingle,
		[3] = self.GiveUnlimited,
	}

	local icon = wep.NZHudIcon
	if icon and not icon:IsError() then
		self.NZHudIcon = icon
	end

	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
	end

	if CLIENT then return end
	//self:SpawnWeapon()
	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)
end

/*function ENT:SpawnWeapon()
	local wep = ents.Create(self:GetGun())
	if not IsValid(wep) then return end
	self:SetModel(wep:GetWeaponWorldModel())
	SafeRemoveEntity(wep)
end*/

function ENT:Reset()
	self:SetNoDraw(false)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(true)

	for _, ply in ipairs(player.GetAll()) do
		if ply:GetNW2Bool("nzGund"..self:EntIndex(), false) then
			ply:SetNW2Bool("nzGund"..self:EntIndex(), false)
		end
	end

	if self.FixBoxList then
		self.FixBoxList = false
		nzMapping.Settings.rboxweps[self:GetGun()] = nil
		timer.Simple(0, function()
			nzMapping:SendMapData()
		end)
	end
end

ENT.GiveRemove = function(self, ply)
	ply:EmitSound("NZ.Buildable.Foley")
	ply:Give(self:GetGun())

	self:SetNoDraw(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
end

ENT.GiveSingle = function(self, ply)
	ply:EmitSound("NZ.Buildable.Foley")
	ply:Give(self:GetGun())

	ply:SetNW2Bool("nzGund"..self:EntIndex(), true)
	local msg = "Entity("..self:EntIndex().."):DrawShadow(false)"
	ply:SendLua(msg)
end

ENT.GiveUnlimited = function(self, ply)
	ply:EmitSound("NZ.Buildable.Foley")
	ply:Give(self:GetGun())
end

function ENT:Use(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:HasWeapon(self:GetGun()) then return end
	if self:GetGiveType() == 2 and ply:GetNW2Bool("nzGund"..self:EntIndex(), false) then return end

	if ply.NextUse and ply.NextUse > CurTime() then return end
	ply.NextUse = CurTime() + 1.5

	if (nzRound:InState(ROUND_CREATE) or ply:IsInCreative()) then
		ply:EmitSound("NZ.Buildable.Foley")
		ply:Give(self:GetGun())
		return
	end

	local wep = ply:GetActiveWeapon()
	local class = self:GetRequiredGun()
	if class ~= "" and weapons.Get(class) then
		if not IsValid(wep) then return end
		if wep:GetClass() ~= class then return end
	end

	local door = self:GetDoorFlag()
	if door ~= "" and not self:GetDoored() then return end

	if self:GetBoxWeapon() and not self.FixBoxList then
		self:AddToBox()
	end

	self.GiveTypes[self:GetGiveType()](self, ply)
end

function ENT:AddToBox()
	if not nzMapping.Settings.rboxweps[self:GetGun()] then
		self.FixBoxList = true
		nzMapping.Settings.rboxweps[self:GetGun()] = self.WeaponWeight
		timer.Simple(0, function()
			nzMapping:SendMapData()
		end)
	end
end

if CLIENT then
	function ENT:Draw()
		local ply = LocalPlayer()
		if self:GetGiveType() == 2 and ply:GetNW2Bool("nzGund"..self:EntIndex(), false) then return end
		self:DrawModel()
	end

	function ENT:GetNZTargetText()
		local ply = LocalPlayer()
		local class = self:GetRequiredGun()
		local door = self:GetDoorFlag()

		if nzRound:InState(ROUND_CREATE) or ply:IsInCreative() then
			local givetype = (self:GetGiveType() == 3 and " | Unlimited") or (self:GetGiveType() == 2 and " | Per Person") or (self:GetGiveType() == 1 and " | Single") or ""
			local boxweapon = self:GetBoxWeapon() and " | Box Weapon" or ""
			local reqwep = class ~= "" and " | Requires "..class or ""
			local reqdoor = door ~= "" and " | Door Flag "..door or ""
			return "Weapon Pickup | "..weapons.Get(self:GetGun()).PrintName..givetype..boxweapon..reqwep..reqdoor
		end

		if ply:HasWeapon(self:GetGun()) then return end
		if door ~= "" and not self:GetDoored() then return end
		if self:GetGiveType() == 2 and ply:GetNW2Bool("nzGund"..self:EntIndex(), false) then return end
		if class ~= "" then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep:GetClass() ~= class then return "Requires "..weapons.Get(class).PrintName end
		end

		return "Press "..string.upper(input.LookupBinding("+USE")).." - pickup "..weapons.Get(self:GetGun()).PrintName
	end
end