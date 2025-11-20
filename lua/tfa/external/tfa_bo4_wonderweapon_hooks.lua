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

if SERVER then
	hook.Add("EntityTakeDamage", "FOXBO4.TFA.WW.FreezeFix", function(ent, dmginfo)
		if not IsValid(ent) then return end
		if not (ent:IsNPC() or ent:IsNextBot()) then return end

		if ent:BO4IsFrozen() and (dmginfo:GetDamage() >= ent:Health()) then
			if ent:IsNPC() and ent:GetCurrentSchedule() == SCHED_NPC_FREEZE then
				ent:SetSchedule(SCHED_ALERT_STAND)
			end

			if dmginfo:IsDamageType(bit.bor(DMG_SLASH, DMG_CLUB, DMG_CRUSH)) then
				ent:GetNW2Entity("BO4.WintersLogic"):Explode()
			end
		end
	end)

	hook.Add("CreateEntityRagdoll", "FOXBO4.TFA.WW.Shatter_Server", function(ent, ragdoll)
		if ent:BO4IsFrozen() and not ent:IsPlayer() then
			ragdoll:Remove()
		end
	end)
end

if CLIENT then
	hook.Add("CreateClientsideRagdoll", "FOXBO4.TFA.WW.Shatter_Client", function(ent, ragdoll)
		if ent:BO4IsFrozen() and not ent:IsPlayer() then
			ragdoll:Remove()
		end
	end)

	hook.Add("RenderScreenspaceEffects","FOXBO4.TFA.WW.Overlays",function()
		local ply = LocalPlayer()
		if not IsValid(ply) then return end

		if ply:BO4IsFrozen() then
			DrawMaterialOverlay( "vgui/overlay/i_frost_r.png", -0.06 )
		end

		if ply:BO4IsStealth() then
			DrawMaterialOverlay( "effects/invuln_overlay_red", -0.06 )
		end
	end)
end