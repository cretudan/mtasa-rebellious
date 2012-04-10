------------------------------------
-----3D Radio Script BY:mR|Monster--
------------------------------------

addEventHandler( 'onClientResourceStart',resourceRoot,
	function( )
		local sound = playSound3D( 'http://www.181.fm/asx.php?station=181-uktop40&amp;style=&amp;description=',2479.3723144531,-1687.0906982422,13.5078125 ) 
		setSoundMaxDistance( sound,50 )
	end
)

