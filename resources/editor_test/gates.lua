
function createTheGate ()
   myGate = createObject ( 980, 96.7138671875, 1920.3447265625, 18.990695953369, 0, 179.99981689453, 90 )
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), createTheGate )
 
function openMyGate ( )
   moveObject ( myGate, 3000, 96.7138671875, 1920.3447265625, 13.990695953369 )
end 
addCommandHandler("opengate1",openMyGate)
 
function movingMyGateBack ()
   moveObject ( myGate, 3000, 96.7138671875, 1920.3447265625, 18.990695953369 )
end 
addCommandHandler("closegate1",movingMyGateBack)

function createTheGate1 ()
   myGate1 = createObject ( 980, 213.8759765625, 1875.4423828125, 13.507524490356 )
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), createTheGate1 )
 
 
function openMyGate1 ()
   moveObject ( myGate1, 3000, 213.8759765625, 1875.4423828125, 9.0075244903564 )
end
addCommandHandler("opengate2",openMyGate1)
 
function movingMyGateBack1 ()
   moveObject ( myGate1, 3000, 213.8759765625, 1875.4423828125, 13.507524490356 )
end
addCommandHandler("closegate2",movingMyGateBack1)

function createTheGate2 ()
   myGate2 = createObject ( 2957, 226.71484375, 1858.5546875, 13.64695930481, 0, 90, 92.5 )
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), createTheGate2 )
 
 
function openMyGate2 ()
   moveObject ( myGate2, 3000, 226.71484375, 1858.5546875, 9.1469593048096, 0, 0, 0 )
end
addCommandHandler("opengate3",openMyGate2)
 
function movingMyGateBack2 ()
   moveObject ( myGate2, 3000, 226.71484375, 1858.5546875, 13.64695930481, 0, 0, 0 )
end
addCommandHandler("closegate3",movingMyGateBack2)

function createTheGate3 ()
   myGate3 = createObject ( 2957, 226.798828125, 1872.87890625, 13.610592842102, 0, 0, 92.5 )
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), createTheGate3 )
 
 
function openMyGate3 ()
   moveObject ( myGate3, 3000, 226.798828125, 1872.87890625, 10.610592842102, 0, 0, 0 )
end
addCommandHandler("opengate4",openMyGate3)
 
function movingMyGateBack3 ()
   moveObject ( myGate3, 3000, 226.798828125, 1872.87890625, 13.610592842102, 0, 0, 0 )
end
addCommandHandler("closegate4",movingMyGateBack3)

function createTheGate4 ()
   myGate4 = createObject ( 980, 266.2236328125, 1884.234375, 16.355909347534, 269.99981689453, 0, 90 )
end
addEventHandler ( "onResourceStart", getResourceRootElement ( getThisResource () ), createTheGate4 )
 
 
function openMyGate4 ()
   moveObject ( myGate4, 3000, 268.7236328125, 1883.734375, -31.644090652466, 0, 0, 0 )
end
addCommandHandler("opengate5",openMyGate4)
 
function movingMyGateBack4 ()
   moveObject ( myGate4, 3000, 266.2236328125, 1884.234375, 16.355909347534, 0, 0, 0 )
end
addCommandHandler("closegate5",movingMyGateBack4)


function openall ()
end
addCommandHandler("openall", openMyGate )
addCommandHandler("openall", openMyGate1 )
addCommandHandler("openall", openMyGate2 )
addCommandHandler("openall", openMyGate3 )
addCommandHandler("openall", openMyGate4 )

function closeall ()
end
addCommandHandler("closeall", movingMyGateBack )
addCommandHandler("closeall", movingMyGateBack1 )
addCommandHandler("closeall", movingMyGateBack2 )
addCommandHandler("closeall", movingMyGateBack3 )
addCommandHandler("closeall", movingMyGateBack4 )
