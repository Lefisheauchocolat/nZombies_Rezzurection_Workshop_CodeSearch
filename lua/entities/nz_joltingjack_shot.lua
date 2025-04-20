ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Mangler Shot"
ENT.Author = "Zet0r"

ENT.Spawnable = false
ENT.AdminSpawnable = false

if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("nz_panzer_grab")
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Panzer")
end

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/w_eq_fraggrenade.mdl") -- Change later
		self:SetNoDraw(true)
		ParticleEffectAttach("bo3_mangler_pulse",PATTACH_ABSORIGIN_FOLLOW,self,0)
		self:PhysicsInit(SOLID_OBB)
		self:SetSolid(SOLID_NONE)
		self:SetTrigger(true)
		self:UseTriggerBounds(true, 0)
		self:SetMoveType(MOVETYPE_FLY)

		phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
		end
	end
end

function ENT:Launch(dir)
	self:SetLocalVelocity(dir * 1000)
	self:SetAngles((dir*-1):Angle())
end

function ENT:OnContact(ent)

	local panzer = self:GetParent()
	if ent:IsPlayer() or ent:IsWorld() then
		self:EmitSound("roach/bo3/raz/imp_0"..math.random(3)..".mp3")
		ParticleEffectAttach("bo3_mangler_blast",PATTACH_ABSORIGIN,self,0)
		local ent = ents.Create("env_explosion")
		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		ent:Spawn()
		ent:SetKeyValue("imagnitude", "21")
		ent:Fire("explode")
		
		self.ExplosionLight1 = ents.Create("light_dynamic")
		self.ExplosionLight1:SetKeyValue("brightness", "4")
		self.ExplosionLight1:SetKeyValue("distance", "300")
		self.ExplosionLight1:SetLocalPos(self:GetPos())
		self.ExplosionLight1:SetLocalAngles(self:GetAngles())
		self.ExplosionLight1:Fire("Color", "255 150 0")
		self.ExplosionLight1:SetParent(self)
		self.ExplosionLight1:Spawn()
		self.ExplosionLight1:Activate()
		self.ExplosionLight1:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.ExplosionLight1)
		
		SafeRemoveEntityDelayed(self,0.1)
	end
end
	
function ENT:StartTouch(ent)
	local panzer = self:GetParent()
	if ent:IsPlayer() or ent:IsWorld() then
		self:EmitSound("roach/bo3/raz/imp_0"..math.random(3)..".mp3")
		ParticleEffectAttach("bo3_mangler_blast",PATTACH_ABSORIGIN,self,0)
		local ent = ents.Create("env_explosion")
		ent:SetPos(self:GetPos())
		ent:SetAngles(self:GetAngles())
		ent:Spawn()
		ent:SetKeyValue("imagnitude", "21")
		ent:Fire("explode")
		
		self.ExplosionLight1 = ents.Create("light_dynamic")
		self.ExplosionLight1:SetKeyValue("brightness", "4")
		self.ExplosionLight1:SetKeyValue("distance", "300")
		self.ExplosionLight1:SetLocalPos(self:GetPos())
		self.ExplosionLight1:SetLocalAngles(self:GetAngles())
		self.ExplosionLight1:Fire("Color", "255 150 0")
		self.ExplosionLight1:SetParent(self)
		self.ExplosionLight1:Spawn()
		self.ExplosionLight1:Activate()
		self.ExplosionLight1:Fire("TurnOn", "", 0)
		self:DeleteOnRemove(self.ExplosionLight1)
		SafeRemoveEntityDelayed(self,0.1)
	end
end

function ENT:OnRemove()
end
