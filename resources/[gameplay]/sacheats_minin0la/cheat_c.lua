--Toppexxx

addCommandHandler("water", 
	function ( command )
		if not isWorldSpecialPropertyEnabled( "hovercars" ) then
			setWorldSpecialPropertyEnabled( "hovercars", true )
			outputChatBox("Water drive: on ", 255, 255, 0 )
		else
			setWorldSpecialPropertyEnabled( "hovercars", false )
			outputChatBox("Water drive: off", 255, 0, 0 )
		end
	end
)

addCommandHandler("fly",
	function ( command )
		if not isWorldSpecialPropertyEnabled( "aircars" ) then
			setWorldSpecialPropertyEnabled( "aircars", true )
			outputChatBox("Flying vehicle is on !", 255, 255, 0 )
		else
			setWorldSpecialPropertyEnabled( "aircars", false )
			outputChatBox("Flying vehicle is off !", 255, 0, 0 )
		end
	end
)

addCommandHandler("bunny",
	function ( command )
		if not isWorldSpecialPropertyEnabled( "extrabunny" ) then
			setWorldSpecialPropertyEnabled( "extrabunny", true )
			outputChatBox("Extrabunny on bicycles is on !", 255, 255, 0 )
		else
			setWorldSpecialPropertyEnabled( "extrabunny", false )
			outputChatBox("Extrabunny is off !", 255, 0, 0 )
		end
	end
)

addCommandHandler("jump",
	function ( command )
		if not isWorldSpecialPropertyEnabled( "extrajump" ) then
			setWorldSpecialPropertyEnabled( "extrajump", true )
			outputChatBox("High-jump is on !", 255, 255, 0 )
		else
			setWorldSpecialPropertyEnabled( "extrajump", false )
			outputChatBox("High-jump is off !", 255, 0, 0 )
		end
	end
)
