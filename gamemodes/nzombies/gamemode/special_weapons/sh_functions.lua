nzSpecialWeapons.Modifiers = nzSpecialWeapons.Modifiers or {}

function nzSpecialWeapons:RegisterModifier(id, func, defaultdata)
	nzSpecialWeapons.Modifiers[id] = {func, defaultdata}
end

function nzSpecialWeapons:ModifyWeapon(wep, id, data)
	local tbl = nzSpecialWeapons.Modifiers[id]
	if !tbl then return end

	local pass = {}
	local default = tbl[2]

	if !data then pass = default else
		for k,v in pairs(default) do
			if data[k] != nil then -- ONLY if nil (not passed)
				pass[k] = data[k]
			else
				pass[k] = v
			end
		end
	end

	local bool = tbl[1](wep, pass) -- Run the function with the data, return whether it worked or not
	if bool then
		wep.NZSpecialWeaponData = pass
		wep.NZSpecialCategory = id -- Mark as special from now on

		if isentity(wep) then -- Reregister it on the player if it is currently being carried
			wep:SetNWInt("SwitchSlot", nil) -- Reset weapon slot
			local ply = wep:GetOwner()
			if IsValid(ply) then
				hook.Run("WeaponEquip", wep) -- Rerun weapon equip logic (resets slots etc)
				ply:EquipPreviousWeapon() -- Equip previous weapon
			end
		end
	end

	return bool
end

local sp = game.SinglePlayer()

nzSpecialWeapons:RegisterModifier("knife", function(wep, data)
	if !wep or wep.NZModifierRegistered then return end
	wep.NZModifierRegistered = true

	local drawtime = tonumber(data.DrawHolsterTime) //set to 0 to be auto calculated
	local attacktime = tonumber(data.AttackHolsterTime) //set to 0 to be auto calculated
	local lungetime = data.LungeHolsterTime and tonumber(data.LungeHolsterTime) or 0
	local equipdraw = tobool(data.DrawOnEquip)

	wep.EquipDraw = wep.Deploy

	local oldattack = wep.PrimaryAttack
	function wep:PrimaryAttack()
		if self.nzCanAttack then
			self.nzCanAttack = false
			oldattack(self)
		end
	end

	function wep:Deploy()
		local ct = CurTime()
		if !self.nzIsDrawing then
			self.nzCanAttack = true
			self.nzHolsterTime = ct + attacktime
			self:SendWeaponAnim(ACT_VM_IDLE)
			self:SetNextPrimaryFire(0)

			if self.SetStatus then
				self:SetStatus(TFA.Enum.STATUS_IDLE)
			end

			self:PrimaryAttack()
		else
			self.nzHolsterTime = ct + drawtime
		end
		self.nzIsDrawing = nil
	end

	local oldthink = wep.Think
	function wep:Think(...)
		local ct = CurTime()

		if self.nzHolsterTime and ct > self.nzHolsterTime then
			self:Holster()
			self.Owner:SetUsingSpecialWeapon(false)
			self.Owner:EquipPreviousWeapon()
			self.nzHolsterTime = nil
		end

		oldthink(self,...)
	end

	/*local oldholster = wep.Holster
	function wep:Holster(...)
		self.Owner:SetUsingSpecialWeapon(false)
		return oldholster(self, ...)
	end*/

	return true
end, { -- Every field that isn't supplied from the data arg is taken from here instead
	AttackHolsterTime = 0.65,
	DrawHolsterTime = 1.5,
	LungeHolsterTime = 1.2,
	DrawOnEquip = true,
	tfaknife = false,
})

nzSpecialWeapons:RegisterModifier("grenade", function(wep, data)
	if !wep or wep.NZModifierRegistered then return end
	wep.NZModifierRegistered = true

	local drawact = data.DrawAct
	local throwtime = data.ThrowTime
	local throwfunc = data.ThrowFunction
	local holstertime = data.HolsterTime

	wep.EquipDraw = wep.Deploy
	local primary = wep.PrimaryAttack

	if wep.IsTFAWeapon and wep.Base and string.find(wep.Base , "tfa_nade") and (wep.Primary.Round or wep.Primary.Projectile) then
		wep.ProceduralHolsterEnabled = true
		wep.ProceduralHolsterTime = engine.TickInterval()

		function wep:Deploy()
			self.ProceduralHolsterEnabled = true
			self.ProceduralHolsterTime = engine.TickInterval()
			self:SetClip1(self.Primary_TFA.ClipSize)
			self:EquipDraw()
		end

		local oldthink = wep.Think2
		local oldthrow = wep.Throw

		function wep:Throw()
			oldthrow(self)
			self:GetOwner():SetAmmo(self:GetOwner():GetAmmoCount(GetNZAmmoID("grenade")) - 1, GetNZAmmoID("grenade"))
			self:SetClip1(self.Primary_TFA.ClipSize)
		end

		function wep:Think2(...)
			local stat = self:GetStatus()
			local statusend = CurTime() >= self:GetStatusEnd()
			local ply = self:GetOwner()

			if stat == TFA.Enum.STATUS_GRENADE_THROW_WAIT and statusend then
				self:Holster()
				self.Owner:SetUsingSpecialWeapon(false)
				self.Owner:EquipPreviousWeapon()
			end

			oldthink(self, ...)

			if CLIENT and sp then return end

			local stat = self:GetStatus()
			local ply = self:GetOwner()

			if stat == TFA.Enum.STATUS_IDLE and IsValid(ply) and (!ply.nzSpecialButtonDown or !ply:GetNotDowned()) then
				primary(self)
			end
		end

		function wep:PrimaryAttack() end
	else
		function wep:Deploy()
			local ct = CurTime()

			if !drawact then
				self:EquipDraw() -- Use normal draw animation/function for not specifying throw act
			else
				self:SendWeaponAnim(drawact) -- Otherwise play the act (preferably pull pin act)
			end
			self.nzThrowTime = ct + throwtime
		end

		if !throwfunc then
			local primary = wep.PrimaryAttack
			throwfunc = function(self)
				primary(self)
				self.Owner:SetAmmo(self.Owner:GetAmmoCount(GetNZAmmoID("grenade")) - 1, GetNZAmmoID("grenade"))
			end
		end

		local oldthink = wep.Think
		function wep:Think()
			local ct = CurTime()

			if self.nzThrowTime and ct > self.nzThrowTime and (!self.Owner.nzSpecialButtonDown or !self.Owner:GetNotDowned()) then
				self.nzThrowTime = nil
				self.nzHolsterTime = ct + holstertime
				self:SetNextPrimaryFire(0)
				throwfunc(self)
			end

			if self.nzHolsterTime and ct > self.nzHolsterTime then
				self:Holster()
				self.Owner:SetUsingSpecialWeapon(false)
				self.Owner:EquipPreviousWeapon()
				self.nzHolsterTime = nil
			end

			oldthink(self)
		end

		function wep:PrimaryAttack() end
	end

	return true
end, {
	MaxAmmo = 4,
	AmmoType = "nz_grenade",
	DrawAct = false, -- False/nil makes default
	ThrowTime = 0.85,
	ThrowFunction = false, -- False/nil uses default PrimaryAttack function
	HolsterTime = 0.4,
})

nzSpecialWeapons:RegisterModifier("specialgrenade", function(wep, data)
	if !wep or wep.NZModifierRegistered then return end
	wep.NZModifierRegistered = true

	local drawact = data.DrawAct
	local throwtime = data.ThrowTime
	local throwfunc = data.ThrowFunction
	local holstertime = data.HolsterTime

	wep.EquipDraw = wep.Deploy
	local primary = wep.PrimaryAttack

	if wep.IsTFAWeapon and wep.Base and string.find(wep.Base , "tfa_nade") and (wep.Primary.Round or wep.Primary.Projectile) then
		wep.ProceduralHolsterEnabled = true
		wep.ProceduralHolsterTime = engine.TickInterval()

		function wep:Deploy()
			self.ProceduralHolsterEnabled = true
			self.ProceduralHolsterTime = engine.TickInterval()
			self:SetClip1(self.Primary_TFA.ClipSize)
			self:EquipDraw()
		end

		local oldthink = wep.Think2
		local oldthrow = wep.Throw

		function wep:Throw()
			oldthrow(self)
			self:GetOwner():SetAmmo(self:GetOwner():GetAmmoCount(GetNZAmmoID("specialgrenade")) - 1, GetNZAmmoID("specialgrenade"))
			self:SetClip1(self.Primary_TFA.ClipSize)
		end

		function wep:Think2(...)
			local stat = self:GetStatus()
			local statusend = CurTime() >= self:GetStatusEnd()

			if stat == TFA.Enum.STATUS_GRENADE_THROW_WAIT and statusend then
				self:Holster()
				self.Owner:SetUsingSpecialWeapon(false)
				self.Owner:EquipPreviousWeapon()
			end

			oldthink(self, ...)

			if CLIENT and sp then return end

			local stat = self:GetStatus()
			local ply = self:GetOwner()

			if stat == TFA.Enum.STATUS_IDLE and IsValid(ply) and (!ply.nzSpecialButtonDown or !ply:GetNotDowned()) then
				primary(self)
			end
		end

		function wep:PrimaryAttack() end
	else
		function wep:Deploy()
			local ct = CurTime()

			if !drawact then
				self:EquipDraw() -- Use normal draw animation/function for not specifying throw act
			else
				self:SendWeaponAnim(drawact) -- Otherwise play the act (preferably pull pin act)
			end
			self.nzThrowTime = ct + throwtime
		end

		if !throwfunc then
			local primary = wep.PrimaryAttack
			throwfunc = function(self)
				primary(self)
				self.Owner:SetAmmo(self.Owner:GetAmmoCount(GetNZAmmoID("specialgrenade")) - 1, GetNZAmmoID("specialgrenade"))
			end
		end

		local oldthink = wep.Think
		function wep:Think()
			local ct = CurTime()

			if self.nzThrowTime and ct > self.nzThrowTime and (!self.Owner.nzSpecialButtonDown or !self.Owner:GetNotDowned()) then
				self.nzThrowTime = nil
				self.nzHolsterTime = ct + holstertime
				self:SetNextPrimaryFire(0)
				throwfunc(self)
			end

			if self.nzHolsterTime and ct > self.nzHolsterTime then
				self:Holster()
				self.Owner:SetUsingSpecialWeapon(false)
				self.Owner:EquipPreviousWeapon()
				self.nzHolsterTime = nil
			end

			oldthink(self)
		end

		function wep:PrimaryAttack() end
	end

	return true
end, {
	MaxAmmo = 3,
	AmmoType = "nz_specialgrenade",
	DrawAct = false, -- False/nil makes default
	ThrowTime = 1.2,
	ThrowFunction = false, -- False/nil uses default PrimaryAttack function
	HolsterTime = 0.4,
})

//rewrite me

nzSpecialWeapons:RegisterModifier("display", function(wep, data)
	if !wep or wep.NZModifierRegistered then return end
	wep.NZModifierRegistered = true

	local drawfunc = data.DrawFunction
	local returnfunc = data.ToHolsterFunction

	wep.EquipDraw = wep.Deploy

	if drawfunc then
		function wep:Deploy()
			local ct = CurTime()
			drawfunc(self) -- Drawfunc specified, overwrite deploy with this function
			self.nzDeployTime = ct -- Time when it was equipped, can be used for time comparisons
		end
	else
		function wep:Deploy()
			local ct = CurTime()
			self:EquipDraw() -- Not specified, use deploy function
			self.nzDeployTime = ct -- Time when it was equipped, can be used for time comparisons
		end
	end

	local oldthink = wep.Think

	function wep:Think()
		if returnfunc(self) then
			self:Holster()
			self.Owner:SetUsingSpecialWeapon(false)
			self.Owner:EquipPreviousWeapon()
			if SERVER then
				self.Owner:StripWeapon(self:GetClass())
			end
		end

		oldthink(self)
	end
	return true
end, {
	DrawFunction = false,
	ToHolsterFunction = function(wep)
		return SERVER and CurTime() > wep.nzDeployTime + 2.5 -- Default delay 2.5 seconds
	end,
})

-- Hardcodes the weapon by re-registering the weapon table after it's passed through normal modifications
function nzSpecialWeapons:AddKnife( class, equipdraw, attacktime, drawtime )
	local wep = weapons.Get(class)
	if wep then
		if nzSpecialWeapons:ModifyWeapon(wep, "knife", {AttackHolsterTime = attacktime or 0.65, DrawHolsterTime = drawtime or 1.5, DrawOnEquip = equipdraw or false}) then
			weapons.Register(wep, class)
		end
	end
end

function nzSpecialWeapons:AddGrenade( class, ammo, drawact, throwtime, throwfunc, holstertime )
	local wep = weapons.Get(class)
	if wep then
		if nzSpecialWeapons:ModifyWeapon(wep, "grenade", {MaxAmmo = ammo, DrawAct = drawact, ThrowTime = throwtime, ThrowFunction = throwfunc, HolsterTime = holstertime}) then
			weapons.Register(wep, class)
		end
	end
end

function nzSpecialWeapons:AddSpecialGrenade( class, ammo, drawact, throwtime, throwfunc, holstertime )
	local wep = weapons.Get(class)
	if wep then
		if nzSpecialWeapons:ModifyWeapon(wep, "specialgrenade", {MaxAmmo = ammo, DrawAct = drawact, ThrowTime = throwtime, ThrowFunction = throwfunc, HolsterTime = holstertime}) then
			weapons.Register(wep, class)
		end
	end
end

function nzSpecialWeapons:AddDisplay( class, drawfunc, returnfunc )
	local wep = weapons.Get(class)
	if wep then
		if nzSpecialWeapons:ModifyWeapon(wep, "display", {DrawFunction = drawfunc, ToHolsterFunction = returnfunc}) then
			weapons.Register(wep, class)
		end
	end
end

if CLIENT then
	CreateClientConVar("nz_key_knife", KEY_V, true, true, "Sets the key that triggers Knife. Uses numbers from gmod's KEY_ enums: http://wiki.garrysmod.com/page/Enums/KEY")
	CreateClientConVar("nz_key_grenade", KEY_G, true, true, "Sets the key that throws Grenades. Uses numbers from gmod's KEY_ enums: http://wiki.garrysmod.com/page/Enums/KEY")
	CreateClientConVar("nz_key_specialgrenade", KEY_B, true, true, "Sets the key that throws Special Grenades. Uses numbers from gmod's KEY_ enums: http://wiki.garrysmod.com/page/Enums/KEY")

	local defaultkeys = nzSpecialWeapons.Keys

	function GetSpecialWeaponIDFromInput()
		local ply = LocalPlayer()
		if !ply.NZSpecialWeapons then return end

		local id
		local wep

		for k,v in pairs(ply.NZSpecialWeapons) do
			local key = input.IsKeyDown(ply:GetInfoNum("nz_key_"..k, defaultkeys[k] or -1))
			local mouse = input.IsMouseDown(ply:GetInfoNum("nz_key_"..k, defaultkeys[k] or -1))
			if key then
				id = k
				wep = v
				break
			end
		end

		return id, wep
	end

	hook.Add("CreateMove", "nzSpecialWeaponSelect", function( cmd )
		if vgui.CursorVisible() then return end
		local ply = LocalPlayer()
		local id, wep = GetSpecialWeaponIDFromInput()
		if id and (ply:GetNotDowned() or id == "knife") and !ply:GetUsingSpecialWeapon() then
			local ammo = GetNZAmmoID(id)
			if !ammo or ply:GetAmmoCount(ammo) >= 1 then
				if IsValid(wep) and !ply:GetNW2Bool("NZSpecialButtonHeld", false) then
					if ply.DoWeaponSwitch then return end
					if hook.Call("PlayerSwitchWeapon", nil, ply, ply:GetActiveWeapon(), wep) then return end
					ply:SelectWeapon(wep:GetClass())
				end
			end
		end
	end)

	hook.Add("HUDWeaponPickedUp", "nzSpecialWeaponAddClient", function(wep)
		local ply = LocalPlayer()
		local id = IsValid(wep) and wep:IsSpecial() and wep:GetSpecialCategory()
		if !ply.NZSpecialWeapons then ply.NZSpecialWeapons = {} end
		if id and !IsValid(ply.NZSpecialWeapons[id]) then
			if ply:HasUpgrade("mulekick") and !wep.NZNoMaxAmmo and wep.NZSpecialWeaponData and wep.NZSpecialWeaponData.MaxAmmo then
				wep.NZSpecialWeaponData.MaxAmmo = wep.NZSpecialWeaponData.MaxAmmo + 1
			end
			ply.NZSpecialWeapons[id] = wep
		end
	end)
end

local ScreenshotRequested = false
function RequestAScreenshot()
	ScreenshotRequested = true
end

-- For the sake of this example, we use a console command to request a screenshot
concommand.Add( "make_screenshot", RequestAScreenshot )

hook.Add( "PostRender", "example_screenshot", function()
	if ( !ScreenshotRequested ) then return end
	ScreenshotRequested = false

	local data = render.Capture( {
		format = "png",
		x = 0,
		y = 0,
		w = ScrW(),
		h = ScrH()
	} )

	file.Write( "image.png", data )
end )

hook.Add("PlayerButtonDown", "nzSpecialWeaponsHandler", function(ply, but)
	if but == ply:GetInfoNum("nz_key_grenade", KEY_G) and !ply.nzSpecialButtonDown then
		local wep = ply:GetSpecialWeaponFromCategory("grenade")
		if not IsValid(wep) then
			wep = ply:GetWeapon(nzMapping.Settings.grenade or "tfa_bo1_m67")
		end

		if IsValid(wep) and ply:GetActiveWeapon() ~= wep then
			for k, v in pairs(ents.FindInSphere(ply:GetPos(), 64)) do
				if v.NZNadeRethrow and v:GetCreationTime() + 0.25 < CurTime() then
					ply:SetAmmo(ply:GetAmmoCount("nz_grenade") + 1, "nz_grenade")
					ply:SelectWeapon(wep:GetClass())

					timer.Simple(engine.TickInterval(), function() //uhh ohh stinky
						if not IsValid(wep) then return end
						wep:SetHeldTime(wep:GetHeldTime() - 2)
					end)

					if SERVER then
						v:Remove()
					end
					break
				end
			end
		end
	end

	if but == ply:GetInfoNum("nz_key_knife", KEY_V) or
	but == ply:GetInfoNum("nz_key_grenade", KEY_G) or
	but == ply:GetInfoNum("nz_key_specialgrenade", KEY_B) then
		ply:SetNW2Bool("NZSpecialButtonHeld", true)
		ply.nzSpecialButtonDown = true
	end

	--[[Recode Comment Wolfkann:"Same issue when playing sound effects with stasis, 
	this should be more reliable, because DoAnimationEvent is Third person ONLY, 
	this is why it broke in single player" --]]

	if id and (ply:GetNotDowned() or id == "knife") and !ply:GetUsingSpecialWeapon() then end
end)

hook.Add("PlayerButtonUp", "nzSpecialWeaponsThrow", function(ply, but)
	local id = but == ply:GetInfoNum("nz_key_knife", KEY_V) or but == ply:GetInfoNum("nz_key_grenade", KEY_G) or but == ply:GetInfoNum("nz_key_specialgrenade", KEY_B)
	if id and ply.nzSpecialButtonDown then
		ply:SetNW2Bool("NZSpecialButtonHeld", false)
		ply.nzSpecialButtonDown = false
	end
end)

hook.Add("SetupMove", "nzKnifeShmove", function(ply, mv, cmd)
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and wep.CanKnifeLunge and wep.GetLunging and IsValid(ply:GetKnifingTarget()) then
		if wep:GetLunging() then
			if ply:IsOnGround() then
				local lunge = (ply:GetKnifingTarget():GetPos() - ply:GetPos()):GetNormalized()
				mv:SetVelocity(lunge * (wep.KnifeLungeSpeed or 800))

				if ply:HasPerk("deadshot") then
					local ent = ply:GetKnifingTarget()
					local headbone = ent:LookupBone("ValveBiped.Bip01_Head1")
					if !headbone then headbone = ent:LookupBone("j_neck") end

					if headbone then
						local headpos = ent:GetBonePosition(headbone)
						local finalang = LerpAngle(0.22, ply:EyeAngles(), (headpos - ply:GetShootPos()):Angle())

						ply:SetEyeAngles(finalang)
					end
				end
			end

			local vel = mv:GetVelocity()
			if vel[3] > ply:GetJumpPower() then
				mv:SetVelocity(vel - (vector_up*math.abs(vel[3])))
			end

			if ply:GetPos():DistToSqr(ply:GetKnifingTarget():GetPos()) <= 1024 then
				mv:SetVelocity(vector_origin)
				wep:SetLunging(false)
				//ply:SetKnifingTarget(NULL)
			end
		else
			ply:SetKnifingTarget(NULL)
		end
	end
end)

hook.Add("StartCommand", "nzKnifeMove", function(ply, cmd)
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) and wep.CanKnifeLunge and ply:IsOnGround() and wep.GetLunging and wep:GetLunging() then
		cmd:RemoveKey(IN_SPEED)
		cmd:RemoveKey(IN_JUMP)
		cmd:RemoveKey(IN_DUCK)
		cmd:ClearMovement()
	end
end)

local WEAPON = FindMetaTable("Weapon")

if WEAPON then
	function WEAPON:IsSpecial()
		return self.NZSpecialCategory and true or false
	end

	function WEAPON:GetSpecialCategory()
		return self.NZSpecialCategory
	end
end

local PLAYER = FindMetaTable("Player")

if PLAYER then
	function PLAYER:GetKnifingTarget()
		return self:GetNW2Entity("nz.KnifingEnemy")
	end

	function PLAYER:SetKnifingTarget(ent)
		return self:SetNW2Entity("nz.KnifingEnemy", ent)
	end

	function PLAYER:GetSpecialWeaponFromCategory( id )
		if !self.NZSpecialWeapons then self.NZSpecialWeapons = {} end
		return self.NZSpecialWeapons[id] or nil
	end

	function PLAYER:EquipPreviousWeapon()
		if IsValid(self.NZPrevWep) then -- If the previously used weapon is valid, use that
			if SERVER then
				self:SetActiveWeapon(nil)
			end

			self:SelectWeapon(self.NZPrevWep:GetClass())
		else
			if sp and CLIENT then
				for k, v in pairs(self:GetWeapons()) do -- And pick the first one that isn't special
					local slot = v:GetNWInt("SwitchSlot", 0)
					if slot == self:GetCurrentWeaponSlot() then
						self:SelectWeapon(v:GetClass())
						return
					end
				end
			else
				for k, v in pairs(self:GetWeapons()) do -- And pick the first one that isn't special
					if !v:IsSpecial() then
						if SERVER then
							self:SetActiveWeapon(nil)
						end

						self:SelectWeapon(v:GetClass())
						return
					end
				end
			end
		end
	end
end

if SERVER then
	function PLAYER:AddSpecialWeapon(wep)
		if !self.NZSpecialWeapons then self.NZSpecialWeapons = {} end
		local id = wep:GetSpecialCategory()
		self.NZSpecialWeapons[id] = wep
		nzSpecialWeapons:SendSpecialWeaponAdded(self, wep, id)

		local data = wep.NZSpecialWeaponData

		if !data then return end -- No nothing more if it doesn't have data supplied (e.g. specially added thingies)

		local ammo = GetNZAmmoID(id)
		local maxammo = data.MaxAmmo
		local mapnade = nzMapping.Settings.grenade

		if ammo and maxammo and wep:GetClass() ~= mapnade then
			if self:HasUpgrade("mulekick") and id == "specialgrenade" and !wep.NZNoMaxAmmo then
				wep.NZMuleModRestore = maxammo
				maxammo = wep.NZMuleModRestore + 1
				wep.NZSpecialWeaponData.MaxAmmo = maxammo
			end

			self:SetAmmo(maxammo, ammo)
		end
		
		if id == "display" then
			self:SetUsingSpecialWeapon(true)
			self:SetActiveWeapon(nil)
			self:SelectWeapon(wep:GetClass())
		elseif data.DrawOnEquip then
			wep.nzIsDrawing = true
			wep:SetNW2Bool("nzIsDrawing", true)
			self:SetUsingSpecialWeapon(true)
			self:SetActiveWeapon(nil)
			self:SelectWeapon(wep:GetClass())
			//wep:Deploy()
		end
	end

	-- This hook only works server-side
	hook.Add("WeaponEquip", "nzSetSpecialWeapons", function(wep)
		if not wep:IsSpecial() then return end
		-- 0 second timer for the next tick where wep's owner is valid
		timer.Simple(0, function()
			local ply = wep:GetOwner()
			if not IsValid(ply) then return end
			ply:AddSpecialWeapon(wep)
		end)
	end)

	hook.Add("PlayerCanPickupWeapon", "nzSpecialWeaponReplacer", function(ply, wep)
		if not IsValid(ply) or not IsValid(wep) or not wep:IsSpecial() then return end
		local oldwep = ply:GetSpecialWeaponFromCategory(wep:GetSpecialCategory())
		if IsValid(oldwep) then
			ply:StripWeapon(oldwep:GetClass())
		end
	end)
end

-- Players switching to special weapons can then no longer switch away until its action has been completed
function GM:PlayerSwitchWeapon(ply, oldwep, newwep)
	if IsValid(oldwep) and IsValid(newwep) then
		if !oldwep:IsSpecial() then
			if oldwep != newwep then
				ply.NZPrevWep = oldwep -- Store previous weapon if it's not special and not the same
			end
			ply:SetUsingSpecialWeapon(false)
		end

		if ply:GetUsingSpecialWeapon() then
			if oldwep:IsSpecial() then
				if oldwep.NZSpecialHolster then
					local allow = oldwep:NZSpecialHolster(newwep)
					if allow then
						ply:SetUsingSpecialWeapon(false)
					end
					return !allow -- With this function, it determines if we can holster
				else
					return true -- Otherwise we CAN'T get away from this weapon until SetUsingSpecialWeapon is false!
				end
			else -- Switching away from a non-sepcial when we have special set; reset it!
				ply:SetUsingSpecialWeapon(false)
				return false -- Allow
			end
		else -- Not using special weapons
			if newwep:IsSpecial() then -- Switching to a special one, turn Using Special on!
				local ammo = GetNZAmmoID(newwep:GetSpecialCategory())
				if !ammo or ply:GetAmmoCount(ammo) >= 1 then
					if SERVER then //this fixes holster/deploy prediction breaking after ever use of a specialwep
						local holster = oldwep.Holster
						oldwep.Holster = function() return true end -- Allow instant holstering
						timer.Simple(0, function() oldwep.Holster = holster end)
					end

					ply:SetUsingSpecialWeapon(true)
					return false -- We allow it when it's either not using ammo or we have enough
				else
					return true -- With ammo and less than 1 left, we don't switch :(
				end
			end
		end
	end
end