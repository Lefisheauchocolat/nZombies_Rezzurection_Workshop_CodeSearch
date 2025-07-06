--[[Example
nzBuilds:NewBuildable("unique_id", {
	name = "Build Name", //name, does not have to be unique, but is still recommended
	model = "path/to/model/model.mdl", //model of final item, used for the hologram
	weapon = "weapon_class", //reward weapon class (if applicable)
	boxweapon = bool, //add reward weapon to box list on pick up, TABLE BECOMES SINGLE USE
	pos = Vector(0,0,0), //height of model from table
	ang = Angle(0,0,0), //rotation of model from table
	hudicon = Material("path/to/icon.png", "unlitgeneric smooth"), //not required
	parts = {
		[1] = {
			id = "Part1 Name", 
			mdl = "path/to/model/model.mdl", 
			icon = Material("path/to/icon.png", "unlitgeneric smooth") //not required, but recommended
		},
		[2] = {
			id = "Part2 Name", 
			mdl = "path/to/model/model.mdl", 
			icon = Material("path/to/icon.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Part3 Name", 
			mdl = "path/to/model/model.mdl", 
			icon = Material("path/to/icon.png", "unlitgeneric smooth")
		},
	},
	remove = bool, //remove table after use? used for buildable PAP
	notable = bool, //dont draw table? used for buildable PAP
	init = function(self) end, //called once when table is spawned/placed, DELETE IF NOT USING
	reset = function(self) end, //called once on game start and game end, DELETE IF NOT USING
	completed = function(self, ply) end, //called once when buildable is completed, DELETE IF NOT USING
	use = function(self, ply) end, //custom use function, DELETE IF NOT USING
	text = function(self) end, //custom text, DELETE IF NOT USING
})]]--

nzBuilds:NewBuildable("mw2_riotshield", {
	name = "Riot Shield",
	model = "models/weapons/tfa_mw2009/riotshield/w_riotshield.mdl",
	weapon = "tfa_mw2_riotshield",
	hudicon = Material("vgui/icon/iw4_menu_riotshield.png", "unlitgeneric smooth"),
	pos = Vector(0,0,72),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Shield Face", 
			mdl = "models/weapons/tfa_mw2009/riotshield/build_riotshield_face.mdl",
			icon = Material("vgui/icon/iw4_hud_pickup_riotshield.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Shield Handle", 
			mdl = "models/weapons/tfa_mw2009/riotshield/build_riotshield_parts.mdl",
			icon = Material("vgui/icon/inventory_wirerepair.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_tranzitshield", {
	name = "Tranzit Shield",
	model = "models/weapons/tfa_bo2/tranzitshield/w_tranzitshield.mdl",
	weapon = "tfa_bo2_tranzitshield",
	pos = Vector(0,0,70),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Dolly", 
			mdl = "models/weapons/tfa_bo2/tranzitshield/build_tranzitshield_dolly.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_dolly.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Car Door", 
			mdl = "models/weapons/tfa_bo2/tranzitshield/build_tranzitshield_door.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_cardoortif.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_prisonshield", {
	name = "Prison Shield",
	model = "models/weapons/tfa_bo2/prisonshield/w_prisonshield.mdl",
	weapon = "tfa_bo2_prisonshield",
	pos = Vector(0,0,70),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Dolly", 
			mdl = "models/weapons/tfa_bo2/prisonshield/build_prisonshield_dolly.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_dolly.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Cell Door", 
			mdl = "models/weapons/tfa_bo2/prisonshield/build_prisonshield_door.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_zshield_door.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Shackles", 
			mdl = "models/weapons/tfa_bo2/prisonshield/build_prisonshield_shackles.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_zshield_clamp.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_tombshield", {
	name = "Tomb Shield",
	model = "models/weapons/tfa_bo2/tombshield/w_tombshield.mdl",
	weapon = "tfa_bo2_tombshield",
	pos = Vector(0,0,70),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Window", 
			mdl = "models/weapons/tfa_bo2/tombshield/build_tombshield_top.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_zshield_tomb_vizor.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Door", 
			mdl = "models/weapons/tfa_bo2/tombshield/build_tombshield_door.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_zshield_tomb_body.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Bracket", 
			mdl = "models/weapons/tfa_bo2/tombshield/build_tombshield_bracket.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_zshield_tomb_feet.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_rocketshield", {
	name = "Rocket Shield",
	model = "models/weapons/tfa_bo3/rocketshield/w_rocketshield.mdl",
	weapon = "tfa_bo3_rocketshield",
	pos = Vector(0,0,72),
	ang = Angle(0,-90,0),
	parts = {
		[1] = {
			id = "Crest", 
			mdl = "models/weapons/tfa_bo3/rocketshield/build_rocketshield_eagle.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc_shield_a.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Tanks", 
			mdl = "models/weapons/tfa_bo3/rocketshield/build_rocketshield_tanks.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc_shield_c.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Window", 
			mdl = "models/weapons/tfa_bo3/rocketshield/build_rocketshield_window.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc_shield_b.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_dragonshield", {
	name = "Dragon Shield",
	model = "models/weapons/tfa_bo3/dragonshield/w_dragonshield.mdl",
	weapon = "tfa_bo3_dragonshield",
	pos = Vector(0,0,72),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Head", 
			mdl = "models/weapons/tfa_bo3/dragonshield/build_dragonshield_head.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc3_ds_piece1.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Pelvis", 
			mdl = "models/weapons/tfa_bo3/dragonshield/build_dragonshield_pelvis.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc3_ds_piece2.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Window", 
			mdl = "models/weapons/tfa_bo3/dragonshield/build_dragonshield_window.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc3_ds_piece3.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_tombshield", {
	name = "Origins Shield",
	model = "models/weapons/tfa_bo3/tombshield/w_tombshield.mdl",
	weapon = "tfa_bo3_tombshield",
	pos = Vector(0,0,72),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Window", 
			mdl = "models/weapons/tfa_bo3/tombshield/build_tombshield_window.mdl",
			icon = Material("vgui/icon/uie_t7_zm_icon_hd_shieldpart_1.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Door", 
			mdl = "models/weapons/tfa_bo3/tombshield/build_tombshield_door.mdl",
			icon = Material("vgui/icon/uie_t7_zm_icon_hd_shieldpart_2.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Bracket", 
			mdl = "models/weapons/tfa_bo3/tombshield/build_tombshield_frame.mdl",
			icon = Material("vgui/icon/uie_t7_zm_icon_hd_shieldpart_3.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_vineshield", {
	name = "Vine Shield",
	model = "models/weapons/tfa_bo3/vineshield/w_vineshield.mdl",
	weapon = "tfa_bo3_vineshield",
	pos = Vector(0,0,72),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Window", 
			mdl = "models/weapons/tfa_bo3/vineshield/build_vineshield_window.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc2_shield_window.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Door", 
			mdl = "models/weapons/tfa_bo3/vineshield/build_vineshield_door.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc2_shield_door.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Bracket", 
			mdl = "models/weapons/tfa_bo3/vineshield/build_vineshield_frame.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc2_shield_frame.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_drone", {
	name = "Maxis Drone",
	model = "models/weapons/tfa_bo2/drone/w_drone.mdl",
	weapon = "tfa_bo2_drone",
	pos = Vector(0,0,62),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/hud_quadrotor_tomb.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Drone Body", 
			mdl = "models/weapons/tfa_bo2/drone/build_drone_body.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_zquad_body.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Maxis' Brain", 
			mdl = "models/weapons/tfa_bo2/drone/build_drone_brain.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_zquad_brain.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Drone Engine", 
			mdl = "models/weapons/tfa_bo2/drone/build_drone_engine.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_zquad_engine.png", "unlitgeneric smooth")
		},
	},
	use = function(self, ply)
		if CLIENT then return end

		local function TakeMaxis()
			ply:EmitSound(self.BuildPickupSound or "NZ.Buildable.PickUp")
			ply:Give(self.WeaponClass)

			self:SetNW2Float("MaxisCooldown", 0)
			self:SetNW2Bool("MaxisDeployed", true)
			if IsValid(self.CraftedModel) then
				self.CraftedModel:GoGhost()
			end
		end

		local function PlaceMaxis()
			local wep = ply:GetWeapon(self.WeaponClass)
			if IsValid(wep) then
				local timeleft = math.max(100 - wep:Clip1(), 0) - 1
				self:SetNW2Float("MaxisCooldown", CurTime() + timeleft)
			end
			hook.Call("RespawnMaxisDrone")

			ply:StripWeapon(self.WeaponClass)
			ply.NextUse = CurTime() + 0.45
		end

		if self:GetNW2Bool("MaxisDeployed", false) and not ply:HasWeapon(self.WeaponClass) then
			self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
		return end

		if self:GetNW2Float("MaxisCooldown", 0) > CurTime() then
			self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
		return end

		local price = self:GetPrice()
		if price > 0 then
			if not ply:CanAfford(price) then self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny") return end

			if not ply:HasWeapon(self.WeaponClass) then
				ply:Buy(price, self, function() TakeMaxis() return true end)
			else
				PlaceMaxis()
			end
		else
			if not ply:HasWeapon(self.WeaponClass) then
				TakeMaxis()
			else
				PlaceMaxis()
			end
		end
	end,
	text = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if self:GetNW2Float("MaxisCooldown", 0) > CurTime() then
			return "Maxis Drone is cooling down - "..math.Round(self:GetNW2Float("MaxisCooldown", 0) - CurTime()).."s"
		end

		if self:GetNW2Bool("MaxisDeployed", false) then //maxis has been picked up
			if ply:HasWeapon(self.WeaponClass) then //you are holding maxis
				return "Press "..string.upper(input.LookupBinding("+USE")).." - Place "..self.BuildName
			else //you arent holding maxis
				local maxis = ents.FindByClass("bo2_trap_drone")[1]
				if IsValid(maxis) then //maxis is deployed somewhere
					if maxis.nearestperk then
						return "Maxis Drone is currently deployed closest to "..maxis.nearestperk
					else
						return "Maxis Drone is currently deployed somewhere"
					end
				else //you arent holding maxis and hes not deployed
					for _, ply in ipairs(player.GetAll()) do
						if ply:HasWeapon(self.WeaponClass) then //someone else is carrying him
							return ply:Nick().." is currently carrying the Maxis Drone"
						end
					end

					return "Maxis is fucking dead"
				end
			end
		end

		local price = ""
		if self:GetPrice() > 0 then
			price = " [Cost: "..self:GetPrice().."]"
		end

		if not ply:HasWeapon(self.WeaponClass) then
			return "Press "..string.upper(input.LookupBinding("+USE")).." - Pickup "..self.BuildName..price
		else //this should never happen but its here ~Justin Case
			return "Press "..string.upper(input.LookupBinding("+USE")).." - Place "..self.BuildName
		end
	end,
})

nzBuilds:NewBuildable("bo2_etrap", {
	name = "Electric Trap",
	model = "models/weapons/tfa_bo2/etrap/w_etrap.mdl",
	weapon = "tfa_bo2_etrap",
	pos = Vector(0,0,45),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/zm_etrap_icon.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Wooden Base", 
			mdl = "models/weapons/tfa_bo2/etrap/build_etrap_base.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_coil.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Car Battery", 
			mdl = "models/weapons/tfa_bo2/etrap/build_etrap_battery.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_battery.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Cathode Ray Tube", 
			mdl = "models/weapons/tfa_bo2/etrap/build_etrap_tvtube.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_tvtube.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_etrap_noturbine", {
	name = "Electric Trap (No Turbine)",
	model = "models/weapons/tfa_bo2/etrap/w_etrap.mdl",
	weapon = "tfa_bo2_etrap_noturbine",
	pos = Vector(0,0,45),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/zm_etrap_icon.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Wooden Base", 
			mdl = "models/weapons/tfa_bo2/etrap/build_etrap_base.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_coil.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Car Battery", 
			mdl = "models/weapons/tfa_bo2/etrap/build_etrap_battery.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_battery.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Cathode Ray Tube", 
			mdl = "models/weapons/tfa_bo2/etrap/build_etrap_tvtube.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_tvtube.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_flinger", {
	name = "Tramplesteam",
	model = "models/weapons/tfa_bo2/flinger/w_flinger.mdl",
	weapon = "tfa_bo2_flinger",
	pos = Vector(0,0,62),
	ang = Angle(55,0,0),
	hudicon = Material("vgui/icon/zom_hud_trample_steam_complete.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Bellows", 
			mdl = "models/weapons/tfa_bo2/flinger/build_flinger_bellows.mdl",
			icon = Material("vgui/icon/zom_hud_trample_steam_bellow.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Compressor", 
			mdl = "models/weapons/tfa_bo2/flinger/build_flinger_compressor.mdl",
			icon = Material("vgui/icon/zom_hud_trample_steam_compressor.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Metal Screen", 
			mdl = "models/weapons/tfa_bo2/flinger/build_flinger_door.mdl",
			icon = Material("vgui/icon/zom_hud_trample_steam_screen.png", "unlitgeneric smooth")
		},
		[4] = {
			id = "Flag", 
			mdl = "models/weapons/tfa_bo2/flinger/build_flinger_flag.mdl",
			icon = Material("vgui/icon/zom_hud_trample_steam_whistle.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_headchopper", {
	name = "Head Chopper",
	model = "models/weapons/tfa_bo2/headchopper/w_headchopper.mdl",
	weapon = "tfa_bo2_headchopper",
	pos = Vector(0,0,45),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/zom_hud_icon_buildable_chopper.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Blade", 
			mdl = "models/weapons/tfa_bo2/headchopper/build_headchopper_blade.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_chop_a.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Crank", 
			mdl = "models/weapons/tfa_bo2/headchopper/build_headchopper_crank.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_chop_b.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Hinge", 
			mdl = "models/weapons/tfa_bo2/headchopper/build_headchopper_hinge.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_chop_c.png", "unlitgeneric smooth")
		},
		[4] = {
			id = "Mount", 
			mdl = "models/weapons/tfa_bo2/headchopper/build_headchopper_mount.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_chop_d.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_raketrap", {
	name = "Rake Trap",
	model = "models/weapons/tfa_bo2/raketrap/w_raketrap.mdl",
	weapon = "tfa_bo2_raketrap",
	pos = Vector(32,0,45),
	ang = Angle(0,90,0),
	hudicon = Material("vgui/icon/hud_icon_rake_trap.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Axe", 
			mdl = "models/weapons/tfa_bo2/raketrap/build_raketrap_axe.mdl",
			icon = Material("vgui/icon/hud_icon_axe.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Rake", 
			mdl = "models/weapons/tfa_bo2/raketrap/build_raketrap_rake.mdl",
			icon = Material("vgui/icon/hud_icon_rake.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Rope", 
			mdl = "models/weapons/tfa_bo2/raketrap/build_raketrap_rope.mdl",
			icon = Material("vgui/icon/hud_icon_rope.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_subwoofer", {
	name = "Subsurface Resonator",
	model = "models/weapons/tfa_bo2/subwoofer/w_subwoofer.mdl",
	weapon = "tfa_bo2_subwoofer",
	pos = Vector(0,0,45),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/zom_hud_icon_buildable_woof_speaker.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Motor", 
			mdl = "models/weapons/tfa_bo2/subwoofer/build_subwoofer_motor.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_woof_motor.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Mount", 
			mdl = "models/weapons/tfa_bo2/subwoofer/build_subwoofer_mount.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_woof_frame.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Speaker", 
			mdl = "models/weapons/tfa_bo2/subwoofer/build_subwoofer_speaker.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_woof_speaker.png", "unlitgeneric smooth")
		},
		[4] = {
			id = "Table", 
			mdl = "models/weapons/tfa_bo2/subwoofer/build_subwoofer_table.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_woof_chains.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_subwoofer_noturbine", {
	name = "Subsurface Resonator (No Turbine)",
	model = "models/weapons/tfa_bo2/subwoofer/w_subwoofer.mdl",
	weapon = "tfa_bo2_subwoofer_noturbine",
	pos = Vector(0,0,45),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/zom_hud_icon_buildable_woof_speaker.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Motor", 
			mdl = "models/weapons/tfa_bo2/subwoofer/build_subwoofer_motor.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_woof_motor.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Mount", 
			mdl = "models/weapons/tfa_bo2/subwoofer/build_subwoofer_mount.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_woof_frame.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Speaker", 
			mdl = "models/weapons/tfa_bo2/subwoofer/build_subwoofer_speaker.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_woof_speaker.png", "unlitgeneric smooth")
		},
		[4] = {
			id = "Table", 
			mdl = "models/weapons/tfa_bo2/subwoofer/build_subwoofer_table.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_woof_chains.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_turbine", {
	name = "Turbine",
	model = "models/weapons/tfa_bo2/turbine/w_turbine.mdl",
	weapon = "tfa_bo2_turbine",
	pos = Vector(0,0,45),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/zm_turbine_icon.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Fan", 
			mdl = "models/weapons/tfa_bo2/turbine/build_turbine_fan.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_fan.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Mannequin", 
			mdl = "models/weapons/tfa_bo2/turbine/build_turbine_mannqeuin.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_mannequin.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Rudder", 
			mdl = "models/weapons/tfa_bo2/turbine/build_turbine_rudder.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_rudder.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_turret", {
	name = "Lawnmower Turret",
	model = "models/weapons/tfa_bo2/turret/w_turret.mdl",
	weapon = "tfa_bo2_turret",
	pos = Vector(0,0,45),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/zm_turret_icon.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Ammo Bag", 
			mdl = "models/weapons/tfa_bo2/turret/build_turret_ammo.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_ammobox.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Lawn Mower", 
			mdl = "models/weapons/tfa_bo2/turret/build_turret_mower.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_lawnmower.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "RPD", 
			mdl = "models/weapons/tfa_bo2/turret/build_turret_rpd.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_turrethead.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_jetgun", {
	name = "Thrustodyne Aeronautics Model 23",
	model = "models/weapons/tfa_bo2/jetgun/w_jetgun.mdl",
	weapon = "tfa_bo2_jetgun",
	boxweapon = true,
	pos = Vector(9,0,65),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "Jet Engine", 
			mdl = "models/weapons/tfa_bo2/jetgun/build_jetgun_engine.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_jg_body.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Gauges", 
			mdl = "models/weapons/tfa_bo2/jetgun/build_jetgun_guages.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_jg_gauges.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Handles", 
			mdl = "models/weapons/tfa_bo2/jetgun/build_jetgun_handles.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_jg_handle.png", "unlitgeneric smooth")
		},
		[4] = {
			id = "Wires", 
			mdl = "models/weapons/tfa_bo2/jetgun/build_jetgun_wires.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_jg_wires.png", "unlitgeneric smooth")
		},
	},
	text = function(self)
		return "Awww Yeah! Press "..string.upper(input.LookupBinding("+USE")).." to take Jet Gun!"
	end,
})

nzBuilds:NewBuildable("bo2_sliquifier", {
	name = "Sliquifier",
	model = "models/weapons/tfa_bo2/sliquifier/w_sliquifier.mdl",
	weapon = "tfa_bo3_sliquifier",
	boxweapon = true,
	pos = Vector(0,0,57),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "Rice Cooker", 
			mdl = "models/weapons/tfa_bo2/sliquifier/build_sliquifier_cooker.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_slip_cooker.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Fire Extinguisher", 
			mdl = "models/weapons/tfa_bo2/sliquifier/build_sliquifier_extinguisher.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_slip_ext.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Mannequin Foot", 
			mdl = "models/weapons/tfa_bo2/sliquifier/build_sliquifier_foot.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_slip_foot.png", "unlitgeneric smooth")
		},
		[4] = {
			id = "Throttle", 
			mdl = "models/weapons/tfa_bo2/sliquifier/build_sliquifier_throttle.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_slip_handle.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_pap", {
	name = "Pack a' Punch",
	model = "models/nzr/2022/machines/pap/vending_pap.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Pack a' Punch Battery", 
			mdl = "models/weapons/tfa_bo2/pap/build_pap_battery.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_battery.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Pack a' Punch Body", 
			mdl = "models/weapons/tfa_bo2/pap/build_pap_body.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_papbody.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Pack a' Punch Table", 
			mdl = "models/weapons/tfa_bo2/pap/build_pap_table.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_item_chairleg.png", "unlitgeneric smooth")
		},
	},
	remove = true,
	notable = true,
	init = function(self)
		local perkdata = nzPerks:Get("pap")
		local paptype = nzPerks:GetPAPType(nzMapping.Settings.PAPtype)
		local machines = {
			["og"] = perkdata.model,
			["bocw"] = perkdata.model_bocw,
			["nz_tomb"] = perkdata.model_origins,
			["nz_tomb_red"] = perkdata.model_origins_red,
			["ww2"] = perkdata.model_ww2,
			["bo2"] = perkdata.model_bo2,
			["waw"] = perkdata.model_waw,
			["spooky"] = perkdata.model_spooky,
		}

		if machines[paptype] then
			self:SetModel(machines[paptype])
			if self.CraftedModel and IsValid(self.CraftedModel) then
				self.CraftedModel:SetModel(machines[paptype])
			end
		end
	end,
	completed = function(self, ply)
		local perk = ents.Create('perk_machine')
		perk:SetPos(self:GetPos())
		perk:SetAngles(self:GetAngles())
		perk:SetPerkID('pap')
		perk.FakePap = true
		perk:Spawn()
		perk:Update()

		if nzElec:IsOn() then
			perk:TurnOn()
		end

		local index = perk:EntIndex()
		hook.Add("OnRoundEnd", "nz.fakepap"..index, function()
			if nzRound:InState(ROUND_CREATE) or nzRound:InState(ROUND_GO) then
				for k, v in pairs(ents.FindByClass("perk_machine")) do
					if v:GetPerkID() == "pap" and v.FakePap then
						v:Remove()
						hook.Remove("OnRoundEnd", "nz.fakepap"..index)
						break
					end
				end
			end
		end)

		self:RemoveTable()
	end,
	text = function(self)
		return "Press "..string.upper(input.LookupBinding("+USE")).." - Activate Pack a' Punch"
	end,
})

nzBuilds:NewBuildable("bo3_dg4", {
	name = "Ragnarok DG-4s",
	model = "models/weapons/tfa_bo3/dg4/w_dg4.mdl",
	model2 = "models/weapons/tfa_bo3/dg4/w_dg4.mdl",
	weapon = "tfa_bo3_dg4",
	pos = Vector(0,0,70),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "DG-4 Body", 
			mdl = "models/weapons/tfa_bo3/dg4/build_dg4_body.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc_talon_spikes_body.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "DG-4 Guard", 
			mdl = "models/weapons/tfa_bo3/dg4/build_dg4_guards.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc_talon_spikes_guards.png", "unlitgeneric smooth")
		},
		[3] = {
			id = " DG-4 Handle", 
			mdl = "models/weapons/tfa_bo3/dg4/build_dg4_handle.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc_talon_spikes_handle.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_idgun", {
	name = "Apothicon Servant",
	model = "models/weapons/tfa_bo3/idgun/w_idgun.mdl",
	weapon = "tfa_bo3_idgun",
	boxweapon = true,
	pos = Vector(12,0,52),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "Margwa Heart", 
			mdl = "models/weapons/tfa_bo3/idgun/build_idgun_heart.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_heart.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Margwa Tentacle", 
			mdl = "models/weapons/tfa_bo3/idgun/build_idgun_tentacle.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_tentacle.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Xeno-Matter", 
			mdl = "models/weapons/tfa_bo3/idgun/build_idgun_xenomatter.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_xenomatter.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_mirg2000", {
	name = "Kusanagi-no-Tsurugi",
	model = "models/weapons/tfa_bo3/mirg2000/w_mirg2000.mdl",
	weapon = "tfa_bo3_mirg2000",
	boxweapon = true,
	pos = Vector(8,0,47),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "Toxic Plant", 
			mdl = "models/weapons/tfa_bo3/mirg2000/build_mirg2000_plant.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc2_wonderweapon_piece3.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Spider Venom", 
			mdl = "models/weapons/tfa_bo3/mirg2000/build_mirg2000_venom.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc2_wonderweapon_piece2.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Vial", 
			mdl = "models/weapons/tfa_bo3/mirg2000/build_mirg2000_vial.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_dlc2_wonderweapon_piece1.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_wunderwaffe", {
	name = "Wunderwaffe DG-2",
	model = "models/weapons/tfa_bo3/wunderwaffe/w_wunderwaffe.mdl",
	weapon = "tfa_bo3_wunderwaffe",
	boxweapon = true,
	pos = Vector(-14,0,52),
	ang = Angle(0,270,0),
	parts = {
		[1] = {
			id = "Tesla Bulbs", 
			mdl = "models/weapons/tfa_bo3/wunderwaffe/build_wunderwaffe_bulbs.mdl",
			icon = Material("vgui/icon/zom_hud_icon_buildable_vactube.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Wunderwaffe Barrel", 
			mdl = "models/weapons/tfa_bo3/wunderwaffe/build_wunderwaffe_front.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_case.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Wunderwaffe Power Box", 
			mdl = "models/weapons/tfa_bo3/wunderwaffe/build_wunderwaffe_powerbox.mdl",
			icon = Material("vgui/icon/zom_hud_icon_sq_powerbox.png", "unlitgeneric smooth"),
		},
	},
	completed = function(self, ply)
		self:EmitSound("TFA_BO3_WAFFE.ImpactWater")
	end,
})

nzBuilds:NewBuildable("bo3_gkzmk3", {
	name = "GKZ-45 Mk3",
	model = "models/weapons/tfa_bo3/mk3/w_mk3.mdl",
	model2 = "models/weapons/tfa_bo3/gkzmk3/w_gkzmk3.mdl",
	weapon = "tfa_bo3_gkzmk3",
	boxweapon = true,
	pos = Vector(10,0,50),
	ang = Angle(0,90,0),
	//hudicon = Material("vgui/icon/zom_hud_icon_zapgun.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "GKZ-45", 
			mdl = "models/weapons/tfa_bo3/gkzmk3/w_gkzmk3.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_gkzmk3_left.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Raygun Mk3", 
			mdl = "models/weapons/tfa_bo3/mk3/w_mk3.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_gkzmk3_right.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_wavegun", {
	name = "Zap Guns",
	model = "models/weapons/tfa_bo3/zapgun/w_wavegun.mdl",
	weapon = "tfa_bo3_zapgun",
	boxweapon = true,
	pos = Vector(10,0,50),
	ang = Angle(0,90,0),
	hudicon = Material("vgui/icon/zom_hud_icon_zapgun.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Left Zap Gun", 
			mdl = "models/weapons/tfa_bo3/zapgun/w_zapgun_left.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_mwave_left.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Right Zap Gun", 
			mdl = "models/weapons/tfa_bo3/zapgun/w_zapgun.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_mwave_right.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_scavenger", {
	name = "Scavenger",
	model = "models/weapons/tfa_bo3/scavenger/w_scavenger.mdl",
	weapon = "tfa_bo3_scavenger",
	boxweapon = true,
	pos = Vector(0,0,52),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "Scavenger Barrel", 
			mdl = "models/weapons/tfa_bo3/scavenger/build_scavenger_barrel.mdl",
			icon = Material("vgui/icon/eu_hud_scav_barrel.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Scavenger Body", 
			mdl = "models/weapons/tfa_bo3/scavenger/build_scavenger_body.mdl",
			icon = Material("vgui/icon/eu_hud_scav_body.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Scavenger Stock", 
			mdl = "models/weapons/tfa_bo3/scavenger/build_scavenger_stock.mdl",
			icon = Material("vgui/icon/eu_hud_scav_stock.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo3_shrinkray", {
	name = "31-79 JGb215",
	model = "models/weapons/tfa_bo3/shrinkray/w_shrinkray.mdl",
	weapon = "tfa_bo3_shrinkray",
	boxweapon = true,
	pos = Vector(5,0,48),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "Shrinkray Barrel", 
			mdl = "models/weapons/tfa_bo3/shrinkray/build_shrinkray_base.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_mori2_shrinkray_base.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Naga Artifact", 
			mdl = "models/weapons/tfa_bo3/shrinkray/build_shrinkray_dragon.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_mori2_shrinkray_dragon.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Shrinkray Stock", 
			mdl = "models/weapons/tfa_bo3/shrinkray/build_shrinkray_stock.mdl",
			icon = Material("vgui/icon/uie_t7_icon_inventory_mori2_shrinkray_stock.png", "unlitgeneric smooth")
		},
	},
	completed = function(self, ply)
		self:EmitSound("TFA_BO3_JGB.FluxUpg")
	end,
})

nzBuilds:NewBuildable("bo1_icelazer", {
	name = "Icelazer",
	model = "models/weapons/tfa_bo1/icelazer/w_icelazer.mdl",
	weapon = "tfa_bo1_icelazer",
	boxweapon = true,
	pos = Vector(8,0,47),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "Icelazer Barrel", 
			mdl = "models/weapons/tfa_bo1/icelazer/build_icelazer_barrel.mdl",
			icon = Material("vgui/icon/hud_icelazer_barrel.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Cryo Mag", 
			mdl = "models/weapons/tfa_bo1/icelazer/build_icelazer_mag.mdl",
			icon = Material("vgui/icon/hud_icelazer_mag.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Icelazer Receiver", 
			mdl = "models/weapons/tfa_bo1/icelazer/build_icelazer_receiver.mdl",
			icon = Material("vgui/icon/hud_icelazer_receiver.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("ghosts_nx1", {
	name = "NX-1 Distruptor",
	model = "models/weapons/tfa_ghosts/nx1/w_nx1.mdl",
	weapon = "tfa_ghosts_nx1",
	boxweapon = true,
	pos = Vector(-10,0,50),
	ang = Angle(0,90,0),
	parts = {
		[1] = {
			id = "NX-1 Frame", 
			mdl = "models/weapons/tfa_ghosts/nx1/build_nx1_body.mdl"
		},
		[2] = {
			id = "NX-1 Foregrip", 
			mdl = "models/weapons/tfa_ghosts/nx1/build_nx1_grip.mdl"
		},
		[3] = {
			id = "Electron Collider Magazine", 
			mdl = "models/weapons/tfa_ghosts/nx1/build_nx1_mag.mdl"
		},
	},
})

nzBuilds:NewBuildable("bo4_acidgat", {
	name = "Acidgat Upgrade Kit (BO4)",
	model = "models/zmb/bo2/alcatraz/zm_al_packasplat.mdl",
	weapon = "tfa_bo4_acidgat",
	pos = Vector(0,0,44),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Engine (Acidgat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_engine.mdl",
			icon = Material("vgui/icon/t8_hud_packasplat_engine.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Suitcase (Acidgat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_suitcase.mdl",
			icon = Material("vgui/icon/t8_hud_packasplat_suitcase.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Acid", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_iv.mdl",
			icon = Material("vgui/icon/t8_hud_packasplat_acid.png", "unlitgeneric smooth")
		},
	},
	use = function(self, ply)
		if CLIENT then return end

		local function GiveAcidgat()
			self:SetNW2Bool("SplatReady", false)
			self:SetNW2Int("SplatUser", 0)

			local wep2 = ply:Give(self.WeaponClass)
			if self.FakeBlundergatPap then
				self.FakeBlundergatPap = nil

				wep2.NZPaPME = true
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(ply) or not IsValid(wep2) then return end
					if wep2:HasNZModifier("pap") then return end
					wep2:ApplyNZModifier("pap")
				end)
			end
			if IsValid(self.FakeBlundergat) then
				self.FakeBlundergat:Remove()
			end
		end

		local function PlaceBlundergat()
			local ghost = self.CraftedModel
			if not IsValid(ghost) then return end
			local gun = ply:GetWeapon("tfa_bo4_blundergat")
			if not IsValid(gun) then return end

			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), 90)

			local prop = ents.Create("nz_script_prop")
			prop:SetParent(ghost)
			prop:SetModel("models/weapons/tfa_bo4/blundergat/w_blundergat.mdl")
			prop:SetPos(ghost:GetPos() + ghost:GetUp()*2 + ghost:GetRight()*21 + ghost:GetForward()*2)
			prop:SetAngles(ang)

			prop:Spawn()

			prop:SetSolid(SOLID_NONE)
			prop:SetCollisionGroup(COLLISION_GROUP_NONE)
			prop:SetMoveType(MOVETYPE_NONE)

			ghost:EmitSound("zmb/alcatraz/acid_upgrade.wav", SNDLVL_NORM, 100, 1, CHAN_STATIC)
			ghost:ResetSequence("start")

			timer.Simple(ghost:SequenceDuration("start"), function()
				if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
				ghost:ResetSequence("loop")

				timer.Simple(3.2, function()
					if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
					prop:SetModel("models/weapons/tfa_bo4/acidgat/w_acidgat.mdl")
					ghost:ResetSequence("end")
					ParticleEffectAttach("nzr_build_acidgat", PATTACH_POINT_FOLLOW, ghost, 1)

					timer.Simple(ghost:SequenceDuration("end") - 0.25, function()
						if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
						self:SetNW2Bool("SplatReady", true)

						timer.Simple(30, function()
							if not IsValid(self) then return end
							self:SetNW2Int("SplatUser", 0)

							if not IsValid(prop) then return end
							ParticleEffect("nzr_building_poof", prop:WorldSpaceCenter(), angle_zero)
							prop:EmitSound("NZ.BO2.DigSite.Part")
						end)
					end)
				end)
			end)

			self.FakeBlundergat = prop
			self:SetNW2Int("SplatUser", ply:EntIndex())
			self.FakeBlundergatPap = gun.Ispackapunched

			ply:EquipPreviousWeapon()
			timer.Simple(engine.TickInterval(), function()
				ply:StripWeapon("tfa_bo4_blundergat")
			end)
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)

		if not splat_ready then
			if not IsValid(wep) or wep:GetClass() ~= "tfa_bo4_blundergat" then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		else
			local index = self:GetNW2Int("SplatUser", 0)
			if index > 0 and ply:EntIndex() ~= index then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		end

		local price = self:GetPrice()
		if price > 0 then
			if not ply:CanAfford(price) then self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny") return end

			if splat_ready then
				GiveAcidgat()
			else
				ply:Buy(price, self, function() PlaceBlundergat() return true end)
			end
		else
			if splat_ready then
				GiveAcidgat()
			else
				PlaceBlundergat()
			end
		end
	end,
	text = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)
		local index = self:GetNW2Int("SplatUser", 0)
		local price = ""
		if self:GetPrice() > 0 then
			price = " [Cost: "..self:GetPrice().."]"
		end

		if splat_ready then
			if index > 0 then
				if ply:EntIndex() == index then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
				else
					return ""
				end
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
			end
		else
			if index > 0 then
				return ""
			end
		end

		if wep:GetClass() == "tfa_bo4_blundergat" then
			if wep.Ispackapunched then
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert The Sweeper into Viltrolic Withering"..price
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert Blundergat into Acidgat"..price
			end
		end

		return "Blundergat Required"
	end,
})

nzBuilds:NewBuildable("bo4_magmagat", {
	name = "Magmagat Upgrade Kit",
	model = "models/zmb/bo2/alcatraz/zm_al_packasplat_fire.mdl",
	weapon = "tfa_bo4_magmagat",
	pos = Vector(0,0,44),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Engine (Magmagat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_engine.mdl",
			icon = Material("vgui/icon/t8_hud_packasplat_engine.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Suitcase (Magmagat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_suitcase.mdl",
			icon = Material("vgui/icon/t8_hud_packasplat_suitcase.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Magma", 
			mdl = "models/weapons/tfa_bo4/magmagat/magma_rock.mdl",
			icon = Material("vgui/icon/t8_hud_packasplat_lava.png", "unlitgeneric smooth")
		},
	},
	use = function(self, ply)
		if CLIENT then return end

		local function GiveAcidgat()
			self:SetNW2Bool("SplatReady", false)
			self:SetNW2Int("SplatUser", 0)

			local wep2 = ply:Give(self.WeaponClass)
			if self.FakeBlundergatPap then
				self.FakeBlundergatPap = nil

				wep2.NZPaPME = true
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(ply) or not IsValid(wep2) then return end
					if wep2:HasNZModifier("pap") then return end
					wep2:ApplyNZModifier("pap")
				end)
			end
			if IsValid(self.FakeBlundergat) then
				self.FakeBlundergat:Remove()
			end
		end

		local function PlaceBlundergat()
			local ghost = self.CraftedModel
			if not IsValid(ghost) then return end
			local gun = ply:GetWeapon("tfa_bo4_blundergat")
			if not IsValid(gun) then return end

			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), 90)

			local prop = ents.Create("nz_script_prop")
			prop:SetParent(ghost)
			prop:SetModel("models/weapons/tfa_bo4/blundergat/w_blundergat.mdl")
			prop:SetPos(ghost:GetPos() + ghost:GetUp()*2 + ghost:GetRight()*21 + ghost:GetForward()*2)
			prop:SetAngles(ang)

			prop:Spawn()

			prop:SetSolid(SOLID_NONE)
			prop:SetCollisionGroup(COLLISION_GROUP_NONE)
			prop:SetMoveType(MOVETYPE_NONE)

			ghost:EmitSound("zmb/alcatraz/acid_upgrade.wav", SNDLVL_NORM, 100, 1, CHAN_STATIC)
			ghost:ResetSequence("start")

			timer.Simple(ghost:SequenceDuration("start"), function()
				if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
				ghost:ResetSequence("loop")

				timer.Simple(3.2, function()
					if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
					prop:SetModel("models/weapons/tfa_bo4/magmagat/w_magmagat.mdl")
					ghost:ResetSequence("end")
					ParticleEffectAttach("nzr_build_magmagat", PATTACH_POINT_FOLLOW, ghost, 1)

					timer.Simple(ghost:SequenceDuration("end") - 0.25, function()
						if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
						self:SetNW2Bool("SplatReady", true)

						timer.Simple(30, function()
							if not IsValid(self) then return end
							self:SetNW2Int("SplatUser", 0)

							if not IsValid(prop) then return end
							ParticleEffect("nzr_building_poof", prop:WorldSpaceCenter(), angle_zero)
							prop:EmitSound("NZ.BO2.DigSite.Part")
						end)
					end)
				end)
			end)

			self.FakeBlundergat = prop
			self:SetNW2Int("SplatUser", ply:EntIndex())
			self.FakeBlundergatPap = gun.Ispackapunched

			ply:EquipPreviousWeapon()
			timer.Simple(engine.TickInterval(), function()
				ply:StripWeapon("tfa_bo4_blundergat")
			end)
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)

		if not splat_ready then
			if not IsValid(wep) or wep:GetClass() ~= "tfa_bo4_blundergat" then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		else
			local index = self:GetNW2Int("SplatUser", 0)
			if index > 0 and ply:EntIndex() ~= index then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		end

		local price = self:GetPrice()
		if price > 0 then
			if not ply:CanAfford(price) then self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny") return end

			if splat_ready then
				GiveAcidgat()
			else
				ply:Buy(price, self, function() PlaceBlundergat() return true end)
			end
		else
			if splat_ready then
				GiveAcidgat()
			else
				PlaceBlundergat()
			end
		end
	end,
	text = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)
		local index = self:GetNW2Int("SplatUser", 0)
		local price = ""
		if self:GetPrice() > 0 then
			price = " [Cost: "..self:GetPrice().."]"
		end

		if splat_ready then
			if index > 0 then
				if ply:EntIndex() == index then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
				else
					return ""
				end
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
			end
		else
			if index > 0 then
				return ""
			end
		end

		if wep:GetClass() == "tfa_bo4_blundergat" then
			if wep.Ispackapunched then
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert The Sweeper into Magnus Operandi"..price
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert Blundergat into Magmagat"..price
			end
		end

		return "Blundergat Required"
	end,
})

nzBuilds:NewBuildable("bo3_hiddenmusic", {
	name = "Music Easter Egg",
	model = "models/zmb/bo3/zod/zm_zod_hidden_songs_mic_build.mdl",
	pos = Vector(0,0,0),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Microphone Head", 
			mdl = "models/zmb/bo3/zod/zm_zod_hidden_songs_mic.mdl",
			//icon = Material("vgui/icon/zm_zod_hidden_songs_mic.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Microphone Cable", 
			mdl = "models/zmb/bo3/zod/zm_zod_hidden_songs_mic_cable.mdl",
			//icon = Material("vgui/icon/zm_zod_hidden_songs_mic_cable.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Microphone Stand", 
			mdl = "models/zmb/bo3/zod/zm_zod_hidden_songs_mic_stand.mdl",
			//icon = Material("vgui/icon/zm_zod_hidden_songs_mic_stand.png", "unlitgeneric smooth")
		},
	},
	notable = true,
	completed = function(self, ply)
		hook.Add("OnRoundEnd", "nz.cleanbuildmusic"..self:EntIndex(), function()
			if not (nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO )) then return end

			for _, ply in ipairs(player.GetAll()) do
				ply:SetNW2Float("eeplaytime", 0)
			end

			for k, v in pairs(ents.FindByClass("nz_buildtable")) do
				if v.hasplayedsong then
					v.hasplayedsong = nil
					hook.Remove("OnRoundEnd", "nz.cleanbuildmusic"..v:EntIndex())
					break
				end
			end
		end)
	end,
	use = function(self, ply)
		if CLIENT then return end

		local sp = game.SinglePlayer()
		local ct_ = sp and SysTime() or CurTime() //systime isnt effected by pausing in solo

		if ply.nextsonguse and ply.nextsonguse > CurTime() then return end
		if self:GetNW2Float("eeplaytime", 0) > ct_ then self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny") return end

		local snd = nzSounds:GetSound("Music")
		if not snd or not isstring(snd) then return end

		if nzSounds.PlayFile then
			local time = nzSounds.SoundDuration and nzSounds:SoundDuration("sound/"..snd) or SoundDuration(snd)
			if time > 3600 then
				time = SoundDuration(snd)
			end

			if not self.hasplayedsong and !sp then
				nzSounds:PlayFile(snd)

				self.hasplayedsong = true
				if time > 0 then
					self:SetNW2Float("eeplaytime", ct_ + time)
				end

				PrintMessage(HUD_PRINTTALK, "Assume all Easter Egg songs are copyrighted!")
			else
				nzSounds:PlayFile(snd, ply)

				ply.nextsonguse = CurTime() + 10
				if time > 0 then
					ply:SetNW2Float("eeplaytime", ct_ + time)
				end
			end
		else
			local time = SoundDuration(snd) //only supports .wav files and windows os
			local msg1 = "LocalPlayer():StopSound('"..snd.."')"
			local msg2 = "surface.PlaySound('"..snd.."')"

			if not self.hasplayedsong and !sp then
				for k, v in ipairs(player.GetAll()) do
					v:SendLua(msg1)
					v:SendLua(msg2)
				end

				self.hasplayedsong = true
				if time > 0 then
					self:SetNW2Float("eeplaytime", ct_ + time)
				end

				PrintMessage(HUD_PRINTTALK, "Assume all Easter Egg songs are copyrighted!")
			else
				ply:SendLua(msg1)
				ply:SendLua(msg2)

				ply.nextsonguse = CurTime() + 10
				if time > 0 then
					ply:SetNW2Float("eeplaytime", ct_ + time)
				end
			end
		end
	end,
	text = function(self)
		local ply = LocalPlayer()
		local ct_ = game.SinglePlayer() and SysTime() or CurTime()

		local time = self:GetNW2Float("eeplaytime", 0)
		if ply:GetNW2Float("eeplaytime", 0) > 0 then
			time = ply:GetNW2Float("eeplaytime", 0)
		end

		if time > ct_ then
			local timeleft = math.Round(time - ct_)
			local format = timeleft > 600 and "%02i:%02i" or "%i:%02i" //00:00 for > 10min, 0:00 otherwise
			return "["..string.FormattedTime(timeleft, format).."]"
		else
			return "Press "..string.upper(input.LookupBinding("+USE")).." - activate music"
		end
	end,
})

nzBuilds:NewBuildable("ghosts_telstrap", {
	name = "Tesla Trap",
	model = "models/weapons/tfa_ghosts/teslatrap/w_teslatrap.mdl",
	weapon = "tfa_ghosts_teslatrap",
	pos = Vector(0,0,45),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/director_trap.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Tesla-Trap Base", 
			mdl = "models/weapons/tfa_ghosts/teslatrap/build_teslatrap_base.mdl",
			icon = Material("vgui/icon/hud_icon_teslatrap_base.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Tesla-Trap Batteries", 
			mdl = "models/weapons/tfa_ghosts/teslatrap/build_teslatrap_battery.mdl",
			icon = Material("vgui/icon/hud_icon_teslatrap_battery.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Tesla-Trap Coils", 
			mdl = "models/weapons/tfa_ghosts/teslatrap/build_teslatrap_coils.mdl",
			icon = Material("vgui/icon/hud_icon_teslatrap_coils.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("ugx_axe", {
	name = "Axe",
	model = "models/weapons/tfa_waw/ugxaxe/build_seelow_axe.mdl",
	weapon = "tfa_waw_ugxaxe",
	pos = Vector(0,0,44),
	ang = Angle(0,0,0),
	hudicon = Material("vgui/icon/ugx_axe_icon.png", "unlitgeneric smooth"),
	parts = {
		[1] = {
			id = "Axe Head",
			mdl = "models/weapons/tfa_waw/ugxaxe/build_seelow_axe_head.mdl",
			icon = Material("vgui/icon/hud_icon_axe_head.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Axe Handle",
			mdl = "models/weapons/tfa_waw/ugxaxe/build_seelow_axe_handle.mdl",
			icon = Material("vgui/icon/hud_icon_axe_handle.png", "unlitgeneric smooth")
		},
	},
})

nzBuilds:NewBuildable("bo2_acidgat", {
	name = "Acidgat Upgrade Kit (BO2)",
	model = "models/zmb/bo2/alcatraz/zm_al_packasplat.mdl",
	weapon = "tfa_bo2_acidgat",
	pos = Vector(0,0,44),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Engine (Acidgat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_engine.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_fuse.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Suitcase (Acidgat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_suitcase.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_case.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Acid (Acidgat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_iv.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_blood.png", "unlitgeneric smooth")
		},
	},
	use = function(self, ply)
		if CLIENT then return end

		local function GiveAcidgat()
			self:SetNW2Bool("SplatReady", false)
			self:SetNW2Int("SplatUser", 0)

			local wep2 = ply:Give(self.WeaponClass)
			if self.FakeBlundergatPap then
				self.FakeBlundergatPap = nil

				wep2.NZPaPME = true
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(ply) or not IsValid(wep2) then return end
					if wep2:HasNZModifier("pap") then return end
					wep2:ApplyNZModifier("pap")
				end)
			end
			if IsValid(self.FakeBlundergat) then
				self.FakeBlundergat:Remove()
			end
		end

		local function PlaceBlundergat()
			local ghost = self.CraftedModel
			if not IsValid(ghost) then return end
			local gun = ply:GetWeapon("tfa_bo2_blundergat")
			if not IsValid(gun) then return end

			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), 90)

			local prop = ents.Create("nz_script_prop")
			prop:SetParent(ghost)
			prop:SetModel("models/weapons/tfa_bo2/blundergat/w_blundergat.mdl")
			prop:SetPos(ghost:GetPos() + ghost:GetUp()*2 + ghost:GetRight()*9.5 + ghost:GetForward()*-1)
			prop:SetAngles(ang)

			prop:Spawn()

			prop:SetSolid(SOLID_NONE)
			prop:SetCollisionGroup(COLLISION_GROUP_NONE)
			prop:SetMoveType(MOVETYPE_NONE)

			ghost:EmitSound("zmb/alcatraz/acid_upgrade.wav", SNDLVL_NORM, 100, 1, CHAN_STATIC)
			ghost:ResetSequence("start")

			timer.Simple(ghost:SequenceDuration("start"), function()
				if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
				ghost:ResetSequence("loop")

				timer.Simple(3.2, function()
					if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
					prop:SetModel("models/weapons/tfa_bo2/acidgat/w_acidgat.mdl")
					ghost:ResetSequence("end")
					ParticleEffectAttach("nzr_build_acidgat", PATTACH_POINT_FOLLOW, ghost, 1)

					timer.Simple(ghost:SequenceDuration("end") - 0.25, function()
						if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
						self:SetNW2Bool("SplatReady", true)

						timer.Simple(30, function()
							if not IsValid(self) then return end
							self:SetNW2Int("SplatUser", 0)

							if not IsValid(prop) then return end
							ParticleEffect("nzr_building_poof", prop:WorldSpaceCenter(), angle_zero)
							prop:EmitSound("NZ.BO2.DigSite.Part")
						end)
					end)
				end)
			end)

			self.FakeBlundergat = prop
			self:SetNW2Int("SplatUser", ply:EntIndex())
			self.FakeBlundergatPap = gun.Ispackapunched

			ply:EquipPreviousWeapon()
			timer.Simple(engine.TickInterval(), function()
				ply:StripWeapon("tfa_bo2_blundergat")
			end)
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)

		if not splat_ready then
			if not IsValid(wep) or wep:GetClass() ~= "tfa_bo2_blundergat" then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		else
			local index = self:GetNW2Int("SplatUser", 0)
			if index > 0 and ply:EntIndex() ~= index then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		end

		local price = self:GetPrice()
		if price > 0 then
			if not ply:CanAfford(price) then self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny") return end

			if splat_ready then
				GiveAcidgat()
			else
				ply:Buy(price, self, function() PlaceBlundergat() return true end)
			end
		else
			if splat_ready then
				GiveAcidgat()
			else
				PlaceBlundergat()
			end
		end
	end,
	text = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)
		local index = self:GetNW2Int("SplatUser", 0)
		local price = ""
		if self:GetPrice() > 0 then
			price = " [Cost: "..self:GetPrice().."]"
		end

		if splat_ready then
			if index > 0 then
				if ply:EntIndex() == index then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
				else
					return ""
				end
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
			end
		else
			if index > 0 then
				return ""
			end
		end

		if wep:GetClass() == "tfa_bo2_blundergat" then
			if wep.Ispackapunched then
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert The Sweeper into Viltrolic Withering"..price
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert Blundergat into Acidgat"..price
			end
		end

		return "Blundergat Required"
	end,
})

nzBuilds:NewBuildable("bo2_teslagat", {
	name = "Teslagat Upgrade Kit",
	model = "models/zmb/bo2/alcatraz/zm_al_packasplat_elec.mdl",
	weapon = "tfa_bo2_teslagat",
	pos = Vector(0,0,44),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Engine (Teslagat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_engine.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_fuse.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Suitcase (Teslagat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_suitcase.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_case.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Acid (Teslagat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_iv_elec.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_blood.png", "unlitgeneric smooth")
		},
	},
	use = function(self, ply)
		if CLIENT then return end

		local function GiveAcidgat()
			self:SetNW2Bool("SplatReady", false)
			self:SetNW2Int("SplatUser", 0)

			local wep2 = ply:Give(self.WeaponClass)
			if self.FakeBlundergatPap then
				self.FakeBlundergatPap = nil

				wep2.NZPaPME = true
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(ply) or not IsValid(wep2) then return end
					if wep2:HasNZModifier("pap") then return end
					wep2:ApplyNZModifier("pap")
				end)
			end
			if IsValid(self.FakeBlundergat) then
				self.FakeBlundergat:Remove()
			end
		end

		local function PlaceBlundergat()
			local ghost = self.CraftedModel
			if not IsValid(ghost) then return end
			local gun = ply:GetWeapon("tfa_bo2_blundergat")
			if not IsValid(gun) then return end

			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), 90)

			local prop = ents.Create("nz_script_prop")
			prop:SetParent(ghost)
			prop:SetModel("models/weapons/tfa_bo2/blundergat/w_blundergat.mdl")
			prop:SetPos(ghost:GetPos() + ghost:GetUp()*2 + ghost:GetRight()*9.5 + ghost:GetForward()*-1)
			prop:SetAngles(ang)

			prop:Spawn()

			prop:SetSolid(SOLID_NONE)
			prop:SetCollisionGroup(COLLISION_GROUP_NONE)
			prop:SetMoveType(MOVETYPE_NONE)

			ghost:EmitSound("zmb/alcatraz/acid_upgrade.wav", SNDLVL_NORM, 100, 1, CHAN_STATIC)
			ghost:ResetSequence("start")

			timer.Simple(ghost:SequenceDuration("start"), function()
				if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
				ghost:ResetSequence("loop")

				timer.Simple(3.2, function()
					if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
					prop:SetModel("models/weapons/tfa_bo2/teslagat/w_teslagat.mdl")
					ghost:ResetSequence("end")
					ParticleEffectAttach("nzr_build_teslagat", PATTACH_POINT_FOLLOW, ghost, 1)

					timer.Simple(ghost:SequenceDuration("end") - 0.25, function()
						if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
						self:SetNW2Bool("SplatReady", true)

						timer.Simple(30, function()
							if not IsValid(self) then return end
							self:SetNW2Int("SplatUser", 0)

							if not IsValid(prop) then return end
							ParticleEffect("nzr_building_poof", prop:WorldSpaceCenter(), angle_zero)
							prop:EmitSound("NZ.BO2.DigSite.Part")
						end)
					end)
				end)
			end)

			self.FakeBlundergat = prop
			self:SetNW2Int("SplatUser", ply:EntIndex())
			self.FakeBlundergatPap = gun.Ispackapunched

			ply:EquipPreviousWeapon()
			timer.Simple(engine.TickInterval(), function()
				ply:StripWeapon("tfa_bo2_blundergat")
			end)
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)

		if not splat_ready then
			if not IsValid(wep) or wep:GetClass() ~= "tfa_bo2_blundergat" then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		else
			local index = self:GetNW2Int("SplatUser", 0)
			if index > 0 and ply:EntIndex() ~= index then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		end

		local price = self:GetPrice()
		if price > 0 then
			if not ply:CanAfford(price) then self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny") return end

			if splat_ready then
				GiveAcidgat()
			else
				ply:Buy(price, self, function() PlaceBlundergat() return true end)
			end
		else
			if splat_ready then
				GiveAcidgat()
			else
				PlaceBlundergat()
			end
		end
	end,
	text = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)
		local index = self:GetNW2Int("SplatUser", 0)
		local price = ""
		if self:GetPrice() > 0 then
			price = " [Cost: "..self:GetPrice().."]"
		end

		if splat_ready then
			if index > 0 then
				if ply:EntIndex() == index then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
				else
					return ""
				end
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
			end
		else
			if index > 0 then
				return ""
			end
		end

		if wep:GetClass() == "tfa_bo2_blundergat" then
			if wep.Ispackapunched then
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert The Sweeper into Tonitruum Tormentum"..price
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert Blundergat into Tesla Gat"..price
			end
		end

		return "Blundergat Required"
	end,
})

nzBuilds:NewBuildable("bo2_hellgat", {
	name = "Hell Gat Upgrade Kit",
	model = "models/zmb/bo2/alcatraz/zm_al_packasplat_fire.mdl",
	weapon = "tfa_bo2_hellgat",
	pos = Vector(0,0,44),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Engine (Hellgat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_engine.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_fuse.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Suitcase (Hellgat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_suitcase.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_case.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Acid (Hellgat)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_iv_hell.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_blood.png", "unlitgeneric smooth")
		},
	},
	use = function(self, ply)
		if CLIENT then return end

		local function GiveAcidgat()
			self:SetNW2Bool("SplatReady", false)
			self:SetNW2Int("SplatUser", 0)

			local wep2 = ply:Give(self.WeaponClass)
			if self.FakeBlundergatPap then
				self.FakeBlundergatPap = nil

				wep2.NZPaPME = true
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(ply) or not IsValid(wep2) then return end
					if wep2:HasNZModifier("pap") then return end
					wep2:ApplyNZModifier("pap")
				end)
			end
			if IsValid(self.FakeBlundergat) then
				self.FakeBlundergat:Remove()
			end
		end

		local function PlaceBlundergat()
			local ghost = self.CraftedModel
			if not IsValid(ghost) then return end
			local gun = ply:GetWeapon("tfa_bo2_blundergat")
			if not IsValid(gun) then return end

			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), 90)

			local prop = ents.Create("nz_script_prop")
			prop:SetParent(ghost)
			prop:SetModel("models/weapons/tfa_bo2/blundergat/w_blundergat.mdl")
			prop:SetPos(ghost:GetPos() + ghost:GetUp()*2 + ghost:GetRight()*9.5 + ghost:GetForward()*-1)
			prop:SetAngles(ang)

			prop:Spawn()

			prop:SetSolid(SOLID_NONE)
			prop:SetCollisionGroup(COLLISION_GROUP_NONE)
			prop:SetMoveType(MOVETYPE_NONE)

			ghost:EmitSound("zmb/alcatraz/acid_upgrade.wav", SNDLVL_NORM, 100, 1, CHAN_STATIC)
			ghost:ResetSequence("start")

			timer.Simple(ghost:SequenceDuration("start"), function()
				if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
				ghost:ResetSequence("loop")

				timer.Simple(3.2, function()
					if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
					prop:SetModel("models/weapons/tfa_bo2/hellgat/w_hellgat.mdl")
					ghost:ResetSequence("end")
					ParticleEffectAttach("nzr_build_magmagat", PATTACH_POINT_FOLLOW, ghost, 1)

					timer.Simple(ghost:SequenceDuration("end") - 0.25, function()
						if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
						self:SetNW2Bool("SplatReady", true)

						timer.Simple(30, function()
							if not IsValid(self) then return end
							self:SetNW2Int("SplatUser", 0)

							if not IsValid(prop) then return end
							ParticleEffect("nzr_building_poof", prop:WorldSpaceCenter(), angle_zero)
							prop:EmitSound("NZ.BO2.DigSite.Part")
						end)
					end)
				end)
			end)

			self.FakeBlundergat = prop
			self:SetNW2Int("SplatUser", ply:EntIndex())
			self.FakeBlundergatPap = gun.Ispackapunched

			ply:EquipPreviousWeapon()
			timer.Simple(engine.TickInterval(), function()
				ply:StripWeapon("tfa_bo2_blundergat")
			end)
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)

		if not splat_ready then
			if not IsValid(wep) or wep:GetClass() ~= "tfa_bo2_blundergat" then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		else
			local index = self:GetNW2Int("SplatUser", 0)
			if index > 0 and ply:EntIndex() ~= index then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		end

		local price = self:GetPrice()
		if price > 0 then
			if not ply:CanAfford(price) then self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny") return end

			if splat_ready then
				GiveAcidgat()
			else
				ply:Buy(price, self, function() PlaceBlundergat() return true end)
			end
		else
			if splat_ready then
				GiveAcidgat()
			else
				PlaceBlundergat()
			end
		end
	end,
	text = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)
		local index = self:GetNW2Int("SplatUser", 0)
		local price = ""
		if self:GetPrice() > 0 then
			price = " [Cost: "..self:GetPrice().."]"
		end

		if splat_ready then
			if index > 0 then
				if ply:EntIndex() == index then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
				else
					return ""
				end
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
			end
		else
			if index > 0 then
				return ""
			end
		end

		if wep:GetClass() == "tfa_bo2_blundergat" then
			if wep.Ispackapunched then
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert The Sweeper into Jahannam"..price
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert Blundergat into Hell Gat"..price
			end
		end

		return "Blundergat Required"
	end,
})

nzBuilds:NewBuildable("bo2_blunderhoff", {
	name = "Blunderhoff Upgrade Kit",
	model = "models/zmb/bo2/alcatraz/zm_al_packasplat_juice.mdl",
	weapon = "tfa_bo2_blunderhoff",
	pos = Vector(0,0,44),
	ang = Angle(0,0,0),
	parts = {
		[1] = {
			id = "Engine (Blunderhoff)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_engine.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_fuse.png", "unlitgeneric smooth")
		},
		[2] = {
			id = "Suitcase (Blunderhoff)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_suitcase.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_case.png", "unlitgeneric smooth")
		},
		[3] = {
			id = "Acid (Blunderhoff)", 
			mdl = "models/zmb/bo2/alcatraz/zm_al_packasplat_iv_juice.mdl",
			icon = Material("vgui/icon/zom_hud_craftable_acidr_blood.png", "unlitgeneric smooth")
		},
	},
	use = function(self, ply)
		if CLIENT then return end

		local function GiveAcidgat()
			self:SetNW2Bool("SplatReady", false)
			self:SetNW2Int("SplatUser", 0)

			local wep2 = ply:Give(self.WeaponClass)
			if self.FakeBlundergatPap then
				self.FakeBlundergatPap = nil

				wep2.NZPaPME = true
				timer.Simple(engine.TickInterval(), function()
					if not IsValid(ply) or not IsValid(wep2) then return end
					if wep2:HasNZModifier("pap") then return end
					wep2:ApplyNZModifier("pap")
				end)
			end
			if IsValid(self.FakeBlundergat) then
				self.FakeBlundergat:Remove()
			end
		end

		local function PlaceBlundergat()
			local ghost = self.CraftedModel
			if not IsValid(ghost) then return end
			local gun = ply:GetWeapon("tfa_bo2_blundergat")
			if not IsValid(gun) then return end

			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Right(), 90)
			ang:RotateAroundAxis(ang:Up(), 90)

			local prop = ents.Create("nz_script_prop")
			prop:SetParent(ghost)
			prop:SetModel("models/weapons/tfa_bo2/blundergat/w_blundergat.mdl")
			prop:SetPos(ghost:GetPos() + ghost:GetUp()*2 + ghost:GetRight()*9.5 + ghost:GetForward()*-1)
			prop:SetAngles(ang)

			prop:Spawn()

			prop:SetSolid(SOLID_NONE)
			prop:SetCollisionGroup(COLLISION_GROUP_NONE)
			prop:SetMoveType(MOVETYPE_NONE)

			ghost:EmitSound("zmb/alcatraz/acid_upgrade.wav", SNDLVL_NORM, 100, 1, CHAN_STATIC)
			ghost:ResetSequence("start")

			timer.Simple(ghost:SequenceDuration("start"), function()
				if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
				ghost:ResetSequence("loop")

				timer.Simple(3.2, function()
					if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
					prop:SetModel("models/weapons/tfa_bo2/blunderhoff/w_blunderhoff.mdl")
					ghost:ResetSequence("end")
					ParticleEffectAttach("nzr_build_blunderhoff", PATTACH_POINT_FOLLOW, ghost, 1)

					timer.Simple(ghost:SequenceDuration("end") - 0.25, function()
						if not (IsValid(self) and IsValid(prop) and IsValid(ghost)) then return end
						self:SetNW2Bool("SplatReady", true)

						timer.Simple(30, function()
							if not IsValid(self) then return end
							self:SetNW2Int("SplatUser", 0)

							if not IsValid(prop) then return end
							ParticleEffect("nzr_building_poof", prop:WorldSpaceCenter(), angle_zero)
							prop:EmitSound("NZ.BO2.DigSite.Part")
						end)
					end)
				end)
			end)

			self.FakeBlundergat = prop
			self:SetNW2Int("SplatUser", ply:EntIndex())
			self.FakeBlundergatPap = gun.Ispackapunched

			ply:EquipPreviousWeapon()
			timer.Simple(engine.TickInterval(), function()
				ply:StripWeapon("tfa_bo2_blundergat")
			end)
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)

		if not splat_ready then
			if not IsValid(wep) or wep:GetClass() ~= "tfa_bo2_blundergat" then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		else
			local index = self:GetNW2Int("SplatUser", 0)
			if index > 0 and ply:EntIndex() ~= index then
				self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny")
			return end
		end

		local price = self:GetPrice()
		if price > 0 then
			if not ply:CanAfford(price) then self:EmitSound(self.BuildDenySound or "NZ.Buildable.Deny") return end

			if splat_ready then
				GiveAcidgat()
			else
				ply:Buy(price, self, function() PlaceBlundergat() return true end)
			end
		else
			if splat_ready then
				GiveAcidgat()
			else
				PlaceBlundergat()
			end
		end
	end,
	text = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then return end
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		local wep = ply:GetActiveWeapon()
		local splat_ready = self:GetNW2Bool("SplatReady", false)
		local index = self:GetNW2Int("SplatUser", 0)
		local price = ""
		if self:GetPrice() > 0 then
			price = " [Cost: "..self:GetPrice().."]"
		end

		if splat_ready then
			if index > 0 then
				if ply:EntIndex() == index then
					return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
				else
					return ""
				end
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - take converted weapon"
			end
		else
			if index > 0 then
				return ""
			end
		end

		if wep:GetClass() == "tfa_bo2_blundergat" then
			if wep.Ispackapunched then
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert The Sweeper into Boogie Bomb"..price
			else
				return "Press "..string.upper(input.LookupBinding("+USE")).." - convert Blundergat into Blunderhoff"..price
			end
		end

		return "Blundergat Required"
	end,
})
