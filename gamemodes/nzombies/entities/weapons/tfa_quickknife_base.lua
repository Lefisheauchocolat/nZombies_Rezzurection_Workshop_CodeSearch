
-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

DEFINE_BASECLASS("tfa_bash_base")

local cv_damagemul = GetConVar("sv_tfa_quickknife_damage")
local cv_lunge = GetConVar("sv_tfa_quickknife_lunge")
local cl_defaultweapon = GetConVar("cl_defaultweapon")

SWEP.IsTFAQuickKnife = true
SWEP.ImpactDecal = "ManhackCut"
SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = ""
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.greasynuts = false
SWEP.KnifeLungeMult = 1
SWEP.KnifeLungeSpeed = 650
SWEP.ProceduralHolsterTime = 0

--SWEP.Secondary.Damage = 1050

if SWEP.Secondary.Damage then
	SWEP.Secondary.Damage = SWEP.Secondary.Damage * 1
end

SWEP.data = {}
SWEP.data.ironsights = 0

SWEP.Primary.DisplayFalloff = false
SWEP.CrosshairConeRecoilOverride = .05

SWEP.Secondary.CanBash = true
--SWEP.Secondary.BashDamage = SWEP.Secondary.Damage
SWEP.Secondary.BashLength = 60
SWEP.Secondary.BashHitLength = 100
SWEP.Secondary.BashDelay = 1/6
SWEP.Secondary.BashDamageType = DMG_SLASH
SWEP.Secondary.BashInterrupt = true
SWEP.Secondary.BashHit = true
SWEP.Secondary.BashHitSound_Lunge = SWEP.Secondary.BashHitSound_Flesh

SWEP.SprintBobMult = 0
SWEP.ProceduralHolsterTime = engine.TickInterval()

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables(self)

	self:NetworkVarTFA("Bool", "Lunging")
	self:NetworkVarTFA("Bool", "Stabbed")
end

function SWEP:AdjustMouseSensitivity()
	if self:GetLunging() then
		return 0.25
	end
	if self:GetStatus() == TFA.Enum.STATUS_BASHING_WAIT and self:GetStabbed() then
		return math.max(0.25, self:GetStatusProgress())
	end
end

local l_CT = CurTime
local sp = game.SinglePlayer()

function SWEP:Deploy(...)
	self.greasynuts = true
	return BaseClass.Deploy(self, ...)
end

function SWEP:AltAttack()
	--print("attack")
	local time = l_CT()
	if
		self:GetStatL("Secondary.CanBash") == false or
		not self:OwnerIsValid() or
		time < self:GetNextSecondaryFire()
	then return end

	local stat = self:GetStatus()
	if not TFA.Enum.ReadyStatus[stat] and not self:GetStatL("Secondary.BashInterrupt") or
		stat == TFA.Enum.STATUS_BASHING and self:GetStatL("Secondary.BashInterrupt") then return end

	if self:IsSafety() or self:GetHolding() then return end

	local retVal = hook.Run("TFA_CanBash", self)
	if retVal == false then return end

	local enabled, tanim, ttype = self:ChooseBashAnim()
	if not enabled then return end

	hook.Run("TFA_Bash", self)

	if self:GetOwner().Vox and IsFirstTimePredicted() then
		self:GetOwner():Vox("bash", 0)
	end

	if not sp or not self:IsFirstPerson() then
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end

	local bashend = self:GetStatL("Secondary.BashEnd")
	local nextTime = time + (bashend or self:GetActivityLength(tanim, false, ttype))

	self:SetNextPrimaryFire(nextTime)
	self:SetNextSecondaryFire(nextTime)

	if sp and SERVER then 
		self:EmitSoundNet(self:GetStatL("Secondary.BashSound"))
	elseif SERVER then
		self:EmitSoundSafe(self:GetStatL("Secondary.BashSound"))
	end

	self:ScheduleStatus(TFA.Enum.STATUS_BASHING, self:GetStatL("Secondary.BashDelay"))
	local ply = self:GetOwner()
	if IsValid(ply) and ply:IsPlayer() then
		ply:SetKnifingCooldown(self:GetStatusEnd())
	end

	hook.Run("TFA_PostBash", self)
end

function SWEP:ChooseBashAnim()
	if not self:GetStatL("Secondary.BashHit") then return BaseClass.ChooseBashAnim(self) end
	--print("choosebashanim")
	local ply = self:GetOwner()
	local pos = ply:GetShootPos()
	local aim = ply:GetAimVector()

	if ply:IsPlayer() then
		ply:LagCompensation(true)
	end

	local tr = util.TraceHull({
		start = pos,
		endpos = pos + (aim * self:GetStatL("Secondary.BashHitLength")),
		filter = ply,
		mins = Vector(-10, -5, 0),
		maxs = Vector(10, 5, 5),
		mask = MASK_SHOT_HULL,
	})

	if ply:IsPlayer() then
		ply:LagCompensation(false)
	end

	local ent = tr.Entity
	if IsValid(ent) and (ent:IsNPC() or ent:IsNextBot() or ent:IsPlayer()) then
		local speed = ply:GetVelocity():Length()
		local dist = ply:GetPos():DistToSqr(ent:GetPos())
		local range = self:GetStatL("Secondary.BashLength")
		local maxrange = self:GetStatL("Secondary.BashHitLength")
		local maxspeed = ply:GetRunSpeed() * 0.45
		local diff = maxrange - range

		
		range = math.Clamp((range + diff) * (speed/maxspeed), range, maxrange)
		if dist <= range^2 and speed > maxspeed and ply:KeyDown(IN_FORWARD) then
			self:SendViewModelAnim(ACT_VM_HITRIGHT)
			self:SetLunging(true)
			self:SetStabbed(true)
			if ent:Health() > 0 then
				ply:SetKnifeTarget(ent)
			end
			return true
		end
	end
	
	return BaseClass.ChooseBashAnim(self)
end

function SWEP:HandleBashAttack()
	local ply = self:GetOwner()
	local pos = ply:GetShootPos()
	local av = ply:GetAimVector()

	local ignoreClasses = {
		breakable_entry = true,
		breakable_entry_plank = true,
		invis_wall = true,
		wall_block = true,
		invis_wall_zombie = true,
		zombie_wall_block = true
	}

	local slash = {}
	slash.start = pos
	slash.endpos = pos + (av * self:GetStatL("Secondary.BashLength"))
	slash.filter = function(ent)
		if ent == ply then return false end
		local class = ent:GetClass()
		return not ignoreClasses[class]
	end
	slash.mins = Vector(-10, -5, 0)
	slash.maxs = Vector(10, 5, 5)

	local slashtrace = util.TraceHull(slash)
	local pain = self:GetStatL("Secondary.BashDamage")

	if not slashtrace.Hit then return end
	self:HandleDoor(slashtrace)

	if not (sp and CLIENT) then
		local soundToPlay

		if self:GetStabbed() and self:GetStatL("Secondary.BashHitSound_Lunge") then
			soundToPlay = self:GetStatL("Secondary.BashHitSound_Lunge")
		elseif slashtrace.MatType == MAT_FLESH or slashtrace.MatType == MAT_ALIENFLESH then
			soundToPlay = self:GetStatL("Secondary.BashHitSound_Flesh")
		else
			soundToPlay = self:GetStatL("Secondary.BashHitSound")
		end

		self:EmitSound(soundToPlay)
	end

	if CLIENT then return end

	local dmg = DamageInfo()
	dmg:SetAttacker(ply)
	dmg:SetInflictor(self)
	dmg:SetDamagePosition(pos)
	dmg:SetDamageForce(av * pain)
	dmg:SetDamage(pain)
	dmg:SetDamageType(self:GetStatL("Secondary.BashDamageType"))

	if IsValid(slashtrace.Entity) and slashtrace.Entity.TakeDamageInfo then
		slashtrace.Entity:TakeDamageInfo(dmg)
	end

	local ent = slashtrace.Entity
	if not IsValid(ent) or not ent.GetPhysicsObject then return end

	local phys
	if ent:IsRagdoll() then
		phys = ent:GetPhysicsObjectNum(slashtrace.PhysicsBone or 0)
	else
		phys = ent:GetPhysicsObject()
	end

	if IsValid(phys) then
		if ent:IsPlayer() or ent:IsNPC() then
			ent:SetVelocity(av * pain * 0.5)
			phys:SetVelocity(phys:GetVelocity() + av * pain * 0.5)
		else
			phys:ApplyForceOffset(av * pain * 0.5, slashtrace.HitPos)
		end
	end
end

function SWEP:Think2(...)
	local ply = self:GetOwner()
	local status = self:GetStatus()
	local statusend = CurTime() > self:GetStatusEnd()

	if self.greasynuts and TFA.Enum.ReadyStatus[status] then
		self.greasynuts = false
		self:AltAttack()
	end

	if not ply:GetKnifing() then
		if CLIENT and not sp then
			//if IsFirstTimePredicted() then
				self:SwitchToPreviousWeapon()
			//end
		elseif SERVER then
			self:CallOnClient("SwitchToPreviousWeapon", "")
		end
	end

	if status == TFA.Enum.STATUS_BASHING and statusend then
		ply.tfa_stalling_bash_hack = nil
		ply.tfa_bash_hack = false

		ply:SetKnifingCooldown(self:GetNextSecondaryFire() + 1)

		if self:GetLunging() then
			self:SetLunging(false)
		end
	end

	if status == TFA.Enum.STATUS_BASHING_WAIT and statusend then
		if self:GetStabbed() then
			self:SetStabbed(false)
		end

		ply:SetKnifing(false)
		ply:SetKnifingCooldown(CurTime() + 0.25)

		local baseThink2 = BaseClass.Think2(self, ...)

		local wep = self:GetOwner():GetKnifeBackup()

		self:FinishHolster()
		self:SetStatusEnd(0)

		if SERVER then
			ply:SetActiveWeapon(nil)
		end

		if CLIENT and not sp then
			//if IsFirstTimePredicted() then
				self:SwitchToPreviousWeapon()
			//end
		elseif SERVER then
			self:CallOnClient("SwitchToPreviousWeapon", "")
		end

			self.Owner:SetUsingSpecialWeapon(false)
			self.Owner:EquipPreviousWeapon()
		return baseThink2
	end

	return BaseClass.Think2(self)
end

function SWEP:SwitchToPreviousWeapon()
	local wep = self:GetOwner():GetKnifeBackup()

	if IsValid(wep) and wep:IsWeapon() and wep:GetOwner() == self:GetOwner() and wep:GetClass() ~= self:GetClass() then
		input.SelectWeapon(wep)
	-- supa redundant code that just bricks you
	-- else
	-- 	wep = self:GetOwner():GetWeapon(cl_defaultweapon:GetString())

	-- 	if IsValid(wep) then
	-- 		input.SelectWeapon(wep)
	-- 	else
	-- 		local _
	-- 		_, wep = next(self:GetOwner():GetWeapons())

	-- 		if IsValid(wep) then
	-- 			input.SelectWeapon(wep)
	-- 		end
	-- 	end
	end
end

-- Disable functions that should not be used
function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:CycleFireMode()
end

function SWEP:CycleSafety()
end

function SWEP:ToggleInspect()
end
