ENT.Type = "anim"

ENT.PrintName		= "Radio"
ENT.Author			= "Steve Jobs"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""
ENT.bPhysgunNoCollide = true

AddCSLuaFile()

local sp = game.SinglePlayer()

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Radio")
	self:NetworkVar("String", 1, "Flag")
	self:NetworkVar("Bool", 0, "Door")
	self:NetworkVar("Bool", 1, "NoModel")
	self:NetworkVar("Float", 0, "NextPlay")
end

function ENT:Initialize()
	local mdl = self:GetModel()
	if not mdl or mdl == "" or mdl == "models/error.mdl" then
		self:SetModel("models/nzr/song_ee/army_radio.mdl")
	end
	local snd = self:GetRadio()
	if not snd or snd == "" then
		self:SetRadio(Sound("ambient/levels/launch/rockettakeoffblast.wav"))
	end

	self:DrawShadow(!self:GetNoModel())
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)

	if CLIENT then return end
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
end

function ENT:Use(ply, call)
	local ct_ = sp and SysTime() or CurTime() //systime isnt effected by pausing in solo

	local creative = (ply:IsInCreative() or nzRound:InState(ROUND_CREATE))
	if !creative and self:GetNoModel() then return end
	if self:GetNextPlay() > ct_ then
		if creative then self:Reset() end
	return end

	self:Play()
end

function ENT:Play()
	local mySound = self:GetRadio()
	self:StopSound(mySound)
	self:EmitSound(mySound, SNDLVL_TALKING, 100, 1, CHAN_ITEM)

	local time = 0
	local ct_ = sp and SysTime() or CurTime()

	if nzSounds.SoundDuration then
		time = nzSounds:SoundDuration("sound/"..mySound)
	else
		time = SoundDuration(mySound)
	end
	if time <= 0 or time > 3600 then
		time = SoundDuration(mySound)
	end

	self:SetNextPlay(ct_ + time)
end

function ENT:Reset()
	self:SetNextPlay(0)
	self:StopSound(self:GetRadio())
end

function ENT:Draw()
	if LocalPlayer():IsInCreative() then
		local num = render.GetBlend()
		render.SetBlend(math.Rand(0.4,0.55))
		self:DrawModel()
		render.SetBlend(num)
	end

	if self:GetNoModel() then return end
	self:DrawModel()
end

function ENT:OnRemove()
	self:StopSound(self:GetRadio())
end

if CLIENT then
	function ENT:GetNZTargetText()
		local ply = LocalPlayer()
		if IsValid(ply:GetObserverTarget()) then
			ply = ply:GetObserverTarget()
		end

		if !(ply:IsInCreative() or nzRound:InState(ROUND_CREATE)) then return end

		local time = self:GetNextPlay()
		local ct_ = sp and SysTime() or CurTime()

		if time > ct_ then
			local timeleft = math.Round(time - ct_)
			local format = timeleft > 600 and "%02i:%02i" or "%i:%02i" //00:00 for > 10min, 0:00 otherwise
			return "["..string.FormattedTime(timeleft, format).."]"
		else
			return "Press "..string.upper(input.LookupBinding("+USE")).." - test"
		end
	end
end
