--This is a script which displays all users online in a class you control.
--It has been tested and should work 100 % fully
--Let me know about bugs and stuff on this e-mail: jojjn@simnet.is
--
--TODO:
--No todo :-)

----------[ Global variables ]----------

--This is the botname variable, it contains then name of the bot
--which displays the list. Change this according to your hub
botname = "UserList"

----------[ Functions ]----------

--VH_OnOperatorCommand
function VH_OnOperatorCommand(nick, data)
      class = string.find(data, "(%d+)")
      if (string.find(data,"!reglist%s(%d+)")) and ((0 < class)  )  then
            su("Begin Searching for users in that class", nick)
            times = 0
            List = "no users!"
            for checkUser in ListSearch() do
                  result, checkUserClass = VH:GetUserClass(checkUser)
                  if checkUserClass == class then
                        if times > 0 then
                              list = list.."\n"..User
                              times = times + 1
                        else
                              list = User
                              times = 1
                        end
                  end
            end
            su ("User's in "..class.." class:\n"..list.."/nTotal: "..times.." Users".."|", nick)
            return 0
      else if string.sub(data, 1, 8) == "!reglist" then
            su ("Params error..\n!reglist <class>", nick)
            return 0
      end
      return 1
end
end

--Function to send pm to the Operator
function su(data, nick)
      VH:SendDataToUser("<"..botname.."> "..data.."|", nick)
end

function ListSearch ()
      result, data = VH:GetNickList()
      local line = data
      local pos = 1           -- current position in the list
      return function ()      -- iterator function
            while line do         -- repeat while there is something in the list
                  local s, e = string.find(line, "%w+".."$$", pos)
                  if s then           -- found a user?
                        pos = e + 1       -- next position is after this user
                        return string.sub(line, s, e - 2)     -- return the user
                  end
            end
      return nil            -- no more user's: end of traversal
      end
end
