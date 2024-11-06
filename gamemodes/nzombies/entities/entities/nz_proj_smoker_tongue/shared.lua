ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Smoker Tongue"
ENT.Author = "GhostlyMoo"

ENT.Spawnable = false
ENT.AdminSpawnable = false

if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("nz_smoker_grab")
end

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Smoker")
end

function ENT:Initialize()
	if SERVER then
        self:SetModel("models/dav0r/hoverball.mdl")
		self:PhysicsInit(SOLID_OBB)
		self:SetSolid(SOLID_NONE)
		self:SetTrigger(true)
		self:UseTriggerBounds(true, 0)
		self:SetMoveType(MOVETYPE_FLY)

		self:SetNoDraw(true)
		self:SetMaterial("invisible")

		--ParticleEffectAttach("doom_imp_fireball_cheap",PATTACH_ABSORIGIN_FOLLOW,self,0)
		--self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)
		--self:SetSolid(SOLID_VPHYSICS)
		phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
		end
	end
end

function ENT:Launch(dir)
	self:SetLocalVelocity(dir * 3000)
	self:SetAngles((dir*-1):Angle())
	self:SetSequence(self:LookupSequence("anim_close"))
	
	self.AutoReturnTime = CurTime() + 0.75
	self.AutoBreak = CurTime() + 2

	self:EmitSound("nz_moo/zombies/vox/_smoker/tongue_fly_loop.wav", 65)
end

function ENT:Grab(ply, pos) -- Pos is used for clients who may not have the smoker valid yet
	if !IsValid(ply) then return end
	
	self.HasGrabbed = true

	local smoker = self:GetSmoker()
	local speed = 750
	local pos = pos or IsValid(smoker) and smoker:GetAttachment(smoker:LookupAttachment("smoker_mouth")).Pos
	
	self.GrabbedPlayer = ply
	local breaktime = CurTime() + 3
	local index = self:EntIndex()

	self:EmitSound(self.LaunchHitSounds[math.random(#self.LaunchHitSounds)], 100, math.random(85, 105))
	ply:EmitSound("nz_moo/zombies/vox/_smoker/music/tonguetiedhit.mp3", SNDLVL_GUNFIRE)

	hook.Add("SetupMove", "SmokerGrab"..index, function(pl, mv, cmd)
		if !IsValid(ply) or IsValid(ply) and !ply:GetNotDowned() then self:Release() end
		
		if pl == ply then
			local dir = (pos - (pl:GetPos() + Vector(0,0,50))):GetNormalized()
			mv:SetVelocity(dir * speed)
			
			if !IsValid(smoker) or !IsValid(Entity(index)) then
				hook.Remove("SetupMove", "SmokerGrab"..index)
			else
				local dist = (pl:GetPos() + Vector(0,0,50)):Distance(pos)
				if dist < 50 then
					speed = 200
				end
				if dist < 16 then
					self:Reattach()
				end
			end

			if mv:GetVelocity():Length() > 100 then -- Keep a speed over 100
				breaktime = CurTime() + 3 -- Then we keep delaying when to "break" the hook
			elseif CurTime() > breaktime then -- But if you haven't been over 100 speed for the time
				self:Release() -- Break the hook!				
			end
			
			if SERVER then
				self:SetPos(pl:GetPos() + Vector(0,0,50))
			end
		end
	end)
	
	if SERVER then
		self:SetLocalVelocity(Vector(0,0,0))
		net.Start("nz_smoker_grab")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteVector(pos)
		net.Send(ply)
		
		self:SetSequence(self:LookupSequence("anim_open"))
	end
	
end

function ENT:Release()
	if IsValid(self.GrabbedPlayer) then
		local smoker = self:GetSmoker()

		if IsValid(smoker) then
			smoker:FinishGrab()
		end
		hook.Remove("SetupMove", "SmokerGrab"..self:EntIndex())
		
		if SERVER then
			net.Start("nz_smoker_grab")
				net.WriteBool(false)
				net.WriteEntity(self)
			net.Send(self.GrabbedPlayer)
			
			self:SetSequence(self:LookupSequence("anim_open"))
			self:Return()
		end
	else
		if SERVER then
			net.Start("nz_smoker_grab")
				net.WriteBool(false)
				net.WriteEntity(self)
			net.Broadcast()
		end
	end
	self.GrabbedPlayer = nil
end

if CLIENT then
	net.Receive("nz_smoker_grab", function()
		local grab = net.ReadBool()
		local ent = net.ReadEntity()
		local pos
		if grab then pos = net.ReadVector() end
		
		if IsValid(ent) then
			if grab then
				ent:Grab(LocalPlayer(), pos)
			else
				if IsValid(ent) then ent:Release() end
			end
		end
	end)
end

function ENT:Return() -- Emptyhanded return - Grab is with player
	--print("return")
	self:EmitSound(self.RetractSounds[math.random(#self.RetractSounds)], 100, math.random(85, 105))
	self.HasGrabbed = true
	self.Retract = true

	local smoker = self:GetSmoker()
	if !IsValid(smoker) then self:Remove() return end

	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetNotSolid(true)
	self:SetCollisionBounds(Vector(0,0,0), Vector(0,0,0))
end

function ENT:Reattach(removed)
	if SERVER then
		self:StopSound("nz_moo/zombies/vox/_smoker/tongue_fly_loop.wav")
		if !removed then self:Remove() end
	end
	
	local smoker = self:GetSmoker()
	if !IsValid(smoker) then return end
	
	smoker:FinishGrab()
end

function ENT:StartTouch(ent)
	local smoker = self:GetSmoker()
	if IsValid(smoker) and !self.HasGrabbed  then
		if ent:IsPlayer() and smoker:IsValidTarget(ent) then
			--self:EmitSound("death.wav")
			self:Grab(ent)
		else
			if ent:GetClass() == "nz_zombie_special_l4d_smoker" or ent.IsMooZombie then return end
			self:Return()
		end
	else
		if SERVER then
			if ent:IsWorld() then
				self:Return()
			else
				self:Remove()
			end
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end

	local col = Color(200,100,100,255)
	local mat = Material("cable/cable2")
	hook.Add( "PostDrawOpaqueRenderables", "smoker_claw_wires", function()
		for k,v in pairs(ents.FindByClass("nz_proj_smoker_tongue")) do
			local smoker = v:GetSmoker()
			if IsValid(smoker) then
				local Vector1 = smoker:GetAttachment(smoker:LookupAttachment("smoker_mouth")).Pos
				local Vector2 = v:GetPos() + v:GetAngles():Forward()*10
				render.SetMaterial( mat )
				render.DrawBeam( Vector1, Vector2, 3, 1, 1, col )
			end
		end
	end )
end


function ENT:Think()
	if SERVER then
		if self.HasGrabbed then
			local smoker = self:GetSmoker()
			if !IsValid(smoker) then self:Remove() return end
			
			if !IsValid(self.GrabbedPlayer) and self:GetPos():DistToSqr(smoker:GetAttachment(smoker:LookupAttachment("smoker_mouth")).Pos) <= 10000 then
				self:Reattach()
			end
			
			if IsValid(smoker) and self.GrabbedPlayer and !smoker:IsValidTarget(self.GrabbedPlayer) then
				self:Release()
			end
			
			if CurTime() > self.AutoBreak then
				self:Release()
			end
		elseif CurTime() > self.AutoReturnTime then 
			self:Return()
		end
		if self.Retract then
			local smoker = self:GetSmoker()
			local att = smoker:GetAttachment(smoker:LookupAttachment("smoker_mouth")).Pos
			if att then
				self:SetPos(LerpVector( 0.1, self:GetPos(), att ))
			end
		end
	end
	self:NextThink(CurTime())
	return true
end

function ENT:OnRemove()
	if SERVER then
		local smoker = self:GetSmoker()
		if IsValid(smoker) then
			smoker:FinishGrab()
		end
		self:StopSound("nz_moo/zombies/vox/_smoker/tongue_fly_loop.wav")
	end
	self:Release()
	self:Reattach(true)
end

ENT.RetractSounds = {
	Sound("nz_moo/zombies/vox/_smoker/miss/smoker_reeltonguein_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/miss/smoker_reeltonguein_02.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/miss/smoker_reeltonguein_03.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/miss/smoker_reeltonguein_04.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/miss/smoker_reeltonguein_05.mp3"),
}

ENT.LaunchHitSounds = {
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_tonguehit_01.mp3"),
	Sound("nz_moo/zombies/vox/_smoker/voice/attack/smoker_tonguehit_02.mp3"),
}
