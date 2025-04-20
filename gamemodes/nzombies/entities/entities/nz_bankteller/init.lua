AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

function ENT:Initialize()
	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
	self:SetPoints(0)
end

function ENT:Use(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

	if self.NextUse and self.NextUse > CurTime() then return end
	self.NextUse = CurTime() + 0.1

	if nzRound:InState(ROUND_CREATE) then
		if ply:KeyDown(IN_SPEED) then
			self:EmitSound(self.GiveSound, SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
		else
			self:EmitSound(self.TakeSound, SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
		end
		return
	end

	if self:GetElectric() and not nzElec:IsOn() then
		return
	end

	if ply:KeyDown(IN_SPEED) then
		if self:GetPoints() < 1000 then
			ply:Buy(math.huge, self, function() end)
			return
		end

		hook.Call("PlayerWithdrawPoints", nil, ply, self)

		ply:GivePoints(1000)
		ply:SetPoints(math.max(ply:GetPoints() - self:GetPointFee(), 0))

		self:EmitSound(self.GiveSound, SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
		self:SetPoints(math.max(self:GetPoints() - 1000, 0))
	else
		if self:GetPoints() >= self:GetPointLimit() then
			local msg = "Entity("..self:EntIndex().."):BankFull()"
			ply:SendLua(msg)
			ply:Buy(math.huge, self, function() end)
			return
		end

		if ply:GetPoints() < 1000 then
			ply:Buy(math.huge, self, function() end)
			return
		end

		hook.Call("PlayerDepositPoints", nil, ply, self)

		ply:SetPoints(math.max(ply:GetPoints() - 1000, 0))

		self:EmitSound(self.TakeSound, SNDLVL_NORM, math.random(97,103), 1, CHAN_STATIC)
		self:SetPoints(self:GetPoints() + 1000)
	end
end

function ENT:Reset()
	self:SetPoints(0)
end
