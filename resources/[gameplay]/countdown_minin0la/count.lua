function colour (thePlayer)
	local chatterName = getPlayerName (thePlayer)
		outputChatBox ("* " ..chatterName.. "#00CC00 counts down from 3! ", getRootElement(), 255, 0, 0, true )
	end
addCommandHandler("countdown", colour)

function countdownRec (count)
      if (count > 0) then
          outputChatBox(tostring(count), getRootElement(), 0, 255, 0)
          setTimer(countdownRec, 1000, 1, count-1)
      else
          outputChatBox("Go Go Go!!!", getRootElement(), 255, 0, 0)
      end
end

function countdown()
      countdownRec(3)
end
addCommandHandler("countdown", countdown)