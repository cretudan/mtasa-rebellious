col  = createColCuboid ( -1854.2998046875, -3105.599609375, 35.799999237061, 280, 450, 18) -- enter your cooderates here for your colshape please note 10 and 3 is to do with the size of the shape.
root = getRootElement ()
 
airportgate = createObject ( 8171, -1807.9000244141, -3053.5, 50.299999237061, 3, 0, 318) -- enter the ID of the object followed by the coordinates
                                 -- note the rotx y and z may not be required so you just remove these. x y and z is where you would put your cordinates.
 
 
function Open ( pla )
    if getElementType ( pla ) == "player" then
        if isObjectInACLGroup ( "user."..getAccountName(getPlayerAccount(pla)), aclGetGroup ( "Admin" ) ) then
            moveObject (airportgate, 4500, -1807.8994140625, -3053.5, 36.299999237061)    -- here is where you enter the coordinatess of the new location of the object, 2200 = the speed of the movent.
        end
    end
end  
addEventHandler ( "onColShapeHit", col, Open)
 
function Close ( pla )
    if getElementType ( pla ) == "player" then
        if isObjectInACLGroup ( "user."..getAccountName(getPlayerAccount(pla)), aclGetGroup ( "Admin" ) ) then
            moveObject (airportgate, 2500, -1807.9000244141, -3053.5, 50.299999237061) -- here is where you copy the coordinates of the orginal location of the object, 2951 = the timer of movent.
        end
    end
end
addEventHandler ( "onColShapeLeave", col, Close )