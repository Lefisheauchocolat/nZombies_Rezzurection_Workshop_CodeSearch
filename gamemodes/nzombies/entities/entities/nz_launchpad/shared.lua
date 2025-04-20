
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

AddCSLuaFile()

--[Info]--
ENT.Type = "anim"
ENT.PrintName = "Launch Pad"
ENT.Author = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.bPhysgunNoCollide = true
ENT.DoNotDuplicate = true
ENT.DisableDuplicator = true
ENT.WireMat = Material( "cable/cable" )

local sp = game.SinglePlayer()

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Price")
	self:NetworkVar("Int", 1, "Flag")
	self:NetworkVar("Int", 2, "Cooldown")
	self:NetworkVar("Float", 0, "NextUse")
	self:NetworkVar("Float", 1, "AirTime")
	self:NetworkVar("Bool", 0, "Electric")
	self:NetworkVar("Bool", 1, "RequireActive")
end

function ENT:CoolingDown()
	return self:GetNextUse() > CurTime()
end

--Below function credited to CmdrMatthew
function ENT:getvel(pos, pos2, time) -- target, starting point, time to get there
    local diff = pos - pos2 --subtract the vectors
     
    local velx = diff.x/time -- x velocity
    local vely = diff.y/time -- y velocity
 
    local velz = (diff.z - 0.5*(-GetConVarNumber( "sv_gravity"))*(time^2))/time --  x = x0 + vt + 0.5at^2 conversion
     
    return Vector(velx, vely, velz)
end

function ENT:LaunchArc(pos, pos2, time, t) -- target, starting point, time to get there, fraction of jump
	local v = self:getvel(pos, pos2, time).z
	local a = (-GetConVarNumber( "sv_gravity"))
	local z = v*t + 0.5*a*t^2
	local diff = pos - pos2
	local x = diff.x*(t/time)
    local y = diff.y*(t/time)
	
	return pos2 + Vector(x, y, z)
end
