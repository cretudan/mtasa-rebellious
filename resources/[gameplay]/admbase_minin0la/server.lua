--Crea un marcador de la entrada. 
--Aqui el valor predeterminado "47" es el simbolo del marcador, 
--los demas indican la posicion de la entrada.
createBlip ( -1985.95, 660.42, 46.56, 47 )

--Lo de abajo NO SE DEBE TOCAR a menos que sepas LUA...

--NO TOCAR!!!!
--Puerta de Entrada y Salida.
local irAdentro = createMarker( -1985.91, 660.38, 45.56, 'cylinder', 1.5, 255, 0, 0, 150 )
local irAfuera = createMarker( -1894.73, 653.08, -64.42, 'cylinder', 1.5, 255, 0, 0, 150 )
--Puerta para Zona de Guardia
local getInGuardZone = createMarker (-1912, 651, -64.2, 'cylinder', 1.5, 0, 255, 0, 150)
local getOutGuardZone = createMarker (-1913, 651, -64.2, 'cylinder', 1.5, 0, 255, 0, 150)
--Puerta para Zona Admin
local puerta = createObject (10150,-1947.0670166016,641.17620849609,-80,0,0,90)
local markerADM = createMarker (-1947.06,641.17,-81, 'cylinder', 3, 0, 0, 255, 0)
--------------------------


--Define quiénes pueden entrar y quiénes no.
function Entrar( hitPlayer, matchingDimension )

    if hasObjectPermissionTo( hitPlayer, 'general.adminpanel', false ) then
        setElementPosition ( hitPlayer, -1901.87, 653.26, -63.42 )
	    outputChatBox ( "Welcome to Zombotech Lab, the San Fierro's sinister zombie research building!",hitPlayer )
	else    
	    outputChatBox ( "You cannot enter. You need to be a member of the Staff.",hitPlayer )			      
  end
end

addEventHandler( "onMarkerHit", irAdentro, Entrar )

--Ésta es la salida del laboratorio.
function Salir( hitPlayer, matchingDimension )
  setElementPosition ( hitPlayer, -1980.78, 660.05, 46.56 )
  outputChatBox ( "Goodbye!",hitPlayer )
end

addEventHandler( "onMarkerHit", irAfuera, Salir )

--Ésta es una  zona de guardias. Sólo ellos pueden ingresar.
function entrarGuard (hitPlayer, matchingDimension)
  local skin = getElementModel (hitPlayer)
  if skin == 0 then
    setElementPosition (hitPlayer, -1916, 651, -63.42)
  elseif skin == 0 then
    setElementPosition (hitPlayer, -1916, 651, -63.42)
  elseif skin == 0 then
    setElementPosition (hitPlayer, -1916, 651, -63.42)
  elseif skin == 0 then
    setElementPosition (hitPlayer, -1916, 651, -63.42)
  else
    outputChatBox ("You need to be guard.",hitPlayer)
  end
end
addEventHandler ("onMarkerHit",getInGuardZone,entrarGuard)
function salirGuard (hitPlayer, matchingDimension)
    setElementPosition (hitPlayer, -1910, 651, -63.42)
end
addEventHandler ("onMarkerHit",getOutGuardZone,salirGuard)

--Ésta es una zona de Admins. Sólo ellos pueden ingresar.
addEventHandler ("onMarkerHit",markerADM,
function (hitPlayer)
 local account = getPlayerAccount(hitPlayer)
 if isObjectInACLGroup( 'user.'..getAccountName( account ), aclGetGroup( 'Admin' ) ) then
  moveObject (puerta,1000,-1947.0670166016,641.17620849609,-77)
  outputChatBox ("Welcome to Staff Zone.",hitPlayer,0,255,0)
 else
  outputChatBox ("You need to be admin to enter this zone.",hitPlayer)
 end
end)

addEventHandler ("onMarkerLeave",markerADM,
function ()
 moveObject (puerta,1000,-1947.0670166016,641.17620849609,-80)
end)