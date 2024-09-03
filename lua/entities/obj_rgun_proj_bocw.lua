AddCSLuaFile()
ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.Spawnable 		= false
ENT.AdminSpawnable 	= false

sound.Add( {
	name = "rg_explode",
	volume = 1.0,
	level = 100,
	pitch = {100, 100},
	sound = "weapons/wpn_ray_explode.wav"
} )

ENT.CollideSND = "rg_explode"
ENT.Damage = 2000
ENT.MoveSpeed = 3500
function ENT:Initialize()
	self:SetModel( "models/roller.mdl" )
	self:SetNoDraw(true)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:DrawShadow(false)
	self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetSolidFlags(FSOLID_NOT_STANDABLE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	if CLIENT then return end
	self:SetTrigger(true)
	local eff = ents.Create("info_particle_system")
	eff:SetKeyValue("effect_name", self.TrailPCF)
	eff:SetKeyValue("start_active", "1")
	eff:SetPos(self:GetPos())
	eff:SetParent(self)
	eff:Spawn()
	eff:Activate()
	self.Effect = eff
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:SetMass( 1 )
		phys:EnableGravity( false )
		phys:EnableDrag( false )
		phys:Wake()
		phys:ApplyForceCenter(self:GetForward()*3500)
	else
		self:Remove()
	end
	self.LifeTime = CurTime() + math.Rand(3,4)
end
if SERVER then
	function ENT:OnCollide(ent,hitpos)
		if self.DoRemove then return end
		if self.Owner == ent then
			return true
		end
		self.DoRemove = true
		--self.Trail:SetParent(self.Effect)
		self.Effect:SetParent(NULL)
		SafeRemoveEntityDelayed(self.Effect,1)
		self.Effect:Fire("Stop")
		SafeRemoveEntityDelayed(self,0)
		self:NextThink(CurTime())
		local c = ent:GetClass()
  for _,v in pairs(ents.FindInSphere(hitpos,65)) do
  if ( gamemode.Get(name) == "nzombies" ) then
  if v:IsPlayer() and hook.Run("PlayerShouldTakeDamage",v,self.Owner) and not self.Owner then
			    return end			
		if c == "nz_spawn_player" then return end				
		if v == self.Owner then
			local dmg2 = DamageInfo()
			dmg2:SetDamage(15)
			dmg2:SetAttacker(self.Owner or self)
			dmg2:SetDamageForce(vector_origin)
			dmg2:SetDamagePosition( self.Entity:GetPos() )
			dmg2:SetInflictor( self )
			dmg2:SetDamageType( DMG_BLAST )	
		    v:TakeDamageInfo(dmg2)    
			 end
		 end
	 end
				 
				  for _,v in pairs(ents.FindInSphere(hitpos,65)) do
				  		if c == "nz_spawn_player" then return end		
				if v == self.Owner then
				local dmg3 = DamageInfo()
			dmg3:SetDamage(15)
			dmg3:SetAttacker(self.Owner or self)
			dmg3:SetDamageForce(vector_origin)
			dmg3:SetDamagePosition( self.Entity:GetPos() )
			dmg3:SetInflictor( self.Owner )								
			v:TakeDamageInfo(dmg3)
			else
			    local dmg4 = DamageInfo()
			dmg4:SetDamage(self.Damage)
			dmg4:SetAttacker(self.Owner or self)
			dmg4:SetDamageForce(vector_origin)
			dmg4:SetDamagePosition( self.Entity:GetPos() )
			dmg4:SetInflictor( self.Owner )								
			v:TakeDamageInfo(dmg4)		
     end
 end
	
for _,v in pairs(ents.FindInSphere(hitpos,65)) do		
  if v:IsNPC() or v.Type == "nextbot" then		
  		if c == "nz_spawn_player" then return end		
        local dmg = DamageInfo()
			dmg:SetDamage(self.Damage)
			dmg:SetAttacker(self.Owner)
			dmg:SetDamageForce(vector_origin)
			dmg:SetDamagePosition( self.Entity:GetPos() )
			dmg:SetInflictor( self.Owner )								
			v:TakeDamageInfo(dmg)

    end
end
        if c == "nz_zombie_boss_panzer" then
		util.BlastDamage( self, self.Owner, hitpos, 65, 335 )		
		end
		self:EmitSound(self.CollideSND)	
	    ParticleEffect( self.CollidePCF, hitpos, self:GetAngles() )		
		return true
	end
	
function ENT:StartTouch(ent)
	if (ent:GetClass() == "prop_dynamic") or (ent:GetClass() == "nz_spawn_zombie_normal") or (ent:GetClass() == "nz_spawn_zombie_special") or (ent:GetClass() == "player_spawns") then return end
	self:OnCollide(ent,self:GetPos())
end
	
function ENT:PhysicsCollide(data)
	self:OnCollide(data.HitEntity,data.HitPos)
end
end

