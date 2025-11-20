AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Plasmanade Logic"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Author = "DBot, FlamingFox"
ENT.RenderGroup = RENDERGROUP_OTHER
local nzombies = engine.ActiveGamemode() == "nzombies"
local entMeta = FindMetaTable("Entity")

if SERVER then
	entMeta.WAWPlasmaRage = function(self, duration)
		if upgrade == nil then
			upgrade = false
		end
		if duration == nil then
			duration = 0
		end

		if IsValid(self.waw_plasmanade_logic) then
			self.waw_plasmanade_logic:UpdateDuration(duration)
			return self.waw_plasmanade_logic
		end

		self.waw_plasmanade_logic = ents.Create("waw_status_effect_plasma")
		self.waw_plasmanade_logic:SetPos(self:WorldSpaceCenter())
		self.waw_plasmanade_logic:SetParent(self)
		self.waw_plasmanade_logic:SetOwner(self)

		self.waw_plasmanade_logic:Spawn()
		self.waw_plasmanade_logic:Activate()

		self.waw_plasmanade_logic:SetOwner(self)

		self.waw_plasmanade_logic:UpdateDuration(duration)
		self:SetNW2Entity("WAW.PlasmaLogic", self.waw_plasmanade_logic)
		return self.waw_plasmanade_logic
	end

	hook.Add("PlayerDeath", "WAW.PlasmaLogic", function(self)
		if IsValid(self.waw_plasmanade_logic) then
			return self.waw_plasmanade_logic:Remove()
		end
	end)
end

entMeta.WAWIsPlasmaEnraged = function(self)
	return IsValid(self:GetNW2Entity("WAW.PlasmaLogic"))
end

ENT.Initialize = function(self)
	self:SetNoDraw(true)
	self:SetNotSolid(true)
	self:SetMoveType(MOVETYPE_NONE)

	local p = self:GetParent()
	if IsValid(p) then
		p:SetNW2Float("pbokefade", CurTime())
		p:EmitSound("TFA_WAW_PLASMANADE.Player.EMP")
		ParticleEffectAttach("waw_plasmanade_player", PATTACH_POINT_FOLLOW, p, 0)
	end

	self:EmitSound("TFA_WAW_PLASMANADE.Player.Start")
	self:EmitSound("TFA_WAW_PLASMANADE.Player.Loop")

	if CLIENT then return end
	self.statusStart = CurTime()
	self.duration = engine.TickInterval()
	self.statusEnd = self.statusStart + self.duration
end

ENT.UpdateDuration = function(self, newtime)
	if newtime == nil then
		newtime = 0
	end

	if self.statusEnd - CurTime() > newtime then return end

	self.duration = newtime
	self.statusEnd = self.statusEnd + newtime
end

ENT.Think = function(self)
	if CLIENT then return false end

	if self.statusEnd < CurTime() then
		local p = self:GetParent()
		if IsValid(p) then
			p:StopParticles()
		end
		self:StopSound("TFA_WAW_PLASMANADE.Player.Loop")
		self:Remove()
		return false
	end

	self:NextThink(CurTime())
	return true
end

ENT.OnRemove = function(self)
	local p = self:GetParent()
	if IsValid(p) then
		p:StopParticles()
		p:SetNW2Float("pbokefade", CurTime())
		ParticleEffectAttach("waw_plasmanade_end", PATTACH_ABSORIGIN_FOLLOW, p, 0)
	end

	self:StopSound("TFA_WAW_PLASMANADE.Player.Loop")
	self:EmitSound("TFA_WAW_PLASMANADE.Player.End")
end

ENT.Draw = function(self)
end