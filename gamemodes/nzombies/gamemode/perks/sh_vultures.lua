nzPerks.VultureArray = nzPerks.VultureArray or {}

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
nzPerks:AddVultureClass("nz_gummachine")

//vulture drop data
nzPerks.VultureData = nzPerks.VultureData or {}
function nzPerks:AddVultureDrop(id, data)
	if data then
		nzPerks.VultureData[id] = data
	else
		nzPerks.VultureData[id] = nil
	end
end

function nzPerks:GetVultureDrop(id)
	return nzPerks.VultureData[id]
end

function nzPerks:GetVultureList()
	local tbl = {}

	for k, v in pairs(nzPerks.VultureData) do
		tbl[k] = (v.name or string.NiceName(k))
	end

	return tbl
end

/*nzPerks:AddVultureDrop("unique_id",{
	name = "Name", //for powerup map settings
	desc = "short description", //for powerup map settings, not needed
	model = Model("path/to/model.mdl"),
	blink = bool, //blink before despawning
	glow = bool, //do powerup loop effect
	poof = bool, //do powerup poof effect
	lamp = bool, //powerup will 'glow' using a projected texture (no limit unlike dlights)
	nodraw = bool, //disable drawing the model
	touch = bool, //call effect function on every Touch() rather than only on StartTouch()
	timer = float, //duration
	chance = int, //chance, like random box chance
	dropsound = "path/to/sound.wav", //for overwriting the powerup drop sound, delete if not using
	natural = true, //automatically enables drop type in the power up map setting menu on initial config creation
	condition = function(position), //same as powerup condition function, delete if not needed
		return true
	end,
	effect = function(ply)
		return true //REQUIRED! return bool for if player can interact with drop or not
	end,
	draw = function(self) //custom draw function to overwrite
	end,
	initialize = function(self) //runs when powerup is created
	end,
	think = function(self) //runs every tick
	end,
	onremove = function(self) //runs when powerup is removed
	end,
})*/

nzPerks:AddVultureDrop("points", {
	name = "Points",
	desc = "Gives the player 100 to 200 points (doubled with modifier)",
	model = Model("models/powerups/w_vulture_points.mdl"),
	blink = true,
	glow = true,
	poof = true,
	lamp = true,
	nodraw = false,
	timer = 30,
	chance = 3,
	natural = true,
	effect = function(ply)
		ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3") 
		ply:EmitSound("nz_moo/powerups/vulture/vulture_money.mp3") 
		ply:GivePoints(math.random(10, 20) * (ply:HasUpgrade("vulture") and 20 or 10))

		return true
	end,
})

nzPerks:AddVultureDrop("ammo", {
	name = "Ammo",
	desc = "Refills between 5% and 10% ammo for players held weapon",
	model = Model("models/powerups/w_vulture_ammo.mdl"),
	blink = true,
	glow = true,
	poof = true,
	lamp = true,
	nodraw = false,
	timer = 30,
	chance = 2,
	natural = true,
	effect = function(ply)
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and wep.Primary then
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
})

nzPerks:AddVultureDrop("gas",{
	name = "Stink",
	desc = "Players stood in stink are ignored by zombies",
	model = Model("models/dav0r/hoverball.mdl"),
	blink = false,
	glow = false,
	poof = false,
	lamp = false,
	nodraw = true,
	touch = true,
	timer = 12,
	chance = 1,
	natural = true,
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

nzPerks:AddVultureDrop("armor",{
	name = "Armor",
	desc = "Gives the player 10 to 50 armor (doubled with modifier)",
	model = Model("models/items/battery.mdl"),
	blink = true,
	glow = true,
	poof = true,
	lamp = true,
	nodraw = false,
	timer = 30,
	chance = 2,
	natural = true,
	effect = function(ply)
		local plyarm = ply:Armor()
		ply:EmitSound("nz_moo/powerups/vulture/vulture_pickup.mp3") 
		ply:SetArmor(math.Clamp(plyarm + (math.random(1, 5) * (ply:HasUpgrade("vulture") and 20 or 10)), 0, ply:GetMaxArmor()))

		return true
	end,
})