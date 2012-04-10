--------------------------------------------------------------------------------------------------------------
-- McSA - 2012 MilchschniTTe - a.k.a MrMilchprodukT @ MTA:SA -------------------------------------------------
--------------------------------------------------------------------------------------------------------------

CLIENT_EnableEditing = true
CLIENT_SelectedBlock = 1 -- The Current Block you are using
CLIENT_ProtectMode = 0 -- Protect your Blocks from being removed
CLIENT_OverrideProtectMode = 0 -- Override the ProtectMode setting, now you can destroy every block!

function showpCursor ( key, keyState, state )
	showCursor( state )
	
	if state == true then
		removeEventHandler ( "onClientRender", getRootElement(), drawBlockLines3D )
		addEventHandler ( "onClientRender", getRootElement(), drawBlockLines3D )
	else
		removeEventHandler ( "onClientRender", getRootElement(), drawBlockLines3D )
	end
end

function removeBlockOnClick ( key, keyState )
	if not isCursorShowing() then
		return
	end

	if not getKeyState ( "lalt" ) then
		return
	end

	hit, wPosX, wPosY, wPosZ, hitElement = getBlockPosFromCursor()

	if (not hit) or ( hitElement == localPlayer ) then
		return
	end

	if ( hit ) then
		--PlayBlockSound()
		triggerServerEvent ( "onBlockRemove", localPlayer, hitElement )
	end

end

function placeBlockOnClick ( key, keyState )
	if not isCursorShowing() then
		return
	end

	if not getKeyState ( "lalt" ) then
		return
	end

	if ( getStreamedBlocksCount() + #UnStreamedObjects >= ENGINE_MaxAreaBlocks ) then
		outputChatBox ( "#FFFFFFENGINE: #C80000Maximum amout of blocks has been reached! ("..ENGINE_MaxAreaBlocks..")", 255, 255, 255, true )
		return
	end
	
	hit, wPosX, wPosY, wPosZ, hitElement = getBlockPosFromCursor()

	if (not hit) or ( hitElement == localPlayer ) then
		return
	end

	-- Floor the Hit-Position to gather the new Block-Position
	bPosX = math.floor(wPosX)
	bPosY = math.floor(wPosY)
	bPosZ = math.floor(wPosZ)

	if hitElement then
		hX, hY, hZ = getElementPosition ( hitElement )
		-- Floor to get the Block-Position
		hX = math.floor(hX)
		hY = math.floor(hY)
		hZ = math.floor(hZ)
	end

	-- Fix for "Blocks-Glitching-In-Each-Other"-Bug
	if ( bPosX == hX ) and ( bPosY == hY ) and ( bPosZ == hZ ) then
		return
	end

	PlayBlockSound()
	
	if McBlocks[CLIENT_SelectedBlock]["rAble"] == true then -- Blocks are rotable, so pass the rotation as an argument
		camx, camy, camz, camxx, camyy, camzz = getCameraMatrix ()
		pX, pY, pZ = getElementPosition ( localPlayer )
		rot = findRotation ( wPosX, wPosY, pX, pY )

		if ( rot > 315 ) or ( rot < 45 )then
			triggerServerEvent ( "onBlockPlace", localPlayer, math.floor(McBlocks[CLIENT_SelectedBlock]["ID"]), math.floor(McBlocks[CLIENT_SelectedBlock]["ObjID"]), bPosX, bPosY, bPosZ, 180 )
			return
		end

		if ( rot > 45 ) and ( rot < 135 ) then
			triggerServerEvent ( "onBlockPlace", localPlayer, math.floor(McBlocks[CLIENT_SelectedBlock]["ID"]), math.floor(McBlocks[CLIENT_SelectedBlock]["ObjID"]), bPosX, bPosY, bPosZ, 270 )
			return
		end

		if ( rot > 135 ) and ( rot < 225 ) then
			triggerServerEvent ( "onBlockPlace", localPlayer, math.floor(McBlocks[CLIENT_SelectedBlock]["ID"]), math.floor(McBlocks[CLIENT_SelectedBlock]["ObjID"]), bPosX, bPosY, bPosZ, 0 )
			return
		end

		if ( rot > 225 ) and ( rot < 315 ) then
			triggerServerEvent ( "onBlockPlace", localPlayer, math.floor(McBlocks[CLIENT_SelectedBlock]["ID"]), math.floor(McBlocks[CLIENT_SelectedBlock]["ObjID"]), bPosX, bPosY, bPosZ, 90 )
			return
		end

		return
	end

	triggerServerEvent ( "onBlockPlace", localPlayer, math.floor(McBlocks[CLIENT_SelectedBlock]["ID"]), math.floor(McBlocks[CLIENT_SelectedBlock]["ObjID"]), bPosX, bPosY, bPosZ, 0 )
end

function selectBlockFromWorld ( key, keyState )
	if not isCursorShowing() then
		return
	end

	if not getKeyState ( "lalt" ) then
		return
	end

	hit, wPosX, wPosY, wPosZ, hitElement = getBlockPosFromCursor()

	if (not hit) or ( hitElement == localPlayer ) then
		return
	end

	setCurrentBlock ( "", math.floor(getElementData ( hitElement, "bID" )) )
end

function ScrollNextItem ( key, keyState )
	if not getKeyState ( "lalt" ) then
		return
	end

	setCurrentBlock ( 0, CLIENT_SelectedBlock + 1 )
end

function ScrollPrevItem ( key, keyState )
	if not getKeyState ( "lalt" ) then
		return
	end

	setCurrentBlock ( 0, CLIENT_SelectedBlock - 1 )
end

bindKey ( "mouse_wheel_down", "down", ScrollNextItem )
bindKey ( "mouse_wheel_up", "down", ScrollPrevItem )
bindKey ( "lalt", "down", showpCursor, true )

bindKey ( "lalt", "down", showpCursor, true )
bindKey ( "lalt", "up", showpCursor, false )

bindKey ( "mouse1", "down", placeBlockOnClick )
bindKey ( "mouse2", "up", removeBlockOnClick )
bindKey ( "mouse3", "up", selectBlockFromWorld )

function drawBlockLines3D ()
	hit, wPosX, wPosY, wPosZ, hitElement = getBlockPosFromCursor()
	
	if ( not hitElement ) or ( hitElement == localPlayer ) then
		return
	end

	hX, hY, hZ = getElementPosition ( hitElement )
	
	local bID = getElementData ( hitElement, "bID" )
	local brAble = McBlocks[bID]["rAble"]

	if brAble == true then -- Block is rotable
		hrX, hrY, hrZ = getElementRotation ( hitElement )
		hrZ = math.floor(hrZ)
		if hrZ == 90 then
			hX = hX - 1
			hY = hY
		end
	
		if hrZ == 179 then
			hX = hX - 1
			hY = hY - 1
		end
	
		if hrZ == 270 then
			hY = hY - 1
		end
	end

-- Draaaaw alllll teh liness aaarrrouuund teh blaawk
dxDrawLine3D ( hX + 1.01, hY + 1.01, hZ, hX + 1.01, hY, hZ, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX + 1.01, hY, hZ, hX, hY, hZ, tocolor(255,0,0), 2, false, 1.01)
dxDrawLine3D ( hX + 1.01, hY, hZ, hX + 1.01, hY, hZ + 1.01, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX + 1.01, hY, hZ + 1.01, hX, hY, hZ + 1.01, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX + 1.01, hY, hZ + 1.01, hX + 1.01, hY + 1.01, hZ + 1.01, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX, hY, hZ, hX, hY + 1.01, hZ, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX, hY, hZ, hX, hY, hZ + 1.01, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX, hY, hZ + 1.01, hX, hY + 1.01, hZ + 1.01, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX, hY + 1.01, hZ, hX, hY + 1.01, hZ + 1.01, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX, hY + 1.01, hZ, hX + 1.01, hY + 1.01, hZ, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX + 1.01, hY + 1.01, hZ + 1.01, hX + 1.01, hY + 1.01, hZ, tocolor(255,0,0), 3, false, 1.01 )
dxDrawLine3D ( hX + 1.01, hY + 1.01, hZ + 1.01, hX, hY + 1.01, hZ + 1.01, tocolor(255,0,0), 3, false, 1.01 )
end

function setCurrentBlock ( Command, BlockID )
	if not BlockID then -- Screw you! Called that function without... an ID
		return
	end
	
	if McBlocks[math.floor(BlockID)] then
		CLIENT_SelectedBlock = math.floor(BlockID)
	end
end

function findRotation(x1,y1,x2,y2) -- Useful function ;)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end

function drawSelectedBlockTBAR ()
sWidth, sHeight = guiGetScreenSize ()

dxDrawRectangle ( 0, sHeight - 25, sWidth, 25, tocolor(0,0,0,255) )
dxDrawRectangle ( 0, sHeight - 25, sWidth, 2, tocolor(255,255,255,255) )

dxDrawImage ( (sWidth/2) - (256/2), sHeight - 256, 256, 256, "img/tbar_bIMG.png" )
dxDrawImage ( (sWidth/2) - (256/2), sHeight - 256, 256, 256, "img/blocks/"..McBlocks[CLIENT_SelectedBlock]["img"]..".png" )

dxDrawText ( McBlocks[CLIENT_SelectedBlock]["Name"], (sWidth / 2) + 75, sHeight - 21, 0, 0, tocolor(255,255,255,255), 1.4, "default-bold" )

if getKeyState ( "lalt" ) then
dxDrawText ( "Release ALT to leave Edit-Mode", 5, sHeight - 19 )
else
dxDrawText ( "Press ALT to switch Edit-Mode", 5, sHeight - 19 )
end
end

function displayClientStatistics ()
	outputChatBox ( "#FFFFFFSTATS: Currently streamed Blocks: #C8C8C8"..math.floor(getStreamedBlocksCount()), 255, 255, 255, true )
	outputChatBox ( "#FFFFFFSTATS: Currently unstreamed Blocks: #C8C8C8"..math.floor(#UnStreamedObjects), 255, 255, 255, true )
end

function callClientFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do arg[key] = tonumber(value) or value end
    end
    loadstring("return "..funcname)()(unpack(arg))
end
addEvent("onServerCallsClientFunction", true)
addEventHandler("onServerCallsClientFunction", resourceRoot, callClientFunction)

function callServerFunction(funcname, ...)
    local arg = { ... }
    if (arg[1]) then
        for key, value in next, arg do
            if (type(value) == "number") then arg[key] = tostring(value) end
        end
    end
    -- If the serverside event handler is not in the same resource, replace 'resourceRoot' with the appropriate element
    triggerServerEvent("onClientCallsServerFunction", resourceRoot , funcname, unpack(arg))
end

addCommandHandler ( "mc_stats", displayClientStatistics, false, false )
addCommandHandler ( "mc_setBlock", setCurrentBlock, false, false )

addEventHandler ( "onClientRender", getRootElement(), drawSelectedBlockTBAR )