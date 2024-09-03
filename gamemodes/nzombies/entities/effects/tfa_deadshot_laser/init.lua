function EFFECT:Init(data)
end

function EFFECT:Think()
	return LocalPlayer():HasPerk("deadshot")
end

local vector_origin = Vector()

local att, angpos, pc
local col = Color(255, 0, 0, 255)
local laserline = Material("cable/smoke")
local laserdot = Material("effects/tfalaserdot")
local laserFOV = 1.5
local traceres

local render = render
local Material = Material
local ProjectedTexture = ProjectedTexture
local math = math

local function IsHolstering(wep)
	if IsValid(wep) and TFA.Enum.HolsterStatus[wep:GetStatus()] then return true end

	return false
end

function EFFECT:Render()
	local ply = LocalPlayer()
	if not IsValid(ply) then return end

	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return end

	local f = ply.GetNW2Vector or ply.GetNWVector
	pc = f(ply, "TFALaserColor", vector_origin)
	col.r = pc.x
	col.g = pc.y
	col.b = pc.z

	local angpos = ply:GetViewModel():GetAttachment(wep.LaserSightAttachment or 1)
	if wep.GetMuzzleAttachment and wep.OwnerViewModel and IsValid(wep.OwnerViewModel) then
		angpos = wep.OwnerViewModel:GetAttachment(wep:GetMuzzleAttachment())
	end

	local localProjAng = select(2, WorldToLocal(vector_origin, angpos.Ang, vector_origin, EyeAngles()))
	localProjAng.p = localProjAng.p * ply:GetFOV() / (wep.ViewModelFOV or ply:GetFOV())
	localProjAng.y = localProjAng.y * ply:GetFOV() / (wep.ViewModelFOV or ply:GetFOV())

	local wsProjAng = select(2, LocalToWorld(vector_origin, localProjAng, vector_origin, EyeAngles())) --reprojection for trace angle

	traceres = util.QuickTrace(ply:GetShootPos(), wsProjAng:Forward() * 999999, ply)

	local hpos = traceres.StartPos + angpos.Ang:Forward() * math.min(traceres.HitPos:Distance(angpos.Pos), wep.LaserDistanceVisual or 64)

	render.SetMaterial(laserline)
	render.SetColorModulation(1, 1, 1)
	render.StartBeam(2)
	col.r = math.sqrt(col.r / 255) * 255
	col.g = math.sqrt(col.g / 255) * 255
	col.b = math.sqrt(col.b / 255) * 255
	render.AddBeam(angpos.Pos, wep.LaserBeamWidth or 0.25, 0, col)
	col.a = 0
	render.AddBeam(hpos, 0, 0, col)
	render.EndBeam()
end