AddCSLuaFile()

ENT.Type = "anim"
 
ENT.PrintName		= "wunderfizz_windup"
ENT.Author			= "Zet0r"
ENT.Contact			= "youtube.com/Zet0r"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.VortexLoopSound = Sound("nz_moo/perks/wonderfizz/vortex_loop.wav")

local teddymat = "models/perk_bottle/c_perk_bottle_teddy"

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Winding" )
end

function ENT:RandomizeSkin()
	local skin
	if nzMapping.Settings.wunderfizzperks then
		skin = nzPerks:Get(table.Random(table.GetKeys(nzMapping.Settings.wunderfizzperklist))).material
	else
		skin = nzPerks:Get(table.Random(table.GetKeys(nzPerks:GetList()))).material
	end

	if skin then
		self:SetSkin(skin)
	end
end

function ENT:Initialize()
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_OBB)
	self:DrawShadow(false)

	if (nzMapping.Settings.bottle == "tfa_perk_can") then
		self:SetModel("models/nz/perks/wm_t9_can.mdl")
	elseif (nzMapping.Settings.bottle == "tfa_bo1_bottle") then
		self:SetModel("models/nz/perks/wm_t5_perk_bottle.mdl")
	elseif (nzMapping.Settings.bottle == "tfa_bo2_bottle") then
		self:SetModel("models/nz/perks/wm_t6_perk_bottle.mdl")
	elseif (nzMapping.Settings.bottle == "tfa_perk_gum") then
		self:SetModel("models/nz/perks/w_wpn_t7_zmb_bubblegum_view_lod4.mdl")
	elseif (nzMapping.Settings.bottle == "tfa_bo3_nana") then
		self:SetModel("models/nz/perks/wm_perk_nana.mdl")
	elseif (nzMapping.Settings.bottle == "tfa_perk_candy") then
		self:SetModel("models/nz/perks/wm_iw8_candy.mdl")
	elseif (nzMapping.Settings.bottle == "tfa_perk_goblet") then
		self:SetModel("models/nz/perks/wm_s4_goblet.mdl")
	else
		self:SetModel("models/nzr/2022/perks/w_perk_bottle.mdl")
	end
	--self:SetModel("models/nzr/2022/perks/w_perk_bottle.mdl")
	self:RandomizeSkin()

	local machine = self.WMachine
	if SERVER then
		self:SetWinding(true)
		self.SoundPlayer = CreateSound(self, self.VortexLoopSound)
    	if (self.SoundPlayer) then
        	self.SoundPlayer:Play()
    	end

		timer.Simple(5, function()
			self:SetWinding(false)
			timer.Simple(5, function()
				if IsValid(self) and IsValid(self.WMachine) then
					self.WMachine:SetSharing(true)
				end
			end)

			self:EmitSound("nz_moo/perks/wonderfizz/elec/hit/random_perk_imp_0"..math.random(0, 2)..".mp3", 90, math.random(97, 103))

			if (self.SoundPlayer) then
        		self.SoundPlayer:FadeOut(0.8)
    		end
			if self.Perk == "teddy" then
				self:SetSkin(30)
				machine:SetIsTeddy(true)
				machine:GetUser():GivePoints(machine:GetPrice())
				timer.Simple(5, function() 
					if IsValid(self) and IsValid(machine) then
						self:Remove()
						machine:MoveLocation()
					end
				end)
			else
				self:SetSkin(nzPerks:Get(self.Perk).material)
			end
			machine:SetPerkID(self.Perk)
		end)

		timer.Simple(15, function() if IsValid(self) then self:Remove() end end)
	end
end

function ENT:WindUp()
	self:RandomizeSkin()
end

function ENT:TeddyFlyUp()
end

function ENT:Think()
	if SERVER then
		if self:GetWinding() then
			self:WindUp()
		end
	end

	self:NextThink(CurTime() + 0.0666)
	return true
end

function ENT:OnRemove()
	if IsValid(self.WMachine) then
		self.WMachine:SetBeingUsed(false)
		self.WMachine.Bottle = nil
	end
end

function ENT:Draw()
	self:DrawModel()
	if !self.Stopped then
		self:SetRenderAngles(self:GetNetworkAngles())
		self.LightningAura = nil -- Kill the aura effect
		self.Stopped = true
	end
end
