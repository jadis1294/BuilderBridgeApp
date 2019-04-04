local physics = require("physics")
local wGenerator = {}


function wGenerator:creaItem(x,y)
  local item
  if(self.era==1)then
  item = display.newImage("item_clava.png")
  item.era=1
  item:scale(0.065,0.065)
  end
  item.x=x
  item.y=y-20 
  return item
  end

function wGenerator:getPlatform(delta)
  	local fine = display.newImageRect("collina2.jpg",display.contentWidth/math.random(6,10), display.contentHeight/20)
	fine.x=display.contentWidth*math.random(5,8)/10 + delta
	fine.y=display.contentHeight
	fine.name = "inizio" 
  local showitem= math.random(0,2)
  if (showitem==0)then
  	local item=wGenerator:creaItem(fine.x,fine.y)
    fine.item= item
  end
	return fine
end

local function creaFine()
	local fine = display.newImageRect("collina2.jpg",display.contentWidth/math.random(6,10), display.contentHeight/20)
	fine.x=display.contentWidth*math.random(5,8)/10
	fine.y=display.contentHeight
	fine.name = "fine"
	local  nwsx,nwdx = fine.width*1/3, fine.width/2
	local hsu, hgiu = fine.height/2, fine.height*4/10
	physics.addBody(fine,"static", {bounce=0, friction = 12, shape={-nwsx,-hgiu,-nwsx,-hsu,nwdx,-hsu,nwdx,-hgiu}})
	return fine
end

local function creaMuro()
	wall = display.newRect(display.contentWidth,display.contentHeight/2, display.contentWidth/100, display.contentHeight)
	physics.addBody(wall, "static")
	wall.isVisible = false
	return wall
end

local function creaPavimento()
	floor = display.newRect(display.contentWidth/2,display.contentHeight + display.contentHeight/50,display.contentWidth,display.contentHeight/20)
	physics.addBody(floor,"static",{bounce = 0})
	floor.isVisible = false
	return floor
end

local function creaInizio()
	local inizio = display.newImageRect("collina2.jpg",display.contentWidth/5,display.contentHeight/20)
	inizio.x=display.contentWidth/10
	inizio.y=display.contentHeight
	inizio.name = "inizio"
	physics.addBody(inizio,"static",{friction=12})
	return inizio
end

function wGenerator:creaPiattaforma(tipo)
	if(tipo == "inizio") then
		return creaInizio()
	elseif(tipo == "fine") then
		return creaFine()
	elseif(tipo == "muro") then
		return creaMuro()
	elseif(tipo == "pavimento") then
		return creaPavimento()
	end
end

function wGenerator:new(era)
	setmetatable({}, self)
	self.__index = self
  self.era=era
	return self
end

return wGenerator