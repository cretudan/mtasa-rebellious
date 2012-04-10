function exitJail(hitElement, matchingDimension)
	setElementInterior(hitElement, 0, 2291, 2429, 11)
end

function isPlayerInJail(player)
if getElementData(player,"arrested") then
	return true
	else
	return false
	end
end

function jailArrestPlayer(client, player)
if ( hasObjectPermissionTo ( client, "command.cpaneljail", true ) ) then
	if (isPlayerInJail(player)) then
	outputChatBox("#FF0000*INFO: #FFFF00".. getPlayerName(player) .." has been released by " .. getPlayerName(client), getRootElement(), 255, 255, 255, true)
	setElementInterior(player, 0)
	setElementData(player,"arrested",false)
	setElementPosition(player, 2291, 2429, 11)
	triggerClientEvent(client,"returnIsPlayer",client,"jail",getElementData(player,"arrested"))	
	else
	outputChatBox("#FF0000*INFO: #FFFF00".. getPlayerName(player) .." has been arrested by " .. getPlayerName(client), getRootElement(), 255, 255, 255, true)
	setElementInterior(player, get("jailInt"))
	setElementPosition(player, get("jailX"), get("jailY"), get("jailZ"), true)
	setElementData(player,"arrested",true)
	triggerClientEvent(client,"returnIsPlayer",client,"jail",getElementData(player,"arrested"))
	end
	else
	outputChatBox ("C-Panel: Access denied", client, 193, 13, 13)
	end
end
addEvent("arrestPlayer", true)
addEventHandler("arrestPlayer", getRootElement(), jailArrestPlayer)

addEventHandler("onPlayerWasted",getRootElement(),
function (ammo,killer)
if isPlayerInJail(source) then
setElementInterior(source, get("jailInt"))
setElementPosition(source, get("jailX"), get("jailY"), get("jailZ"), true)
outputChatBox("#FF0000*INFO: #FFFF00".. getPlayerName(source) .." has been auto arrested", getRootElement(), 255, 255, 255, true)
  end
end)