AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"
local sp = game.SinglePlayer()

function ENT:Initialize()
	self:SetModel("models/hunter/blocks/cube025x025x025.mdl")

	self:DrawShadow(false)
	self:PhysicsInit(SOLID_OBB)
	//self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_OBB)

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	self:SetRenderMode(RENDERMODE_TRANSALPHA)

	self:SetTrigger(true)
	self:SetUsed(false)
end

function ENT:StartTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end
	if nzRound:InState(ROUND_CREATE) then
		if self.NextUse and self.NextUse > CurTime() then return end
		self.NextUse = CurTime() + 3.5

		self:EmitSound("NZ.Chalks.Loop")
		timer.Simple(0, function()
			if not IsValid(self) then return end
			ParticleEffectAttach("nzr_chalks_loop", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		end)
		timer.Simple(2.5, function()
			if not IsValid(self) then return end
			self:StopParticles()
			timer.Simple(0, function()
				if not IsValid(self) then return end
				self:StopParticles()

				local msg = "Entity("..self:EntIndex().."):Flashbangg()"
				for k, v in ipairs(player.GetAll()) do
					if v:TestPVS(self) then
						v:SendLua(msg)
					end
				end
				self:EmitSound("NZ.Chalks.Finish")
			end)
		end)
		return
	end
	if IsValid(self.ActiveUser) then return end

	if self:GetUsed() then return end
	if not nzChalks:GetPlayerChalk(ply) then return end

	if sp then
		ParticleEffectAttach("nzr_chalks_loop", PATTACH_ABSORIGIN_FOLLOW, self, 0)
	else
		timer.Simple(0, function()
			if not IsValid(self) then return end
			ParticleEffectAttach("nzr_chalks_loop", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		end)
	end

	ply:Give("tfa_chalkdrawing")
	self.ActiveUser = ply
	return 2.5
end

function ENT:StopTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	self:StopParticles()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:StopParticles()
	end)

	ply:SetUsingSpecialWeapon(false)
	ply:EquipPreviousWeapon()
	ply:StripWeapon("tfa_chalkdrawing")
	self.ActiveUser = nil
end

function ENT:FinishTimedUse(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end

	self.ActiveUser = nil

	if self:GetUsed() then return end

	local data = nzChalks:GetPlayerChalk(ply)
	if not data then return end

	self:StopParticles()
	timer.Simple(0, function()
		if not IsValid(self) then return end
		self:StopParticles()
	end)

	local ang = self:GetAngles()
	if data.flipped then
		ang:RotateAroundAxis(-self:GetUp(), 90)
	end

	self.MyWallBuy = nzMapping:WallBuy(self:GetPos(), tostring(data.class), tonumber(data.price), ang, nil, nil, tobool(data.flipped), self:GetNoChalk())
	//self.MyWallBuy:SetParent(self)
	self.MyWallBuy:SetSolid(SOLID_NONE)
	self:Trigger()

	local msg = "Entity("..self:EntIndex().."):Flashbangg()"
	for k, v in ipairs(player.GetAll()) do
		if v:TestPVS(self) then
			v:SendLua(msg)
		end
	end

	local wall = self.MyWallBuy
	timer.Simple(0.8, function()
		if not IsValid(wall) then return end
		wall:SetSolid(SOLID_OBB)
		wall:SetUseType(SIMPLE_USE)
	end)

	hook.Run("PlayerDrawWeaponChalk", nil, ply, self, self.MyWallBuy)

	nzChalks:TakePlayerChalk(ply)
	ply:SetPoints(ply:GetPoints() + (tonumber(data.points) or 1000)) //dont want cash sound to play

	self:EmitSound("NZ.Chalks.Finish")
end

function ENT:Reset()
	if self.MyWallBuy and IsValid(self.MyWallBuy) then
		self.MyWallBuy:Remove()
	end

	self:SetUsed(false)
	self:SetSolid(SOLID_OBB)
	self:DrawShadow(true)
	self:SetTrigger(true)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
end

function ENT:Trigger()
	self:SetUsed(true)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	self:SetTrigger(false)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
end
