AddCSLuaFile( )

ENT.Base = "prop_buys" -- prop_buys are purchaseable props and this is an invisible prop, let's combine the functionality!

ENT.Type = "anim"
 
ENT.PrintName		= "zombie_wall_block"
ENT.Author			= "Alig96 & Zet0r"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.NZOnlyVisibleInCreative = true


function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSubMaterial(0, "models/wireframe")
	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	self:SetCustomCollisionCheck(true)
	self:SetColor(Color(0, 255, 0))
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(false)
		phys:Sleep()
	end
end



if CLIENT then
	function ENT:Draw()
		if ConVarExists("nz_creative_preview") and !GetConVar("nz_creative_preview"):GetBool() and nzRound:InState( ROUND_CREATE ) then
			self:DrawModel()
		end
	end
end