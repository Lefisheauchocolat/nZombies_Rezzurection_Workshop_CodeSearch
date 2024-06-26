AddCSLuaFile( )

ENT.Base = "prop_buys" -- prop_buys are purchaseable props and this is an invisible prop, let's combine the functionality!

ENT.Type = "anim"
 
ENT.PrintName		= "wall_block"
ENT.Author			= "Alig96 & Zet0r"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.NZOnlyVisibleInCreative = true

--[[function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "BlockPlayers")
	self:NetworkVar("Bool", 1, "BlockZombies")
end

function ENT:SetFilter(players, zombies)
	if players and zombies then
		self:SetBlockPlayers(true)
		self:SetBlockZombies(true)
		self:SetCustomCollisionCheck(false)
		self:SetColor(Color(255,255,255))
	elseif players and !zombies then
		self:SetBlockPlayers(true)
		self:SetBlockZombies(false)
		self:SetCustomCollisionCheck(true)
		self:SetColor(Color(100,100,255))
	elseif !players and zombies then
		self:SetBlockPlayers(false)
		self:SetBlockZombies(true)
		self:SetCustomCollisionCheck(true)
		self:SetColor(Color(255,100,100))
	end
end]]

function ENT:Initialize()
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:DrawShadow( false )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	self:SetCustomCollisionCheck(true)
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