-- Main Tables
nzPerks = nzPerks or AddNZModule("Perks")
nzPerks.Data = nzPerks.Data or {}

-- Variables
nzPerks.Players = nzPerks.Players or {}
nzPerks.PlayerUpgrades = nzPerks.PlayerUpgrades or {}

nzPerks.NextNukedRound = 0

nzPerks.EPoPIcons = {
	[1] = Material("vgui/aat/t7_hud_cp_aat_blastfurnace.png", "smooth unlitgeneric"),
	[2] = Material("vgui/aat/t7_hud_cp_aat_deadwire.png", "smooth unlitgeneric"),
	[3] = Material("vgui/aat/t7_hud_cp_aat_fireworks.png", "smooth unlitgeneric"),
	[4] = Material("vgui/aat/t7_hud_cp_aat_thunderwall.png", "smooth unlitgeneric"),
	[5] = Material("vgui/aat/t7_hud_cp_aat_cryofreeze.png", "smooth unlitgeneric"),
	[6] = Material("vgui/aat/t7_hud_cp_aat_turned.png", "smooth unlitgeneric"),
	[7] = Material("vgui/aat/t7_hud_cp_aat_bhole.png", "smooth unlitgeneric"),
	[8] = Material("vgui/aat/t7_hud_cp_aat_wonder.png", "smooth unlitgeneric"),
}

nzPerks.VultureArray = nzPerks.VultureArray or {}

nzPerks.oldturnedlist = {
	["Odious Individual"] = true,
	["Laby after Taco Bell"] = true,
	["Fucker.lua"] = true,
	["Turned"] = true,
	["Shitass"] = true,
	["Miscellaneous Intent"] = true,
	["The Imposter"] = true,
	["Zobie"] = true,
	["Creeper, aww man"] = true,
	["Herbin"] = true,
	["Category Five"] = true,
	["TheRelaxingEnd"] = true,
	["Zet0r"] = true,
	["Dead By Daylight"] = true,
	["Cave Johnson"] = true,
	["Vinny Vincesauce"] = true,
	["Who's Who?"] = true,
	["MR ELECTRIC, KILL HIM!"] = true,
	["Jerma985"] = true,
	["Steve Jobs"] = true,
	["BRAAAINS..."] = true,
	["The False Shepherd"] = true,
	["Timer Failed!"] = true,
	["r_flushlod"] = true,
	["Doctor Robotnik"] = true,
	["Clown"] = true,
	["Left 4 Dead 2"] = true,
	["Squidward Tortellini"] = true,
	["Five Nights at FNAF"] = true,
	["Minecraft Steve"] = true,
	["Wowee Zowee"] = true,
	["Gorgeous Freeman"] = true,
	["fog rolling in"] = true,
	["Exotic Butters"] = true,
	["Brain Rot"] = true,
	["Team Fortress 2"] = true,
	["Roblox"] = true,
	["Cave1.ogg"] = true,
	["Fin Fin"] = true,
	["Jimmy Gibbs Jr."] = true,
	["Brain Blast"] = true,
	["Sheen"] = true
}

if SERVER then
	function nzPerks:UpdatePerkMachines()
		for k, v in pairs(ents.FindByClass("perk_machine")) do
			if v.Update then
				v:Update()
			end
		end
		for k, v in pairs(ents.FindByClass("wunderfizz_machine")) do
			if v.Update then
				v:Update()
			end
		end
	end

	function nzPerks:RebuildPaPCount()
		local machines = ents.FindByClass("perk_machine")

		nzPerks.PackAPunchCount = 0
		for _, e in pairs(machines) do
			if e.GetPerkID and e:GetPerkID() == "pap" then
				nzPerks.PackAPunchCount = nzPerks.PackAPunchCount + 1
			end
		end
	end

	if game.SinglePlayer() or (IsValid(Entity(1)) and Entity(1):IsListenServerHost()) then
		nzPerks:RebuildPaPCount()
	end
end

//class names for vulture vision entities
nzPerks.VultureClass = nzPerks.VultureClass or {}
function nzPerks:AddVultureClass(class)
	if class then
		nzPerks.VultureClass[class] = true
	end
end

nzPerks:AddVultureClass("nz_ammo_matic")
nzPerks:AddVultureClass("wunderfizz_machine")
nzPerks:AddVultureClass("wall_buys")
nzPerks:AddVultureClass("random_box")
nzPerks:AddVultureClass("perk_machine")
nzPerks:AddVultureClass("drop_powerup")
nzPerks:AddVultureClass("drop_widows")
nzPerks:AddVultureClass("drop_tombstone")
nzPerks:AddVultureClass("wunderfizz_windup")

//vulture mini powerup effects table
nzPerks.VultureDropsTable = nzPerks.VultureDropsTable or {}
function nzPerks:AddVultureDropType(id, data)
	if data then
		nzPerks.VultureDropsTable[id] = data
	else
		nzPerks.VultureDropsTable[id] = nil
	end
end

nzPerks:AddVultureDropType("points", {
	id = "points",
	model = Model("models/powerups/w_vulture_points.mdl"),
	blink = true,
	poof = true,
	timer = 30,
	chance = 3,
	effect = function(ply)
		ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3") 
		ply:EmitSound("nz_moo/powerups/vulture/vulture_money.mp3") 
		ply:GivePoints(math.random(10, 20) * (ply:HasUpgrade("vulture") and 20 or 10))

		return true
	end,
	draw = function(self)
		self:DrawModel()

		if !self.loopglow or !IsValid(self.loopglow) then
			local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
			local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
			local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			else
				self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			end
		end
	end,
	initialize = function(self)
		if CLIENT then
			local lamp = ProjectedTexture()
			self.lamp = lamp

			lamp:SetTexture( "effects/flashlight001" )
			lamp:SetFarZ(42)
			lamp:SetFOV(math.random(55,70))

			lamp:SetPos(self:GetPos() + vector_up*24)
			lamp:SetAngles(Angle(90,0,0))

			local cvec = nzMapping.Settings.powerupcol["mini"][1]
			lamp:SetColor(Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255))
			lamp:Update()
		end
		self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 
	end,
	think = function(self)
		if CLIENT then
			if ( IsValid( self.lamp ) ) then
				self.lamp:SetFarZ(math.random(40,44))
				self.lamp:SetPos( self:GetPos() + vector_up*24 )
				self.lamp:Update()
			end
		end
	end,
	onremove = function(self)
		if IsValid(self.lamp) then
			self.lamp:Remove()
		end
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end,
})

nzPerks:AddVultureDropType("ammo", {
	id = "ammo",
	model = Model("models/powerups/w_vulture_ammo.mdl"),
	blink = true,
	poof = true,
	timer = 30,
	chance = 2,
	effect = function(ply)
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) then
			local max = wep.Primary.MaxAmmo or nzWeps:CalculateMaxAmmo(wep:GetClass(), wep:HasNZModifier("pap"))
			local give = math.Round(max/math.random(10, 20))
			local ammo = wep:GetPrimaryAmmoType()
			local cur = ply:GetAmmoCount(ammo)

			if (cur + give) > max then
				give = max - cur
			end

			if give <= 0 then
				return false
			end

			ply:GiveAmmo(give, ammo)
			ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3")

			return true
		end
	end,
	draw = function(self)
		self:DrawModel()

		if !self.loopglow or !IsValid(self.loopglow) then
			local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
			local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
			local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			else
				self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			end
		end
	end,
	initialize = function(self)
		if CLIENT then
			local lamp = ProjectedTexture()
			self.lamp = lamp

			lamp:SetTexture( "effects/flashlight001" )
			lamp:SetFarZ(42)
			lamp:SetFOV(math.random(55,70))

			lamp:SetPos(self:GetPos() + vector_up*24)
			lamp:SetAngles(Angle(90,0,0))
			
			local cvec = nzMapping.Settings.powerupcol["mini"][1]
			lamp:SetColor(Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255))
			lamp:Update()
		end
		self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 
	end,
	think = function(self)
		if CLIENT then
			if ( IsValid( self.lamp ) ) then
				self.lamp:SetFarZ(math.random(40,44))
				self.lamp:SetPos( self:GetPos() + vector_up*24 )
				self.lamp:Update()
			end
		end
	end,
	onremove = function(self)
		if IsValid(self.lamp) then
			self.lamp:Remove()
		end
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end,
})

nzPerks:AddVultureDropType("gas",{
	id = "gas",
	model = Model("models/dav0r/hoverball.mdl"),
	blink = false,
	poof = false,
	timer = 12,
	chance = 1,
	effect = function(ply)
		ply:VulturesStink(0.5)

		return false
	end,
	draw = function(self)
		if !self.loopglow or !IsValid(self.loopglow) then
			self.loopglow = CreateParticleSystem(self, "nz_perks_vulture_stink", PATTACH_ABSORIGIN_FOLLOW)
		end
	end,
	initialize = function(self)
		self:DrawShadow(false)
		self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 

		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() - Vector(0,0,64),
			filter = self,
			mask = MASK_SOLID_BRUSHONLY,
		})

		if tr.Hit then
			self:SetPos(tr.HitPos + vector_up*32)
		end

		if CLIENT then
			local lamp = ProjectedTexture()
			self.lamp = lamp

			lamp:SetTexture( "effects/flashlight001" )
			lamp:SetFarZ(240)
			lamp:SetFOV(60)

			lamp:SetPos(self:GetPos() + vector_up*64)
			lamp:SetAngles(Angle(90,0,0))

			lamp:SetColor(Color(60,255,0,255))
			lamp:Update()
		end
	end,
	think = function(self)
		if CLIENT then
			if ( IsValid( self.lamp ) ) then
				self.lamp:SetPos( self:GetPos() + vector_up*64 )
				self.lamp:Update()
			end
		end
	end,
	onremove = function(self)
		if IsValid(self.lamp) then
			self.lamp:Remove()
		end
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end,
})

nzPerks:AddVultureDropType("armor",{
	id = "armor",
	model = Model("models/items/battery.mdl"),
	blink = true,
	poof = true,
	timer = 30,
	chance = 2,
	effect = function(ply)
		local plyarm = ply:Armor()
		ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3") 
		ply:SetArmor(math.Clamp(plyarm + (math.random(1, 5) * (ply:HasUpgrade("vulture") and 20 or 10)), 0, 200))

		return true
	end,
	draw = function(self)
		self:DrawModel()

		if !self.loopglow or !IsValid(self.loopglow) then
			local colorvec1 = nzMapping.Settings.powerupcol["mini"][1]
			local colorvec2 = nzMapping.Settings.powerupcol["mini"][2]
			local colorvec3 = nzMapping.Settings.powerupcol["mini"][3]

			if nzMapping.Settings.powerupstyle then
				local style = nzPowerUps:GetStyle(nzMapping.Settings.powerupstyle)
				self.loopglow = CreateParticleSystem(self, style.loop, PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			else
				self.loopglow = CreateParticleSystem(self, "nz_powerup_classic_loop", PATTACH_POINT_FOLLOW, 1)
				self.loopglow:SetControlPoint(2, colorvec1)
				self.loopglow:SetControlPoint(3, colorvec2)
				self.loopglow:SetControlPoint(4, colorvec3)
				self.loopglow:SetControlPoint(1, Vector(0.65,0.65,0.65))
			end
		end
	end,
	initialize = function(self)
		if CLIENT then
			local lamp = ProjectedTexture()
			self.lamp = lamp

			lamp:SetTexture( "effects/flashlight001" )
			lamp:SetFarZ(42)
			lamp:SetFOV(math.random(55,70))

			lamp:SetPos(self:GetPos() + vector_up*24)
			lamp:SetAngles(Angle(90,0,0))

			local cvec = nzMapping.Settings.powerupcol["mini"][1]
			lamp:SetColor(Color(math.Round(cvec[1]*255),math.Round(cvec[2]*255),math.Round(cvec[3]*255),255))
			lamp:Update()
		end
		self:EmitSound("nz_moo/powerups/vulture/vulture_drop.mp3") 
	end,
	think = function(self)
		if CLIENT then
			if ( IsValid( self.lamp ) ) then
				self.lamp:SetFarZ(math.random(40,44))
				self.lamp:SetPos( self:GetPos() + vector_up*24 )
				self.lamp:Update()
			end
		end
	end,
	onremove = function(self)
		if IsValid(self.lamp) then
			self.lamp:Remove()
		end
		if self.loopglow and IsValid(self.loopglow) then
			self.loopglow:StopEmission()
		end
	end,
})