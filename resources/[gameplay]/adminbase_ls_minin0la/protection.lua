local nofly1 = createMarker( 1722.8520507813, -3341.5732421875, 12.17505645752,  "cylinder", 500, 0, 255, 0, 0 )
-- Define Marker


function noFlyZone ( hitElement )
if (getElementType(hitElement) == "player" ) then
if hasObjectPermissionTo( hitElement, "function.kickPlayer" ) then
outputChatBox( "** Entering admin airport **", hitElement, 0, 255, 0 )
else
outputChatBox( "** You do not have permission to enter **", hitElement, 255, 0, 0 )
setElementPosition( hitElement, 1431, -2699, 14 )
end
end

if (getElementType(hitElement) == "vehicle" )  then
	 local driver = getVehicleOccupant ( hitElement )
if ( driver ) then
if hasObjectPermissionTo( getVehicleOccupant( hitElement ), "function.kickPlayer" ) then
outputChatBox( "** Entering admin airport! **", hitElement, 0, 255, 0 )
else
outputChatBox( "** You do not have permission to enter **", hitElement, 255, 0, 0 )
setElementPosition( hitElement, 1431, -2699, 14 )
setVehicleFrozen( hitElement, true )
setVehicleFrozen( hitElement, false )
end
end
end
end
-- What happens when they enter the no-fly zone.

addEventHandler("onMarkerHit", root,
        function(...)
                if (source == nofly1) then setTimer(noFlyZone, 1500, 1, ...) end
        end
)
-- Do so 1 second after entering the no-fly zone
