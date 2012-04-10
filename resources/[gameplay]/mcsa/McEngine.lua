--------------------------------------------------------------------------------------------------------------
-- McSA - 2012 MilchschniTTe - a.k.a MrMilchprodukT @ MTA:SA -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

CHUNKS = { --[[ ["X"] = {}, ["Y"] = {}, ["Z"] = {} ]] }

function ENGINE_LoadBlocks() -- Loads .dff, .txd and .col of all defined blocks
	setFarClipDistance ( 1000 )

	for ENGINE_CurrentBlockID = 1, ENGINE_MaxDef, 1 do
		txd_block = engineLoadTXD ( "blocks/"..ENGINE_CurrentBlockID.."/"..ENGINE_CurrentBlockID..".txd" )
		engineImportTXD ( txd_block, McBlocks[ENGINE_CurrentBlockID]["ObjID"] )
		col_block = engineLoadCOL ( "blocks/"..ENGINE_CurrentBlockID.."/"..ENGINE_CurrentBlockID..".col" )
		dff_block = engineLoadDFF ( "blocks/"..ENGINE_CurrentBlockID.."/"..ENGINE_CurrentBlockID..".dff", 0 )
		engineReplaceCOL ( col_block, McBlocks[ENGINE_CurrentBlockID]["ObjID"] )
		engineReplaceModel ( dff_block, McBlocks[ENGINE_CurrentBlockID]["ObjID"] )
		engineSetModelLODDistance ( McBlocks[ENGINE_CurrentBlockID]["ObjID"], ENGINE_LODDistance )
		--outputChatBox ( "Block "..McBlocks[ENGINE_CurrentBlockID]["Name"].." loaded!", 255, 255, 0 )
	end
end

function ENGINE_LoadMobs() -- Loads .dff, .txd and .col of all defined mobs
	setFarClipDistance ( 1000 )

	for ENGINE_CurrentMobID = 0, ENGINE_MOBS_MaxDef - 1, 1 do
		local MobName = McMobs[ENGINE_CurrentMobID].Name
		
		txd_mob = engineLoadTXD ( "mobs/"..MobName.."/"..MobName..".txd" )
		engineImportTXD ( txd_mob, McMobs[ENGINE_CurrentMobID].ObjID )
		col_mob = engineLoadCOL ( "mobs/"..MobName.."/"..MobName..".col" )
		dff_mob = engineLoadDFF ( "mobs/"..MobName.."/"..MobName..".dff", 0 )
		engineReplaceCOL ( col_mob, McMobs[ENGINE_CurrentMobID].ObjID )
		engineReplaceModel ( dff_mob, McMobs[ENGINE_CurrentMobID].ObjID )
		engineSetModelLODDistance ( McMobs[ENGINE_CurrentMobID].ObjID, ENGINE_LODDistance )
	end
end

function getStreamedObjectsCount ()
	local ObjectsTBL = getElementsByType ( "object", getRootElement(), true )
	numItems = 0
	for k,v in pairs(ObjectsTBL) do
		numItems = numItems + 1
	end
	
	return numItems
end

function getStreamedBlocksCount ()
	local ObjectsTBL = getElementsByType ( "object", getRootElement(), true )
	numItems = 0
	for k,v in pairs(ObjectsTBL) do
		if (getElementData(v, "mc.isMcBlock", false) == true) then
			numItems = numItems + 1
		end
	end
	
	return numItems
end

function getBlockPosFromCursor ()
	sHeight, sWidth = guiGetScreenSize ()
	sPosX, sPosY = getCursorPosition()
	sPosX = sPosX * sWidth
	sPosY = sPosY * sHeight
	sX, sY, wPosX, wPosY, wPosZ = getCursorPosition ()
	camPosX, camPosY, camPosZ  = getCameraMatrix ()
	pPosX, pPosY, pPosZ = getElementPosition ( localPlayer )
	return processLineOfSight ( camPosX, camPosY, camPosZ, wPosX, wPosY, wPosZ, true, false, false )
end

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ENGINE_LoadBlocks )
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), ENGINE_LoadMobs )
addCommandHandler ( "mc_reloadblocks", ENGINE_LoadBlocks, false, false )