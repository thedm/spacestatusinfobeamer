gl.setup(1920,1080)

local json = require "json"
function node.render()
local text="Hello World"
local MessageSize=150


local font = resource.load_font("silkscreen.ttf")
local rollText="Kein Text"
local rollSie=100
local rollTextWidth=font:width(rollText, rollSize)
local rollY=1080-rollSize
local rollMomX=1920
local rollSpeed=4

local personsInSpace="none"
--function node.render()
util.auto_loader(_G)
util.file_watch("spaceinfo.json", function(content)
	print("reloading json") 
local spaceinfo=json.decode(content)
	print("Used APIversion: " ..  spaceinfo.api)
	print("Hackspace: "..spaceinfo.space)
	print("Internetstatus : "..spaceinfo.sensors.network_connections[2].value)
	print(spaceinfo.sensors.power_consumption[1].value)
	print(spaceinfo.sensors.power_consumption[1].unit)
	print("Netzwerkgeraete: ".. spaceinfo.sensors.network_connections[1].value)

local internetstatus=spaceinfo.sensors.network_connections[2].value
local power=spaceinfo.sensors.power_consumption[1].value
local powerUnit=spaceinfo.sensors.power_consumption[1].unit
local networkUnits=nil
local numberOfPersonsInSpace=nil
local newPersonsInSpace=nil
local personsInSpace=nil
if powerUnit == "W" then
	powerUnit="Watt"
	end
	if networkUnits ~= spaceinfo.sensors.network_connections[1].value then
	networkUnits=spaceinfo.sensors.network_connections[1].value
	end
	if numberOfPersonsInSpace ~= spaceinfo.sensors.people_now_present[1].value then
	numberOfPersonsInSpace=spaceinfo.sensors.people_now_present[1].value
	end
	if spaceinfo.sensors.people_now_present[1].names ~= nil then
	for i,line in ipairs(spaceinfo.sensors.people_now_present[1].names) do
		if i == 1 then
		newPersonsInSpace=line;
		else
		newPersonsInSpace=newPersonsInSpace .. ", " .. line
		end
		print(line)
    	end
	end
	if newPersonsInSpace ~= personsInSpace then
		personsInSpace = newPersonsInSpace
	end
	rollText= "momentane Leistungsaufnahme: " .. power .. " " .. powerUnit .. "; " .. networkUnits .. " aktive Netzwerkgeraete; ".. numberOfPersonsInSpace .. " Personen anwesend, namentlich: " .. personsInSpace
	rollText= "+++" .. rollText .. "+++"
	rollTextWidth=font:width(rollText, rollSize)
	rollY=1080-rollSize
	
end)
--end

--function node.render()
	local statusText=spaceinfo.state.message
	local textwidth=font:width(statusText,MessageSize)
	local statusY=1080/4-MessageSize/2
local 	statusX=1920/2-textwidth/2
	if spaceinfo.state.open == false
	then
	font:write(statusX, statusY, statusText, MessageSize, 1,0,0,1)
	end
	if spaceinfo.state.open == true
	then
	font:write(statusX, statusY, statusText, MessageSize, 0,1,0,1)
	end
	
local	internetSize=100
local	internetStatus=spaceinfo.sensors.network_connections[2].value
local	internetText="INTERNET!!!!!"

	if internetStatus == 1 then
	--internetText="INTERNET!!!!!"
local	internetTextWidth=font:width(internetText,internetSize) 
local	internetY=2*1080/4-internetSize/2
local	internetX=1920/2-internetTextWidth/2
	font:write(internetX, internetY, internetText, internetSize, 0,1,0,1)
	else
	internetText="KEIN INTERNET!!!!!"
local	internetTextWidth=font:width(internetText,internetSize) 
	internetY=2*1080/4-internetSize/2
	internetX=1920/2-internetTextWidth/2
	font:write(internetX, internetY, internetText, internetSize, 1,0,0,1)
	end
	
	font:write(rollMomX, rollY, rollText, rollSize, 1,1,1,1)
	if rollMomX > -rollTextWidth then
	rollMomX = rollMomX-rollSpeed*1
	else
	rollMomX=1920
	end

	--[[
	powerText="Power consumption"
	powerTextSize=50
	powerTextWidth=pixelFont:width(powerText, powerTextSize)
	powerTextX=width/2-powerTextWidth/2
	powerTextY=4*height/5-powerTextSize
	pixelFont:write(powerTextX,powerTextY, powerText, powerTextSize, 1,1,1,1)
	
	
	power=spaceinfo.sensors.power_consumption[1].value .. " " .. spaceinfo.sensors.power_consumption[1].unit
	print(power)
	powerSize=100
	powerWidth=pixelFont:width(power, powerSize)
	powerX=width/2-powerWidth/2
	powerY=height-powerSize*1.5
	pixelFont:write(powerX, powerY, power, powerSize, 1,1,1,1)]]

	end
