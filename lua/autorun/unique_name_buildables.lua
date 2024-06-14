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
	completed = function(self, ply) end, //runs once when buildable is completed, DELETE IF NOT USING
	use = function(self, ply) end, //custom use function, DELETE IF NOT USING
	text = function(self) end, //custom text, DELETE IF NOT USING
})]]--

if engine.ActiveGamemode() == "nzombies" then
	hook.Add("PostGamemodeLoaded", "nz.register.myname.buildables", function()

		nzBuilds:NewBuildable("heisenhammer", {
			name = "Heisenberg's Hammer",
			model = "models/weapons/bo3_melees/mace/karlheisenberg_hammer.mdl",
			pos = Vector(0,0,60),
			ang = Angle(0,90,90),
			weapon = "nz_knife_heisenberg",
			parts = {
				[1] = {id = "Metal Pole", mdl = "models/props_c17/signpole001.mdl"},
				[2] = {id = "Gear", mdl = "models/props_phx/gears/spur12.mdl"},
				[3] = {id = "Engineblock", mdl = "models/props_c17/trappropeller_engine.mdl"},
				//there can be as many parts as you want
			},
			remove = true,
		})
		nzBuilds:NewBuildable("ritual_door", {
			name = "Ritual Door",
			model = "models/zmb/bo2/alcatraz/zm_al_skull_afterlife.mdl",
			pos = Vector(0,0,40),
			ang = Angle(90,90,0),
			weapon = "",
			parts = {
				[1] = {id = "Skull", mdl = "models/Gibs/HGIBS.mdl"},
				[2] = {id = "Ritual Knife", mdl = "models/nzr/2022/weapons/w_knife.mdl"},
			},
			remove = true,
			use = function(self, ply)
				nzDoors:OpenLinkedDoors("buildable_ritual")
    		end,
   			text = function(self)
        		return "Press "..string.upper(input.LookupBinding("+USE")).." - Open Linked Door"
    		end,
		})
		nzBuilds:NewBuildable("bomb_door", {
            name = "Dynamite",
            model = "models/moo/_codz_ports_props/t8/zm_orange/p8_zm_ora_dynamite/moo_codz_p8_zm_ora_dynamite_bundle.mdl",
            pos = Vector(0,0,0),
            ang = Angle(0,0,0),
            weapon = "",
            hudicon = Material("vgui/icon/ximage_273ffc1da3b8cca.png", "unlitgeneric smooth"),
            parts = {
				[1] = {
					id = "Explosives", 
					mdl = "models/moo/_codz_ports_props/t8/zm_orange/p8_zm_ora_dynamite/moo_codz_p8_zm_ora_dynamite_01.mdl",
					icon = Material("vgui/icon/ximage_24fd3c09cd2486a.png", "unlitgeneric smooth")
				},
				[2] = {
					id = "Timer", 
					mdl = "models/moo/_codz_ports_props/t8/zm_orange/p8_zm_ora_dynamite/moo_codz_p8_zm_ora_dynamite_timer.mdl",
					icon = Material("vgui/icon/ximage_3db4d4435557493.png", "unlitgeneric smooth")
				},
				[3] = {
					id = "Clock", 
					mdl = "models/moo/_codz_ports_props/t8/zm_orange/p8_zm_ora_dynamite/moo_codz_p8_zm_ora_dynamite_clock.mdl",
					icon = Material("vgui/icon/ximage_c2591029d6e9c0c.png", "unlitgeneric smooth")
				},
            },
            remove = true,
            notable = true,
            use = function(self, ply)
                self:EmitSound("weapons/slam/buttonclick.wav", SNDLVL_TALKING, 100, 1, CHAN_STATIC)
                nzDoors:OpenLinkedDoors("buildable_bomb")

                timer.Simple(0.1, function()
                    if not IsValid(self) then return end
                    ParticleEffect("bo3_panzer_explosion", self:GetPos(), Angle(0,0,0))
                    self:EmitSound("weapons/c4/c4_explode1.wav", 511, 100, 1, CHAN_STATIC)
                    self:EmitSound("weapons/c4/c4_explode_deb"..math.random(2)..".wav", 511, 100, 1, CHAN_STATIC)
                end)
            end,
            text = function(self)
                return "Press "..string.upper(input.LookupBinding("+USE")).." - Activate Dynamite"
            end,
        })
		nzBuilds:NewBuildable("power", {
			name = "Power Switch",
			model = "models/zmb/bo2/power/build_power_body.mdl",
			pos = Vector(0,0,0),
			ang = Angle(0,0,0),
			weapon = "",
			parts = {
				[1] = {
					id = "Power Switch Panel", 
					mdl = "models/zmb/bo2/power/build_power_body.mdl",
					icon = Material("vgui/icon/zom_hud_icon_buildable_item_panel.png", "unlitgeneric smooth")
				},
				[2] = {
					id = "Power Switch Lever", 
					mdl = "models/zmb/bo2/power/build_power_lever.mdl",
					icon = Material("vgui/icon/zom_hud_icon_buildable_item_lever.png", "unlitgeneric smooth")
				},
				//there can be as many parts as you want
			},
			remove = true,
            notable = true,
            completed = function(self, ply)
				local fakepower = ents.Create('power_box')
				fakepower:SetPos(self:GetPos())
				fakepower:SetAngles(self:GetAngles())
				fakepower.FakePower = true
				fakepower:Spawn()

				local index = fakepower:EntIndex()
				hook.Add("OnRoundEnd", "nz.fakepower"..index, function()
					if nzRound:InState( ROUND_CREATE ) or nzRound:InState( ROUND_GO ) then
						for k, v in pairs(ents.FindByClass("power_box")) do
							if IsValid(v) and v.FakePower then
								v:Remove()
								hook.Remove("OnRoundEnd", "nz.fakepower"..index)
								break
							end
						end
					end
				end)

				self:RemoveTable()
			end,
    		text = function(self)
        		return "Press "..string.upper(input.LookupBinding("+USE")).." - Turn Power On"
    		end,
		})
	end)
end