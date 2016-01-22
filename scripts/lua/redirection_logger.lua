--|--------------------------------------------------------|--
--| redirection_logger.lua                   2006. 03. 13. |--
--|                                                        |--
--| author: weekender                                      |--
--| HUB:    TIËSTO HUB @ tiesto-hub.hu:1969                |--
--| e-mail: weekender@tiesto-hub.hu                        |--
--|                                                        |--
--| (c) 2006 All rights reserved, GNU GPL license          |--
--|--------------------------------------------------------|--
--| Logs the informations to a *.dat file when an OP       |--
--| uses the redirect function of the HUB.                 |--
--| It can be used by Masters to be notified about the     |--
--| redirections.                                          |--
--|--------------------------------------------------------|--
--| Used scripts was:                                      |--
--| function SaveLog(information) - myinfoban.lua (by: Ro) |--
--|--------------------------------------------------------|--


--//itt adhatjuk meg a log-ot tároló fájl elérési útját és nevét
Log_file = "/home/tiesto/.verlihub/scripts/configuration_logger.dat"


function VH_OnParsedMsgAny(opname, data)

	if (string.find(data, "$OpForceMove%s$Who:")) then
	
	_, _, VictimNick = string.find(data, "$OpForceMove%s$Who:(%S+)$Where:(%S+)$Msg:(%S+)")
	_, _, _, NewHub = string.find(data, "$OpForceMove%s$Who:(%S+)$Where:(%S+)$Msg:(%S+)")
	_, _, _, _, ReasonMessage = string.find(data, "$OpForceMove%s$Who:(%S+)$Where:(%S+)$Msg:(.*)")
		
	information = "["..os.date("%Y. %m. %d. | %H:%M:%S").."] "..opname.." redirected "..VictimNick.." to ''"..NewHub.."'' with the following reason:     "..ReasonMessage..""
	SaveLog(information)
	end
	
return 1
end


function SaveLog(information)
notadd = false
		if notadd == false then
		local logfile = io.open(Log_file, "a")
			if (logfile) then
			logfile:write(""..information.."\n")
			logfile:close()
			end
		end
end 
