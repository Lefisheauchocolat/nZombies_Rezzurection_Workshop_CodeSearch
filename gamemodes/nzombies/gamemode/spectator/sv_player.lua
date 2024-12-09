--Get the meta Table
local plyMeta = FindMetaTable( "Player" )
--accessors
AccessorFunc( plyMeta, "iSpectatingID", "SpectatingID", FORCE_NUMBER )
AccessorFunc( plyMeta, "iSpectatingType", "SpectatingType", FORCE_NUMBER )

function plyMeta:SetSpectator()
	if self:Alive() then
		self:SetPreventPerkLoss(false)
		self:RemovePerks(true)
		self:RemoveUpgrades()

		self.OldWeapons = nil
		self.OldUpgrades = nil
		self.OldPerks = nil

		self:SetPoints(0)
		self:SetTotalRevives(0)
		self:SetTotalDowns(0)
		self:SetTotalKills(0)

		self:SetFrags(0)
		self:KillSilent()
	end
	self:SetTeam( TEAM_SPECTATOR )
	self:SetSpectatingType( OBS_MODE_CHASE )
	self:Spectate( self:GetSpectatingType() )
	self:SetSpectatingID( 1 )
end
