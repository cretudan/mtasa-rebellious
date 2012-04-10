--------------------------------------------------------------------------------------------------------------
-- McSA - 2012 MilchschniTTe - a.k.a MrMilchprodukT @ MTA:SA -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

UnStreamedObjects = {}
local SkipCounter = 0

function STREAMER_StreamObjects()
	if ( ENGINE_McStreamerEnabled == false ) then
		removeEventHandler("onClientPreRender", getRootElement(), STREAMER_StreamObjects)
		return
	end
	
	-- Skip some frames
	SkipCounter = SkipCounter + 1
	if ( SkipCounter <= 1 ) then
		return
	end
	SkipCounter = 0
	
	local pX,pY,pZ = getElementPosition(localPlayer)
	local ObjectsTBL = getElementsByType ( "object", getRootElement(), true )
	for k,v in pairs(ObjectsTBL) do
		if (getElementData(v, "mc.isMcBlock", false) == true) then
			local bX,bY,bZ = getElementPosition(v)
			
			if ( getScreenFromWorldPosition(bX,bY,bZ,0.25) == false ) and ( getDistanceBetweenPoints3D(pX,pY,pZ,bX,bY,bZ) > 5.0 ) then
				table.insert(UnStreamedObjects, v)
				setElementDimension(v, 1)
			end
		end
	end
	
	for k,v in pairs(UnStreamedObjects) do
		local bX,bY,bZ = getElementPosition(v)
		
		if ( not getScreenFromWorldPosition(bX,bY,bZ,0.25) == false ) or ( getDistanceBetweenPoints3D(pX,pY,pZ,bX,bY,bZ) < 5.0 ) then
			setElementDimension(v, 0)
			table.remove(UnStreamedObjects, k)
		end
	end
	
		
end

function STREAMER_Enable()
	if ( ENGINE_McStreamerEnabled == false ) then
		return
	end
	setTimer(STREAMER_StreamObjects, ENGINE_StreamerInterval, 0)
end

addEventHandler("onClientPreRender", getRootElement(), STREAMER_StreamObjects)
--addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), STREAMER_Enable )