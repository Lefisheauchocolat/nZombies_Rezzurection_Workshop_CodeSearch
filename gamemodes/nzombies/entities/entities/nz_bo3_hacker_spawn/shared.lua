AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "nz_bo3_hacker_spawn"
ENT.Author			= "fox"
ENT.Contact			= "dont"
ENT.Purpose			= "hacker spawn point"
ENT.Instructions	= ""

ENT.NZHudIcon = Material("vgui/icon/uie_t5hud_icon_hacker.png", "smooth unlitgeneric")

function ENT:Initialize()
	self:SetModel("models/weapons/tfa_bo3/hacker/hacker_prop.mdl")

	if SERVER then
		self:DrawShadow(false)
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:PhysicsInit(SOLID_NONE)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetTrigger(true)
	end

	self:SetColor(Color(255, 255, 255, 120))
	self:SetRenderMode(RENDERMODE_GLOW)
	self:SetRenderFX(4)
end

function ENT:OnRemove()
	hook.Call("nzmapscript_PropRemoved", nil, self)
end

if SERVER then
	function ENT:Use(ply)
		if not IsValid(ply) then return end
		if not nzRound:InState(ROUND_CREATE) and ply:IsInCreative() then return end
		if ply:HasWeapon('tfa_bo3_hacker') then return end
		if ply:KeyDown(IN_SPEED) then return end

		ply:EmitSound("weapon_bo3_cloth.med")
		self:EmitSound("weapon_bo3_gear.rattle")
		ply:Give('tfa_bo3_hacker')
	end
end

if CLIENT then
	function ENT:Draw()
		if not nzRound:InState( ROUND_CREATE ) then return end
		self:DrawModel()
	end

	function ENT:GetNZTargetText()
		if not nzRound:InState( ROUND_CREATE ) then return end
		return "Hacker Spawn"
	end
end