--giocatore.lua--
local physics = require("physics")
local giocatore = {}
local timer = require("timer")

--creazione giocatore
function giocatore:new(nome, difficolta)
	setmetatable({}, self)
	self.__index = self
	self.nome = nome
	self.renderplayer = self:renderGiocatore(difficolta)
  self.zaino={clava = 0, martello=0, cavallo=0,atomica=0}
	return self
end


function giocatore:renderGiocatore(difficolta)
	local rendergiocatore = self:creaSprite()
	rendergiocatore.x = display.contentWidth/15
	rendergiocatore.y=display.contentHeight/2
	rendergiocatore.width = rendergiocatore.width*0.3
	rendergiocatore.height = rendergiocatore.height*0.3
	local nw, h
	if (difficolta == "difficile") then
		 nw = rendergiocatore.width/20
		 h = rendergiocatore.height/3
	else 
		 nw = rendergiocatore.width/5
		 h= rendergiocatore.height/3
		end
	rendergiocatore.name = "giocatore"
	physics.addBody(rendergiocatore,"dinamic",{bounce=0, shape={-nw,-h,-nw,h,nw,h,nw,-h}})
	
	return rendergiocatore
end

function giocatore:creaSprite()
	local sheetOptions =
		{
    	width = 200,
    	height = 200.4,
    	numFrames = 20
		}
local sheet_neanderthal = graphics.newImageSheet( "manpro2.png", sheetOptions )
local sequences_neanderthal = {
    {
        name = "normalRun",
        start = 5,
        count = 8,
        time = 1000,
        loopCount = 0,
        loopDirection = "forward"
    },{
        name = "wait",
        start = 1,
        count = 4,
        time = 1000,
        loopCount = 0,
        loopDirection = "forward"
    },{
        name = "fall",
        start = 13,
        count = 7,
        time = 900,
        loopCount = 0,
        loopDirection = "forward"
    }
}
local neanderthal = display.newSprite( sheet_neanderthal, sequences_neanderthal )
neanderthal.x = self.x
neanderthal.y = self.y
neanderthal:setSequence("wait")
neanderthal:play()
neanderthal:scale(0.3,0.3)
return neanderthal
end

--movimenti giocatore
function giocatore:stop()
	local render = self.renderplayer
	render:setSequence( "wait" )
	render:play()
	render:setLinearVelocity(0,0)
end

function giocatore:destroy()
physics.removeBody(self.renderplayer) self.renderplayer = nil
end

function giocatore:move()
	local render = self.renderplayer
	render:setSequence("normalRun")
	render:play()
	render:setLinearVelocity(100,0)
	--render:applyForce(1,0,render.x,render.y)
end

function giocatore:fall()
	self:stop()
	local render = self.renderplayer
	render.bodyType = "kinematic"
	render:setSequence( "fall" )
	render:play()
	render:toFront()
	timer.performWithDelay(50,function() render:setLinearVelocity(0,30) end )
end

function giocatore:addItem(era)
    if era == 1 then
      self.zaino.clava=self.zaino.clava+1
    end
  end
--creazione sprite


return giocatore