AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Buildable Hologram"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true

local nzombies = engine.ActiveGamemode() == "nzombies"

function ENT:Initialize()
	if SERVER then
		self:DrawShadow(false)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:PhysicsInit(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_NONE)
		self:SetTrigger(false)
	end

	if CLIENT then
		local p = self:GetParent()
		if IsValid(p) then
			if not p.HoloGramEnt then p.HoloGramEnt = {} end
			table.insert(p.HoloGramEnt, self)
			if not table.HasValue(p.HoloGramEnt, p) then
				table.insert(p.HoloGramEnt, p)
			end
		end
	end

	self:SetAutomaticFrameAdvance(true)

	self:GoGhost()
end

function ENT:OnRemove()
	local p = self:GetParent()
	if IsValid(p) and p.HoloGramEnt and table.HasValue(p.HoloGramEnt, self) then
		table.RemoveByValue(p.HoloGramEnt, self)
	end
end

function ENT:Think()
	self:NextThink(CurTime())
	return true
end

function ENT:GoGhost()
	self:SetColor(Color(255, 255, 255, 100))
	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetRenderFX(16)
end

function ENT:Reset()
	self:SetColor(Color(255, 255, 255, 255))
	self:SetRenderMode(RENDERMODE_NORMAL)
	self:SetRenderFX(0)
end
