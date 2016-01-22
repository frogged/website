-- Anti-Kick by woody
minclass = 10
kicker = ""
kicked = ""
botname = VH:GetConfig("config", "hub_security")

function VH_OnOperatorKicks(op, nick, data)
res, class = VH:GetUserClass(op)
    if (class < minclass) then
   VH:KickUser(botname, op, "Kicking is disabled, stop that!!!_BAN_10m")
   kicker = op
   kicked = nick
   return 0
    end
return 1
end


function VH_OnParsedMsgPM(from, data, to)
    if (from == kicker and to == kicked) then
   kicker = ""
   kicked = ""
   return 0
    end
return 1
end