--|-------------------------------------------------------|--
--| configuration_notifier.lua              2005. 09. 27. |--
--|                                                       |--
--| author: weekender                                     |--
--| HUB:    TIËSTO HUB @ tiesto-hub.hu:1969               |--
--| e-mail: weekender@tiesto-hub.hu                       |--
--|                                                       |--
--| (c) 2005 All rights reserved, GNU GPL license         |--
--|-------------------------------------------------------|--
--| Sends a notification to the OP-chat for a specified   |--
--| class range when an OP makes any changes in the       |--
--| configuration settings.                               |--
--| It can be used by Masters to be notified about the    |--
--| changes on the HUB.                                   |--
--|-------------------------------------------------------|--



function Main()
	  OpChat = GetOpChat()
	return 1
end


function VH_OnOperatorCommand(opname, data)
local config, new_value

--//!set parancs esetén
command = "!set"

	if (string.find(data, "!set%s(%S+)%s(%S+)")) or (string.find(data, "!set%s(%S+)%s")) then
		--//!set <config> <new_value>
		if (string.find(data, "!set%s(%S+)%s(%S+)")) then
		_, _, config = string.find(data, "!set%s(%S+)%s(%S+)")
		new_value = string.sub(data, (string.len(command) +1 +(string.len(config)) +1), string.len(data))
		--//a sor végén megadott osztály látja csak az üzenetet OP-chatben (ezesetben 10-tol 10-ig, vagyis csak Master-ek)
		VH:SendPMToAll("Configuration has just been modified:     "..opname.." changed the value ''"..config.."'' to the following:    "..new_value.."" , OpChat, 10, 10)
		--//!set <config> nil
		elseif (string.find(data, "!set%s(%S+)%s")) then
		_, _, config, new_value = string.find(data, "!set%s(%S+)%s")
		--//a sor végén megadott osztály látja csak az üzenetet OP-chatben (ezesetben 10-tol 10-ig, vagyis csak Master-ek)
		VH:SendPMToAll("Configuration has just been modified:     "..opname.." changed the value ''"..config.."'' to nil value" , OpChat, 10, 10)
		end
	end

--//!= parancs esetén
command = "!="

	if (string.find(data, "!=%s(%S+)%s(%S+)")) or (string.find(data, "!=%s(%S+)%s")) then
		--//!= <config> <new_value>
		if (string.find(data, "!=%s(%S+)%s(%S+)")) then
		_, _, config = string.find(data, "!=%s(%S+)%s(%S+)")
		new_value = string.sub(data, (string.len(command) +1 +(string.len(config)) +1), string.len(data))
		--//a sor végén megadott osztály látja csak az üzenetet OP-chatben (ezesetben 10-tol 10-ig, vagyis csak Master-ek)
		VH:SendPMToAll("Configuration has just been modified:     "..opname.." changed the value ''"..config.."'' to the following:    "..new_value.."" , OpChat, 10, 10)
		--//!= <config> nil
		elseif (string.find(data, "!=%s(%S+)%s")) then
		_, _, config, new_value = string.find(data, "!=%s(%S+)%s")
		--//a sor végén megadott osztály látja csak az üzenetet OP-chatben (ezesetben 10-tol 10-ig, vagyis csak Master-ek)
		VH:SendPMToAll("Configuration has just been modified:     "..opname.." changed the value ''"..config.."'' to nil value" , OpChat, 10, 10)
		end
	end

return 1
end


function GetOpChat()
res, val = VH:GetConfig("config", "opchat_name")
	  if res then
	  return val
	  end
return "Unknown"
end 
