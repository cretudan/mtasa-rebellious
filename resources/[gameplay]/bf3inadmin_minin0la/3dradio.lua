------------------------------------
-----3D Radio Script BY:mR|Monster--
------------------------------------

addEventHandler( 'onClientResourceStart',resourceRoot,
	function( )
		local sound = playSound3D( 'http://www.181.fm/asx.php?station=181-uktop40&amp;style=&amp;description=',-1842,-3088,52 ) 
		setSoundMaxDistance( sound,40 )
	end
)

