ENT.Type = "anim"

ENT.PrintName		= "stinky_lever"
ENT.Author			= "Laby"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.bPhysgunNoCollide = true

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "ohfuck")
end


AddCSLuaFile()



function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel( "models/nzr/2022/misc/maldometer.mdl" )
	end
	self:Setohfuck(false)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
end

function ENT:Use( activator, caller )
	if nzRound:InProgress() then
		if self:Getohfuck() then
			for k,v in pairs(ents.FindByClass("stinky_lever")) do
				PrintMessage(HUD_PRINTTALK, "THIS BORING MOTHER FUCKER -->"..activator:Nick().."<-- JUST DEACTIVATED THE MALDOMETER AND GOT SENT TO THE CUM ZONE")
				activator:KillSilent()
				self:SetSkin(0)
				v:Setohfuck(false)
			end
			self:Setohfuck(false)

			if nzRound:GetRampage() then
				nzRound:DisableRampage()
			end

			--self:EmitSound("nzr/maldometer/xsound_5ea1ae90c6e3660.wav", 100, math.random(95,105))

			self:EmitSound("nz_moo/effects/deactivate.mp3", 577, math.random(95, 105))
		else
			for k,v in pairs(ents.FindByClass("stinky_lever")) do
				PrintMessage(HUD_PRINTTALK, "THIS DUMB MOTHER FUCKER -->"..activator:Nick().."<-- JUST ACTIVATED THE MALDOMETER")
				self:SetSkin(1)
				v:Setohfuck(true)
			end
			self:Setohfuck(true)

			if !nzRound:GetRampage() then
				nzRound:EnableRampage()
			end

			--self:EmitSound("nzr/maldometer/xsound_5ea1ae90c6e3660.wav", 100, math.random(95,105))

			self:EmitSound("nz_moo/effects/activate.mp3", 577, math.random(95, 105))
			if math.random(500) == 420 then
				if math.random(0,1) == 1 then
					self:EmitSound("God_Cum_Zone.wav", 577)
				else
					self:EmitSound("Demon_Cum_Zone.wav", 577)
				end
			end
		end
	end
end

function ENT:Think()
	if CLIENT and DynamicLight then
		local dlight = DynamicLight(self:EntIndex(), false)
		if (dlight) then
			local color = nzMapping.Settings.zombieeyecolor or Color(40, 255, 60, 255)
			dlight.pos = self:WorldSpaceCenter()
			dlight.r = color.r
			dlight.g = color.g
			dlight.b = color.b
			dlight.brightness = 1
			dlight.Decay = 1000
			dlight.Size = 64
			dlight.DieTime = CurTime() + 1
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:Draw()
	self:DrawModel()
end