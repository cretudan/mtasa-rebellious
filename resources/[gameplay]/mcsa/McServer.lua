--------------------------------------------------------------------------------------------------------------
-- McSA - 2012 MilchschniTTe - a.k.a MrMilchprodukT @ MTA:SA -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

Blocks = {} -- Array containing all currently placed blocks
BlockCount = 0 -- Something for constructing the array

CurrentPlacedBlocks = 0

bProtected = {} -- /protect Players
bOPs = {} -- /op Players

function overrideProtection ( thePlayer )
	if isObjectInACLGroup ( "user."..getPlayerName(thePlayer), aclGetGroup ( "Admin" ) ) then
		serial = getPlayerSerial(thePlayer)

		if not bOPs[serial] == true then
			bOPs[serial] = true
			outputChatBox  ( "#FFFFFFPROTECTION: #00C800Protection overriding enabled!", thePlayer, 0, 200, 0, true )
			return
		end
		
		if bOPs[serial] == true then
			bOPs[serial] = false
			outputChatBox  ( "#FFFFFFPROTECTION: #C80000Protection overriding disabled!", thePlayer, 200, 0, 0, true )
			return
		end	
	else -- Not an Admin
	outputChatBox ( "#FFFFFFPROTECTION: #C80000You have to be an Admin to use this Command!", thePlayer, 255, 255, 255, true )
	end
end

function protectPlayer ( thePlayer )
	if ( (PERMISSION_AllowProtection == false) and ( not isObjectInACLGroup ( "user."..getPlayerName(thePlayer), aclGetGroup ("Admin") ) ) ) then
		outputChatBox  ( "#FFFFFFPERMISSIONS: #00C800You dont have the needed permissions!", thePlayer, 0, 200, 0, true )
	end
	
	serial = getPlayerSerial(thePlayer)
	if not bProtected[serial] == true then
		bProtected[serial] = true
		outputChatBox  ( "#FFFFFFPROTECTION: #00C800Your Blocks are now protected!", thePlayer, 0, 200, 0, true )
		return
	end
	
	if bProtected[serial] == true then
		bProtected[serial] = false
		outputChatBox  ( "#FFFFFFPROTECTION: #C80000Your Blocks are NOT protected anymore!", thePlayer, 200, 0, 0, true )
		return
	end
end

function isProtected ( thePlayer )
	serial = getPlayerSerial(thePlayer)
	if bProtected[serial] == true then
		return true
	else
		return false
	end
end

addCommandHandler ( "mc_protect", protectPlayer, false, false )
addCommandHandler ( "mc_op", overrideProtection, false, false )

function placeBlock( BlockID, ObjID, x, y, z, rotation )

	if ( (PERMISSION_AllowPlace == false) and ( not isObjectInACLGroup ( "user."..getPlayerName(source), aclGetGroup ("Admin") ) ) ) then
		outputChatBox  ( "#FFFFFFPERMISSIONS: #00C800You dont have the needed permissions!", source, 0, 200, 0, true )
	end

	oX = x
	oY = y
	oZ = z

	if rotation == 90 then
		oX = x + 1
		oY = y
	end

	if rotation == 180 then
		oX = x + 1
		oY = y + 1
	end

	if rotation == 270 then
		oX = x
		oY = y + 1
	end

	--[[local ObjectsTBL = getElementsByType ( "object", getRootElement(), true )
	for k,v in pairs(ObjectsTBL) do
		if (getElementData(v, "mc.isMcBlock", false) == true) then
			local agpX, agpY, agpZ = getElementPosition(v)
			agpX = math.floor(agpX)
			agpY = math.floor(agpY)
			agpZ = math.floor(agpZ)
			
			if ( (agpX==math.floor(x)) and (agpY==math.floor(y)) and (agpZ==math.floor(z)) ) then
				-- Block already exist at that position... -- Prevent a glitch!
				-- return -- NOT WORKING AS IT SHOULD :(
			end
		end
	end]]-- Removed useless
	
	Blocks[BlockCount] = createObject ( ObjID, oX, oY, oZ, 0, 0, rotation )
	setElementData ( Blocks[BlockCount], "bCount", BlockCount, true )
	setElementData ( Blocks[BlockCount], "bID", BlockID, true )
	setElementData ( Blocks[BlockCount], "bOwner", getPlayerSerial(source), true )
	setElementData ( Blocks[BlockCount], "mc.isMcBlock", true, true )
	BlockCount = BlockCount + 1
	CurrentPlacedBlocks = CurrentPlacedBlocks + 1
end

function removeBlock ( theBlock )
	if ( (PERMISSION_AllowDestroy == false) and ( not isObjectInACLGroup ( "user."..getPlayerName(source), aclGetGroup ("Admin") ) ) ) then
		outputChatBox  ( "#FFFFFFPERMISSIONS: #00C800You dont have the needed permissions!", source, 0, 200, 0, true )
	end

	if ( theBlock == nil ) then
		return -- No block
	end
	
	if not ( getElementData(theBlock, "mc.isMcBlock") == true ) then
		return -- No McBlock
	end
	
	if getElementData ( theBlock, "bCount" ) then
		bCount = getElementData ( theBlock, "bCount" )
		bOwner = getElementData ( theBlock, "bOwner" )
		serial = getPlayerSerial ( source )

		if ( bProtected[bOwner] == true ) and not ( bOwner == getPlayerSerial(source) ) and not ( bOPs[getPlayerSerial(source)] == true ) then
			outputChatBox ( "#FFFFFFPROTECTION: #C80000This Block is protected and can not be destroyed!", source, 200, 0, 0, true )
			return
		end
		
		destroyElement ( Blocks[bCount] )
		CurrentPlacedBlocks = CurrentPlacedBlocks - 1
	end
end

function ForceRemoveBlock ( theBlock )
	if getElementData ( theBlock, "bCount" ) then
		bCount = getElementData ( theBlock, "bCount" )
		bOwner = getElementData ( theBlock, "bOwner" )

		destroyElement ( Blocks[bCount] )
		CurrentPlacedBlocks = CurrentPlacedBlocks - 1
	end
end

function saveMap ( Arg1, Arg2, MapName )
-- Save the Map :D
-- Not included yet :(
end

function OutputCurrentServerStatistics ( thePlayer )
	outputChatBox ( "#FFFFFFSTATS: Currently placed Blocks: #C8C8C8"..math.floor(CurrentPlacedBlocks), thePlayer, 255, 255, 255, true )
	outputChatBox ( "#FFFFFFSTATS: This Server is running #C8C8C8McSA v1.3.5#FFFFFF!", thePlayer, 255, 255, 255, true )
end

function callClientFunction(client, funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    -- If the clientside event handler is not in the same resource, replace 'resourceRoot' with the appropriate element
    triggerClientEvent(client, "onServerCallsClientFunction", resourceRoot, funcname, unpack(arg or {}))
end

function callServerFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onClientCallsServerFunction", true)
addEventHandler("onClientCallsServerFunction", resourceRoot , callServerFunction)

addCommandHandler ( "mc_stats", OutputCurrentServerStatistics, false, false )

addEvent ( "onBlockRemove", true )
addEventHandler ( "onBlockRemove", getRootElement(), removeBlock )

addEvent ( "onBlockPlace", true )
addEventHandler ( "onBlockPlace", getRootElement(), placeBlock )

-- Mobs:
SpawnedMobs = {}

function SpawnCreeper(uID, X, Y, Z)
SpawnedMobs[uID] = {}
SpawnedMobs[uID]["AIPed"] = createPed(0, X, Y, Z, true)
setElementData(SpawnedMobs[uID]["AIPed"], "mc.Creator", source, true)
setElementData(SpawnedMobs[uID]["AIPed"], "mc.uID", uID, true)
setElementAlpha(SpawnedMobs[uID]["AIPed"], 0) -- Make the AIPed invisible
SpawnedMobs[uID]["MobObj"] = createObject(McMobs[0].ObjID, X, Y, Z)
setElementAlpha(SpawnedMobs[uID]["MobObj"], 150)
attachElements(SpawnedMobs[uID]["MobObj"], SpawnedMobs[uID]["AIPed"], 0.0, 0.0, -0.9)
triggerClientEvent("onCreeperEnable", getRootElement(), SpawnedMobs[uID]["AIPed"])
triggerClientEvent(source, "onCreeperEnableUpdate", getRootElement(), SpawnedMobs[uID]["AIPed"])
setElementSyncer(SpawnedMobs[uID]["AIPed"], source)
--outputChatBox("Creeper spawned... uID: "..uID, source)
end

function destroyMob(theMob)
	if ( theMob == nil ) or ( isElement(theMob) == false ) then
		return
	end
	local uID = getElementData(theMob, "mc.uID")
	local x, y, z = getElementPosition(theMob)
	destroyElement(SpawnedMobs[uID]["AIPed"])
	destroyElement(SpawnedMobs[uID]["MobObj"])
	local ClientTBL = getElementsByType ( "player", getRootElement(), true )
	for k,v in pairs(ClientTBL) do
		callClientFunction(v, "createFire", x, y, z, 1.0)
	end
end

function explodeMob(theMob)
	local uID = getElementData(theMob, "mc.uID")
	local x, y, z = getElementPosition(theMob)
	local ClientTBL = getElementsByType ( "player", getRootElement(), true )
	for k,v in pairs(ClientTBL) do
		callClientFunction(v, "createFire", x, y, z, 2.0)
		callClientFunction(v, "createExplosion", x, y, z, 4, true, 3.0, true)
		callClientFunction(v, "PlayExplosion3D", x, y, z)
	end
	
	if ( MOBS_DestroyBlocks == true ) then
		local ObjTBL = getElementsByType ( "object", getRootElement(), true )
		for k,v in pairs(ObjTBL) do
			if ( getElementData(v, "mc.isMcBlock") == true ) then
				local bX, bY, bZ = getElementPosition(v)
				if ( getDistanceBetweenPoints3D(bX, bY, bZ, x, y, z) <= MOBS_CreeperStrength ) then
					ForceRemoveBlock(v)
				end
			end
		end
	end
	
	destroyElement(SpawnedMobs[uID]["AIPed"])
	destroyElement(SpawnedMobs[uID]["MobObj"])
end

addEvent("onCreeperSpawn", true)
addEventHandler("onCreeperSpawn", getRootElement(), SpawnCreeper)