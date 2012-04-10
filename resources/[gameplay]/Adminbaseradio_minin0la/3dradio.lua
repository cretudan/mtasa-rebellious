------------------------------------
-----3D Radio Script BY:mR|Monster--
------------------------------------

addEventHandler( 'onClientResourceStart',resourceRoot,
	function( )
		local sound = playSound3D( 'http://www.181.fm/asx.php?station=181-uktop40&amp;style=&amp;description=',-1605,-2714,49 ) 
		setSoundMaxDistance( sound,50 )
	end
)

