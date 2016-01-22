_=[[
	################################################################################
######
	Filename: vh_chatstats_v2.lua
	Released: July 20, 2005 
	Distributed by: http://ro.4242.hu/
	Copyright (c) 2005, Ro	(lamehub.lame.hu:8998)   (elite.4242.hu:4242)
	################################################################################
######
	Lua 5: The Programming Language
	Open-Source Program for HubOwners
	================================================================================
======
	Software by: Lua is a powerful light-weight programming language designed for extending applications.
	Lua is also frequently used as a general-purpose, stand-alone language. Lua is free software.
	################################################################################
######
]]

-- // --  S E T   U P   S T A R T -- // --

BotNick = "ChatStats"
File_Database = ".verlihub/scripts/vh_chatstats_database.roo"	--// Location of the tdatabase file

CommandPrefix = "?"
CommandTop = "top" 		--// commands: ?top post ; ?top smiley ; ?top char ; ?top time
CommandMyStat = "mystats"
CommandShowStats = "showstats" --// ?showstats [HUN]TesztUser

-- // --  S E T   U P   E N D -- // --

_=[[
		Do not edit below this line!!
												]]
SmileyList_Table = {":%)",":%-%)",":%]",":%-%]",":D",":%-D",":%(",":-%(","lol","Lol","LoL","LOL"}
Timer = math.random(500, 700)
Time = Timer


function VH_OnParsedMsgChat(nick,data)
	data = data .. " "
	brake = false
	_, _, firstWord = string.find(data, "(%S+)")

	--// Post statistic
	if (not (PostedMSG_Table[nick])) then
		PostedMSG_Table[nick] = 1
	else 
		PostedMSG_Table[nick] = PostedMSG_Table[nick] + 1
	end
	
	--// Smiley statistic
	for k in SmileyList_Table do
		if string.find(data,SmileyList_Table[k]) then
			if (not (PostedSmiley_Table[nick])) then
				PostedSmiley_Table[nick] = 1
			else 
				PostedSmiley_Table[nick] = PostedSmiley_Table[nick] + 1
			end
		else
			if (not (PostedSmiley_Table[nick])) then
				PostedSmiley_Table[nick] = 0
			end
		end
	end
	
	-- // Character statistic
	local value = (string.len(data) - 1)
	if (not (PostedChar_Table[nick])) then
		PostedChar_Table[nick] = value
	else 
		PostedChar_Table[nick] = PostedChar_Table[nick] + value
	end

	--// Commands
	
	if firstWord == (CommandPrefix .. CommandMyStat) then
		brake = true
		diffsec = Time_Table[nick]
		TimeDiff(diffsec)
		VH:SendDataToAll("<"..BotNick.."> "..nick.." a statisztikád: "..PostedMSG_Table[nick].." db hozzászólás, "..PostedSmiley_Table[nick].." db szmájli, "..PostedChar_Table[nick].." db karakter, "..temp.."online töltött idõ.|",0 ,10)
	
	elseif firstWord == (CommandPrefix .. CommandTop) then
		brake = true
		local StatType = string.sub(data, (2 + string.len(CommandPrefix .. CommandTop)), (string.len(data)-1))
		if StatType == "smiley" or StatType == "post" or StatType == "char" or StatType == "time" then
			local index = {n=0}
			if StatType == "smiley" then
				table.foreach(PostedSmiley_Table, function(nick, score) table.insert(index, nick) end)
				local func = function(a, b) return PostedSmiley_Table[a] > PostedSmiley_Table[b] end table.sort(index, func)
			elseif StatType == "post" then
				table.foreach(PostedMSG_Table, function(nick, score) table.insert(index, nick) end)
				local func = function(a, b) return PostedMSG_Table[a] > PostedMSG_Table[b] end table.sort(index, func)
			elseif StatType == "char" then 
				table.foreach(PostedChar_Table, function(nick, score) table.insert(index, nick) end)
				local func = function(a, b) return PostedChar_Table[a] > PostedChar_Table[b] end table.sort(index, func)
			elseif StatType == "time" then
				table.foreach(Time_Table, function(nick, score) table.insert(index, nick) end)
				local func = function(a, b) return Time_Table[a] > Time_Table[b] end table.sort(index, func)
			end

			x = x or 10
			if x > index.n then x = index.n end
local result = "A top "..x.." "..StatType..":\r\nPos:\tPost:\t\tChar:\t\tSmiley:\t\tTime:\t\t\tNick:"
			for i = 1, x do
				diffsec = Time_Table[index[i]]
				TimeDiff(diffsec)

				local space1 = "\t\t"
				local space2 = "\t\t"
				local space3 = "\t\t"
				local space4 = "\t\t"
				if string.len(PostedMSG_Table[index[i]]) > 8 then space1 = "\t" end
				if string.len(PostedChar_Table[index[i]]) > 8 then space2 = "\t" end
				if string.len(PostedSmiley_Table[index[i]]) > 8 then space3 = "\t" end
				if string.len(temp) >= 20 then space4 = "\t" elseif string.len(temp) <= 8 then space4 = "\t\t\t" end
				result = result.."\r\n"..i.."\t"..PostedMSG_Table[index[i]]..""..space1..""..PostedChar_Table[index[i]]..""..space2..""..PostedSmiley_Table[index[i]]..""..space3..""..temp..""..space4..""..index[i]
			end
		VH:SendDataToAll("<"..BotNick.."> "..nick.." lekérte statisztikát. (Top "..x.." "..StatType..")|",1, 10)
			VH:SendDataToUser("<"..BotNick.."> "..result.."|",nick)
		else
			VH:SendDataToUser("<"..BotNick.."> Unknown type! Use: "..CommandPrefix .. CommandTop.." smiley or "..CommandPrefix .. CommandTop.." post or "..CommandPrefix .. CommandTop.." char or "..CommandPrefix .. CommandTop.." time|",nick)
		end

	elseif firstWord == (CommandPrefix .. CommandShowStats) then
		brake = true
		local User = string.sub(data, (2 + string.len(CommandPrefix .. CommandShowStats)), (string.len(data)-1))
		if PostedMSG_Table[User] ~= nil then
			diffsec = Time_Table[User]
			TimeDiff(diffsec)
			VH:SendDataToAll("<"..BotNick.."> "..nick..": "..User.." a statisztikája: "..PostedMSG_Table[User].." db hozzászólás, "..PostedSmiley_Table[User].." db szmájli, "..PostedChar_Table[User].." db karakter, "..temp.."online töltött idõ.|",0 ,10)
		else
			VH:SendDataToUser("<"..BotNick.."> "..User.." nevû felhasználó nincs az adatbázisban|",nick)
		end
	end
	
if brake == false then return 1 else return 0 end
end

function Save()
	local file = io.open(File_Database, "w")
	if (file) then
		for index, value in PostedMSG_Table do
			if Time_Table[index] == nil then
				file:write(index .. "<Post>" .. value .. "<Post><Smiley>" .. PostedSmiley_Table[index] .. "<Smiley><Char>" .. PostedChar_Table[index] .. "<Char><Time>0<Time>\r\n")
			else
				file:write(index .. "<Post>" .. value .. "<Post><Smiley>" .. PostedSmiley_Table[index] .. "<Smiley><Char>" .. PostedChar_Table[index] .. "<Char><Time>" .. Time_Table[index] .. "<Time>\r\n")
			end
		end
	end
		file:close()
	 Load()
end

function VH_OnTimer()
	if Timer > 0 then Timer = Timer - 1 return end
	if Timer == 0 then
		--// Save all data to HDD
		Save()

		--// online time statistic 
		for index, value in PostedMSG_Table do
			myinfo = ""
			res, myinfo = VH:GetMyINFO(index)
			if string.len(myinfo) > 10 then
				if (not (Time_Table[index])) then
					Time_Table[index] = Time
				else 
					Time_Table[index] =Time_Table[index] + Time
				end
			end
		end
		Timer = math.random(500, 700)
		Time = Timer
	end
return 1
end

function TimeDiff(diffsec)
	temp = "" local okay = 1 if diffsec < 0 then temp = "(Wrong Clock)" okay = 0 end if okay == 1 then local second = " sec" local minute = " min" local hour = " hour" local day = " day" local week = " week" local month = " month" local year = " year" local difftmp = 0 difftmp = math.floor ( diffsec / 60 / 60 / 24 / 360 )
	if difftmp > 0 then if difftmp > 1 then year = year.." " else year = year .. " " end year = difftmp .. year else year = "" end diffsec = diffsec - difftmp * 60 * 60 * 24 * 360 difftmp = math.floor ( diffsec / 60 / 60 / 24 / 30 )
	if difftmp > 0 then if difftmp > 1 then month = month .. " " else month = month .. " " end month = difftmp .. month else month = "" end diffsec = diffsec - difftmp * 30 * 24 * 60 * 60 difftmp = math.floor ( diffsec / 60 / 60 / 24 / 7 )
	if difftmp > 0 then if difftmp > 1 then week = week .. " " else week = week .. " " end week = difftmp .. week else week = "" end diffsec = diffsec - difftmp * 7 * 24 * 60 * 60 difftmp = math.floor ( diffsec / 60 / 60 / 24 )
	if difftmp > 0 then if difftmp > 1 then day = day .. " " else day = day .. " " end day = difftmp .. day else day = "" end diffsec = diffsec - difftmp * 24 * 60 * 60 difftmp = math.floor ( diffsec / 60 / 60 )
	if difftmp > 0 then if difftmp > 1 then hour = hour .. " " else hour = hour .. " " end hour = difftmp .. hour else hour = "" end diffsec = diffsec - difftmp * 60 * 60 difftmp = math.floor ( diffsec / 60 )
	if difftmp > 0 then if difftmp > 1 then minute = minute .. " " else minute = minute .. " " end minute = difftmp .. minute else minute = "" end diffsec = diffsec - difftmp * 60 difftmp = diffsec
	if difftmp > 0 then if difftmp > 1 then second = second .. " " else second = second .. " " end second = difftmp .. second else second = "" end
	temp = year .. month .. week .. day .. hour .. minute .. second end return temp
end

function Load()
	PostedMSG_Table = {}
	PostedSmiley_Table = {}
	PostedChar_Table = {}
	Time_Table = {}
	
	local file = io.open(File_Database, "r")
	if (file) then
		local line = file:read()
		while line do
				s,e,sNick,sPosts = string.find(line, "(.+)%<Post%>(.+)%<Post%>")
				PostedMSG_Table[sNick] = tonumber(sPosts)
				s,e,sSmiley,sChars = string.find(line, "%<Smiley%>(.+)%<Smiley%>%<Char%>(.+)%<Char%>")
				PostedSmiley_Table[sNick] = tonumber(sSmiley)
				PostedChar_Table[sNick] = tonumber(sChars)
				if string.find(line,"%<Time%>") then
					s,e,sTime = string.find(line, "%<Time%>(.+)%<Time%>")
					Time_Table[sNick] = tonumber(sTime)
				end
			line = file:read()
		end
		file:close()
	else
	end
end


--// Script entry point
Load()