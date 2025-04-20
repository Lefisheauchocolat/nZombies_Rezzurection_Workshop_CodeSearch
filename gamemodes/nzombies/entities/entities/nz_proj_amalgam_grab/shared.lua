ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Amalgam Grab Hitbox"
ENT.Author = "Zet0r"

ENT.Spawnable = false
ENT.AdminSpawnable = false

if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("nz_amalgam_grab")
end

ENT.GibSounds = {
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_00.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_01.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_02.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_03.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_04.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_05.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_06.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_07.mp3"),
	Sound("nz_moo/zombies/vox/_amal/fly/fly_amal_gib_victim_08.mp3"),
}

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Amalgam")
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
	self:SetLocalVelocity(dir * 2000)
	self:SetAngles((dir*-1):Angle())
	self:SetSequence(self:LookupSequence("anim_close"))
	
	self.AutoReturnTime = CurTime() + 1.75
	self.AutoBreak = CurTime() + 4
end

function ENT:Grab(ply, pos) -- Pos is used for clients who may not have the Panzer valid yet
	if !IsValid(ply) then return end
	
	self.HasGrabbed = true

	local amalgam = self:GetAmalgam()
	local speed = 750
	local pos = pos or IsValid(amalgam) and amalgam:GetAttachment(amalgam:LookupAttachment("grab_attach")).Pos
	
	self.GrabbedPlayer = ply
	local breaktime = CurTime() + 3
	local index = self:EntIndex()
	
	self:EmitSound("nz_moo/zombies/vox/_amal/fly/fly_amal_grab_arm_retract_short.mp3", 80, math.random(95,105))

	hook.Add("SetupMove", "AmalgamGrab"..index, function(pl, mv, cmd)
		if !IsValid(ply) or IsValid(ply) and !ply:GetNotDowned() then self:Release() end
		
		if pl == ply then
			local dir = (pos - (pl:GetPos() + Vector(0,0,50))):GetNormalized()
			mv:SetVelocity(dir * speed)
			
			if !IsValid(amalgam) or !IsValid(Entity(index)) then
				hook.Remove("SetupMove", "AmalgamGrab"..index)
			else
				local dist = (pl:GetPos() + Vector(0,0,50)):Distance(pos)
				if dist < 50 then
					speed = 200
				end
				if dist < 70 then
					self:Reattach()
				end
			end

			if mv:GetVelocity():Length() > 50 then -- Keep a speed over 100
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
		net.Start("nz_amalgam_grab")
			net.WriteBool(true)
			net.WriteEntity(self)
			net.WriteVector(pos)
		net.Send(ply)
		
		self:SetSequence(self:LookupSequence("anim_open"))
	end
	
end

function ENT:Release()
	if IsValid(self.GrabbedPlayer) then
		local amalgam = self:GetAmalgam()
		amalgam:FinishGrab()
		hook.Remove("SetupMove", "AmalgamGrab"..self:EntIndex())
		
		if SERVER then
			net.Start("nz_amalgam_grab")
				net.WriteBool(false)
				net.WriteEntity(self)
			net.Send(self.GrabbedPlayer)
			
			self:SetSequence(self:LookupSequence("anim_open"))
			self:Return()
		end
	else
		if SERVER then
			net.Start("nz_amalgam_grab")
				net.WriteBool(false)
				net.WriteEntity(self)
			net.Broadcast()
		end
	end
	self.GrabbedPlayer = nil
end

if CLIENT then
	net.Receive("nz_amalgam_grab", function()
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
	self.HasGrabbed = true
	self.Retract = true

	local amalgam = self:GetAmalgam()
	if !IsValid(amalgam) then self:Remove() return end

	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self:SetNotSolid(true)
	self:SetCollisionBounds(Vector(0,0,0), Vector(0,0,0))
end

function ENT:Reattach(removed)
	if SERVER then
		if !removed then self:Remove() end
	end
	
	local amalgam = self:GetAmalgam()
	if !IsValid(amalgam) then return end

	amalgam:FinishGrab()
end

function ENT:StartTouch(ent)
	local amalgam = self:GetAmalgam()
	if IsValid(amalgam) and !self.HasGrabbed  then
		if ent:IsPlayer() and amalgam:IsValidTarget(ent) then
			--self:EmitSound("death.wav")
			self:Grab(ent)
		else
			if ent:GetClass() == "nz_zombie_boss_amalgam" or ent.IsMooZombie then return end
			self:Return()
		end
	else
		if SERVER then
			self:Remove()
		end
	end
end


function ENT:Think()
	if SERVER then
		if self.HasGrabbed then
			local amalgam = self:GetAmalgam()
			if !IsValid(amalgam) then self:Remove() return end
			
			if !IsValid(self.GrabbedPlayer) and self:GetPos():DistToSqr(amalgam:GetAttachment(amalgam:LookupAttachment("grab_attach")).Pos) <= 5000 then
				self:Reattach()
			end
			
			if IsValid(amalgam) and self.GrabbedPlayer and !amalgam:IsValidTarget(self.GrabbedPlayer) then
				self:Release()
			end
			
			if CurTime() > self.AutoBreak then
				self:Release()
			end
		elseif CurTime() > self.AutoReturnTime then 
			self:Return()
		end
		if self.Retract then
			local amalgam = self:GetAmalgam()
			local att = amalgam:GetAttachment(amalgam:LookupAttachment("grab_attach")).Pos
			if att then
				self:SetPos(LerpVector( 0.1, self:GetPos(), att ))
			end
		end
	end
	self:NextThink(CurTime())
	return true
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end

	local col = Color(255,255,255,255)
	local mat = Material("models/flesh_cable")
	hook.Add( "PostDrawOpaqueRenderables", "amalgam_claw_wires", function()
		for k,v in pairs(ents.FindByClass("nz_proj_amalgam_grab")) do
			local amalgam = v:GetAmalgam()
			if IsValid(amalgam) then
				local Vector1 = amalgam:GetAttachment(amalgam:LookupAttachment("grab_attach")).Pos
				local Vector2 = v:GetPos() + v:GetAngles():Forward()*10
				render.SetMaterial( mat )
				render.DrawBeam( Vector1, Vector2, 5, 1, 1, col )
			end
		end
	end )
end

function ENT:OnRemove()
	if SERVER then
		local amalgam = self:GetAmalgam()
		amalgam:FinishGrab()
	end
	self:Release()
	self:Reattach(true)

	for i = 1, 5 do 
		ParticleEffect("ins_blood_impact_headshot",self:GetPos(),self:GetAngles(),nil) 
	end
	self:EmitSound(self.GibSounds[math.random(#self.GibSounds)],100)
end