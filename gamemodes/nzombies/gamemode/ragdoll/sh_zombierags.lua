
local function cleanrag(ent, ragdoll, time)
	local dTime = math.random(time * 0.75, time * 1.25)
	
	if ent.GetDecapitated and ent:GetDecapitated() then
		local bone = ragdoll:LookupBone("ValveBiped.Bip01_Head1")
		if not bone then bone = ragdoll:LookupBone("j_head") end
		
		if bone then
			ragdoll:ManipulateBoneScale(bone, Vector(0.00001,0.00001,0.00001))
			--- Y GMOD YYYYYYYY I DONT UNDERSTAND
			--because, it's real dumb
			ragdoll:ManipulateBoneScale(bone, Vector(0.00001,0.00001,0.00001))
		end
	end
	
	if ragdoll:GetClass() ~= "class C_HL2MPRagdoll" or SERVER then SafeRemoveEntityDelayed(ragdoll, dTime + 2.5) end
end

if CLIENT then
	if not ConVarExists("nz_client_ragdolltime") then CreateConVar("nz_client_ragdolltime", 30, {FCVAR_ARCHIVE}, "How long clientside Zombie ragdolls will stay in the map.") end
	
	function GM:CreateClientsideRagdoll(ent, ragdoll)
		local convar = GetConVar("nz_client_ragdolltime"):GetInt()
		
		cleanrag(ent, ragdoll, convar)
	end
else
	if not ConVarExists("nz_server_ragdolltime") then CreateConVar("nz_server_ragdolltime", 30, {FCVAR_ARCHIVE}, "How long serverside Zombie ragdolls will stay in the map.") end
	
	function GM:CreateEntityRagdoll(ent, ragdoll)
		local convar = GetConVar("nz_server_ragdolltime"):GetInt()
		
		cleanrag(ent, ragdoll, convar)
	end
end