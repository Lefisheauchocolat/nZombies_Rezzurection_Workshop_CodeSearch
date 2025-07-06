local nzombies = engine.ActiveGamemode()

local zmhud_filter_zombieblood = Material("materials/nz_moo/huds/t7/i_generic_filter_zombie_blood_d.png", "unlitgeneric smooth noclamp")
local zmhud_filter_zombieblood_2 = Material("materials/nz_moo/huds/t7/i_generic_filter_zombie_blood_c.png", "unlitgeneric smooth noclamp")
local blur_mat = Material("pp/bokehblur")

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_brightness"] = 0.0,
	["$pp_colour_contrast"] = 1.0,
	["$pp_colour_colour"] = 1.0,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0,
}

local function MyDrawBokehDOF(fac)
	render.UpdateScreenEffectTexture()
	render.UpdateFullScreenDepthTexture()
	blur_mat:SetTexture("$BASETEXTURE", render.GetScreenEffectTexture())
	blur_mat:SetTexture("$DEPTHTEXTURE", render.GetResolvedFullFrameDepth())
	blur_mat:SetFloat("$size", fac * 5)
	blur_mat:SetFloat("$focus", 1)
	blur_mat:SetFloat("$focusradius", 60*fac)
	render.SetMaterial(blur_mat)
	render.DrawScreenQuad()
end

local bloodtime = 0
local bloody = false
local function DrawColorModulation()
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

end

local p1pos = 0
local p2pos = 0
local function DrawThrasherOverlay()
	local ply = LocalPlayer()
	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

	if ply:NZIsThrasherVictim() then
		local w, h = ScrW(), ScrH()
		local scale = (w/1920 + 1)/2

		p1pos = p1pos + FrameTime()*0.1
		if p1pos > 1 then p1pos = 0 end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(zmhud_filter_zombieblood)
		surface.DrawTexturedRectUV(0, 0, w, h, 0, 0+p1pos, 1, 1+p1pos)

		p2pos = p2pos + FrameTime()*0.4
		if p2pos > 1 then p2pos = 0 end

		surface.SetDrawColor(color_white)
		surface.SetMaterial(zmhud_filter_zombieblood_2)
		surface.DrawTexturedRectUV(0, 0, w, h, 0, 0+p2pos, 1, 1+p2pos)
	end
end

hook.Add("HUDPaint", "DrawThrasherOverlay", DrawThrasherOverlay)

hook.Add("RenderScreenspaceEffects", "nz.Status.Overlay", function()
	if not nzombies then hook.Remove("RenderScreenspaceEffects", "nz.Status.Overlay") end

	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	if IsValid(ply:GetObserverTarget()) then ply = ply:GetObserverTarget() end

	if ply:NZIsThrasherVictim() then
		tab["$pp_colour_mulr"] = 1
		tab["$pp_colour_mulg"] = 0
		tab["$pp_colour_addr"] = 0.15
		tab["$pp_colour_addg"] = 0.1
		DrawColorModify(tab)
		if not bloody then
			bloody = true
			bloodtime = CurTime() + 0.6
		end
	elseif bloody then
		bloody = false
		bloodtime = CurTime() + 1.2
	end

	if bloodtime > CurTime() then
		local fac = math.Clamp((bloodtime - CurTime()) / 1, 0, 1)
		MyDrawBokehDOF(fac)
	end
end)

if SERVER then
    hook.Add("Move", "nz.TrasherMove", function(ply, mv)
		if not nzombies then hook.Remove("Move", "nz.TrasherMove") end
        if ply:NZIsThrasherVictim() and ply.ThrasherParent and IsValid(ply.ThrasherParent) then
            local ent = ply.ThrasherParent
            local velocity = ent:GetVelocity()

            local halfTickInterval = engine.TickInterval() * 0.5
            velocity = velocity * halfTickInterval

            mv:SetOrigin(ent:EyePos())
            mv:SetVelocity(velocity - math.max(1, ply:GetGravity()) * physenv.GetGravity() * halfTickInterval)
        end
    end)

    --[[hook.Add("Move", "nz.MimicMove", function(ply, mv)
		if not nzombies then hook.Remove("Move", "nz.MimicMove") end
        if ply:NZIsMimicGrab() and ply.MimicParent and IsValid(ply.MimicParent) then

            local ent = ply.MimicParent
            local velocity = ent:GetVelocity()

            local attach = ent:GetAttachment(ent:LookupAttachment("player_attach"))
            local eyeattach = ent:GetAttachment(ent:LookupAttachment("jaw_fx_tag"))

            local halfTickInterval = engine.TickInterval() * 0.5
            velocity = velocity * halfTickInterval

            mv:SetOrigin(attach.Pos - Vector(0,0,30))
            ply:SetEyeAngles((eyeattach.Pos - ply:GetShootPos()):Angle())
            mv:SetVelocity(velocity - math.max(1, ply:GetGravity()) * physenv.GetGravity() * halfTickInterval)
        end
    end)]]
    hook.Add("Move", "nz.MimicMove", function(ply, mv)
		if not nzombies then hook.Remove("Move", "nz.MimicMove") end
        if ply:NZIsMimicGrab() and ply.MimicParent and IsValid(ply.MimicParent) then
        	local ent = ply.MimicParent

	        if ent:GetMoveType() == MOVETYPE_NONE then
	            return
	        end

	        local velocity = ent:GetVelocity()

	        local attach = ent:GetAttachment(ent:LookupAttachment("player_attach"))
	        local eyeattach = ent:GetAttachment(ent:LookupAttachment("jaw_fx_tag"))

	        local pos = attach.Pos - Vector(0,0,30)

	        if not ply:Alive() or ply:GetMoveType() ~= MOVETYPE_WALK then
	            mv:SetVelocity(velocity)
	            return
	        end

	        local halfTickInterval = engine.TickInterval() * 0.5
	        velocity = velocity * halfTickInterval

	        local mins, maxs = ply:GetCollisionBounds()
	        mins[3] = maxs[3]/2

	        if util.TraceHull({start = pos, endpos = pos - velocity, filter = {ply, ent}, mins = mins, maxs = maxs}).HitWorld then
	            ply:Fire("ignorefalldamage","",0)
	            return
	        end

	        mv:SetOrigin(pos)
            ply:SetEyeAngles((eyeattach.Pos - ply:GetShootPos()):Angle())
	        mv:SetVelocity(velocity - math.max(1, ply:GetGravity()) * physenv.GetGravity() * halfTickInterval)
	    end
    end)
end

hook.Add("SetupMove", "nz.Bleeding.SetupMove", function(ply, mv, cmd)
	if ply:NZIsBleedingVictim() and ply:GetNotDowned() then
		ply:SetDSP(32, false)
		mv:SetMaxClientSpeed(100)
	end
end)

hook.Add("StartCommand", "nz.TrasherBlockCMD", function(ply, cmd)
	if not nzombies then hook.Remove("StartCommand", "nz.TrasherBlockCMD") end
    if ply:NZIsThrasherVictim() then
        cmd:RemoveKey(IN_SPEED)
        cmd:RemoveKey(IN_JUMP)
        cmd:RemoveKey(IN_DUCK)
        cmd:RemoveKey(IN_ATTACK)
        cmd:RemoveKey(IN_ATTACK2)
        cmd:ClearMovement()
    end
end)

hook.Add("StartCommand", "nz.MimicBlockCMD", function(ply, cmd)
	if not nzombies then hook.Remove("StartCommand", "nz.MimicBlockCMD") end
    if ply:NZIsMimicGrab() then
        cmd:RemoveKey(IN_SPEED)
        cmd:RemoveKey(IN_JUMP)
        cmd:RemoveKey(IN_DUCK)
        cmd:RemoveKey(IN_ATTACK)
        cmd:RemoveKey(IN_ATTACK2)
        cmd:ClearMovement()
    end
end)