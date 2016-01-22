--|
--| Client Checker by Alianora 2005
--| for LUA 5 (Verilhub)
--|

sBotName = "#-ClientChecker"
sBotDescryption = "Kik'em all"
sBotMail = "alianora@alia.zapto.org"

sKickMSG = "Twoja wersja DC ($DCPP) jest zabroniona z powodu BUGow. Pobierz nowa i wroc...\n"..
"Your DC client (version $DCPP) is banned becouse of bugs. Please download new one and come back..."

function Main()
    VH:AddRobot(sBotName, 10, sBotDescryption, "Bot", sBotMail, "0")
end

function myCheckUser(sNick)
    data = ""
    mydata = ""
    result, class = VH:GetUserClass(sNick)
    if not ( class > 20 or sNick == "{HubListPinger}" ) then
        myresult, mydata = VH:GetMyINFO(sNick)
        ret,c,desc = string.find( mydata, "^%$MyINFO %$ALL [^ ]* ([^$]*)%$" )
        if ret then
    	    local ret,c,dcpp = string.find( desc, "<%+%+ V:([0-9.]*),[^<>]*>$" )
	    if (dcpp=="0.666" or dcpp=="0.403" or dcpp=="0.4032" or dcpp=="0.4033" or dcpp=="0.4034") then
--		local t = {$DCPP=dcpp}
		local myString = string.gsub(sKickMSG, "%$(%w+)", dcpp)
		VH:SendDataToUser("<"..sBotName.."> \n\n\n\n\n"..myString.."\n\n\n\n\n|", sNick)
	    end
	end
    end
end

function VH_OnUserLogin(sNick)
    myCheckUser(sNick)
    return 1
end

function VH_OnParsedMsgChat(sNick, sData)
    myCheckUser(sNick)
    return 1
end

function VH_OnParsedMsgPM(sNick, sData, sNick2)
    myCheckUser(sNick)
    myCheckUser(sNick2)
    return 1
end

function VH_OnParsedMsgSearch(sNick, sData)
    myCheckUser(sNick)
    return 1
end
