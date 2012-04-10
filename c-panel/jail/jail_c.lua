function isPlayerInJail(thePlayer)
if getElementData(thePlayer,"arrested") then
	return true
	else
	return false
	end
end