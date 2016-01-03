local json = require "json"
width=1024
height=1024
text="Hello World"
size=100
gl.setup(height, width)
font = resource.load_font("silkscreen.ttf")
util.auto_loader(_G)
util.file_watch("spaceinfo.json", function(content)
	print("reloading json") 
	spaceinfo=json.decode(content)
	print("Used APIversion: " ..  spaceinfo.api)
	print("Hackspace: "..spaceinfo.space)
	text=spaceinfo.state.message
end)
function node.render()
	textwidth= font:width(text,size)
	font:write(width/2-textwidth/2, height/2-size/2, text, size, 1,1,1,1)
end
