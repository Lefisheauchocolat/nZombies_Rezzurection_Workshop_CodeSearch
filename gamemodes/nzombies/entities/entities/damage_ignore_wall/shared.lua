AddCSLuaFile( )

ENT.Type = "anim"
 
ENT.PrintName		= "invis_wall"
ENT.Author			= "Zet0r"
ENT.Contact			= "youtube.com/Zet0r"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar("Vector", 0, "MaxBound")
	self:NetworkVar("Int", 0, "Damage")
	self:NetworkVar("Int", 1, "Damage2")
	self:NetworkVar("Int", 2, "Damage3")
end

function ENT:Initialize()
	self:SetModel("models/BarneyHelmet_faceplate.mdl")
	self:DrawShadow( false )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	if self.SetRenderBounds then
		self:SetRenderBounds(Vector(0,0,0), self:GetMaxBound())
	end
	self:SetCustomCollisionCheck(true)

	if CLIENT then return end
	self.PlayersInside = {}
end

function ENT:Touch(ent)
	if ent:IsPlayer() and ent:GetNotDowned() and !table.HasValue(self.PlayersInside, ent) then
		if ent.DamageBarrierTypes then
			ent.DamageBarrierTypes = bit.bor(ent.DamageBarrierTypes, self:GetDamage(), self:GetDamage2(), self:GetDamage3())
		else
			ent.DamageBarrierTypes = bit.bor(self:GetDamage(), self:GetDamage2(), self:GetDamage3())
		end
		table.insert(self.PlayersInside, ent)
	end
end

function ENT:Think()
	if SERVER then
		for k, v in ipairs(self.PlayersInside) do
			if !IsValid(v) then self.PlayersInside[k] = nil continue end
			if !v:GetNotDowned() then
				self:EndTouch(v)
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:EndTouch(ent)
	if table.HasValue(self.PlayersInside, ent) then
		ent.DamageBarrierTypes = nil
		table.RemoveByValue(self.PlayersInside, ent)
	end
end

if CLIENT then
	local white = Color(100,0,200,30)

	function ENT:Draw()
		local nz_preview = GetConVar("nz_creative_preview")
		if !nz_preview:GetBool() and nzRound:InState( ROUND_CREATE ) then
			render.SetColorMaterial()
			render.DrawBox(self:GetPos(), self:GetAngles(), Vector(0,0,0), self:GetMaxBound(), white, true)
		end
	end
end

-- Causes collisions to completely disappear, not just traces :(
--[[function ENT:TestCollision(start, delta, hulltrace, bounds)
	return nil -- Traces pass through it!
end]]

hook.Add("PhysgunPickup", "nzInvisWallNotPickup", function(ply, wall)
	if wall:GetClass() == "damage_blocker" then return false end
end)
