-- =================
-- Car Locks ( server )
-- by vick.
-- =================

-- player element data --
	-- cl_ownedvehicle
-- vehicle element data --
	-- cl_vehicleowner
	-- cl_vehiclelocked
	-- cl_enginestate


-- resource starts - ends
function initCarLocks ()
	-- Initilize Player Element Data
	local players = getElementsByType ( "player" )
	for k,p in ipairs(players) do
		removeElementData ( p, "cl_ownedvehicle" )
		bindKey ( p, "l", "down", doToggleLocked )
	end

	-- Initilize Vehicle Element Data
	local vehicles = getElementsByType ( "vehicle" )
	for k,v in ipairs(vehicles) do
		removeElementData ( v, "cl_vehicleowner" )
		removeElementData ( v, "cl_vehiclelocked" )
		removeElementData ( v, "cl_enginestate" )
		setVehicleLocked ( v, false )
		setVehicleOverrideLights ( v, 0 )
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), initCarLocks )
addEventHandler ( "onResourceStop", getResourceRootElement ( getThisResource () ), initCarLocks )

-- player joins
function cl_PlayerJoin ( )
bindKey ( source, "l", "down", doToggleLocked )

end
addEventHandler ( "onPlayerJoin", getRootElement(), cl_PlayerJoin )

-- player quits
function cl_PlayerQuit ( )
	-- check for owned car
	local ownedVehicle = getElementData ( source, "cl_ownedvehicle" )
	if (ownedVehicle ~= false) then
		cl_RemoveVehicleOwner ( ownedVehicle )
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), cl_PlayerQuit )

-- player dies
function cl_PlayerWasted ( )
	-- check for owned car
	local ownedVehicle = getElementData ( source, "cl_ownedvehicle" )
	if (ownedVehicle ~= false) then
		cl_RemoveVehicleOwner ( ownedVehicle )
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), cl_PlayerWasted )

-- player tries to enter vehicle
function cl_VehicleStartEnter ( enteringPlayer, seat, jacked )
	local theVehicle = source
	local theOwner
	-- locked and not owner entering
	if ( getElementData ( theVehicle, "cl_vehiclelocked" ) == true ) then
		theOwner = getElementData ( theVehicle, "cl_vehicleowner" )
		if theOwner ~= false and theOwner ~= enteringPlayer then
			-- make sure they dont enter
			--cancelEvent();
		end
	 end
end
addEventHandler ( "onVehicleStartEnter", getRootElement(), cl_VehicleStartEnter )

-- player enters a vehicle
function cl_PlayerDriveVehicle ( player, seat, jacked )
	-- Driver Enter
	if ( seat == 0 ) then
		oldVehicle = getElementData ( player, "cl_ownedvehicle" )
		-- not entering player's own owned vehicle
		if ( (cl_VehicleLocked(source) == true) and (cl_VehicleOwner(source) ~= player) ) then
			removePlayerFromVehicle( player )
			Err_Msg("this vehicle is locked.", player)
			return false
		end
		-- set element data for vehicle and owner
		cl_SetVehicleOwner ( source, player )
	end
	return true
end
addEventHandler ( "onVehicleEnter", getRootElement(), cl_PlayerDriveVehicle )

-- vehicle respawns
function cl_VehicleRespawn ( exploded ) 
	cl_RemoveVehicleOwner ( source )
end
addEventHandler ( "OnVehicleRespawn", getRootElement(), cl_VehicleRespawn )

-- vehicle explosion
function cl_VehicleExplode ( )
	local theOwner = getElementData ( source, "cl_vehicleowner" )
	if ( theOwner ~= false ) then
		cl_RemoveVehicleOwner ( source )
	end
end
addEventHandler ( "onVehicleExplode", getRootElement(), cl_VehicleExplode )

-- set vehicle owner
function cl_SetVehicleOwner ( theVehicle, thePlayer )
	local oldVehicle = getElementData ( thePlayer, "cl_ownedvehicle" )
	if ( oldVehicle ~= false ) then
		-- unlock old car		
		removeElementData ( oldVehicle, "cl_vehicleowner" )
		removeElementData ( oldVehicle, "cl_vehiclelocked" )
		removeElementData ( oldVehicle, "cl_enginestate" )
		setVehicleLocked ( oldVehicle, false ) 
		-- set vars for new car
	end
	setElementData ( theVehicle, "cl_vehicleowner", thePlayer )
	setElementData ( theVehicle, "cl_vehiclelocked", false )
	setElementData ( thePlayer, "cl_ownedvehicle", theVehicle )
	setElementData( theVehicle, "cl_enginestate", true )

end

function cl_RemoveVehicleOwner ( theVehicle )
	local theOwner = getElementData ( theVehicle, "cl_vehicleowner" )
	if ( theOwner ~= false ) then
		removeElementData ( theOwner, "cl_ownedvehicle" )
		removeElementData ( theVehicle, "cl_vehicleowner" )
		removeElementData ( theVehicle, "cl_vehiclelocked" )
		removeElementData ( owned, "cl_enginestate" )
	end
	setVehicleLocked ( theVehicle, false )

end

-- flash the lights twice
function cl_FlashLights ( thePlayer )
	setTimer ( doToggleLights, 300, 4, thePlayer, true )
end

-- flash once
function cl_FlashOnce ( thePlayer )
	setTimer ( doToggleLights, 300, 2, thePlayer, true )
end

-- get vehicle owner ( according to vehicle's element data )
function cl_VehicleOwner ( theVehicle )
	return getElementData( theVehicle, "cl_vehicleowner" )

end
-- is vehicle locked ( according to vehicle's element data )
function cl_VehicleLocked ( theVehicle )
	return getElementData( theVehicle, "cl_vehiclelocked" )
end
-- messaging functions
-- send red error message
function Err_Msg ( strout, thePlayer )
	outputChatBox ( strout, thePlayer, 200, 0, 10 )
end

-- send message to all occupants of vehicle
function Car_Msg ( strout, theVehicle )
	numseats = getVehicleMaxPassengers ( theVehicle )
	for s = 0, numseats do
		local targetPlayer = getVehicleOccupant ( theVehicle, s )
		if targetPlayer ~= false then
			outputChatBox ( strout, targetPlayer, 30, 144, 255 )
		end
	end
end
-- send aquamarine message to player
function Info_Msg ( strout, thePlayer )
	outputChatBox ( strout, thePlayer, 102, 205, 170 )
end

-- commands 
function doToggleLocked ( source )
	local theVehicle , strout
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end

	if ( theVehicle ) then
		local vehiclename = getVehicleName ( theVehicle )
		-- already locked
		if ( getElementData ( theVehicle, "cl_vehiclelocked") == true ) then
			doUnlockVehicle ( source )
		else 
			doLockVehicle ( source )
		end
	else
		Err_Msg("You must have a vehicle to lock or unlock it.", source)
	end
end	

function doLockVehicle ( source )
	local theVehicle , strout
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end

	if ( theVehicle ) then
		local vehiclename = getVehicleName ( theVehicle )
		-- already locked
		if ( getElementData ( theVehicle, "cl_vehiclelocked") == true ) then
			strout = "Your " .. vehiclename .. " is already locked." 
			Err_Msg(strout, source)
		else 
			setElementData ( theVehicle, "cl_vehiclelocked", true)
			setVehicleLocked ( theVehicle, true ) 
			Car_Msg( "current vehicle " .. vehiclename .. " locked.", theVehicle)
			Info_Msg ( "locked vehicle " .. vehiclename .. ".", source )
			if ( getVehicleController ( theVehicle ) == false ) then
				cl_FlashLights ( source )
			end
		end
	else
		Err_Msg("You must have a vehicle to lock it.", source)
	end
end

function doUnlockVehicle ( source )
	local theVehicle, strout
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end
	if ( theVehicle ) then
	local vehiclename = getVehicleName ( theVehicle )
		if ( getElementData ( theVehicle, "cl_vehiclelocked") == false ) then
			strout = "Your " .. vehiclename .. " is already unlocked."
			Err_Msg(strout, source)
		else
			setElementData ( theVehicle, "cl_vehiclelocked", false)
			setVehicleLocked ( theVehicle, false )
			Car_Msg( "current vehicle " .. vehiclename .. " unlocked.", theVehicle )
			Info_Msg ( "unlocked vehicle " .. vehiclename .. ".", source )
			if ( getVehicleController ( theVehicle ) == false ) then
				cl_FlashOnce ( source )
			end
		end
	else
		Err_Msg("You must have a vehicle to unlock it.", source)
	end
end

function doToggleLights ( source, beep )
	local theVehicle 
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end
	if ( theVehicle ) then
		-- if he was in one
		if ( getVehicleOverrideLights ( theVehicle ) ~= 2 ) then  -- if the current state isn't 'force on'
            setVehicleOverrideLights ( theVehicle, 2 )            -- force the lights on
			-- play sound close to element
			if ( beep == true ) then
				local theElement = theVehicle
				triggerClientEvent ( getRootElement(), "onPlaySoundNearElement", getRootElement(), theElement, 5)
			end
        else
            setVehicleOverrideLights ( theVehicle, 1 )            -- otherwise, force the lights off
        end
	else
		Err_Msg("You must have a vehicle to control the lights.", source )
    end
end

function doToggleEngine ( source )
	local theVehicle
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "cl_ownedvehicle" )
	end
	if ( theVehicle ) then
		-- off or not set
		local lights = getVehicleOverrideLights ( theVehicle )
		if ( getElementData( theVehicle, "cl_enginestate" ) == false )  then
			setElementData( theVehicle, "cl_enginestate", true)
			setVehicleEngineState( theVehicle, true )
		else -- on -- set to off
			setElementData( theVehicle, "cl_enginestate", false )
			setVehicleEngineState( theVehicle, false )
		end
		setVehicleOverrideLights ( theVehicle, lights )
	else
		Err_Msg("You must have a vehicle to control the engine.", source )
	end
end

addCommandHandler ( "engine", doToggleEngine )
addCommandHandler ( "lights", doToggleLights, false)
addCommandHandler ( "lock", doLockVehicle )
addCommandHandler ( "unlock", doUnlockVehicle )


