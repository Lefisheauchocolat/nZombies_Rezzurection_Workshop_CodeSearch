include("shared.lua")

local nzombies = engine.ActiveGamemode() == "nzombies"
local glow = Material("sprites/wallbuy_light") --"sprites/light_ignorez"
local glowcolor = Color(0, 200, 255, 20)
local chalkcol = color_white
local glowsizew, glowsizeh, alpha = 128, 42, 30

function ENT:Draw()
	if self:GetUsed() then return end

	local eyepos = EyePos()
	local eyeang = EyeAngles()

	if nzMapping.Settings.wallbuydata and nzMapping.Settings.wallbuydata["glow"] ~= glowcolor then
		local glow_path = nzMapping.Settings.wallbuydata["material"]
		if glow_path and file.Exists("materials/"..glow_path, "GAME") then
			glow = Material(glow_path)
		end

		chalkcol = nzMapping.Settings.wallbuydata["chalk"]
		glowsizew = nzMapping.Settings.wallbuydata["sizew"]
		glowsizeh = nzMapping.Settings.wallbuydata["sizeh"]
		glowcolor = nzMapping.Settings.wallbuydata["glow"]
		alpha = nzMapping.Settings.wallbuydata["alpha"]

		if glow:IsError() then
			glow = Material("sprites/wallbuy_light")
		end
	end

	if (self.OutlineGiveUp and self.OutlineGiveUp > 5) then
		self:DrawModel()
	else
		local pos = eyepos + eyeang:Forward()*8
		local ang = eyeang
		ang = Angle(ang.p + 90, ang.y, 0)

		if halo.RenderedEntity() != self then
			render.ClearStencil()
			render.SetStencilEnable(true)
			render.SetStencilWriteMask(255)
			render.SetStencilTestMask(255)
			render.SetStencilReferenceValue(15)
			render.SetStencilFailOperation(STENCILOPERATION_KEEP)
			render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
			render.SetBlend(0)

			if !IsValid(self.ChalkCenter) then 
				self:RecalculateModelOutlines()
				self.OutlineGiveUp = self.OutlineGiveUp and self.OutlineGiveUp + 1 or 1
			else
				self.ChalkCenter:DrawModel()
			end

			render.SetBlend(1)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
			cam.Start3D2D(pos, ang, 1)
				surface.SetDrawColor(chalkcol)
				surface.DrawRect(-ScrW(),-ScrH(),ScrW()*2,ScrH()*2)
			cam.End3D2D()

			render.SetStencilEnable(false)
		end
	end

	local spriteang = self:GetFlipped() and self:GetAngles() + Angle(180,0,-90) or self:GetAngles() + Angle(0,90,90)
	render.SetMaterial(glow)
	render.DrawQuadEasy(self:GetPos(), spriteang:Up(), glowsizew, glowsizeh, ColorAlpha(glowcolor, alpha))

	//self:DrawModel()
end

function ENT:GetNZTargetText()
	if nzRound:InState(ROUND_CREATE) then
		return self.weaponname.." Chalk | Price "..string.Comma(self:GetPrice()).." | Point reward "..string.Comma(self:GetPoints())
	end

	if self:GetUsed() then return end
	return "Press "..string.upper(input.LookupBinding("+USE")).." - for "..self.weaponname.." Chalk"
end

local flipscale = Vector(1, 0.01, 1)
local normalscale = Vector(0.01, 1, 1)

function ENT:Initialize()
	self.Flipped = self:GetFlipped()
	local wep = weapons.Get(self:GetWepClass())
	if wep then
		self:RecalculateModelOutlines(wep)
	end
end

function ENT:RecalculateModelOutlines(wep)
	if !wep then
		wep = weapons.Get(self:GetWepClass())
	end
	if !wep then
		self:RemoveOutline()
		return
	end

	self:RemoveOutline()

	local ang = self:GetAngles()
	local curang = self:GetAngles()
	local curpos = self:GetPos()
	local model = wep.WM or wep.WorldModel

	self.modelclass = self:GetWepClass()
	self.weaponname = wep.PrintName
	self.NZHudIcon = wep.NZHudIcon

	self.ChalkCenter = ClientsideModel(model)
	self.ChalkCenter:SetPos(curpos)
	self.ChalkCenter:SetAngles(ang)
	self.ChalkCenter:SetMaterial("chalk.png")

	if self.Flipped == nil then
		self.Flipped = self:GetFlipped()
	end

	local mat = Matrix()
	mat:Scale(self.Flipped and flipscale or normalscale)

	self.ChalkCenter:EnableMatrix("RenderMultiply", mat)
	self.ChalkCenter:SetNoDraw(true)
	self.ChalkCenter:SetParent(self)

	/*chalkcol = color_white
	glowcolor = nzMapping.Settings.boxlightcolor
	alpha = 30

	if nzMapping.Settings.wallbuydata then
		local glow_path = nzMapping.Settings.wallbuydata["material"]
		if glow_path and file.Exists("materials/"..glow_path, "GAME") then
			glow = Material(glow_path)
		end

		chalkcol = nzMapping.Settings.wallbuydata["chalk"]
		glowsizew = nzMapping.Settings.wallbuydata["sizew"]
		glowsizeh = nzMapping.Settings.wallbuydata["sizeh"]
		glowcolor = nzMapping.Settings.wallbuydata["glow"]
		alpha = nzMapping.Settings.wallbuydata["alpha"]
	end

	if glow:IsError() then
		glow = Material("sprites/wallbuy_light")
	end*/
end

function ENT:RemoveOutline()
	if IsValid(self.ChalkCenter) then
		self.ChalkCenter:Remove()
	end
end

function ENT:Update()
	local wep = weapons.Get(self:GetWepClass())
	if wep then
		self:RecalculateModelOutlines()
	end
	self.OutlineGiveUp = 0
end

function ENT:Think()
	if self.Flipped != self:GetFlipped() then
		self.Flipped = self:GetFlipped()
		self:RecalculateModelOutlines()
	end
	if self.modelclass != self:GetWepClass() then
		self.modelclass = self:GetWepClass()
		self:Update()
	end
end

function ENT:Flashbangg()
	ParticleEffectAttach("nzr_chalks_poof", PATTACH_ABSORIGIN, self, 0)
	if DynamicLight then
		local dlight = DynamicLight(self:EntIndex(), false)
		if (dlight) then
			dlight.pos = self:WorldSpaceCenter()
			dlight.r = 10
			dlight.g = 10
			dlight.b = 10
			dlight.brightness = 0.5
			dlight.Decay = 500
			dlight.Size = 64
			dlight.DieTime = CurTime() + 1
		end
	end
end

function ENT:IsTranslucent()
	return true
end

function ENT:OnRemove()
	self:RemoveOutline()
end