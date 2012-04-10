col  = createColTube (-1683.0999755859, -2881.1000976563, 51.400001525879, 10, 3) -- enter your cooderates here for your colshape please note 10 and 3 is to do with the size of the shape.
root = getRootElement ()
 
cone1 = createObject ( 1237, -1679.099609375, -2884.099609375, 51.099998474121, 0, 0, 311.99523925781) -- enter the ID of the object followed by the coordinates
cone2 = createObject ( 1237, -1681.5, -2881.7998046875, 51.099998474121, 0, 0, 311.99523925781)
cone3 = createObject ( 1237, -1684.19921875, -2879.3994140625, 51.099998474121, 0, 0, 311.99523925781)
cone4 = createObject ( 1237, -1686.7998046875, -2877, 51.099998474121, 0, 0, 311.99523925781)  
gate1 = createObject ( 980, -1683, -2881.19921875, 54, 0, 0, 317.99926757813)                                           -- note the rotx y and z may not be required so you just remove these. x y and z is where you would put your cordinates.
 
 
function Open ( pla )
    if getElementType ( pla ) == "player" then
        if isObjectInACLGroup ( "user."..getAccountName(getPlayerAccount(pla)), aclGetGroup ( "Admin" ) ) then
            moveObject (cone1, 300, -1679.0999755859, -2884.1000976563, 50)
            moveObject (cone2, 300, -1681.5, -2881.8000488281, 50)
            moveObject (cone3, 300, -1684.1999511719, -2879.3999023438, 50)
            moveObject (cone4, 300, -1686.8000488281, -2877, 50)
            moveObject (gate1, 2500, -1674.4000244141, -2888.8999023438, 54)    -- here is where you enter the coordinatess of the new location of the object, 2200 = the speed of the movent.
        end
    end
end  
addEventHandler ( "onColShapeHit", col, Open)
 
function Close ( pla )
    if getElementType ( pla ) == "player" then
        if isObjectInACLGroup ( "user."..getAccountName(getPlayerAccount(pla)), aclGetGroup ( "Admin" ) ) then
            moveObject (cone1, 300, -1679.099609375, -2884.099609375, 51.099998474121)
            moveObject (cone2, 300, -1681.5, -2881.7998046875, 51.099998474121)
            moveObject (cone3, 300, -1684.19921875, -2879.3994140625, 51.099998474121)
            moveObject (cone4, 300, -1686.7998046875, -2877, 51.099998474121)
            moveObject (gate1, 2500, -1683, -2881.19921875, 54) -- here is where you copy the coordinates of the orginal location of the object, 2951 = the timer of movent.
        end
    end
end
addEventHandler ( "onColShapeLeave", col, Close )