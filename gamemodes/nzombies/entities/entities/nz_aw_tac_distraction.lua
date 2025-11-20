AddCSLuaFile()

--[Info]--
ENT.Base = "tfa_exp_base"
ENT.PrintName = "Distraction Drone"

--[Parameters]--
ENT.Delay = 1
ENT.Range = 200
ENT.GlowColor = Color(255, 25, 25, 255)

ENT.Mat = Material("cable/smoke")
ENT.Mat2 = Material("cable/redlaser")
ENT.DotMat = Material("effects/hypelaserdot")
ENT.LaserThickness = 4

ENT.Color = Color(255, 10, 10, 255)

DEFINE_BASECLASS(ENT.Base)

local util_TraceLine = util.TraceLine
local dlight_cvar = GetConVar("cl_tfa_fx_wonderweapon_dlights")
local nzombies = engine.ActiveGamemode() == "nzombies"
local pvp_bool = GetConVar("sbox_playershurtplayers")

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Activated")
	self:NetworkVar("Bool", 1, "Upgraded")
	self:NetworkVar("Float", 0, "AttractTime")
	self:NetworkVar("Angle", 0, "Roll")
end

function ENT:GetAttracting()
	return self:GetAttractTime() > CurTime()
end

function ENT:GetWarning()
	return (self:GetAttractTime() - 3.2) < CurTime()
end

function ENT:Draw()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		self:SetRenderAngles(Angle(0,phys:GetAngles()[2],0))
	end

	self:DrawModel()

	if !self:GetActivated() then return end

	if !self.jetpvsfx1 or !IsValid(self.jetpvsfx1) then
		self.jetpvsfx1 = CreateParticleSystem(self, "aw_distract_drone_jet", PATTACH_POINT_FOLLOW, 6)
	end
	if !self.jetpvsfx2 or !IsValid(self.jetpvsfx2) then
		self.jetpvsfx2 = CreateParticleSystem(self, "aw_distract_drone_jet", PATTACH_POINT_FOLLOW, 7)
	end
	if !self.jetpvsfx3 or !IsValid(self.jetpvsfx3) then
		self.jetpvsfx3 = CreateParticleSystem(self, "aw_distract_drone_jet", PATTACH_POINT_FOLLOW, 8)
	end
	if !self.jetpvsfx4 or !IsValid(self.jetpvsfx4) then
		self.jetpvsfx4 = CreateParticleSystem(self, "aw_distract_drone_jet", PATTACH_POINT_FOLLOW, 9)
	end

	if !self:GetAttracting() then return end

	if !self.lamp1 then
		local lamp1 = ProjectedTexture()
		self.lamp1 = lamp1 

		lamp1:SetTexture( "effects/flashlight/square" )
		lamp1:SetFarZ( 256 )
		lamp1:SetFOV( 16 )

		local attData = self:GetAttachment(2)
		lamp1:SetPos( attData.Pos )
		lamp1:SetAngles( attData.Ang )
		lamp1:SetColor(Color(255,15,15))
		lamp1:Update()
	end

	if !self.lamp2 then
		local lamp2 = ProjectedTexture()
		self.lamp2 = lamp2 

		lamp2:SetTexture( "effects/flashlight/square" )
		lamp2:SetFarZ( 256 )
		lamp2:SetFOV( 16 )

		local attData = self:GetAttachment(3)
		lamp2:SetPos( attData.Pos )
		lamp2:SetAngles( attData.Ang )
		lamp2:SetColor(Color(255,15,15))
		lamp2:Update()
	end

	if !self.lamp3 then
		local lamp3 = ProjectedTexture()
		self.lamp3 = lamp3 

		lamp3:SetTexture( "effects/flashlight/square" )
		lamp3:SetFarZ( 256 )
		lamp3:SetFOV( 16 )

		local attData = self:GetAttachment(4)
		lamp3:SetPos( attData.Pos )
		lamp3:SetAngles( attData.Ang )
		lamp3:SetColor(Color(255,15,15))
		lamp3:Update()
	end

	if !self.lamp4 then
		local lamp4 = ProjectedTexture()
		self.lamp4 = lamp4 

		lamp4:SetTexture( "effects/flashlight/square" )
		lamp4:SetFarZ( 256 )
		lamp4:SetFOV( 16 )

		local attData = self:GetAttachment(5)
		lamp4:SetPos( attData.Pos )
		lamp4:SetAngles( attData.Ang )
		lamp4:SetColor(Color(255,15,15))
		lamp4:Update()
	end

	if !self.lamp5 then
		local lamp5 = ProjectedTexture()
		self.lamp5 = lamp5 

		lamp5:SetTexture( "effects/flashlight001" )
		lamp5:SetFarZ( 256 )
		lamp5:SetFOV( 128 )

		local attData = self:GetAttachment(10)
		lamp5:SetPos( attData.Pos )
		lamp5:SetAngles( attData.Ang )
		lamp5:SetColor(Color(255,15,15))
		lamp5:Update()
	end

	if !self.attractfx or !IsValid(self.attractfx) then
		self.attractfx = CreateParticleSystem(self, "aw_distract_drone_attract", PATTACH_POINT_FOLLOW, 10)
	end

	if self:GetWarning() then
		if !self.alarmfx or !IsValid(self.alarmfx) then
			self.alarmfx = CreateParticleSystem(self, "aw_distract_drone_warning", PATTACH_POINT_FOLLOW, 10)
		end
	end
end

function ENT:DrawLasers()
	local attData1 = self:GetAttachment(2)
	local attData2 = self:GetAttachment(3)
	local attData3 = self:GetAttachment(4)
	local attData4 = self:GetAttachment(5)
	local attData5 = self:GetAttachment(10)

	local filterTab = table.Copy(player.GetAll())
	table.insert(filterTab, self)

	self.pcftime = self.pcftime + 1
	self.cuntas = self.cuntas - FrameTime()
	if self.cuntas < 0 then self.cuntas = 1 end

	if attData1 then
		local trace1 = util_TraceLine({
			start = attData1.Pos,
			endpos = attData1.Pos + attData1.Ang:Forward()*256,
			mask = MASK_SOLID,
			filter = filterTab,
		})

		if trace1.Hit and self.pcftime%6 == 0 and self.lastpcf[1] ~= CurTime() then
			self.lastpcf[1] = CurTime()
			ParticleEffect("aw_limbo_hit", trace1.HitPos, -trace1.Normal:Angle())
			//util.Decal("FadingScorch", trace1.HitPos - trace1.HitNormal, trace1.HitPos + trace1.HitNormal*2)
		end

		local fucker = math.Rand(0.8,1.2)

		render.SetMaterial(self.DotMat)
		render.DrawSprite(trace1.HitPos, 16*fucker, 16*fucker, ColorAlpha(self.GlowColor, math.Rand(180, 255)))

		render.SetMaterial(self.DotMat)
		render.DrawQuadEasy(trace1.StartPos, trace1.Normal, 8*fucker, 8*fucker, self.GlowColor, math.Rand(-180,180))

		//beam
		render.SetMaterial(self.Mat)
		render.DrawBeam(trace1.StartPos, trace1.HitPos, self.LaserThickness, self.cuntas, (1*trace1.Fraction)+self.cuntas, self.GlowColor)

		render.SetMaterial(self.Mat2)
		render.DrawBeam(trace1.StartPos, trace1.HitPos, self.LaserThickness, self.cuntas, (1*trace1.Fraction)+self.cuntas, self.GlowColor)
	end

	if attData2 then
		local trace2 = util_TraceLine({
			start = attData2.Pos,
			endpos = attData2.Pos + attData2.Ang:Forward()*256,
			mask = MASK_SOLID,
			filter = filterTab,
		})

		if trace2.Hit and self.pcftime%6 == 0 and self.lastpcf[2] ~= CurTime() then
			self.lastpcf[2] = CurTime()
			ParticleEffect("aw_limbo_hit", trace2.HitPos, -trace2.Normal:Angle())
			//util.Decal("FadingScorch", trace2.HitPos - trace2.HitNormal, trace2.HitPos + trace2.HitNormal*2)
		end

		local fucker = math.Rand(0.8,1.2)

		render.SetMaterial(self.DotMat)
		render.DrawSprite(trace2.HitPos, 16*fucker, 16*fucker, ColorAlpha(self.GlowColor, math.Rand(180, 255)))

		render.SetMaterial(self.DotMat)
		render.DrawQuadEasy(trace2.StartPos, trace2.Normal, 8*fucker, 8*fucker, self.GlowColor, math.Rand(-180,180))

		//beam
		render.SetMaterial(self.Mat)
		render.DrawBeam(trace2.StartPos, trace2.HitPos, self.LaserThickness, self.cuntas, (1*trace2.Fraction)+self.cuntas, self.GlowColor)

		render.SetMaterial(self.Mat2)
		render.DrawBeam(trace2.StartPos, trace2.HitPos, self.LaserThickness, self.cuntas, (1*trace2.Fraction)+self.cuntas, self.GlowColor)
	end

	if attData3 then
		local trace3 = util_TraceLine({
			start = attData3.Pos,
			endpos = attData3.Pos + attData3.Ang:Forward()*256,
			mask = MASK_SOLID,
			filter = filterTab,
		})

		if trace3.Hit and self.pcftime%6 == 0 and self.lastpcf[3] ~= CurTime() then
			self.lastpcf[3] = CurTime()
			ParticleEffect("aw_limbo_hit", trace3.HitPos, -trace3.Normal:Angle())
			//util.Decal("FadingScorch", trace3.HitPos - trace3.HitNormal, trace3.HitPos + trace3.HitNormal*2)
		end

		local fucker = math.Rand(0.8,1.2)

		render.SetMaterial(self.DotMat)
		render.DrawSprite(trace3.HitPos, 16*fucker, 16*fucker, ColorAlpha(self.GlowColor, math.Rand(180, 255)))

		render.SetMaterial(self.DotMat)
		render.DrawQuadEasy(trace3.StartPos, trace3.Normal, 8*fucker, 8*fucker, self.GlowColor, math.Rand(-180,180))

		//beam
		render.SetMaterial(self.Mat)
		render.DrawBeam(trace3.StartPos, trace3.HitPos, self.LaserThickness, self.cuntas, (1*trace3.Fraction)+self.cuntas, self.GlowColor)

		render.SetMaterial(self.Mat2)
		render.DrawBeam(trace3.StartPos, trace3.HitPos, self.LaserThickness, self.cuntas, (1*trace3.Fraction)+self.cuntas, self.GlowColor)
	end

	if attData4 then
		local trace4 = util_TraceLine({
			start = attData4.Pos,
			endpos = attData4.Pos + attData4.Ang:Forward()*256,
			mask = MASK_SOLID,
			filter = filterTab,
		})

		//impact
		if trace4.Hit and self.pcftime%6 == 0 and self.lastpcf[4] ~= CurTime() then
			self.lastpcf[4] = CurTime()
			ParticleEffect("aw_limbo_hit", trace4.HitPos, -trace4.Normal:Angle())
			//util.Decal("FadingScorch", trace4.HitPos - trace4.HitNormal, trace4.HitPos + trace4.HitNormal*2)
		end

		local fucker = math.Rand(0.8,1.2)

		render.SetMaterial(self.DotMat)
		render.DrawSprite(trace4.HitPos, 16*fucker, 16*fucker, ColorAlpha(self.GlowColor, math.Rand(180, 255)))

		render.SetMaterial(self.DotMat)
		render.DrawQuadEasy(trace4.StartPos, trace4.Normal, 8*fucker, 8*fucker, self.GlowColor, math.Rand(-180,180))

		//beam
		render.SetMaterial(self.Mat)
		render.DrawBeam(trace4.StartPos, trace4.HitPos, self.LaserThickness, self.cuntas, (1*trace4.Fraction)+self.cuntas, self.GlowColor)

		render.SetMaterial(self.Mat2)
		render.DrawBeam(trace4.StartPos, trace4.HitPos, self.LaserThickness, self.cuntas, (1*trace4.Fraction)+self.cuntas, self.GlowColor)
	end

	if attData5 then
		local trace5 = util_TraceLine({
			start = attData5.Pos,
			endpos = attData5.Pos + attData5.Ang:Forward()*256,
			mask = MASK_SOLID,
			filter = filterTab,
		})

		//impact
		if trace5.Hit and self.pcftime%6 == 0 and self.lastpcf[5] ~= CurTime() then
			self.lastpcf[5] = CurTime()
			ParticleEffect("aw_limbo_hit", trace5.HitPos, -trace5.Normal:Angle())
			//util.Decal("FadingScorch", trace5.HitPos - trace5.HitNormal, trace5.HitPos + trace5.HitNormal*2)
		end

		local fucker = math.Rand(0.8,1.2)

		render.SetMaterial(self.DotMat)
		render.DrawSprite(trace5.HitPos, 16*fucker, 16*fucker, ColorAlpha(self.GlowColor, math.Rand(180, 255)))

		render.SetMaterial(self.DotMat)
		render.DrawQuadEasy(trace5.StartPos, trace5.Normal, 8*fucker, 8*fucker, self.GlowColor, math.Rand(-180,180))

		//beam
		render.SetMaterial(self.Mat)
		render.DrawBeam(trace5.StartPos, trace5.HitPos, self.LaserThickness, self.cuntas, (1*trace5.Fraction)+self.cuntas, self.GlowColor)

		render.SetMaterial(self.Mat2)
		render.DrawBeam(trace5.StartPos, trace5.HitPos, self.LaserThickness, self.cuntas, (1*trace5.Fraction)+self.cuntas, self.GlowColor)
	end
end

function ENT:PhysicsCollide(data, phys)
	if self:GetActivated() then
		if self.TimeToFly and self.TimeToFly > CurTime() then
			phys:SetVelocity(vector_origin)
			phys:EnableMotion(false)
			phys:Sleep()

			self.TimeToFly = 0
		else
			phys:SetVelocity(vector_origin)
			phys:EnableMotion(false)
			phys:Wake()
		end
	else
		if data.Speed > 60 then
			sound.Play("sound/weapons/tfa_aw/grenade/grenade_bounce_default_0"..math.random(9)..".wav", data.HitPos, SNDLVL_NORM, math.random(97,103), 1)
		end

		local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
		local NewVelocity = phys:GetVelocity()
		NewVelocity:Normalize()

		LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
		local TargetVelocity = NewVelocity * LastSpeed * 0.4
		phys:SetVelocity( TargetVelocity )

		local ent = data.HitEntity

		if data.HitNormal:Dot(vector_up) < 0 and (!IsValid(ent) or ent:IsWorld() or data.Speed < 10) then
			local fx = EffectData()
			fx:SetOrigin( data.HitPos )
			fx:SetNormal( data.HitNormal )
			fx:SetScale( 1 )
			fx:SetMagnitude( 2 )

			util.Effect( "ElectricSpark", fx )

			self:ActivateCustom(phys)
		end
	end
end

function ENT:ActivateCustom(phys)
	phys:SetVelocityInstantaneous(vector_origin)
	phys:EnableMotion(false)
	phys:EnableGravity(false)
	phys:EnableDrag(false)
	phys:Sleep()

	self:SetActivated(true)

	self:SetTargetPriority(TARGET_PRIORITY_SPECIAL)
	UpdateAllZombieTargets(self)

	self:ResetSequence("idle")

	self:EmitSound("TFA_AW_DISTRACT.Deploy")

	ParticleEffectAttach("aw_distract_drone_start", PATTACH_POINT_FOLLOW, self, 10)
end

function ENT:Initialize(...)
	BaseClass.Initialize(self, ...)

	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	//self:PhysicsInitSphere(12, "metal_bouncy")
	self:SetRoll(self:GetAngles())
	self:SetAutomaticFrameAdvance(true)

	self:ResetSequence("thrown")

	self.killtime = CurTime() + self.Delay
	self.Damage = self.mydamage or self.Damage

	if CLIENT then
		self.pcftime = 0
		self.cuntas = 1
		self.lastpcf = {[1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0}

		local name = "aw_distract_lasers_hack"..self:EntIndex()
		hook.Add("PostDrawTranslucentRenderables", name, function(bDepth, bSkybox)
			if ( bSkybox ) then return end
			if not IsValid(self) then hook.Remove("PostDrawTranslucentRenderables", name) return end

			if self:GetActivated() and self:GetUpgraded() and !self:GetWarning() then
				self:DrawLasers()
			end
		end)

		return
	end

	timer.Simple(8, function()
		if IsValid(self) and not self:GetActivated() then
			self:ActivateCustom(self:GetPhysicsObject())
		end
	end)

	self:SetTrigger(true)

	SafeRemoveEntityDelayed(self, 30)
end

local flPulse = 1
function ENT:Think()
	if CLIENT then
		if self:GetActivated() and dlight_cvar:GetBool() and DynamicLight then
			local dlight = DynamicLight(self:EntIndex(), false)
			if (dlight) then
				dlight.pos = self:GetAttachment(1).Pos
				dlight.r = 255
				dlight.g = 25
				dlight.b = 25
				dlight.brightness = 1
				dlight.Decay = 4000
				dlight.Size = self:GetAttracting() and 256 or 128
				dlight.dietime = CurTime() + 0.5
			end
		end

		flPulse = math.Clamp((flPulse - (FrameTime()*3)), 0, 1)
		if self:GetAttracting() then
			if !self.nextquickpulse or self.nextquickpulse < CurTime() then
				self.nextquickpulse = CurTime() + 0.2
				flPulse = 1
			end
		end

		if self.lamp1 and ( IsValid( self.lamp1 ) ) then
			local attData = self:GetAttachment(2)
			self.lamp1:SetPos( attData.Pos )
			self.lamp1:SetAngles( attData.Ang )
			if self:GetActivated() and self:GetWarning() then
				self.lamp1:SetColor(color_white)
				self.lamp1:SetFOV(32*flPulse)
			end
			self.lamp1:Update()
		end

		if self.lamp2 and ( IsValid( self.lamp2 ) ) then
			local attData = self:GetAttachment(3)
			self.lamp2:SetPos( attData.Pos )
			self.lamp2:SetAngles( attData.Ang )
			if self:GetActivated() and self:GetWarning() then
				self.lamp2:SetColor(color_white)
				self.lamp2:SetFOV(32*flPulse)
			end
			self.lamp2:Update()
		end

		if self.lamp3 and ( IsValid( self.lamp3 ) ) then
			local attData = self:GetAttachment(4)
			self.lamp3:SetPos( attData.Pos )
			self.lamp3:SetAngles( attData.Ang )
			if self:GetActivated() and self:GetWarning() then
				self.lamp3:SetColor(color_white)
				self.lamp3:SetFOV(32*flPulse)
			end
			self.lamp3:Update()
		end

		if self.lamp4 and ( IsValid( self.lamp4 ) ) then
			local attData = self:GetAttachment(5)
			self.lamp4:SetPos( attData.Pos )
			self.lamp4:SetAngles( attData.Ang )
			if self:GetActivated() and self:GetWarning() then
				self.lamp4:SetColor(color_white)
				self.lamp4:SetFOV(32*flPulse)
			end
			self.lamp4:Update()
		end

		if self.lamp5 and ( IsValid( self.lamp5 ) ) then
			local attData = self:GetAttachment(10)
			self.lamp5:SetPos( attData.Pos )
			self.lamp5:SetAngles( attData.Ang )
			if self:GetActivated() and self:GetWarning() then
				self.lamp5:SetColor(color_white)
				self.lamp5:SetFOV(64*flPulse)
			end
			self.lamp5:Update()
		end
	end

	if SERVER then
		local phys = self:GetPhysicsObject()
		if not IsValid(phys) then
			self:Remove()
			return false
		end

		if !self.HasStarted then
			local vel = phys:GetVelocity()
			self:SetAngles(self:GetRoll())
			phys:SetVelocity(vel)
		end

		if self:GetActivated() then
			if self:GetUpgraded() and !self:GetWarning() then
				self:TraceForEnemies()
			end

			if self.HasStarted and self:GetAttractTime() < CurTime() then
				self:Explode()
				return false
			end

			if self:GetAttracting() then
				if !self.HasStarted then
					self.HasStarted = true
				end

				if !self:GetWarning() then
					if not phys:IsMotionEnabled() then
						phys:Wake()
						phys:EnableMotion(true)
					end

					phys:SetAngleVelocity(self:GetUp()*54)
				elseif phys:IsMotionEnabled() then
					phys:SetAngleVelocityInstantaneous(vector_origin)
					phys:EnableMotion(false)
					phys:Sleep()

					self:SetAngles(self:GetRoll())
				end
			end

			if self.TimeToFly then
				if self.TimeToFly > CurTime() then
					local ratio = math.Clamp((self.TimeToFly - CurTime()) / 0.4, 0, 1)

					phys:AddVelocity(vector_up*(22*ratio))
				elseif !self:GetAttracting() and !self.HasStarted then
					self:SetVelocity(vector_origin)
					phys:SetVelocityInstantaneous(vector_origin)
					phys:EnableGravity(false)
					phys:EnableDrag(false)
					phys:EnableMotion(false)
					phys:Sleep()

					self:SetAttractTime(CurTime() + 8.2)

					self:SetCollisionGroup(COLLISION_GROUP_WORLD)

					self:EmitSound("TFA_AW_DISTRACT.Alarm")
				end
			end

			if !self.TimeToFly then
				self:SetPos(self:GetPos() + vector_up*2)

				self.TimeToFly = CurTime() + 0.6

				phys:Wake()
				phys:EnableMotion(true)
				phys:EnableGravity(true)
				phys:EnableDrag(true)
			end
		end
	end

	self:NextThink(CurTime())
	return true
end

function ENT:IsAttractiveTarget( hitEntity )
	local playerEntity = self:GetOwner()

	if hitEntity:GetNoDraw() then
		return false
	end

	if hitEntity:GetClass() == self:GetClass() then
		return false
	end

	if hitEntity == playerEntity then
		return false
	end

	// owner is NPC and hit entity is ally
	if IsValid( playerEntity ) and hitEntity:IsNPC() and playerEntity:IsNPC() and hitEntity:Disposition( playerEntity ) == D_LI then
		return false
	end

	// owner is player and hit player is (potentially) an ally
	if IsValid( playerEntity ) and hitEntity:IsPlayer() and playerEntity:IsPlayer() and !hook.Run( "PlayerShouldTakeDamage", ent, playerEntity ) then
		return false
	end

	if nzombies and hitEntity:IsPlayer() then
		return false
	end

	if nzombies and hitEntity:GetOwner() == playerEntity then
		return false
	end

	if hitEntity:IsPlayer() and not pvp_bool:GetBool() then
		return false
	end

	return true
end

function ENT:TraceForEnemies()
	local attData1 = self:GetAttachment(2)
	local attData2 = self:GetAttachment(3)
	local attData3 = self:GetAttachment(4)
	local attData4 = self:GetAttachment(5)
	local attData5 = self:GetAttachment(10)

	local playerEntity = self:GetOwner()

	local trace1 = {}
	local trace2 = {}
	local trace3 = {}
	local trace4 = {}
	local trace5 = {}

	if attData1 then
		util_TraceLine( {
			start = attData1.Pos,
			endpos = attData1.Pos + attData1.Ang:Forward()*256,
			mask = MASK_SHOT,
			filter = function( hitEntity ) return self:IsAttractiveTarget( hitEntity ) end,
			output = trace1,
		} )

		local hitEntity = trace1.Entity

		if trace1.Hit and !trace1.HitSky then
			if IsValid( hitEntity ) and hitEntity:IsSolid() then
				local damage = DamageInfo()
				damage:SetDamage( self.Damage*0.2 )
				damage:SetAttacker( IsValid( playerEntity ) and playerEntity or game.GetWorld() )
				damage:SetInflictor( IsValid( self.Inflictor ) and self.Inflictor or self )
				damage:SetDamageType( DMG_DISSOLVE )
				damage:SetDamageForce( trace1.Normal*(hitEntity:Health() > 0 and 2000 or 200) )
				damage:SetDamagePosition( trace1.HitPos )
				damage:SetReportedPosition( trace1.StartPos )

				hitEntity:DispatchTraceAttack( damage, trace1, trace1.Normal )
			end
		end
	end

	if attData2 then
		util_TraceLine( {
			start = attData2.Pos,
			endpos = attData2.Pos + attData2.Ang:Forward()*256,
			mask = MASK_SHOT,
			filter = function( hitEntity ) return self:IsAttractiveTarget( hitEntity ) end,
			output = trace2,
		} )

		hitEntity = trace2.Entity

		if trace2.Hit and !trace2.HitSky then
			if IsValid( hitEntity ) and hitEntity:IsSolid() then
				local damage = DamageInfo()
				damage:SetDamage( self.Damage*0.2 )
				damage:SetAttacker( IsValid( playerEntity ) and playerEntity or game.GetWorld() )
				damage:SetInflictor( IsValid( self.Inflictor ) and self.Inflictor or self )
				damage:SetDamageType( DMG_DISSOLVE )
				damage:SetDamageForce( trace2.Normal*(hitEntity:Health() > 0 and 2000 or 200) )
				damage:SetDamagePosition( trace2.HitPos )
				damage:SetReportedPosition( trace2.StartPos )

				hitEntity:DispatchTraceAttack( damage, trace2, trace2.Normal )
			end
		end
	end

	if attData3 then
		util_TraceLine( {
			start = attData3.Pos,
			endpos = attData3.Pos + attData3.Ang:Forward()*256,
			mask = MASK_SHOT,
			filter = function( hitEntity ) return self:IsAttractiveTarget( hitEntity ) end,
			output = trace3,
		} )

		hitEntity = trace3.Entity

		if trace3.Hit and !trace3.HitSky then
			if IsValid( hitEntity ) and hitEntity:IsSolid() then
				local damage = DamageInfo()
				damage:SetDamage( self.Damage*0.2 )
				damage:SetAttacker( IsValid( playerEntity ) and playerEntity or game.GetWorld() )
				damage:SetInflictor( IsValid( self.Inflictor ) and self.Inflictor or self )
				damage:SetDamageType( DMG_DISSOLVE )
				damage:SetDamageForce( trace3.Normal*(hitEntity:Health() > 0 and 2000 or 200) )
				damage:SetDamagePosition( trace3.HitPos )
				damage:SetReportedPosition( trace3.StartPos )

				hitEntity:DispatchTraceAttack( damage, trace1, trace3.Normal )
			end
		end
	end

	if attData4 then
		util_TraceLine( {
			start = attData4.Pos,
			endpos = attData4.Pos + attData4.Ang:Forward()*256,
			mask = MASK_SHOT,
			filter = function( hitEntity ) return self:IsAttractiveTarget( hitEntity ) end,
			output = trace4,
		} )

		hitEntity = trace4.Entity

		if trace4.Hit and !trace4.HitSky then
			if IsValid( hitEntity ) and hitEntity:IsSolid() then
				local damage = DamageInfo()
				damage:SetDamage( self.Damage*0.2 )
				damage:SetAttacker( IsValid( playerEntity ) and playerEntity or game.GetWorld() )
				damage:SetInflictor( IsValid( self.Inflictor ) and self.Inflictor or self )
				damage:SetDamageType( DMG_DISSOLVE )
				damage:SetDamageForce( trace4.Normal*(hitEntity:Health() > 0 and 2000 or 200) )
				damage:SetDamagePosition( trace4.HitPos )
				damage:SetReportedPosition( trace4.StartPos )

				hitEntity:DispatchTraceAttack( damage, trace4, trace4.Normal )
			end
		end
	end

	if attData5 then
		util_TraceLine( {
			start = attData5.Pos,
			endpos = attData5.Pos + attData5.Ang:Forward()*256,
			mask = MASK_SHOT,
			filter = function( hitEntity ) return self:IsAttractiveTarget( hitEntity ) end,
			output = trace5,
		} )

		hitEntity = trace5.Entity

		if trace5.Hit and !trace5.HitSky then
			if IsValid( hitEntity ) and hitEntity:IsSolid() then
				local damage = DamageInfo()
				damage:SetDamage( self.Damage*0.2 )
				damage:SetAttacker( IsValid( playerEntity ) and playerEntity or game.GetWorld() )
				damage:SetInflictor( IsValid( self.Inflictor ) and self.Inflictor or self )
				damage:SetDamageType( DMG_DISSOLVE )
				damage:SetDamageForce( trace5.Normal*(hitEntity:Health() > 0 and 2000 or 200) )
				damage:SetDamagePosition( trace5.HitPos )
				damage:SetReportedPosition( trace5.StartPos )

				hitEntity:DispatchTraceAttack( damage, trace5, trace5.Normal )
			end
		end
	end
end

function ENT:Explode()
	self.Damage = self.mydamage or self.Damage

	local pos = self:GetPos()
	local ply = self:GetOwner()
	local tr = {
		start = pos,
		filter = {self, ply},
		mask = MASK_SHOT_HULL
	}

	for k, v in pairs(ents.FindInSphere(pos, self.Range)) do
		if not v:IsWorld() and v:IsSolid() and !v:IsPlayer() then
			if v == self then continue end
			if v == ply then continue end

			tr.endpos = v:WorldSpaceCenter()
			local tr1 = util.TraceLine(tr)
			if tr1.HitWorld then continue end

			if IsValid(ply) and v:IsNPC() and v:Disposition(ply) == D_LI then continue end

			self:InflictDamage(v, tr1.Entity == v and tr1.HitPos or tr.endpos, nil, tr1.Normal)
		end
	end

	self:DoExplosionEffect()
	util.ScreenShake(pos, 5, 255, 1, 120)

	self:Remove()
end

function ENT:InflictDamage(ent, hitpos, hitgroup, norm)
	local damage = DamageInfo()
	damage:SetDamage(self.Damage)
	damage:SetAttacker(IsValid(self:GetOwner()) and self:GetOwner() or self)
	damage:SetInflictor(IsValid(self.Inflictor) and self.Inflictor or self)
	damage:SetDamageForce(ent:GetUp()*math.random(4000,8000) + (norm and norm*math.random(8000,12000) or (ent:GetPos() - self:GetPos()):GetNormalized()*10000))
	damage:SetDamageType(nzombies and DMG_BLAST or bit.bor(DMG_BLAST, DMG_AIRBOAT))
	damage:SetDamagePosition(ent:WorldSpaceCenter())

	if hitpos then
		damage:SetDamagePosition(hitpos)
		local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
		if !headbone then headbone = ent:LookupBone("j_head") end
		if (headbone and ent:GetBonePosition(headbone):DistToSqr(hitpos) < 12^2) or (hitgroup and hitgroup == HITGROUP_HEAD) then
			damage:SetDamage(self.Damage*7)
			damage:SetDamagePosition(ent:GetBonePosition(headbone))
		end
	end

	if ent:IsNPC() then ent:SetSchedule(SCHED_ALERT_STAND) end
	ent:TakeDamageInfo(damage)
end

function ENT:DoExplosionEffect()
	local attData = self:GetAttachment(10)

	local fx = EffectData()
	fx:SetOrigin((attData and attData.Pos) and attData.Pos or self:GetPos())
	fx:SetNormal((attData and attData.Ang) and attData.Ang:Forward() or vector_up:GetNegated())

	util.Effect("HelicopterMegaBomb", fx)
	util.Effect("Explosion", fx)

	sound.Play("weapons/tfa_aw/grenade/wpn_frag_exp_deep_01.wav", self:GetPos(), SNDLVL_GUNFIRE, 100, 1)
	sound.Play("weapons/tfa_aw/grenade/wpn_frag_exp_imp_0"..math.random(4)..".wav", self:GetPos(), SNDLVL_120db, 100, 1)
	sound.Play("weapons/tfa_aw/grenade/wpn_frag_exp_low_0"..math.random(5)..".wav", self:GetPos(), SNDLVL_TALKING, 100, 1)
	sound.Play("weapons/tfa_aw/grenade/wpn_frag_exp_tail_0"..math.random(4)..".wav", self:GetPos(), SNDLVL_GUNFIRE, 100, 1)
end

function ENT:OnRemove()
	self:StopSound("TFA_AW_DISTRACT.Alarm")

	if SERVER then
		self:SetTargetPriority(TARGET_PRIORITY_NONE)
	end

	if self.lamp1 and IsValid(self.lamp1) then
		self.lamp1:Remove()
	end
	if self.lamp2 and IsValid(self.lamp2) then
		self.lamp2:Remove()
	end
	if self.lamp3 and IsValid(self.lamp3) then
		self.lamp3:Remove()
	end
	if self.lamp4 and IsValid(self.lamp4) then
		self.lamp4:Remove()
	end
	if self.lamp5 and IsValid(self.lamp5) then
		self.lamp5:Remove()
	end
end
