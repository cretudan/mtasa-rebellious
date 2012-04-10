g_base_col = createColCuboid ( 97.3376, 1800.0384, -32.0937, 250, 280, 120 )
createBlip ( 193.248, 1890.01, 17.234, 47 )

g_root = getRootElement ()

--rocketOne = createMarker ( -2931.5136, 454.4492, 17.3671, "corona", 1.5, 255, 0, 0, 150 ) --test marker
--rocketTwo = createMarker ( -2931.5932, 487.1994, 17.3671, "corona", 1.5, 255, 0, 0, 150 ) --test marker

function hit ( pla, dim, hitElement )
	if getElementType ( pla ) == "player" then
	local vehicle = getPedOccupiedVehicle ( pla )
		if vehicle or not vehicle then
			local account = getPlayerAccount ( pla )
                        if isObjectInACLGroup( 'user.'..getAccountName( account ), aclGetGroup( 'SuperModerator' ) ) then
				outputChatBox ( "Welcome to The Admin-Base, "..getPlayerName(pla).."!", pla, 0, 150, 0 )
			else
				setElementData ( pla, "inRestrictedArea", "true" )
				triggerClientEvent ( pla, "destroyTrepassor", g_root, pla )
				outputChatBox ( "***Restricted Area***", pla, 255, 0, 0 )
				outputChatBox ( "* "..getPlayerName(pla).." has entered the admin-Base Get Out Of Your Are DEAD!!", g_root, 255, 0, 0 )
			end
		end
	end
end
addEventHandler ( "onColShapeHit", g_base_col, hit )

function leave ( pla, dim )
	if getElementType ( pla ) == "player" then
	local vehicle = getPedOccupiedVehicle ( pla )
		if vehicle or not vehicle then
			local account = getPlayerAccount ( pla )
                        if isObjectInACLGroup( 'user.'..getAccountName( account ), aclGetGroup( 'SuperModerator' ) ) then
				outputChatBox ( "Good Bye!", pla, 0, 100, 0 )
			else
				setElementData ( pla, "inRestrictedArea", "false" )
				triggerClientEvent ( pla, "destroyTimers", g_root, pla )
				outputDebugString ( "*"..getPlayerName(pla).." has left col shape" )
			end
		end
	end
end
addEventHandler ( "onColShapeLeave", g_base_col, leave )