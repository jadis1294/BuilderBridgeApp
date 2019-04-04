local physics = require("physics")
local player = {}

function player:new(nome)
	setmetatable({}, self)
	self.__index = self
	self.nome = nome
	return self
end

function player:renderPlayer(Xancora,Yancora,altezzaInizio)
	renderPlayer = display.newImage("fermo.png")
	renderPlayer.x = Xancora-7
	renderPlayer.y = Yancora - altezzaInizio/2
	renderPlayer.name = "player"
	physics.addBody(renderPlayer,"dinamic")
	self.render = renderPlayer
	return self.render
end

function player:stop()
	local render = self.render
	render:setLinearVelocity(0,0)

function player:move()
	local render = self.render
	render:setLinearVelocity(100,0)
end

return player
end