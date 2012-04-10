col  = createColCircle (-1851, -3112.1000976563, 47, 0.1)
lift = createObject (3095, -1851, -3112.1000976563, 51.700000762939, 0, 0, 228.49365234375)
function open(player)
    local acc = getAccountName(getPlayerAccount(player))
         if acc then
         if isObjectInACLGroup("user." .. acc, aclGetGroup("Admin")) then
            moveObject(lift, 4000, -1851, -3112.1000976563, 38.900001525879)
        end
    end
end  
 
function close(player)
    local acc = getAccountName(getPlayerAccount(player))
         if acc then
         if isObjectInACLGroup("user." .. acc, aclGetGroup("Admin")) then
              moveObject (lift, 4500, -1851, -3112.1000976563, 51.700000762939)
         end
    end
end
 
function bind(hitPlayer, matchingDimension)
if getElementType(hitPlayer) == "player" then
          bindKey(hitPlayer, "-", "down", open)
          bindKey(hitPlayer, "=", "down", close)
          end
end
addEventHandler("onColShapeHit", col, bind)
 
function unbind(leaveElement, matchingDimension)
if getElementType(leaveElement) == "player" then
          unbindKey(leaveElement, "-", "down", open)
          unbindKey(leaveElement, "=", "down", close)
          end
end
addEventHandler("onColShapeLeave", col, unbind)