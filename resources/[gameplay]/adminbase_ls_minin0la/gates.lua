local theMarker = createMarker ( 1660.2961425781, -2918.6540527344, 4.2936902046204,  "cylinder", 15, 0, 0, 255, 0 )
local gate = createObject ( 980, 1660.1441650391, -2920.7719726563, 7.1170854568481, 0, 0, 0 )
-- Define Marker and Gate

function openGate ( hitElement )
if (getElementType(hitElement) == "player" ) then
if hasObjectPermissionTo( hitElement, "function.kickPlayer" ) then
moveObject ( gate, 1500, 1660.1441650391, -2920.7719726563, 0.61708545684814, 0, 0, 0 )
else
outputChatBox ( "** You do not have permission to enter **", hitElement, 255, 0, 0 )
setElementPosition ( hitElement, 1442, -2693, 12.5 )
end
end
if (getElementType(hitElement) == "vehicle" ) then
if hasObjectPermissionTo( getVehicleOccupant( hitElement ), "function.kickPlayer" ) then
moveObject ( gate, 1500, 1660.1441650391, -2920.7719726563, 0.61708545684814, 0, 0, 0 )
else
outputChatBox ( "** You do not have permission to enter **", hitElement, 255, 0, 0 )
setElementPosition ( hitElement, 1442, -2693, 12.5 )
setVehicleFrozen( hitElement, true )
setVehicleFrozen( hitElement, false )
end
end
end
addEventHandler( "onMarkerHit", theMarker, openGate )
-- Open Gate

function closeGate ( leftElement )
if (getElementType(leftElement) == "player" ) then
moveObject ( gate, 1500, 1660.1441650391, -2920.7719726563, 7.1170854568481, 0, 0, 0 )
end
end
addEventHandler( "onMarkerLeave", theMarker, closeGate )
-- Close Gate
