--This is a script which i created to log all commands Operators
--do. It has not been tested but should work 100 % fully
--Let me know about bugs and stuff on this e-mail: jojjn@simnet.is
--
--TODO:
--Make Search in the log for a user (show what that user did)
--Record commands with Ip function (with Search Function)

----------[ Global variables ]----------

--Change this according to you'r needs
botname = "OpLog"

--This is the min class which can see the log
--Change this into 5 and Admins can also view the log
minclass = 10

--This is the filename of log for Operators commands
oplogfilename = "oplog.dat"

--This is the filename of log for Users commands
userlogfilename = "userlog.dat"

----------[ Event handler functions ]----------

--Operator function, record or view log?
function VH_OnOperatorCommand(opname, data)
      result, class = VH:GetUserClass(opname)
      if (class >= minclass) and (string.find(data, "!oplog%s(%d+)")) then
            total = string.find(data, "%d+")
            linesRead = 0
            list = ""
            su("Opening file "..oplogfilename.."to read", opname)
            fileList = io.open(oplogfilename, "r")
         	if (fileList) then
                  local currentline = fileList:read()
                  while currentline and linesRead ~= total do
                        total = total + 1
                        if list == "" then
                              list =currentline
                        else
                              list = list.."\n"..currentline
                        end
                        currentline = fileList:read()
                  end
                  FileList:close()
            end
            su("Operator's commands:\n"..list, opname)
            return 0
      elseif (class >= minclass) and (string.find(data, "!userlog%s(%d+)")) then
            total = string.find(data, "%d+")
            linesRead = 0
            list = ""
            su("Opening file "..userlogfilename.."to read", opname)
            fileList = io.open(userlogfilename, "r")
         	if (fileList) then
                  local currentline = fileList:read()
                  while currentline and linesRead ~= total do
                        total = total + 1
                        if list == "" then
                              list =currentline
                        else
                              list = list.."\n"..currentline
                        end
                        currentline = fileList:read()
                  end
                  FileList:close()
            end
            su("User's commands:\n"..list, opname)
            return 0
--Operator typed the command wrong to view the log, then this will appear
      elseif (class >= minclass) and (string.sub(data, 1, 6) == "!oplog") then
            su("Parse Error\n!oplog <lines>\n<lines> = number of lines to read from the log")
            return 0
--Operator typed the command wrong to view the log, then this will appear
      elseif (class >= minclass) and (string.sub(data, 1, 6) == "!userlog") then
            su("Parse Error\n!userlog <lines>\n<lines> = number of lines to read from the log")
            return 0
      end
      Write = io.open(oplogfilename, "w")
      myDate = os.date('*t')  -- time now, thanks TyPhOoN :)
      Write:write("["..myDate.."]Operator "..opname.." used the command: "..data)
      return 1
end

function VH_OnUserCommand(username, data)
      Write = io.open(userlogfilename, "w")
      myDate = os.date('*t')  -- time now, thanks TyPhOoN :)
      Write:write("["..myDate.."]User "..username.." used the command: "..data)
      return 1
end

function su(data, nick)
      VH:SendDataToUser("<"..botname.."> "..data.."|", nick)
end
