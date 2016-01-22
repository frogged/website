=[[           You may find last version of this script on my web: http://freshscripts.no-ip.biz
			   Or   on my hub  dchub://ophubchanell.izodar.com:1090 !!
			   This script login all kick with reason
			   And sending info to opchat that some one used command!
			   To print on mainchat logs add trigger
			   !addtrigger +oploger -d "%[CFG]/scripts/kicklogger.dat" -f0 -c10
			   Regards Fresh
			   Ophub Chanell owner
			   Making Dc Better ]]

-- Configure this
 sciezka = "/home/verlihub/ophub/.verlihub/scripts/kicklogger.lua"
MinClass = 11

function VH_OnOperatorKicks(op, nick, data)
    result, class = VH:GetUserClass(nick)
    res, opchatname = VH:GetConfig("config","opchat_name")
    if (class < MinClass
	and not string.find(data, "fresh")) then
        VH:SendPMToAll(" Kick "..op.." kicked "..nick.." because    "..data.."|", opchatname ,4,10)
zapiszlog = "["..os.date("%Y. %m. %d. | %H:%M:%S").."] "..op.." kicked  "..nick.."  because:    "..data.."�"
Zapisz(zapiszlog)
        return 1
    end
end


function Zapisz(zapiszlog)
notadd = false
		if notadd == false then
		local logfile = io.open(sciezka, "a")
			if (logfile) then
			logfile:write(""..zapiszlog.."\n")
			logfile:close()
			end
		end
end