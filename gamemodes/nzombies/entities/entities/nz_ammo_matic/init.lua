AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

DEFINE_BASECLASS( "base_anim" )

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	self:SetModel("models/nzr/2022/perk/ammomatic.mdl")

	self:DrawShadow(true)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)

	if not self.Jingle then
		self.Jingle = "nzr/2023/ammomatic/ammomatic_jingle.mp3"
	end
	if not self.Sting then
		self.Sting = "nzr/2023/ammomatic/ammomatic_stinger.mp3"
	end

	self:SetActive(false)
end

function ENT:Use(ply)
	if CLIENT then return end
	if not IsValid(ply) then return end
	if not self:GetActive() then return end
	if self:IsCoolingDown() then
		ply:Buy(math.huge, self, function() return true end)
		return
	end

	ply:Buy(self:GetPrice(), self, function()
		local time = CurTime()
		for _, ent in pairs(ents.FindByClass("nz_ammo_matic")) do
			ent:SetNextCooldown(time + self:GetTotalCooldown())
		end

		self:EmitSound("NZ.Tomb.Perk.Stinger")
		timer.Simple(1.2, function()
			if not IsValid(self) then return end
			if !self.PlayingJingle and self.Sting then
				self:EmitSound(self.Sting, SNDLVL_TALKING, math.random(97, 103))
			end
		end)

		nzPowerUps:SpawnPowerUp((self:GetPos() - Vector(0,0,6)) + self:GetForward()*50, "maxammo")
		return true
	end)
end

function ENT:Think()
	if self:GetActive() and self.NextJingle and CurTime() > self.NextJingle and !self.PlayingJingle and !self.NoJingle then
		local NJ = CurTime() + math.random(300,900)
		local WFJ = CurTime() + 55

		if self.Jingle then
			self.PlayingJingle = true

			self.NextJingle = NJ
			self.WaitforJingle = WFJ

			self:EmitSound(self.Jingle, 75, math.random(97, 103))
		else
			self.NoJingle = true
		end
	end

	if self.WaitforJingle and CurTime() > self.WaitforJingle and self.PlayingJingle then
		self.PlayingJingle = false -- This is just because mp3s don't work with getting their duration.
	end

	self:NextThink(CurTime())
	return true
end

-- Funny Spare Change Code: By GhostlyMoo
function ENT:Touch(ent)
	if ent:IsPlayer() and ent:Crouching() and !self.LooseChange then
		self.LooseChange = true
		ent:GivePoints(100)
	end
end

function ENT:StartTouch(ent)
	if ent:IsPlayer() and (!self.NextBump or self.NextBump < CurTime()) then
		self:EmitSound("nz_moo/perkacolas/bump/vend_0"..math.random(0,2)..".mp3", SNDLVL_TALKING)
		self.NextBump = CurTime() + 1
	end
end

function ENT:Reset()
	self:TurnOff()
	self.LooseChange = nil
	self.NextBump = nil
	self.PlayingJingle = nil
	self.NextJingle = nil
end

function ENT:TurnOn()
	self:SetActive(true)
	self.NextJingle = CurTime() + math.random(0,600)
end

function ENT:TurnOff()
	if nzRound:InProgress() and nzElec:IsOn() then return end
	self:SetActive(false)
	self:SetNextCooldown(CurTime())
end

function ENT:OnRemove()
end
