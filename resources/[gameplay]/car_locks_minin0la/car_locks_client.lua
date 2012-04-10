-- Car Locks ( client )

-- local player
localPlayer = getLocalPlayer ( )

-- playSoundNearElement
addEvent ( "onPlaySoundNearElement", true )
function playSoundNearElement ( theElement, sound )
--	local sound = 5
	local maxdist = 15.0
	-- valid element
	if ( theElement ) then
		local x,y,z = getElementPosition ( theElement )
		local x2,y2,z2 = getElementPosition ( localPlayer )
		local dist = getDistanceBetweenPoints3D ( x, y, z, x2, y2, z2 ) 
		-- distance is less than parameter maxdist
		if ( dist < maxdist ) then
			-- play parameter sound 
			playSoundFrontEnd ( 5 )
		--	outputChatBox ( "sound should play" )
		else
		--	outputChatBox ( "not in range" )
		end
	else
		-- outputChatBox ( "invalid element" )
	end
end
addEventHandler ( "onPlaySoundNearElement", getRootElement(), playSoundNearElement )
