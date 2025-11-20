-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Weapon Pickup"
ENT.Purpose = ""
ENT.Instructions = ""
ENT.Spawnable = false
ENT.AdminOnly = false

--[Parameters]--
ENT.Delay = 30

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Gun")
end

function ENT:Draw()
	self:DrawModel()

	if nzPowerUps.PowerUpGlowTypes and (!self.loopglow or !IsValid(self.loopglow)) then
		local colorvec1 = nzMapping.Settings.powerupcol["local"][1]
		local colorvec2 = nzMapping.Settings.powerupcol["local"][2]
		local colorvec3 = nzMapping.Settings.powerupcol["local"][3]

		if nzMapping.Settings.powerupstyle then
			local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
			self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_ABSORIGIN_FOLLOW)
			self.loopglow:SetControlPoint(2, colorvec1)
			self.loopglow:SetControlPoint(3, colorvec2)
			self.loopglow:SetControlPoint(4, colorvec3)
			self.loopglow:SetControlPoint(1, Vector(1,1,1))
		else
			self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_ABSORIGIN_FOLLOW)
			self.loopglow:SetControlPoint(2, colorvec1)
			self.loopglow:SetControlPoint(3, colorvec2)
			self.loopglow:SetControlPoint(4, colorvec3)
			self.loopglow:SetControlPoint(1, Vector(1,1,1))
		end
	end
end

function ENT:Use(ply)
	if IsValid(ply) and ply:IsPlayer() then
		self:StopSound(self.LoopSound)
		self:EmitSound(self.GrabSound)

		self:Effect(ply)
		self:Remove()
	end
end

function ENT:Initialize()
	if SERVER then
		local wepmodel = ents.Create(self:GetGun())
		self:SetModel(wepmodel:GetWeaponWorldModel())
	end
	self:SetModelScale(1, 0)

	self:PhysicsInit(SOLID_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_BBOX)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:UseTriggerBounds(true, 5)

	self:SetColor(Color(0,0,0))
	self:SetMaterial("models/weapons/powerups/mtl_x2icon_gold")

	self.LoopSound =  "nz_moo/powerups/powerup_lp_zhd.wav"
	self.GrabSound = "nz_moo/powerups/powerup_pickup_zhd.mp3"
	self.SpawnSound = "nz_moo/powerups/powerup_spawn_zhd_"..math.random(1,3)..".mp3"

	if !table.IsEmpty(nzSounds.Sounds.Custom.Loop) then
		self.LoopSound = tostring(nzSounds.Sounds.Custom.Loop[math.random(#nzSounds.Sounds.Custom.Loop)])
	end
	if !table.IsEmpty(nzSounds.Sounds.Custom.Grab) then
		self.GrabSound = tostring(nzSounds.Sounds.Custom.Grab[math.random(#nzSounds.Sounds.Custom.Grab)])
	end
	if !table.IsEmpty(nzSounds.Sounds.Custom.Spawn) then
		self.SpawnSound = tostring(nzSounds.Sounds.Custom.Spawn[math.random(#nzSounds.Sounds.Custom.Spawn)])
	end

	self:EmitSound(self.SpawnSound, 75)
	self:EmitSound(self.LoopSound, 75, 100, 0.5, 3)

	if !nzPowerUps.PowerUpGlowTypes then
		ParticleEffectAttach("bo3_qed_powerup_local", PATTACH_ABSORIGIN_FOLLOW, self, 1)
	end

	if CLIENT then return end
	if nzPowerUps.PowerUpGlowTypes then
		local fx = EffectData()
		fx:SetOrigin(self:GetPos()) //position
		fx:SetAngles(angle_zero) //angle
		fx:SetNormal(Vector(1,1,1)) //size (dont ask why its a vector)
		fx:SetFlags(2) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

		local filter = RecipientFilter()
		filter:AddPVS(self:GetPos())
		if filter:GetCount() > 0 then
			util.Effect("nz_powerup_poof", fx, true, filter)
		end
	end

	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
	SafeRemoveEntityDelayed(self, self.Delay)
end

function ENT:Think()
	if CLIENT then
		if !self:GetRenderAngles() then self:SetRenderAngles(self:GetAngles()) end
		self:SetRenderAngles(self:GetRenderAngles() + Angle(2,50,5)*math.sin(CurTime()/10)*FrameTime())
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Effect(ply)
	local wep = ply:GetWeapon(self:GetGun())
	if IsValid(wep) then
		wep:GiveMaxAmmo()
	else
		local gun = ply:Give(self:GetGun())
		gun:GiveMaxAmmo()
	end

	if SERVER then
		net.Start("TFA.BO3.QED_SND")
			net.WriteString("WeaponGive")
		net.Send(ply)
	end

	self:Remove()
end

function ENT:OnRemove()
	self:StopSound(self.LoopSound)
	if nzPowerUps.PowerUpGlowTypes and SERVER then
		local fx = EffectData()
		fx:SetOrigin(self:GetPos()) //position
		fx:SetAngles(angle_zero) //angle
		fx:SetNormal(Vector(1,1,1)) //size (dont ask why its a vector)
		fx:SetFlags(2) //powerup type, see nzPowerUps.PowerUpGlowTypes in gamemode/powerups/sh_constructor

		local filter = RecipientFilter()
		filter:AddPVS(self:GetPos())
		if filter:GetCount() > 0 then
			util.Effect("nz_powerup_poof", fx, true, filter)
		end
	end
end

if CLIENT then
	function ENT:GetNZTargetText()
		return "Press "..string.upper(input.LookupBinding("+USE")).." - Pickup "..weapons.Get(self:GetGun()).PrintName
	end
end