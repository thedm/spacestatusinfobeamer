gl.setup(1920, 1080)
local json = require "json"
local font = resource.load_font("silkscreen.ttf")
local w = 1920
local h = 1080
local rollText = "Kein Text"
local rollSize = 100
local rollTextWidth = font:width(rollText, rollSize)
local rollY = h-rollSize
local rollMomX = w
local rollSpeed = 4
local messageSize = 150
util.auto_loader(_G)
util.json_watch("spaceinfo.json", function(status) 
	print("reloading json")
	print("Used APIversion: " .. status.api)
	print("Hackspace: " .. status.space)
	print("Internetstatus: " .. status.sensors.network_connections[2].value)
	print(status.sensors.power_consumption[1].value)
	print(status.sensors.power_consumption[1].unit)
	print("Netzgeraete: " .. status.sensors.network_connections[1].value)
internetStatus=status.sensors.network_connections[2].value
power=status.sensors.power_consumption[1].value
powerUnit=status.sensors.power_consumption[1].unit
local networkUnits
if networkUnits ~= status.sensors.network_connections[1].value then
	networkUnits = status.sensors.network_connections[1].value
end
local numberOfPersonsInSpace

if numberOfPersonsInSpace ~= status.sensors.people_now_present[1].value then
	numberOfPersonsInSpace = status.sensors.people_now_present[1].value
end
local newPersonsInSpace
local personsInSpace
local i
local line
if status.sensors.people_now_present[1].names ~= nil then
	for i,line in ipairs(status.sensors.people_now_present[1].names) do
		if i == 1 then
			newPersonsInSpace = line
		else
			newPersonsInSpace=newPersonsInSpace .. ", " .. line
		end
		print(line)
	end
end

if powerUnit == "W" then
	powerUnit="Watt"
end
if newPersonsInSpace ~= personsInSpace then
	personsInSpace = newPersonsInSpace
end
if numberOfPersonsInSpace == nil then
	numberOfPersonsInSpace = 0
end
if networkUnits == nil then
	networkUnits = 0
end
rollText = "momentane Leistungsaufnahme: " .. power .. " " .. powerUnit .. "; " .. networkUnits .. " aktive Netzwerkgeraete; " .. numberOfPersonsInSpace .. " Personen anwesend: "-- .. personsInSpace
rollText = "+++" .. rollText .. "+++"
rollTextWidth = font:width(rollText, rollSize)
rollY = h-rollSize
status = true

textwidth = font:width("open", messageSize)
statusY = h/4-messageSize/2
statusX = w/2-textwidth/2
internetSize = 100
-- internetStatus = status.sensors.network_connections[2].value
internetText = "INTERNET!!!"
internetTextWidth = font:width(internetText, internetSize)
internetY = 2*h/4-internetSize/2
internetX = w/2-internetTextWidth/2
print(status)
end)
function node.render()
if status == false then
	font:write(statusX, statusY, "closed", MessageSize, 1,0,0,1)
end
if status == true then
font:write(statusX, statusY, "open", MessageSize, 0,1,0,1)
end
if internetStatus == 1 then
	internetText="INTERNET!!!"
	font:write(internetX, 500, internetText, 100, 0,1,0,1)

else
	internetText="KEIN INTERNET!!!"
	font:write(internetX, 500, internetText, 100, 1,0,0,1)
end
font:write(rollMomX, rollY, rollText, rollSize, 1,1,1,1)
if rollMomX > -rollTextWidth then
	rollMomX = rollMomX-rollSpeed*1
else
	rollMomX=w
end
--font:write(400,400,test,1,1,1,1)
end
