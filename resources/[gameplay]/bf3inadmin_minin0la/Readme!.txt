Hello!
-----
How add more radios?


copy this line  whidout "--!!" "!--" , and add this to "3dradio.lua" 

--!!addEventHandler( 'onClientResourceStart',resourceRoot,
	function( )
		local sound = playSound3D( 'http://www.181.fm/asx.php?station=181-uktop40&amp;style=&amp;description=',2479.3723144531,-1687.0906982422,13.5078125 ) 
		setSoundMaxDistance( sound,50 )
	end
)!!--

---EXAMPLE--

ONE STATION.

addEventHandler( 'onClientResourceStart',resourceRoot,
	function( )
		local sound = playSound3D( 'http://www.181.fm/asx.php?station=181-uktop40&amp;style=&amp;description=',2479.3723144531,-1687.0906982422,13.5078125 ) 
		setSoundMaxDistance( sound,50 )
	end
)

--AND NOW ADD SAME LINE ,BUT OTHER CORDINATES!--

addEventHandler( 'onClientResourceStart',resourceRoot,
	function( )
		local sound = playSound3D( 'http://www.181.fm/asx.php?station=181-uktop40&amp;style=&amp;description=',OWN CORDINATES HERE,OWN CORDINATES HERE,OWN CORDINATES HERE ) 
		setSoundMaxDistance( sound,50 )
	end
)


!!YOU CAN ADD OWN MUSIC ((MP3, WAV, OGG, RIFF, MOD, XM, IT and S3M.)) !!

--setSoundMaxDistance( sound,50 ) <--minimum distance is 0 and max is 100 

--local sound = playSound3D( 'http://www.181.fm/asx.php?station=181-uktop40&amp;style=&amp;description=',2479.3723144531,-1687.0906982422,13.5078125 )

'http://www.181.fm/asx.php?station=181-uktop40&amp;style=&amp;description='   <--you can add own radio station here.

Best way to get cordinates in FREEROAM MODE "MAP" 


©mR|Monster