--------------------------
-- Login panel by NeXTreme
--------------------------


-- Login handling
function loginPlayer(username,password,enableKickPlayer,attemptedLogins,maxLoginAttempts)
	if not (username == "") then
		if not (password == "") then
			local account = getAccount ( username, password )
			if ( account ~= false ) then
				logIn (source, account, password)
				outputChatBox ("#0000FF* #FFFFFFTe has logueado correctamente!",source,255,255,255,true)
				setTimer(outputChatBox,700,1,"#0000FF* #FFFFFFPara activar el auto-login, usa #ABCDEF/enableauto#FFFFFF!",source,255,255,255,true)
				triggerClientEvent (source,"hideLoginWindow",getRootElement())
			else
				if enableKickPlayer == true then
					if (attemptedLogins >= maxLoginAttempts-1) then
						outputChatBox ("#0000FF* #FFFFFFError! Usuario/clave incorrecto!",source,255,255,255,true)
						setTimer(outputChatBox,500,1,"#0000FF* #FFFFFFAtencion! Alcanzaste el maximo de intentos de logueo! [#008AFF"..attemptedLogins+1 .."/"..maxLoginAttempts.."#FFFFFF]",source,255,255,255,true)
						setTimer(outputChatBox,1000,1,"#0000FF* #FFFFFFSeras kickeado en #008AFF5 segundos#FFFFFF!",source,255,255,255,true)
						setTimer(kickPlayer,5000,1,source,"Failed to login")
					else
						outputChatBox ("#0000FF* #FFFFFFError! Usuario/clave incorrecto!",source,255,255,255,true)
						setTimer(outputChatBox,500,1,"#0000FF* #FFFFFFLogin attempts: [#008AFF"..attemptedLogins+1 .."/"..maxLoginAttempts.."#FFFFFF]",source,255,255,255,true)
						triggerClientEvent(source,"onRequestIncreaseAttempts",source)
					end
				else
					outputChatBox ("#0000FF* #FFFFFFError! Usuario/clave incorrecto!",source,255,255,255,true)
				end
			end
		else
			outputChatBox ("#0000FF* #FFFFFFError! por favor pon una clave!",source,255,255,255,true)
		end
	else
		outputChatBox ("#0000FF* #FFFFFFError! Por favor pon un nombre de usuario!",source,255,255,255,true)
	end
end



-- Registration here
function registerPlayer(username,password,passwordConfirm)
	if not (username == "") then
		if not (password == "") then
			if not (passwordConfirm == "") then
				if password == passwordConfirm then
					local account = getAccount (username,password)
					if (account == false) then
						local accountAdded = addAccount(tostring(username),tostring(password))
						if (accountAdded) then
							triggerClientEvent(source,"hideRegisterWindow",getRootElement())
							outputChatBox ("#0000FF* #FFFFFFTe has registrado correctamente! [Usuario: #ABCDEF" .. username .. " #FF0000| #FFFFFFClave: #ABCDEF" .. password .. "#FFFFFF]",source,255,255,255,true )
							setTimer(outputChatBox,800,1,"#0000FF* #FFFFFFYou can now login with your new account.",source,255,255,255,true )
						else
							outputChatBox ("#0000FF* #FFFFFFOcurrio un error! Por favor elige un usuario/clave distino y vuelve a intentarlo.",source,255,255,255,true )
						end
					else
						outputChatBox ("#0000FF* #FFFFFFError! Ya existe una cuenta con ese nombre!",source,255,255,255,true )
					end
				else
					outputChatBox ("#0000FF* #FFFFFFError! Las claves no coinciden!",source,255,255,255,true)
				end
			else
				outputChatBox ("#0000FF* #FFFFFFError! Por favor confirma tu clave!",source,255,255,255,true)
			end
		else
			outputChatBox ("#0000FF* #FFFFFFError! Por favor pon una clave!",source,255,255,255,true)
		end
	else
		outputChatBox ("#0000FF* #FFFFFFError! Por favor pon un nombre de usuario con el que quieres registrarte!",source,255,255,255,true)
	end
end



-- Auto-login handling
function autologinPlayer(username,password)
	if not (username == "") then
		if not (password == "") then
			local account = getAccount ( username, password )
			if not (account == false) then
				logIn (source, account, password)
				outputChatBox("#0000FF* #FFFFFFHas sido logueado automaticamente.",source,255,255,255,true)
				setTimer(outputChatBox,1000,1,"#0000FF* #FFFFFFPara desactivar el auto-logueo, usa #ABCDEF/disableauto.",source,255,255,255,true)
				triggerClientEvent ( source, "hideLoginWindow", getRootElement())
			else
				outputChatBox ("#FF0000* #FFFFFFError de auto-logueo, usuario y clave no coinciden",source,255,255,255,true)
			end
		else
			outputChatBox ("#FF0000* #FFFFFFError de auto-logueo, fallo la obtencion de contraseña",source,255,255,255,true)
		end
	else
		outputChatBox ("#FF0000* #FFFFFFError de auto-logueo fallo la obtencion de usuario",source,255,255,255,true)
	end
end



-- When the player logs out, trigger the client event to check if the login panel will request them to login again
function logoutHandler()
	triggerClientEvent(source,"onRequestDisplayPanel",source)
end
addEventHandler("onPlayerLogout",getRootElement(),logoutHandler)






addEvent("onRequestLogin",true)
addEvent("onRequestRegister",true)
addEvent("onRequestAutologin",true)
addEventHandler("onRequestLogin",getRootElement(),loginPlayer)
addEventHandler("onRequestRegister",getRootElement(),registerPlayer)
addEventHandler("onRequestAutologin",getRootElement(),autologinPlayer)

