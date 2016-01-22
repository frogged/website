 -- mclogger.lua 0.2 - written by TyPhOoN

logfile= "/root/.verlihub/mainchat.log"
lf= "n"

function Main()
-- handle =  io.open(logfile,"a+") -- to append (notinhere)
handle =  io.open(logfile,"w+")
io.output(handle)
end

function formatTF(field)
if (tonumber(field)<10 and string.len(field)== 1) then -- Fixed: string.len(field)= = 2) (notinhere)
  field =  "0"..field
end
return field
end

function VH_OnParsedMsgChat(nick, data)
if (handle) then
date =  os.date ("*t")
io.write("~["..date.year.."-"..formatTF(date.month).."-"..formatTF(date.day).." "..formatTF(date.hour)..":"..formatTF(date.min)..":"..formatTF(date.day).."] <"..nick.."> "..data..lf)
io.flush()
end
return 1
end