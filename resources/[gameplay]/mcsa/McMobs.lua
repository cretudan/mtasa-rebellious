--------------------------------------------------------------------------------------------------------------
-- McSA - 2012 MilchschniTTe - a.k.a MrMilchprodukT @ MTA:SA -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function SpawnCreeper()

	if MOBS_EnableCreepers == false then
		return
	end
	
	local pX, pY, pZ = getElementPosition(localPlayer)
	local rndSpawnX, rndSpawnY, SpawnZ = getElementPosition(localPlayer)
	
	while ( getDistanceBetweenPoints3D(pX,pY,pZ,rndSpawnX,rndSpawnY,SpawnZ) < 20.0 ) do
		rndSpawnX = math.random() * MOBS_SpawnDistance - (MOBS_SpawnDistance/2) + pX
		rndSpawnY = math.random() * MOBS_SpawnDistance - (MOBS_SpawnDistance/2) + pY
		SpawnZ = getGroundPosition(rndSpawnX, rndSpawnY, pZ + 50.0) + 1.5
	end
	
	local uID = "X"..math.floor(pX).."R"..math.random(0,9999)
	
	triggerServerEvent("onCreeperSpawn", localPlayer, uID, rndSpawnX, rndSpawnY, SpawnZ)
end

function UpdateCreeper( theCreeper )
	if ( isElement(theCreeper) == false ) then
		return -- Creeper does NOT exist anymore
	end
	local pX, pY, pZ = getElementPosition(localPlayer)
	local cX, cY, cZ = getElementPosition(theCreeper)
	local rZ = findRotation(cX, cY, pX, pY)
	setPedRotation(theCreeper, rZ)
	if ( getElementHealth(theCreeper) < 1.00 ) then
		callServerFunction("destroyMob", theCreeper)
		return
	end
	
	if ( getDistanceBetweenPoints3D(pX, pY, pZ, cX, cY, cZ) < 4.0 ) then
		PlayFuse3D(cX, cY, cZ)
	end
	
	if ( getDistanceBetweenPoints3D(pX, pY, pZ, cX, cY, cZ) < 2.0 ) then
		callServerFunction("explodeMob", theCreeper)
	end
	
	if ( getDistanceBetweenPoints3D(pX, pY, pZ, cX, cY, cZ) > 100.0 ) then
		callServerFunction("destroyMob", theCreeper)
	end
	
	if ( getElementSpeed(theCreeper, "kph") < 0.25 ) then
		setPedControlState( theCreeper, "jump", true )
	else
		setPedControlState( theCreeper, "jump", false )
	end
	
	setTimer(UpdateCreeper, 50, 1, theCreeper)
end

function EnableCreeper( theCreeper )
	setPedControlState( theCreeper, "forwards", true )
	if ( MOBS_HSLevel == 1 ) then
		setPedControlState( theCreeper, "walk", true )
	end
	if ( MOBS_HSLevel == 3 ) then
		setPedControlState( theCreeper, "sprint", true )
	end
end

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

function SpawnMobsRandomly()
	local h, m = getTime()
	local rnd = math.random(1,100)
	-- Creepy Kreepah?
	if ( h > 20 ) or ( h < 6 ) then
		if ( rnd <= MOBS_Spawnrate ) then
			SpawnCreeper()
		end
	end
end

function EnableMobSpawn()
	setTimer(SpawnMobsRandomly, 1000, 0)
end

addCommandHandler ( "mc_creeper", SpawnCreeper, false, false )

addEvent("onCreeperEnable", true)
addEventHandler("onCreeperEnable", getRootElement(), EnableCreeper)

addEvent("onCreeperEnableUpdate", true)
addEventHandler("onCreeperEnableUpdate", getRootElement(), UpdateCreeper)

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), SpawnMobsRandomly)
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), EnableMobSpawn)