AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:Initialize()
    print( "Natural Selection Gamemode Loaded" )
    resource.AddWorkshop( "1466867606" ) 
end


function GM:PlayerSpawn(ply)
	ply:SetPos(Vector(0,0,0))
	GAMEMODE:PlayerSpawnAsSpectator(ply)
	ply:Spectate( OBS_MODE_CHASE )
	
	if !ROUNDSTARTED then
		if #player.GetAll() > 1 then
            		timer.Simple(1, function()
                		StartRound()
            		end )
		end
	else
		ply:Spectate(OBS_MODE_ROAMING)
		
		for index, pl in pairs(player.GetAll()) do
			if IsValid(pl.Entity) then
				net.Start("SendStats")
					net.WriteEntity(pl)
					net.WriteTable(pl.stats)
				net.Send(ply)
			end
		end
		
	end
end
