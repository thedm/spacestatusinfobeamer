local json = require "json"
width=1280
height=1024
text="Hello World"
MessageSize=150
gl.setup(width,height)
pixelFont = resource.load_font("silkscreen.ttf")
rollText="Kein Text"
rollSize=100
rollTextWidth=pixelFont:width(rollText, rollSize)
rollY=height-rollSize
rollMomX=width
rollSpeed=4

personsInSpace="none"

util.auto_loader(_G)
util.file_watch("spaceinfo.json", function(content)
	print("reloading json") 
	spaceinfo=json.decode(content)
	print("Used APIversion: " ..  spaceinfo.api)
	print("Hackspace: "..spaceinfo.space)
	print("Internetstatus : "..spaceinfo.sensors.network_connections[2].value)
	print(spaceinfo.sensors.power_consumption[1].value)
	print(spaceinfo.sensors.power_consumption[1].unit)
	print("Netzwerkgeraete: ".. spaceinfo.sensors.network_connections[1].value)

	internetstatus=spaceinfo.sensors.network_connections[2].value
	power=spaceinfo.sensors.power_consumption[1].value
	powerUnit=spaceinfo.sensors.power_consumption[1].unit
		if powerUnit == "W" then
			powerUnit="Watt"
		end
	networkUnits=spaceinfo.sensors.network_connections[1].value
	numberOfPersonsInSpace=spaceinfo.sensors.people_now_present[1].value
	if spaceinfo.sensors.people_now_present[1].names ~= nil then
	for i,line in ipairs(spaceinfo.sensors.people_now_present[1].names) do
		if i == 1 then
		personsInSpace=line;
		else
		personsInSpace=personsInSpace .. ", " .. line
		end
		print(line)
    	end
	end
	
	rollText= "momentane Leistungsaufnahme: " .. power .. " " .. powerUnit .. "; " .. networkUnits .. " aktive Netzwerkgeraete; ".. numberOfPersonsInSpace .. " Personen anwesend, namentlich: " .. personsInSpace
	rollText= "+++" .. rollText .. "+++"
	rollTextWidth=pixelFont:width(rollText, rollSize)
	rollY=height-rollSize
	
end)



function node.render()
	statusText=spaceinfo.state.message
	textwidth= pixelFont:width(statusText,MessageSize)
	statusY=height/4-MessageSize/2
	statusX=width/2-textwidth/2
	if spaceinfo.state.open == false
	then
	pixelFont:write(statusX, statusY, statusText, MessageSize, 1,0,0,1)
	end
	if spaceinfo.state.open == true
	then
	pixelFont:write(statusX, statusY, statusText, MessageSize, 0,1,0,1)
	end
	
	internetSize=100
	internetStatus=spaceinfo.sensors.network_connections[2].value
	internetText="INTERNET!!!!!"

	if internetStatus == 1 then
	--internetText="INTERNET!!!!!"
	internetTextWidth=pixelFont:width(internetText,internetSize) 
	internetY=2*height/4-internetSize/2
	internetX=width/2-internetTextWidth/2
	pixelFont:write(internetX, internetY, internetText, internetSize, 0,1,0,1)
	else
	internetText="KEIN INTERNET!!!!!"
	internetTextWidth=pixelFont:width(internetText,internetSize) 
	internetY=2*height/4-internetSize/2
	internetX=width/2-internetTextWidth/2
	pixelFont:write(internetX, internetY, internetText, internetSize, 1,0,0,1)
	end
	
	pixelFont:write(rollMomX, rollY, rollText, rollSize, 1,1,1,1)
	if rollMomX > -rollTextWidth then
	rollMomX = rollMomX-rollSpeed*1
	else
	rollMomX=width
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
