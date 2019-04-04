local timer = require("timer")
local math = require("math")
local bgCarousel = {}
local imgs = {terra = {
	"grafichette/rock tower.png",
	"grafichette/rockina.png",
	"grafichette/rock1.png",
	"grafichette/palme.png",
	"grafichette/palmina.png",
	"grafichette/felcedx.png",
},
	cielo = {
	"grafichette/nuvola1.png",
	"grafichette/nuvola2.png",
	"grafichette/nuvole3.png",
	"grafichette/nuvole4.png",
	"grafichette/nuvole5.png",
	"grafichette/nuvole7.png",
}
}

function bgCarousel:new(scene)
setmetatable({}, self)
	self.__index = self
	self.flip = false
    self.background = display.newGroup()
  self.nuvole = display.newGroup()
  self.nuvoleItems = display.newGroup()
  self.vulcani = display.newGroup()
  self.terrain = display.newGroup()
  self.terrainItems = display.newGroup()

self.gioco = display.newGroup()
self.livelli = { self.nuvole, self.nuvoleItems,self.vulcani, self.terrain, self.terrainItems}
self:setupBackground()
self:setupNuvole()
self:setupVulcani()
self:setupTerrain()
self:setupGioco(scene)
	return self
end

function bgCarousel:setupBackground()
local bg = display.newImage("cielo.png", display.contentWidth/2, display.contentHeight/2)
  self.background:insert(bg)
end

function bgCarousel:showBgObjectsRuntime()
local cielo = self.nuvoleItems
local terra = self.terrainItems
local vulcani = self.vulcani
self:popola("cielo",cielo)
self:popola("terra",terra)
self:popola("vulcani",vulcani)
end

function bgCarousel:spawnVulcani(spawnPlace)
	local img
	local h = display.contentHeight /2
if(spawnPlace.numChildren == 0) then
	if(math.random(0,1) == 0) then
		img = "grafichette/vulcano1.png"
	else
		img = "grafichette/vulcano2.png"
		h = h+50
	end
	if(math.random(0,6) == 0) then
	display.newImage(spawnPlace, img, display.contentWidth*(10+math.random(1,9))/10, h)
end
end
end

function bgCarousel:popola(k, spawnPlace)
local h
if(k == "cielo") then
	h = math.random(10,30) / 10
end
if(k == "terra") then
	h = math.random(75,80) / 10
else
	self:spawnVulcani(spawnPlace)
	return
end
local images = imgs[k]
if(spawnPlace.numChildren < 3) then
	local r = math.random(1,#images)
	local img = images[r]
	display.newImage(spawnPlace, img, display.actualContentWidth*(10+math.random(1,9))/10, display.contentHeight*h/10)
end
end

function bgCarousel:setupNuvole()
local strisciaGialla = display.newImage("grafichette/giallo.png")
  strisciaGialla.x = display.contentWidth/2
  strisciaGialla.y = display.contentHeight*6/10
  self.nuvole:insert(strisciaGialla)
local strisciaGialla2 = display.newImage("grafichette/giallo.png")
strisciaGialla2.x = display.actualContentWidth*3/2 - 30
strisciaGialla2.y = strisciaGialla.y
strisciaGialla2.xScale = -1
self.nuvole.flip = false
self.nuvole:insert(strisciaGialla2)
	end

function bgCarousel:setupVulcani()		
		local vulcano1 = display.newImage("vulcano1.png")
	vulcano1.x = display.contentWidth*14/20
	vulcano1.y = display.contentHeight/2
	local vulcano2 = display.newImage("vulcano2.png")
	vulcano2.x = display.contentWidth*7/20
	vulcano2.y = vulcano1.y +50
	self.vulcani:insert(vulcano1)
	self.vulcani:insert(vulcano2)
end

function bgCarousel:setupTerrain()
local prato1 = display.newImage("grafichette/belprato2.png")
prato1.y = display.contentHeight*8.5/10
prato1.width = display.actualContentWidth
prato1.x = display.contentWidth/2
local prato2 = display.newImage("grafichette/belprato2.png")
prato2.width = display.actualContentWidth
prato2.x = display.actualContentWidth*3/2 -45
prato2.y = display.contentHeight*8.5/10
prato2.xScale = -1
self.terrain.flip = false
self.terrain:insert(prato1)
self.terrain:insert(prato2)
end

function bgCarousel:setupGioco(scene)
	self.gioco:insert(scene.inizio)
	self.gioco:insert(scene.fine)
	self.gioco:insert(scene.ponte.render.collo)
	self.gioco:insert(scene.ponte.render.testa)
	self.gioco:insert(scene.ponte.render.testaponte)
	self.gioco:insert(scene.giocatore.renderplayer)
	self.gioco:insert(scene.ponte.dino)
	
end

function bgCarousel:manageCarousel()
local groups = {self.nuvole,self.terrain}
for i=1, #groups, 1 do
local group = groups[i]
local carousel = group[group.numChildren]
if(carousel ~= nil and carousel.x+carousel.width/2 < 300+display.actualContentWidth) then
	local img
	local y 
	if(i == 1) then
		img = display.newImage("grafichette/giallo.png")
		y = display.contentHeight*6/10
	else
		img = display.newImage("grafichette/belprato2.png")
		y = display.contentHeight* 8.5/10
	end
img.x = carousel.x + carousel.width/2 + img.width/2
img.y = y
group:insert(img)
if(group.flip == true) then
	img.xScale = -1
	group.flip = false
else
	group.flip = true
end
if(carousel.width ~= nil or img.width ~=nil) then
timer.performWithDelay(100, function() transition.to(img,{time = 500, x = carousel.x+carousel.width/2+img.width/2}) end)
	end
	end
end
end

function bgCarousel:clean(group)

	for i=1, group.numChildren, 1 do
		local item = group[i]
		if(item ~= nil) then
			if(item.x + item.width/2 < -200) then
			timer.performWithDelay(1000,function() group:remove(item) end)
			end
		end
	end
end

--elimina oggetti in fuori dallo schermo
function bgCarousel:cleanObjectsOutScene()
	for i=1, #self.livelli, 1 do
		self:clean(self.livelli[i])	
	end
end

function bgCarousel:move(group, delta)
	for i=1, group.numChildren, 1 do
		local dynBgObj = group[i]
		transition.to( dynBgObj, {time =1500, delay=500, x = dynBgObj.x - delta})
	end
end

function bgCarousel:moveBgObjects(delta)
	local i
	for i=1, #self.livelli, 1 do
		self:move(self.livelli[i], delta)

	end
end


function bgCarousel:destroy()
  timer.performWithDelay(100,function() display.remove(self.background) self.background = nil end)
  timer.performWithDelay(200,function() display.remove(self.nuvole) self.nuvole = nil end)
  timer.performWithDelay(300,function() display.remove(self.vulcani) self.vulcani = nil end)
  timer.performWithDelay(400,function() display.remove(self.terrain) self.terrain = nil end)
  timer.performWithDelay(500,function() display.remove(self.terrainItems) self.terrainItems = nil end)
  timer.performWithDelay(600,function() display.remove(self.gioco) self.gioco = nil end)

end

return bgCarousel

