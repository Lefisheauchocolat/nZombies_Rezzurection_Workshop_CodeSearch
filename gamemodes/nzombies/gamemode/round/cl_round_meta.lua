function nzRound:GetState() return self.State end
function nzRound:SetState( state ) self.State = state end

function nzRound:GetNumber() return self.Number or 0 end
function nzRound:SetNumber( num ) self.Number = num end

function nzRound:IsSpecial() return self.SpecialRound or false end
function nzRound:SetSpecial( bool ) self.SpecialRound = bool end

function nzRound:InState( state )
	return nzRound:GetState() == state
end

function nzRound:InProgress()
	return nzRound:GetState() == ROUND_PREP or nzRound:GetState() == ROUND_PROG
end


function nzRound:GetStartMusic()
	self.RndMusic = self.RndMusic or false
	return self.RndMusic
end

function nzRound:EnableRndMusic()
	self.RndMusic = true
end

function nzRound:DisableRndMusic()
	self.RndMusic = false
end
